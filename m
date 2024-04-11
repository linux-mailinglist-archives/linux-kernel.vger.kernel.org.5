Return-Path: <linux-kernel+bounces-140896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8708A1974
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8301B287A1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FC015CD6D;
	Thu, 11 Apr 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1C2cQaaa"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D515B98A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849725; cv=none; b=CiTkkvWlcN+NLj+lL5FL2F1GC1U+LHZ9FNLLYUS5tWzdKKz/D2DQ7IunYV6wTr/UqpN4YYaTzCowVo0+Z6UDZrABpqV5aZKkA1OWixjk7CjsO1Is8dpACoxXXSOrS7hhU2l/KxhpUkdUadIj4TUrB/nomvlxgm09eXxQ7SEAzks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849725; c=relaxed/simple;
	bh=ciIYPNXNl+LNo14DX+APzHybObo5YmU7vfmUoXqh4Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb6rCB8aKamP/d8x2Ak9Q3ZisJwYP0fnmHaPKjzI4nqfjtloNJZgYhpz3akvILcJY9ixZ64lA02gGtA0xxHSbvCI15WgwM8WX9gzqQNBkesbamxSZk5pMT2V1s+BQ319Tzu/HbGfa9ZaWQLiVC87OEcxGtoDkUMO0tNJ13WbDhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1C2cQaaa; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69553539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849723; x=1713454523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO0uhGFATJkkYVGDUegCBXfMVm99pjVyPXsWEr7rmNo=;
        b=1C2cQaaaLCKlZV2QD7fyjOtnOLraeXZnuLKyMXG06ET7O9WeQKG63Ot6S6gq7Yv4b5
         3boFtSKxof7zaed5CgrPA9GKjfDbwL4/Y1QvIfgvFTvtSNq6q3Q0QS9XuFHj7VZb4gI6
         TWalUhjZr+KWL3Z3CgqoXeVvB7TMrtVZxA0xSR+2cu72UXMl0SogzotKB6NAMoEhhAiO
         FGq39qcJGWB84rrZpbwhrTndCw7HuyDD3AGctUaJ1Nin1X6g11CuqUfq3AQ2aH+vG2A1
         54C8xcfpTmatQngKLb3Jrxw4y1lBQQ0Jo5V+jtRuvmVZ010NgSEIMRhvghCctpYVTBCE
         q8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849723; x=1713454523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO0uhGFATJkkYVGDUegCBXfMVm99pjVyPXsWEr7rmNo=;
        b=q/wG+rZ4Dd2Ijjy/chkiS7azT+G16r7xgkIKriW7xH++UeRBl/mLwZdofRGWbFxT5w
         VEt2+cIeWP07cH6knfaW91F6mdUKNG0Krrb6R0viK5HawWJ3YB3jfrJTKRcYu34Xjyl+
         09KN1Zsw+cV07Q/zCMRCWrj8uCwn8UFwzHWeAhbTlZiJCMzm2JCiWtzNfCkJ8KmaTP7I
         LZvo/vjoyYqQg9luLU4DkVtqnmw/YpcyTeEfvfIlOhGD1XKGXz+MxVFniHY7Tpsv3ZXd
         S0zBw0oW+03AxGjChj2FUKDBRwbGxhKsuvdPmV2GfOBylbbzYLmOFkyQVwPeWZHp1twS
         r78g==
X-Gm-Message-State: AOJu0Yyp+z/A61xD5M9Rcmv+XTvx3Kib/SC4VO+e4fgNLrIEcvK54Vtb
	s1ENJ1I3nARByvDGGkvKzyNsIXSCUxY0EScpougvm1LjZ3VwCWcsDqMsGFTTFC+wMe37d8hivew
	x
X-Google-Smtp-Source: AGHT+IFChSn5oExubJ4WGSQzj3594XIuuuUAzzTt2pxQKRMDoj1tVAPDxyqyJIq9CfodLYWocOfWmQ==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr39389iob.2.1712849723092;
        Thu, 11 Apr 2024 08:35:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 132/437] drivers/base: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:32 -0600
