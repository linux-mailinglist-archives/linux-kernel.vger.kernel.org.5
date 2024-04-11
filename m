Return-Path: <linux-kernel+bounces-141121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6778A1A95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EAB1C234A9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07128166C72;
	Thu, 11 Apr 2024 15:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mFUi5QJU"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30001E82F7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850070; cv=none; b=nZWdJXotFEiibyHbRhjADxx4ZUa24ouH4nF0WKQjgiJt5Z0oVE483TQMckkDdrxeSAWal4bsDnpjZSi7GyI/aAMdj4goC465kiHDoUdAN6+qG5kq/Rliant3nvUPWr3vpMfQwl6hJqOpFpD71mLHgjZ6P3TsDXQPWwrZxlFshGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850070; c=relaxed/simple;
	bh=ITb8KOwmbUKgoOui9gC0IKYwtAIg0e4C0OHDvvGUThc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYUPhSJR4uJ4mbh3Ds0gspVOOxcUTdOmxvSCVCO6g5JEJ59kLPTfkSqWvdcPL/IVy1JsYDnKc/MbR+nTKiOXHU3cMmsWtLYmmNMwry+UtDcoV8zf6kvrRyV6OUY1cGqEPhblfkARGru2MH2uOLNHwQNDy65CQh8MQs4dT2OypEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mFUi5QJU; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a224d7414so194345ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850068; x=1713454868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vv4bAOODXJgx8r16bKbR8tk4hrWGJK7Hg/pbVqwYvpY=;
        b=mFUi5QJUJWspUOnn//qM4WOq3HjXT7ZRENOf1qsGOCRA3/5ZORA6RiZkKdGhiDvT1G
         yfAb8c7ZZgltAMBX5aM7wmoUw7ifJLF5JfdbB4EezYPuSeN1ciZFfXVbfePJeLk50rhH
         vSLzyoZbSlTUl7BIhszuGJy05gDz4jEBKiTU+5uo/rfN08ITAUg9oR8MiZFQNBOcidmN
         AFZoHXNEo/b7gFj2QcNz0bvtQUY8xGOVqqRMg/wduym0ELVk6w/fVg1euNd6o/ZvQLkD
         8y1Ozx7vHzci9TYAayLcu12nNentylONodL0M8ss4d7m6G7I+ayXUxGj6uOFUQU2F2A3
         EYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850068; x=1713454868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv4bAOODXJgx8r16bKbR8tk4hrWGJK7Hg/pbVqwYvpY=;
        b=u9Tn6pIiDUCLmxynvR+5AErLsmmTcUr8w/2eqtczJys2yR1U3nk2IM8HMg1rzYF6WZ
         oHR2MxUV4xoBn+jLqImoQBocjadkzMXFZhyP+VSkHByuqbSewt92hrSy19B1YHCKPyJh
         OE+BqgB9EsPKoVbHzt/YxIGQbUNFLdWQyHGfcmpb7aF01rjwnBf5i1ePbgx4wdkh/vYh
         3arXMozksA/jX6zJoyBRlozigifFKLKknv1nZ9O86L9Ee9p13wZfDR57yi9Ls9PA+blY
         aHRQyTx+EzYtz5h2zBMcfbKKUEcoC/+oF2KLTEfhzs2vpgitpYkifiGaT1l1NrC6O2t1
         79Dg==
X-Gm-Message-State: AOJu0YzkgpcTxjyIWnvpjVU3Tr4SY1VMnYA1a3QcoKmvQFYF2ad6LE7m
	+JhGCIWzDgrQfZfkA+VsVYOet37FVfv5LvJGdO6O74xte9GjYAhNEDwDIJMxNmyrUn5aS/M/sPl
	3
X-Google-Smtp-Source: AGHT+IFbPA6f7MWU6nmLo0b11jYuqQ/NhLduoV8qSDFr4iBixT7iQiJaR0PW0X7pj2vorR6Fg9q1WQ==
X-Received: by 2002:a6b:6605:0:b0:7d4:1dae:da1a with SMTP id a5-20020a6b6605000000b007d41daeda1amr160805ioc.2.1712850067881;
        Thu, 11 Apr 2024 08:41:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 342/437] s390: fs3270: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:02 -0600
Message-ID: <20240411153126.16201-343-axboe@kernel.dk>
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
 drivers/s390/char/fs3270.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 4d824f86bbbb..c8c767342167 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -276,6 +276,7 @@ static ssize_t fs3270_read(struct file *filp, char __user *data,
 	idal_buffer_free(ib);
 	return rc;
 }
+FOPS_READ_ITER_HELPER(fs3270_read);
 
 /*
  * Process writes to fullscreen 3270.
@@ -316,6 +317,7 @@ static ssize_t fs3270_write(struct file *filp, const char __user *data,
 	idal_buffer_free(ib);
 	return rc;
 }
+FOPS_WRITE_ITER_HELPER(fs3270_write);
 
 /*
  * process ioctl commands for the tube driver
@@ -509,8 +511,8 @@ static int fs3270_close(struct inode *inode, struct file *filp)
 
 static const struct file_operations fs3270_fops = {
 	.owner		 = THIS_MODULE,		/* owner */
-	.read		 = fs3270_read,		/* read */
-	.write		 = fs3270_write,	/* write */
+	.read_iter	 = fs3270_read_iter,	/* read */
+	.write_iter	 = fs3270_write_iter,	/* write */
 	.unlocked_ioctl	 = fs3270_ioctl,	/* ioctl */
 	.compat_ioctl	 = fs3270_ioctl,	/* ioctl */
 	.open		 = fs3270_open,		/* open */
-- 
2.43.0


