Return-Path: <linux-kernel+bounces-140773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9A8A18E3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAA321F2299A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC44654F;
	Thu, 11 Apr 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DdWff7QD"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7D34597C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849519; cv=none; b=IkfE3uLFeIGjZWBIyik94dCmcqBgluLbIWUhkAGv1AgLoprkbIdFHMMcD8Hh+j6Y/N3vAq2Ywt8Lh0qgLpoEarYoM6zQW8+oYbiU8ljUffBxn8HYLpXOwnbVNJ4ururZfEcnjNqB0hgeZJVvww5AvYQDEFWdkLTWVYEFZ+LURoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849519; c=relaxed/simple;
	bh=cmjfSl6h2Whcjmz7Pi4Wg6GZ+a1urQb2foAZ77bll40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xbpo1gqxIMxqjqWENC04+LWmqNRTpDACLXb1BJGypC+02Dh+N0m+fXTyjbrkzIA4+PY/anyUHDACYbqhYi341pEsGtvGzWzPNo335fR9R2mSym/6dQBXF5NszCOL2ItG7JfAasvWP4mhWp5n7FwZGZxQOe00wgZPYwwchtFqapE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DdWff7QD; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69481839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849516; x=1713454316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExyYpOJNnR+7CCKMJKo086UwisuZaMhOO8s4npoyeko=;
        b=DdWff7QDeff4p4QnPxEycR5kQ3LBzHeyceir7ov4r9YKj4TvYPpv6wgYMbeZvJ/VTh
         E3c59KNmku7mjZHTAYcWCve16eU9gFnHXx+nYZOHIH8BweT5Gb/frhmNQioraxoAf4FP
         RlE4tR/v+C/ivdOHNT4qQm7FDHmjbLBHHc9zCVu9snPEI0mEPsipkMF4Ab73GcdMtObp
         xq0I9Dv7gWeBD6p9Dz3Et10VFqlHSy9/HcRriwjP78YGTiNW2QNHsGz5PU9X+e5TIIoh
         JwqvKe+Oxr3If/qhl/Nz8aTREw1h8fX6c7irUn7qrZQZJR8BWoB6NVfiRTyD4LAuBCnN
         n6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849516; x=1713454316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExyYpOJNnR+7CCKMJKo086UwisuZaMhOO8s4npoyeko=;
        b=n0KyHUmvxIjDzqIASKiGQRpJM3KKXQ6T9GWwgZk0J4U7zKPo5rjL+cc5TP+2uSkK+r
         NOATItGhHVL5FKEdIgK/nDqgXeeaO2+8We8RUquJu6R37+zn82Y15TuMbMkjmym6JTCU
         N0Z8HzsMPzHsbDHMR73JmqETA2XwbO3qTsTKhmpkodduQOjOXT6MRc0QZpZxUXjDVfdl
         7SSLd/xcQiUHkcxPmdqFU+1m8zKAzb4oMPJtycKqFjAhhskfQaL4RikSmTcifcd5YNLs
         5fTJVPfx+A+B7ZGwFmlawG2XNzx6FJbteryQov54+Kv/Sp8IrqMK0S97HZunEkxapUOl
         n7Mg==
X-Gm-Message-State: AOJu0YxQlGb0KvctEO/FXQv9KEZnw2Y3ULEziXXtPUaXX13r2U49yZDp
	IFpz5t109QxumhDoTOYecmf2m4W2MHSliwvcaE8SYmqJtgxaNrWr3DvfUkJroywyuknASZHwMH1
	P
X-Google-Smtp-Source: AGHT+IGGhSmXzbNPmsg/v4Pl2XcjR1eHKqkf/OSLorUrLq+gX7Uin13kS6vc3rZJfy9eLP3CgRseyA==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr182249iop.1.1712849516616;
        Thu, 11 Apr 2024 08:31:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:31:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 016/437] char/dsp1620: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:36 -0600
Message-ID: <20240411153126.16201-17-axboe@kernel.dk>
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
 drivers/char/ds1620.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ds1620.c b/drivers/char/ds1620.c
index cf89a9631107..036f1db308d2 100644
--- a/drivers/char/ds1620.c
+++ b/drivers/char/ds1620.c
@@ -216,8 +216,7 @@ static int ds1620_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static ssize_t
-ds1620_read(struct file *file, char __user *buf, size_t count, loff_t *ptr)
+static ssize_t ds1620_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	signed int cur_temp;
 	signed char cur_temp_degF;
@@ -227,7 +226,7 @@ ds1620_read(struct file *file, char __user *buf, size_t count, loff_t *ptr)
 	/* convert to Fahrenheit, as per wdt.c */
 	cur_temp_degF = (cur_temp * 9) / 5 + 32;
 
-	if (copy_to_user(buf, &cur_temp_degF, 1))
+	if (!copy_to_iter_full(&cur_temp_degF, 1, to))
 		return -EFAULT;
 
 	return 1;
@@ -351,7 +350,7 @@ static int ds1620_proc_therm_show(struct seq_file *m, void *v)
 static const struct file_operations ds1620_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ds1620_open,
-	.read		= ds1620_read,
+	.read_iter	= ds1620_read,
 	.unlocked_ioctl	= ds1620_unlocked_ioctl,
 	.llseek		= no_llseek,
 };
-- 
2.43.0


