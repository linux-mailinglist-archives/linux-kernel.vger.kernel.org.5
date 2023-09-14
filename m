Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8457A060E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbjINNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbjINNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:34:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8302026AF;
        Thu, 14 Sep 2023 06:33:51 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:36f2:37bd:ccbb:373f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE0286607386;
        Thu, 14 Sep 2023 14:33:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694698430;
        bh=nAdhAei2sfdOufKeuwN9pMJSVWrRttlIbrMwNBf4Ulw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BKySdgRiV7Rtv6yJBJSbPB3yWzTqU/dLrmop5DiHyTqbnHXKZ3Tg+pWc/oZH5NB03
         4cq3NUgpucVFv92GlIAYxlt0CsP3l67r560U7Ws3ABm/5CV5ki23B+yNIf0k7HTCcJ
         lfzapOsPKTpHyARGYeWjiJ+EHPgyVI5JZjBOWuoqYGvQG+RyPRCVd4DEK/I3hmPmSM
         SCOEOf3SF/77PLkooMe/nAQpF5MLr8Rl1sB1cuFsy7A0/X85XFqXQxaQvq87mjNMkD
         NmgouqIMcypWfglS42aF5dizH3pIOOCi8Otbr1Y4Lu9dcg+jn/WVlo8wk1WoEPn0MK
         CXLySE6DAVLUg==
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
Subject: [PATCH v7 36/49] media: test-drivers: Stop direct calls to queue num_buffers field
Date:   Thu, 14 Sep 2023 15:33:10 +0200
Message-Id: <20230914133323.198857-37-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vb2_get_num_buffers() to avoid using queue num_buffer field directly.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/visl/visl-dec.c         | 4 ++--
 drivers/media/test-drivers/vivid/vivid-meta-cap.c  | 5 +++--
 drivers/media/test-drivers/vivid/vivid-meta-out.c  | 5 +++--
 drivers/media/test-drivers/vivid/vivid-touch-cap.c | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vbi-cap.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vbi-out.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vid-cap.c   | 5 +++--
 drivers/media/test-drivers/vivid/vivid-vid-out.c   | 5 +++--
 8 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/media/test-drivers/visl/visl-dec.c b/drivers/media/test-drivers/visl/visl-dec.c
index ba20ea998d19..81da5dcf890a 100644
--- a/drivers/media/test-drivers/visl/visl-dec.c
+++ b/drivers/media/test-drivers/visl/visl-dec.c
@@ -287,7 +287,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
 	len = 0;
-	for (i = 0; i < out_q->num_buffers; i++) {
+	for (i = 0; i < out_q->max_allowed_buffers; i++) {
 		char entry[] = "index: %u, state: %s, request_fd: %d, ";
 		u32 old_len = len;
 		struct vb2_buffer *vb2;
@@ -347,7 +347,7 @@ static void visl_tpg_fill(struct visl_ctx *ctx, struct visl_run *run)
 	frame_dprintk(ctx->dev, run->dst->sequence, "%s\n", buf);
 
 	len = 0;
-	for (i = 0; i < cap_q->num_buffers; i++) {
+	for (i = 0; i < cap_q->max_allowed_buffers; i++) {
 		u32 old_len = len;
 		struct vb2_buffer *vb2;
 		char *q_status;
diff --git a/drivers/media/test-drivers/vivid/vivid-meta-cap.c b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
index 780f96860a6d..646b1c6a936f 100644
--- a/drivers/media/test-drivers/vivid/vivid-meta-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-meta-cap.c
@@ -18,6 +18,7 @@ static int meta_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 				struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	unsigned int size =  sizeof(struct vivid_uvc_meta_buf);
 
 	if (!vivid_is_webcam(dev))
@@ -30,8 +31,8 @@ static int meta_cap_queue_setup(struct vb2_queue *vq, unsigned int *nbuffers,
 		sizes[0] = size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = 1;
 	return 0;
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
index 184a6df2c29f..25578f55a060 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-out.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-out.c
@@ -25,6 +25,7 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
 		       unsigned sizes[], struct device *alloc_devs[])
 {
 	struct vivid_dev *dev = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	const struct vivid_fmt *vfmt = dev->fmt_out;
 	unsigned planes = vfmt->buffers;
 	unsigned h = dev->fmt_out_rect.height;
@@ -73,8 +74,8 @@ static int vid_out_queue_setup(struct vb2_queue *vq,
 				       vfmt->data_offset[p] : size;
 	}
 
-	if (vq->num_buffers + *nbuffers < 2)
-		*nbuffers = 2 - vq->num_buffers;
+	if (q_num_bufs + *nbuffers < 2)
+		*nbuffers = 2 - q_num_bufs;
 
 	*nplanes = planes;
 
-- 
2.39.2

