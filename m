Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A557E6EC6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343985AbjKIQc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343930AbjKIQcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:32:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A6335B3;
        Thu,  9 Nov 2023 08:32:22 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA9FD660740E;
        Thu,  9 Nov 2023 16:32:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699547541;
        bh=QtxHfL0BQ7O0Rg3+MEqedQuzB2OKbyifYJESSd1Oirg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FU3HMmbcFXkQmBGHqr8VC4eM4ucYUSSu21QW19iVg+LvR5HWU2MwjELCE6KFK3yk+
         /3wPbwJuwvToxRfA8d1ojkWGbvIiFhSR/3O0gsrFC5Uw2M66RUZ3Y8HFYiRT+chsGc
         zmSXdESEbihywP8Hi0kbuwn8ja9YOeHupl/GQUWyxDS3X1kXFprDmjnIZO63M2BG7d
         F1r3veepsHw04LpsL0D/86lIpO3NUeV6QuVQIc4KkXKJiAQY+GOMWtJr161M8qkRS6
         bPFsf1G/4XF74xCX947hvug7xl3iCEAdYeU+3Iau4RWc0uI9cEkF0ya1I9BE9AhzF3
         p7FpltmH57dvg==
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
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: [PATCH v15 01/56] media: videobuf2: Rename offset parameter
Date:   Thu,  9 Nov 2023 17:29:13 +0100
Message-Id: <20231109163008.179152-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
References: <20231109163008.179152-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'off' parameter to 'offset' to clarify the code.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 .../media/common/videobuf2/videobuf2-core.c   | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 27aee92f3eea..e5fd7ff0dae6 100644
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
 
@@ -2185,10 +2185,10 @@ int vb2_core_streamoff(struct vb2_queue *q, unsigned int type)
 EXPORT_SYMBOL_GPL(vb2_core_streamoff);
 
 /*
- * __find_plane_by_offset() - find plane associated with the given offset off
+ * __find_plane_by_offset() - find plane associated with the given offset
  */
-static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
-			unsigned int *_buffer, unsigned int *_plane)
+static int __find_plane_by_offset(struct vb2_queue *q, unsigned long offset,
+				  unsigned int *_buffer, unsigned int *_plane)
 {
 	struct vb2_buffer *vb;
 	unsigned int buffer, plane;
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

