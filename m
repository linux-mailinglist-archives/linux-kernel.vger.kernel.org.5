Return-Path: <linux-kernel+bounces-140932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAE18A19AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C2C283EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86091C68BB;
	Thu, 11 Apr 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nzORRSOT"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027781C6897
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849780; cv=none; b=IZB1XuGgtP+G/QBrTxXrLexVLnf0AL53x2miRFc0AeLb9L/DYN3SXA/kVfOj9xJLbHXjVOyj+NL3I20x56clHYbCFeMZ5nuIMNkNhhRxeQypXBDys9YruBXuXB+FYVj+karES9a7p4Fo9egvuv3qfqoK2d6RTmKlbGjMXUxsPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849780; c=relaxed/simple;
	bh=1TJUdxOn8SvAXo66++GiAauAMR1729Nqfb3kGJAZDIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDUSO93DCLQzy2Nemf8Fi581JXDxatLrxVVW8ZEzi+cfbuFcuHy24Gu7ahQ71zu8wgeYcsQxJh7vXN/9A+VIdVrNpzfXVKVu+k/pMvUfhqScdmfiyxzZt+YB2Iccp+FI1PZUY9q8iSsR5uzYgpqitXa5Fg0lJgaPzZlUbKrGyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nzORRSOT; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16163039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849778; x=1713454578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBv8IDfSRUn7twlyubV+EXaW21C9+wFsBX7NFxTWmg8=;
        b=nzORRSOTrAvyZa5xczWkuu7rcrMpH2Ow4epWZGpBEBzYqKkdiJitXCOPP91IBQVnN8
         /KpOaCfZQExnP0AjRulGlWpckkQzSGOQ5kmNAIYDA9/EAI0Y1cJy85oaj2qXjHZ6BjQa
         PcijK7WjzqSIizID2QKtOwK8lNxixrxlrmC0xraNqScKAgVHLXhvMAU6uiMSxEIwdIQV
         D3KEsvBq8TcK/YBf8wN1jcn6ZGpyG+5tdJ4D76R/IvzNqjEA92l0rhJTm3iVUYiHXDRF
         XvcIo0YZbxLYiVtZuZRMEISZOdCtD4BUVcUSBHVZSbuys53FKbNVpkIVysP9qFWiW+qk
         SMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849778; x=1713454578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBv8IDfSRUn7twlyubV+EXaW21C9+wFsBX7NFxTWmg8=;
        b=Mgq6qSGXliYXpmOoMk2zpOg7QvhnrpNnk2nritynJbauqXgNMXNTvXRPXpjUvTc6NR
         kdcQKMFEWQOVVJi5GHbLWyJsnU7K+D7wmPXRWoeNOfcssW8Oa1Ma3vZAG5tcTU0gyJqe
         p/Idulzug0sERYnfmNkex5Y5zFc2nxe1tP7Z/Rwz0XuGsHbvkvneTRCWWWPpSiNBw6n1
         CsZOHam7uY8oi6zQEBwDBbIwXjMjIcn8meetpq6vHu2yHiuJhM5dAPZ6sulbrxQlT5xy
         cohCkwt2jNrjPpsJKuKZ3MAVl+W7v7hVbIaRu1mUwqmPvpq72gZ8Nj1K+y3iuXBLpIps
         VAxg==
X-Gm-Message-State: AOJu0YxER+frnreifGoocOYXk3gpCmyjQ/h+9u4Mj4sDWEoe09vdkQ2G
	/JAstBIFrB59fNKuZ5MMpqLjzYP2vwJ6L4a6NLF/3AL4UEMVJhaFHxbHu4nR4pM51cp8pEY7fD0
	k
X-Google-Smtp-Source: AGHT+IGMI/yfjAT3P3XF1d37Q192CNsL+f0/c34WOuNXUh+w+XXfzuRfJ1JP3RVpic8nNGkmIiHlXw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr161397ioh.1.1712849777808;
        Thu, 11 Apr 2024 08:36:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 164/437] usb: host: ohci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:04 -0600
Message-ID: <20240411153126.16201-165-axboe@kernel.dk>
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
 drivers/usb/host/ohci-dbg.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ohci-dbg.c b/drivers/usb/host/ohci-dbg.c
index 76bc8d56325d..dc40e655f824 100644
--- a/drivers/usb/host/ohci-dbg.c
+++ b/drivers/usb/host/ohci-dbg.c
@@ -361,27 +361,27 @@ static int debug_async_open(struct inode *, struct file *);
 static int debug_periodic_open(struct inode *, struct file *);
 static int debug_registers_open(struct inode *, struct file *);
 static int debug_async_open(struct inode *, struct file *);
-static ssize_t debug_output(struct file*, char __user*, size_t, loff_t*);
+static ssize_t debug_output(struct kiocb *, struct iov_iter *);
 static int debug_close(struct inode *, struct file *);
 
 static const struct file_operations debug_async_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_async_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
 static const struct file_operations debug_periodic_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_periodic_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
 static const struct file_operations debug_registers_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_registers_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
@@ -701,10 +701,9 @@ static int fill_buffer(struct debug_buffer *buf)
 	return ret;
 }
 
-static ssize_t debug_output(struct file *file, char __user *user_buf,
-			size_t len, loff_t *offset)
+static ssize_t debug_output(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debug_buffer *buf = file->private_data;
+	struct debug_buffer *buf = iocb->ki_filp->private_data;
 	int ret;
 
 	mutex_lock(&buf->mutex);
@@ -717,9 +716,7 @@ static ssize_t debug_output(struct file *file, char __user *user_buf,
 	}
 	mutex_unlock(&buf->mutex);
 
-	ret = simple_read_from_buffer(user_buf, len, offset,
-				      buf->page, buf->count);
-
+	ret = simple_copy_to_iter(buf->page, &iocb->ki_pos, buf->count, to);
 out:
 	return ret;
 
-- 
2.43.0


