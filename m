Return-Path: <linux-kernel+bounces-140928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF78A19A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F341C21145
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228DF1C231E;
	Thu, 11 Apr 2024 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fU7URUQH"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39F1C2301
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849774; cv=none; b=pEGrorJl+VIWN1pquPC6mOT6aGhiP0w7Z+zW6mfoMeI9umF3/HibLy/p2dRHGBnGtCn2EL6t2FqXAH4p60C8bXAfVKvu9BsvlGs+rMQsaMzq7kxPk0QV8WeeKPhMQi5svf1Xi8pNkO2uCyDsakL/TyB9U3U1dSTwkSXSSkQ4arE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849774; c=relaxed/simple;
	bh=eyNw/fMz9VWuTAy6eheOBWrnyPqJvTPEmKdpUxMiO0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw97CtUpyS04Hc49hR2CrLiohhLXhhmPJ5yG43uuXMJ0hDqziusGi1ILxQILAmHRpy4jdKknm8YHNy0fFRJv0Yf/uiMseWi5Gaza25yFJfJpYs6Smu39AKJIG3grRhTosgS9VHTCM7V2F/VDqNh0bosTSv9qovboJOwkpzQHlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fU7URUQH; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-36a224d7414so183015ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849772; x=1713454572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ClBrrRz8U9U/IoNi5Xa3s47Go5lIgp985Yz+fhOQbY=;
        b=fU7URUQHVgXUl2JL5NW6aSrjhQMUoZ/0HvyuPAI20clKq03VYAmC5xNwnW9HrGus12
         OCVKr2PorldLGJ3lhMlCMBrfmkEr7RHyILRNkLtthSwlJhP5/p6lEEN1bL9p1p+CJ0gY
         WnFzldSC6WcJGFgZcQeJcEO5jHfMCj6bC0VSsKJttQLYU5ZOOWJ/Hw9/ysje7s9gYHab
         b3Pn0T9GJfIFXa2auOIBLf8fpNW/z+dG7df63slrAZOXNUA3XmZ/dPbrVWE8GomwCtPd
         1CPT2qRcYiWlFmaC4eVpE4RPlkECBH0fJImUGAZ1OY7tyKSCCrwTKxmknttCEnLy69WQ
         wBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849772; x=1713454572;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ClBrrRz8U9U/IoNi5Xa3s47Go5lIgp985Yz+fhOQbY=;
        b=uinrqV//iydhhGlFWfTfI+ZNfVEu1S31Rwrv5DrsyvgQJfj2zPbjM2YWYVaNYUBNfd
         Jewm7jncbWES/s8v5laR4Zjdoz2m21fIsI31jP3oa+gOOHmgvz/HENzEWXnKElJyWtmm
         XNy8NPL2zh1io+oumD/SHrz2RF+7kUQUYJwkFEWNSZmqUPgY0q9zlGAC5nNCxO+V4xwT
         gvbs8CSzrwKbpyzrILn9Qeqw/kSPkMyt5G/4px+jP4fC2weQziMaA1P0GgxdMgFHR4Xu
         h1oefFPX4KyCEMjgyjvz5HYuESFb+V56VFwToVfwWKullSEed2Hk5pd3YfgyIuf/i5bH
         uZFw==
X-Gm-Message-State: AOJu0YxmG3u5pHIK3xzrwRjmis2rb7Sryh+n9h1n06H5WTEAckpnUIU0
	pdJbgKuR6cRdcvss0jcwAtys0O8vv3aadR6AHjMUDFWGCt8Oorw2murNfFPlcKG2eVo3i3OFY8z
	x
X-Google-Smtp-Source: AGHT+IF7ZbI9A7JIn7tJgiBlVGCu8zc52LXDbfHc31jaQ19ZMyKjJHiJ3TOSifGWii/VinAFMZpbsw==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr186853iob.1.1712849771751;
        Thu, 11 Apr 2024 08:36:11 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:10 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 160/437] usb: dwc3: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:00 -0600
Message-ID: <20240411153126.16201-161-axboe@kernel.dk>
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
 drivers/usb/dwc3/debugfs.c | 48 +++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index ebf03468fac4..5af745ef00a0 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -365,17 +365,17 @@ static int dwc3_lsp_open(struct inode *inode, struct file *file)
 	return single_open(file, dwc3_lsp_show, inode->i_private);
 }
 
-static ssize_t dwc3_lsp_write(struct file *file, const char __user *ubuf,
-			      size_t count, loff_t *ppos)
+static ssize_t dwc3_lsp_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	char			buf[32] = { 0 };
 	u32			sel;
 	int			ret;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	ret = kstrtouint(buf, 0, &sel);
@@ -391,8 +391,8 @@ static ssize_t dwc3_lsp_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations dwc3_lsp_fops = {
 	.open			= dwc3_lsp_open,
-	.write			= dwc3_lsp_write,
-	.read			= seq_read,
+	.write_iter		= dwc3_lsp_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -436,15 +436,15 @@ static int dwc3_mode_open(struct inode *inode, struct file *file)
 	return single_open(file, dwc3_mode_show, inode->i_private);
 }
 
-static ssize_t dwc3_mode_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t dwc3_mode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct dwc3		*dwc = s->private;
 	u32			mode = 0;
 	char			buf[32];
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (dwc->dr_mode != USB_DR_MODE_OTG)
@@ -466,8 +466,8 @@ static ssize_t dwc3_mode_write(struct file *file,
 
 static const struct file_operations dwc3_mode_fops = {
 	.open			= dwc3_mode_open,
-	.write			= dwc3_mode_write,
-	.read			= seq_read,
+	.write_iter		= dwc3_mode_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -522,17 +522,17 @@ static int dwc3_testmode_open(struct inode *inode, struct file *file)
 	return single_open(file, dwc3_testmode_show, inode->i_private);
 }
 
-static ssize_t dwc3_testmode_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t dwc3_testmode_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	u32			testmode = 0;
 	char			buf[32];
 	int			ret;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "test_j", 6))
@@ -563,8 +563,8 @@ static ssize_t dwc3_testmode_write(struct file *file,
 
 static const struct file_operations dwc3_testmode_fops = {
 	.open			= dwc3_testmode_open,
-	.write			= dwc3_testmode_write,
-	.read			= seq_read,
+	.write_iter		= dwc3_testmode_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -610,10 +610,10 @@ static int dwc3_link_state_open(struct inode *inode, struct file *file)
 	return single_open(file, dwc3_link_state_show, inode->i_private);
 }
 
-static ssize_t dwc3_link_state_write(struct file *file,
-		const char __user *ubuf, size_t count, loff_t *ppos)
+static ssize_t dwc3_link_state_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct seq_file		*s = file->private_data;
+	struct seq_file		*s = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	struct dwc3		*dwc = s->private;
 	unsigned long		flags;
 	enum dwc3_link_state	state = 0;
@@ -622,7 +622,7 @@ static ssize_t dwc3_link_state_write(struct file *file,
 	u8			speed;
 	int			ret;
 
-	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+	if (!copy_from_iter_full(&buf, min_t(size_t, sizeof(buf) - 1, count), from))
 		return -EFAULT;
 
 	if (!strncmp(buf, "SS.Disabled", 11))
@@ -672,8 +672,8 @@ static ssize_t dwc3_link_state_write(struct file *file,
 
 static const struct file_operations dwc3_link_state_fops = {
 	.open			= dwc3_link_state_open,
-	.write			= dwc3_link_state_write,
-	.read			= seq_read,
+	.write_iter		= dwc3_link_state_write,
+	.read_iter		= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
-- 
2.43.0


