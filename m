Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499A07CC6CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344175AbjJQOvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjJQOtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:49:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8A9D68;
        Tue, 17 Oct 2023 07:48:32 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2CE7D660733E;
        Tue, 17 Oct 2023 15:48:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554110;
        bh=CXn4h0IxtDsAWkm4SwlGBeyD+zWA1T36ht/PdPVPBJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqapPuIHyciwwS4QnCuv/Etz1CZjJcWETmbIw9Uo11K4Uut7Iyuzba8cHeLsCntsH
         J1ybeIfCb5rUmtfmF6w7hFtBJzCaMDy5+BwE1kCFt7g9Cm275r3bEHOpImhRoBm1Vz
         mbnxNz4RdVoSsM9ljq7z05AQp9S5cDXSPOz/H8Qa8NlE2NBQMU4tCNUZ+F2cHNEx5j
         klFgr6e6/vtJ/lk0gT6upT3sdETSi3ufGPjZO+MUraEvOJSLZ2OcHKGuh7YphgZfOj
         sVrONa8KmhaqpHyqchpPOGtPTuhba2618bMX9QFvY0zApyQ9W9QetDK5oM04oJeaTM
         Fm0rTOru6pw3g==
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
Subject: [PATCH v12 51/56] media: core: Rework how create_buf index returned value is computed
Date:   Tue, 17 Oct 2023 16:47:51 +0200
Message-Id: <20231017144756.34719-52-benjamin.gaignard@collabora.com>
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

When DELETE_BUFS will be introduced holes could created in bufs array.
To be able to reuse these unused indices reworking how create->index
is set is mandatory.
Let __vb2_queue_alloc() decide which first index is correct and
forward this to the caller.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 22 ++++++++++++-------
 .../media/common/videobuf2/videobuf2-v4l2.c   | 20 +++++++++++------
 include/media/videobuf2-core.h                |  5 ++++-
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 72ef7179d80a..2c8cf479a962 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -442,16 +442,21 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  */
 static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			     unsigned int num_buffers, unsigned int num_planes,
-			     const unsigned plane_sizes[VB2_MAX_PLANES])
+			     const unsigned plane_sizes[VB2_MAX_PLANES],
+			     unsigned int *first_index)
 {
-	unsigned int q_num_buffers = vb2_get_num_buffers(q);
 	unsigned int buffer, plane;
 	struct vb2_buffer *vb;
+	unsigned long index;
 	int ret;
 
 	/* Ensure that the number of already queue + num_buffers is below q->max_num_buffers */
 	num_buffers = min_t(unsigned int, num_buffers,
-			    q->max_num_buffers - q_num_buffers);
+			    q->max_num_buffers - vb2_get_num_buffers(q));
+
+	index = vb2_get_num_buffers(q);
+
+	*first_index = index;
 
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
@@ -471,7 +476,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			vb->planes[plane].min_length = plane_sizes[plane];
 		}
 
-		vb2_queue_add_buffer(q, vb, q_num_buffers + buffer);
+		vb2_queue_add_buffer(q, vb, index++);
 		call_void_bufop(q, init_buffer, vb);
 
 		/* Allocate video buffer memory for the MMAP type */
@@ -812,7 +817,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
-	unsigned int i;
+	unsigned int i, first_index;
 	int ret = 0;
 
 	if (q->streaming) {
@@ -898,7 +903,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers =
-		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
+		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first_index);
 	if (allocated_buffers == 0) {
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
@@ -972,7 +977,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[])
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index)
 {
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
@@ -1034,7 +1040,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
-				num_planes, plane_sizes);
+				num_planes, plane_sizes, first_index);
 	if (allocated_buffers == 0) {
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 201438ffd13f..c28905bd893b 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -805,11 +805,16 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
 	for (i = 0; i < requested_planes; i++)
 		if (requested_sizes[i] == 0)
 			return -EINVAL;
-	return ret ? ret : vb2_core_create_bufs(q, create->memory,
-						create->flags,
-						&create->count,
-						requested_planes,
-						requested_sizes);
+	if (ret)
+		return ret;
+
+	ret = vb2_core_create_bufs(q, create->memory,
+				   create->flags,
+				   &create->count,
+				   requested_planes,
+				   requested_sizes,
+				   &create->index);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(vb2_create_bufs);
 
@@ -1037,15 +1042,16 @@ int vb2_ioctl_create_bufs(struct file *file, void *priv,
 	int res = vb2_verify_memory_type(vdev->queue, p->memory,
 			p->format.type);
 
-	p->index = vdev->queue->num_buffers;
 	fill_buf_caps(vdev->queue, &p->capabilities);
 	validate_memory_flags(vdev->queue, p->memory, &p->flags);
 	/*
 	 * If count == 0, then just check if memory and type are valid.
 	 * Any -EBUSY result from vb2_verify_memory_type can be mapped to 0.
 	 */
-	if (p->count == 0)
+	if (p->count == 0) {
+		p->index = vb2_get_num_buffers(vdev->queue);
 		return res != -EBUSY ? res : 0;
+	}
 	if (res)
 		return res;
 	if (vb2_queue_is_busy(vdev->queue, file))
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index e77a397195f2..6986ff4b77cd 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -803,6 +803,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
  * @count: requested buffer count.
  * @requested_planes: number of planes requested.
  * @requested_sizes: array with the size of the planes.
+ * @first_index: index of the first created buffer, all allocated buffers have
+ *		 indices in the range [first..first+count]
  *
  * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
  * called internally by VB2 by an API-specific handler, like
@@ -819,7 +821,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[]);
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index);
 
 /**
  * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace
-- 
2.39.2

