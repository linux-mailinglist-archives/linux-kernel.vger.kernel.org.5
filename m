Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7987B6348
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbjJCIHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239232AbjJCIHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:07:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8886ABB;
        Tue,  3 Oct 2023 01:07:15 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:b6df:b784:6a0f:8451])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 624626607314;
        Tue,  3 Oct 2023 09:07:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696320433;
        bh=iaY5c9hnLGM9FgrNcUT9lH4BfnmbtAjScVjFG5kZCis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U32ioNXFphjGSPZdVwpd0lLjfDTrjtM6596sviypo1SXXukFqqingEOxnPZ5QAkx9
         FN7moKADdfch34xO/K6Psjwe9Z4IZU+keR5sxck8rZwuqOXIr+ZXoEARaJD9+8wuD1
         R7NC3Y1da3nVNVQHlQ+7TpJCUUUkz2Zfaai5T8mIEbEKxPaql8PG3VXdLDBhLQdWo8
         U0gBdu/lAf3Q3wuJRyu/+NOCxlmOS0NnehG8LNUenMGfUz/omx17wl43vfMZxUsceE
         UjFxDWl+TLn1CbIB6FRLIS2Okq3C8h5KGy9uX7cK5AwstpVMcFMilVfpyx/MMU6She
         Sd7OtUGnz2Bqw==
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
Subject: [PATCH v10 01/54] media: videobuf2: Rework offset 'cookie' encoding pattern
Date:   Tue,  3 Oct 2023 10:06:10 +0200
Message-Id: <20231003080704.43911-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
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
changes in version 10:
- Make BUFFER_INDEX_MASK definition more readable.
- Correct typo.

 .../media/common/videobuf2/videobuf2-core.c   | 72 +++++++++----------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 27aee92f3eea..5591ac830668 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,11 @@
 
 #include <trace/events/vb2.h>
 
+#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + 3)
+#define PLANE_INDEX_MASK	0x7
+#define MAX_BUFFER_INDEX	BIT_MASK(30 - PLANE_INDEX_SHIFT)
+#define BUFFER_INDEX_MASK	(MAX_BUFFER_INDEX - 1)
+
 static int debug;
 module_param(debug, int, 0644);
 
@@ -358,21 +363,24 @@ static void __setup_offsets(struct vb2_buffer *vb)
 	unsigned int plane;
 	unsigned long off = 0;
 
-	if (vb->index) {
-		struct vb2_buffer *prev = q->bufs[vb->index - 1];
-		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
-
-		off = PAGE_ALIGN(p->m.offset + p->length);
-	}
+	/*
+	 * Offsets cookies value have the following constraints:
+	 * - a buffer can have up to 8 planes.
+	 * - v4l2 mem2mem uses bit 30 to distinguish between source and destination buffers.
+	 * - must be page aligned
+	 * That led to this bit mapping when PAGE_SHIFT = 12:
+	 * |30                |29        15|14       12|11 0|
+	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
+	 * where there are 15 bits to store the buffer index.
+	 * Depending on PAGE_SHIFT value we can have fewer bits to store the buffer index.
+	 */
+	off = vb->index << PLANE_INDEX_SHIFT;
 
 	for (plane = 0; plane < vb->num_planes; ++plane) {
-		vb->planes[plane].m.offset = off;
+		vb->planes[plane].m.offset = off + (plane << PAGE_SHIFT);
 
 		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
 				vb->index, plane, off);
-
-		off += vb->planes[plane].length;
-		off = PAGE_ALIGN(off);
 	}
 }
 
@@ -2185,13 +2193,12 @@ int vb2_core_streamoff(struct vb2_queue *q, unsigned int type)
 EXPORT_SYMBOL_GPL(vb2_core_streamoff);
 
 /*
- * __find_plane_by_offset() - find plane associated with the given offset off
+ * __find_plane_by_offset() - find video buffer and plane associated with the given offset off
  */
 static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
-			unsigned int *_buffer, unsigned int *_plane)
+			struct vb2_buffer **vb, unsigned int *plane)
 {
-	struct vb2_buffer *vb;
-	unsigned int buffer, plane;
+	unsigned int buffer;
 
 	/*
 	 * Sanity checks to ensure the lock is held, MEMORY_MMAP is
@@ -2209,24 +2216,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
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
+	buffer = (off >> PLANE_INDEX_SHIFT) & BUFFER_INDEX_MASK;
+	*plane = (off >> PAGE_SHIFT) & PLANE_INDEX_MASK;
 
-		for (plane = 0; plane < vb->num_planes; ++plane) {
-			if (vb->planes[plane].m.offset == off) {
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
@@ -2306,7 +2304,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 {
 	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer = 0, plane = 0;
+	unsigned int plane = 0;
 	int ret;
 	unsigned long length;
 
@@ -2335,12 +2333,10 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, off, &buffer, &plane);
+	ret = __find_plane_by_offset(q, off, &vb, &plane);
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
-
 	/*
 	 * MMAP requires page_aligned buffers.
 	 * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
@@ -2368,7 +2364,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	dprintk(q, 3, "buffer %d, plane %d successfully mapped\n", buffer, plane);
+	dprintk(q, 3, "buffer %u, plane %d successfully mapped\n", vb->index, plane);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vb2_mmap);
@@ -2382,7 +2378,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 {
 	unsigned long off = pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer, plane;
+	unsigned int plane;
 	void *vaddr;
 	int ret;
 
@@ -2392,12 +2388,10 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, off, &buffer, &plane);
+	ret = __find_plane_by_offset(q, off, &vb, &plane);
 	if (ret)
 		goto unlock;
 
-	vb = q->bufs[buffer];
-
 	vaddr = vb2_plane_vaddr(vb, plane);
 	mutex_unlock(&q->mmap_lock);
 	return vaddr ? (unsigned long)vaddr : -EINVAL;
-- 
2.39.2

