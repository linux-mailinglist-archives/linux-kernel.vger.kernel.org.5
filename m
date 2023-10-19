Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8DE7CFA09
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346167AbjJSM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbjJSMyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:54:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B311709;
        Thu, 19 Oct 2023 05:53:01 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:ccea:1fb5:34eb:239b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F33266073A4;
        Thu, 19 Oct 2023 13:52:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697719980;
        bh=bvlqKNzionLKB1VClCmq81RGJBsdZ7hA0RN2y42SWPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+twYbANrVJ+kjFi560OlpvROgm4yskA9m74KZaNoNOqqwZDuqk2lxtJueSvP7eSI
         SNg2Ux5H/OrSlPFcQMMythq1uzew7TVhUB7TFgkt3UuIpYUalnUV3nuH7PvlJNWLLe
         ZtuIXhV0/MPboo4zQLOr7XjDj2j76WDEJB8/9Le4qip9SrINsSKmYkqR/1tQap6LAB
         nchR9GtmCGKC6WMFiY//ZQ4VX9E5r4FSipS1trPZWtWjTIbV5FviGQFE/xDVNA08rf
         VS//ESVvprpVlJai3bN0OJaNLhxrLKG8wnLlOhjOP22Izkuqrp2ungM1xRwMYM5K9L
         eKBs9BkgGRvJw==
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
Subject: [PATCH v13 56/56] media: test-drivers: Use helper for DELETE_BUFS ioctl
Date:   Thu, 19 Oct 2023 14:52:22 +0200
Message-Id: <20231019125222.21370-57-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
References: <20231019125222.21370-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow test drivers to use DELETE_BUFS by adding vb2_ioctl_delete_bufs() helper.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c |  2 ++
 drivers/media/test-drivers/vimc/vimc-capture.c    |  2 ++
 drivers/media/test-drivers/visl/visl-video.c      |  2 ++
 drivers/media/test-drivers/vivid/vivid-core.c     | 13 ++++++++++---
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 69cbe2c094e1..f14a8fd506d0 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1339,6 +1339,7 @@ static const struct v4l2_ioctl_ops vicodec_ioctl_ops = {
 	.vidioc_prepare_buf	= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs	= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf		= v4l2_m2m_ioctl_expbuf,
+	.vidioc_delete_bufs	= v4l2_m2m_ioctl_delete_bufs,
 
 	.vidioc_streamon	= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff	= v4l2_m2m_ioctl_streamoff,
@@ -1725,6 +1726,7 @@ static int queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->lock = src_vq->lock;
+	dst_vq->supports_delete_bufs = true;
 
 	return vb2_queue_init(dst_vq);
 }
diff --git a/drivers/media/test-drivers/vimc/vimc-capture.c b/drivers/media/test-drivers/vimc/vimc-capture.c
index aa944270e716..fda7ea3a6cb6 100644
--- a/drivers/media/test-drivers/vimc/vimc-capture.c
+++ b/drivers/media/test-drivers/vimc/vimc-capture.c
@@ -221,6 +221,7 @@ static const struct v4l2_ioctl_ops vimc_capture_ioctl_ops = {
 	.vidioc_expbuf = vb2_ioctl_expbuf,
 	.vidioc_streamon = vb2_ioctl_streamon,
 	.vidioc_streamoff = vb2_ioctl_streamoff,
+	.vidioc_delete_bufs = vb2_ioctl_delete_bufs,
 };
 
 static void vimc_capture_return_all_buffers(struct vimc_capture_device *vcapture,
@@ -435,6 +436,7 @@ static struct vimc_ent_device *vimc_capture_add(struct vimc_device *vimc,
 	q->min_buffers_needed = 2;
 	q->lock = &vcapture->lock;
 	q->dev = v4l2_dev->dev;
+	q->supports_delete_bufs = true;
 
 	ret = vb2_queue_init(q);
 	if (ret) {
diff --git a/drivers/media/test-drivers/visl/visl-video.c b/drivers/media/test-drivers/visl/visl-video.c
index 7cac6a6456eb..bd6c112f7846 100644
--- a/drivers/media/test-drivers/visl/visl-video.c
+++ b/drivers/media/test-drivers/visl/visl-video.c
@@ -521,6 +521,7 @@ const struct v4l2_ioctl_ops visl_ioctl_ops = {
 	.vidioc_prepare_buf		= v4l2_m2m_ioctl_prepare_buf,
 	.vidioc_create_bufs		= v4l2_m2m_ioctl_create_bufs,
 	.vidioc_expbuf			= v4l2_m2m_ioctl_expbuf,
+	.vidioc_delete_bufs		= v4l2_m2m_ioctl_delete_bufs,
 
 	.vidioc_streamon		= v4l2_m2m_ioctl_streamon,
 	.vidioc_streamoff		= v4l2_m2m_ioctl_streamoff,
@@ -728,6 +729,7 @@ int visl_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->mem_ops = &vb2_vmalloc_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
 	dst_vq->lock = &ctx->vb_mutex;
+	dst_vq->supports_delete_bufs = true;
 
 	return vb2_queue_init(dst_vq);
 }
diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
index 353f035fcd19..06b18d8e2248 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -769,6 +769,7 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+	.vidioc_delete_bufs		= vb2_ioctl_delete_bufs,
 
 	.vidioc_enum_input		= vivid_enum_input,
 	.vidioc_g_input			= vivid_g_input,
@@ -883,12 +884,18 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	 * PAGE_SHIFT > 12, but then max_num_buffers will be clamped by
 	 * videobuf2-core.c to MAX_BUFFER_INDEX.
 	 */
-	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
+	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		q->max_num_buffers = 64;
-	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE)
+		q->supports_delete_bufs = true;
+	}
+	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE) {
 		q->max_num_buffers = 1024;
-	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
+		q->supports_delete_bufs = true;
+	}
+	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE) {
 		q->max_num_buffers = 32768;
+		q->supports_delete_bufs = true;
+	}
 
 	if (allocators[dev->inst] != 1)
 		q->io_modes |= VB2_USERPTR;
-- 
2.39.2

