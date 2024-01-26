Return-Path: <linux-kernel+bounces-40020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231D83D8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1411F25247
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764E71AACB;
	Fri, 26 Jan 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N63pLaIx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E313AEC;
	Fri, 26 Jan 2024 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266912; cv=none; b=fxuht9Mk/X0J6ezYj0ntB3LO3iF/Vo0tEsyzDqll/O8yAjiTrV0QNX2in+4nWRSBr0DADqOW2Xp856wB+60N+U18XAdc1Z6h7wgtWBWZyGe9uxHguGwt11BMg0Tz32bWf9T45um6oAkU+bx+xF90U8IOqAeleZuXz54mNWzbTyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266912; c=relaxed/simple;
	bh=43p8p/DG5K2SsYzvP6oHFn1qGILWOgD1JX4pVxapidw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=isbJBzudZrMI+DZKMB7b+9EYUEf3FcJ8z1kCDaRUuWzoGM8Sos/QyPQHpwv73I/Z9M/etbxJyyEz9jNOl4ECxXMKNvLEWAklTWid5fw+HrojQOIeVagH+m/2kCyltN7nlz5gMHBFfMfYemZnBewmrG9qsKOONbcnBaVbdVBV5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N63pLaIx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266909;
	bh=43p8p/DG5K2SsYzvP6oHFn1qGILWOgD1JX4pVxapidw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N63pLaIxPkb0HNhYTdX/KRrBWDLyJzIbVNuLMdsYRRCJwmBc3T1IxMjCWir+yZu4y
	 cs9rGBrHArZoPxW3SqhbzdsLtjcXHlchGVanUDmpi/KTK9FgclAD7BamTQ29IW31rw
	 x45CeTVbD5HePjG4BUYjYB1LYTuc/GFhzlHrqFmV6qgkPXtAgCxloRpg9U7B4ER+Yp
	 pEP+9+H4BmJAAMn1fsv4AZsUMukvlNuOsAcPsCEt2NskLCMJLgA+avHLIG3YWL77aZ
	 rOZ5lFbgDM29jQT9ekSGrziVR1wYmTKHsYaLhjDnjkQ3ulln8+hrBb1ODYTdBdPSrT
	 9mhBbdm3sWibw==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A90AA3782081;
	Fri, 26 Jan 2024 11:01:48 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 4/9] media: core: Rework how create_buf index returned value is computed
Date: Fri, 26 Jan 2024 12:01:36 +0100
Message-Id: <20240126110141.135896-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
References: <20240126110141.135896-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When DELETE_BUFS will be introduced holes could created in bufs array.
To be able to reuse these unused indices reworking how create->index
is set is mandatory.
Let __vb2_queue_alloc() decide which first index is correct and
forward this to the caller.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 18:
- fix __vb2_queue_alloc() parameters descriptions.

 .../media/common/videobuf2/videobuf2-core.c    | 18 +++++++++++++-----
 .../media/common/videobuf2/videobuf2-v4l2.c    | 14 +++++++++-----
 include/media/videobuf2-core.h                 |  5 ++++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 85a56b7fcd4a..4114df79f8ad 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -442,12 +442,15 @@ static void vb2_queue_remove_buffer(struct vb2_buffer *vb)
  * __vb2_queue_alloc() - allocate vb2 buffer structures and (for MMAP type)
  * video buffer memory for all buffers/planes on the queue and initializes the
  * queue
+ * @first_index: index of the first created buffer, all newly allocated buffers
+ *		 have indices in the range [first_index..first_index+count-1]
  *
  * Returns the number of buffers successfully allocated.
  */
 static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 			     unsigned int num_buffers, unsigned int num_planes,
-			     const unsigned plane_sizes[VB2_MAX_PLANES])
+			     const unsigned int plane_sizes[VB2_MAX_PLANES],
+			     unsigned int *first_index)
 {
 	unsigned int q_num_buffers = vb2_get_num_buffers(q);
 	unsigned int buffer, plane;
@@ -461,6 +464,8 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 	num_buffers = min_t(unsigned int, num_buffers,
 			    q->max_num_buffers - q_num_buffers);
 
+	*first_index = q_num_buffers;
+
 	for (buffer = 0; buffer < num_buffers; ++buffer) {
 		/* Allocate vb2 buffer structures */
 		vb = kzalloc(q->buf_struct_size, GFP_KERNEL);
@@ -820,7 +825,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	unsigned int q_num_bufs = vb2_get_num_buffers(q);
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
 	bool non_coherent_mem = flags & V4L2_MEMORY_FLAG_NON_COHERENT;
-	unsigned int i;
+	unsigned int i, first_index;
 	int ret = 0;
 
 	if (q->streaming) {
@@ -908,8 +913,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers =
-		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes);
+		__vb2_queue_alloc(q, memory, num_buffers, num_planes, plane_sizes, &first_index);
 	if (allocated_buffers == 0) {
+		/* There shouldn't be any buffers allocated, so first_index == 0 */
+		WARN_ON(first_index);
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
 		goto error;
@@ -983,7 +990,8 @@ EXPORT_SYMBOL_GPL(vb2_core_reqbufs);
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[])
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index)
 {
 	unsigned int num_planes = 0, num_buffers, allocated_buffers;
 	unsigned plane_sizes[VB2_MAX_PLANES] = { };
@@ -1045,7 +1053,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 
 	/* Finally, allocate buffers and video memory */
 	allocated_buffers = __vb2_queue_alloc(q, memory, num_buffers,
-				num_planes, plane_sizes);
+				num_planes, plane_sizes, first_index);
 	if (allocated_buffers == 0) {
 		dprintk(q, 1, "memory allocation failed\n");
 		ret = -ENOMEM;
diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index c575198e8354..03e8080a68a8 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -795,11 +795,15 @@ int vb2_create_bufs(struct vb2_queue *q, struct v4l2_create_buffers *create)
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
+	return vb2_core_create_bufs(q, create->memory,
+				    create->flags,
+				    &create->count,
+				    requested_planes,
+				    requested_sizes,
+				    &create->index);
 }
 EXPORT_SYMBOL_GPL(vb2_create_bufs);
 
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index ef5500d14c09..2a9ca70e99c7 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -823,6 +823,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
  * @count: requested buffer count.
  * @requested_planes: number of planes requested.
  * @requested_sizes: array with the size of the planes.
+ * @first_index: index of the first created buffer, all allocated buffers have
+ *		 indices in the range [first_index..first_index+count-1]
  *
  * Videobuf2 core helper to implement VIDIOC_CREATE_BUFS() operation. It is
  * called internally by VB2 by an API-specific handler, like
@@ -839,7 +841,8 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 			 unsigned int flags, unsigned int *count,
 			 unsigned int requested_planes,
-			 const unsigned int requested_sizes[]);
+			 const unsigned int requested_sizes[],
+			 unsigned int *first_index);
 
 /**
  * vb2_core_prepare_buf() - Pass ownership of a buffer from userspace
-- 
2.40.1


