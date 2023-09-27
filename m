Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4027B08EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjI0PiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjI0Pgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302F010CA;
        Wed, 27 Sep 2023 08:36:26 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 930186607368;
        Wed, 27 Sep 2023 16:36:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828985;
        bh=c7kOTl+JvLUci3Ybxp5I5uKTMKcI7MOYLdh4Vrq/z0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldggy2WldH0w6fVpvXJHAv7iB4WJmdb/QCjL+QiwdHX8gFobbO7nON+6XhVzyWLwR
         /7Sb6kC6I6+XjfpBly+k491HxRBIfHsazDLwHJvRMwnuN+bXN1eugJ4XRVZjIv8A0i
         IwpGy7INrvvNN66Z5mnRo9VFWEwpycJi5HyafxcZ/Vfvx2q7pCtkvCywOQXiN54w4w
         Riz8uEscQVW2t2AGcUWpsTr2rqziQ2D3rvXtJytRNvbB/Y5fDOQKxP7TYh4mCcP6g5
         iwg5UKqKk+uozqiwQWRpBnkvoIRkX4lPLHukwuKOuLreoiK6wl3t4gVMOt44Fl121m
         7h2j99D+/mYrQ==
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
Subject: [PATCH v8 35/53] media: ti: Use queue min_buffers_needed field to set the min number of buffers
Date:   Wed, 27 Sep 2023 17:35:40 +0200
Message-Id: <20230927153558.159278-36-benjamin.gaignard@collabora.com>
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

When queue min_buffers_needed field is correctly set vb2 queue_setup()
does take care of it and we can remove the checks from drivers.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/platform/ti/am437x/am437x-vpfe.c   | 7 ++-----
 drivers/media/platform/ti/cal/cal-video.c        | 5 +----
 drivers/media/platform/ti/davinci/vpif_capture.c | 5 +----
 drivers/media/platform/ti/davinci/vpif_display.c | 5 +----
 drivers/media/platform/ti/omap/omap_vout.c       | 5 +++--
 5 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/ti/am437x/am437x-vpfe.c b/drivers/media/platform/ti/am437x/am437x-vpfe.c
