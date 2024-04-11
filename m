Return-Path: <linux-kernel+bounces-141017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C87508A1A3E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF42B25C86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03DA405FB;
	Thu, 11 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eCVyoydJ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E11C660A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849909; cv=none; b=k4fMBldaHyb2KtdN65RjXpvPAIMjT0BHfmDyaPPUVFlkzBDBVf0x+07HFqdwJrWLt3H1ECBIMBwSRwJX7a62u71np9T4f7kCdSmTlc68yPY/txKKRYM6Zs7p+Q0EVSfUAAqTwGV/TywEfxVDspEwz5Ut0/Ut+ArKJEDFvH9E414=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849909; c=relaxed/simple;
	bh=ljM+THJt9ckIMz7+H38GYD20ieLBnVjWZXbkjayQiHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F3qRJuH78TDeXHfkWJsUA6OmAYnsxt/aS2zTvHFBIj/MPBhcVv6XrVlPEL2vLtdi3GbRYFEh3OJvRFW+0z2jRhTi6w6xnWTfUeQI46TV6vhIxllfKuDr+J0FjZxHXdvQ9LIH6MBIk78U6mXxVnk0wu/0unD1E8iW6o6qqYRtYvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eCVyoydJ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58133539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849907; x=1713454707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QehkgIXotruTVsg7DERL5D7J+WaSkDbqFA6PyqD6gNU=;
        b=eCVyoydJClPhgvzoa98MtcukCqYCbaHRDtb7+8/ZzxZCsvescIV/hePT+gOlIpiNcq
         BKI80zRbmSTu/azuftk0nqrd71b+t82PboJzkFdk1rCjCM4gACj5UQEAWNtxw9jiyjjE
         deFdF0YNcv3u8EndpQEVJv+XoJmzOWeXpN0qB+sWzJEMkZBa72KAmjfLADb4fGC61nCa
         f6WehYP3eC3Z3KuZhzS7F32Fa2zkAGax5BKw+KYZefbNZsjOH9vUPC4fKvYbQjli1WIq
         4IJmEc+lY2OajUJoyTyvxrEGXmovCGr8ysqvZUfde1pHXlzWUsSzikHq/H7NscMrrlBM
         Hn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849907; x=1713454707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QehkgIXotruTVsg7DERL5D7J+WaSkDbqFA6PyqD6gNU=;
        b=ACqVu9IhdQYpLiDgz2IMRyTdnDIpjrMumoCByv/8jTHQI/dlubN42/4k0ziPd5+FtK
         NpMtplIp2Mf/Qf71zPc+CeVc6qo6ppwi2bJgBCnDRkDW15Y3tbuLi7IZ6vZGsyl8R57i
         ScT3h3pXTqvOLqeWN5Ps7x0nSuUzMi6DCw4Jiq9Ecjlo2CrAamL0Vs1X55KJWK+E6AfN
         ALeplcg9B0rFlvU/QoFhibbaqr5Z3LNdsTAFdwdMGFIErRZRzAW/h5q9uIn/rDh9fB/P
         pP1uhowGExOC1xC6p8JYcq/XgzLgZvzdn1+cgiDVSkaIuc6tkU2H/2ASahinCvELPApo
         VBOA==
X-Gm-Message-State: AOJu0Yy6zz3kaj1rPNrAg01BJdsjl1ObOYtxBa899Uwk1uKj7C4Buv2E
	6kPIRnAd8Wor+yVYv/oQHeKvWSkl0y+/a5oMCrK8pIdlpQcwlc+ixcAaL8M+25nJlyS4ZjYs+Hr
	H
X-Google-Smtp-Source: AGHT+IF1UdoMhnDJSYWjhnlLX6od0W4qUpS6aX3gzGu/DBr8cPEhCqdE+q3VLxzqDwODTbnwvt5+qA==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr207639iog.0.1712849906862;
        Thu, 11 Apr 2024 08:38:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 244/437] watchdog: machzwd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:24 -0600
Message-ID: <20240411153126.16201-245-axboe@kernel.dk>
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
 drivers/watchdog/machzwd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 73f2221f6222..c36a0a441c2c 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -262,9 +262,9 @@ static void zf_ping(struct timer_list *unused)
 		pr_crit("I will reset your machine\n");
 }
 
-static ssize_t zf_write(struct file *file, const char __user *buf, size_t count,
-								loff_t *ppos)
+static ssize_t zf_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character */
 	if (count) {
 		/*
@@ -282,7 +282,7 @@ static ssize_t zf_write(struct file *file, const char __user *buf, size_t count,
 			/* now scan */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V') {
 					zf_expect_close = 42;
@@ -360,7 +360,7 @@ static int zf_notify_sys(struct notifier_block *this, unsigned long code,
 static const struct file_operations zf_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= zf_write,
+	.write_iter	= zf_write,
 	.unlocked_ioctl = zf_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= zf_open,
-- 
2.43.0


