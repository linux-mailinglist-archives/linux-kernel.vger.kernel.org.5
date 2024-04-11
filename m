Return-Path: <linux-kernel+bounces-141036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6DE8A1A29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FAE1F220D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFA1CD771;
	Thu, 11 Apr 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Z/Dt6OQE"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9D1CCF12
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849940; cv=none; b=MTira5aS8n41ZpaaClIeXnOwE7nXE6MG1LTjjmYEZ5iAKYxUPxckcsXCoTBS0+hTrWT8jXNW5Q5csyPSgSDoQxShpJJF/pvXyg2LuY4cTLP+sNWC0J1FIcvOyep+G5y3HE9JJknMAOl495izCYWq56JKR796og/+qycbe1wpBSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849940; c=relaxed/simple;
	bh=PU1Zf+zrd7sTsTKINY0PwDd5tG03rzKZ5kv3h7QMxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mup8ZZEzOa7Bv2c/3SKl8UjK+viQq0a+vunlulMFUWIAlwbbVj8zBlK7qJsQLJjnPWG7X2OZiCqzTmHTVjy9ILkOIGCONmTWqxm9S0nJ3TLXWuNj/FLw2KJwzVnxIX9WgEtFWNxePPZ335c5IQFo55CmqoRKLr6ioIedS8RYo5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Z/Dt6OQE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a224d7414so188375ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849937; x=1713454737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mscnvAodvFjnkULv9sqFuSpmTwvvYlqWrZMKP6DUYFM=;
        b=Z/Dt6OQE046C1t2qAj0oEqPQBaU7MCZqIp6r1cKksPcdjrgtgCnC8sjBmo6dXOJblF
         wqNvm1Tk4CYIEHY7rEY1ICUoAoLpbIz1/51V1VRHqIEUBZEW8lg1oegDxNZfwSkpIcQU
         gqLud18TyPHVFHCX8bmWOKySKKYSujpLv43hju70b0pRz0mOdXDx0HxkC3nopj796U9f
         OupFgBCKPwsmPlvSueLQWDb/fusIklGXe0FeO2ndG3auB+NZY6+VIm/NhqcGQi2yDTO3
         nm/pH12nq4dkuBYT99JsbK5Tg2fCZ1WpVWueIJDji15VhcSpNod8h+cyQ2VytUKicVWW
         3hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849937; x=1713454737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mscnvAodvFjnkULv9sqFuSpmTwvvYlqWrZMKP6DUYFM=;
        b=J4ZukF04dNjiPVTGXiv+E1yiR7YJ/+T5UtZ6NUv2Iu6ZKlrWarczIHnIhz9DvDDOv9
         X6c5SttbXABRd+M9qW1ZPf9Q+dbPF34yvQjwJUrHvaPVbE+cNWkkRnAJjrnk4YGoAw8s
         vDOM+os32hn3CKuE/pQmuvXaWvtXhl9V3VZyt7uAu+wSQQEG/k04Ma7UgXAkdvUK+PWm
         211RD5aO0U3kldqruxf8vGTXEUvoq4w6OKMH9M44dhypsg+vt2lNUPbZLb19poBaK4Wr
         4OerwAEy4jamhM5WPOk8c8ylxaZLrFGHeaLDdiEAiXMXALGEmaTzQZ0CJiku00pYTSY2
         39tA==
X-Gm-Message-State: AOJu0YygqFGeS9ZZXqCGxy99HXxHN5NKFQIz3JJoo2TboHm8sjsTMSDn
	F8uKBNNt440TczckspuQkTkODHdkwxYhqDyyqmDCxBfBczxnpiQ6c14dm9K+SV/Yf/eZVxeQ+4s
	y
X-Google-Smtp-Source: AGHT+IEgR3dLXx8dpXgCulV8iX4I7eQsVkZbc1zWKcRZNkFQZ0SRTV8xvZPozVp3oYIDVjKASibu+Q==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr194815iob.0.1712849937495;
        Thu, 11 Apr 2024 08:38:57 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:56 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 262/437] watchdog: watchdog_dev: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:42 -0600
Message-ID: <20240411153126.16201-263-axboe@kernel.dk>
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
 drivers/watchdog/watchdog_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e2bd266b1b5b..828141d16264 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -694,10 +694,10 @@ static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
  *
  * Return: @len if successful, error otherwise.
  */
-static ssize_t watchdog_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t watchdog_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct watchdog_core_data *wd_data = file->private_data;
+	struct watchdog_core_data *wd_data = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(from);
 	struct watchdog_device *wdd;
 	int err;
 	size_t i;
@@ -714,7 +714,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 
 	/* scan to see whether or not we got the magic character */
 	for (i = 0; i != len; i++) {
-		if (get_user(c, data + i))
+		if (get_iter(c, from))
 			return -EFAULT;
 		if (c == 'V')
 			set_bit(_WDOG_ALLOW_RELEASE, &wd_data->status);
@@ -991,7 +991,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 
 static const struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
-	.write		= watchdog_write,
+	.write_iter	= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= watchdog_open,
-- 
2.43.0


