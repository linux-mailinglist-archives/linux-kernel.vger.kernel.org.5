Return-Path: <linux-kernel+bounces-141030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D78A1A25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16421F21E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475001CC482;
	Thu, 11 Apr 2024 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vj3VqRYb"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432B41CAE93
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849928; cv=none; b=kUpqOsvPnOTuzbl8WFyNzQgKoYCbHmKOzsU0Z2tZ0s2kGL3akAm1VXC/iJYQv6qD0/WUNL/WywesFqUzrBvQJRQOn7vup/ZrsM6j7gfVYYkGso2RhYWQ+sP8GQ7TxOhX40ZjFKCWkn5LepCvStS/piMxCeENLgYtTVvTmWkywO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849928; c=relaxed/simple;
	bh=V2pknhwZI2GhsZ1za3+1JnKfg9SgjeH1J9FHXA1o/lI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0DlNTcjz3qOXozYaX4F2z/d1Lwkujf/WE2HPQ36SkEeFa2B9zva1M4eyVoI0E1T3C9aa/xMwwN1C3Us5gmeOeEEk/mGNZuU10vNWQqvo+FjWc3YhlcNYTwiyoCi0FYIO5fIaz/JUBTwO3vuu5Vs1Tmac9ymcnMcNdPqxZEWcs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vj3VqRYb; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a224d7414so188065ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849926; x=1713454726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERW5BR/BtJ4YToiXkMeRs6Mbsl8L+nhWw3aXXM96rYs=;
        b=Vj3VqRYbQhkf7o8/CG/18g+ladX3cM2WzvYInokRLjDaodiH0KGTz3ataAasDi1FDP
         4/wIVHwU70RqVnZLUgJr88tCCF1k8/i8EWUOCIvtykCBupqm5kQvsonSLTQdMzjNQkX3
         fxKDNqBIBCZrwhWYCRAOz8TImDBJSM6jSDge2MBCEVwWRtbXkcQPreZdtKSLVLp0S0gv
         9dSm+WUxAb0gUxY3KRbBED45NRgLX/01hbQDp5H9rCYZCLJ7Z5rohI2+/vaokwanZ66a
         ikTD6uQRxV6zcQQ72Emntw7Yfb5WMhaLShd9Q7ZHhf/6y7iTFloPC0bIoLF9L9siMUfT
         +pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849926; x=1713454726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERW5BR/BtJ4YToiXkMeRs6Mbsl8L+nhWw3aXXM96rYs=;
        b=aGU2PbnjxsP7l9/vq/nmrG+MLCjiUJrZcuSi7tRXHQZkOB68M6LIH5NEYVrYO/ZIz5
         xEvQpWLV+sKP5HNSBaROngJQ4Ey6vgfLFZksVsKy2xXTVfrjKR0U5GSu95BQjCwBtLJA
         RrTowUv41FJQWbG8IFA/rUjpuOPmfAMaEIV3JSEeuoGvqsUrpFd04KAG9j6RdFud/yg1
         +yzl24dpnxHi00g4Ik5LyTtlXAUM/QlXKhuhXQ0R/2+Y6pewRY0vH00A2tEjIJpGRwr/
         IbAjpFKxvf/1s8NydZ2yT8OdM+La29Vl/i+Z3+SMhMZx6L9U6ZEoxsg1DJrgGMapVhVf
         NpFQ==
X-Gm-Message-State: AOJu0YwZ7mDHif/2vLRnVSabCS6gv8iLIcKAfqFA6A6SrrZb7PjL9A1z
	J58C+WPHxVDr/SCFGxBzujceh5Mkd6hvu+ZZqRd9duVK26j7IJlRo50DDtxnue8TITuVXwfJmZY
	u
X-Google-Smtp-Source: AGHT+IG+EWZ/xsJas1ogVghq5x9xscOsX0/9t5Mv+eVzp+taq0mNNTvrfcTyDAiAJ/sp/KPVhxJxCQ==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr194377iob.0.1712849926153;
        Thu, 11 Apr 2024 08:38:46 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 256/437] watchdog: sc520_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:36 -0600
Message-ID: <20240411153126.16201-257-axboe@kernel.dk>
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
 drivers/watchdog/sc520_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index ca65468f4b9c..a428f1e28fbd 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -215,9 +215,9 @@ static int wdt_set_heartbeat(int t)
  *	/dev/watchdog handling
  */
 
-static ssize_t fop_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t fop_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	/* See if we got the magic character 'V' and reload the timer */
 	if (count) {
 		if (!nowayout) {
@@ -230,7 +230,7 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 			/* now scan */
 			for (ofs = 0; ofs != count; ofs++) {
 				char c;
-				if (get_user(c, buf + ofs))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					wdt_expect_close = 42;
@@ -332,7 +332,7 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= fop_write,
+	.write_iter	= fop_write,
 	.open		= fop_open,
 	.release	= fop_close,
 	.unlocked_ioctl	= fop_ioctl,
-- 
2.43.0


