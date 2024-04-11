Return-Path: <linux-kernel+bounces-141010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004838A1A37
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70A2B2896F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3DF12C46A;
	Thu, 11 Apr 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ED5xFJjn"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABAF1C4C49
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849899; cv=none; b=P7NtlXbyZXHnz/Tqi7PE3U4rksAljHoZpxPpu3MvvWyq5fi01HFzDHgyFY5fR6B/RZxuS0fKFIDPNfd+74CeG9FmMjcIXRwkTOs0McsShhop4/o74y7cfCofCQD5RJDiiPFsbHkwBh9EA37Lc6JETNiMEel5hk2W2tvwn3Sdi7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849899; c=relaxed/simple;
	bh=3/V667XKBglm9im1Z9fRJ1TA+beLvb8GZxgDNkg/7F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBoDly/hz7W0g19cNlo99ZIwxUrrSw4awd15DE739qtmcwPb65LEX0solzzmOnSREooUctpGE+5JMK8hLDEmIzV2NA9pNPGRu4IfzklIMcc8qP1PIXk9u0H4IY4l6sEK/oVfbZMluX+QbPIt+9KgTkotMqsViTQIqPUw8qMOiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ED5xFJjn; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9837039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849897; x=1713454697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl12uZ8o/yOCWgQSdPpy5k35ORLGY8Lo/Z/2sz1z1GA=;
        b=ED5xFJjnM4a70pZfWb0JCjsA2lS6+cTWweFdg1/HnIp8cdeXHigXND7jAUYyJy2jyL
         HaFWmrbw0q54VZdYuvsdUQrz9XSYYchMx89CTSDYht8+9g6/R27mdr0idvoe0My+D/GQ
         nJGgOIJFBNcSYQlW7kQoyP20+BO3h9Vi1sQSPp7i6GUYqIktkniDLTHo1vLBpQNkZ1cW
         KG3V6UNduTMADqsqh/UgCF06zGWvVnEPqu2RSCx6X4hjErhI6tG1JSrZpqUcgEnojH8d
         J/RUOs5n2x1EQ+QSf8cdllGmFQMmN4higtk7WK8q8mhsEdDp9mbSC2PS43xPLgCk6WPz
         mZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849897; x=1713454697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fl12uZ8o/yOCWgQSdPpy5k35ORLGY8Lo/Z/2sz1z1GA=;
        b=Gi3HVB0mpU3FZ0z9l2d8KdXbd+D7S8aHAkJdRbh0wR+xXa5GmVgEymJT5HT3w0CPyd
         7RuFqxhIXYMBEm+Z4QmpLhgsGGN373XXQ2RB0GWDg08+ZSxP50iqJ60ru7XLu5xuvYf7
         xp/np96cCHTv9NZ6rC1ua++EfmgRgan6ultPIohYy7cGbJ8aO6M8u0nwqD3cD3EZpUDX
         omze1Y21ZKvZFs06SqkCTG7w38eoshN01DrTRJAXprIVQBMC2hdDIeYzBGoRaJakVjKU
         9F4qmCCSklfU+Xt3BW9ge7OErOGENzuqHkkczXIfo3s6CVPNcQwkendgSQTCiWGvo2HJ
         ef2Q==
X-Gm-Message-State: AOJu0YxpTLNB1kf5HDIDz8sQqvrrNIc2nYw13SHEgBNN8dIlxyTdKzYv
	xFiLPRnmIn4BRakweSZjRXx7nweBUjtY00A1n1A7UnLkanSPzYhnUMwL9shyCvRuZBO5GUkmvtB
	1
X-Google-Smtp-Source: AGHT+IF+NfFxryjzYWEnMoPD6xrhhk2OL/eZiwnbDZGQ8nvDVNp5EqqEOVrr1AkYFEjkqvSFJRg6fQ==
X-Received: by 2002:a05:6602:84:b0:7d6:9d75:6de2 with SMTP id h4-20020a056602008400b007d69d756de2mr46713iob.2.1712849897275;
        Thu, 11 Apr 2024 08:38:17 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 238/437] watchdog: cpu5wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:18 -0600
Message-ID: <20240411153126.16201-239-axboe@kernel.dk>
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
 drivers/watchdog/cpu5wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 688b112e712b..cef1d6ba6ecf 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -174,9 +174,9 @@ static long cpu5wdt_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-static ssize_t cpu5wdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t cpu5wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (!count)
 		return -EIO;
 	cpu5wdt_reset();
@@ -189,7 +189,7 @@ static const struct file_operations cpu5wdt_fops = {
 	.unlocked_ioctl	= cpu5wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= cpu5wdt_open,
-	.write		= cpu5wdt_write,
+	.write_iter	= cpu5wdt_write,
 	.release	= cpu5wdt_release,
 };
 
-- 
2.43.0


