Return-Path: <linux-kernel+bounces-140864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA438A1941
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EFA1F235DD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C3813A3F9;
	Thu, 11 Apr 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="SL9JZSpp"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCB13A88F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849676; cv=none; b=JZ4pEi2PmpJv5nravC1osrjSzMnN4LmrVwl9SqQU17UfgYTRtXlvB6t5Cv0/66BF6YsYJZCGLCdW2r9QQFi64Dd0cKViVIv6rPfOtzxUHw7Zx/ZlCgLF9K04R94mLTib2hT/1HOo/WCgaPUyJPzDWIyvD21Zz1Xgd1z53qIUiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849676; c=relaxed/simple;
	bh=p8d488wkRo5nDc8R6DlGCaIrfG56wn1pZbHgl4s6SRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJyXwayaDV3j0rTwzF4o+ofyAq73piE2Y7ziqIAmJ7nRI+AF3AoFrc9m6phqQz0EF1njH//rKdNeEpipBcbp1qPgBPh5wj/G9SQpfcfIoRh77UIxJJCDNMqZWLVQXE+BU2zTJX9L4xAToQOeOhVueBO+PHqRNyvDuZa8K/JzSTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=SL9JZSpp; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170480539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849673; x=1713454473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HxVAxXkHDWlwHAWZ+aWYAyKYEYbdX7k4joaDRZl4as=;
        b=SL9JZSppcVIvo7l/PFn7abolSJgNrcEhqbjm+PJ+MYt7jwyuRE2Fffv6BmyP1VW9H/
         yLhv9OsMrQUeMI6DBWoajRsP7/p0tidtSTqjcVI4YhVMG5UzrqvFhaT2Eon8upwKjf0P
         JqKjoR1Rjc6RmXcwrSVKb5AKq6TvybEodBoCxI2rRkG3Duevzoq1BAXsm8whUzGk1IMJ
         Fx7JOnAB2tp/nQ3bYYHJrRMTiXobej4huj6S/VuWSNVCj5nWD6S4YLWHvPDymUxFoXkA
         ON5V4OIxhqG3WKAko0cWm8iy+p8mvWLO8QjG2Rvcip3yiKvO7bjrRXss8k0InmWopyE0
         xgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849673; x=1713454473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HxVAxXkHDWlwHAWZ+aWYAyKYEYbdX7k4joaDRZl4as=;
        b=g2gMlx8rl4of8F1YVCRjpWrVnd45xMX+fOb9ornD8D4gSJXklocllZNhryf9nGbkI1
         4421kJiVpBSuHjC66Ynn6weHfwa2/aErXoH2dq4Gd0B/wzNkiMpVVKx2HS8DT4t5enTX
         k8qjll0DqtDi/osjVxYiz9Gx9V1PCPLMJEx42StfGpjYPVTXCRSOz5A++Mwa5sRbuJP4
         4KCKet1l1Qx1pVbx3653pJOEHEUdGXHAAlB9j6gkg7JqKYKBLWO6DUHRAm7SkFV9TahY
         HbCJVshq64x/8Ro9v94tOCauS5e9ZKGFtVEEBEXWmy/lZ1W7lnOE5MeCtOky3YbZpq9C
         Rvxg==
X-Gm-Message-State: AOJu0YzfzERLi9O8dMVMlmfBUBtsQlCK+GlqLBZ65q18UjuZvR7FB9n4
	L6j3Q1k9KVXnJioOupE4pTT0Fd42/aTy8uA2kgJqsseDPcBl6vnAmRUdH/pn7SLJUZCJYKXkaPw
	u
X-Google-Smtp-Source: AGHT+IHEyav1JwNE6p3N+fBdHYjSDUFmLV09EhcPb1fb3ELM/9/AwQfRYSXe+abM09MmaENZutV/eA==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr218209ioh.0.1712849673482;
        Thu, 11 Apr 2024 08:34:33 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:32 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 101/437] s390/dasd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:01 -0600
Message-ID: <20240411153126.16201-102-axboe@kernel.dk>
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
 drivers/s390/block/dasd.c      | 34 +++++++++++++++++++++++++++-------
 drivers/s390/block/dasd_eer.c  | 12 ++++++------
 drivers/s390/block/dasd_int.h  |  1 +
 drivers/s390/block/dasd_proc.c |  2 +-
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0a97cfedd706..789e8c47e6ee 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -897,6 +897,7 @@ void dasd_profile_off(struct dasd_profile *profile)
 	spin_unlock_bh(&profile->lock);
 }
 
+/* this can go away once proc is converted to ->write_iter() */
 char *dasd_get_user_string(const char __user *user_buf, size_t user_len)
 {
 	char *buffer;
@@ -916,18 +917,37 @@ char *dasd_get_user_string(const char __user *user_buf, size_t user_len)
 	return buffer;
 }
 
