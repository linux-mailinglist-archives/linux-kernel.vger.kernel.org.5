Return-Path: <linux-kernel+bounces-140856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042B8A1938
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46C71F21C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658411384B3;
	Thu, 11 Apr 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ik19F6gy"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7422D138495
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849664; cv=none; b=UPTcStsCIv3n56UA32xnIsM9ceupPuHoEdSfPOI+S3/6SneQoHLmbWslWCtdgHUWJAGEwVujImEqCDHy1+KxpjBsqgWEvkubi1YA8XB6ugCgYs05n0UW4uonl968Z+S55EtiIRk59/wOe9bZxSEWg8PEX/f67/UdlPaSRAiVzwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849664; c=relaxed/simple;
	bh=wipL4mL/eUvbX6HEd5vhA+QIcjWUcNKLmam46xT8Cxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7tJDMKzAg2t7bAsNysHoNziwOQaz+SVL4dRYnzDWcdAlbvHRLIT8eVFsF7akEb/wHhbiXw6nw/D7dx1F09TzN/m+Gr8MqfN+oVXI7yhgWKYOBNh6tX8v4kPmlylaoPbCRMqwpC9c6HenZz1r6cT/12OEPZ/lxbJpjYFXBsfntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ik19F6gy; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8907939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849662; x=1713454462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hI3XeuEqXSe5xAQxoRI1k1fUfRRMoYe2Nj0mBwtIi0U=;
        b=Ik19F6gy49aLTfUrNt7Hem5ufKYpvdWEEZWvpg1/67ZiXPH49bGbJjFJQPyKEtxz2o
         cV2AVl421n6ABaWCuzZ9Cv5pzASxDyuRXF4UiHIzqes/KdF3LHjMB7Wd0PAJ6cYYkS84
         3w17X0daPMOOEcmBrx0Y+ATCRSUgdojlzPmx7cCDoZ6A3qUbA+bDY4+6j41wjGIolumd
         dpp+DQ6YLLDY8jAd3A4lhhx+mKKu6kBABFBX75oxFqTOvtmMTCd/avGwozu0gWa7FUbw
         HU9zmBh/GWY6xbitrMtQyA7JS2PSQcaB3VvVbVH8JFD2iYEO7jsXRep0Jec6HcwgT3ZP
         oovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849662; x=1713454462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hI3XeuEqXSe5xAQxoRI1k1fUfRRMoYe2Nj0mBwtIi0U=;
        b=ARxY+556syhrwu810YlEkWdirsKbu2F2wWUSLqTiBbJDOrDnnhuF7q3vZT+356SK/j
         ZcSjG8HD7Zh7U32Bss2goMKkVAhpIbkGyPzQCUu8v4zKrZ3S15Cq1qBFNIjRH1kGEOjE
         6nHtVgqtpZeWA5hcvr9d+WLNcM3zv/FfkazOkym5DwP16vnFAo/dqYWdzyYgq5QgziYP
         KngTXx5boW3kbjqDYmqvUTKAGhRIDMyS9/+/N+RDZ/buBwGg/zJleTGfK3+ZgC2GoG0v
         8ObOOWmxm7QeYsO+5vbrYrg/FqZ5TgqgYDJ4zsWNNP3tiYCdzveVvDWdnwz4CTtPEkQH
         cbwA==
X-Gm-Message-State: AOJu0YxcIg3Fbg6Ph5GC/Y1YWWb5Z5vzRU4iUwDtt5eXjtWHk4d7CxkI
	lIKnlUynIO1kv/M8VngpIVsq5s4SS4K0Fjy2otPw7Sm2aPulpdqPNKCWvMWf4WBtkSbxXPeEHw2
	9
X-Google-Smtp-Source: AGHT+IEbL8urxZb3orUijOvDtLuuzsgLfSrxCXfZO0P4dSjvpBsjhCS0EUyZdhIScjnCWRLC/A77dQ==
X-Received: by 2002:a05:6602:21d7:b0:7d6:9ddf:5095 with SMTP id c23-20020a05660221d700b007d69ddf5095mr9953ioc.1.1712849662442;
        Thu, 11 Apr 2024 08:34:22 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 094/437] lockdown: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:54 -0600
Message-ID: <20240411153126.16201-95-axboe@kernel.dk>
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
 security/lockdown/lockdown.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cd84d8ea1dfb..ea208d3251e6 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -93,8 +93,7 @@ static int __init lockdown_lsm_init(void)
 	return 0;
 }
 
-static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t lockdown_read(struct kiocb *iocb, struct iov_iter *to)
 {
 	char temp[80];
 	int i, offset = 0;
@@ -116,7 +115,7 @@ static ssize_t lockdown_read(struct file *filp, char __user *buf, size_t count,
 	if (offset > 0)
 		temp[offset-1] = '\n';
 
-	return simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
+	return simple_copy_to_iter(temp, &iocb->ki_pos, strlen(temp), to);
 }
 
 static ssize_t lockdown_write(struct file *file, const char __user *buf,
@@ -146,10 +145,11 @@ static ssize_t lockdown_write(struct file *file, const char __user *buf,
 	kfree(state);
 	return err ? err : n;
 }
+FOPS_WRITE_ITER_HELPER(lockdown_write);
 
 static const struct file_operations lockdown_ops = {
-	.read  = lockdown_read,
-	.write = lockdown_write,
+	.read_iter  = lockdown_read,
+	.write_iter = lockdown_write_iter,
 };
 
 static int __init lockdown_secfs_init(void)
-- 
2.43.0