Message-ID: <20240411153126.16201-133-axboe@kernel.dk>
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
 drivers/base/power/wakeup.c          |   2 +-
 drivers/base/regmap/regmap-debugfs.c | 119 ++++++++++++---------------
 2 files changed, 52 insertions(+), 69 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..b3ae10683a95 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1168,7 +1168,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations wakeup_sources_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = wakeup_sources_stats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index 571b5c00a28e..ab0458ec787c 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/device.h>
 #include <linux/list.h>
 
@@ -31,11 +32,9 @@ static size_t regmap_calc_reg_len(int max_val)
 	return snprintf(NULL, 0, "%x", max_val);
 }
 
-static ssize_t regmap_name_read_file(struct file *file,
-				     char __user *user_buf, size_t count,
-				     loff_t *ppos)
+static ssize_t regmap_name_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct regmap *map = file->private_data;
+	struct regmap *map = iocb->ki_filp->private_data;
 	const char *name = "nodev";
 	int ret;
 	char *buf;
@@ -53,14 +52,14 @@ static ssize_t regmap_name_read_file(struct file *file,
 		return ret;
 	}
 
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, ret, to);
 	kfree(buf);
 	return ret;
 }
 
 static const struct file_operations regmap_name_fops = {
 	.open = simple_open,
-	.read = regmap_name_read_file,
+	.read_iter = regmap_name_read_file,
 	.llseek = default_llseek,
 };
 
@@ -213,17 +212,18 @@ static int regmap_next_readable_reg(struct regmap *map, int reg)
 }
 
 static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