index 63092013d476..a12c93f8b40e 100644
--- a/drivers/media/platform/ti/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/ti/am437x/am437x-vpfe.c
@@ -1776,9 +1776,6 @@ static int vpfe_queue_setup(struct vb2_queue *vq,
 	struct vpfe_device *vpfe = vb2_get_drv_priv(vq);
 	unsigned size = vpfe->fmt.fmt.pix.sizeimage;
 
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	if (*nplanes) {
 		if (sizes[0] < size)
 			return -EINVAL;
@@ -1789,7 +1786,7 @@ static int vpfe_queue_setup(struct vb2_queue *vq,
 	sizes[0] = size;
 
 	vpfe_dbg(1, vpfe,
-		"nbuffers=%d, size=%u\n", *nbuffers, sizes[0]);
+		"nbuffers=%u, size=%u\n", vb2_get_num_buffers(vq), sizes[0]);
 
 	/* Calculate field offset */
 	vpfe_calculate_offsets(vpfe);
@@ -2237,7 +2234,7 @@ static int vpfe_probe_complete(struct vpfe_device *vpfe)
 	q->buf_struct_size = sizeof(struct vpfe_cap_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
 	q->lock = &vpfe->lock;
-	q->min_buffers_needed = 1;
+	q->min_buffers_needed = 3;
 	q->dev = vpfe->pdev;
 
 	err = vb2_queue_init(q);
diff --git a/drivers/media/platform/ti/cal/cal-video.c b/drivers/media/platform/ti/cal/cal-video.c
index a8abcd0fee17..924465b37e5f 100644
--- a/drivers/media/platform/ti/cal/cal-video.c
+++ b/drivers/media/platform/ti/cal/cal-video.c
@@ -604,9 +604,6 @@ static int cal_queue_setup(struct vb2_queue *vq,
 	struct cal_ctx *ctx = vb2_get_drv_priv(vq);
 	unsigned int size = ctx->v_fmt.fmt.pix.sizeimage;
 
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	if (*nplanes) {
 		if (sizes[0] < size)
 			return -EINVAL;
@@ -616,7 +613,7 @@ static int cal_queue_setup(struct vb2_queue *vq,
 	*nplanes = 1;
 	sizes[0] = size;
 
-	ctx_dbg(3, ctx, "nbuffers=%d, size=%d\n", *nbuffers, sizes[0]);
+	ctx_dbg(3, ctx, "nbuffers=%d, size=%d\n", vb2_get_num_buffers(vq), sizes[0]);
 
 	return 0;
 }
diff --git a/drivers/media/platform/ti/davinci/vpif_capture.c b/drivers/media/platform/ti/davinci/vpif_capture.c
index 99fae8830c41..8a4cc62cf562 100644
--- a/drivers/media/platform/ti/davinci/vpif_capture.c
+++ b/drivers/media/platform/ti/davinci/vpif_capture.c
@@ -122,9 +122,6 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
 		size = sizes[0];
 	}
 
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	*nplanes = 1;
 	sizes[0] = size;
 
@@ -1428,7 +1425,7 @@ static int vpif_probe_complete(void)
 		q->mem_ops = &vb2_dma_contig_memops;
 		q->buf_struct_size = sizeof(struct vpif_cap_buffer);
 		q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		q->min_buffers_needed = 1;
+		q->min_buffers_needed = 3;
 		q->lock = &common->lock;
 		q->dev = vpif_dev;
 
diff --git a/drivers/media/platform/ti/davinci/vpif_display.c b/drivers/media/platform/ti/davinci/vpif_display.c
index f8ec2991c667..6fc32314cf9c 100644
--- a/drivers/media/platform/ti/davinci/vpif_display.c
+++ b/drivers/media/platform/ti/davinci/vpif_display.c
@@ -122,9 +122,6 @@ static int vpif_buffer_queue_setup(struct vb2_queue *vq,
 		size = sizes[0];
 	}
 
-	if (vq->num_buffers + *nbuffers < 3)
-		*nbuffers = 3 - vq->num_buffers;
-
 	*nplanes = 1;
 	sizes[0] = size;
 
@@ -1168,7 +1165,7 @@ static int vpif_probe_complete(void)
 		q->mem_ops = &vb2_dma_contig_memops;
 		q->buf_struct_size = sizeof(struct vpif_disp_buffer);
 		q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-		q->min_buffers_needed = 1;
+		q->min_buffers_needed = 3;
 		q->lock = &common->lock;
 		q->dev = vpif_dev;
 		err = vb2_queue_init(q);
diff --git a/drivers/media/platform/ti/omap/omap_vout.c b/drivers/media/platform/ti/omap/omap_vout.c
index 4143274089c3..72ce903717d3 100644
--- a/drivers/media/platform/ti/omap/omap_vout.c
+++ b/drivers/media/platform/ti/omap/omap_vout.c
@@ -944,10 +944,11 @@ static int omap_vout_vb2_queue_setup(struct vb2_queue *vq,
 				     struct device *alloc_devs[])
 {
 	struct omap_vout_device *vout = vb2_get_drv_priv(vq);
+	unsigned int q_num_bufs = vb2_get_num_buffers(vq);
 	int size = vout->pix.sizeimage;
 
-	if (is_rotation_enabled(vout) && vq->num_buffers + *nbufs > VRFB_NUM_BUFS) {
-		*nbufs = VRFB_NUM_BUFS - vq->num_buffers;
+	if (is_rotation_enabled(vout) && q_num_bufs + *nbufs > VRFB_NUM_BUFS) {
+		*nbufs = VRFB_NUM_BUFS - q_num_bufs;
 		if (*nbufs == 0)
 			return -EINVAL;
 	}
-- 
2.39.2

