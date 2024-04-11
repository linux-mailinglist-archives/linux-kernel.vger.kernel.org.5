Return-Path: <linux-kernel+bounces-140950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDA08A19C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53895289B63
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57521C195;
	Thu, 11 Apr 2024 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dKXkxG40"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0221C176
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849807; cv=none; b=izRJBObfyfQDEfb9jGaPY/NfrVHMjTtkWtQor8c5pZZNWO94u2wrKPmNfegmUb6k2CBVfdc9PGHYqMGReNqfUYYlzV4CIZ4SXgvViYpDPIt/LxVOFie5/91C8fJA1AYWlp10uCruHvRfVssTd6WAfIjEv3DAMFH0kWQ2ZHCtvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849807; c=relaxed/simple;
	bh=frauEX6INwklrIHCsDw9vLd8RU5x+j5aNf+GKbFJXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7cDgNCbd1dehAQhToe2zizUM8DmwQOOFU/vLRcHhjBUY3IBC3gGFvzTcbeU1XKPA1yl7RWF079/aklGg6gA2FpunTmPQSRm0uhFXEEj36ETQuPQxJsKI9xOjbL4wXu8BV91qVKq83Nff+tjvtMsr5ZBh49rcyUUXZMg2h2OMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dKXkxG40; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a224d7414so184305ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849805; x=1713454605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uI5YkKJPy4+kmr48OtjUmofeu6Ns753KwID6IxcYoc=;
        b=dKXkxG40KJ6X0bRsVbZyNF9PnTw8mMf4WzgrYTHtKyUHAM4zJI3gPKKMcYGD68bIDR
         nck11ZkoCO1CqjAclPPLn0mCKr/XXvRmusf2+yqmYqowi4/9Jc+8okjFUQ03gcdvbxI3
         yctjHkcLITpveAgsZa72CR83/M29c/gCGJb8EcCs8oxblESyjf4M+/nxCKIb6Dz8UO2d
         qRkqeHEcewM3ab9Ogi2QY4xXoyCdrWhdrrMYsNgUvAV8cSxXgS/qde5U6P3fvCp7YQle
         4mRprx+lVyQkxvQEFiUNnmKjAvagwL6pBaiD9VnZNAB8m2DtXUZkh6lAzcKXeAgyb57z
         6kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849805; x=1713454605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uI5YkKJPy4+kmr48OtjUmofeu6Ns753KwID6IxcYoc=;
        b=ul67DnjrxeLfM8VhwKBhBStmragdlnLJMA4YxmNl5SJUFSxulCnKIs+tegRGkPtghp
         edOc4K22UFD/9pg3JrzZVoRNch1uYd5Ak8n3hPEzn/d95nGLAkj3qZ6M+jvAdIsbuLfw
         A+EF+Jb3+Hm6zFiaPH4XAhXh2wPKPAwHudXU9XcJN0RwWd0h9xM6rfER221coH5aTABa
         /9UBEzUng9fhF/KezNgfDD1tMr7kj5/wS8t7EuVgu+B2CtZy+yUC6at/zg35pLO99W7j
         gq1fHynqUgbjtTz02YJekhdJSZhaj3mTvcF0metJj49JbAgtNMQegY7f4EqPOfLzczu3
         KS4A==
X-Gm-Message-State: AOJu0Yyq74VDVDyMy/uV0j99PhqJ+lh7arL4ww8+vo0w+dBvjIDg4BDS
	sHrhyoPfnm6TXEwLmhlDIl0dZdOaNoh7d2z+C/Z3FlyekbPOfZq6y3aoMpUc8zbMA+TdUy3X2Ch
	f
X-Google-Smtp-Source: AGHT+IFI4vGub9VJWXPqEfZniOHP9lopABuUTo+1W/ebIy1hezurAvbAJGuf6tb72MFY1skLkR/BZw==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr189481iob.0.1712849805058;
        Thu, 11 Apr 2024 08:36:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 181/437] drivers/ufs: convert to ->read_iter and ->write_iter
Date: Thu, 11 Apr 2024 09:15:21 -0600
Message-ID: <20240411153126.16201-182-axboe@kernel.dk>
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
 drivers/ufs/core/ufs-debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ufs/core/ufs-debugfs.c b/drivers/ufs/core/ufs-debugfs.c
index e3baed6c70bd..6f5116d024f3 100644
--- a/drivers/ufs/core/ufs-debugfs.c
+++ b/drivers/ufs/core/ufs-debugfs.c
@@ -157,17 +157,17 @@ static int ufs_saved_err_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static ssize_t ufs_saved_err_write(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t ufs_saved_err_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ufs_debugfs_attr *attr = file->f_inode->i_private;
-	struct ufs_hba *hba = hba_from_file(file);
+	struct ufs_debugfs_attr *attr = iocb->ki_filp->f_inode->i_private;
+	struct ufs_hba *hba = hba_from_file(iocb->ki_filp);
+	size_t count = iov_iter_count(from);
 	char val_str[16] = { };
 	int val, ret;
 
 	if (count > sizeof(val_str))
 		return -EINVAL;
-	if (copy_from_user(val_str, buf, count))
+	if (!copy_from_iter_full(val_str, count, from))
 		return -EFAULT;
 	ret = kstrtoint(val_str, 0, &val);
 	if (ret < 0)
@@ -196,8 +196,8 @@ static int ufs_saved_err_open(struct inode *inode, struct file *file)
 static const struct file_operations ufs_saved_err_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ufs_saved_err_open,
-	.read		= seq_read,
-	.write		= ufs_saved_err_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= ufs_saved_err_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


