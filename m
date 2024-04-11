Return-Path: <linux-kernel+bounces-140797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5264F8A1965
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F3B23EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B456B9C;
	Thu, 11 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1PXuvIjS"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D684F88B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849559; cv=none; b=h7AUkMVbLQ6rnr/Fd/bcUSLtRBOUbPqzny4f3BqxDZxrYkR+1bBViv78MaaqNRAGM6Ygg3Gzq2c8WGuvUSn+eaB7e2LD2+BrfA7de1yGXJgXUXT4lg0c83kx7PwjCgCAMgXzdE05Tq3iJCm2mhGD+pKTQE4KDR20UWppGUvdccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849559; c=relaxed/simple;
	bh=3yiypp7otTzShQxGZK3EPCdcJ6oDNIfGmBaTPZXo9zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDM6Z1Yw5c2aX77blBBoTDzGS4fTZfOgUArg3svQZqCovc9+dlw0ahSmCbnoxyl646OkrD2wkhFQddQRJvu62I0T23shqwF2QJnlL9aD1sYrEHvFPxJ8xoliYP5wHAehFEdgZFMSnvwJ1ulvUaddpRBoPxMQINrGykFnkrPPDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1PXuvIjS; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9709839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849556; x=1713454356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vso8h9KUTJRTgUc+rRfjD5CMC6cf/TiJgMh+jZVwjns=;
        b=1PXuvIjStgUmHsqYZJc8RbDo/3ffgfpi2YE/zeVivF788pDvCiBnHubE29i6gR9ZFT
         RLLTDPYSUSPCVLuf6TD1qq8I6hvAVzGcl2Qh6pDkWLSfe+csijekdbl9644rqjPyWD0l
         /+dKDSCY/ODGnWyQ6JCbT6cEBb/azy8/GK3z8+mtHN9IB/q2uehLwbcYuEPsq8UnLnY6
         cjgmVw17V8K45Qyvce0TayhQK8pkw8D8Fuk/RB4/lxErYnz1j5hbJDjOen7e84NxtbaA
         n7UBufq+nFeCP9gVo9jJI74AkBT3vGSCwxXDwuScqC2+00pAhFNtaYspGEj5+homlHyt
         7bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849556; x=1713454356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vso8h9KUTJRTgUc+rRfjD5CMC6cf/TiJgMh+jZVwjns=;
        b=D9D3vz4Zvlh8a5My0xKhVSHSrYzkg4cUhMH3DzrgBu8pmegq4rj/U/WhkplQHCfhVk
         UqQLIYCN7FHP7BuEA0GhluXeE9TBqPnQsmf13AI57CK3Bf4dzo5RzKgjcLzbJfKG3PrP
         oOfl6ZwZrOzvwofLHCg6XAAHTSL9NeN/Y6bbnWrImYm+gfMrx4ABfKHNFpW47Q8xiEOW
         lorbbOkTB9Pa5kt5yk4/VOlaM5hYAKT35fCms2Utmbmlc7jImcEtvpPOjAkDejdgY7OL
         qVV9y3daHgmdzAvy1PUKLy1vSqxIbKMgD+VnMk8lEdsmD7EBwHq9LMe0FIp+Dnf8jmvd
         NEEA==
X-Gm-Message-State: AOJu0Yw3qYaYD7jHwTpk71YAE1w0FdaFxdR1LD7UNQYYxw0beiDjaHtr
	EEcw0eKVFRvkFSt3lnJgin80bX/6IzrHhnIT5K/xPdlMQCaae2Rdoo76jwVjZqUWx0CBe/3bp9A
	s
X-Google-Smtp-Source: AGHT+IF+HMTVNXvgvXM2D2YpD+MTeyJF5uqKesoFwvBiGGxVVUHh8+bQiyQuzu3J27YCCafN3/TlmA==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr32373iob.2.1712849556067;
        Thu, 11 Apr 2024 08:32:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 039/437] libfs: switch to read iter and add copy helpers
Date: Thu, 11 Apr 2024 09:12:59 -0600
Message-ID: <20240411153126.16201-40-axboe@kernel.dk>
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
 fs/debugfs/file.c       | 44 +++++++++++++++++++++
 fs/libfs.c              | 87 +++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h | 25 +++++++++++-
 include/linux/fs.h      |  7 +++-
 4 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index c6ff9084bc0f..31749d8c35f8 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -468,6 +468,20 @@ ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_read);
 
