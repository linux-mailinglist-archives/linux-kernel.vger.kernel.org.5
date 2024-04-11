Return-Path: <linux-kernel+bounces-140999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E58A1A09
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DFF52824FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31031C125F;
	Thu, 11 Apr 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="x1tJ53kN"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3081C1AE6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849882; cv=none; b=Rba1FCcJSM2LfqXIh5gyjB92huD7Z1W67kFTTTBCpyr6sgUKBqPexuokyOolRbBftEsNgHflnLtMUCnEUtR2IBW7i2IUzVpeC9PCYWuA6H2OS+Gs4FFjW/sc6T9I31BOPT7INZ/iCljg/jv7fDzE0g2vEcQPpRIWoPRVp6dnH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849882; c=relaxed/simple;
	bh=6X6jAKa3dWU3lq3ru8ux95v8OJLf7IzSdNHkXzZB8OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBOnAXkXxHI7qb5pO/xIehxO1rXRFQIhV+yaDYbIAf4RxaVNy00FPXrvni0GUuWkeRPSXIZA69x0+K42uNQ4q6+SlpHsn5fzxWUVZvpWv/7jAWu9Kpl7WOd8tKZxQYwuBUUqUEe04ie8+n9R9RvySz4VZp9Hi+Un2cczzc3fVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=x1tJ53kN; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9830239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849879; x=1713454679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8tWM1HuHPpRlDt3cdCZk4Rq3a8/t27j4pr9RvVTiQw=;
        b=x1tJ53kNOkdfmhpAh3hFLz4VrevEvyFGYp47wU9Xq4V723wpRkiPDJAhX1dIZOUfSv
         mgwsxnzBsqXSBsjBLnKcwa0Dtc1zkTKKkjA75d3cOAH2HpLZwRdrZKbqr69hjrX+6Hhn
         Jd7/X7vgci56z3hkQHpE9vlPv/sYIb3onCfqWqMTZJW0jf/w4qT+VcjUWE1E5piK3irm
         ewRtA0bjlgnSXrm/mjhhMWQLsFnQEZz0CjkmAM0Nz4mObYMfclKop0u8I/dh13hXvcVd
         04r5NhDbMNsUqVHVwamO9ts5Q56IRaam7c2nG54A8b6L+zb25AEGjDR9IwgLyV771N3H
         2OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849879; x=1713454679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8tWM1HuHPpRlDt3cdCZk4Rq3a8/t27j4pr9RvVTiQw=;
        b=RFBds3HotLAbrvJpysytukgZPe/zfV/OcQc00ZzwS+R3TzESKSbsnFmBZRXH1ngK0W
         peeooIHUgm9pJfkPDvn5BZrCiNsqg4kC4UfsTG3NOYwCcmD6c5zpnnd9fvXPImVGTG7D
         JEiJv62vzNQ6+hWG19kAOgTwF2/9CtqaT33aWjwbOOSscLk3tqsVZz22+PYdqvGcbrSZ
         d8Tfxr2TTf6X0p4muNEGtG7L0odWUyw76sYMZKUbWji6Pec35si2IjJ32Tcyg2MGKDOO
         qZ326pXO+DV0o2zD81kyf6Q7kDdxHRNkUEolutjNCIHnkKdE61W46hGpwmeUnh2mF4HB
         ASMQ==
X-Gm-Message-State: AOJu0YzzbgkSciDrsr0n+tOR9gfAV0HNmIPH8raSGPBrBuSjmXjc5ozK
	5nO+7W4WyxbdCgXczsvMZ/YzNDntGnN/YzqbMsik6rPAPM3SXbf4EbJ3E6lWyPrqMlSQKAscf19
	3
X-Google-Smtp-Source: AGHT+IHMkSCiCyAQ43i3rGFmnOms9FbdSB+Lgec75jE2V21MxYMsWwTg2GqPaKFenYH199gPJkWELw==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr46000iob.2.1712849879651;
        Thu, 11 Apr 2024 08:37:59 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 227/437] misc: ibmasm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:07 -0600
Message-ID: <20240411153126.16201-228-axboe@kernel.dk>
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
 drivers/misc/ibmasm/ibmasmfs.c | 94 ++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasmfs.c b/drivers/misc/ibmasm/ibmasmfs.c
index c44de892a61e..8f7ea4214d20 100644
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -256,18 +256,19 @@ static int command_file_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t command_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+static ssize_t command_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ibmasmfs_command_data *command_data = file->private_data;
+	struct ibmasmfs_command_data *command_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	struct command *cmd;
 	int len;
 	unsigned long flags;
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count == 0 || count > IBMASM_CMD_MAX_BUFFER_SIZE)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	spin_lock_irqsave(&command_data->sp->lock, flags);
@@ -284,7 +285,7 @@ static ssize_t command_file_read(struct file *file, char __user *buf, size_t cou
 		return -EIO;
 	}
 	len = min(count, cmd->buffer_size);
