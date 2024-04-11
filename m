Return-Path: <linux-kernel+bounces-141108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B48A1A85
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B86F1F24A03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309861E5A87;
	Thu, 11 Apr 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="qTt4lA0I"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D11E49BF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850051; cv=none; b=GUT2Ue8VnNtltUzth+xPGTf7klmxyEcl6djv6OukzUIeVsSMFzzHam+xOknShEgsMTNfzlRJC54r1sVVR4FnPG/Oj3tjfpNBeADraX7gR6P7h4sKSrmTYqgWOtcGmCMBoXCFXJu8PL1CibcO80rbPD5C0rrZBEYXXQCf8OPCCXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850051; c=relaxed/simple;
	bh=529wjpas2p56dqMV8X7IZjIFCzhyxyeJhKZ2qwEF32k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udUL4zCTQ6795nUjVXWOGkdUlg2NYrArpa0KVYTAseTbjJyNjbW98w8+Rsl5U6caQeLZkYFW+Ue4j+EUO9l5End395wwa39O8YidNqDmRfy04yt5+1IZCdtr6pvzSoWaXPtbbCG36TUAyZbdvr6ak5ntOC3DiTtmIYdUGP0Bet0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=qTt4lA0I; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9893039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850048; x=1713454848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do2lRM3x5b0Zjz+Q9sYMbX0U+xC2iLU0SVhIay8/GyQ=;
        b=qTt4lA0IepQqcgRcyA9bZYMNxhXB3DuR/5/roTYdXimxMnbcgTVn+Rf/V9jhmehZhU
         syUjSSS0suXy+MzYFKSsxEOSxN9EpsUlrgucIwnrj3UbWaKIftV8ef9annOWJvHO57Uc
         dZGeTMp0svz6MkaefI1Uy1vArMVOapfhLxee5aqfO3wy8fuc72VBQxlWgW5bWoupP6k4
         Jqfvf4N92S3ThWesRgcA2ueTz2XKePqXzRWIm8YW5WRa27v1DSeI8Tjk9PlZbYxj2F+k
         IanvjNhySEEWm1m8HvNi6lnB4L90//ncrlDxP4b9k5hUEdjO/j7pMKpoYDLVWaYVmI3T
         V+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850048; x=1713454848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do2lRM3x5b0Zjz+Q9sYMbX0U+xC2iLU0SVhIay8/GyQ=;
        b=LiUDvwWCNaYh+2mlBvau/AE7yyVfy/Br3ihfGPhQueRuJKu2VWBFz4H6tGhyt8/xHF
         lfma79qruSHhygl9CiVkk7CYcuNn9lL80y5ec9Wr1j43yAl2Rwjg07av25cw9jev1/e2
         sQPFgYDzs+DEeKcwDQ0hhlzOvCFwcw8hwwYCOvJFQHyBrGCLcwM2KScVOf8jziRgd58q
         UMVMhuR2T3x89LhevyL42cBu0HFKEP000VZLBvMTSvhMIIa8z1kkxgZZYjY+yRQ+6+0+
         7igTl1qxt118okZoeFdbaFe8sifUKn1icK9z67+dKrdE6gxdPkRxwAqPPvauDQF6yJLK
         QbrQ==
X-Gm-Message-State: AOJu0YxPri9HTZ/yk+k6ItDJ11hRrOhHA8NUV+nxhRfZUO8JKg/EACmP
	TKsS25o7c0FhFswFn92ipmyuRkodGCJzIeo5eIaZXdIBi76+vpP+z9AF57Bu9CgiBVGTLZ352/G
	4
X-Google-Smtp-Source: AGHT+IHViGBn7BQW5cP/C+BwgAVKVoHB2/IN4dDpmMdg2/oVSn5s+TU71SOFfGsS52vRPtuZ3PJdkQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr205119iop.1.1712850048093;
        Thu, 11 Apr 2024 08:40:48 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 330/437] x86/kernel: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:50 -0600
