Return-Path: <linux-kernel+bounces-141028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F698A1A20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3531F243D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFF1CAE60;
	Thu, 11 Apr 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wIpmiuBK"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F511CA6AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849924; cv=none; b=RGImOaHZpWrARuR6vu/Rj2lp8Z5sx/qbKA3sflMazU/WvAIER0Gfeb2xcFu1o0E6qXSae57xZy3eOEq8YdXaVJTKLQrrf0BtVBxsEKJCMgiWuzONphzu+2KO0t/Oh8MYg2nyDCKVVP530xyIOF4UE20qavwWfk2/f74TpXTST/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849924; c=relaxed/simple;
	bh=yMIlP0uDT1a2iJJZCesxiZF6Nz8GjshlxZnxGTaAbG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg2JXoTN3wP2PfnN9jk+Y7F3qodi6SG/2x1mE6Ur6HJ8qn3aoAhBpawdOtsIuWMSFLGHQc+lebSbSlWThNFtkcD9A4j06EhGrQ6yrn+P8JquDNglgaXvi0svfHWKxw3r226o+x99uM/voTY4NfsU3jKk6q6rLBGb9qFaIBgOafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wIpmiuBK; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a34b68277so114635ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849922; x=1713454722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZcK1rfwTZjRRHJsk4dAWwu4NrkxOOrPp/qD5fIYkqA=;
        b=wIpmiuBKK8KJrHbiOfcy4CQ4OQHXGxUEHwaAI3iqaUlCypHsPhxNON4J3C/KusS6HK
         I+L4Mwt9NTNQQRWxu/2eIQaRqCZf25J4dF8Pe7KUiO2Rx/itxyo2qMLi46AqjzIPrLCt
         4oMvJp3Lj1cqsUXoaegy0Xq3WRyKaEo7rcthbO6dayIcy1T3uG4aVgi/NEpqxK5bL0E1
         cTn03eMAZYYLArL2t9w9dOVqUMHOPci0BCjO/u1YlJV2a0T82qyWbgdbn1jcD5/A1t8B
         d1nFfPTEQKD35b+z7eZ/TUpy4u24ux86EnqfvGCWTKLtwo2tMtVf0DHrbTxDHt8JBhVt
         wfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849922; x=1713454722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZcK1rfwTZjRRHJsk4dAWwu4NrkxOOrPp/qD5fIYkqA=;
        b=qosLEmz+H4W975hl8gLocQD4Zy4UpVqXBvOekXiqgfeNhufliSrCIkvwZloSm/mrez
         DNkAmP5QFiUk1b47xGe8WoCSQ+erYX+L0HZsW/zyb3BsKVdGQw1HJ0IwMdEtVTtegj2+
         Cct82P/oXdWLI8hVrfCaq4s/wnUJD0fpaw8pi/JCzqqyfQnwdEzXwkSAfLZee8SETdGJ
         GxWqWtd1FVtoTR+AhqZpu3a824IAKMw9Oh1CuvVUkbiVLItVzIqDtilF6aUX/REgMdrw
         3esJDziuLX2iqn5BcgOhRamoIBHkbPMc7dICgEh6qAOt7F4xltL5zyqsRMLEn7xWwjtA
         VmMA==
X-Gm-Message-State: AOJu0YwcH3vm88voNvWdooM7lMZi7/XPS+gID5nUP/C6FfdHXklJ3ggo
	IrHNGeoXCIRf4RGyzOEAUYuIwrRarC2hxPeYwdTkY3RMJx9BCiwRMLAXvOVSDZd+JIlWV7B0XrF
	i
X-Google-Smtp-Source: AGHT+IFuLySlU4iWbv5CDw6a/05Zws62ozI4Zsdn7o/vO1K2z/0X5B8OA3pCg4o98Ig67i22TzTNvQ==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr194733iob.1.1712849922076;
        Thu, 11 Apr 2024 08:38:42 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 254/437] watchdog: sbc_fitpc2_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:34 -0600
Message-ID: <20240411153126.16201-255-axboe@kernel.dk>
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
 drivers/watchdog/sbc_fitpc2_wdt.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index b8eb8d5ca1af..1619f92814cf 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -76,9 +76,9 @@ static int fitpc2_wdt_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static ssize_t fitpc2_wdt_write(struct file *file, const char __user *data,
-						size_t len, loff_t *ppos)
+static ssize_t fitpc2_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	size_t i;
 
 	if (!len)
@@ -94,7 +94,7 @@ static ssize_t fitpc2_wdt_write(struct file *file, const char __user *data,
 	for (i = 0; i != len; i++) {
 		char c;
 
-		if (get_user(c, data + i))
+		if (get_iter(c, from))
 			return -EFAULT;
 
 		if (c == 'V')
@@ -107,7 +107,6 @@ static ssize_t fitpc2_wdt_write(struct file *file, const char __user *data,
 	return len;
 }
 
-
 static const struct watchdog_info ident = {
 	.options	= WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT |
 				WDIOF_KEEPALIVEPING,
@@ -182,7 +181,7 @@ static int fitpc2_wdt_release(struct inode *inode, struct file *file)
 static const struct file_operations fitpc2_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= fitpc2_wdt_write,
+	.write_iter	= fitpc2_wdt_write,
 	.unlocked_ioctl	= fitpc2_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= fitpc2_wdt_open,
-- 
2.43.0


