Return-Path: <linux-kernel+bounces-40017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDFF83D8D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAD51C26E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC614286;
	Fri, 26 Jan 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IXtyZgub"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000A8134A9;
	Fri, 26 Jan 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706266910; cv=none; b=oxqxY9Tf5nQW/FRT6TguKeZvgauQawtOeJvW2vMnPebJOOByNFo7Zq1zDYt6Fab7rKlfh8lR6pXLkSN4bZQG4qdfCi5TH5jqQlauelUSZY1bfscndrKLWlf2hjXM3brZQSV/H8TlQ6dXfz/h9iFncwh8NU5AhykG6zzBw4VNno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706266910; c=relaxed/simple;
	bh=pU7ADMC9W3X1II2U5vo0mdMm3TYxbo2cFp28xo0Dtu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEztv9iSgMVKJMGJNRJgat3Oj3MkwPV9AdMZ0wt89z3PF75XVZ2i2QQvT3/i2z7CMkctA0WrQU/Ls+XNLMo1kV8ON8GxXh5bXLgfjPehNW/MDifiIPgBy6h13vpNwbEhevNvGrAJWoEUqCFxKZoGveH5ug6Srffl6HKdoEWMIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IXtyZgub; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706266907;
	bh=pU7ADMC9W3X1II2U5vo0mdMm3TYxbo2cFp28xo0Dtu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXtyZgubZ4mT/Z2XpWBOmseONFLJb5nsg8VLZUw8SdeuiEuCklZ/iIr4rfGfjXWrd
	 1w6PbciaVNZNALFBqNnfzQLjxmLd84x9qBGkBjj0CKmn6ZNwVYvu+sFtFneZtoALOL
	 EYuQOZaFqCsKytKTPb4Ig3EZQVtunyQkDcZimdtC/WXs1VX4Vb2Ol6EHpCouifQAdx
	 qB+PGnxD+7EjRGdjymN3eGi6S9cr8194j0LX5gkdAF524O3w1yajBvxSWd7MIoQcBD
	 UneH9ws1hMfOfQ6ErY5laVikEOs97i5igyBey2bfipXXHiJhZyOYaltgdmUaqjV9wl
	 JBj6Q5m4P7dlQ==
Received: from benjamin-XPS-13-9310.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 142523782075;
	Fri, 26 Jan 2024 11:01:47 +0000 (UTC)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: hverkuil@xs4all.nl,
	mchehab@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v18 1/9] media: videobuf2: Update vb2_is_busy() logic
Date: Fri, 26 Jan 2024 12:01:33 +0100
Message-Id: <20240126110141.135896-2-benjamin.gaignard@collabora.com>
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

Do not rely on the number of allocated buffers to know if the
queue is busy but on flag set when at least buffer has been allocated
by REQBUFS or CREATE_BUFS ioctl.
The flag is reset when REQBUFS is called with count = 0 or close the
file handle.
This is needed because delete buffers feature will be able to remove
all the buffers from a queue while streaming so relying in the number
of allocated buffers in the queue won't be possible.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 6 +++++-
 include/media/videobuf2-core.h                  | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index b6bf8f232f48..8aa6057df581 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -858,8 +858,10 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 		 * In case of REQBUFS(0) return immediately without calling
 		 * driver's queue_setup() callback and allocating resources.
 		 */
-		if (*count == 0)
+		if (*count == 0) {
+			q->is_busy = 0;
 			return 0;
+		}
 	}
 
 	/*
@@ -966,6 +968,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
 	 */
 	*count = allocated_buffers;
 	q->waiting_for_buffers = !q->is_output;
+	q->is_busy = 1;
 
 	return 0;
 
@@ -1091,6 +1094,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum vb2_memory memory,
 	 * to the userspace.
 	 */
 	*count = allocated_buffers;
+	q->is_busy = 1;
 
 	return 0;
 
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


