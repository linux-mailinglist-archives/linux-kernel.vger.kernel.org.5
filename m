Return-Path: <linux-kernel+bounces-140931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADA88A19AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 572891C2268A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771E31C68A0;
	Thu, 11 Apr 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lgpw3Tqx"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBF61C233E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849778; cv=none; b=D6Gwb+8oVT8ToJtQUIUgcZ6u/PcOC7FTQEwEezvrA8xSXD4gIei2YgISPqykr5s/IGf1QHf5kwUydY+hnFaN2LpoZnf9DHGDEasFBYdgZnP+XRXvcXt6mN9Xoabl7ew7qD7OyPcdhzkHDlp+iF4v15cbbDzotxKfxoe/Kz5KCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849778; c=relaxed/simple;
	bh=/R2BeYlhfrBa/htPCC3HHf2TvwcQYfAjQ5baP8YTlLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SA1Cg8vwGNDLVZScgqEf/hmJEzdn0l7LQr0uC0lJr0zFF2fOVS/mBpBpcqoRFP6h1vfx0RdYlMH3zOKE2+N5i1JA4ao3hXLb6Xn/BRLeAAyPVHNOnRNkrHiALqgTSEyTyVsr02uuRbw9B5ki8EBYtbIjhDtw6b+Q61sqyu9QAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Lgpw3Tqx; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36a34b68277so110735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849776; x=1713454576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pbp/RQnmR075DrC7x5KXesv8hnwC9YQtvtSngsJEyrQ=;
        b=Lgpw3TqxQvdeqR4iWNmLah9LmXFR3VL8tUxTffJO/0cSEkbb/cm8GuE53+qhmM+ncD
         lD4WH7qQZjjbyM41blzmTuLBE1Ug+hz6w2x4nz9nHL3/PgxwtsrccRuiHhqFADYP8Mgh
         JzfUZTcfahwaAmENdo3HhTnHab3h9Zq/j70OrXAnD85nhgE7CjgNvj5ZN5YnMp6J51Zc
         ZDxMljnqSkI/9XkduENh8kfWykD2LXX5WriDJnXug+z6y+aEdD9TzF1Jif/72c2ZPxhV
         XyofPjwKUwnr3wdgqvNUtVWsKa8WHEHnBPRkKrdQ9GotSvY4I0kQjFDOGz3PGYQfKYIp
         SyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849776; x=1713454576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbp/RQnmR075DrC7x5KXesv8hnwC9YQtvtSngsJEyrQ=;
        b=m9A4vFfevgMj8fc1NHegeo5o8NLyBMmZ20nhAEHr+JlTbWTzpeXGbaMxewLJupKVBF
         nEIlRPX5wqyRr0o63c1VH37sQT2gQqDWQXe4pK62p5KRpIZTQBOyUkNQ56AB2/bnzER4
         0ksr9cI5ZSCCFNliyJxu8wG0k8TfF7V7EoiV4Yt0joI5Ot6NbJ4UonCRGPDikjoR3rpw
         ojdp6WSfPv0u+fcMMKXtEYVS6cUxZSPjMJNBpOasBUJmjkj3+3q6HJ+4PgcJa39UqCqq
         2pjmgUFF19/lXEqJiYXlp90PGiCHFJAnpNVwYOOKTwWpWWHJ2X3Hwr1q0m7wK3okzwxB
         Hsrw==
X-Gm-Message-State: AOJu0Yzeor0Z3KfUDOcUGS3zrw4BAfDgaOvhUbueBCP15ietALsWBLTj
	AtSeWsQQQNvQJDkq7SF0QEDkautc6Qxe2NIkAwbDSwD2juaYjM8X1SqUVM117VPgWiKOj3v5VRY
	n
X-Google-Smtp-Source: AGHT+IGLq54DEe1zhqCraahGOdGsPkzsePVXA+w4AS3YhdrJmGgj6lDhuKgH977fWczZg5qz3VHK9A==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr188498iob.0.1712849776330;
        Thu, 11 Apr 2024 08:36:16 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 163/437] usb: host: ehci: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:03 -0600
Message-ID: <20240411153126.16201-164-axboe@kernel.dk>
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
 drivers/usb/host/ehci-dbg.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index c063fb042926..c9390a17c432 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -293,13 +293,13 @@ static int debug_bandwidth_open(struct inode *, struct file *);
 static int debug_periodic_open(struct inode *, struct file *);
 static int debug_registers_open(struct inode *, struct file *);
 
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
@@ -307,7 +307,7 @@ static const struct file_operations debug_async_fops = {
 static const struct file_operations debug_bandwidth_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_bandwidth_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
@@ -315,7 +315,7 @@ static const struct file_operations debug_bandwidth_fops = {
 static const struct file_operations debug_periodic_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_periodic_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
@@ -323,7 +323,7 @@ static const struct file_operations debug_periodic_fops = {
 static const struct file_operations debug_registers_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_registers_open,
-	.read		= debug_output,
+	.read_iter	= debug_output,
 	.release	= debug_close,
 	.llseek		= default_llseek,
 };
@@ -952,10 +952,9 @@ static int fill_buffer(struct debug_buffer *buf)
 	return ret;
 }
 
-static ssize_t debug_output(struct file *file, char __user *user_buf,
-		size_t len, loff_t *offset)
+static ssize_t debug_output(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct debug_buffer *buf = file->private_data;
+	struct debug_buffer *buf = iocb->ki_filp->private_data;
 	int ret;
 
 	mutex_lock(&buf->mutex);
@@ -968,9 +967,7 @@ static ssize_t debug_output(struct file *file, char __user *user_buf,
 	}
 	mutex_unlock(&buf->mutex);
 
-	ret = simple_read_from_buffer(user_buf, len, offset,
-				      buf->output_buf, buf->count);
-
+	ret = simple_copy_to_iter(buf->output_buf, &iocb->ki_pos, buf->count, to);
 out:
 	return ret;
 }
-- 
2.43.0


