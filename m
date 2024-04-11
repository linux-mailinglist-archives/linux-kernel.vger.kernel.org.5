Return-Path: <linux-kernel+bounces-141220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D458A1B0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D8C1C20506
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A173A2049F5;
	Thu, 11 Apr 2024 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ib+G5sCN"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D8203580
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850228; cv=none; b=VsZC4VpqHWiEHCXsPhgVtdvARUj0zSWPBqSKnZJV1OROXOUBFWVV5AqwuuU4BiQ8CjM4WjLMbv0GP1sPmwvv308ff7jf59fbXXHX61Q5cBj/9GKYGgdphc9KSHH2oDhYn5g0zQjbC4Ri3+3DyywY57PX7tXq8HeXU1NUKyV9/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850228; c=relaxed/simple;
	bh=KhJyfYd8Vj9NqkmdKLW2WvZin9Gnn6ZH8dQq+N3KPTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHzzKZn5l+tfHBkwpd49bkDrQgHdm0E2ETG7CmEDJ3D3izZa0/G45/h5tNpMSDOnZT3VajmomMAAO7jZyxAqaJrUP6K1NCh+OUWJZoFfCkomo8agCAycf8SdILI5uxC/3vLqR3fU3wCmNnZ+NtfQebD1JkC0/baqIP/EUeGJo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ib+G5sCN; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9123239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850225; x=1713455025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtyNxOMSSlFtTrfa71viN3TkdB2q/uxCCkQxbxCUUkc=;
        b=Ib+G5sCNeauuc0XTOK09N59+SCaXmaNcjXwTstazfoAti/rNjD36B5+icMjKpgtXoj
         e/xlN5AWYeK/iFoQqFkdWWb368lREtgaRAUKMIp/aSGuzLJdKLlZ6dIgF3+iWO7Z8Qsv
         fnP5BeiVnGLDcWWH/ChqaEZGOKC1gjQqCVLYCY36hhDYZLDO1SGOFv3Yy1OpdRw+G6px
         3JR88TbjksKaDGCSrc27F2NzOIMhTfbN/g6KMDRNx4AE3nQf/jOxJ7+RHjzxBueFoRfz
         eNjFFnTr4PGHxpwD4zc5D0hB4BOH2bGwFPsr9vmTCeUcTbFOdfIvqnXH4Ikct4WGCrGG
         7gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850225; x=1713455025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtyNxOMSSlFtTrfa71viN3TkdB2q/uxCCkQxbxCUUkc=;
        b=Scg/deR0wNEJrIEXOtJCT/cFPpGxCKRKHOcz2aYUuRaMtPf6Mu5zBT616aFJqH1t2h
         L9uSoZ0jVrjtjOPXUAQeLvPaI5Ehc5PqLmCaZ9ItiToeDtwefatADu8KWPedKktnLI1L
         YNFsnLlJqbqKEzXgTvoSY295V4eyXypMAjU1BV7bcwEN1NOBhed79FlHlS4J6qDkOZ2Z
         RhY7//KTN7wSkhfUXBwfAn6lmcsyNi/VwPoDzY9JVQ33OWFbtUbXop0jx+fBBMkTglrj
         QSkxCqs26rz6UfF2puXKUlYSPeBj2/k8CybeHrgESLoNSeYFbIvUjK22auu9mKzUdQJp
         Ex6w==
X-Gm-Message-State: AOJu0YyLW+fwy8/dmXm+5ZDlAX1zLssIxf1tWHfsUWzwYcCrdDVZGRSy
	s6/wNiMn+wWeY2KTcTFDy4fjs9J1o5H7N9XZCF7nSvG8qJl8lGNnietr9NOGEUUAcJsok5fxicE
	D
X-Google-Smtp-Source: AGHT+IFqn5NePFYJdmb+LJ19j/v+WQ57/B1QlJWEIT+unE0XLACesxHPJ1AizA6tpmbwvrpuk5LiDA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr201491ioj.2.1712850225419;
        Thu, 11 Apr 2024 08:43:45 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 433/437] fs/debugfs: remove (now) dead non-iterator debugfs_attr functions
Date: Thu, 11 Apr 2024 09:19:33 -0600
Message-ID: <20240411153126.16201-434-axboe@kernel.dk>
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
 fs/debugfs/file.c       | 46 -----------------------------------------
 include/linux/debugfs.h |  6 ------
 2 files changed, 52 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 6463b4a274d4..9c8fe0834b2b 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -451,21 +451,6 @@ const struct file_operations debugfs_full_proxy_file_operations = {
 	.open = full_proxy_open,
 };
 
-ssize_t debugfs_attr_read(struct file *file, char __user *buf,
-			size_t len, loff_t *ppos)
-{
-	struct dentry *dentry = F_DENTRY(file);
-	ssize_t ret;
-
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-	ret = simple_attr_read(file, buf, len, ppos);
-	debugfs_file_put(dentry);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(debugfs_attr_read);
-
 ssize_t debugfs_attr_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct dentry *dentry = F_DENTRY(iocb->ki_filp);
@@ -480,37 +465,6 @@ ssize_t debugfs_attr_read_iter(struct kiocb *iocb, struct iov_iter *to)
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_read_iter);
 
-static ssize_t debugfs_attr_write_xsigned(struct file *file, const char __user *buf,
-			 size_t len, loff_t *ppos, bool is_signed)
-{
-	struct dentry *dentry = F_DENTRY(file);
-	ssize_t ret;
-
-	ret = debugfs_file_get(dentry);
-	if (unlikely(ret))
-		return ret;
-	if (is_signed)
-		ret = simple_attr_write_signed(file, buf, len, ppos);
-	else
-		ret = simple_attr_write(file, buf, len, ppos);
-	debugfs_file_put(dentry);
-	return ret;
-}
-
-ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
-			 size_t len, loff_t *ppos)
-{
-	return debugfs_attr_write_xsigned(file, buf, len, ppos, false);
-}
-EXPORT_SYMBOL_GPL(debugfs_attr_write);
-
-ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
-			 size_t len, loff_t *ppos)
-{
-	return debugfs_attr_write_xsigned(file, buf, len, ppos, true);
-}
-EXPORT_SYMBOL_GPL(debugfs_attr_write_signed);
-
 static ssize_t debugfs_attr_write_iter_xsigned(struct kiocb *iocb,
 					       struct iov_iter *from,
 					       bool is_signed)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index c6d189059d3d..7d08c0900b4c 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -104,14 +104,8 @@ const struct file_operations *debugfs_real_fops(const struct file *filp);
 int debugfs_file_get(struct dentry *dentry);
 void debugfs_file_put(struct dentry *dentry);
 
-ssize_t debugfs_attr_read(struct file *file, char __user *buf,
-			size_t len, loff_t *ppos);
 ssize_t debugfs_attr_read_iter(struct kiocb *iocb, struct iov_iter *to);
-ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
-			size_t len, loff_t *ppos);
 ssize_t debugfs_attr_write_iter(struct kiocb *iocb, struct iov_iter *from);
-ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
-			size_t len, loff_t *ppos);
 ssize_t debugfs_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from);
 
 struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
-- 
2.43.0


