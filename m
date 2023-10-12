Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C097C6D15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378333AbjJLLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347199AbjJLLrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F5C4;
        Thu, 12 Oct 2023 04:46:59 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5C49B6607368;
        Thu, 12 Oct 2023 12:46:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111218;
        bh=+ac6y9CN7AEDcWAriiIST3GyWqbq9cgUUTvdotEB6/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Imzaqt52nbCypSbgVlMK7HiA7wfMRQz5QJ5l/b7I4hElPPTJ5r4DfxO/zMU55hCGp
         Gf688FMecpuRjSxxtB3D1pTSjQ0LAuyhUdF7U4gKNMoR/PYNq5p/M+2nU/LTcOBJyO
         fXs42nuD3dS3uTYKTkA02PWgRXCBOzci73PkRwhHHg6D9oQLXp7lI1nQgBB41NO9e4
         buGTpx/3FcnbQ4qwHk3pakP73BEFc2UMjEEt4HB1l6k+uhzvR5j5GkVFSpspL2na/H
         cj6Ur4UInc7HjGLiefWCj/jfJfyS6m5DD3l68GyNCcqOswydV4+Joq4uoMkcndvNsT
         bOtRR17f7TYCA==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH v11 17/56] media: atomisp: Stop direct calls to queue num_buffers field
Date:   Thu, 12 Oct 2023 13:46:03 +0200
Message-Id: <20231012114642.19040-18-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffers field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Hans de Goede <hdegoede@redhat.com>
CC: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index a8a964b2f1a8..09c0091b920f 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1028,7 +1028,7 @@ static int atomisp_qbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 	struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
 
-	if (buf->index >= vdev->queue->num_buffers)
+	if (buf->index >= vb2_get_num_buffers(vdev->queue))
 		return -EINVAL;
 
 	if (buf->reserved2 & ATOMISP_BUFFER_HAS_PER_FRAME_SETTING) {
-- 
2.39.2

