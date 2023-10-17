Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A67CC6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344154AbjJQOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbjJQOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFB115;
        Tue, 17 Oct 2023 07:48:16 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC0376607370;
        Tue, 17 Oct 2023 15:48:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554095;
        bh=YCZw7PvG0/vvqRoLk52CD8Z7MDM+1YNzRKdH40h8V+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUSq5BfKZyYnBeq717o58rGsqLPCI3q/4TQNCYgZkwmbtNZUSOuDSuMqbnpuM3358
         hOHflD8jGQ9hwQIBD6zkrBav56RjX4i3Sley/VOyHFQqdPbUP3SO85KKkgME7oOvWv
         667uk23Zbe9qI4aBu2uYnHi82b83q8gRKxvzdhqKF7uLVKIq4sVVlc4N0Ikk50O1IC
         OAzRK6xQOGv66i9HUFvN5Qhc1a2mY1FmyhV3Yaezrj2Pus6jBDKgy6BLka9tvOQyRI
         eIw9eFnqe99DkBZfR3NXWjETJxITT6o9R58Kmp77EpUF8HOVXSqHHzozs0fS0nFXp9
         sHPEnpmvSqo7A==
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
Subject: [PATCH v12 22/56] media: pci: tw686x: Set min_buffers_needed to 3
Date:   Tue, 17 Oct 2023 16:47:22 +0200
Message-Id: <20231017144756.34719-23-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
References: <20231017144756.34719-1-benjamin.gaignard@collabora.com>
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
min_buffers_needed to 3 and remove the useless check in
tw686x_queue_setup().

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
CC: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/pci/tw686x/tw686x-video.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/media/pci/tw686x/tw686x-video.c b/drivers/media/pci/tw686x/tw686x-video.c
index 3ebf7a2c95f0..74cd864365aa 100644
--- a/drivers/media/pci/tw686x/tw686x-video.c
+++ b/drivers/media/pci/tw686x/tw686x-video.c
@@ -426,13 +426,6 @@ static int tw686x_queue_setup(struct vb2_queue *vq,
 	unsigned int szimage =
 		(vc->width * vc->height * vc->format->depth) >> 3;
 
-	/*
-	 * Let's request at least three buffers: two for the
-	 * DMA engine and one for userspace.
-	 */
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	if (*nplanes) {
 		if (*nplanes != 1 || sizes[0] < szimage)
 			return -EINVAL;
@@ -1221,7 +1214,11 @@ int tw686x_video_init(struct tw686x_dev *dev)
 		vc->vidq.ops = &tw686x_video_qops;
 		vc->vidq.mem_ops = dev->dma_ops->mem_ops;
 		vc->vidq.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		vc->vidq.min_buffers_needed = 2;
+		/*
+		 * Let's request at least three buffers: two for the
+		 * DMA engine and one for userspace.
+		 */
+		vc->vidq.min_buffers_needed = 3;
 		vc->vidq.lock = &vc->vb_mutex;
 		vc->vidq.gfp_flags = dev->dma_mode != TW686X_DMA_MODE_MEMCPY ?
 				     GFP_DMA32 : 0;
-- 
2.39.2