+ssize_t debugfs_attr_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct dentry *dentry = F_DENTRY(iocb->ki_filp);
+	ssize_t ret;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+	ret = simple_attr_read_iter(iocb, to);
+	debugfs_file_put(dentry);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_read_iter);
+
 static ssize_t debugfs_attr_write_xsigned(struct file *file, const char __user *buf,
 			 size_t len, loff_t *ppos, bool is_signed)
 {
@@ -499,6 +513,36 @@ ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
 }
 EXPORT_SYMBOL_GPL(debugfs_attr_write_signed);
 
+static ssize_t debugfs_attr_write_iter_xsigned(struct kiocb *iocb,
+					       struct iov_iter *from,
+					       bool is_signed)
+{
+	struct dentry *dentry = F_DENTRY(iocb->ki_filp);
+	ssize_t ret;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+	if (is_signed)
+		ret = simple_attr_write_iter_signed(iocb, from);
+	else
+		ret = simple_attr_write_iter(iocb, from);
+	debugfs_file_put(dentry);
+	return ret;
+}
+
+ssize_t debugfs_attr_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return debugfs_attr_write_iter_xsigned(iocb, from, false);
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_write_iter);
+
+ssize_t debugfs_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from)
+{
+	return debugfs_attr_write_iter_xsigned(iocb, from, true);
+}
+EXPORT_SYMBOL_GPL(debugfs_attr_write_iter_signed);
+
 static struct dentry *debugfs_create_mode_unsafe(const char *name, umode_t mode,
 					struct dentry *parent, void *value,
 					const struct file_operations *fops,
diff --git a/fs/libfs.c b/fs/libfs.c
index 074cfacc377f..90f79113e48b 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1365,6 +1365,93 @@ ssize_t simple_attr_read(struct file *file, char __user *buf,
 }
 EXPORT_SYMBOL_GPL(simple_attr_read);
 
+/* read from the buffer that is filled with the get function */
+ssize_t simple_attr_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct simple_attr *attr;
+	size_t size;
+	ssize_t ret;
+
+	attr = iocb->ki_filp->private_data;
+
+	if (!attr->get)
+		return -EACCES;
+
+	ret = mutex_lock_interruptible(&attr->mutex);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_pos && attr->get_buf[0]) {
+		/* continued read */
+		size = strlen(attr->get_buf);
+	} else {
+		/* first read */
+		u64 val;
+		ret = attr->get(attr->data, &val);
+		if (ret)
+			goto out;
+
+		size = scnprintf(attr->get_buf, sizeof(attr->get_buf),
+				 attr->fmt, (unsigned long long)val);
+	}
+
+	ret = simple_copy_to_iter(attr->get_buf, &iocb->ki_pos, size, to);
+out:
+	mutex_unlock(&attr->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(simple_attr_read_iter);
+
+static ssize_t __simple_write_iter(struct kiocb *iocb, struct iov_iter *from,
+				   bool is_signed)
+{
+	struct simple_attr *attr;
+	unsigned long long val;
+	size_t len = iov_iter_count(from);
+	size_t size;
+	ssize_t ret;
+
+	attr = iocb->ki_filp->private_data;
+	if (!attr->set)
+		return -EACCES;
+
+	ret = mutex_lock_interruptible(&attr->mutex);
+	if (ret)
+		return ret;
+
+	ret = -EFAULT;
+	size = min(sizeof(attr->set_buf) - 1, len);
+	if (!copy_from_iter(attr->set_buf, size, from))
+		goto out;
+
+	attr->set_buf[size] = '\0';
+	if (is_signed)
+		ret = kstrtoll(attr->set_buf, 0, &val);
+	else
+		ret = kstrtoull(attr->set_buf, 0, &val);
+	if (ret)
+		goto out;
+	ret = attr->set(attr->data, val);
+	if (ret == 0)
+		ret = len; /* on success, claim we got the whole input */
+out:
+	mutex_unlock(&attr->mutex);
+	return ret;
+}
+
+ssize_t simple_attr_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	return __simple_write_iter(iocb, from, false);
+}
+EXPORT_SYMBOL_GPL(simple_attr_write_iter);
+
+ssize_t simple_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from)
+
+{
+	return __simple_write_iter(iocb, from, true);
+}
+EXPORT_SYMBOL_GPL(simple_attr_write_iter_signed);
+
 /* interpret the buffer as a number to call the set function with */
 static ssize_t simple_attr_write_xsigned(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos, bool is_signed)
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ad417d079ec9..c6d189059d3d 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -55,8 +55,8 @@ static const struct file_operations __fops = {				\
 	.owner	 = THIS_MODULE,						\
 	.open	 = __fops ## _open,					\
 	.release = simple_attr_release,					\
-	.read	 = debugfs_attr_read,					\
-	.write	 = (__is_signed) ? debugfs_attr_write_signed : debugfs_attr_write,	\
+	.read_iter = debugfs_attr_read_iter,				\
+	.write_iter= (__is_signed) ? debugfs_attr_write_iter_signed : debugfs_attr_write_iter,	\
 	.llseek  = no_llseek,						\
 }
 
