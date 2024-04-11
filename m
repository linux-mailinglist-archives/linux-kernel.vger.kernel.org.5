Return-Path: <linux-kernel+bounces-140937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FEF8A19B7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455471C2290D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FD61CB313;
	Thu, 11 Apr 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="udHddoX/"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B81C9ED3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849787; cv=none; b=pugJSeLLfj3XikUFzaGsghCYZv7qWe3jx/TFrfcwTb2zvD5vsbaQMa1VT9Nksa1zakKjyhMQ6OseE1qFtgNQZpAVSRkX5Z5Hu/U2UoNbKLpRxbFkBQwij6uj/HaTpM0Ti159/HXuoQdHrePmWHF/7y2wAmRH6cPQc1geiwCscyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849787; c=relaxed/simple;
	bh=NVRs4dggM+Epm+8AHAcTeyE4WoLIT+cCoaaQM7m768Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iiRIWWPPy8jU00PZgptrNgzXIfbzYkoYka8kCRPHKPzUbMTDfyakR/aqlahqZrXUjXKR/4Hm1Igrh3xm6cxgKNBxLiDyg03mf5zZdXoOpPuSAc4wx+vMC+p/0z3NgQhnjA5XhnZBaxgJQUO2owt79f1gu8RX28VMBG4u8kGfciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=udHddoX/; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8952339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849785; x=1713454585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9m4dGsh4a7mpzDXDOdvreeKb63yVkSfsQX8D+D5oolY=;
        b=udHddoX/+29UqlxTivy0sveuWnXCMsNVDX3ALbQk4wHQcE13PTLv7pLN39tTwb3XJS
         NTuvINK47LPhsqcUr6pWRs8+BVDfntOF+XCnpF7/aD9BOv5MxqFg9Ubcv09c5oV0vQZH
         cmRwcYlFSTPybx3vS912R2tccruSgsOtLvxBy2vqVK2k9f3vvXSBHiiuoV+7Sn2RVxIP
         FKQH1mnm959XDEScXljfKpuaiEuh1IgrcYI05JkHITCmj+RbHiQj0qmdGhrCfMxgWllU
         Gzt7XMUzfLf7mrNTMiJ3cQD4lPVrp/1Ig2J0wb0yT4vy254gzq9gxlokAUAFtIXUlXQn
         9iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849785; x=1713454585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9m4dGsh4a7mpzDXDOdvreeKb63yVkSfsQX8D+D5oolY=;
        b=pi/dhYtqS+0iQvsTnN/Xx2q+UXI5cTr8wRW4FBon+BXMnwcbJYVJ9FoDiS2rEkG5WM
         lTSpYxhISk4vfpiInAU+nRw4Qy1RSTVtmSmX2FqZrkJTSpYLYvUtFONd+ACNlO0PBto0
         ZKl6Sgx8xz6omGByMbF506vC4mFHyHPj1af7+hZOKupyL3g7UAGgnCBlrsVWgKQiqnct
         /NSEkOr+VhPHasv+SXIPMlSin3mkuqyI4+R8zvoLZiIoBgaS5cCLNVtn7jw8qYeYljrO
         ext9fn2PgBP8xrJ90Pk3Ty/35OPtwX4EOnOCpCGc3YDgd38v+LpMTDLLX0Q96w/EM/8p
         Vtxg==
X-Gm-Message-State: AOJu0YzNLZWDQsTiC81ELaSDGjo3eQJ5YEyMwv2mvQP6al14N3FSUIbg
	YkM5ceSPRUf2a2KELdum3KEZAnlamdmcYHP+0j6glUt0rlSU7oSYsuhrdrDUqyUf55ih5Or7aWY
	P
X-Google-Smtp-Source: AGHT+IFTfwhPk7/eXTPZUfgSoFQ8V0ilaiYLiDFM4QN9DUzhSCgLtuXioVlaxFiutxkib6gCDTbyuQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr16493ioc.1.1712849785245;
        Thu, 11 Apr 2024 08:36:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 169/437] usb: mon: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:09 -0600
