Return-Path: <linux-kernel+bounces-141179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB038A1B6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52AC9B2C7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC841F82FA;
	Thu, 11 Apr 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oLAwG6yk"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54521F82C6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850166; cv=none; b=EY9zdETSSRFnFOWN6tC/ESDwQL4EtNbYF3bNfcUbpUZsLZqk8n+tT0BVHDU1n84QGUzli75tf0FivF/4Wv0GRVO4U84t83cTRaiQqlrH3YrtVVH+0gNG2isAVFaNzPggpxOScDyrl1Q0WK22Ay6Vk1Wp0jw0n7Bj6dwGS5JhJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850166; c=relaxed/simple;
	bh=yy/6GmbRnjGCw0g0ryIHbYYSRWyWwmvA16ZADkWlDLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPKkKQkj//P0awQ94+hSvcHWKXm23Kvmp12hPLKa80pQAV8D1Cx26rh0jajFII1pDiYlPjLpaZvN90exdeeTalj7X57WdBbpEWkKb+xrRm/KbwV7gtUZ8kgOM3swWmGJfcU+Ubq6w9w+ENIc9Z9hyoJuKIGOfalsFczqi+G9zTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oLAwG6yk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-36a34b68277so123945ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850163; x=1713454963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fj6UziE2dihlMcRRDHp7rGOT3rMAa8UR8NL//b4tju8=;
        b=oLAwG6ykxpffoAZzBMut/ohchbjEPCP6qPUmqs0jhQhXB8P+28kgfuMgMYP20P/S1n
         4AO/HDKIBs8TOh2BOm2dILvP7y+KSaWsuMNVGgEd22MdXg2O9CLj3Kem4RX2BR6j3iWP
         olq5jgnSiQxTcmM5BDyQU1r+HjsFvwd1YhcSmN9ILzLup55/ZD42JYf5Ur8cHJT5l047
         nUiocqGDpkWWy2ffp5DR2Crt3OfiscVOX4PoGXpz3x2tZEJD51stbCbjDO/LvjlrzNlQ
         /bHGVS+8tg3IyXRwha1rQ2zHBKU3FIrEIz6wgJimVory10yDc1OLh+iK5QUOM3olpGc2
         UCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850163; x=1713454963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fj6UziE2dihlMcRRDHp7rGOT3rMAa8UR8NL//b4tju8=;
        b=WdgfYKSUl58gIsC7uXUzu+cHVWESe4OMOOyi+K2WQE/geN8Z4Iz3rwH9XNnag4nem1
         t93gHGRgd8QO8p0KhRyLLNiG+qXxC4eH3gsXvRp+fH8XqUaHqrNWBYqsQqGc5qFDqXMs
         GNrZHg8p3rtwmkh3wOZgCz6X65jvXT5iHax4/KHhaT6WGkd44MCtg7EJzXQBi18wHQas
         o1LB3nryaDZYwQZEGm16b/eubvrH39eJxP9ARGDU3Eb0/YzXJjxPfvblCB6dMoSxBBrx
         apOXUcUzhcbMCm40gC4+4XGxgBkDWQQM9B5B5KdAWDzNmYBL+Rlv1EV7WCdcON7wiOMD
         /9vQ==
X-Gm-Message-State: AOJu0YxLKcPxxhtCnU9G8LBCOxu/yO83lwMrH3SVB8RfBKFLRSP0WzGG
	bLr5Vdxe2MeVxE9wM0FKV75+WwZJVLPpXq2ojTf+uNA9JAjnFiBJeRQwlh8SD4GZRa8DLl9Ujq2
	5
X-Google-Smtp-Source: AGHT+IF9XT5rUmB9QDMVaBtp9Y4fdHKeii3oUC+8dPlDAWql5xz9CIt+pA9tC8yHgAtq6LSpYXenRA==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr203729iob.0.1712850163701;
        Thu, 11 Apr 2024 08:42:43 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 395/437] hsi: clients: cmt_speech: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:55 -0600
Message-ID: <20240411153126.16201-396-axboe@kernel.dk>
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
 drivers/hsi/clients/cmt_speech.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index daa8e1bff5d9..8de1beb45119 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1126,10 +1126,10 @@ static __poll_t cs_char_poll(struct file *file, poll_table *wait)
 	return ret;
 }
 
-static ssize_t cs_char_read(struct file *file, char __user *buf, size_t count,
-								loff_t *unused)
+static ssize_t cs_char_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct cs_char *csdata = file->private_data;
+	struct cs_char *csdata = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(to);
 	u32 data;
 	ssize_t retval;
 
@@ -1152,7 +1152,7 @@ static ssize_t cs_char_read(struct file *file, char __user *buf, size_t count,
 
 		if (data)
 			break;
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		} else if (signal_pending(current)) {
@@ -1165,7 +1165,7 @@ static ssize_t cs_char_read(struct file *file, char __user *buf, size_t count,
 		finish_wait(&csdata->wait, &wait);
 	}
 
-	retval = put_user(data, (u32 __user *)buf);
+	retval = put_iter(data, to);
 	if (!retval)
 		retval = sizeof(data);
 
@@ -1173,10 +1173,10 @@ static ssize_t cs_char_read(struct file *file, char __user *buf, size_t count,
 	return retval;
 }
 
-static ssize_t cs_char_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *unused)
+static ssize_t cs_char_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct cs_char *csdata = file->private_data;
+	struct cs_char *csdata = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	u32 data;
 	int err;
 	ssize_t	retval;
@@ -1184,7 +1184,7 @@ static ssize_t cs_char_write(struct file *file, const char __user *buf,
 	if (count < sizeof(data))
 		return -EINVAL;
 
-	if (get_user(data, (u32 __user *)buf))
+	if (get_iter(data, from))
 		retval = -EFAULT;
 	else
 		retval = count;
@@ -1349,8 +1349,8 @@ static int cs_char_release(struct inode *unused, struct file *file)
 
 static const struct file_operations cs_char_fops = {
 	.owner		= THIS_MODULE,
-	.read		= cs_char_read,
-	.write		= cs_char_write,
+	.read_iter	= cs_char_read,
+	.write_iter	= cs_char_write,
 	.poll		= cs_char_poll,
 	.unlocked_ioctl	= cs_char_ioctl,
 	.mmap		= cs_char_mmap,
-- 
2.43.0