@@ -106,10 +106,13 @@ void debugfs_file_put(struct dentry *dentry);
 
 ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 			size_t len, loff_t *ppos);
+ssize_t debugfs_attr_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t debugfs_attr_write(struct file *file, const char __user *buf,
 			size_t len, loff_t *ppos);
+ssize_t debugfs_attr_write_iter(struct kiocb *iocb, struct iov_iter *from);
 ssize_t debugfs_attr_write_signed(struct file *file, const char __user *buf,
 			size_t len, loff_t *ppos);
+ssize_t debugfs_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from);
 
 struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, const char *new_name);
@@ -271,6 +274,12 @@ static inline ssize_t debugfs_attr_read(struct file *file, char __user *buf,
 	return -ENODEV;
 }
 
+static inline ssize_t debugfs_attr_read_iter(struct kiocb *iocb,
+					     struct iov_iter *to)
+{
+	return -ENODEV;
+}
+
 static inline ssize_t debugfs_attr_write(struct file *file,
 					const char __user *buf,
 					size_t len, loff_t *ppos)
@@ -278,6 +287,12 @@ static inline ssize_t debugfs_attr_write(struct file *file,
 	return -ENODEV;
 }
 
+static inline ssize_t debugfs_attr_write_iter(struct kiocb *iocb,
+					      struct iov_iter *from)
+{
+	return -ENODEV;
+}
+
 static inline ssize_t debugfs_attr_write_signed(struct file *file,
 					const char __user *buf,
 					size_t len, loff_t *ppos)
@@ -285,6 +300,12 @@ static inline ssize_t debugfs_attr_write_signed(struct file *file,
 	return -ENODEV;
 }
 
+static inline ssize_t debugfs_attr_write_iter_signed(struct kiocb *iocb,
+						     struct iov_iter *from)
+{
+	return -ENODEV;
+}
+
 static inline struct dentry *debugfs_rename(struct dentry *old_dir, struct dentry *old_dentry,
                 struct dentry *new_dir, char *new_name)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5806cea7a3ac..d15a79020efa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3528,8 +3528,8 @@ static const struct file_operations __fops = {				\
 	.owner	 = THIS_MODULE,						\
 	.open	 = __fops ## _open,					\
 	.release = simple_attr_release,					\
-	.read	 = simple_attr_read,					\
-	.write	 = (__is_signed) ? simple_attr_write_signed : simple_attr_write,	\
+	.read_iter = simple_attr_read_iter,				\
+	.write_iter = (__is_signed) ? simple_attr_write_iter_signed : simple_attr_write_iter,	\
 	.llseek	 = generic_file_llseek,					\
 }
 
@@ -3555,6 +3555,9 @@ ssize_t simple_attr_write(struct file *file, const char __user *buf,
 			  size_t len, loff_t *ppos);
 ssize_t simple_attr_write_signed(struct file *file, const char __user *buf,
 				 size_t len, loff_t *ppos);
+ssize_t simple_attr_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t simple_attr_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t simple_attr_write_iter_signed(struct kiocb *iocb, struct iov_iter *from);
 
 struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
-- 
2.43.0


