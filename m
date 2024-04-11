Return-Path: <linux-kernel+bounces-141191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BC88A1B41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135CBB2E2A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FA91FB09A;
	Thu, 11 Apr 2024 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TKq4BZlw"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F321FB076
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850186; cv=none; b=BVIfxxoaDKlEA5lvCrn4z9KE1YFBuAuryz2GXw5z3XHZ+KvoFh37WYNWoqPxo1RF5K0D+xDNeCQQRUUzLPD+UcHIZCRbwHzifyacMNZdQzzqPvhYnAokjRteNv7gfBC6Lo1kwxbRjYVmUxqI/M6lAtsLI9cuPFF0zSvIWFGgrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850186; c=relaxed/simple;
	bh=tzqgYXHzifgFmNnKob1SoOuBoJxCVRmCZTCP63ibsvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQrgZvBlvb38kBX9afhsgH8Q13Ruj9BPQ2iZBKK5rrXOWti9zvzRc6wsyV2HYZ3AqhWqurUzOGEUEn1IFCyHyv71TbHf2AHsiHZkcUWGuyRicwR0W0On3H80XQOIcz9gtd4HDysFZOZT8hsUMHVLK0VgisgSgoqULQVGK0FugOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TKq4BZlw; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9108439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850183; x=1713454983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bbkgh6wS8rrxa/aA5ey6xEyhGsyTyT+2gX7v9UKwI0=;
        b=TKq4BZlwz6JbpPI1XZvdynz/9Wi1Js65ryfBFaqpB0JaHfXc3N1kB3WN8xPs5pgIY6
         1PNT2xmhNIvaSyeRSjp6LxkN27HsmN6NFX5GsO8sEr0jdfxQBsD0SGrfLJY2EOdNhFNe
         JH1KZ3EG1B4ugr+jOhXt+BjA+fIw3PJgMD/AQPEuGQ7ULDKPmpi2cr72ehCq2GqFJt1p
         Yc5uR0zOIJGl8VDLs9HIGXoh1YgybxND9AHDEJ5lE2gwlOwJjJUKy8+aM7nndfD9/lMG
         DqLyZXofMOjHgTb19Jq08g2XQc0Iv++csIZ7DJM/beiD1f3ZDRva6mm1OHVgvcnKgMal
         eUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850183; x=1713454983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bbkgh6wS8rrxa/aA5ey6xEyhGsyTyT+2gX7v9UKwI0=;
        b=sfh8NLYEAWRzncqk1XEeyeTJW4b/Gaug7mg7eC2Z5WwpqsNi7y7wsmR8Dv3LRGlqL5
         zQg8RSiZLKdlRr4WfZIftZQyp6HjLtGEq759qRLCOA+YK6tCe3YDGK7deqQg9Gzwiszd
         hGQIgiIuHuKyJF6F+XsytEo34HewtFukxSuT+uB4pCWwg1L787/KUZw2TZm8UatWPZDi
         GKBgt5rl4L/stHNhYxKVINEpbOhlMH2FwhXQHM3t23ieLsR9JPYt5gy2mlyR9l979QXi
         /m8kBQNLmTFa2BsLuMasS6RGe0Jr1DVTPszDeCyAHZu+JybqgwdRPCHEveVSXgeBdtcI
         BQQA==
X-Gm-Message-State: AOJu0YwxTvY3zMDFSiY31JHrVWKsyqYlwnm96t8hpL+j70IzqlCPw4LY
	l+MW366NUgCYe4dPMWdPAIrNIfr3qYY46LDR/uxwJtGJH96kzhIu4r04hgl1XK5OY/RrwELt/Yk
	Y
X-Google-Smtp-Source: AGHT+IFNS2ho9/DrVY3U4ajiFCP4C3UwWJDDLZf9vXn0GqoDYpz/E9QhMoSgWimR9OR17r25y7DSnA==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr34699ioc.1.1712850182327;
        Thu, 11 Apr 2024 08:43:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:43:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 407/437] infiniband/mlx5: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:19:07 -0600
Message-ID: <20240411153126.16201-408-axboe@kernel.dk>
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
 drivers/infiniband/hw/mlx5/cong.c | 19 ++++++++--------
 drivers/infiniband/hw/mlx5/devx.c | 24 +++++++++----------
 drivers/infiniband/hw/mlx5/main.c | 20 ++++++++--------
 drivers/infiniband/hw/mlx5/mr.c   | 38 +++++++++++++++----------------
 4 files changed, 49 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cong.c b/drivers/infiniband/hw/mlx5/cong.c
index a78a067e3ce7..b7ca85f516fc 100644
--- a/drivers/infiniband/hw/mlx5/cong.c
+++ b/drivers/infiniband/hw/mlx5/cong.c
@@ -368,10 +368,10 @@ static int mlx5_ib_set_cc_params(struct mlx5_ib_dev *dev, u32 port_num,
 	return err;
 }
 
