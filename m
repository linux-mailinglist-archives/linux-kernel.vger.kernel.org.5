Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB12F7C6D24
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbjJLLsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378557AbjJLLrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:47:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15545F1;
        Thu, 12 Oct 2023 04:47:02 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7ae7:b86d:c19a:877e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 87F366607371;
        Thu, 12 Oct 2023 12:47:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697111220;
        bh=Jt1mNMm36fegL/wBY23liBF0ngeSMzYwFlorrhK5AKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ikpsd6wm0YYrF8nGwJim6Sv46Xxi4+ScsUHZDGZGFg11Xq2SIcNnZJuk8JxZjYeis
         1dDxmHOF/e9SWZ2vztz3EwGYkBzKS253R+V/+GwZ2hWFFsD93tg2yIctLbvp0BeXcv
         BGYfejgSuF20/iraRJ/0RSvSu5UBlJHtf0zjg5kyeA7bTHO1piM1KbtvRCpHMaT+qV
         CQQcxvHf/hi49UYNaT/ndwxI53687YmNz08aGpUbvHR1txfHCs8KfZQvXSofhTjT5E
         uR9MpIn01HNnQiYlZ9l9CkBIdPtUDlyqK5CShCdD4Mzgiz/BXMOwaUjYClBjruaA8A
         r0IVcbFWDbhlg==
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
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v11 21/56] media: video-i2c: Set min_buffers_needed to 2
Date:   Thu, 12 Oct 2023 13:46:07 +0200
Message-Id: <20231012114642.19040-22-benjamin.gaignard@collabora.com>
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

vb2 queue_setup checks for a minimum number of buffers so set
min_buffers_needed to 2 and remove the useless check in video-i2c
queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/media/i2c/video-i2c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 178bd06cc2ed..0a38b9614764 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -406,9 +406,6 @@ static int queue_setup(struct vb2_queue *vq,
 	struct video_i2c_data *data = vb2_get_drv_priv(vq);
 	unsigned int size = data->chip->buffer_size;
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2;
-
 	if (*nplanes)
 		return sizes[0] < size ? -EINVAL : 0;
 
@@ -794,7 +791,7 @@ static int video_i2c_probe(struct i2c_client *client)
 	queue->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	queue->drv_priv = data;
 	queue->buf_struct_size = sizeof(struct video_i2c_buffer);
-	queue->min_buffers_needed = 1;
+	queue->min_buffers_needed = 2;
 	queue->ops = &video_i2c_video_qops;
 	queue->mem_ops = &vb2_vmalloc_memops;
 
-- 
2.39.2

