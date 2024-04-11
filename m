Return-Path: <linux-kernel+bounces-141063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322C98A1A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D671F2269C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6C1D36FC;
	Thu, 11 Apr 2024 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n0WHij6j"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DD31D2A1E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849983; cv=none; b=CbEbHhK5uRLIqqsnqVTdxLuKVHLNJrsTlexdULIkeVvgkI3PDKtmxANezQySIrV7nSa4Jd0KA3J8awHzmkYRcJcxM903Zz/xjV9GzNGx8gll/QBm1C2swSmXcqQdA+6JXv0yE4jclDKsWal/65K5w/BK9TN8nxtn9IuU+doZ4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849983; c=relaxed/simple;
	bh=ES225KtuVoJ5i6v6nvtizWVMfFAa5TGb/0Yk5uukEPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r9n1ucvtgxKtEyPR6nh9TOBoc8yLc61XTygGwJ5LBI/YsYqUrcRCxuvXQOMO6XlDif/VsPXAU2fs1h/HjtDfbS2aOqxzpFTJrigrEzt8YQUfby1dXapmnS7PdnzTGIVj53rZxbLKI3AjnoTvobjWySiAt2y96xE0eBq5Hw/D2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n0WHij6j; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170583139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849980; x=1713454780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nLu7wpnWOLvM+s2AzprnSTFqRjsfhkfx2fTjpg7ngA=;
        b=n0WHij6je4wpMpzHb7A5vMzVc1l0h1v5QeJJZNviDy7eK9Xj/SLRKsy5Jyp9jXaVtM
         LkCSS7Nhbh9dydZQfsXcuBAmUXBOP5uVdsWUyYG0t7cVP5S2x2VlOoSPJphh56hevEJY
         uAgt0xWaC2QwKYYQw28AktFTaWKgs/ADFoCKRuJLa9fJL2wqdlY2PrlPYmeekvqNhvDs
         NbTVnZWekg2c7U/kCc5gWQtmzwzphJD8D/9EsubiYP4K+YltzhfrQmlOomMb3SV3KsJM
         g6HSL3/33Nz9iKsZzmPlbHd1frcGAaxhK9TnqJoB0HNlje4N4Q7HtOFbFV2tPGkD4pO/
         MILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849980; x=1713454780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nLu7wpnWOLvM+s2AzprnSTFqRjsfhkfx2fTjpg7ngA=;
        b=dtq8dCnBcT70KeXT3cVJTGLB93zSDiQnBfW0jqnDMC05go0NcMRmK1OlUOOtqulk5c
         9hnEiOSn6V0vpwsMIUcHLsAkPSJVGuu0VeY5MCzzQybyJpWd5kQ7gvNlcC11ppx2BTEm
         mDtdFIu4n8gA93P5Bd5//jnqQfpXRMVbDCb39hHa5+oJ/WVACcKpP6o74X6JTV31Y1go
         RjhFIz1f0P1WqvtBzKVns+54xLGEq6jx63DohNeLECja8r45y47gc92q9tUPlFz9VbQK
         QhGq2/bOJg0obZRSKJjtfbByE4fvKMb5wBXtJHXV+ZIOyTRcWYZ0Zidi4Ogr+Rcjpi6k
         EwvQ==
X-Gm-Message-State: AOJu0Yw8TDqSXaBGG1XnksgOqNLQjp2NDK2lK30bUHpGHBDcAQ2GyAMd
	eU+tgfNh4+mheIPYNp6/j4HSfAkEe6ct7k0fIz8wpXZ50GcP1eVPD15Y+PlWFLWU4+3+PmJC7K9
	X
X-Google-Smtp-Source: AGHT+IFKxP68b1/qavwsvg18NGRRbHieEwN3uZfjp4zvWzZzKwO/J4I5ASD4jVp8a+UNEuY2tJWbLQ==
X-Received: by 2002:a92:d352:0:b0:36a:1275:4aeb with SMTP id a18-20020a92d352000000b0036a12754aebmr5890513ilh.1.1712849980225;
        Thu, 11 Apr 2024 08:39:40 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 290/437] fs/ocfs2: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:10 -0600
