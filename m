Return-Path: <linux-kernel+bounces-141009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4029E8A1A15
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD241F21AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0901C4C52;
	Thu, 11 Apr 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Zo0LRL7o"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC671C4C27
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849898; cv=none; b=RDxspwsXvXmmIkFGxg683EY6BF+T472OLxe0ZT18ydIRWuShEFzI0CSkG+n3Wc8q3xm+5ud0yCFpOD+9jwvHAXtmW+YWIXV77RWd5jmAIz7BvPR/eAQpvmFb0CrxFsTwZwWf4nM/j60VUMDRVY2i5Wi+QFR7zNfuKjTnh6fnYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849898; c=relaxed/simple;
	bh=1r4eslxLt6ueCoMhWGBz0NGQ8+WXDixhYonNogvvO6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQ+sOUCshmOHmZgGCdAkhsuak6lkpofC09XKdBBIyBAln1cAFJyk+jk6XqmTcnqBqJqOZ7pBg+DMXTZOXFe9mVm8HpNOm73QEuPYJFyKcvFgeHobOlOXV/QjcbFZagoUDSE28ffN9vBExa7e7mPTeAVYoxZxBzS2w3Cr7sQFcHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Zo0LRL7o; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8989139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849895; x=1713454695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT+ow2SZLliaFc9itBO70O6+R5hwCgvMhvgLlFMq7yE=;
        b=Zo0LRL7oogkpWZcRWTYjOR0oOnifF6a3MUcUEzt5/jm7USoReINKFMl7UnOvJvBnDi
         by2kPIx6ayD6Cwi9sKOMcszvUvNllqnE3cStvj674uZZVj8Wm9nvhwDj61DJWRE04z4G
         8G8CzhuCpcUAYZW42jalaKBri0pznA8nUJfhTkROpBxpvm95eGo/TZ/65ErllPouOCvb
         Rgay4p1pfoMTfQ92079jfzFoQMqiVrnpbeIMvANUSimFrlJ+P5mjhmcehmwwNJuzqA9h
         5yzDOFlQRh3FYxVWbxiAxBAfXPWyixvuBGCEWaQ5B98qpwDN+kxRxVpcT4DZq8E7U/Ix
         4+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849895; x=1713454695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT+ow2SZLliaFc9itBO70O6+R5hwCgvMhvgLlFMq7yE=;
        b=CDZ3GdTe5hL1RaJfJWWf7ZgqQj1WauFYSnSND4Py8fF3hyh8THwPJE+BiUl5mc4dH4
         LJUUufi5NGgY/zuEVjocRyLpzbfMvrn6eLkjH6lB36QWYpgbkqWPejRfBwhvI4a10dbI
         6WD9qKPEB6xlQJ+ciH2s01Rc2FFgN5oCIdG+sfIjuWxSVY0WA4hQ82rKmbf0yZtC9CHt
         NtXXj1Sfm9jZ/BaVKSWBIFmlxqV8KRjZ/jHiNqBxWHclXk61YMsEt0ttn/9+aXugCPpU
         d2l3ifBy8EohswCJV9h4N9p06SvfqkE98fUSOqpxGOQJZYTtuuvPtHBPY/an4/IgAzyL
         Rxsw==
X-Gm-Message-State: AOJu0Yyg1DMJS28yo9D346ySSETPJ4h4+cS0esB/OluAtPb09hZo/QJ6
	7fo8e3/nCWeF0lXtRDnBVOxVWRi2EvpMb/yFJ/QvOMlcrLJUWQcZfh0/AE5mg7yRcE5Ffo1ti+H
	E
X-Google-Smtp-Source: AGHT+IF4f/8do6cedWd+JNFRC2Q4ASmJOtnz/0ZzMCcgEJ+i/BmrOv1Ia8v4cF8jyuAKunGgvcH3bg==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr21903ioc.1.1712849895509;
        Thu, 11 Apr 2024 08:38:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 237/437] watchdog: at91rm9200_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:17 -0600
Message-ID: <20240411153126.16201-238-axboe@kernel.dk>
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
 drivers/watchdog/at91rm9200_wdt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 558015f08c7a..1860fbeb6e57 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -199,11 +199,10 @@ static long at91_wdt_ioctl(struct file *file,
 /*
  * Pat the watchdog whenever device is written to.
  */
-static ssize_t at91_wdt_write(struct file *file, const char *data,
-						size_t len, loff_t *ppos)
+static ssize_t at91_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	at91_wdt_reload();		/* pat the watchdog */
-	return len;
+	return iov_iter_count(from);
 }
 
 /* ......................................................................... */
@@ -215,7 +214,7 @@ static const struct file_operations at91wdt_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= at91_wdt_open,
 	.release	= at91_wdt_close,
-	.write		= at91_wdt_write,
+	.write_iter	= at91_wdt_write,
 };
 
 static struct miscdevice at91wdt_miscdev = {
-- 
2.43.0