Message-ID: <20240411153126.16201-331-axboe@kernel.dk>
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
 arch/x86/kernel/apm_32.c                  | 10 +++---
 arch/x86/kernel/callthunks.c              |  2 +-
 arch/x86/kernel/cpu/debugfs.c             |  4 +--
 arch/x86/kernel/cpu/mce/dev-mcelog.c      | 38 +++++++++++------------
 arch/x86/kernel/cpu/mce/inject.c          | 27 +++++++---------
 arch/x86/kernel/cpu/mce/severity.c        | 11 +++----
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 18 +++++------
 arch/x86/kernel/cpuid.c                   | 16 +++++-----
 arch/x86/kernel/kdebugfs.c                | 14 ++++-----
 arch/x86/kernel/msr.c                     | 28 +++++++----------
 arch/x86/kernel/tboot.c                   | 17 +++++-----
 11 files changed, 86 insertions(+), 99 deletions(-)

diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index b37ab1095707..bc4c8db6b52f 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -1431,13 +1431,14 @@ static int check_apm_user(struct apm_user *as, const char *func)
 	return 0;
 }
 
-static ssize_t do_read(struct file *fp, char __user *buf, size_t count, loff_t *ppos)
+static ssize_t do_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct apm_user *as;
 	int i;
 	apm_event_t event;
 
-	as = fp->private_data;
+	as = iocb->ki_filp->private_data;
 	if (check_apm_user(as, "read"))
 		return -EIO;
 	if ((int)count < sizeof(apm_event_t))