-	if (copy_to_user(buf, cmd->buffer, len)) {
+	if (!copy_to_iter_full(cmd->buffer, len, to)) {
 		command_put(cmd);
 		return -EFAULT;
 	}
@@ -293,17 +294,18 @@ static ssize_t command_file_read(struct file *file, char __user *buf, size_t cou
 	return len;
 }
 
-static ssize_t command_file_write(struct file *file, const char __user *ubuff, size_t count, loff_t *offset)
+static ssize_t command_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ibmasmfs_command_data *command_data = file->private_data;
+	struct ibmasmfs_command_data *command_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct command *cmd;
 	unsigned long flags;
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count == 0 || count > IBMASM_CMD_MAX_BUFFER_SIZE)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	/* commands are executed sequentially, only one command at a time */
@@ -314,7 +316,7 @@ static ssize_t command_file_write(struct file *file, const char __user *ubuff, s
 	if (!cmd)
 		return -ENOMEM;
 
-	if (copy_from_user(cmd->buffer, ubuff, count)) {
+	if (!copy_from_iter_full(cmd->buffer, count, from)) {
 		command_put(cmd);
 		return -EFAULT;
 	}
@@ -365,19 +367,20 @@ static int event_file_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t event_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+static ssize_t event_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ibmasmfs_event_data *event_data = file->private_data;
+	struct ibmasmfs_event_data *event_data = iocb->ki_filp->private_data;
 	struct event_reader *reader = &event_data->reader;
 	struct service_processor *sp = event_data->sp;
+	size_t count = iov_iter_count(to);
 	int ret;
 	unsigned long flags;
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count == 0 || count > IBMASM_EVENT_MAX_SIZE)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	spin_lock_irqsave(&sp->lock, flags);
@@ -397,7 +400,7 @@ static ssize_t event_file_read(struct file *file, char __user *buf, size_t count
 		goto out;
 	}
 
-        if (copy_to_user(buf, reader->data, reader->data_size)) {
+        if (!copy_to_iter_full(reader->data, reader->data_size, to)) {
 		ret = -EFAULT;
 		goto out;
 	}
@@ -408,15 +411,16 @@ static ssize_t event_file_read(struct file *file, char __user *buf, size_t count
 	return ret;
 }
 
-static ssize_t event_file_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
+static ssize_t event_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ibmasmfs_event_data *event_data = file->private_data;
+	struct ibmasmfs_event_data *event_data = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count != 1)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	ibmasm_cancel_next_event(&event_data->reader);
@@ -449,17 +453,18 @@ static int r_heartbeat_file_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t r_heartbeat_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+static ssize_t r_heartbeat_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct ibmasmfs_heartbeat_data *rhbeat = file->private_data;
+	struct ibmasmfs_heartbeat_data *rhbeat = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	unsigned long flags;
 	int result;
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count == 0 || count > 1024)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	/* allow only one reverse heartbeat per process */
@@ -477,15 +482,16 @@ static ssize_t r_heartbeat_file_read(struct file *file, char __user *buf, size_t
 	return result;
 }
 
-static ssize_t r_heartbeat_file_write(struct file *file, const char __user *buf, size_t count, loff_t *offset)
+static ssize_t r_heartbeat_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct ibmasmfs_heartbeat_data *rhbeat = file->private_data;
+	struct ibmasmfs_heartbeat_data *rhbeat = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count != 1)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	if (rhbeat->active)
@@ -499,9 +505,9 @@ static int remote_settings_file_close(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t remote_settings_file_read(struct file *file, char __user *buf, size_t count, loff_t *offset)
+static ssize_t remote_settings_file_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	void __iomem *address = (void __iomem *)file->private_data;
+	void __iomem *address = (void __iomem *)iocb->ki_filp->private_data;
 	int len = 0;
 	unsigned int value;
 	char lbuf[20];
@@ -509,28 +515,28 @@ static ssize_t remote_settings_file_read(struct file *file, char __user *buf, si
 	value = readl(address);
 	len = snprintf(lbuf, sizeof(lbuf), "%d\n", value);
 
-	return simple_read_from_buffer(buf, count, offset, lbuf, len);
+	return simple_copy_to_iter(lbuf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t remote_settings_file_write(struct file *file, const char __user *ubuff, size_t count, loff_t *offset)
+static ssize_t remote_settings_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	void __iomem *address = (void __iomem *)file->private_data;
+	void __iomem *address = (void __iomem *)iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	char *buff;
 	unsigned int value;
 
-	if (*offset < 0)
+	if (iocb->ki_pos < 0)
 		return -EINVAL;
 	if (count == 0 || count > 1024)
 		return 0;
-	if (*offset != 0)
+	if (iocb->ki_pos != 0)
 		return 0;
 
 	buff = kzalloc (count + 1, GFP_KERNEL);
 	if (!buff)
 		return -ENOMEM;
 
-
-	if (copy_from_user(buff, ubuff, count)) {
+	if (!copy_from_iter_full(buff, count, from)) {
 		kfree(buff);
 		return -EFAULT;
 	}
@@ -545,32 +551,32 @@ static ssize_t remote_settings_file_write(struct file *file, const char __user *
 static const struct file_operations command_fops = {
 	.open =		command_file_open,
 	.release =	command_file_close,
-	.read =		command_file_read,
-	.write =	command_file_write,
+	.read_iter =	command_file_read,
+	.write_iter =	command_file_write,
 	.llseek =	generic_file_llseek,
 };
 
 static const struct file_operations event_fops = {
 	.open =		event_file_open,
 	.release =	event_file_close,
-	.read =		event_file_read,
-	.write =	event_file_write,
+	.read_iter =	event_file_read,
+	.write_iter =	event_file_write,
 	.llseek =	generic_file_llseek,
 };
 
 static const struct file_operations r_heartbeat_fops = {
 	.open =		r_heartbeat_file_open,
 	.release =	r_heartbeat_file_close,
-	.read =		r_heartbeat_file_read,
-	.write =	r_heartbeat_file_write,
+	.read_iter =	r_heartbeat_file_read,
+	.write_iter =	r_heartbeat_file_write,
 	.llseek =	generic_file_llseek,
 };
 
 static const struct file_operations remote_settings_fops = {
 	.open =		simple_open,
 	.release =	remote_settings_file_close,
-	.read =		remote_settings_file_read,
-	.write =	remote_settings_file_write,
+	.read_iter =	remote_settings_file_read,
+	.write_iter =	remote_settings_file_write,
 	.llseek =	generic_file_llseek,
 };
 
-- 
2.43.0


