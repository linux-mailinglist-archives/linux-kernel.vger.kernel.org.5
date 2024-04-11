Return-Path: <linux-kernel+bounces-141130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0A78A1A9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DED11C23668
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4000250276;
	Thu, 11 Apr 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jIBm2PjD"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEE1EB1E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850086; cv=none; b=NUIlYi8ch3JHyTqmXUmUX4K90Wa7OzPaFT0C8rTSX/xXG7XUuhuFgbMm3OqESXUy+thW4m0wqbO/zAoRktbfMr6ZnEXFbP47MyJ33JaXlzPCvscErn0qzLIR3RZewrOjZ/TVv95aa4GnjXSo86zLTAk0wHjjXRb/APDzh5fh/R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850086; c=relaxed/simple;
	bh=PqDeDgy/De6m/OJg3diSioxuusmcMjaYGApdUFOMph8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRZwyP2SFIpDjmp0/fkW91ceuYk/0PZdyldhsScbSnX6vmLR50jkujBjHgvgd6/HGtXD9i1PZPn2iDAWoWtHqwRsfVbq80TDnPxvw+dqq49aUpYKEFrsr6M31VuGZZpJUaRRaCcNEbTJN9w+OIm2ZFdV3uN3F+LZTXatj7DcG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jIBm2PjD; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58237539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850084; x=1713454884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDokQDLdu8ydMVRcbu4qpXm/coItPHPFNmmq2PVMFw4=;
        b=jIBm2PjDUATTUEtjFgj8AlSjxECdPbBdIs2KJbA73SWqMTnLPwXGQD3cTgeXYr5mJx
         JhDXfE8TOMnRaaR3gqqRUB8OrVrKtKLAlyx9uwbDgM3tgH2oLc8TJWxewPixgu5g4y7/
         e1C9MlJXRzD2ZkaZv5GvKRhweCUrvubiaVdncOU0WcxvRHhdbL80tGBXFeZwMLhUaf9q
         aJQTMThQQFeogy8OJzpmW+fbi7uEK4U5f6kslddiKSYWuzSVV09cUeUMIs9jxeLq6ib6
         YNqlXTX0TaHA7Fnc/en63Tm2J2dGfqHQPBmbDWsMKtBJmbJ6moN34j7ct6iDWnNinQDN
         SxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850084; x=1713454884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDokQDLdu8ydMVRcbu4qpXm/coItPHPFNmmq2PVMFw4=;
        b=lj/r6xIwPKpvovaDidIqQpnnYt//rkwE+atCgBSM+TutnZvFpul8UMwilsvjX+5Z9j
         M0FFDfZquz4WD5dJr8kSb+gJfF1TU7ExRbVDaNrlnhvSU/mMiEpVUK2dHWY/xRe5QHA/
         d/5LJgwtMgkh2Q15GyU9sFYBxx3CJW7Wyl0lKalsbO6GUT4sfRyhkpg3lSyv1sveXmCF
         2DnQxxH/2YUwQ2eVb260QDHwzSgrK64RCe1SOc8t/+s3dHY7QVrvv8Zr4nThdzm4S3ZP
         KOsWXAlSeNAx9mFxj23mxSPNzMdqrKa1dPa2S81ELzUdzmUlCtS/39T7r4WShO4LaycS
         77Jw==
X-Gm-Message-State: AOJu0YzfZSw4O8KeCHUn/X+FHM8fiRBFH7bxZuVVESkoR9g5swdSoHLv
	Lvo7N2s8Na0vEHQfqpVlnQNfvo4rXc8bOKJY0YMTwMqB6ww2E+0rEGnNa+m1hKU3PUKjCFsNeUh
	0
X-Google-Smtp-Source: AGHT+IHrdQLsuEY4VQZHVdXifHMIIeXlnJNBqvz3tXiLXGbi54U91Zg/enZBUzHchjraN2CrOSmm3g==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr175815ioh.1.1712850084221;
        Thu, 11 Apr 2024 08:41:24 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 351/437] s390: hw_random: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:11 -0600
Message-ID: <20240411153126.16201-352-axboe@kernel.dk>
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
 drivers/char/hw_random/s390-trng.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
index d27e32e9bfee..b1e1b896907c 100644
--- a/drivers/char/hw_random/s390-trng.c
+++ b/drivers/char/hw_random/s390-trng.c
@@ -53,9 +53,9 @@ static int trng_open(struct inode *inode, struct file *file)
 	return nonseekable_open(inode, file);
 }
 
-static ssize_t trng_read(struct file *file, char __user *ubuf,
-			 size_t nbytes, loff_t *ppos)
+static ssize_t trng_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t nbytes = iov_iter_count(to);
 	u8 buf[32];
 	u8 *p = buf;
 	unsigned int n;
@@ -85,12 +85,11 @@ static ssize_t trng_read(struct file *file, char __user *ubuf,
 		n = nbytes > PAGE_SIZE ? PAGE_SIZE : nbytes;
 		cpacf_trng(NULL, 0, p, n);
 		atomic64_add(n, &trng_dev_counter);
-		if (copy_to_user(ubuf, p, n)) {
+		if (!copy_to_iter_full(p, n, to)) {
 			ret = -EFAULT;
 			break;
 		}
 		nbytes -= n;
-		ubuf += n;
 		ret += n;
 	}
 
@@ -139,7 +138,7 @@ static const struct file_operations trng_fops = {
 	.owner		= THIS_MODULE,
 	.open		= &trng_open,
 	.release	= NULL,
-	.read		= &trng_read,
+	.read_iter	= trng_read,
 	.llseek		= noop_llseek,
 };
 
-- 
2.43.0


