Return-Path: <linux-kernel+bounces-54457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802A84AF7D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2C51C23372
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29C512B156;
	Tue,  6 Feb 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H7dsqrDZ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921012AAD6;
	Tue,  6 Feb 2024 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707206555; cv=none; b=AGMdyfJCk8D31dA33GgfINspoep19tC8daGnIbWcBVaMRmAn1HYfO7t0THr22htnrPCb3XydLWN+5bCR+REHBQjGEKc6ZqtTlVakIkQ7Q4oGhP2DsEsQmKWBgHDY6jpYP21dHphc0B+OpfWEmgxofQHTHdh57ZSj+3dtbFcx0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707206555; c=relaxed/simple;
	bh=AQHxJDxHKybI6Oypj2MDAORaS7KhOD0Zjids4metyrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jwJoDOmgSNX7KbR8cYH76oe+doEb5+cSFMAJBJUUQW1IuCEmFiCcPNLM8GlpVMnY2knlu1c4GmPumDpK/ZV6UwL565TGsMzTMxdUdDgiY5epsbJuqL9QJ+9UjfP91fI4SH3wvn9/GlWSkGDzA89r0sRAZ4whTED83mCOWFMpSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H7dsqrDZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707206546;
	bh=AQHxJDxHKybI6Oypj2MDAORaS7KhOD0Zjids4metyrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7dsqrDZ1+rK1UjFTCAMma+ggxJXdZesfw16ZQXhOzppQYKm8oZFePOfei2maOt8T
	 r9pqrAxpxQj8drKeXNVVmhU4Xo9kD1ZOBE6ZgxHzZTDj54p7voUBchOn2gRy1LtXxO
	 KQ/eJRtcfVICoOPmEDZvQW/9fWadbTLBZHpKQPeljJyJXQZ/+06SLDhMWKcJ20+ap3
	 /i7qYaAAKlAY9PPM+HQud5aeFLK47qFVSHy5s7BV0Sti42/D4t6LN0JueUiZRsz27e
	 fFr/Q77iuEHLiCHk6/JGXTHz9eTj6etdlbUnA1J+prXlQe2hkysBDAwQ1HdaRpVWxO
	 GqXoBNLEyqyGA==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A796D3780C21;
	Tue,  6 Feb 2024 08:02:25 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v19 1/9] media: videobuf2: Update vb2_is_busy() logic
Date: Tue,  6 Feb 2024 09:02:11 +0100
Message-Id: <20240206080219.11951-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
References: <20240206080219.11951-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not rely on the number of allocated buffers to know if the
queue is busy but on a flag set when at least buffer has been allocated
by REQBUFS or CREATE_BUFS ioctl.
The flag is reset when REQBUFS is called with count = 0 or the file
handle is closed.
This is needed because delete buffers feature will be able to remove
all the buffers from a queue while streaming so relying on the number
of allocated buffers in the queue won't be possible.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 19:
- Add q->is_busy = 0 in vb2_core_queue_release()
- Fix q->is_busy usage in vb2_core_reqbufs()
- Reword commit message.

 drivers/media/common/videobuf2/videobuf2-core.c | 4 ++++
 include/media/videobuf2-core.h                  | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b6bf8f232f48..d8b3c04cb3b5 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -854,6 +854,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		__vb2_queue_free(q, q_num_bufs);
 		mutex_unlock(&q->mmap_lock);
 
+		q->is_busy = 0;
 		/*
 		 * In case of REQBUFS(0) return immediately without calling
 		 * driver's queue_setup() callback and allocating resources.
@@ -966,6 +967,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 */
 	*count = allocated_buffers;
 	q->waiting_for_buffers = !q->is_output;
+	q->is_busy = 1;
 
 	return 0;
 
@@ -1091,6 +1093,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * to the userspace.
 	 */
 	*count = allocated_buffers;
+	q->is_busy = 1;
 
 	return 0;
 
@@ -2555,6 +2558,7 @@ void vb2_core_queue_release(struct vb2_queue *q)
 	__vb2_queue_free(q, vb2_get_num_buffers(q));
 	kfree(q->bufs);
 	q->bufs = NULL;
+	q->is_busy = 0;
 	mutex_unlock(&q->mmap_lock);
 }
 EXPORT_SYMBOL_GPL(vb2_core_queue_release);
diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
index 56719a26a46c..b317286a7b08 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -579,6 +579,7 @@ struct vb2_buf_ops {
  *		called since poll() needs to return %EPOLLERR in that situation.
  * @is_multiplanar: set if buffer type is multiplanar
  * @is_output:	set if buffer type is output
+ * @is_busy:	set if at least one buffer has been allocated at some time.
  * @copy_timestamp: set if vb2-core should set timestamps
  * @last_buffer_dequeued: used in poll() and DQBUF to immediately return if the
  *		last decoded buffer was already dequeued. Set for capture queues
@@ -644,6 +645,7 @@ struct vb2_queue {
 	unsigned int			waiting_in_dqbuf:1;
 	unsigned int			is_multiplanar:1;
 	unsigned int			is_output:1;
+	unsigned int			is_busy:1;
 	unsigned int			copy_timestamp:1;
 	unsigned int			last_buffer_dequeued:1;
 
@@ -1163,7 +1165,7 @@ static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
  */
 static inline bool vb2_is_busy(struct vb2_queue *q)
 {
-	return vb2_get_num_buffers(q) > 0;
+	return !!q->is_busy;
 }
 
 /**
-- 
2.40.1