-static ssize_t dasd_stats_write(struct file *file,
-				const char __user *user_buf,
-				size_t user_len, loff_t *pos)
+char *dasd_get_iter_string(struct iov_iter *from)
+{
+	size_t user_len = iov_iter_count(from);
+	char *buffer;
+
+	buffer = vmalloc(user_len + 1);
+	if (buffer == NULL)
+		return ERR_PTR(-ENOMEM);
+	if (!copy_from_iter_full(buffer, user_len, from)) {
+		vfree(buffer);
+		return ERR_PTR(-EFAULT);
+	}
+	/* got the string, now strip linefeed. */
+	if (buffer[user_len - 1] == '\n')
+		buffer[user_len - 1] = 0;
+	else
+		buffer[user_len] = 0;
+	return buffer;
+}
+
+static ssize_t dasd_stats_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	char *buffer, *str;
 	int rc;
-	struct seq_file *m = (struct seq_file *)file->private_data;
+	struct seq_file *m = iocb->ki_filp->private_data;
 	struct dasd_profile *prof = m->private;
+	size_t user_len = iov_iter_count(from);
 
 	if (user_len > 65536)
 		user_len = 65536;
-	buffer = dasd_get_user_string(user_buf, user_len);
+	buffer = dasd_get_iter_string(from);
 	if (IS_ERR(buffer))
 		return PTR_ERR(buffer);
 
@@ -1042,10 +1062,10 @@ static int dasd_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations dasd_stats_raw_fops = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_stats_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
-	.write		= dasd_stats_write,
+	.write_iter	= dasd_stats_write,
 };
 
 static void dasd_profile_init(struct dasd_profile *profile,
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 194e9e2d9cb8..476d6cf80089 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -592,15 +592,15 @@ static int dasd_eer_close(struct inode *inp, struct file *filp)
 	return 0;
 }
 
-static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
-			     size_t count, loff_t *ppos)
+static ssize_t dasd_eer_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	int tc,rc;
 	int tailcount,effective_count;
         unsigned long flags;
 	struct eerbuffer *eerb;
 
-	eerb = (struct eerbuffer *) filp->private_data;
+	eerb = (struct eerbuffer *) iocb->ki_filp->private_data;
 	if (mutex_lock_interruptible(&readbuffer_mutex))
 		return -ERESTARTSYS;
 
@@ -625,7 +625,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 				/* no data available */
 				spin_unlock_irqrestore(&bufferlock, flags);
 				mutex_unlock(&readbuffer_mutex);
-				if (filp->f_flags & O_NONBLOCK)
+				if (iocb->ki_filp->f_flags & O_NONBLOCK)
 					return -EAGAIN;
 				rc = wait_event_interruptible(
 					dasd_eer_read_wait_queue,
@@ -647,7 +647,7 @@ static ssize_t dasd_eer_read(struct file *filp, char __user *buf,
 
 	spin_unlock_irqrestore(&bufferlock, flags);
 
-	if (copy_to_user(buf, readbuffer, effective_count)) {
+	if (!copy_to_iter_full(readbuffer, effective_count, to)) {
 		mutex_unlock(&readbuffer_mutex);
 		return -EFAULT;
 	}
@@ -676,7 +676,7 @@ static __poll_t dasd_eer_poll(struct file *filp, poll_table *ptable)
 static const struct file_operations dasd_eer_fops = {
 	.open		= &dasd_eer_open,
 	.release	= &dasd_eer_close,
-	.read		= &dasd_eer_read,
+	.read_iter	= &dasd_eer_read,
 	.poll		= &dasd_eer_poll,
 	.owner		= THIS_MODULE,
 	.llseek		= noop_llseek,
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index e5f40536b425..be7d6875b054 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -897,6 +897,7 @@ void dasd_profile_reset(struct dasd_profile *);
 int dasd_profile_on(struct dasd_profile *);
 void dasd_profile_off(struct dasd_profile *);
 char *dasd_get_user_string(const char __user *, size_t);
+char *dasd_get_iter_string(struct iov_iter *);
 
 /* externals in dasd_devmap.c */
 extern int dasd_max_devindex;
diff --git a/drivers/s390/block/dasd_proc.c b/drivers/s390/block/dasd_proc.c
index 0faaa437d9be..b97d1227b9b0 100644
--- a/drivers/s390/block/dasd_proc.c
+++ b/drivers/s390/block/dasd_proc.c
@@ -317,7 +317,7 @@ static ssize_t dasd_stats_proc_write(struct file *file,
 
 static const struct proc_ops dasd_stats_proc_ops = {
 	.proc_open	= dasd_stats_proc_open,
-	.proc_read	= seq_read,
+	.proc_read_iter	= seq_read_iter,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
 	.proc_write	= dasd_stats_proc_write,
-- 
2.43.0


