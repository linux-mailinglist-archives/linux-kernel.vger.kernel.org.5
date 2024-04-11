Return-Path: <linux-kernel+bounces-140788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FC8A18FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8CB1C21171
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316354656;
	Thu, 11 Apr 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eQ4cyajF"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65D153E09
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849543; cv=none; b=FFqcM/rIGsUdVjXp7cxCdP2KZekrmrM+AqUwWqQlDmABOalS9DzhnJm6AjXCSTiXFSdc1nM4bFKKa0e1vRJV3W/EWIS6eqPSzn2/j30FU+li43vX74J1l4m6eDuoDIUX7TVBH/bigQEVck+NrbKbQIMc0z+Yge8in0YmXsq5zJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849543; c=relaxed/simple;
	bh=HzrrndI3sspGuOXaTKEU6Gr6N5suncD/ymmoDiyLICc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtJtg6IqSQdyF1b+T9dvaUKREOY1IiO78Z2UmUhyRfnVrfLd0eAaVA2vZcDJ34EDo1b4+zIez1O252gh/JDZ5NxSbizph2yuS4K7Gt1YOa9f1gtfugJIxebmizhDxEmkxbo0ujOF6uY5E9kl8YKPXyl/FzIeVdCNkvp93GukW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eQ4cyajF; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180594139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849540; x=1713454340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jN1Jw/IXKI5zVUuW8F2edL/9uqR+v8xiG6E13Jt2DE=;
        b=eQ4cyajFSpzXe5UAXZllBPyDVZICw+j2vyM9bHFgRDiN1XB6mW311NGSro+U4XlcyJ
         W72t4SuRcmurzjrAdxlCndt/9yJpJqw+B2AJi2i2zyAoW6ZwjUkEgObgjLXIzn6CW/q9
         fRnyiBE9Ja1Q7Nafzd78NFIU3cqQbzY+U+eeyPcvuuW28z7zXtBW/zP4qjMJb5oKFqPO
         0nSM57zkH5FoAI5zFej+ZfIG+93lhNAGAcwMeQIkoKD6fpkIPjHH5iH7z67iZeDvOWx8
         Pv0SRoY2KzMpR7lB/60W4YFfNu/s8gsHXZVjNNkkUUnY9gHTqMprwIlPB/YK/aWV7lsw
         /UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849540; x=1713454340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jN1Jw/IXKI5zVUuW8F2edL/9uqR+v8xiG6E13Jt2DE=;
        b=l5oB8DaJcryWhp+SqM/SvH+NfNnVuTuVFUzMbi3UlGJ6usfXCgWQjbuzXbPb+AmOr+
         93tk7/67/0M0QzNCK8UyymA14iY7O3owgFrPh1QkIN9rrQXeL9wrL3VQTwkrD9pIlORu
         8/Z+tX+pp5pHvlTVBKXEoGMlbNSrGIhPwbTiUztO85nwOKMEvtqgKi1KZxFLVcGhP+vJ
         qNKZWK4Etestp6fDUmmAlRHnyre/zPZliXT31fsOzumcPl3TU0cIUgy8j12Nhl9ZWO6S
         mrz4LbUqlecZ+PUxypHHOcAIfxYE1mLwdKbFMIJaBDuFQJhiONY6arqL1rSE4soMguEQ
         qBEw==
X-Gm-Message-State: AOJu0YyxqB8057bPBm3AvI0mSgRQJirspTapD4dncFBaFobL52d57Y4a
	AZraN+hEhAVNdqJBa7vOTgRW2Z1x2RO7F7YLJlaBX0qwYcoe8WuQe4sBO2tklBulDy/HHm9CSQj
	Y
X-Google-Smtp-Source: AGHT+IFB9Ius/I9JeYSwlEd4gMR6WoxifUIeNFPqgwRTTEC7GRf/hNsQKI6UI8HDcPO6lZ82+ln+jQ==
X-Received: by 2002:a92:d812:0:b0:369:bf80:e367 with SMTP id y18-20020a92d812000000b00369bf80e367mr6232801ilm.3.1712849540581;
        Thu, 11 Apr 2024 08:32:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 031/437] char/ppdev: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:51 -0600
Message-ID: <20240411153126.16201-32-axboe@kernel.dk>
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
 drivers/char/ppdev.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213..4176b2b59dc9 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -112,10 +112,11 @@ static inline void pp_enable_irq(struct pp_struct *pp)
 	port->ops->enable_irq(port);
 }
 
-static ssize_t pp_read(struct file *file, char __user *buf, size_t count,
-		       loff_t *ppos)
+static ssize_t pp_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	struct file *file = iocb->ki_filp;
 	unsigned int minor = iminor(file_inode(file));
+	size_t count = iov_iter_count(to);
 	struct pp_struct *pp = file->private_data;
 	char *kbuffer;
 	ssize_t bytes_read = 0;
@@ -182,7 +183,7 @@ static ssize_t pp_read(struct file *file, char __user *buf, size_t count,
 
 	parport_set_timeout(pp->pdev, pp->default_inactivity);
 
-	if (bytes_read > 0 && copy_to_user(buf, kbuffer, bytes_read))
+	if (bytes_read > 0 && !copy_to_iter_full(kbuffer, bytes_read, to))
 		bytes_read = -EFAULT;
 
 	kfree(kbuffer);
@@ -190,10 +191,11 @@ static ssize_t pp_read(struct file *file, char __user *buf, size_t count,
 	return bytes_read;
 }
 
-static ssize_t pp_write(struct file *file, const char __user *buf,
-			size_t count, loff_t *ppos)
+static ssize_t pp_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	unsigned int minor = iminor(file_inode(file));
+	size_t count = iov_iter_count(from);
 	struct pp_struct *pp = file->private_data;
 	char *kbuffer;
 	ssize_t bytes_written = 0;
@@ -222,7 +224,7 @@ static ssize_t pp_write(struct file *file, const char __user *buf,
 	while (bytes_written < count) {
 		ssize_t n = min_t(unsigned long, count - bytes_written, PP_BUFFER_SIZE);
 
-		if (copy_from_user(kbuffer, buf + bytes_written, n)) {
+		if (!copy_from_iter_full(kbuffer, n, from)) {
 			bytes_written = -EFAULT;
 			break;
 		}
@@ -780,8 +782,8 @@ static const struct class ppdev_class = {
 static const struct file_operations pp_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.read		= pp_read,
-	.write		= pp_write,
+	.read_iter	= pp_read,
+	.write_iter	= pp_write,
 	.poll		= pp_poll,
 	.unlocked_ioctl	= pp_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
-- 
2.43.0


