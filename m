Return-Path: <linux-kernel+bounces-141003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF278A1A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 907051C211AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC3127E29;
	Thu, 11 Apr 2024 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IXEHDMDU"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE731C2FF8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849888; cv=none; b=LoLpNe0NV0bQxddOtd73/eiCuN+F/6mCbQBSXyuKJ5nfZYePeoCCQAK3gSiBGoXvh/Jhu8ncoEhBeTtimo8DhF2r8qBa3xfCPC3mZBWyYhRI1IXwMx/Y25bpV+JRao4O5PtK9eWFlqks71kVC56y91luDHelDDfSVtMVdx5Gzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849888; c=relaxed/simple;
	bh=3yIpst5kLmXkwWBNErLf6OLJBGgyTE9txj7gnX4Igc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DG7q6f8TMfmdE2hue3X4FrnUKTDmxj3foYQ5ARXZXRusEuJBoVh5c05NcKF8y+YCm9toudl+FZtRmBdMqA6NS4dalS7D4lMncLUcAn8snrrpCbMqJY8yMDU63H0ahU2mPKr+3iSWKsc05THThcnnCqqVs8VwuDEP4JQG8h9h1vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IXEHDMDU; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69614339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849886; x=1713454686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peTjKRC6X+86PGwc2Q6phD2WDOs6FCjj6AMdXL0+48U=;
        b=IXEHDMDUR8RJNf41ZCgk+msfbysMztyKSrVgQtaDoAdzhF9RFLwWXkgcHa+qkJccxl
         GDyJm6fCyvJCHJ/MEaKKJkUmAhyqSNkGmuB0wBoWTnOCOI3W7jm0fui/LbhYmb1AXcKz
         0c2I8nv6qOCtiDXSeCvwN2BYd/PbsxFqMsLHCmwaUP7/9qBff5JumfFnS/XeTKD/Pdx6
         iWCqhypEHq6DD4jTR0jYMX/4rZH+FzP2bGINFT69LzOU90/45qorjPjCe0vav30UayhU
         CPO7Kizs9mWlu3/y25CzRwFz+oYuUAOjvagzs/W3lA6wdOCPK6JHQV5CV3N+9XBcIzrb
         Vn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849886; x=1713454686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peTjKRC6X+86PGwc2Q6phD2WDOs6FCjj6AMdXL0+48U=;
        b=GFlOwMCuxozq+jqDBsV5hzCvhjfRNanh3nCi9IjYo5d4OpaiOmRoMEqHwoJkvDbnsd
         sL9/DNBdIMO866caH7IWiOJIBwxqE/eeyOFaIIPWGgLIjoGRo0dijHgpgkgD7oJ3c4LB
         jLhwO4rsl9yh7mUMFohPXBisERdlksbFS2LfhpsCRt7IwGIAjQI+ZJtUA5LKhEi6TiiS
         1jZvz1lCJ0vwBKl1ukQz4Cc+cf42+866VM7jvDzlp01mIzbYOPDKi7YrZ9eCGKDR7ekK
         1UUfvzs0rBHrA2y98SPfE/E+t7uFJNHTuE7/NOs13Su0KyGaNoaZ8K3LT0IwJeT+5+Al
         6yEA==
X-Gm-Message-State: AOJu0YzOkGVjg2kA5JTW+D6hWZtbXKcL78+npH4F2gZiydw97MhVG3lW
	0cJKos8Ybdx6moyZ02dpdJB3QQHWLbNKiGsknwsEeixiXZJSDVXqUK8xr59Sap7bIFhW+naMeIz
	U
X-Google-Smtp-Source: AGHT+IFqzDhd4vpIbktVNX7vcPIZY1szCHLjxjvrGB3WL7sDNMtmXGBxcSQrlI5mUWavOEmQOGbQhw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr197945iop.1.1712849885904;
        Thu, 11 Apr 2024 08:38:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 231/437] drivers/firewire: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:11 -0600
