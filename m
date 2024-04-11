Return-Path: <linux-kernel+bounces-141093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6B8A1A75
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0CC6284CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7965D1DB549;
	Thu, 11 Apr 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ko7xvst8"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC611DED69
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850025; cv=none; b=BhGFvRrFhh9kT2d/jHV6j68lpNBTOd30sBewRK7eai4UgI/WEJbpGmZ0Hh3z7/W7n5sCLHMJ6E4i6wAVkqQt8fqTaBCP0/co9aFb54xGdFjJEpVqEeZIOhIHAAFdNMmAU0gQm4l4syctqFF0ovU1TMn3RPWRCQ+CzQN1hQ87CzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850025; c=relaxed/simple;
	bh=jfuPh7jOe1pir85UGVWuyH6noSfb2+TNninVoiZkPRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNS7YxVLV0am+48l2VsJ3ch1nG+nkFWY+Jz9ms44Q4fj6BLvoOjEZ+o3MCUo5lspP3zx4L7A3mcmmhl31r89TKf9iGzrlFKuw58AdGRjE8fJP5MeVVTm1lEwEtsIh0ElofPiRewbuLTuAwqBkL4ZsZrV6/PjBV0y0TeilZi3HPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ko7xvst8; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16230139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850022; x=1713454822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSPz88yQfRnAL2hZ2Bi3ijQOs+uqL4F0A1jPmmi3GCw=;
        b=ko7xvst8mHuOxohNRkvbtGYMh7mQwU1ph7ZPqZS9nZ/XxxRiMgSU4Yx9FwdTh6yidJ
         lBfd+Fl0ffzRz89jZilmdpoi8wNQNlLvAhQCzegqPUMxbt2TKTfJlKveH9TdUtQ4sF2r
         NooZN9cizK4Zl2qK2PgE9vL5DoqYPx8Ym51C4WOcQssFxBiPReuef5d7tgNuhXEEHrwo
         GvApJ0rd6YowIo4h/tIAfxFKWtx9OLqXTD+o1wC4YxUjUsFkoweNE/3E10P/1U3aHilP
         yOGnzitMl1mPijoJ1cJtENaBATKOBjE779PIhEMQWtM5EBzY773Ny/2FdbFD2sFiHw7I
         RXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850022; x=1713454822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hSPz88yQfRnAL2hZ2Bi3ijQOs+uqL4F0A1jPmmi3GCw=;
        b=o9So+Jaq4uzBo1y1P1UmERax6dUPUKskmbnAQxTzwPXfH/z8Qzib1EDJuN5UxW0iDa
         rciCJC+bsDnK3q6KwpEYxaKlYZbey6z6se8ar+4nkcHxmcWBWJWbpTLyttN6fHibjbki
         fZT6/UTcpC4VBtJAOrTp0nMoWfjIFdAnNB/C1WNP68jGxN014tt9awCS3cy3hw099a4O
         9TZI0DZPKzc92ehqotdasm49nC6yHwRVczsMUkQZsHngCpkVBO2nqzEMYt6GuXJI37XL
         eqIagnbqhRp8hNigJiSrDxypsQVj+YlVTcMEkeZpUfqfk8QNXZAfogeJbgGyVctem7fe
         jgrQ==
X-Gm-Message-State: AOJu0Yzbn8ibXNgGtB+NSQ0WCylHNfkBmxL2IoCYUs33KlbkulXNafEs
	YBK4PjZY/eSBuF8UtA40r4H7Ok6zZE0WvGDWi40nBFPF5Zv52MTwf6Cy2Skz2M+PHRh1jBCBhuW
	E
X-Google-Smtp-Source: AGHT+IHXD7LmtwxxXWUpu4JFC4KKXTBQrU6itFof8DoKFZ1wK4g0iK6JMZFgaI0y24cAmIjt4PwOiw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr210559iog.0.1712850021930;
        Thu, 11 Apr 2024 08:40:21 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 315/437] drivers/net/netdevsim: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:35 -0600