@@ -1448,7 +1449,7 @@ static ssize_t do_read(struct file *fp, char __user *buf, size_t count, loff_t *
 	i = count;
 	while ((i >= sizeof(event)) && !queue_empty(as)) {
 		event = get_queued_event(as);
-		if (copy_to_user(buf, &event, sizeof(event))) {
+		if (!copy_to_iter_full(&event, sizeof(event), to)) {
 			if (i < count)
 				break;
 			return -EFAULT;
@@ -1464,7 +1465,6 @@ static ssize_t do_read(struct file *fp, char __user *buf, size_t count, loff_t *
 			as->standbys_read++;
 			break;
 		}
-		buf += sizeof(event);
 		i -= sizeof(event);
 	}
 	if (i < count)
@@ -1876,7 +1876,7 @@ __setup("apm=", apm_setup);
 
 static const struct file_operations apm_bios_fops = {
 	.owner		= THIS_MODULE,
-	.read		= do_read,
+	.read_iter	= do_read,
 	.poll		= do_poll,
 	.unlocked_ioctl	= do_ioctl,
 	.open		= do_open,
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e92ff0c11db8..bec11795ff8e 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -375,7 +375,7 @@ static int callthunks_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_ops = {
 	.open		= callthunks_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..1f29b224c8c0 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -42,7 +42,7 @@ static int cpu_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_cpu_ops = {
 	.open		= cpu_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -76,7 +76,7 @@ static int dom_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_dom_ops = {
 	.open		= dom_debug_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index a05ac0716ecf..1d5d1b26b85b 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -159,7 +159,7 @@ static int mce_chrdev_release(struct inode *inode, struct file *file)
 static int mce_apei_read_done;
 
 /* Collect MCE record of previous boot in persistent storage via APEI ERST. */
-static int __mce_read_apei(char __user **ubuf, size_t usize)
+static int __mce_read_apei(struct iov_iter *to, size_t usize)
 {
 	int rc;
 	u64 record_id;
@@ -181,7 +181,7 @@ static int __mce_read_apei(char __user **ubuf, size_t usize)
 		return rc;
 	}
 	rc = -EFAULT;
-	if (copy_to_user(*ubuf, &m, sizeof(struct mce)))
+	if (!copy_to_iter_full(&m, sizeof(struct mce), to))
 		return rc;
 	/*
 	 * In fact, we should have cleared the record after that has
@@ -194,51 +194,49 @@ static int __mce_read_apei(char __user **ubuf, size_t usize)
 		mce_apei_read_done = 1;
 		return rc;
 	}
-	*ubuf += sizeof(struct mce);
 
 	return 0;
 }
 
-static ssize_t mce_chrdev_read(struct file *filp, char __user *ubuf,
-				size_t usize, loff_t *off)
+static ssize_t mce_chrdev_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	char __user *buf = ubuf;
+	size_t copied, usize = iov_iter_count(to);
 	unsigned next;
 	int i, err;
 
 	mutex_lock(&mce_chrdev_read_mutex);
 
 	if (!mce_apei_read_done) {
-		err = __mce_read_apei(&buf, usize);
-		if (err || buf != ubuf)
+		err = __mce_read_apei(to, usize);
+		if (err)
 			goto out;
 	}
 
 	/* Only supports full reads right now */
 	err = -EINVAL;
-	if (*off != 0 || usize < mcelog->len * sizeof(struct mce))
+	if (iocb->ki_pos != 0 || usize < mcelog->len * sizeof(struct mce))
 		goto out;
 
 	next = mcelog->next;
 	err = 0;
+	copied = 0;
 
 	for (i = 0; i < next; i++) {
 		struct mce *m = &mcelog->entry[i];
 
-		err |= copy_to_user(buf, m, sizeof(*m));
-		buf += sizeof(*m);
+		if (copy_to_iter_full(m, sizeof(*m), to))
+			copied += sizeof(*m);
+		else
+			err = -EFAULT;
 	}
 
 	memset(mcelog->entry, 0, next * sizeof(struct mce));
 	mcelog->next = 0;
 
-	if (err)
-		err = -EFAULT;
-
 out:
 	mutex_unlock(&mce_chrdev_read_mutex);
 
-	return err ? err : buf - ubuf;
+	return err ? err : copied;
 }
 
 static __poll_t mce_chrdev_poll(struct file *file, poll_table *wait)
@@ -290,9 +288,9 @@ void mce_unregister_injector_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_injector_chain);
 
-static ssize_t mce_chrdev_write(struct file *filp, const char __user *ubuf,
-				size_t usize, loff_t *off)
+static ssize_t mce_chrdev_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t usize = iov_iter_count(from);
 	struct mce m;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -306,7 +304,7 @@ static ssize_t mce_chrdev_write(struct file *filp, const char __user *ubuf,
 
 	if ((unsigned long)usize > sizeof(struct mce))
 		usize = sizeof(struct mce);
-	if (copy_from_user(&m, ubuf, usize))
+	if (!copy_from_iter_full(&m, usize, from))
 		return -EFAULT;
 
 	if (m.extcpu >= num_possible_cpus() || !cpu_online(m.extcpu))
@@ -326,8 +324,8 @@ static ssize_t mce_chrdev_write(struct file *filp, const char __user *ubuf,
 static const struct file_operations mce_chrdev_ops = {
 	.open			= mce_chrdev_open,
 	.release		= mce_chrdev_release,
-	.read			= mce_chrdev_read,
-	.write			= mce_chrdev_write,
+	.read_iter		= mce_chrdev_read,
+	.write_iter		= mce_chrdev_write,
 	.poll			= mce_chrdev_poll,
 	.unlocked_ioctl		= mce_chrdev_ioctl,
 	.compat_ioctl		= compat_ptr_ioctl,
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d749475..5d545f331d0d 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -349,27 +349,26 @@ static int __set_inj(const char *buf)
 	return -EINVAL;
 }
 
-static ssize_t flags_read(struct file *filp, char __user *ubuf,
-			  size_t cnt, loff_t *ppos)
+static ssize_t flags_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[MAX_FLAG_OPT_SIZE];
 	int n;
 
 	n = sprintf(buf, "%s\n", flags_options[inj_type]);
 
-	return simple_read_from_buffer(ubuf, cnt, ppos, buf, n);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, n, to);
 }
 
-static ssize_t flags_write(struct file *filp, const char __user *ubuf,
-			   size_t cnt, loff_t *ppos)
+static ssize_t flags_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char buf[MAX_FLAG_OPT_SIZE], *__buf;
+	size_t cnt = iov_iter_count(from);
 	int err;
 
 	if (!cnt || cnt > MAX_FLAG_OPT_SIZE)
 		return -EINVAL;
 
-	if (copy_from_user(&buf, ubuf, cnt))
+	if (!copy_from_iter_full(&buf, cnt, from))
 		return -EFAULT;
 
 	buf[cnt - 1] = 0;
@@ -383,14 +382,14 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
 		return err;
 	}
 
-	*ppos += cnt;
+	iocb->ki_pos += cnt;
 
 	return cnt;
 }
 
 static const struct file_operations flags_fops = {
-	.read           = flags_read,
-	.write          = flags_write,
+	.read_iter      = flags_read,
+	.write_iter     = flags_write,
 	.llseek         = generic_file_llseek,
 };
 
@@ -679,16 +678,14 @@ static const char readme_msg[] =
 "ipid:\t IPID (AMD-specific)\n"
 "\n";
 
-static ssize_t
-inj_readme_read(struct file *filp, char __user *ubuf,
-		       size_t cnt, loff_t *ppos)
+static ssize_t inj_readme_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	return simple_read_from_buffer(ubuf, cnt, ppos,
-					readme_msg, strlen(readme_msg));
+	return simple_copy_to_iter(readme_msg, &iocb->ki_pos,
+					strlen(readme_msg), to);
 }
 
 static const struct file_operations readme_fops = {
-	.read		= inj_readme_read,
+	.read_iter	= inj_readme_read,
 };
 
 static struct dfs_node {
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index c4477162c07d..eb648f415d55 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -447,21 +447,20 @@ static int severities_coverage_open(struct inode *inode, struct file *file)
 	return seq_open(file, &severities_seq_ops);
 }
 
-static ssize_t severities_coverage_write(struct file *file,
-					 const char __user *ubuf,
-					 size_t count, loff_t *ppos)
+static ssize_t severities_coverage_write(struct kiocb *iocb,
+					 struct iov_iter *from)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(severities); i++)
 		severities[i].covered = 0;
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations severities_coverage_fops = {
 	.open		= severities_coverage_open,
 	.release	= seq_release,
-	.read		= seq_read,
-	.write		= severities_coverage_write,
+	.read_iter	= seq_read_iter,
+	.write_iter	= severities_coverage_write,
 	.llseek		= seq_lseek,
 };
 
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 884b88e25141..e10f1e9513ec 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1244,18 +1244,18 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 	return ret;
 }
 
