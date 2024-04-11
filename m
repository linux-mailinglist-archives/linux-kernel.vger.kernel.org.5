Return-Path: <linux-kernel+bounces-140832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489A8A1999
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4355B2C10C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300A12C816;
	Thu, 11 Apr 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="it+Jnjhk"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225212BF29
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849625; cv=none; b=Rnc0YZ49mvgrJyMW4VWZUQ21WQCuLbDPYwMc3hMdm8YfQA2rvw7KLx8dB8yoawHs0fJKOoW2mKx9ePASABjA2Hv2RoWEbC0CVlIQfbT/xlNrRnkal0pJKsoO7HJC1tVxq/rboJ7mBxl61iErVl1a5zRJgFsq/c4RcYyzmaoo/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849625; c=relaxed/simple;
	bh=Zrb9qOHAYQmCQMm3S19eAIdu+BbUBaZP/otKUs2EJRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ny1H46xLF43+k1H1o4v0rWwplhHTW91R9h6db+/XmE/d/A6NWX3iwZ5lWcKMzOicBnNUZGbCYByXNh23ycKIcFDbb6tlBDzp+qX8y1fTTcsBJ8IXoQp0Zr/i1PhC52tKFznvhL0i1OExkJIlOamfaDJqhRZlUyJU97BZ8Qzk61s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=it+Jnjhk; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16124739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849623; x=1713454423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SvvTE0GFGfdacX6nff1GiupvKPbkS4LIGd9MDwOd6Q=;
        b=it+JnjhkZY4bn+sXPfTsRqvbKnjgvSCitkfWk0EFaJ59eS4NB+QzOgoWTCmVtPzuaa
         UUKhTQbOxr0G85wF1HBCZgGrjHXavxU3EHeW8aKpx8+ayI7fCT9c+aIbPNr9+V1fApE5
         r8niQLpb8oh63Uy7A9e8JVSWuRvyBK74OyW8SMEVqT4Sw6f7d3cSG+EjX1mSqE/Kt4PQ
         nk3iCp+YuNkQagk9Ec8w8Q166WhG9h2BJgFqUmOEqSD7Ri7tCsnPSdTPwnPHj1VAFXIj
         fWJ7k1zdxY/ea8qwqa+JgOTreROnLlnJQN/Zd3/9V///jpLq4KuOVn5pNes4mAnkeME8
         9uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849623; x=1713454423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3SvvTE0GFGfdacX6nff1GiupvKPbkS4LIGd9MDwOd6Q=;
        b=bVigCg7mgUFvxvJdszOB2D0VhZL7SKW+QtaFK7MQaFCnCqnbO6xMjNMyA7wvsXyEq3
         Lw3p61XTqqDTCwzpzrR3YepHmielVsDu8K4lr0g5t9qDhoqlpG+NH0G8uUxwl3roGnB6
         Dw/U5Bgu8EeBYoV7ljHT0bTTlQkcBOEPZOVOtA2rP706xvuWT/8DdAEOqVtLaK3b2W0b
         M4idb4GQnHzmbdzSvfGd0EXtkPY/UrdpSysjs+SjNdiOq6RCEj4rMHxbzgK4phU7LKbF
         dFCo93b+DMp0PAI8H1NdtvuGZ3ReVDACvIx4wE2ihCcrgTEfLc8fbqqA9UeFRA615D6n
         Yf0A==
X-Gm-Message-State: AOJu0YzTGt9IVoVSwOHcrg7dbOvV7V/Ed+XWi8ptIq/gRUfa8o4spLhN
	Wgq3cLJp0wlyacaJa7IrTkVq8fVaLAEpgiHhPp5T1vCGyCdTqPNahKZfXjzWLBZcctYcXHnvrP7
	V
X-Google-Smtp-Source: AGHT+IF9iTDD2NkAPVET7m6aD77wDbz5J4+cifHBFb/ROln3OLgf+CJj0xEl5Mg+0thBna6RMKGzOQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr175481iov.2.1712849622725;
        Thu, 11 Apr 2024 08:33:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:41 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 071/437] dma-debug: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:31 -0600
Message-ID: <20240411153126.16201-72-axboe@kernel.dk>
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
 kernel/dma/debug.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index a6e3792b15f8..4be49922129b 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -717,8 +717,7 @@ static void dma_entry_free(struct dma_debug_entry *entry)
  *   2. Preallocate a given number of dma_debug_entry structs
  */
 
-static ssize_t filter_read(struct file *file, char __user *user_buf,
-			   size_t count, loff_t *ppos)
+static ssize_t filter_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char buf[NAME_MAX_LEN + 1];
 	unsigned long flags;
@@ -736,12 +735,12 @@ static ssize_t filter_read(struct file *file, char __user *user_buf,
 	len = scnprintf(buf, NAME_MAX_LEN + 1, "%s\n", current_driver_name);
 	read_unlock_irqrestore(&driver_name_lock, flags);
 
-	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+	return simple_copy_to_iter(buf, &iocb->ki_pos, len, to);
 }
 
-static ssize_t filter_write(struct file *file, const char __user *userbuf,
-			    size_t count, loff_t *ppos)
+static ssize_t filter_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	char buf[NAME_MAX_LEN];
 	unsigned long flags;
 	size_t len;
@@ -754,7 +753,7 @@ static ssize_t filter_write(struct file *file, const char __user *userbuf,
 	 * need to copy to temporary buffer first
 	 */
 	len = min(count, (size_t)(NAME_MAX_LEN - 1));
-	if (copy_from_user(buf, userbuf, len))
+	if (!copy_from_iter_full(buf, len, from))
 		return -EFAULT;
 
 	buf[len] = 0;
@@ -804,8 +803,8 @@ static ssize_t filter_write(struct file *file, const char __user *userbuf,
 }
 
 static const struct file_operations filter_fops = {
-	.read  = filter_read,
-	.write = filter_write,
+	.read_iter  = filter_read,
+	.write_iter = filter_write,
 	.llseek = default_llseek,
 };
 
-- 
2.43.0


