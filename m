Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A627B0868
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjI0PgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjI0PgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:36:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272F19E;
        Wed, 27 Sep 2023 08:36:08 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:672:46bd:3ec7:6cdf])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EBD6660730F;
        Wed, 27 Sep 2023 16:36:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695828967;
        bh=MOk2KKodOqrhhN2jePaaGtM0G7JvZDpVcdwxnUt/ZJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duudKOIjodHd6k38tbvClz5wHtLPWCGD278/zPScVhrsRQeXDOAQpa0d9y/CVPziP
         RxDy9qXrCJ5aSslt/NmKI2dMnfj6Q2pgCeeS23td2bj2bQKvSwXXDCsYVliPNbMyVp
         BQs/c9iNcmASmnMvwMAXaFzsGvG9H9spKluyevFFaDH01Oao3kDe/qouXIyymIb3TN
         lDKdSSjzhSanFdrqfdKQ6A/2GRRYk1aPsbpQSRmWLzrbIRX5c0vAUrY3Uo9hHqj5rV
         XwAQOXIwlftxE2+MIfZ2VZR9+gAOU0oWDfcfqdy7OI00hYv21vDojPyBQY3cTToChp
         ru37KlmVjWXHA==
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
Subject: [PATCH v8 01/53] media: videobuf2: Rework offset 'cookie' encoding pattern
Date:   Wed, 27 Sep 2023 17:35:06 +0200
Message-Id: <20230927153558.159278-2-benjamin.gaignard@collabora.com>
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

Change how offset 'cookie' field value is computed to make possible
to use more buffers (up to 0x7fff)
With this encoding pattern we know the maximum number that a queue
could store so we can check ing at queue init time.
It also make easier and faster to find buffer and plane from using
the offset field.
Change __find_plane_by_offset() prototype to return the video buffer
itself rather than it index.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 74 +++++++++----------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index cf6727d9c81f..6eeddb3a01c7 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -31,6 +31,14 @@
 
 #include <trace/events/vb2.h>
 
+#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + 3)
+#define PLANE_INDEX_MASK	0x7
+#define BUFFER_INDEX_MASK	0x7fff
+
+#if PAGE_SHIFT != 12
+#error Expected PAGE_SHIFT to be 12
+#endif
+
 static int debug;
 module_param(debug, int, 0644);
 
@@ -358,21 +366,23 @@ static void __setup_offsets(struct vb2_buffer *vb)
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
+	 * - a buffer could have up to 8 planes.
+	 * - v4l2 mem2mem use bit 30 to distinguish between source and destination buffers.
+	 * - must be page aligned
+	 * That led to this bit mapping:
+	 * |30                |29        15|14       12|11 0|
+	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
+	 * where there are 15 bits to store buffer index.
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
 
@@ -2185,13 +2195,12 @@ int vb2_core_streamoff(struct vb2_queue *q, unsigned int type)
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
@@ -2209,24 +2218,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
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
@@ -2306,7 +2306,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 {
 	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer = 0, plane = 0;
+	unsigned int plane = 0;
 	int ret;
 	unsigned long length;
 
@@ -2335,12 +2335,10 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
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
@@ -2368,7 +2366,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	if (ret)
 		return ret;
 
-	dprintk(q, 3, "buffer %d, plane %d successfully mapped\n", buffer, plane);
+	dprintk(q, 3, "buffer %u, plane %d successfully mapped\n", vb->index, plane);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vb2_mmap);
@@ -2382,7 +2380,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 {
 	unsigned long off = pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
-	unsigned int buffer, plane;
+	unsigned int plane;
 	void *vaddr;
 	int ret;
 
@@ -2392,12 +2390,10 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
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

