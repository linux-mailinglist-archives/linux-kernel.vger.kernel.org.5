Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07CA7B08ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjI0PiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjI0Pgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40898196;
        Wed, 27 Sep 2023 08:36:27 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3D9F6607355;
        Wed, 27 Sep 2023 16:36:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828986;
        bh=rHRsY4Ykk7DeFM5FncUlUgp6Bdha+CYxFon6BrOIBTM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JJTBhS7QomSbs+wfJce0uA/VMpO3XQHOBdxZGH+MBjzHPx5KHF2JnZuR4Kkbh5cVw
         0uOTNdIs4rhgAJ2YSH8rhxHSvR3z8bUuit+EQE4oBhYK/ocmti+u0XxChkF09weHSD
         Clj3r+5QZX7+Gb9gAEGW5KLzyF+Mvge79ZshMKzEOYOBeGLbf0ovwTmF6Xk9cbZbRH
         RVaAz0aYcwDV7sP8cjaHqHb1Uhw0fcNc5Z7Gxpl3j4dRdG5RkkSYZP4bQzhLIfUkcs
         HnJ6Sq4Sd0puSURsgGU0U1rCzIQ/gMiQaIG1SXwAddqP12frFYIY0kC/YoqdbHp+1k
         Fu+5HV/vAshIw==
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
Subject: [PATCH v8 37/53] media: test-drivers: Stop direct calls to queue num_buffers field
Date:   Wed, 27 Sep 2023 17:35:42 +0200
Message-Id: <20230927153558.159278-38-benjamin.gaignard@collabora.com>
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
If min_buffers_needed is set remove useless checks.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c         | 4 ++--
 drivers/media/test-drivers/vivid/vivid-meta-cap.c  | 3 ---
 drivers/media/test-drivers/vivid/vivid-meta-out.c  | 5 +++--
 drivers/media/test-drivers/vivid/vivid-touch-cap.c | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vbi-cap.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vbi-out.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vid-out.c   | 5 +----
 8 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index ba20ea998d19..7aa70da72b97 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -287,7 +287,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
 	len = 0;
-	for (i = 0; i < out_q->num_buffers; i++) {
+	for (i = 0; i < out_q->max_num_buffers; i++) {
 		char entry[] = "index: %u, state: %s, request_fd: %d, ";
 		u32 old_len = len;
 		struct vb2_buffer *vb2;
@@ -347,7 +347,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
 	len = 0;
-	for (i = 0; i < cap_q->num_buffers; i++) {
+	for (i = 0; i < cap_q->max_num_buffers; i++) {
 		u32 old_len = len;
 		struct vb2_buffer *vb2;
 		char *q_status;
diff --git a/drivers/media/test-drivers/vivid/vivid-meta-cap.c b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
index 780f96860a6d..0a718d037e59 100644
--- a/drivers/media/test-drivers/vivid/vivid-meta-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
@@ -30,9 +30,6 @@ static int meta_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
-
 	*nplanes = 1;
 	return 0;
 }
diff --git a/drivers/media/test-drivers/vivid/vivid-meta-out.c b/drivers/media/test-drivers/vivid/vivid-meta-out.c
index 95835b52b58f..4a569a6e58be 100644
--- a/drivers/media/test-drivers/vivid/vivid-meta-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-meta-out.c
@@ -18,6 +18,7 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned int size =  sizeof(struct vivid_meta_out_buf);
 
 	if (!vivid_is_webcam(dev))
@@ -30,8 +31,8 @@ static int meta_out_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = 1;
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-touch-cap.c b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
index c7f6e23df51e..4b3c6ea0afde 100644
--- a/drivers/media/test-drivers/vivid/vivid-touch-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-touch-cap.c
@@ -13,6 +13,7 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				 struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	struct v4l2_pix_format *f = &dev->tch_format;
 	unsigned int size = f->sizeimage;
 
@@ -23,8 +24,8 @@ static int touch_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = 1;
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-cap.c b/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
index b65b02eeeb97..fcd7f40385e9 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-cap.c
@@ -124,6 +124,7 @@ static int vbi_cap_queue_setup(struct vb2_queue *vq,
 		       unsigned sizes[], struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	bool is_60hz = dev->std_cap[dev->input] & V4L2_STD_525_60;
 	unsigned size = vq->type == V4L2_BUF_TYPE_SLICED_VBI_CAPTURE ?
 		36 * sizeof(struct v4l2_sliced_vbi_data) :
@@ -134,8 +135,8 @@ static int vbi_cap_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = size;
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = 1;
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-vbi-out.c b/drivers/media/test-drivers/vivid/vivid-vbi-out.c
index cd56476902a2..8f0da5d88bcc 100644
--- a/drivers/media/test-drivers/vivid/vivid-vbi-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vbi-out.c
@@ -20,6 +20,7 @@ static int vbi_out_queue_setup(struct vb2_queue *vq,
 		       unsigned sizes[], struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	bool is_60hz = dev->std_out & V4L2_STD_525_60;
 	unsigned size = vq->type == V4L2_BUF_TYPE_SLICED_VBI_OUTPUT ?
 		36 * sizeof(struct v4l2_sliced_vbi_data) :
@@ -30,8 +31,8 @@ static int vbi_out_queue_setup(struct vb2_queue *vq,
 
 	sizes[0] = size;
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = 1;
 	return 0;
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 3a06df35a2d7..0cc7602b9fb2 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -77,6 +77,7 @@ static int vid_cap_queue_setup(struct vb2_queue *vq,
 		       unsigned sizes[], struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned buffers = tpg_g_buffers(&dev->tpg);
 	unsigned h = dev->fmt_cap_rect.height;
 	unsigned p;
@@ -117,8 +118,8 @@ static int vid_cap_queue_setup(struct vb2_queue *vq,
 					dev->fmt_cap->data_offset[p];
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = buffers;
 
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-out.c b/drivers/media/test-drivers/vivid/vivid-vid-out.c
index 184a6df2c29f..24c6dc896255 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -73,12 +73,9 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
 				       vfmt->data_offset[p] : size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
-
 	*nplanes = planes;
 
-	dprintk(dev, 1, "%s: count=%d\n", __func__, *nbuffers);
+	dprintk(dev, 1, "%s: count=%u\n", __func__, vb2_get_num_buffers(vq));
 	for (p = 0; p < planes; p++)
 		dprintk(dev, 1, "%s: size[%u]=%u\n", __func__, p, sizes[p]);
 	return 0;
-- 
2.39.2