-				   unsigned int to, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+				   unsigned int to, struct kiocb *iocb,
+				   struct iov_iter *to_iov)
 {
 	size_t buf_pos = 0;
-	loff_t p = *ppos;
+	loff_t p = iocb->ki_pos;
 	ssize_t ret;
 	int i;
 	char *buf;
 	unsigned int val, start_reg;
+	size_t count = iov_iter_count(to_iov);
 
-	if (*ppos < 0 || !count)
+	if (iocb->ki_pos < 0 || !count)
 		return -EINVAL;
 
 	if (count > (PAGE_SIZE << MAX_PAGE_ORDER))
@@ -236,13 +236,13 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 	regmap_calc_tot_len(map, buf, count);
 
 	/* Work out which register we're starting at */
-	start_reg = regmap_debugfs_get_dump_start(map, from, *ppos, &p);
+	start_reg = regmap_debugfs_get_dump_start(map, from, iocb->ki_pos, &p);
 
 	for (i = start_reg; i >= 0 && i <= to;
 	     i = regmap_next_readable_reg(map, i)) {
 
 		/* If we're in the region the user is trying to read */
-		if (p >= *ppos) {
+		if (p >= iocb->ki_pos) {
 			/* ...but not beyond it */
 			if (buf_pos + map->debugfs_tot_len > count)
 				break;
@@ -269,25 +269,22 @@ static ssize_t regmap_read_debugfs(struct regmap *map, unsigned int from,
 
 	ret = buf_pos;
 
-	if (copy_to_user(user_buf, buf, buf_pos)) {
+	if (!copy_to_iter_full(buf, buf_pos, to_iov)) {
 		ret = -EFAULT;
 		goto out;
 	}
 
-	*ppos += buf_pos;
-
+	iocb->ki_pos += buf_pos;
 out:
 	kfree(buf);
 	return ret;
 }
 
-static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
+static ssize_t regmap_map_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct regmap *map = file->private_data;
+	struct regmap *map = iocb->ki_filp->private_data;
 
-	return regmap_read_debugfs(map, 0, map->max_register, user_buf,
-				   count, ppos);
+	return regmap_read_debugfs(map, 0, map->max_register, iocb, to);
 }
 
 #undef REGMAP_ALLOW_WRITE_DEBUGFS
@@ -298,19 +295,18 @@ static ssize_t regmap_map_read_file(struct file *file, char __user *user_buf,
  * for this feature, people who want to use this will need to modify
  * the source code directly.
  */
-static ssize_t regmap_map_write_file(struct file *file,
-				     const char __user *user_buf,
-				     size_t count, loff_t *ppos)
+static ssize_t regmap_map_write_file(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[32];
 	size_t buf_size;
 	char *start = buf;
 	unsigned long reg, value;
-	struct regmap *map = file->private_data;
+	struct regmap *map = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int ret;
 
 	buf_size = min(count, (sizeof(buf)-1));
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 	buf[buf_size] = 0;
 
@@ -336,33 +332,32 @@ static ssize_t regmap_map_write_file(struct file *file,
 
 static const struct file_operations regmap_map_fops = {
 	.open = simple_open,
-	.read = regmap_map_read_file,
-	.write = regmap_map_write_file,
+	.read_iter = regmap_map_read_file,
+	.write_iter = regmap_map_write_file,
 	.llseek = default_llseek,
 };
 
-static ssize_t regmap_range_read_file(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
+static ssize_t regmap_range_read_file(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct regmap_range_node *range = file->private_data;
+	struct regmap_range_node *range = iocb->ki_filp->private_data;
 	struct regmap *map = range->map;
 
 	return regmap_read_debugfs(map, range->range_min, range->range_max,
-				   user_buf, count, ppos);
+				   iocb, to);
 }
 
 static const struct file_operations regmap_range_fops = {
 	.open = simple_open,
-	.read = regmap_range_read_file,
+	.read_iter = regmap_range_read_file,
 	.llseek = default_llseek,
 };
 
-static ssize_t regmap_reg_ranges_read_file(struct file *file,
-					   char __user *user_buf, size_t count,
-					   loff_t *ppos)
+static ssize_t regmap_reg_ranges_read_file(struct kiocb *iocb,
+					   struct iov_iter *to)
 {
-	struct regmap *map = file->private_data;
+	struct regmap *map = iocb->ki_filp->private_data;
 	struct regmap_debugfs_off_cache *c;
+	size_t count = iov_iter_count(to);
 	loff_t p = 0;
 	size_t buf_pos = 0;
 	char *buf;
@@ -370,7 +365,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	int ret;
 	unsigned int entry_len;
 
-	if (*ppos < 0 || !count)
+	if (iocb->ki_pos < 0 || !count)
 		return -EINVAL;
 
 	if (count > (PAGE_SIZE << MAX_PAGE_ORDER))
@@ -392,7 +387,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	 * about the file position information that is contained
 	 * in the cache, just about the actual register blocks */
 	regmap_calc_tot_len(map, buf, count);
-	regmap_debugfs_get_dump_start(map, 0, *ppos, &p);
+	regmap_debugfs_get_dump_start(map, 0, iocb->ki_pos, &p);
 
 	/* Reset file pointer as the fixed-format of the `registers'
 	 * file is not compatible with the `range' file */
@@ -401,7 +396,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	list_for_each_entry(c, &map->debugfs_off_cache, list) {
 		entry_len = snprintf(entry, PAGE_SIZE, "%x-%x\n",
 				     c->base_reg, c->max_reg);
-		if (p >= *ppos) {
+		if (p >= iocb->ki_pos) {
 			if (buf_pos + entry_len > count)
 				break;
 			memcpy(buf + buf_pos, entry, entry_len);
@@ -414,12 +409,12 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 	kfree(entry);
 	ret = buf_pos;
 
-	if (copy_to_user(user_buf, buf, buf_pos)) {
+	if (!copy_to_iter_full(buf, buf_pos, to)) {
 		ret = -EFAULT;
 		goto out_buf;
 	}
 
-	*ppos += buf_pos;
+	iocb->ki_pos += buf_pos;
 out_buf:
 	kfree(buf);
 	return ret;
@@ -427,7 +422,7 @@ static ssize_t regmap_reg_ranges_read_file(struct file *file,
 
 static const struct file_operations regmap_reg_ranges_fops = {
 	.open = simple_open,
-	.read = regmap_reg_ranges_read_file,
+	.read_iter = regmap_reg_ranges_read_file,
 	.llseek = default_llseek,
 };
 
@@ -456,21 +451,21 @@ static int regmap_access_show(struct seq_file *s, void *ignored)
 
 DEFINE_SHOW_ATTRIBUTE(regmap_access);
 
-static ssize_t __regmap_cache_only_write_file(struct file *file,
-					      const char __user *user_buf,
-					      size_t count, loff_t *ppos)
+static ssize_t regmap_cache_only_write_file(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct regmap *map = container_of(file->private_data,
+	struct regmap *map = container_of(iocb->ki_filp->private_data,
 					  struct regmap, cache_only);
+	size_t count = iov_iter_count(from);
 	bool new_val, require_sync = false;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &new_val);
+	err = kstrtobool_from_iter(from, count, &new_val);
 	/* Ignore malforned data like debugfs_write_file_bool() */
 	if (err)
 		return count;
 
-	err = debugfs_file_get(file->f_path.dentry);
+	err = debugfs_file_get(iocb->ki_filp->f_path.dentry);
 	if (err)
 		return err;
 
@@ -486,7 +481,7 @@ static ssize_t __regmap_cache_only_write_file(struct file *file,
 	map->cache_only = new_val;
 
 	map->unlock(map->lock_arg);
-	debugfs_file_put(file->f_path.dentry);
+	debugfs_file_put(iocb->ki_filp->f_path.dentry);
 
 	if (require_sync) {
 		err = regcache_sync(map);
@@ -497,33 +492,27 @@ static ssize_t __regmap_cache_only_write_file(struct file *file,
 	return count;
 }
 
-static ssize_t regmap_cache_only_write_file(struct kiocb *iocb,
-					    struct iov_iter *from)
-{
-	return vfs_write_iter(iocb, from, __regmap_cache_only_write_file);
-}
-
 static const struct file_operations regmap_cache_only_fops = {
 	.open = simple_open,
 	.read_iter = debugfs_read_file_bool,
 	.write_iter = regmap_cache_only_write_file,
 };
 
-static ssize_t __regmap_cache_bypass_write_file(struct file *file,
-						const char __user *user_buf,
-						size_t count, loff_t *ppos)
+static ssize_t regmap_cache_bypass_write_file(struct kiocb *iocb,
+					      struct iov_iter *from)
 {
-	struct regmap *map = container_of(file->private_data,
+	struct regmap *map = container_of(iocb->ki_filp->private_data,
 					  struct regmap, cache_bypass);
+	size_t count = iov_iter_count(from);
 	bool new_val;
 	int err;
 
-	err = kstrtobool_from_user(user_buf, count, &new_val);
+	err = kstrtobool_from_iter(from, count, &new_val);
 	/* Ignore malforned data like debugfs_write_file_bool() */
 	if (err)
 		return count;
 
-	err = debugfs_file_get(file->f_path.dentry);
+	err = debugfs_file_get(iocb->ki_filp->f_path.dentry);
 	if (err)
 		return err;
 
@@ -538,17 +527,11 @@ static ssize_t __regmap_cache_bypass_write_file(struct file *file,
 	map->cache_bypass = new_val;
 
 	map->unlock(map->lock_arg);
-	debugfs_file_put(file->f_path.dentry);
+	debugfs_file_put(iocb->ki_filp->f_path.dentry);
 
 	return count;
 }
 
-static ssize_t regmap_cache_bypass_write_file(struct kiocb *iocb,
-					      struct iov_iter *from)
-{
-	return vfs_write_iter(iocb, from, __regmap_cache_bypass_write_file);
-}
-
 static const struct file_operations regmap_cache_bypass_fops = {
 	.open = simple_open,
 	.read_iter = debugfs_read_file_bool,
-- 
2.43.0


