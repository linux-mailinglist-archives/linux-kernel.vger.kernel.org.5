Return-Path: <linux-kernel+bounces-140802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A98A1906
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 893FF282A27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DF5915C;
	Thu, 11 Apr 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OSR3VVAr"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E25823F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849565; cv=none; b=nAfKAaYq0rE966RmSIr/c+FCcVfdv0t99PbofzZIKQFdESfrTInl0eKs07/jzZtBfKWvYOlY42/EQ5aL1ZfRSBlVE+leMq4KkgXWAQ02d8oE5L2j3oFvd+Cxjyz+k5eWax8KpvaduTlANlnLpUYAc1NXgxNU97jSvgP6K3ANnrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849565; c=relaxed/simple;
	bh=RdbtLfH4DeUMpRjCbRrhxuDYt7VaoNjaVp5cEA9JnGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGjvkeMC12Y+WF2tLaGvvehKegpb62oWfoUomEQhywP4uO6Rw4XU18IGh7v5L9x1w0hN2AsHgqyOwkmlZIYr5CxMrAzEE1JsA2Elgs8dDvwYj6smnc59iSsk9Y3IfIpdMMBa6DCRTWfOoCfgGNbcryWGD7S6gU7FpkyoIi5TSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OSR3VVAr; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso57955139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849562; x=1713454362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMLMOZo3aCfjzVvHbnT0tkuBKVMN85MSasB72yxiozw=;
        b=OSR3VVAre10J/WJNsXCqDJ/mfGUObhIMDgYs7mUzN5o8rtyPdDhR67kKIt51XEIQpy
         4y4tG6e2sw24AF2J2Bb91eZEv9mMTM8t85SVgkAy8vtD173/690maOfCbZKqyrpAEVCF
         wX9UlWCXyjK3Xl3p2dCzXwJv23z/q4RqNkEga/jGl5sI4n8uolgMR9NdpvVDxQ4WjdWM
         3LJFMr8LCuwxGXa7qcA6b6WcrTMkhw6gzY4zOqE2slksaXK0iYpGduDaZ3dZV0yazPGm
         jRMQsaj6os2GKVR1KezXn46tX/lQRISk8eKP+dr8k6ZQVJpKLHKavEyG6J1e17yq/0ZV
         lnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849562; x=1713454362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMLMOZo3aCfjzVvHbnT0tkuBKVMN85MSasB72yxiozw=;
        b=vSeSHnvX4eMEmJvJ9I2N0bLqlR9rxxOpt979gbsBC047ILz/i7flVz1ly4y0SvgthA
         xgskW0M49m1ub5opXxjnYPLnmqaAiE47B7GE+qe0erE3mglVoQzsaJWPv61Yy2/M3XSk
         DYFFNBTbgtooCLXH4POkryyyh4FdmNvR6UpNCF/zhnIZLTeOvO7XrrNj3R5wB8EUgbvE
         1OlfMmG6aVx62VNZhUycWUn07sBGtpT1eBKe9oTH3cIgXZwdO5htJZAxgwg4mIFGWZYX
         s6TbSdZ8HXfVe3KHdPEvukKdnj6n41cf16FxiM03lJtLy0poP54icGZb4RJIwsL2KyRR
         iiEA==
X-Gm-Message-State: AOJu0Yz9S2CzTjdOEK+iHkgNXAsOqR3i71W7iupLvKtPupaJayh9hJNS
	UcGZ7UtJcS0VlfU0txObYDh0ebwZN5FTZd162cypwfK95UVS8+0LuLH0wX0c6BBChEOALN2IW3L
	3
X-Google-Smtp-Source: AGHT+IHUNnvfa4lKCsrW3de1MfgYIqXyI4ZKFkAdwJKch8d4iUlhw7EuKx8I6VXNBjDap4D/BeHh4Q==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr199357iog.0.1712849562393;
        Thu, 11 Apr 2024 08:32:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 042/437] ceph: convert read_dir handler to read_iter()
Date: Thu, 11 Apr 2024 09:13:02 -0600
Message-ID: <20240411153126.16201-43-axboe@kernel.dk>
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
 fs/ceph/dir.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0e9f56eaba1e..3397b24f9e1a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -2110,12 +2110,13 @@ static void ceph_d_prune(struct dentry *dentry)
  * read() on a dir.  This weird interface hack only works if mounted
  * with '-o dirstat'.
  */
-static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
-			     loff_t *ppos)
+static ssize_t ceph_read_dir(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	size_t size;
 	int left;
 	const int bufsize = 1024;
 
@@ -2147,13 +2148,13 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 				ci->i_rctime.tv_nsec);
 	}
 
-	if (*ppos >= dfi->dir_info_len)
+	if (iocb->ki_pos >= dfi->dir_info_len)
 		return 0;
-	size = min_t(unsigned, size, dfi->dir_info_len-*ppos);
-	left = copy_to_user(buf, dfi->dir_info + *ppos, size);
+	size = min_t(unsigned, iov_iter_count(to), dfi->dir_info_len-iocb->ki_pos);
+	left = copy_to_iter(dfi->dir_info + iocb->ki_pos, size, to);
 	if (left == size)
 		return -EFAULT;
-	*ppos += (size - left);
+	iocb->ki_pos += (size - left);
 	return size - left;
 }
 
@@ -2184,7 +2185,7 @@ unsigned ceph_dentry_hash(struct inode *dir, struct dentry *dn)
 
 WRAP_DIR_ITER(ceph_readdir) // FIXME!
 const struct file_operations ceph_dir_fops = {
-	.read = ceph_read_dir,
+	.read_iter = ceph_read_dir,
 	.iterate_shared = shared_ceph_readdir,
 	.llseek = ceph_dir_llseek,
 	.open = ceph_open,
-- 
2.43.0