Message-ID: <20240411153126.16201-232-axboe@kernel.dk>
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
 drivers/firewire/core-cdev.c | 15 +++++++--------
 drivers/firewire/nosy.c      | 18 ++++++++----------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 6274b86eb943..ded5873c444b 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -301,9 +301,9 @@ static void queue_event(struct client *client, struct event *event,
 	wake_up_interruptible(&client->wait);
 }
 
-static int dequeue_event(struct client *client,
-			 char __user *buffer, size_t count)
+static int dequeue_event(struct client *client, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
 	struct event *event;
 	size_t size, total;
 	int i, ret;
@@ -326,7 +326,7 @@ static int dequeue_event(struct client *client,
 	total = 0;
 	for (i = 0; i < ARRAY_SIZE(event->v) && total < count; i++) {
 		size = min(event->v[i].size, count - total);
-		if (copy_to_user(buffer + total, event->v[i].data, size)) {
+		if (!copy_to_iter_full(event->v[i].data, size, to)) {
 			ret = -EFAULT;
 			goto out;
 		}
@@ -340,12 +340,11 @@ static int dequeue_event(struct client *client,
 	return ret;
 }
 
-static ssize_t fw_device_op_read(struct file *file, char __user *buffer,
-				 size_t count, loff_t *offset)
+static ssize_t fw_device_op_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct client *client = file->private_data;
+	struct client *client = iocb->ki_filp->private_data;
 
-	return dequeue_event(client, buffer, count);
+	return dequeue_event(client, to);
 }
 
 static void fill_bus_reset_event(struct fw_cdev_event_bus_reset *event,
@@ -1922,7 +1921,7 @@ const struct file_operations fw_device_ops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.open		= fw_device_op_open,
-	.read		= fw_device_op_read,
+	.read_iter	= fw_device_op_read,
 	.unlocked_ioctl	= fw_device_op_ioctl,
 	.mmap		= fw_device_op_mmap,
 	.release	= fw_device_op_release,
diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index b0d671db178a..d4e7f465afc4 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -133,8 +133,7 @@ packet_buffer_destroy(struct packet_buffer *buffer)
 	kfree(buffer->data);
 }
 
-static int
-packet_buffer_get(struct client *client, char __user *data, size_t user_length)
+static int packet_buffer_get(struct client *client, struct iov_iter *to)
 {
 	struct packet_buffer *buffer = &client->buffer;
 	size_t length;
@@ -154,15 +153,15 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
 	length = buffer->head->length;
 
 	if (&buffer->head->data[length] < end) {
-		if (copy_to_user(data, buffer->head->data, length))
+		if (!copy_to_iter_full(buffer->head->data, length, to))
 			return -EFAULT;
 		buffer->head = (struct packet *) &buffer->head->data[length];
 	} else {
 		size_t split = end - buffer->head->data;
 
-		if (copy_to_user(data, buffer->head->data, split))
+		if (!copy_to_iter_full(buffer->head->data, split, to))
 			return -EFAULT;
-		if (copy_to_user(data + split, buffer->data, length - split))
+		if (!copy_to_iter_full(buffer->data, length - split, to))
 			return -EFAULT;
 		buffer->head = (struct packet *) &buffer->data[length - split];
 	}
@@ -332,12 +331,11 @@ nosy_poll(struct file *file, poll_table *pt)
 	return ret;
 }
 
-static ssize_t
-nosy_read(struct file *file, char __user *buffer, size_t count, loff_t *offset)
+static ssize_t nosy_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct client *client = file->private_data;
+	struct client *client = iocb->ki_filp->private_data;
 
-	return packet_buffer_get(client, buffer, count);
+	return packet_buffer_get(client, to);
 }
 
 static long
@@ -393,7 +391,7 @@ nosy_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 static const struct file_operations nosy_ops = {
 	.owner =		THIS_MODULE,
-	.read =			nosy_read,
+	.read_iter =		nosy_read,
 	.unlocked_ioctl =	nosy_ioctl,
 	.poll =			nosy_poll,
 	.open =			nosy_open,
-- 
2.43.0


