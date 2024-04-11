Return-Path: <linux-kernel+bounces-140836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B18A193D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18920B2B440
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6EE130A60;
	Thu, 11 Apr 2024 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X7laa+Db"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB312FB27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849632; cv=none; b=HpsXY5C9+FfZcJjoxfvhMzbDh02Im9yWMvDd7jxvZf3s39FNGDeT//7XJcnL78S45sYVPxZmnLCH1J/hm3ZZyxI7rEHojy8Jqde/BXvtlsnxLABcyXYvFT/RUzyN7TjLqvbEcLKPqjvkriC3MUXOixrlVHWuwQaxnGDKrVdnwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849632; c=relaxed/simple;
	bh=LsKfHEdm3+sfLpTCdcPfNA/yJBUTGKlz7wgkVgloVGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2xPM0/nWPPWE0HDAwyrk0CP2xs3shJhAwZlEhHjQqC38k7xtlkZCStwg0XYPdpeHFt73jUYEb+A1tuideE/g6dr87uJri0O4Or9rpjz6/2e19tAA6U6IhD+rXC8te939ylRpd4XY9D4l95waw1Jfw2zO5FErZfgyE0N+TXiGc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X7laa+Db; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8893339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849630; x=1713454430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N9ahDuoY+zuQ2pr2PQD3XrVwZo+VQLYGz05dfATnSU=;
        b=X7laa+DbJkZ1QgBv1wZamEyZ3xMO2Kx449hhNYbHOIe4JSjxm+weH8CWTNDpvh1Xt9
         /9ZXeWI1au/SPEujq2t+wcpwBAGoCXc+ieeJG9I7I2abgNujRNLtMwNurwV3V/Ib7+ls
         0U8VG1+gTUXnGiFHzSWUqxfdQe/mobA6NaWw46Gul8M3DQ74M7cwzlHtkBzgChuESEI7
         GY9dYbrFYjQo76NMzq2K8/ANzkoJJ7ECZ7VyuKlp7DEuGxNNPSolR1t6Xk5h5kHgkAKK
         PF3GuQOOWQ7aVA7QKFqWDq+78LBRL0m8qdHcrEwwcHFpzjkx2JkNYkyvXdo3LoQjtXdX
         zxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849630; x=1713454430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N9ahDuoY+zuQ2pr2PQD3XrVwZo+VQLYGz05dfATnSU=;
        b=jeADzV9J/pWSnrYJOQlePYVrYosI6gTs2esfzR05tjfdTZycO9+Lhr2cUXQgVV7TiM
         lS/0EVtetXtfnsvDBiKhkacM0x447tec8HmE50Mjgkuj0mnY2mIf2jDdyUzeVzLjfOHz
         KLTEvOqt19nNPqzkOWM2e4EozhkWWW3JqE/RhsKYND6LrrUhbHMBYt/NFr2cBviiyGMl
         p6G5KcCUwSWrdCz5K6lK8DGzdXbNNAXJYTWu6aaBqNqWOYVsNV/OP2NsevpUsdo9/T/w
         +Rnpemijfh4qQ944lXKNMRzYKYBWilHg+slNexqMnyluvhQSWGqJbVEmA7Z6Ty+O0v+6
         Ag2g==
X-Gm-Message-State: AOJu0YwQPpUVQ7ecYxU03zjEA+iNOSHpggd0UozROBiBcxDtYQaDXFvu
	MUH/wNJ69ztfkYe0oA66SXxhMGRlObHHuFl04r3xCUfPg2GjI5tSpQ9K+pNdWXdG9ha93H5yxxz
	l
X-Google-Smtp-Source: AGHT+IFQbCHYS0+c2WDHitRJDmcwowpJbdZqr759gqvFJ74QCi5r692XOEO+HzeiGFKiFnWStqAW6g==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr216099ioh.0.1712849629726;
        Thu, 11 Apr 2024 08:33:49 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 075/437] kernel/power: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:35 -0600
Message-ID: <20240411153126.16201-76-axboe@kernel.dk>
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
 kernel/power/qos.c  | 21 ++++++++++-----------
 kernel/power/user.c | 28 ++++++++++++----------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..eeea74bc639a 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -363,10 +363,9 @@ static int cpu_latency_qos_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t cpu_latency_qos_read(struct file *filp, char __user *buf,
-				    size_t count, loff_t *f_pos)
+static ssize_t cpu_latency_qos_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct pm_qos_request *req = filp->private_data;
+	struct pm_qos_request *req = iocb->ki_filp->private_data;
 	unsigned long flags;
 	s32 value;
 
