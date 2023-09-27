Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E47B0906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjI0PjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjI0Pgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5DCE9;
        Wed, 27 Sep 2023 08:36:35 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC2516607389;
        Wed, 27 Sep 2023 16:36:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828994;
        bh=od83LmKhAhKbqGYrw7/WB9PaXmjqloXPSjvbzmBGKQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B24J5Z8Of97NNyUNAJz/HZT9Qi/vPP8oAqa8FhJL3F3fRQ54bDAQG/yWbIjb3xW+M
         yJQzGr7VhIGpemYTtQPc8ULjpaP3Td7B1RoYL0YbOMV7Y3Ez9pyEfp/VTvY2w03AsW
         cJv8UzGZiy6JBSRJ8I3IvxH74JDU5KwrIG3igq8Mn5QI4fYM+NDHwcpGEsVRv4zt7W
         CjTizA0UvCXW+UDLjiLjxR6UEMCCWXfwN1GL4ZXUOJl6uIfPknBxTzpskXg7oqSC8R
         xh1nsbSvJcapxgquRDdDkMQ6YzcfdxG9QXp7tZdMoCBxZqlbZ07JWdERF78O6IosWm
         +vomP7UO5sQVg==
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
Subject: [PATCH v8 53/53] media: test-drivers: Use helper for DELETE_BUFS ioctl
Date:   Wed, 27 Sep 2023 17:35:58 +0200
Message-Id: <20230927153558.159278-54-benjamin.gaignard@collabora.com>
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
index 58a059140365..2ed8847ce86e 100644
--- a/drivers/media/test-drivers/vivid/vivid-core.c
+++ b/drivers/media/test-drivers/vivid/vivid-core.c
@@ -769,6 +769,7 @@ static const struct v4l2_ioctl_ops vivid_ioctl_ops = {
 	.vidioc_expbuf			= vb2_ioctl_expbuf,
 	.vidioc_streamon		= vb2_ioctl_streamon,
 	.vidioc_streamoff		= vb2_ioctl_streamoff,
+	.vidioc_delete_bufs		= vb2_ioctl_delete_bufs,
 
 	.vidioc_enum_input		= vivid_enum_input,
 	.vidioc_g_input			= vivid_g_input,
@@ -876,12 +877,18 @@ static int vivid_create_queue(struct vivid_dev *dev,
 	q->type = buf_type;
 	q->io_modes = VB2_MMAP | VB2_DMABUF;
 	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
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

