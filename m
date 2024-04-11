Return-Path: <linux-kernel+bounces-141052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 606238A1A40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902321C22653
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333681D0EE3;
	Thu, 11 Apr 2024 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rBa0+pzq"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCE1D06AF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849963; cv=none; b=ArEEQgNntLTKY9dWfucoxGWRqlAxFJkt/HWhYD51eSdAR8ihd5/jItpPo6FeFVquN3AiQYwhqPANNKtT9TFpXKwivbWHW05NbCiyoqiSEI2n1LmU8lxeNe65RekRee/G0D46r8e41ew6xpZUpucHqRPTeF7uX4Xkf+OhQSObI/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849963; c=relaxed/simple;
	bh=KnIgl6MglrfY4Pt7bofkCvBlvNUeMdpx2F0wfVTu/FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g27Z6T7FkUY+5BOf3a9ZULGKwsHJKrRrRuU8xEh1guEmaIBrkGGdcwM7qTsWk+ZUU/rM1wAewg0/ldPuNEt/jVKiBg5y9ylGrHvJGPIRl0LQjAho/EYKNIlZ162xes+qYEktIapS0xBB4ZlTCBWpnT3SAO3v8F3lhUVH9vD46Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rBa0+pzq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16211239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849961; x=1713454761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6G8RAv71+gB9tO1QisjQW3vm4/xEhWblxWLBkHrSlY=;
        b=rBa0+pzqw5Ix3Ga47dRUerWlGzpW01jwIzw/FOjVbdKONu4iBTyE+zqmslWno0hM9w
         AzdEiGiSXAPJSa5GRntcGNH1F/LpQx/85Qfzhy7+TAqvXgsgUaWE84yS823dlwjlyOLg
         B8/EzdaOiFhJC6Kg9P33Q5Z/c4EfcFSCzrsgegg7LWwRNx9xteyh0Z37zQwg7rdp6bSo
         QWGWKVaHSIDHBkgFgRLC6VRrxUZ7D04qRl7AfOl8ox+S5kPXPlO6QfuvdLNd7OjJqoKW
         z8VCVgZ+u9PW7bL9FpjD8Z3wEGL6GbgQXm8LADQ1iwsiclKvMKxh7dhY4Qc4ziwaqeub
         2ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849961; x=1713454761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6G8RAv71+gB9tO1QisjQW3vm4/xEhWblxWLBkHrSlY=;
        b=CJARdhw5PZG2oRRLD+Ne15l27LivKMd5VUYpTpfdmIvEMDSptIkZ1CMXqWgn5AUQb7
         2DHoJnWJXZxd3cEJA1otXPX4ZYigjMqIuiQEopEU2tteE281DIm8wVwnmA99Qq1VUA4D
         Yg+omNmRJaDneqy8HQ3KbaCkvY8REi0CSGgansUpjSmMpvSWhGTjXdge91KVejAugl/p
         Ecvh0veWnu+cBqfDS08b4PDtiemu9VTBrm6fwJhDWIIihQHaPQWcoqF/iOEBK3mfgSbj
         lTA0vwoQlfVDYpUBA/8zIAL9eFuok78OcEXq3u78fqWCyckgTNr2ei1CiQE1oqUiceOn
         BAIQ==
X-Gm-Message-State: AOJu0Yyb3gSxxXnVEt4Mjh0wwRwdZjICwI9w8/2iuIah0um0YR1dPV7n
	xVl581PbF9uJk5if9OdURjobzL/SYIboTlOLdFpzFJQbXl9j/BtPuNGerhgP4b6lVboYJbmaP+1
	5
X-Google-Smtp-Source: AGHT+IH3RdrqUtnTptptmjmZ4TCgDnV6ILHKj3WtgTrkwZaQYht0xcILzsFJYQGpUjFJYZ/FSy8QIA==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr169765ioh.1.1712849960921;
        Thu, 11 Apr 2024 08:39:20 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:20 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 278/437] watchdog: scx200_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:58 -0600
Message-ID: <20240411153126.16201-279-axboe@kernel.dk>
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
 drivers/watchdog/scx200_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 7b5e18323f3f..a9b6a4734805 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -128,9 +128,10 @@ static struct notifier_block scx200_wdt_notifier = {
 	.notifier_call = scx200_wdt_notify_sys,
 };
 
-static ssize_t scx200_wdt_write(struct file *file, const char __user *data,
-				     size_t len, loff_t *ppos)
+static ssize_t scx200_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	/* check for a magic close character */
 	if (len) {
 		size_t i;
@@ -140,7 +141,7 @@ static ssize_t scx200_wdt_write(struct file *file, const char __user *data,
 		expect_close = 0;
 		for (i = 0; i < len; ++i) {
 			char c;
-			if (get_user(c, data + i))
+			if (get_iter(c, from))
 				return -EFAULT;
 			if (c == 'V')
 				expect_close = 42;
@@ -199,7 +200,7 @@ static long scx200_wdt_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations scx200_wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.write = scx200_wdt_write,
+	.write_iter = scx200_wdt_write,
 	.unlocked_ioctl = scx200_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open = scx200_wdt_open,
-- 
2.43.0