Message-ID: <20240411153126.16201-316-axboe@kernel.dk>
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
 drivers/net/netdevsim/dev.c         | 73 ++++++++++++++---------------
 drivers/net/netdevsim/fib.c         | 16 +++----
 drivers/net/netdevsim/health.c      | 12 ++---
 drivers/net/netdevsim/hwstats.c     | 13 +++--
 drivers/net/netdevsim/ipsec.c       | 10 ++--
 drivers/net/netdevsim/psample.c     | 12 ++---
 drivers/net/netdevsim/udp_tunnels.c |  9 ++--
 7 files changed, 69 insertions(+), 76 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 92a7a36b93ac..41d49c53da39 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -93,11 +93,10 @@ nsim_dev_take_snapshot(struct devlink *devlink,
 	return 0;
 }
 
-static ssize_t nsim_dev_take_snapshot_write(struct file *file,
-					    const char __user *data,
-					    size_t count, loff_t *ppos)
+static ssize_t nsim_dev_take_snapshot_write(struct kiocb *iocb,
+					    struct iov_iter *from)
 {
-	struct nsim_dev *nsim_dev = file->private_data;
+	struct nsim_dev *nsim_dev = iocb->ki_filp->private_data;
 	struct devlink *devlink;
 	u8 *dummy_data;
 	int err;
@@ -124,21 +123,20 @@ static ssize_t nsim_dev_take_snapshot_write(struct file *file,
 		return err;
 	}
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations nsim_dev_take_snapshot_fops = {
 	.open = simple_open,
-	.write = nsim_dev_take_snapshot_write,
+	.write_iter = nsim_dev_take_snapshot_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t nsim_dev_trap_fa_cookie_read(struct file *file,
-					    char __user *data,
-					    size_t count, loff_t *ppos)
+static ssize_t nsim_dev_trap_fa_cookie_read(struct kiocb *iocb,
+					    struct iov_iter *to)
 {
-	struct nsim_dev *nsim_dev = file->private_data;
+	struct nsim_dev *nsim_dev = iocb->ki_filp->private_data;
 	struct flow_action_cookie *fa_cookie;
 	unsigned int buf_len;
 	ssize_t ret;
@@ -159,7 +157,7 @@ static ssize_t nsim_dev_trap_fa_cookie_read(struct file *file,
 	bin2hex(buf, fa_cookie->cookie, fa_cookie->cookie_len);
 	spin_unlock(&nsim_dev->fa_cookie_lock);
 
-	ret = simple_read_from_buffer(data, count, ppos, buf, buf_len);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, buf_len, to);
 
 	kfree(buf);
 	return ret;
@@ -169,23 +167,23 @@ static ssize_t nsim_dev_trap_fa_cookie_read(struct file *file,
 	return ret;
 }
 
-static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
-					     const char __user *data,
-					     size_t count, loff_t *ppos)
+static ssize_t nsim_dev_trap_fa_cookie_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct nsim_dev *nsim_dev = file->private_data;
+	struct nsim_dev *nsim_dev = iocb->ki_filp->private_data;
 	struct flow_action_cookie *fa_cookie;
+	size_t count = iov_iter_count(from);
 	size_t cookie_len;
 	ssize_t ret;
 	char *buf;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return -EINVAL;
 	cookie_len = (count - 1) / 2;
 	if ((count - 1) % 2)
 		return -EINVAL;
 
-	buf = memdup_user(data, count);
+	buf = iterdup(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
@@ -218,42 +216,42 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
 
 static const struct file_operations nsim_dev_trap_fa_cookie_fops = {
 	.open = simple_open,
-	.read = nsim_dev_trap_fa_cookie_read,
-	.write = nsim_dev_trap_fa_cookie_write,
+	.read_iter = nsim_dev_trap_fa_cookie_read,
+	.write_iter = nsim_dev_trap_fa_cookie_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
 
-static ssize_t nsim_bus_dev_max_vfs_read(struct file *file, char __user *data,
-					 size_t count, loff_t *ppos)
+static ssize_t nsim_bus_dev_max_vfs_read(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
-	struct nsim_dev *nsim_dev = file->private_data;
+	struct nsim_dev *nsim_dev = iocb->ki_filp->private_data;
 	char buf[11];
 	ssize_t len;
 
 	len = scnprintf(buf, sizeof(buf), "%u\n",
 			READ_ONCE(nsim_dev->nsim_bus_dev->max_vfs));
 
-	return simple_read_from_buffer(data, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
-					  const char __user *data,
-					  size_t count, loff_t *ppos)
+static ssize_t nsim_bus_dev_max_vfs_write(struct kiocb *iocb,
+					  struct iov_iter *from)
 {
 	struct nsim_vf_config *vfconfigs;
+	size_t count = iov_iter_count(from);
 	struct nsim_dev *nsim_dev;
 	char buf[10];
 	ssize_t ret;
 	u32 val;
 
-	if (*ppos != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (count >= sizeof(buf))
 		return -ENOSPC;
 
-	ret = copy_from_user(buf, data, count);
+	ret = !copy_from_iter_full(buf, count, from);
 	if (ret)
 		return -EFAULT;
 	buf[count] = '\0';
@@ -271,7 +269,7 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
 	if (!vfconfigs)
 		return -ENOMEM;
 
-	nsim_dev = file->private_data;
+	nsim_dev = iocb->ki_filp->private_data;
 	devl_lock(priv_to_devlink(nsim_dev));
 	/* Reject if VFs are configured */
 	if (nsim_dev_get_vfs(nsim_dev)) {
@@ -279,7 +277,7 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
 	} else {
 		swap(nsim_dev->vfconfigs, vfconfigs);
 		WRITE_ONCE(nsim_dev->nsim_bus_dev->max_vfs, val);
-		*ppos += count;
+		iocb->ki_pos += count;
 		ret = count;
 	}
 	devl_unlock(priv_to_devlink(nsim_dev));
@@ -290,8 +288,8 @@ static ssize_t nsim_bus_dev_max_vfs_write(struct file *file,
 
 static const struct file_operations nsim_dev_max_vfs_fops = {
 	.open = simple_open,
-	.read = nsim_bus_dev_max_vfs_read,
-	.write = nsim_bus_dev_max_vfs_write,
+	.read_iter = nsim_bus_dev_max_vfs_read,
+	.write_iter = nsim_bus_dev_max_vfs_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
@@ -367,23 +365,22 @@ static void nsim_dev_debugfs_exit(struct nsim_dev *nsim_dev)
 	debugfs_remove_recursive(nsim_dev->ddir);
 }
 
-static ssize_t nsim_dev_rate_parent_read(struct file *file,
-					 char __user *data,
-					 size_t count, loff_t *ppos)
+static ssize_t nsim_dev_rate_parent_read(struct kiocb *iocb,
+					 struct iov_iter *to)
 {
-	char **name_ptr = file->private_data;
+	char **name_ptr = iocb->ki_filp->private_data;
 	size_t len;
 
 	if (!*name_ptr)
 		return 0;
 
 	len = strlen(*name_ptr);
-	return simple_read_from_buffer(data, count, ppos, *name_ptr, len);
+	return simple_copy_to_iter(*name_ptr, &iocb->ki_pos, len, to);
 }
 
 static const struct file_operations nsim_dev_rate_parent_fops = {
 	.open = simple_open,
-	.read = nsim_dev_rate_parent_read,
+	.read_iter = nsim_dev_rate_parent_read,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index a1f91ff8ec56..4ab1b7944f3e 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1361,15 +1361,15 @@ static void nsim_nexthop_free(void *ptr, void *arg)
 	nsim_nexthop_destroy(nexthop);
 }
 
-static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
-						  const char __user *user_buf,
-						  size_t size, loff_t *ppos)
+static ssize_t nsim_nexthop_bucket_activity_write(struct kiocb *iocb,
+						  struct iov_iter *from)
 {
-	struct nsim_fib_data *data = file->private_data;
+	struct nsim_fib_data *data = iocb->ki_filp->private_data;
 	struct net *net = devlink_net(data->devlink);
+	size_t size = iov_iter_count(from);
 	struct nsim_nexthop *nexthop;
 	unsigned long *activity;
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
 	u16 bucket_index;
 	char buf[128];
 	int err = 0;
@@ -1379,7 +1379,7 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 		return -EINVAL;
 	if (size > sizeof(buf))
 		return -EINVAL;
-	if (copy_from_user(buf, user_buf, size))
+	if (!copy_from_iter_full(buf, size, from))
 		return -EFAULT;
 	if (sscanf(buf, "%u %hu", &nhid, &bucket_index) != 2)
 		return -EINVAL;
@@ -1407,13 +1407,13 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
 out:
 	rtnl_unlock();
 
-	*ppos = size;
+	iocb->ki_pos = size;
 	return err ?: size;
 }
 
 static const struct file_operations nsim_nexthop_bucket_activity_fops = {
 	.open = simple_open,
-	.write = nsim_nexthop_bucket_activity_write,
+	.write_iter = nsim_nexthop_bucket_activity_write,
 	.llseek = no_llseek,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/net/netdevsim/health.c b/drivers/net/netdevsim/health.c
index 70e8bdf34be9..b1c23d23bee2 100644
--- a/drivers/net/netdevsim/health.c
+++ b/drivers/net/netdevsim/health.c
@@ -140,16 +140,16 @@ struct devlink_health_reporter_ops nsim_dev_dummy_reporter_ops = {
 	.diagnose = nsim_dev_dummy_reporter_diagnose,
 };
 
-static ssize_t nsim_dev_health_break_write(struct file *file,
-					   const char __user *data,
-					   size_t count, loff_t *ppos)
+static ssize_t nsim_dev_health_break_write(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct nsim_dev_health *health = file->private_data;
+	struct nsim_dev_health *health = iocb->ki_filp->private_data;
 	struct nsim_dev_dummy_reporter_ctx ctx;
+	size_t count = iov_iter_count(from);
 	char *break_msg;
 	int err;
 
-	break_msg = memdup_user_nul(data, count);
+	break_msg = iterdup_nul(from, count);
 	if (IS_ERR(break_msg))
 		return PTR_ERR(break_msg);
 
@@ -168,7 +168,7 @@ static ssize_t nsim_dev_health_break_write(struct file *file,
 
 static const struct file_operations nsim_dev_health_break_fops = {
 	.open = simple_open,
-	.write = nsim_dev_health_break_write,
+	.write_iter = nsim_dev_health_break_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/net/netdevsim/hwstats.c b/drivers/net/netdevsim/hwstats.c
index 0e58aa7f0374..8e9b13c464a8 100644
--- a/drivers/net/netdevsim/hwstats.c
+++ b/drivers/net/netdevsim/hwstats.c
@@ -337,20 +337,19 @@ struct nsim_dev_hwstats_fops {
 };
 
 static ssize_t
-nsim_dev_hwstats_do_write(struct file *file,
-			  const char __user *data,
-			  size_t count, loff_t *ppos)
+nsim_dev_hwstats_do_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct nsim_dev_hwstats *hwstats = file->private_data;
+	struct nsim_dev_hwstats *hwstats = iocb->ki_filp->private_data;
 	struct nsim_dev_hwstats_fops *hwsfops;
+	size_t count = iov_iter_count(from);
 	struct list_head *hwsdev_list;
 	int ifindex;
 	int err;
 
-	hwsfops = container_of(debugfs_real_fops(file),
+	hwsfops = container_of(debugfs_real_fops(iocb->ki_filp),
 			       struct nsim_dev_hwstats_fops, fops);
 
-	err = kstrtoint_from_user(data, count, 0, &ifindex);
+	err = kstrtoint_from_iter(from, count, 0, &ifindex);
 	if (err)
 		return err;
 
@@ -385,7 +384,7 @@ nsim_dev_hwstats_do_write(struct file *file,
 	{							\
 		.fops = {					\
 			.open = simple_open,			\
-			.write = nsim_dev_hwstats_do_write,	\
+			.write_iter = nsim_dev_hwstats_do_write,	\
 			.llseek = generic_file_llseek,		\
 			.owner = THIS_MODULE,			\
 		},						\
diff --git a/drivers/net/netdevsim/ipsec.c b/drivers/net/netdevsim/ipsec.c
index f0d58092e7e9..16535c552d12 100644
--- a/drivers/net/netdevsim/ipsec.c
+++ b/drivers/net/netdevsim/ipsec.c
@@ -9,11 +9,9 @@
 
 #define NSIM_IPSEC_AUTH_BITS	128
 
-static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
-					char __user *buffer,
-					size_t count, loff_t *ppos)
+static ssize_t nsim_dbg_netdev_ops_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct netdevsim *ns = filp->private_data;
+	struct netdevsim *ns = iocb->ki_filp->private_data;
 	struct nsim_ipsec *ipsec = &ns->ipsec;
 	size_t bufsize;
 	char *buf, *p;
@@ -53,7 +51,7 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 			       sap->key[2], sap->key[3]);
 	}
 
-	len = simple_read_from_buffer(buffer, count, ppos, buf, p - buf);
+	len = simple_copy_to_iter(buf, &iocb->ki_pos, p - buf, to);
 
 	kfree(buf);
 	return len;
@@ -62,7 +60,7 @@ static ssize_t nsim_dbg_netdev_ops_read(struct file *filp,
 static const struct file_operations ipsec_dbg_fops = {
 	.owner = THIS_MODULE,
 	.open = simple_open,
-	.read = nsim_dbg_netdev_ops_read,
+	.read_iter = nsim_dbg_netdev_ops_read,
 };
 
 static int nsim_ipsec_find_empty_idx(struct nsim_ipsec *ipsec)
diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index f0c6477dd0ae..21353aea4f4a 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -168,15 +168,15 @@ static int nsim_dev_psample_disable(struct nsim_dev *nsim_dev)
 	return 0;
 }
 
-static ssize_t nsim_dev_psample_enable_write(struct file *file,
-					     const char __user *data,
-					     size_t count, loff_t *ppos)
+static ssize_t nsim_dev_psample_enable_write(struct kiocb *iocb,
+					     struct iov_iter *from)
 {
-	struct nsim_dev *nsim_dev = file->private_data;
+	struct nsim_dev *nsim_dev = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	bool enable;
 	int err;
 
-	err = kstrtobool_from_user(data, count, &enable);
+	err = kstrtobool_from_iter(from, count, &enable);
 	if (err)
 		return err;
 
@@ -190,7 +190,7 @@ static ssize_t nsim_dev_psample_enable_write(struct file *file,
 
 static const struct file_operations nsim_psample_enable_fops = {
 	.open = simple_open,
-	.write = nsim_dev_psample_enable_write,
+	.write_iter = nsim_dev_psample_enable_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 02dc3123eb6c..efbd5af4562c 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -106,10 +106,9 @@ static const struct udp_tunnel_nic_info nsim_udp_tunnel_info = {
 };
 
 static ssize_t
-nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
-				  size_t count, loff_t *ppos)
+nsim_udp_tunnels_info_reset_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct net_device *dev = file->private_data;
+	struct net_device *dev = iocb->ki_filp->private_data;
 	struct netdevsim *ns = netdev_priv(dev);
 
 	memset(ns->udp_ports.ports, 0, sizeof(ns->udp_ports.__ports));
@@ -117,12 +116,12 @@ nsim_udp_tunnels_info_reset_write(struct file *file, const char __user *data,
 	udp_tunnel_nic_reset_ntf(dev);
 	rtnl_unlock();
 
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations nsim_udp_tunnels_info_reset_fops = {
 	.open = simple_open,
-	.write = nsim_udp_tunnels_info_reset_write,
+	.write_iter = nsim_udp_tunnels_info_reset_write,
 	.llseek = generic_file_llseek,
 	.owner = THIS_MODULE,
 };
-- 
2.43.0