-static ssize_t set_param(struct file *filp, const char __user *buf,
-			 size_t count, loff_t *pos)
+static ssize_t set_param(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_ib_dbg_param *param = filp->private_data;
+	struct mlx5_ib_dbg_param *param = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	int offset = param->offset;
 	char lbuf[11] = { };
 	u32 var;
@@ -380,7 +380,7 @@ static ssize_t set_param(struct file *filp, const char __user *buf,
 	if (count > sizeof(lbuf))
 		return -EINVAL;
 
-	if (copy_from_user(lbuf, buf, count))
+	if (!copy_from_iter_full(lbuf, count, from))
 		return -EFAULT;
 
 	lbuf[sizeof(lbuf) - 1] = '\0';
@@ -392,10 +392,9 @@ static ssize_t set_param(struct file *filp, const char __user *buf,
 	return ret ? ret : count;
 }
 
-static ssize_t get_param(struct file *filp, char __user *buf, size_t count,
-			 loff_t *pos)
+static ssize_t get_param(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_ib_dbg_param *param = filp->private_data;
+	struct mlx5_ib_dbg_param *param = iocb->ki_filp->private_data;
 	int offset = param->offset;
 	u32 var = 0;
 	int ret;
@@ -409,14 +408,14 @@ static ssize_t get_param(struct file *filp, char __user *buf, size_t count,
 	if (ret < 0)
 		return ret;
 
-	return simple_read_from_buffer(buf, count, pos, lbuf, ret);
+	return simple_copy_to_iter(lbuf, &iocb->ki_pos, ret, to);
 }
 
 static const struct file_operations dbg_cc_fops = {
 	.owner	= THIS_MODULE,
 	.open	= simple_open,
-	.write	= set_param,
-	.read	= get_param,
+	.write_iter	= set_param,
+	.read_iter	= get_param,
 };
 
 void mlx5_ib_cleanup_cong_debugfs(struct mlx5_ib_dev *dev, u32 port_num)
diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index 253fea374a72..a73c9ba11912 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2595,11 +2595,11 @@ void mlx5_ib_devx_cleanup(struct mlx5_ib_dev *dev)
 	}
 }
 
-static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
-					 size_t count, loff_t *pos)
+static ssize_t devx_async_cmd_event_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct devx_async_cmd_event_file *comp_ev_file = filp->private_data;
+	struct devx_async_cmd_event_file *comp_ev_file = iocb->ki_filp->private_data;
 	struct devx_async_event_queue *ev_queue = &comp_ev_file->ev_queue;
+	size_t count = iov_iter_count(to);
 	struct devx_async_data *event;
 	int ret = 0;
 	size_t eventsz;
