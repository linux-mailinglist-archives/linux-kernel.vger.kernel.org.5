Return-Path: <linux-kernel+bounces-141050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB138A1A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115141F22433
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9491B1D06A1;
	Thu, 11 Apr 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0SO3hafi"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9585146522
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849960; cv=none; b=dbAmV3zSHjxYMSkXUdj8kwgly08S908DjPLwHdIB9fYa2rPXcd2hZBI1F2dQIIJtGuXokSFIoyFPjTK0XEFOvEHhLmQbCHDGqmM9hBN+oI40uJQmw2uBdz4oOttA2XOa8ew8iyvzftPQVFlWD/8xfP+Ofj8VHhEewuuaBXWts20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849960; c=relaxed/simple;
	bh=1P3PvXzmLXRyEqwVZrDsHvdiTkQ5YAPCllYVkquxbos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVBqkO6lgScWTPWbW8Diwq4Ie9vV8UnHHlhXo8dfxm1YtF/sBJyZTkKDpHSTA8FXiWS5pPKPqA96xS7kmZu4AiOWZrBWXQQwZM8PPFlUQ53cyFObAC5DJsYU2iUaUvDnTnU5EfzStWdU+agDeGzaJkI1D5v4fBJsmZFw1Atf79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0SO3hafi; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d67d1073easo9854739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849958; x=1713454758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKexpSQQyqoFLPKhZyGGJ/yk2BE5+WHRWZNOAGWWcOE=;
        b=0SO3hafiqAUPUsxFAyZEbGrrLeyQXF04F9q/5t47EBgJY3no17n7dzTJMLwmUx5Zzb
         mZs43Q9vsJIxpl8M743JbhSTggc0b+NsZopXUc9U9v4lBglzpNm7ubYqa5DP6QlLA3Qa
         cDm117bRpA7r1yHPV3wLAEQzZoQM67PZWTRgoAnBoJVJQvDRwBWSlz4SwUpGglLemdbJ
         cHrR1E0hKlP+eHMcUKnxmNYZHDgHSqWaDajK6sKMimZjOoqRgg8kgpQjwXkptSigXV1r
         oIkQmpyxrISiK2KOw6K0u94kmwnUvccnCzzlE7KsVyTeMW/tlXFaFUnQrHkxEKNYJoEg
         XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849958; x=1713454758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKexpSQQyqoFLPKhZyGGJ/yk2BE5+WHRWZNOAGWWcOE=;
        b=DhBXzeJmafVrIXpRioM7TFg0lYk5p6hfDbuQBi6SS/yLFBm61A4XFJ6akMEEAZTCAE
         P7canPPS4Z12UR8hXxFRplL5yAA4GdYwlkmBBQ2oLguoP+U3BabEtcDMVFN3A8oBQuzG
         rMGWL95TevJN99/gg1YCcto1yQ2JklQhhww3XL6eGMFyo5Pii1XNHPQuTB53EVZxhbgM
         sUtWWFpR7KoScaFuesaRkqJdhFSMp5BtTH9lmWEuH6Bq+CPwus4B28grvNxU83Dt51qV
         0rzD5DJkKhVaTL1RfD4SiuCuV82a9RkHLXqnTdswdz3xA+NcnAmbj0XTyavH1CLZvTpD
         Wq2Q==
X-Gm-Message-State: AOJu0YwSNXYYLdJMpKuM1sI6b/135qVpQj/KE8PZce8IG0Gk3BPFGAd2
	rmYPuKk/q6N4i8S62shVJ209Z5r8RchAlmkWg5lqtGjK5TAWwplbz31cj7hIIWJQbm4lxBwyp+W
	B
X-Google-Smtp-Source: AGHT+IF8OAWwnp+ltJT3BQTpk83sMFklSXMKE6Le/mZ15E6LAWrx6spdiDIIJaVMhp8wIPxQfHMGWw==
X-Received: by 2002:a6b:7b05:0:b0:7d6:60dc:bc8e with SMTP id l5-20020a6b7b05000000b007d660dcbc8emr201242iop.1.1712849958396;
        Thu, 11 Apr 2024 08:39:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:16 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 276/437] watchdog: sbc7240_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:56 -0600
Message-ID: <20240411153126.16201-277-axboe@kernel.dk>
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
 drivers/watchdog/sbc7240_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index d640b26e18a6..3e31a047bb91 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -91,9 +91,9 @@ static inline void wdt_keepalive(void)
 /*
  * /dev/watchdog handling
  */
-static ssize_t fop_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t fop_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	size_t i;
 	char c;
 
@@ -104,7 +104,7 @@ static ssize_t fop_write(struct file *file, const char __user *buf,
 
 			/* is there a magic char ? */
 			for (i = 0; i != count; i++) {
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == SBC7240_MAGIC_CHAR) {
 					set_bit(SBC7240_EXPECT_CLOSE_STATUS_BIT,
@@ -206,7 +206,7 @@ static long fop_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 static const struct file_operations wdt_fops = {
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
-	.write = fop_write,
+	.write_iter = fop_write,
 	.open = fop_open,
 	.release = fop_close,
 	.unlocked_ioctl = fop_ioctl,
-- 
2.43.0


