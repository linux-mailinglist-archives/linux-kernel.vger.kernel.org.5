Return-Path: <linux-kernel+bounces-103498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B4487C04B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 529C91C210E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A007319F;
	Thu, 14 Mar 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="j/kf/jVr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539357175F;
	Thu, 14 Mar 2024 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430357; cv=none; b=QYo22JxYcvi6FKOT91FI1hTIvlrcTbK/v4GD9yMqibHooDN0xGa/Izups/GGZeVSDLTx/mNdzTKwiR66fO1P1BovqvU9p9O5Z2ojkoDbPOKBvVISJs6ANp5rXwrImDZoCpWPLfy+qhiJyWcRcLAEVI6f6fp7bGpANYgW+uLdd1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430357; c=relaxed/simple;
	bh=kghUcSURPBJoB0fmxL1r0Y9N1XZdT/r3cDKOOvYVX9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxjJl80ydDvHSUmf1KFtmgNmmXcCI37bD299bXlcFr1LIRyRQozgOxE0HbrWP2UDuhVc1fzgeuENcEFgjtmI5KHx4raErqqgJ9HHX11WaKidMWL0KoDosTboCn3k9IdM+viUGn0FqmVAon+xwNuGdHNWJinBG44xyfY410ET/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=j/kf/jVr; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710430353;
	bh=kghUcSURPBJoB0fmxL1r0Y9N1XZdT/r3cDKOOvYVX9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/kf/jVrjp7W2NII/rxpmOhKm8oAJ5alSNrSLUM1dPrOPrGAS9lTzjBU+b+uSFPjD
	 GlBl1UPD2sunY0CLxTT1nDRnzFPZNu5LlQEVa7hIBMIMMr+FSaMrncG1yxa/lWfmUx
	 L1njzmWkj7eIN/SiUc4GmfGbdTwaI2EJq7zhswG+BgmDtTuFx3PzYXeF1A1TjjSSET
	 KHEigPFabFHa0zuVgHEIYXuFJNFmnvW0t5/f6xoBZJsiPNCORrBR0ddFFYlvtVgmWg
	 M4R8uBrYqPOzbPZ4XrbnJ/OHIRaV06ImJaavEaRwCdvg+Nchsd44/ldZqYJ0w5hqQr
	 P5eTgB4Hd2kjg==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4B30037820F5;
	Thu, 14 Mar 2024 15:32:33 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: mchehab@kernel.org,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	hverkuil-cisco@xs4all.nl,
	nicolas@ndufresne.ca
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v21 1/9] media: videobuf2: Update vb2_is_busy() logic
Date: Thu, 14 Mar 2024 16:32:18 +0100
Message-Id: <20240314153226.197445-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
References: <20240314153226.197445-1-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not rely on the number of allocated buffers to know if the
queue is busy but on a flag set when at least one buffer has been allocated
by REQBUFS or CREATE_BUFS ioctl.
The flag is reset when REQBUFS is called with count = 0 or the file
handle is closed.
This is needed because remove buffers feature will be able to remove
all the buffers from a queue while streaming so relying on the number
of allocated buffers in the queue won't be possible.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
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
index 8b86996b2719..667bf9ee1101 100644
--- a/include/media/videobuf2-core.h
+++ b/include/media/videobuf2-core.h
@@ -582,6 +582,7 @@ struct vb2_buf_ops {
  *		released. Used to prevent destroying the queue by other threads.
  * @is_multiplanar: set if buffer type is multiplanar
  * @is_output:	set if buffer type is output
+ * @is_busy:	set if at least one buffer has been allocated at some time.
  * @copy_timestamp: set if vb2-core should set timestamps
  * @last_buffer_dequeued: used in poll() and DQBUF to immediately return if the
  *		last decoded buffer was already dequeued. Set for capture queues
@@ -647,6 +648,7 @@ struct vb2_queue {
 	unsigned int			waiting_in_dqbuf:1;
 	unsigned int			is_multiplanar:1;
 	unsigned int			is_output:1;
+	unsigned int			is_busy:1;
 	unsigned int			copy_timestamp:1;
 	unsigned int			last_buffer_dequeued:1;
 
@@ -1166,7 +1168,7 @@ static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
  */
 static inline bool vb2_is_busy(struct vb2_queue *q)
 {
-	return vb2_get_num_buffers(q) > 0;
+	return !!q->is_busy;
 }
 
 /**
-- 
2.40.1


