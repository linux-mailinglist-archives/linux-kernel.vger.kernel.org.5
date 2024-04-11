Return-Path: <linux-kernel+bounces-141061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC88A1A48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206751C22A15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5271D2A08;
	Thu, 11 Apr 2024 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nYUqtFwi"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440081D29E7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849978; cv=none; b=TKl0Qy/h0OQxxmV5Efomy7KGAFvxx8owr/XnOojMcC27vUT1CE9t0jGY37Yi2rI0hhWRszLdB6SB6EbW82YG1n/o7sAt8ipn9HZdhOP99lhFXWnOSKDnJPvrFDI5Umgj1RnAg/JsS6hsmG3qjXT6OpQX+PY5KEjzzxMuN7Pc+ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849978; c=relaxed/simple;
	bh=Oi1CL4SZ7jF5iZGPiPuWgGK8ZRI8ipyz2HPqUMkXGTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdDDjrSpTZgZRGsP+zDbl0Nd1LQtzxl2Ctr/HvkXTVXcR1Lt7twmJTHFwa4MFpCi0wnFvHnWMrxjYOfZOJQQ6rhfFwV25Dy7p/CUPlEYkMsq1nOR74jw4ka4LmPosH7RDuGvgw3Tj1PDehYAPjJtwNXg1lrCIHmsPErk2dEmqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nYUqtFwi; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16213939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849976; x=1713454776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCrr/tS5aR2avoRP2BBFyz38JLXO1ubG5EpJ8aJmhaU=;
        b=nYUqtFwipJX7ZeQxeOhAPZz9k7x8bbpazOLQUdCiFqtURc1xG4LJ3gcAAxoYlOd9+R
         aMMFFZVagv5CFPCQ9MtZJurD6x5mc9DCCIdTJEuOgnXCTGVaaBj5WitR7FEDT8Gbvy9u
         pVl3yzapGqwwpk5t3v7plarfSa70ddacA8HtdMJTCUUTCagFzp46fYOynfmeWENI+k1D
         K1q+pVBWKxYcoriaEeckmzLTKecCInIvw23/AVGEtVo0904qO41HvRUd/Jwg44RCPHrG
         CNhdAu86CdJLzuAsiK3TRMV2GYWOYQ7/f5a+jwiPY0wpQdHIGTlpMSwnGszESk0Gggzt
         EMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849976; x=1713454776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCrr/tS5aR2avoRP2BBFyz38JLXO1ubG5EpJ8aJmhaU=;
        b=DJM02hMqZR9QDCSIJIZcPFVonawi4xMRkXsDyOZIJ6U/h21H1K0L4VRehq4CKCqHfL
         7g/TUSbGnB0aOjOK9v8eR6TgyuPWuEzRQnX6hEFuxwkaOKqf1H4x3Hxf+oJiEr/kKRVG
         MlIxBxeejTTBmaayUFqDyxDbezTfack4pcgOjE2Nrwira82O76VJtzkJTFwEtGaNtGHJ
         P/Z0MpbJ7Zql2di4Pspg1XF1APwsLAAUc8iLYb/nm0Jj2srQupaM5z8n0DQ2m1g5b91H
         CToQ6tZAe2M28HZ9/ZbOionYQGBXDA7NAIq2pQnt/CqaniqTFRA8V+352qgusPeq5vSx
         fRsA==
X-Gm-Message-State: AOJu0YyVlRSS23BL14Iq4XsWQ9ik+iYAn5z1N/vY/FbdG2BRfmrMQdGB
	uA/9QYFS+dF9INSHZ8EkpNsVfZiLPgFIkvyqUWoQoSTBwXNz4kCE/MREKhTBaRWQxNGacKk7o2Q
	D
X-Google-Smtp-Source: AGHT+IG3PcXy2sM7qioOv3aZPlpA11Fr3mjwfnVeG9gcwygon6ME7zge95ABkf8g6X/YripE4PZpAg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr209462iog.0.1712849976065;
        Thu, 11 Apr 2024 08:39:36 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:33 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 287/437] cachefiles: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:07 -0600
Message-ID: <20240411153126.16201-288-axboe@kernel.dk>
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
 fs/cachefiles/daemon.c   | 35 ++++++++++++++++-------------------
 fs/cachefiles/internal.h |  4 ++--
 fs/cachefiles/ondemand.c |  5 +++--
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 6465e2574230..4a6a31a76d35 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -23,10 +23,8 @@
 
 static int cachefiles_daemon_open(struct inode *, struct file *);
 static int cachefiles_daemon_release(struct inode *, struct file *);