@@ -377,33 +376,33 @@ static ssize_t cpu_latency_qos_read(struct file *filp, char __user *buf,
 	value = pm_qos_get_value(&cpu_latency_constraints);
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
-	return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(s32));
+	return simple_copy_to_iter(&value, &iocb->ki_pos, sizeof(s32), to);
 }
 
-static ssize_t cpu_latency_qos_write(struct file *filp, const char __user *buf,
-				     size_t count, loff_t *f_pos)
+static ssize_t cpu_latency_qos_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	s32 value;
 
 	if (count == sizeof(s32)) {
-		if (copy_from_user(&value, buf, sizeof(s32)))
+		if (!copy_from_iter_full(&value, sizeof(s32), from))
 			return -EFAULT;
 	} else {
 		int ret;
 
-		ret = kstrtos32_from_user(buf, count, 16, &value);
+		ret = kstrtos32_from_iter(from, count, 16, &value);
 		if (ret)
 			return ret;
 	}
 
-	cpu_latency_qos_update_request(filp->private_data, value);
+	cpu_latency_qos_update_request(iocb->ki_filp->private_data, value);
 
 	return count;
 }
 
 static const struct file_operations cpu_latency_qos_fops = {
-	.write = cpu_latency_qos_write,
-	.read = cpu_latency_qos_read,
+	.write_iter = cpu_latency_qos_write,
+	.read_iter = cpu_latency_qos_read,
 	.open = cpu_latency_qos_open,
 	.release = cpu_latency_qos_release,
 	.llseek = noop_llseek,
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 3aa41ba22129..1dcdfbf240a9 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -131,17 +131,16 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t snapshot_read(struct file *filp, char __user *buf,
-                             size_t count, loff_t *offp)
+static ssize_t snapshot_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	loff_t pg_offp = *offp & ~PAGE_MASK;
+	loff_t pg_offp = iocb->ki_pos & ~PAGE_MASK;
 	struct snapshot_data *data;
 	unsigned int sleep_flags;
 	ssize_t res;
 
 	sleep_flags = lock_system_sleep();
 
-	data = filp->private_data;
+	data = iocb->ki_filp->private_data;
 	if (!data->ready) {
 		res = -ENODATA;
 		goto Unlock;
@@ -154,10 +153,9 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 		res = PAGE_SIZE - pg_offp;
 	}
 
-	res = simple_read_from_buffer(buf, count, &pg_offp,
-			data_of(data->handle), res);
+	res = simple_copy_to_iter(data_of(data->handle), &iocb->ki_pos, res, to);
 	if (res > 0)
-		*offp += res;
+		iocb->ki_pos += res;
 
  Unlock:
 	unlock_system_sleep(sleep_flags);
@@ -165,10 +163,9 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
 	return res;
 }
 
-static ssize_t snapshot_write(struct file *filp, const char __user *buf,
-                              size_t count, loff_t *offp)
+static ssize_t snapshot_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	loff_t pg_offp = *offp & ~PAGE_MASK;
+	loff_t pg_offp = iocb->ki_pos & ~PAGE_MASK;
 	struct snapshot_data *data;
 	unsigned long sleep_flags;
 	ssize_t res;
@@ -180,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 
 	sleep_flags = lock_system_sleep();
 
-	data = filp->private_data;
+	data = iocb->ki_filp->private_data;
 
 	if (!pg_offp) {
 		res = snapshot_write_next(&data->handle);
@@ -195,10 +192,9 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		goto unlock;
 	}
 
-	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
-			buf, count);
+	res = simple_copy_from_iter(data_of(data->handle), &iocb->ki_pos, res, from);
 	if (res > 0)
-		*offp += res;
+		iocb->ki_pos += res;
 unlock:
 	unlock_system_sleep(sleep_flags);
 
@@ -445,8 +441,8 @@ snapshot_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations snapshot_fops = {
 	.open = snapshot_open,
 	.release = snapshot_release,
-	.read = snapshot_read,
-	.write = snapshot_write,
+	.read_iter = snapshot_read,
+	.write_iter = snapshot_write,
 	.llseek = no_llseek,
 	.unlocked_ioctl = snapshot_ioctl,
 #ifdef CONFIG_COMPAT
-- 
2.43.0


