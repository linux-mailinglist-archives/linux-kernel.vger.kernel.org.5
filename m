Return-Path: <linux-kernel+bounces-140829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337BA8A1923
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CCFC1C235AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2C85281;
	Thu, 11 Apr 2024 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZIIi5Tov"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3068614D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849619; cv=none; b=Q9sAe03I+SFRHFyzPTMHi3lyC9df3YIJI9ftyPiivblVLjFkiLOSo9XfnG3gu/I5TfxmRGmoZRxE7ynupoZ6ZQUQHhREy6mS/CzR15c3xi5xcsexB/qt0kprsZbKLGLGWs8JS8sI0GhAxGsQE4QxmATfCt4mMCOKBAaHB26kVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849619; c=relaxed/simple;
	bh=KAj7pDZG0DmdNRwN+S10mzI9/zwuOL7L3hdZnXrn7t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8o2kqDEVjL5Y1LbraEGrmhzwC1f9WrLj2sAqpMJ5z6a32HUK/t7yVXZckaAgRCZS4U+ZJ4tEAr3eFfTxiDNmEQk7vh8w8YAqHRWeAq0qGUZS0yHdUyINgbvNK2gQGSyPXgcm/6zc4FO8JU+OAwz7OUT7S0jSbs7cPLaBNRjbyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZIIi5Tov; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69517639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849617; x=1713454417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zkJeIQvic9FC53zPuVEYfcChN56JDTgqDlFAUUQXoE=;
        b=ZIIi5TovpVarzKle2OF9IAD1yxD2u0TBxtuEVTTSPaLqfoQUFqbIM3HYijK71tDC05
         SZh40whXoKqPVFVEs9Upu4iJ0OUNSMXhsOjJY05b7FrtVH2ulBc/I8Dmd7cc9HJTaBQD
         x2WyMMj7YORasVOb+h80uvXuJuVgGHBm21Qu/+mSBkMvckJ5CntIwNHw1XlagVcjAtw1
         NSqcGxZ2O7WAvvjk1OSB01y+NXS8+TQ/PJMMyCa8D8D99U567G7WPwXHToQyWelqzGel
         isVhCwffqlIoZKok908uxe7hOz2YY3xQGtmgEXEOgDaT4Pd188FMZAwOuimf6OVP+BZ4
         6PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849617; x=1713454417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zkJeIQvic9FC53zPuVEYfcChN56JDTgqDlFAUUQXoE=;
        b=H0AeCGLfMqN9ojou9FT/5xxo0rjaLYVcgBraUbEbTN26fTsA1tu6e04pdWxvtH6AfY
         y/PNRa5rmxPs7JzumVhhh5uemRpw/31lRCD5fTQocM4fNQ00+4U52YpJe9Kidwt0ona/
         p3WyXlf94dqSQWo4V7IyaCrc4+kXPL8G0U0z1E7ZT2dzNw99lxlm1gLwVocjECJCdq03
         /XnQe8y4qgg4+xL2o/iiqTC1/HEJYUX615jbYGWlSlw2FzPiwFh2f5Eo3kfLhSeN4bPD
         Hbxvao/oImXw5ow/STcEJa2d2YPgLqL7pLMlqJd/uWUfP6XqI3JVPFqV/In7QZqo7dFx
         7P6A==
X-Gm-Message-State: AOJu0YwhhvduU7/naPsgUbeDHLsMpCCVIJ0T+qXqc4x8jA7IRCzcVXqo
	PQD+0XMJUGu+L7GgCBMIPRaKKQcXFdKIaU8Vrog3VwSfHT3MCugGJVXEzHd46ja/Dtf7FtSD8kL
	F
X-Google-Smtp-Source: AGHT+IF8a+T4aVHFXaNmtkIHEfAOK89wsat9WzZ9Nu0ZVt3DXP93XJ5A5m6CjntFInTCNXn4EtrmHw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr208413iof.0.1712849617359;
        Thu, 11 Apr 2024 08:33:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 068/437] block: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:28 -0600
Message-ID: <20240411153126.16201-69-axboe@kernel.dk>
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
 block/blk-mq-debugfs.c | 20 ++++++++++----------
 block/blk-mq-debugfs.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 94668e72ab09..a9fa3d7311ac 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -119,9 +119,10 @@ static int queue_state_show(void *data, struct seq_file *m)
 	return 0;
 }
 
-static ssize_t queue_state_write(void *data, const char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t queue_state_write(void *data, struct kiocb *iocb,
+				 struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	struct request_queue *q = data;
 	char opbuf[16] = { }, *op;
 
@@ -137,7 +138,7 @@ static ssize_t queue_state_write(void *data, const char __user *buf,
 		goto inval;
 	}
 
-	if (copy_from_user(opbuf, buf, count))
+	if (!copy_from_iter_full(opbuf, count, from))
 		return -EFAULT;
 	op = strstrip(opbuf);
 	if (strcmp(op, "run") == 0) {
@@ -540,12 +541,11 @@ static int blk_mq_debugfs_show(struct seq_file *m, void *v)
 	return attr->show(data, m);
 }
 
-static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
-				    size_t count, loff_t *ppos)
+static ssize_t blk_mq_debugfs_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *m = file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	const struct blk_mq_debugfs_attr *attr = m->private;
-	void *data = d_inode(file->f_path.dentry->d_parent)->i_private;
+	void *data = d_inode(iocb->ki_filp->f_path.dentry->d_parent)->i_private;
 
 	/*
 	 * Attributes that only implement .seq_ops are read-only and 'attr' is
@@ -554,7 +554,7 @@ static ssize_t blk_mq_debugfs_write(struct file *file, const char __user *buf,
 	if (attr == data || !attr->write)
 		return -EPERM;
 
-	return attr->write(data, buf, count, ppos);
+	return attr->write(data, iocb, from);
 }
 
 static int blk_mq_debugfs_open(struct inode *inode, struct file *file)
@@ -591,8 +591,8 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations blk_mq_debugfs_fops = {
 	.open		= blk_mq_debugfs_open,
-	.read		= seq_read,
-	.write		= blk_mq_debugfs_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= blk_mq_debugfs_write,
 	.llseek		= seq_lseek,
 	.release	= blk_mq_debugfs_release,
 };
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 9c7d4b6117d4..22c65e5ff430 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -12,7 +12,7 @@ struct blk_mq_debugfs_attr {
 	const char *name;
 	umode_t mode;
 	int (*show)(void *, struct seq_file *);
-	ssize_t (*write)(void *, const char __user *, size_t, loff_t *);
+	ssize_t (*write)(void *, struct kiocb *, struct iov_iter *);
 	/* Set either .show or .seq_ops. */
 	const struct seq_operations *seq_ops;
 };
-- 
2.43.0


