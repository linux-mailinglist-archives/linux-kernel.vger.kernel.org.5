Return-Path: <linux-kernel+bounces-140838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFF8A19CC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF421B27999
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435FA131725;
	Thu, 11 Apr 2024 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xo6Lu4k1"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C92130A40
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849635; cv=none; b=HxyYbUMZPNNpquxnpuT08DkjbXAwbvQRkd5qFFfzlNAq+uPNxOIdgQuzGDgt+ocf31827Alzcnb+nicQds0pWD6msPdjQNDidNREdv79MoC1kWrijyjuHHTXlQNwmdiPo0MpwqYkM/sxN85SH/oidPZkgNe5e+OuIq5YxsaBnns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849635; c=relaxed/simple;
	bh=W3k6/FXevE8wDAMCp42FxIbGXgHu5v0EESnQHOknpbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kffaLNlRJfIHu7IGsWUmwSH956dw2h+9+/Tl0gG+iKDMBkuRtDGJkJrHMtwQ3bTIsJfHGIpDz9tkUOFDQzxLKbWnni52Q8VxWczNfXDF2uJj/K2bjtq71DaIGiFyABvTJRhVC2Vj5RjOdS1tLH+8hCL+27YBTVimPll5PBjZIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xo6Lu4k1; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a224d7414so178515ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849633; x=1713454433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL+hkzCgNGfdZd8isDHnQ3Z6spDtusW+FGPl5GpAvYw=;
        b=xo6Lu4k1V0v5XpLkCso2L2a78JW1zT5st2S5/pJTuSB2x8cdFPky/HDP47IDm9GwTw
         63RUkR4YTvmYsi2AbHbXhFKBh8lbW62htXba+atXqlbQvrqEYHbIKxMEvDvRHOXymvz5
         CXNbfKDS7Pb6GXNhAR/DyukNkZ+PwjxRGt3a1xmMB4b0QepjHCxHeJQ3d158/mhLhl8l
         tFZxVNIYpH1GMrmgrHuYeY3FVZAC4VU8ad/HLPY3khru4w4hao2Lwc2NlxP3Awz7RyM/
         cjiFSlhDuGgQieVHaJRJGz9NUE/vXIrASVNElfLYwwLl10wp/AgnmqsDUUmD2I+wBwhJ
         8ujw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849633; x=1713454433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL+hkzCgNGfdZd8isDHnQ3Z6spDtusW+FGPl5GpAvYw=;
        b=qN9L0qcEdDV7+0sxlQGu4A7b36E0ah2vQZZQLC5bb2QCAKNEUcFRtaKjaT4k33m1Ub
         LH1rUJHmDUZiP3KhjhgVc/uy2c+Nu2afsCqjlWdhgh7ZT96R/fcwTImZFy8tsdVELM35
         rnOI9p6pCQBBCHSFzrFUEVqTXz6bgsHp5+QPAHpqTxYtar9WZkRUqdW6RIV1Kgl66yLx
         vwLj4G4NT2qNkwMRbTdrolSzUAtmik+TSE5dlMCZhXABk3wH3Reey19RroY7YHQWUCYt
         6+yW4Pdsh/MdKy1dSBvRWA9Xcw53WW6FD1VddQWymKeDmr6rBKVv/xmtvR1yix8DfItk
         r5Ig==
X-Gm-Message-State: AOJu0YzL3Tm20sfQo4UDVaqgZsuf9Faaj5EYzgkrl2esnC4dxc77LmHt
	nHoptP677Pg1d99cHzAJLBGpEN114C484E93GvIpGoZuRBKTMXeDzQOGcRzotIC1Jo094NnyJ6Q
	t
X-Google-Smtp-Source: AGHT+IFxntkksjVud7OjzO7PKdbesEEV20eEMNVSwdhb/K12oy7Hpz3H50erMbl+Clfr1XyHZ2WwKQ==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr182896iob.0.1712849633159;
        Thu, 11 Apr 2024 08:33:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 077/437] relay: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:37 -0600
Message-ID: <20240411153126.16201-78-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/relay.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index a8e90e98bf2c..d34f5b0e4e53 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1030,12 +1030,10 @@ static size_t relay_file_read_end_pos(struct rchan_buf *buf,
 	return end_pos;
 }
 
-static ssize_t relay_file_read(struct file *filp,
-			       char __user *buffer,
-			       size_t count,
-			       loff_t *ppos)
+static ssize_t relay_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct rchan_buf *buf = filp->private_data;
+	struct rchan_buf *buf = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	size_t read_start, avail;
 	size_t written = 0;
 	int ret;
@@ -1043,7 +1041,7 @@ static ssize_t relay_file_read(struct file *filp,
 	if (!count)
 		return 0;
 
-	inode_lock(file_inode(filp));
+	inode_lock(file_inode(iocb->ki_filp));
 	do {
 		void *from;
 
@@ -1058,27 +1056,25 @@ static ssize_t relay_file_read(struct file *filp,
 		avail = min(count, avail);
 		from = buf->start + read_start;
 		ret = avail;
-		if (copy_to_user(buffer, from, avail))
+		if (!copy_to_iter_full(from, avail, to))
 			break;
 
-		buffer += ret;
 		written += ret;
 		count -= ret;
 
 		relay_file_read_consume(buf, read_start, ret);
-		*ppos = relay_file_read_end_pos(buf, read_start, ret);
+		iocb->ki_pos = relay_file_read_end_pos(buf, read_start, ret);
 	} while (count);
-	inode_unlock(file_inode(filp));
+	inode_unlock(file_inode(iocb->ki_filp));
 
 	return written;
 }
 
-
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
 	.mmap		= relay_file_mmap,
-	.read		= relay_file_read,
+	.read_iter	= relay_file_read,
 	.llseek		= no_llseek,
 	.release	= relay_file_release,
 };
-- 
2.43.0