Message-ID: <20240411153126.16201-291-axboe@kernel.dk>
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
 fs/ocfs2/cluster/netdebug.c | 11 ++++++-----
 fs/ocfs2/dlmfs/dlmfs.c      | 38 +++++++++++++++++--------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index fde10358c8ee..877955f35aef 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -468,17 +468,18 @@ static int o2net_debug_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t o2net_debug_read(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t o2net_debug_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(buf, nbytes, ppos, file->private_data,
-				       i_size_read(file->f_mapping->host));
+	struct file *file = iocb->ki_filp;
+
+	return simple_copy_to_iter(file->private_data, &iocb->ki_pos,
+				       i_size_read(file->f_mapping->host), to);
 }
 
 static const struct file_operations nodes_fops = {
 	.open		= nodes_fop_open,
 	.release	= o2net_debug_release,
-	.read		= o2net_debug_read,
+	.read_iter	= o2net_debug_read,
 	.llseek		= generic_file_llseek,
 };
 
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 7fc0e920eda7..a13b80cb11f1 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -28,6 +28,7 @@
 #include <linux/string.h>
 #include <linux/backing-dev.h>
 #include <linux/poll.h>
+#include <linux/uio.h>
 
 #include <linux/uaccess.h>
 
@@ -219,47 +220,42 @@ static __poll_t dlmfs_file_poll(struct file *file, poll_table *wait)
 	return event;
 }
 
-static ssize_t dlmfs_file_read(struct file *file,
-			       char __user *buf,
-			       size_t count,
-			       loff_t *ppos)
+static ssize_t dlmfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char lvb[DLM_LVB_LEN];
 
-	if (!user_dlm_read_lvb(file_inode(file), lvb))
+	if (!user_dlm_read_lvb(file_inode(iocb->ki_filp), lvb))
 		return 0;
 
-	return simple_read_from_buffer(buf, count, ppos, lvb, sizeof(lvb));
+	return simple_copy_to_iter(lvb, &iocb->ki_pos, sizeof(lvb), to);
 }
 
-static ssize_t dlmfs_file_write(struct file *filp,
-				const char __user *buf,
-				size_t count,
-				loff_t *ppos)
+static ssize_t dlmfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char lvb_buf[DLM_LVB_LEN];
-	int bytes_left;
-	struct inode *inode = file_inode(filp);
+	int copied;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 
 	mlog(0, "inode %lu, count = %zu, *ppos = %llu\n",
-		inode->i_ino, count, *ppos);
+		inode->i_ino, count, iocb->ki_pos);
 
-	if (*ppos >= DLM_LVB_LEN)
+	if (iocb->ki_pos >= DLM_LVB_LEN)
 		return -ENOSPC;
 
 	/* don't write past the lvb */
-	if (count > DLM_LVB_LEN - *ppos)
-		count = DLM_LVB_LEN - *ppos;
+	if (count > DLM_LVB_LEN - iocb->ki_pos)
+		count = DLM_LVB_LEN - iocb->ki_pos;
 
 	if (!count)
 		return 0;
 
-	bytes_left = copy_from_user(lvb_buf, buf, count);
-	count -= bytes_left;
+	copied = copy_from_iter(lvb_buf, count, from);
+	count -= copied;
 	if (count)
 		user_dlm_write_lvb(inode, lvb_buf, count);
 
-	*ppos = *ppos + count;
+	iocb->ki_pos += count;
 	mlog(0, "wrote %zu bytes\n", count);
 	return count;
 }
@@ -525,8 +521,8 @@ static const struct file_operations dlmfs_file_operations = {
 	.open		= dlmfs_file_open,
 	.release	= dlmfs_file_release,
 	.poll		= dlmfs_file_poll,
-	.read		= dlmfs_file_read,
-	.write		= dlmfs_file_write,
+	.read_iter	= dlmfs_file_read,
+	.write_iter	= dlmfs_file_write,
 	.llseek		= default_llseek,
 };
 
-- 
2.43.0


