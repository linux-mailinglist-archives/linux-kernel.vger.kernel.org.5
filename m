Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC467CC62C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjJQOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbjJQOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:48:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62820F0;
        Tue, 17 Oct 2023 07:48:05 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:7205:da49:a7e8:59f8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B879C66072F4;
        Tue, 17 Oct 2023 15:48:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697554084;
        bh=cMzVFA9/TUVo9VWr/5JcyqG4OOKgwWqTUUieq9IONwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XrGI6n38ElM1sagzjAvlEFoFUAILsXCAW2Yfr1v8qdtlh1wjEJVLJs33bknwHfNsx
         S8gMVrtR149KRLgRdQnZQ4lojxQJLrtAjsEz3/UmDqgLMfhMajPZbfR0FgJRP2IpfL
         3KzXLqfOQ8nP9C3bIt8ew9C/OF0iLStewmCu7MI0vGkEBXpIgZ2E7Ut5D+b5DztbwV
         rkDWXi60I/PzQql5yVtzM0wT4ajTESeD1NvybT/A0sjrYcNnTk/1qtpzicNVNuCUxB
         QGXFveJ/4z74xckcmzXszWfnk8lpjiW5qu2ferVLJWean+GP8kaejQWI9v+B4H+8tT
         ycVQ/2c4f+GsQ==
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
Subject: [PATCH v12 01/56] media: videobuf2: Rename offset parameter
Date:   Tue, 17 Oct 2023 16:47:01 +0200
Message-Id: <20231017144756.34719-2-benjamin.gaignard@collabora.com>
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

Rename 'off' parameter to 'offset' to clarify the code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 27aee92f3eea..a5e57affeb30 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -356,23 +356,23 @@ static void __setup_offsets(struct vb2_buffer *vb)
 {
 	struct vb2_queue *q = vb->vb2_queue;
 	unsigned int plane;
-	unsigned long off = 0;
+	unsigned long offset = 0;
 
 	if (vb->index) {
 		struct vb2_buffer *prev = q->bufs[vb->index - 1];
 		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
 
-		off = PAGE_ALIGN(p->m.offset + p->length);
+		offset = PAGE_ALIGN(p->m.offset + p->length);
 	}
 
 	for (plane = 0; plane < vb->num_planes; ++plane) {
-		vb->planes[plane].m.offset = off;
+		vb->planes[plane].m.offset = offset;
 
 		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
-				vb->index, plane, off);
+				vb->index, plane, offset);
 
-		off += vb->planes[plane].length;
-		off = PAGE_ALIGN(off);
+		offset += vb->planes[plane].length;
+		offset = PAGE_ALIGN(offset);
 	}
 }
 
@@ -2185,9 +2185,9 @@ int vb2_core_streamoff(struct vb2_queue *q, unsigned int type)
 EXPORT_SYMBOL_GPL(vb2_core_streamoff);
 
 /*
- * __find_plane_by_offset() - find plane associated with the given offset off
+ * __find_plane_by_offset() - find plane associated with the given offset
  */
-static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
+static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
 			unsigned int *_buffer, unsigned int *_plane)
 {
 	struct vb2_buffer *vb;
@@ -2218,7 +2218,7 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
 		vb = q->bufs[buffer];
 
 		for (plane = 0; plane < vb->num_planes; ++plane) {
-			if (vb->planes[plane].m.offset == off) {
+			if (vb->planes[plane].m.offset == offset) {
 				*_buffer = buffer;
 				*_plane = plane;
 				return 0;
@@ -2304,7 +2304,7 @@ EXPORT_SYMBOL_GPL(vb2_core_expbuf);
 
 int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 {
-	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
 	unsigned int buffer = 0, plane = 0;
 	int ret;
@@ -2335,7 +2335,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, off, &buffer, &plane);
+	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
 	if (ret)
 		goto unlock;
 
@@ -2380,7 +2380,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 				    unsigned long pgoff,
 				    unsigned long flags)
 {
-	unsigned long off = pgoff << PAGE_SHIFT;
+	unsigned long offset = pgoff << PAGE_SHIFT;
 	struct vb2_buffer *vb;
 	unsigned int buffer, plane;
 	void *vaddr;
@@ -2392,7 +2392,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
 	 * Find the plane corresponding to the offset passed by userspace. This
 	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
 	 */
-	ret = __find_plane_by_offset(q, off, &buffer, &plane);
+	ret = __find_plane_by_offset(q, offset, &buffer, &plane);
 	if (ret)
 		goto unlock;
 
-- 
2.39.2