-static ssize_t pseudo_lock_measure_trigger(struct file *file,
-					   const char __user *user_buf,
-					   size_t count, loff_t *ppos)
+static ssize_t pseudo_lock_measure_trigger(struct kiocb *iocb,
+					   struct iov_iter *from)
 {
-	struct rdtgroup *rdtgrp = file->private_data;
+	struct rdtgroup *rdtgrp = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	size_t buf_size;
 	char buf[32];
 	int ret;
 	int sel;
 
 	buf_size = min(count, (sizeof(buf) - 1));
-	if (copy_from_user(buf, user_buf, buf_size))
+	if (!copy_from_iter_full(buf, buf_size, from))
 		return -EFAULT;
 
 	buf[buf_size] = '\0';
@@ -1263,20 +1263,20 @@ static ssize_t pseudo_lock_measure_trigger(struct file *file,
 	if (ret == 0) {
 		if (sel != 1 && sel != 2 && sel != 3)
 			return -EINVAL;
-		ret = debugfs_file_get(file->f_path.dentry);
+		ret = debugfs_file_get(iocb->ki_filp->f_path.dentry);
 		if (ret)
 			return ret;
 		ret = pseudo_lock_measure_cycles(rdtgrp, sel);
 		if (ret == 0)
 			ret = count;
-		debugfs_file_put(file->f_path.dentry);
+		debugfs_file_put(iocb->ki_filp->f_path.dentry);
 	}
 
 	return ret;
 }
 
 static const struct file_operations pseudo_measure_fops = {
-	.write = pseudo_lock_measure_trigger,
+	.write_iter = pseudo_lock_measure_trigger,
 	.open = simple_open,
 	.llseek = default_llseek,
 };
@@ -1570,8 +1570,6 @@ static int pseudo_lock_dev_mmap(struct file *filp, struct vm_area_struct *vma)
 static const struct file_operations pseudo_lock_dev_fops = {
 	.owner =	THIS_MODULE,
 	.llseek =	no_llseek,
-	.read =		NULL,
-	.write =	NULL,
 	.open =		pseudo_lock_dev_open,
 	.release =	pseudo_lock_dev_release,
 	.mmap =		pseudo_lock_dev_mmap,
diff --git a/arch/x86/kernel/cpuid.c b/arch/x86/kernel/cpuid.c
index dae436253de4..f33fc680cc7d 100644
--- a/arch/x86/kernel/cpuid.c
+++ b/arch/x86/kernel/cpuid.c
@@ -58,13 +58,12 @@ static void cpuid_smp_cpuid(void *cmd_block)
 	complete(&cmd->done);
 }
 
-static ssize_t cpuid_read(struct file *file, char __user *buf,
-			  size_t count, loff_t *ppos)
+static ssize_t cpuid_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	char __user *tmp = buf;
 	struct cpuid_regs_done cmd;
-	int cpu = iminor(file_inode(file));
-	u64 pos = *ppos;
+	int cpu = iminor(file_inode(iocb->ki_filp));
+	size_t count = iov_iter_count(to);
+	u64 pos = iocb->ki_pos;
 	ssize_t bytes = 0;
 	int err = 0;
 
@@ -84,13 +83,12 @@ static ssize_t cpuid_read(struct file *file, char __user *buf,
 		if (err)
 			break;
 		wait_for_completion(&cmd.done);
-		if (copy_to_user(tmp, &cmd.regs, 16)) {
+		if (!copy_to_iter_full(&cmd.regs, 16, to)) {
 			err = -EFAULT;
 			break;
 		}
-		tmp += 16;
 		bytes += 16;
-		*ppos = ++pos;
+		iocb->ki_pos = ++pos;
 		reinit_completion(&cmd.done);
 	}
 
@@ -119,7 +117,7 @@ static int cpuid_open(struct inode *inode, struct file *file)
 static const struct file_operations cpuid_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_seek_end_llseek,
-	.read = cpuid_read,
+	.read_iter = cpuid_read,
 	.open = cpuid_open,
 };
 
diff --git a/arch/x86/kernel/kdebugfs.c b/arch/x86/kernel/kdebugfs.c
index e2e89bebcbc3..4b4db90ffab2 100644
--- a/arch/x86/kernel/kdebugfs.c
+++ b/arch/x86/kernel/kdebugfs.c
@@ -26,12 +26,12 @@ struct setup_data_node {
 	u32 len;
 };
 
-static ssize_t setup_data_read(struct file *file, char __user *user_buf,
-			       size_t count, loff_t *ppos)
+static ssize_t setup_data_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct setup_data_node *node = file->private_data;
+	struct setup_data_node *node = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	unsigned long remain;
-	loff_t pos = *ppos;
+	loff_t pos = iocb->ki_pos;
 	void *p;
 	u64 pa;
 
@@ -54,20 +54,20 @@ static ssize_t setup_data_read(struct file *file, char __user *user_buf,
 	if (!p)
 		return -ENOMEM;
 
-	remain = copy_to_user(user_buf, p, count);
+	remain = !copy_to_iter_full(p, count, to);
 
 	memunmap(p);
 
 	if (remain)
 		return -EFAULT;
 
-	*ppos = pos + count;
+	iocb->ki_pos = pos + count;
 
 	return count;
 }
 
 static const struct file_operations fops_setup_data = {
-	.read		= setup_data_read,
+	.read_iter	= setup_data_read,
 	.open		= simple_open,
 	.llseek		= default_llseek,
 };
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index e17c16c54a37..80cd3d83fb75 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -49,13 +49,12 @@ enum allow_write_msrs {
 
 static enum allow_write_msrs allow_writes = MSR_WRITES_DEFAULT;
 
-static ssize_t msr_read(struct file *file, char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t msr_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	u32 __user *tmp = (u32 __user *) buf;
 	u32 data[2];
-	u32 reg = *ppos;
-	int cpu = iminor(file_inode(file));
+	u32 reg = iocb->ki_pos;
+	int cpu = iminor(file_inode(iocb->ki_filp));
+	size_t count = iov_iter_count(to);
 	int err = 0;
 	ssize_t bytes = 0;
 
@@ -66,11 +65,10 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 		err = rdmsr_safe_on_cpu(cpu, reg, &data[0], &data[1]);
 		if (err)
 			break;
-		if (copy_to_user(tmp, &data, 8)) {
+		if (!copy_to_iter_full(&data, 8, to)) {
 			err = -EFAULT;
 			break;
 		}
-		tmp += 2;
 		bytes += 8;
 	}
 
@@ -105,13 +103,12 @@ static int filter_write(u32 reg)
 	return 0;
 }
 
-static ssize_t msr_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t msr_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const u32 __user *tmp = (const u32 __user *)buf;
+	size_t count = iov_iter_count(from);
 	u32 data[2];
-	u32 reg = *ppos;
-	int cpu = iminor(file_inode(file));
+	u32 reg = iocb->ki_pos;
+	int cpu = iminor(file_inode(iocb->ki_filp));
 	int err = 0;
 	ssize_t bytes = 0;
 
@@ -127,7 +124,7 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 		return -EINVAL;	/* Invalid chunk size */
 
 	for (; count; count -= 8) {
-		if (copy_from_user(&data, tmp, 8)) {
+		if (!copy_from_iter_full(&data, 8, from)) {
 			err = -EFAULT;
 			break;
 		}
@@ -138,7 +135,6 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 		if (err)
 			break;
 
-		tmp += 2;
 		bytes += 8;
 	}
 
@@ -227,8 +223,8 @@ static int msr_open(struct inode *inode, struct file *file)
 static const struct file_operations msr_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_seek_end_llseek,
-	.read = msr_read,
-	.write = msr_write,
+	.read_iter = msr_read,
+	.write_iter = msr_write,
 	.open = msr_open,
 	.unlocked_ioctl = msr_ioctl,
 	.compat_ioctl = msr_ioctl,
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 4c1bcb6053fc..59020897c7e6 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -356,8 +356,9 @@ static int tboot_dying_cpu(unsigned int cpu)
 
 static uint8_t tboot_log_uuid[16] = TBOOT_LOG_UUID;
 
-static ssize_t tboot_log_read(struct file *file, char __user *user_buf, size_t count, loff_t *ppos)
+static ssize_t tboot_log_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	void __iomem *log_base;
 	u8 log_uuid[16];
 	u32 max_size;
@@ -373,13 +374,13 @@ static ssize_t tboot_log_read(struct file *file, char __user *user_buf, size_t c
 		goto err_iounmap;
 
 	max_size = readl(log_base + LOG_MAX_SIZE_OFF);
-	if (*ppos >= max_size) {
+	if (iocb->ki_pos >= max_size) {
 		ret = 0;
 		goto err_iounmap;
 	}
 
-	if (*ppos + count > max_size)
-		count = max_size - *ppos;
+	if (iocb->ki_pos + count > max_size)
+		count = max_size - iocb->ki_pos;
 
 	kbuf = kmalloc(count, GFP_KERNEL);
 	if (!kbuf) {
@@ -387,11 +388,11 @@ static ssize_t tboot_log_read(struct file *file, char __user *user_buf, size_t c
 		goto err_iounmap;
 	}
 
-	memcpy_fromio(kbuf, log_base + LOG_BUF_OFF + *ppos, count);
-	if (copy_to_user(user_buf, kbuf, count))
+	memcpy_fromio(kbuf, log_base + LOG_BUF_OFF + iocb->ki_pos, count);
+	if (!copy_to_iter_full(kbuf, count, to))
 		goto err_kfree;
 
-	*ppos += count;
+	iocb->ki_pos += count;
 
 	ret = count;
 
@@ -405,7 +406,7 @@ static ssize_t tboot_log_read(struct file *file, char __user *user_buf, size_t c
 }
 
 static const struct file_operations tboot_log_fops = {
-	.read	= tboot_log_read,
+	.read_iter	= tboot_log_read,
 	.llseek	= default_llseek,
 };
 
-- 
2.43.0


