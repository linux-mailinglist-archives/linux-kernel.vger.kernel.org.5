Return-Path: <linux-kernel+bounces-140924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4328A19A3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1931F226A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7699C1A0B0E;
	Thu, 11 Apr 2024 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Wj5a7uYr"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4B19DF6F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849766; cv=none; b=tPST+/kdueVg9Q5GHYAbtcOD5AG9jc3dyakKZUtB8pmljDUoxfbeiz44xOHn78+KlINE9wyRzt0jhaNo05jAt01XdG+WAyDUiSa7yq1KA1qwmEcat3HB3X+2rMM4jsT4IZFB88eGISOhALK2XWr0I6XRSvmbsQXxEeLLZYtXIeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849766; c=relaxed/simple;
	bh=N0LR7rePclWwCSdt0qVNhNXvj3rVODCzYkNWaEHF4to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcYcvV6FEVm6AZghlAFmSlhC6z99w6vAW0KizLq//LU5Hbs+yJFxStrK/78WYu82kfIUCRr2WUkfZ8QJYmlogH+/eAx+th/LUYR3ADXxrmv/8/x1W+1OGGYzqsRL3+Zq8QTxLo1oXEuHBGhVBK2/Iw1OqU5j24aJTZTPxdKaFwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Wj5a7uYr; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58071439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849764; x=1713454564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXVa3ezz1u6hZf4xOyPr+4b2F47oTYcBm9qW5wgKxWE=;
        b=Wj5a7uYrLedmoPADzacH3lE6wKm9bve6/FjXrNCI5UcjBXsNujP6YGe0Bmf3bPOFaE
         Eg4UWlD0ShXA3FkxRxrL22Xmt9RELdIDGJhxbBn1IokBj9FO4I3CBVlVEn5bPITn/98E
         4mfv+joEDes/IQv/1bcw1Zt2rrxfG9JGdFDZfGihwnaNQNswhAwTrRHU+BCVEqC/zL73
         5sS53yJZIhd9r3+DKUmgck0tuE9uLlUiTY0TNQTZ0E/+FYTwPDReNIw8RCvWJzKLzesa
         dcmrCczkfYl+4f6OczHaVc5OomOi7EpHscRxmEuXvkUqLTpUgO3yXhFv17qvVa9LqRgz
         BkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849764; x=1713454564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXVa3ezz1u6hZf4xOyPr+4b2F47oTYcBm9qW5wgKxWE=;
        b=mrq3CNcFlE4DVgLffF4o5YAzsqbAacQvTBnlMflT//5Jb7Juoku9YkbsdQmtYkpU3U
         EwFKBM7YDLpqUcPaVHgq+qOiAXeSgkqGKz19fzchX8Vvc0L2dlPPSPdQvGZwK4gyj9VR
         4SYeU1r0KjBKe2xSaA+cEH9Gt0276bk+FVMi69yxT3ggaoqbQgO0MagYv2Do+F9x4Jfi
         gVUlAc0j3iAdda0jGRYLvK7dF0nJxBdw0xN1rqqvRLgWYus6eIxzW9znUTmZiiM349Rb
         +cKiuG5WtyL51TC2DfGR4Tq95I3iewRxlxZWkjMWeRwHctu0D/ShTQ+tKz+37ZqmSR7k
         LDZQ==
X-Gm-Message-State: AOJu0YwRgBE/kvwNdNCYr8LDbDF/sOMCAK0akvJxfuFYPMz7cAJrWkyE
	CnEv3SdhiLugTBV/m8CH4ayYo0dC2e4BaRkVP00VoROkTD3+aXYACaLYM6EoCQX39DYuPPY2ZzD
	B
X-Google-Smtp-Source: AGHT+IFKm7AHRItIii66BGW7YKuR1NLymHhP2GmLh3hjuWGUK48Q+NGXWVJ4U3zYvNveAdknQUtuHw==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr204522iog.0.1712849764352;
        Thu, 11 Apr 2024 08:36:04 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 156/437] usb: chipidea: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:56 -0600
Message-ID: <20240411153126.16201-157-axboe@kernel.dk>
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
 drivers/usb/chipidea/debug.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index e72c43615d77..fa080c6dabf3 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/uio.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/phy.h>
@@ -70,10 +71,10 @@ static int ci_port_test_show(struct seq_file *s, void *data)
 /*
  * ci_port_test_write: writes port test mode
  */
-static ssize_t ci_port_test_write(struct file *file, const char __user *ubuf,
-				  size_t count, loff_t *ppos)
+static ssize_t ci_port_test_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file *s = file->private_data;
+	struct seq_file *s = iocb->ki_filp->private_data;
+	size_t count = iov_iter_count(from);
 	struct ci_hdrc *ci = s->private;
 	unsigned long flags;
 	unsigned mode;
@@ -81,7 +82,7 @@ static ssize_t ci_port_test_write(struct file *file, const char __user *ubuf,
 	int ret;
 
 	count = min_t(size_t, sizeof(buf) - 1, count);
-	if (copy_from_user(buf, ubuf, count))
+	if (!copy_from_iter_full(buf, count, from))
 		return -EFAULT;
 
 	/* sscanf requires a zero terminated string */
@@ -109,8 +110,8 @@ static int ci_port_test_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ci_port_test_fops = {
 	.open		= ci_port_test_open,
-	.write		= ci_port_test_write,
-	.read		= seq_read,
+	.write_iter	= ci_port_test_write,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
-- 
2.43.0


