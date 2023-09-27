Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26357B08F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjI0Pi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjI0Pgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED81B3;
        Wed, 27 Sep 2023 08:36:29 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 216D06607374;
        Wed, 27 Sep 2023 16:36:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828988;
        bh=g+cKvL+57Ge4BbEO/J6pfXbFnIiiN4vCjyxapf5D6Zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GEZjpG3Mg1O+df6BIyrjZlfYVzJjl0vG5IseZ0ajGJrFj1XsxYL2itb+mcQdbdJjb
         EAnC1dqe9bSt5Y/6S2HwdRpXo6Ceou0sdZVBVNMXX8s+xyLXtyG1zMZRj4n9ywLv1F
         vpFzzXPLEz1mCavsBHcMCkpFf8fXFHXd1u3a74raRo2Dc6nYBUV34Hdep5cqj1acnj
         gCIInYq7h6BlpMNoZ7RZWk7iRMhSsbZ04PiCI2LDUb3lOtMIfH1z/+oCZZPUgc/mKJ
         1J5z2pldHY07c1rhRZ7Y5tAcC/ce+bFhVZCsadw52brVQBxb9B/ywVKmWrh0qnhhY1
         RnevAiUJVYvgg==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v8 42/53] media: atomisp: Stop direct calls to queue num_buffers field
Date:   Wed, 27 Sep 2023 17:35:47 +0200
Message-Id: <20230927153558.159278-43-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 4b65c69fa60d..48f9745421a9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1030,7 +1030,7 @@ static int atomisp_qbuf_wrapper(struct file *file, void *fh, struct v4l2_buffer
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 	struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
 
-	if (buf->index >= vdev->queue->num_buffers)
+	if (buf->index >= vb2_get_num_buffers(vdev->queue))
 		return -EINVAL;
 
 	if (buf->reserved2 & ATOMISP_BUFFER_HAS_PER_FRAME_SETTING) {
-- 
2.39.2