Message-ID: <20240411153126.16201-170-axboe@kernel.dk>
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
 drivers/usb/mon/mon_bin.c  | 3 ++-
 drivers/usb/mon/mon_stat.c | 9 ++++-----
 drivers/usb/mon/mon_text.c | 6 ++++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 4e30de4db1c0..af88dd18eafe 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -867,6 +867,7 @@ static ssize_t mon_bin_read(struct file *file, char __user *buf,
 	mutex_unlock(&rp->fetch_lock);
 	return done;
 }
+FOPS_READ_ITER_HELPER(mon_bin_read);
 
 /*
  * Remove at most nevents from chunked buffer.
@@ -1290,7 +1291,7 @@ static const struct file_operations mon_fops_binary = {
 	.owner =	THIS_MODULE,
 	.open =		mon_bin_open,
 	.llseek =	no_llseek,
-	.read =		mon_bin_read,
+	.read_iter =	mon_bin_read_iter,
 	/* .write =	mon_text_write, */
 	.poll =		mon_bin_poll,
 	.unlocked_ioctl = mon_bin_ioctl,
diff --git a/drivers/usb/mon/mon_stat.c b/drivers/usb/mon/mon_stat.c
index 3c23805ab1a4..e13a81ade7cf 100644
--- a/drivers/usb/mon/mon_stat.c
+++ b/drivers/usb/mon/mon_stat.c
@@ -43,12 +43,11 @@ static int mon_stat_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t mon_stat_read(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+static ssize_t mon_stat_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct snap *sp = file->private_data;
+	struct snap *sp = iocb->ki_filp->private_data;
 
-	return simple_read_from_buffer(buf, nbytes, ppos, sp->str, sp->slen);
+	return simple_copy_to_iter(sp->str, &iocb->ki_pos, sp->slen, to);
 }
 
 static int mon_stat_release(struct inode *inode, struct file *file)
@@ -63,7 +62,7 @@ const struct file_operations mon_fops_stat = {
 	.owner =	THIS_MODULE,
 	.open =		mon_stat_open,
 	.llseek =	no_llseek,
-	.read =		mon_stat_read,
+	.read_iter =	mon_stat_read,
 	/* .write =	mon_stat_write, */
 	/* .poll =		mon_stat_poll, */
 	/* .unlocked_ioctl =	mon_stat_ioctl, */
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 2fe9b95bac1d..ec50a0e23117 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -428,6 +428,7 @@ static ssize_t mon_text_read_t(struct file *file, char __user *buf,
 	mutex_unlock(&rp->printf_lock);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(mon_text_read_t);
 
 /* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_u(struct file *file, char __user *buf,
@@ -476,6 +477,7 @@ static ssize_t mon_text_read_u(struct file *file, char __user *buf,
 	mutex_unlock(&rp->printf_lock);
 	return ret;
 }
+FOPS_READ_ITER_HELPER(mon_text_read_u);
 
 static struct mon_event_text *mon_text_read_wait(struct mon_reader_text *rp,
     struct file *file)
@@ -686,7 +688,7 @@ static const struct file_operations mon_fops_text_t = {
 	.owner =	THIS_MODULE,
 	.open =		mon_text_open,
 	.llseek =	no_llseek,
-	.read =		mon_text_read_t,
+	.read_iter =	mon_text_read_t_iter,
 	.release =	mon_text_release,
 };
 
@@ -694,7 +696,7 @@ static const struct file_operations mon_fops_text_u = {
 	.owner =	THIS_MODULE,
 	.open =		mon_text_open,
 	.llseek =	no_llseek,
-	.read =		mon_text_read_u,
+	.read_iter =	mon_text_read_u_iter,
 	.release =	mon_text_release,
 };
 
-- 
2.43.0


