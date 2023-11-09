Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4D7E6ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343927AbjKIQcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234631AbjKIQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:32:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1F3844;
        Thu,  9 Nov 2023 08:32:26 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 63D0866076A5;
        Thu,  9 Nov 2023 16:32:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547545;
        bh=Ado2aLhXuzRBkS8Z3fQJtea36tlmtlVc/RetuaMh07Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrNyW8eXD87JZJ4lsPACUPMuwIBqMOL8lM91zet/0z5wZidkaUgszs93dMDhViab/
         errk8OKOu9N68ixNt6bihN/90MuxgGwpWjrYvWfPxSDFbEbtzlEqwgtMQykoWMm8t2
         703kNKndKm03hRAKWAWAy45OHMcTi5X329cSgfAdMq+hzL71urWEjDx3/eF8uR9KMZ
         6s7FUI5Q9OUMMab/xOnScdqvXbgHTBVoNCHnelroIeBJsbywpGyrR/C/lAFdooZzsP
         6cRcWiPlQ67vJQMbW00Qq98TwMb2JIMOQ0JByteGUa/E5H1Ql7Rlnj04hClQgYrPqD
         /IMTo7M0yZzhg==
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
Subject: [PATCH v15 02/56] media: videobuf2: Rework offset 'cookie' encoding pattern
Date:   Thu,  9 Nov 2023 17:29:14 +0100
Message-Id: <20231109163008.179152-3-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
References: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change how offset 'cookie' field value is computed to make possible
to use more buffers.
The maximum number of buffers depends of PAGE_SHIFT value and can
go up to 0x7fff when PAGE_SHIFT = 12.
With this encoding pattern we know the maximum number that a queue
could store so we can check it at  queue init time.
It also make easier and faster to find buffer and plane from using
the offset field.
Change __find_plane_by_offset() prototype to return the video buffer
itself rather than it index.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 15:
- Add a check on PLANE_INDEX_BITS value.
  I haven't used BUILD_BUG_ON() macro because I would have need
  to put it inside a function. I have prefer a basic #if

 .../media/common/videobuf2/videobuf2-core.c   | 78 ++++++++++---------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index e5fd7ff0dae6..0b7c6b297d12 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,16 @@
 
 #include <trace/events/vb2.h>
 
+#define PLANE_INDEX_BITS	3
+#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + PLANE_INDEX_BITS)
+#define PLANE_INDEX_MASK	(BIT_MASK(PLANE_INDEX_BITS) - 1)
+#define MAX_BUFFER_INDEX	BIT_MASK(30 - PLANE_INDEX_SHIFT)
+#define BUFFER_INDEX_MASK	(MAX_BUFFER_INDEX - 1)
+
+#if BIT(PLANE_INDEX_BITS) != VIDEO_MAX_PLANES
+#error PLANE_INDEX_BITS order must be equal to VIDEO_MAX_PLANES
+#endif
+
 static int debug;
 module_param(debug, int, 0644);
 
@@ -358,21 +368,27 @@ static void __setup_offsets(struct vb2_buffer *vb)
 	unsigned int plane;
 	unsigned long offset = 0;
 
-	if (vb->index) {
-		struct vb2_buffer *prev = q->bufs[vb->index - 1];
-		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
-
-		offset = PAGE_ALIGN(p->m.offset + p->length);
-	}
+	/*
+	 * The offset "cookie" value has the following constraints:
+	 * - a buffer can have up to 8 planes.
+	 * - v4l2 mem2mem uses bit 30 to distinguish between
+	 *   OUTPUT (aka "source", bit 30 is 0) and
+	 *   CAPTURE (aka "destination", bit 30 is 1) buffers.
+	 * - must be page aligned
+	 * That led to this bit mapping when PAGE_SHIFT = 12:
+	 * |30                |29        15|14       12|11 0|
+	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
+	 * where there are 15 bits to store the buffer index.
+	 * Depending on PAGE_SHIFT value we can have fewer bits
+	 * to store the buffer index.
+	 */
+	offset = vb->index << PLANE_INDEX_SHIFT;
 
 	for (plane = 0; plane < vb->num_planes; ++plane) {
-		vb->planes[plane].m.offset = offset;
+		vb->planes[plane].m.offset = offset + (plane << PAGE_SHIFT);
 
 		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
 				vb->index, plane, offset);
-
-		offset += vb->planes[plane].length;
-		offset = PAGE_ALIGN(offset);
 	}
 }
 
@@ -2188,10 +2204,9 @@ EXPORT_SYMBOL_GPL(vb2_core_streamoff);
  * __find_plane_by_offset() - find plane associated with the given offset
  */
 static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
-				  unsigned int *_buffer, unsigned int *_plane)
+			struct vb2_buffer **vb, unsigned int *plane)
 {
-	struct vb2_buffer *vb;
-	unsigned int buffer, plane;
+	unsigned int buffer;
 
 	/*
 	 * Sanity checks to ensure the lock is held, MEMORY_MMAP is
@@ -2209,24 +2224,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
 		return -EBUSY;
 	}
 
-	/*
-	 * Go over all buffers and their planes, comparing the given offset
-	 * with an offset assigned to each plane. If a match is found,
-	 * return its buffer and plane numbers.
-	 */
-	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
-		vb = q->bufs[buffer];
+	/* Get buffer and plane from the offset */
+	buffer = (offset >> PLANE_INDEX_SHIFT) & BUFFER_INDEX_MASK;
+	*plane = (offset >> PAGE_SHIFT) & PLANE_INDEX_MASK;
 
-		for (plane = 0; plane < vb->num_planes; ++plane) {
-			if (vb->planes[plane].m.offset == offset) {
-				*_buffer = buffer;
-				*_plane = plane;
-				return 0;
-			}
-		}
-	}
+	if (buffer >= q->num_buffers || *plane >= q->bufs[buffer]->num_planes)
+		return -EINVAL;
 
-	return -EINVAL;
+	*vb = q->bufs[buffer];
+	return 0;
 }
 
 int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
@@ -2306,7 +2312,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 {
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer = 0, plane = 0;
+	unsigned int plane = 0;
 	int ret;
 	unsigned long length;
 
@@ -2335,12 +2341,10 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
+	ret = __find_plane_by_offset(q, offset, &vb, &plane);
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
-
 	/*
 	 * MMAP requires page_aligned buffers.
 	 * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
@@ -2368,7 +2372,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	dprintk(q, 3, "buffer %d, plane %d successfully mapped\n", buffer, plane);
+	dprintk(q, 3, "buffer %u, plane %d successfully mapped\n", vb->index, plane);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vb2_mmap);
@@ -2382,7 +2386,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 {
 	unsigned long offset = pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer, plane;
+	unsigned int plane;
 	void *vaddr;
 	int ret;
 
@@ -2392,12 +2396,10 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
+	ret = __find_plane_by_offset(q, offset, &vb, &plane);
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
-
 	vaddr = vb2_plane_vaddr(vb, plane);
 	mutex_unlock(&q->mmap_lock);
 	return vaddr ? (unsigned long)vaddr : -EINVAL;
-- 
2.39.2

