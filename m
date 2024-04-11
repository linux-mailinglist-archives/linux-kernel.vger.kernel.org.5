Return-Path: <linux-kernel+bounces-141029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 289C68A1A23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D654F282B15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746F11CAE9A;
	Thu, 11 Apr 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="oQ89gQS+"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC0D1CAE63
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849926; cv=none; b=Wcf5CisIjKKQNGnRIU79CV3CvyUhI2AeTrxA4dNJmtnRDVJZYP5RCP+H/1sFMc42cuDN4kTsboLxgC/fVqJmvjr9pTav+nrZ/rb4GBPObdzLJYAxfbx6j7kqhwrRV9tUBLrlSoxMibK+3Lu3qeMOMnwkXE3etyOqC5kL3fbzLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849926; c=relaxed/simple;
	bh=6B2WoKPOI5jH9L3xtmppLbFB0kE2ZS0Md7S/WyFPe08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1bVDJCiKhXPTpoREkNQjbF3E5Jbwods+kyFPtjkIMDp0kUCmHGtnuyRzmye4bL4LkfrWA6DFM7nMd7JsXRyltXV59JhSE9J3+goM0D6MHJ+8oi39Vmn4PpUrMmbXiXbS/eZ+HCEinYflF8SsY4OWzfFJxTxO+4nOD2ikYpmDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=oQ89gQS+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69622639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849924; x=1713454724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa7N/DWhQ/KXmWbuqOdMWw3Ybx3W+kEd/hmFicp6e0Q=;
        b=oQ89gQS+cOjKMsZI0ObHaBKWnys7VhnHlinN7o7nIkluGaLoz+rrh1LiwiQ1npQ3dR
         0SxFr3tLMm84S8utVjVM6NRx8aamOfs60SAajbPeHKATYwZ2qPGsudqkdHNvVZRR0WfQ
         g5nzvAU1cPEgPTR754sDn9eNEtRdaxAssikeqMqahNuVbyM3nR2RRLktcA4FcZgDsEJc
         LcSxDok6WaNpONUzg2kfJ+eGGpZh1pE9Hz9/JHlD+1QIWOMgLpOQqtmoZrTDj7+1ePl8
         dz9UvSWXHRMEKLrVsOUGD/u0wnKnjBOzfT4MNyw1KdEDjxgkcBmAMFTtl5Y+mh1THNTb
         t1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849924; x=1713454724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa7N/DWhQ/KXmWbuqOdMWw3Ybx3W+kEd/hmFicp6e0Q=;
        b=pDcPALe5vMR06JeMZ9Yj9D4+F4RH93s+udA0SwMV9JFI0KijushMBI0d4qbtE1dA7f
         x4mKTXFeMZ/1nnNRg+yR6B+JY+Qyv4suPXsuHMJImTMeHZbQWo/meaQo83FV2mg3rqAN
         rI6vBY7Tykt5AGPkD46ZiAD5HTUBa3FH8DsPwFMvn4OA3ut2gDQpGbmAh2Q/mTRFlnev
         udHNsbMjxW3VYiUJRAFH0gRvmCogIMZxv63Vre3SsdmrMJd/AWsri8Frw+2YoE3JlJhP
         K6ceGWq5axyZW0qXsLiKey9eJONuL+ikqbhm5ragkUmCgFVGD29+JWZlX/pMXllPAEgi
         b5lw==
X-Gm-Message-State: AOJu0Ywj05U/U16QKQMWr6uFCdPsgqgHY43FZ2LNbKhqthNV+zmbZ4sK
	xULYE2VmryCJxmoy0bf6+lgg+T2oqxriM/RTET7iw0W3oMR9FnbnSsWHcaJvj5g1XHc3mAeLeRd
	1
X-Google-Smtp-Source: AGHT+IFnwgiMRjG8PSme/0DJx1aTrwzMspdRbmD46KqjAxncydpAqgsEfy+CGbGkM0TUoUL5R++DmQ==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr199627iop.1.1712849924293;
        Thu, 11 Apr 2024 08:38:44 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 255/437] watchdog: sc1200wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:35 -0600
Message-ID: <20240411153126.16201-256-axboe@kernel.dk>
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
 drivers/watchdog/sc1200wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index f22ebe89fe13..d8d8bee1d6d4 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -261,9 +261,9 @@ static int sc1200wdt_release(struct inode *inode, struct file *file)
 }
 
 
-static ssize_t sc1200wdt_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t sc1200wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -273,7 +273,7 @@ static ssize_t sc1200wdt_write(struct file *file, const char __user *data,
 			for (i = 0; i != len; i++) {
 				char c;
 
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					expect_close = 42;
@@ -287,7 +287,6 @@ static ssize_t sc1200wdt_write(struct file *file, const char __user *data,
 	return 0;
 }
 
-
 static int sc1200wdt_notify_sys(struct notifier_block *this,
 					unsigned long code, void *unused)
 {
@@ -305,7 +304,7 @@ static struct notifier_block sc1200wdt_notifier = {
 static const struct file_operations sc1200wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= sc1200wdt_write,
+	.write_iter	= sc1200wdt_write,
 	.unlocked_ioctl = sc1200wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= sc1200wdt_open,
-- 
2.43.0