-static ssize_t cachefiles_daemon_read(struct file *, char __user *, size_t,
-				      loff_t *);
-static ssize_t cachefiles_daemon_write(struct file *, const char __user *,
-				       size_t, loff_t *);
+static ssize_t cachefiles_daemon_read(struct kiocb *, struct iov_iter *);
+static ssize_t cachefiles_daemon_write(struct kiocb *, struct iov_iter *);
 static __poll_t cachefiles_daemon_poll(struct file *,
 					   struct poll_table_struct *);
 static int cachefiles_daemon_frun(struct cachefiles_cache *, char *);
@@ -50,8 +48,8 @@ const struct file_operations cachefiles_daemon_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cachefiles_daemon_open,
 	.release	= cachefiles_daemon_release,
-	.read		= cachefiles_daemon_read,
-	.write		= cachefiles_daemon_write,
+	.read_iter	= cachefiles_daemon_read,
+	.write_iter	= cachefiles_daemon_write,
 	.poll		= cachefiles_daemon_poll,
 	.llseek		= noop_llseek,
 };
@@ -207,8 +205,9 @@ static int cachefiles_daemon_release(struct inode *inode, struct file *file)
 }
 
 static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
-					 char __user *_buffer, size_t buflen)
+					 struct iov_iter *to)
 {
+	size_t buflen = iov_iter_count(to);
 	unsigned long long b_released;
 	unsigned f_released;
 	char buffer[256];
@@ -245,7 +244,7 @@ static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
 	if (n > buflen)
 		return -EMSGSIZE;
 
-	if (copy_to_user(_buffer, buffer, n) != 0)
+	if (!copy_to_iter_full(buffer, n, to) != 0)
 		return -EFAULT;
 
 	return n;
@@ -254,10 +253,9 @@ static ssize_t cachefiles_do_daemon_read(struct cachefiles_cache *cache,
 /*
  * Read the cache state.
  */
-static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
-				      size_t buflen, loff_t *pos)
+static ssize_t cachefiles_daemon_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cachefiles_cache *cache = file->private_data;
+	struct cachefiles_cache *cache = iocb->ki_filp->private_data;
 
 	//_enter(",,%zu,", buflen);
 
@@ -265,21 +263,20 @@ static ssize_t cachefiles_daemon_read(struct file *file, char __user *_buffer,
 		return 0;
 
 	if (cachefiles_in_ondemand_mode(cache))
-		return cachefiles_ondemand_daemon_read(cache, _buffer, buflen);
+		return cachefiles_ondemand_daemon_read(cache, to);
 	else
-		return cachefiles_do_daemon_read(cache, _buffer, buflen);
+		return cachefiles_do_daemon_read(cache, to);
 }
 
 /*
  * Take a command from cachefilesd, parse it and act on it.
  */
-static ssize_t cachefiles_daemon_write(struct file *file,
-				       const char __user *_data,
-				       size_t datalen,
-				       loff_t *pos)
+static ssize_t cachefiles_daemon_write(struct kiocb *iocb,
+				       struct iov_iter *from)
 {
 	const struct cachefiles_daemon_cmd *cmd;
-	struct cachefiles_cache *cache = file->private_data;
+	struct cachefiles_cache *cache = iocb->ki_filp->private_data;
+	size_t datalen = iov_iter_count(from);
 	ssize_t ret;
 	char *data, *args, *cp;
 
@@ -294,7 +291,7 @@ static ssize_t cachefiles_daemon_write(struct file *file,
 		return -EOPNOTSUPP;
 
 	/* drag the command string into the kernel so we can parse it */
-	data = memdup_user_nul(_data, datalen);
+	data = iterdup_nul(from, datalen);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d33169f0018b..2b5565d38cb3 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -298,7 +298,7 @@ extern bool cachefiles_commit_tmpfile(struct cachefiles_cache *cache,
  */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
-					char __user *_buffer, size_t buflen);
+					struct iov_iter *to);
 
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
@@ -341,7 +341,7 @@ static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *
 
 #else
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
-					char __user *_buffer, size_t buflen)
+					struct iov_iter *to)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..e27144ff2050 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -295,8 +295,9 @@ static struct cachefiles_req *cachefiles_ondemand_select_req(struct xa_state *xa
 }
 
 ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
-					char __user *_buffer, size_t buflen)
+					struct iov_iter *to)
 {
+	size_t buflen = iov_iter_count(to);
 	struct cachefiles_req *req;
 	struct cachefiles_msg *msg;
 	unsigned long id = 0;
@@ -345,7 +346,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	msg->msg_id = id;
 	msg->object_id = req->object->ondemand->ondemand_id;
 
-	if (copy_to_user(_buffer, msg, n) != 0) {
+	if (!copy_to_iter_full(msg, n, to) != 0) {
 		ret = -EFAULT;
 		goto err_put_fd;
 	}
-- 
2.43.0