@@ -2609,7 +2609,7 @@ static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
 	while (list_empty(&ev_queue->event_list)) {
 		spin_unlock_irq(&ev_queue->lock);
 
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		if (wait_event_interruptible(
@@ -2639,7 +2639,7 @@ static ssize_t devx_async_cmd_event_read(struct file *filp, char __user *buf,
 	list_del(ev_queue->event_list.next);
 	spin_unlock_irq(&ev_queue->lock);
 
-	if (copy_to_user(buf, &event->hdr, eventsz))
+	if (!copy_to_iter_full(&event->hdr, eventsz, to))
 		ret = -EFAULT;
 	else
 		ret = eventsz;
@@ -2670,18 +2670,18 @@ static __poll_t devx_async_cmd_event_poll(struct file *filp,
 
 static const struct file_operations devx_async_cmd_event_fops = {
 	.owner	 = THIS_MODULE,
-	.read	 = devx_async_cmd_event_read,
+	.read_iter	 = devx_async_cmd_event_read,
 	.poll    = devx_async_cmd_event_poll,
 	.release = uverbs_uobject_fd_release,
 	.llseek	 = no_llseek,
 };
 
-static ssize_t devx_async_event_read(struct file *filp, char __user *buf,
-				     size_t count, loff_t *pos)
+static ssize_t devx_async_event_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct devx_async_event_file *ev_file = filp->private_data;
+	struct devx_async_event_file *ev_file = iocb->ki_filp->private_data;
 	struct devx_event_subscription *event_sub;
 	struct devx_async_event_data *event;
+	size_t count = iov_iter_count(to);
 	int ret = 0;
 	size_t eventsz;
 	bool omit_data;
@@ -2701,7 +2701,7 @@ static ssize_t devx_async_event_read(struct file *filp, char __user *buf,
 	while (list_empty(&ev_file->event_list)) {
 		spin_unlock_irq(&ev_file->lock);
 
-		if (filp->f_flags & O_NONBLOCK)
+		if (iocb->ki_filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
 
 		if (wait_event_interruptible(ev_file->poll_wait,
@@ -2743,7 +2743,7 @@ static ssize_t devx_async_event_read(struct file *filp, char __user *buf,
 
 	spin_unlock_irq(&ev_file->lock);
 
-	if (copy_to_user(buf, event_data, eventsz))
+	if (!copy_to_iter_full(event_data, eventsz, to))
 		/* This points to an application issue, not a kernel concern */
 		ret = -EFAULT;
 	else
@@ -2785,7 +2785,7 @@ static void devx_free_subscription(struct rcu_head *rcu)
 
 static const struct file_operations devx_async_event_fops = {
 	.owner	 = THIS_MODULE,
-	.read	 = devx_async_event_read,
+	.read_iter	 = devx_async_event_read,
 	.poll    = devx_async_event_poll,
 	.release = uverbs_uobject_fd_release,
 	.llseek	 = no_llseek,
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index c2b557e64290..f531568cfead 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3154,25 +3154,25 @@ static int mlx5_ib_rn_get_params(struct ib_device *device, u32 port_num,
 	return mlx5_rdma_rn_get_params(to_mdev(device)->mdev, device, params);
 }
 
-static ssize_t delay_drop_timeout_read(struct file *filp, char __user *buf,
-				       size_t count, loff_t *pos)
+static ssize_t delay_drop_timeout_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_ib_delay_drop *delay_drop = filp->private_data;
+	struct mlx5_ib_delay_drop *delay_drop = iocb->ki_filp->private_data;
 	char lbuf[20];
 	int len;
 
 	len = snprintf(lbuf, sizeof(lbuf), "%u\n", delay_drop->timeout);
-	return simple_read_from_buffer(buf, count, pos, lbuf, len);
+	return simple_copy_to_iter(lbuf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t delay_drop_timeout_write(struct file *filp, const char __user *buf,
-					size_t count, loff_t *pos)
+static ssize_t delay_drop_timeout_write(struct kiocb *iocb,
+					struct iov_iter *from)
 {
-	struct mlx5_ib_delay_drop *delay_drop = filp->private_data;
+	struct mlx5_ib_delay_drop *delay_drop = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 timeout;
 	u32 var;
 
-	if (kstrtouint_from_user(buf, count, 0, &var))
+	if (kstrtouint_from_iter(from, count, 0, &var))
 		return -EFAULT;
 
 	timeout = min_t(u32, roundup(var, 100), MLX5_MAX_DELAY_DROP_TIMEOUT_MS *
@@ -3189,8 +3189,8 @@ static ssize_t delay_drop_timeout_write(struct file *filp, const char __user *bu
 static const struct file_operations fops_delay_drop_timeout = {
 	.owner	= THIS_MODULE,
 	.open	= simple_open,
-	.write	= delay_drop_timeout_write,
-	.read	= delay_drop_timeout_read,
+	.write_iter	= delay_drop_timeout_write,
+	.read_iter	= delay_drop_timeout_read,
 };
 
 static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a8ee2ca1f4a1..779da5c2f911 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -366,14 +366,14 @@ static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
 	}
 }
 
-static ssize_t size_write(struct file *filp, const char __user *buf,
-			  size_t count, loff_t *pos)
+static ssize_t size_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_cache_ent *ent = filp->private_data;
+	struct mlx5_cache_ent *ent = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 target;
 	int err;
 
-	err = kstrtou32_from_user(buf, count, 0, &target);
+	err = kstrtou32_from_iter(from, count, 0, &target);
 	if (err)
 		return err;
 
@@ -404,10 +404,9 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 	return err;
 }
 
-static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
-			 loff_t *pos)
+static ssize_t size_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_cache_ent *ent = filp->private_data;
+	struct mlx5_cache_ent *ent = iocb->ki_filp->private_data;
 	char lbuf[20];
 	int err;
 
@@ -416,24 +415,24 @@ static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(buf, count, pos, lbuf, err);
+	return simple_copy_to_iter(lbuf, &iocb->ki_pos, err, to);
 }
 
 static const struct file_operations size_fops = {
 	.owner	= THIS_MODULE,
 	.open	= simple_open,
-	.write	= size_write,
-	.read	= size_read,
+	.write_iter	= size_write,
+	.read_iter	= size_read,
 };
 
-static ssize_t limit_write(struct file *filp, const char __user *buf,
-			   size_t count, loff_t *pos)
+static ssize_t limit_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct mlx5_cache_ent *ent = filp->private_data;
+	struct mlx5_cache_ent *ent = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 var;
 	int err;
 
-	err = kstrtou32_from_user(buf, count, 0, &var);
+	err = kstrtou32_from_iter(from, count, 0, &var);
 	if (err)
 		return err;
 
@@ -450,10 +449,9 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	return count;
 }
 
-static ssize_t limit_read(struct file *filp, char __user *buf, size_t count,
-			  loff_t *pos)
+static ssize_t limit_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mlx5_cache_ent *ent = filp->private_data;
+	struct mlx5_cache_ent *ent = iocb->ki_filp->private_data;
 	char lbuf[20];
 	int err;
 
@@ -461,14 +459,14 @@ static ssize_t limit_read(struct file *filp, char __user *buf, size_t count,
 	if (err < 0)
 		return err;
 
-	return simple_read_from_buffer(buf, count, pos, lbuf, err);
+	return simple_copy_to_iter(lbuf, &iocb->ki_pos, err, to);
 }
 
 static const struct file_operations limit_fops = {
 	.owner	= THIS_MODULE,
 	.open	= simple_open,
-	.write	= limit_write,
-	.read	= limit_read,
+	.write_iter	= limit_write,
+	.read_iter	= limit_read,
 };
 
 static bool someone_adding(struct mlx5_mkey_cache *cache)
-- 
2.43.0


