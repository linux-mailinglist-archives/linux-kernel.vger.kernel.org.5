Return-Path: <linux-kernel+bounces-141016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9C8A1A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A82280D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0301C6617;
	Thu, 11 Apr 2024 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wsrWXzkU"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691701C6602
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849908; cv=none; b=OSI7DJyS6j9JgICq4grmxvFmQiDJzQTylMddsp7gl7qkX517dlnaRLX+gn5W9hQ0wDTq2nKSWqqN0kGQFXTboa010I2JlS+MfbxYs9YiMWlt8eE7+luA6oKfzqPRH8zQ0x1ahdGcmCmiZHqVzLFEJOZoYIEf2zxPoiaOvG6qkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849908; c=relaxed/simple;
	bh=+94MxtKY02TZlqNeg+4IQ4Lt/c63Jz0sgjsSICoX8B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTmnb1UIfYkd2v5NkqAovJToIzSxuRWUByd2SMt59z5Htmx4OXlIYd/hdeR3QSez/ufnoonAhtcfUroE4LnsbrHdDoXPz95Jpj1kWHdl35DzIYEiecM7lMseto1E69+WoyNduVtsAnLYLo1HqKRI/CxGtSgDh68MspmVnVgfK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wsrWXzkU; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8992839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849905; x=1713454705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okoTn2nT+86tQe7VPgwHrzIkRc/ZO+p8AbDzoheVfL4=;
        b=wsrWXzkU7JnvR+0R8/sy4OdRon8LU/WQ8D3BS9Ho9WCGKQZSAf8Evp5tinuK9lFVye
         9jIcoDOoVcFAMTBIC0nMpa3fWOGPWhay6Xg6st/B5O5/C1e7yori1bNg2GqzdB94M53q
         z5RsJuTZ60LnrBDrpf6lopVSiSbDmr8Cmz/kf+Tlz+PjRbTyr10tQJEGOxquSP4hfeWP
         THfJ3StgYzFjzc7ikgoVhMe3EkgXS0Y1hxaDsZ5pxrYD20I1ncAPgAnypXfK+uk7C3Ht
         iqSkldhVV7qUn2W6RLYjXP7p2ynAiJuaxFYZkZj3H2WGIFSXBrS2aSmLCpK2G1NtR/xO
         Bnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849905; x=1713454705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=okoTn2nT+86tQe7VPgwHrzIkRc/ZO+p8AbDzoheVfL4=;
        b=ZfMnKSORXFsBFiLLFKI0lCkfq/7oyunvbyZYvSrFQ/G/6O8hyxXyCnyzqjZwzetzDL
         c14btY5OCD8X4ZA2/I182yVpxlWPGtR0O31T0XDC8mPOGrrvg4UeZTN4bEE+B5FOUuRg
         foQCovPv32dsUPPwAdsq8Jli89DZMmgUKL9gw03SLtSsgYRVbM3wenQoaEAh1c4dV/mZ
         ZsfAD5QF4z5eWvzlpXB8KNoBUHECeUmmQADoiKGp3zEtoZGCyjar5Aa/xcv2XjZD3iGw
         k/V/YNrSwV+wAWL+NQGdDR+8fo0i6gfXHO7L8qN8gUFthezE4XkfgsXOksdnFqfq2skL
         PRyA==
X-Gm-Message-State: AOJu0YzNZRgdOeQQMbjXomiZXV1kJFCVG86n5EJOFJTzCRCmA/RuU7Zj
	862SySwAxxkFYI50iEbW2rFn47H+ZQlAVscTbe747jpnUsA6NrAatstjbzfMjfCcR7LgUpxyQS7
	x
X-Google-Smtp-Source: AGHT+IHN413/KGhGH+P2SZGFF1t47mQR+8MCJqu+pikWgOAYPmclAXnj/11pjI+ZT/4cRVXwUItaqA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr186912ioj.2.1712849905221;
        Thu, 11 Apr 2024 08:38:25 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 243/437] watchdog: it8712f_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:23 -0600
Message-ID: <20240411153126.16201-244-axboe@kernel.dk>
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
 drivers/watchdog/it8712f_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index 3ce6a58bd81e..897f312eb5c9 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -228,9 +228,9 @@ static struct notifier_block it8712f_wdt_notifier = {
 	.notifier_call = it8712f_wdt_notify,
 };
 
-static ssize_t it8712f_wdt_write(struct file *file, const char __user *data,
-					size_t len, loff_t *ppos)
+static ssize_t it8712f_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* check for a magic close character */
 	if (len) {
 		size_t i;
@@ -240,7 +240,7 @@ static ssize_t it8712f_wdt_write(struct file *file, const char __user *data,
 		expect_close = 0;
 		for (i = 0; i < len; ++i) {
 			char c;
-			if (get_user(c, data + i))
+			if (get_iter(c, from))
 				return -EFAULT;
 			if (c == 'V')
 				expect_close = 42;
@@ -342,7 +342,7 @@ static int it8712f_wdt_release(struct inode *inode, struct file *file)
 static const struct file_operations it8712f_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.write = it8712f_wdt_write,
+	.write_iter = it8712f_wdt_write,
 	.unlocked_ioctl = it8712f_wdt_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
 	.open = it8712f_wdt_open,
-- 
2.43.0


