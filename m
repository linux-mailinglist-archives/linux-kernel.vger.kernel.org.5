Return-Path: <linux-kernel+bounces-141182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB28A1ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC73D2874F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F51F9605;
	Thu, 11 Apr 2024 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="dRt0qSd/"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7911F8C90
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850171; cv=none; b=HFugO1+a3BzOWzY/MW7oGTvDQE0AdkT9H7L3OQv8BauY8hRT69h6FTztdI7bKfgkAxCDxQlwwQO8po0FUzz4/x0TaRjhZfPrIw3UeagShggS+NnXtPQ3R/ziJYySOpuD4/gHGRF5PMhbv52ZjXvm4F6MBX/p5VhtXH8v0UaX4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850171; c=relaxed/simple;
	bh=STDVFpAkyKttnqWQSdobRcxuZdcuEEvFlaLOrWnl7+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=im+PkrcB5uZG1xEr7A3Y2Vp5gSysn+ZhxVDCLTWEmbU+cJi5+cqcp0aLor+9M6EQMZzt3u+/rg8kvlHHKhU1ZNAOJS91dzjlX06rVYANbq4avkbZ5XB7Sfm1627QCaygWCFvUv0U7+d41XaUxBC9z+3bcioKPsCv+jbe2bB6af8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=dRt0qSd/; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9938639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850169; x=1713454969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPBWypckBhBGW4D+1tLL366jc5FZH7e47fvl0X8R8zs=;
        b=dRt0qSd/enVQN3bjuhmWVlxxH1ltzRKNDBUvz1gPjfGSwv5md2WB0LDmaWdK6NqBuI
         /1WjQ+BCgUKd3C/a+sMeX/eTq38XmMgcPi+YO37QuFoG9wyYsxrtoq/q4yHYetyPozJH
         soU2nkpY/N7To7ctXTC+tqwI/Mqx2L4Q6Eo/jyeJeVA7ZTA1XaR330aR5pSBkEyrSvGY
         91Zps9ZV5FDfn0SGH6Q41I25yDScAfy+zkHIT1efVMKPMgaaEF5C7eLBW7xLyfgfIr1C
         Kz46shwxwy7J5REur5tL54SEergWyf9RS/4VyaRsSwIB6sKOugqebbB7VjU3VBvRrqT7
         oBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850169; x=1713454969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPBWypckBhBGW4D+1tLL366jc5FZH7e47fvl0X8R8zs=;
        b=hIEEb1p5N+oqnlg+jm+miYZGWZTXQ3fkmuYT82jVkFJH7ro2Oj7yoaLDQ4H7U+nxtE
         H3lOVdYWsuz35sNqDHBL8NgGRkLbMFo/Z1XrMy1k3H+XlmmRhyw0nK6pfwoZVNyVeK7f
         uW3HM4ML3A70W4trpTsGQsGPR79ekeTadL4Y7OPvj6tXGm/BGQ8oWoesQ/PineJrl1dT
         LhJh7EVnrCX75p6wNSSEGKa87YMDxR22vh2syapolB/RBD4o6qhnk6kwzROp7umYJyEv
         1S1jfElpzQrNToSYraI/rHMSNEXASkguLB08X12AVOFnimgsWDor2rJkesMJHW8MdIxd
         6/kw==
X-Gm-Message-State: AOJu0Ywk4CKwQL1DKybjbQX4EbCEgHgVowS9uFqlMgCruNynF3rBUg9S
	GNpBB56uKDhsuW8iso3sgSOGT1kfGAhgsvLVkF+ST4Bx1xtS82Yo38Fu1hTDnWJ5Cz5JmINz2v4
	D
X-Google-Smtp-Source: AGHT+IGfAHYUte8ZypZKI81inTUiQtnGngskwX6/QEi+9orH8zKr3JmizLT+Yd0hNfE7w6rsw/KEOw==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr237726iof.0.1712850167267;
        Thu, 11 Apr 2024 08:42:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:42:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 397/437] macintosh: ans-lcd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:57 -0600
Message-ID: <20240411153126.16201-398-axboe@kernel.dk>
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
 drivers/macintosh/ans-lcd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
index fa904b24a600..cfc0a95f0b8b 100644
--- a/drivers/macintosh/ans-lcd.c
+++ b/drivers/macintosh/ans-lcd.c
@@ -53,30 +53,31 @@ anslcd_write_byte_data ( unsigned char c )
 	udelay(anslcd_short_delay);
 }
 
-static ssize_t
-anslcd_write( struct file * file, const char __user * buf, 
-				size_t count, loff_t *ppos )
+static ssize_t anslcd_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	const char __user *p = buf;
-	int i;
+	size_t count = iov_iter_count(from);
+	int i, err = 0;
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "LCD: write\n");
 #endif
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
-
 	mutex_lock(&anslcd_mutex);
-	for ( i = *ppos; count > 0; ++i, ++p, --count ) 
+	for ( i = iocb->ki_pos; count > 0; ++i, --count ) 
 	{
 		char c;
-		__get_user(c, p);
-		anslcd_write_byte_data( c );
+		if (get_iter(c, from)) {
+			err = -EFAULT;
+			break;
+		}
+		anslcd_write_byte_data(c);
 	}
 	mutex_unlock(&anslcd_mutex);
-	*ppos = i;
-	return p - buf;
+	if (i - iocb->ki_pos) {
+		err = i - iocb->ki_pos;
+		iocb->ki_pos = i;
+	}
+	return err;
 }
 
 static long
@@ -135,7 +136,7 @@ anslcd_open( struct inode * inode, struct file * file )
 }
 
 const struct file_operations anslcd_fops = {
-	.write		= anslcd_write,
+	.write_iter	= anslcd_write,
 	.unlocked_ioctl	= anslcd_ioctl,
 	.open		= anslcd_open,
 	.llseek		= default_llseek,
-- 
2.43.0


