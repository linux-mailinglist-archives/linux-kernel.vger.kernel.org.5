Return-Path: <linux-kernel+bounces-141006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A28A1A13
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B8B1F2207A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55B1C42FE;
	Thu, 11 Apr 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Mf8uJjuV"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF731C42E6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849895; cv=none; b=NqD+NIjfs59WAfsrHPRK4sLDXYTy4BafxYBTpYdzb0U7z3PexHbW5r9ypg3b4bWdmNAoFOliua1a3y7o18Mo0epeWbmoV2O+sXcsc/bod408XRKlZu4yAGpwpNoECOmQIX+chBwkc8qnO0hTH0MflQAom57t67qK3KbgOh8J1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849895; c=relaxed/simple;
	bh=6/+WHJeAq5tum1kEkpNqKpjWymK7+gbS40aMopxhBDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rL7sLXkpI9IjobPe62grsgEUv7bTqEuegA3peJ9fQN+YYrM7E/Nsd3OOQ2cyydWHD1Pamgpd+CnAwZw/Jmar+voiQr+xSu667fZ1mDiwpn6dYvXFgamA620MTc521qFWYygUb778zMQ5h6KXGbz9BovMXdZnLgGcS4Y+rflUJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Mf8uJjuV; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so8987939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849892; x=1713454692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5BCglZo6iVaCCleAsTPCfSecI5kckk3+SFyaP5fatk=;
        b=Mf8uJjuVgYHcFQiMUsm+kISzku8omtxqsLjb08Xt2n95TfOdtZ7OZo3FwvgqATwBjp
         /YszQIqHI4USNqUa/uSajs9dseOxZ1LfMBd82nolsNk/nfs2ktKV0hVGtN6Qlf/N0cxr
         SspMbcfzgWkzrPQk9SzHgc5bZcuC0ByvQZ9+6OoWO3LzZwvTcTP/aujRUqgFI2SPShcQ
         HSoU+9aamNCr0Y0mxMQfNjvwaTDACNm5Sw7rHSl7WjgEdQOHQg6rPGR/opjv6f1juRKv
         51YSEaik6RyTxt5Wuc8wnMR7YExZhPuKyvJ7rCcOGNGbosrl8YbVNI/yjAq3H/Trj2Up
         43Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849892; x=1713454692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5BCglZo6iVaCCleAsTPCfSecI5kckk3+SFyaP5fatk=;
        b=Z08f5tbeYgumNkHT82t5HgaPmN73zybBMWw0ZZ77lDsXCyL3QorWF3mKOisIX840Qg
         iDFIzX0p1N70Fr1cTflSsrORWHszgkqobb8J2HLY7ywptT1SPA/zSc90RLxox1T9kmF9
         E4iAWCTrigiW5Cla6fA0M+ky1FJdEAiAYwhUsXN1raNQvYCELigHqRykLMkreW1Zd1WA
         CGnmPMCaXperMzG1q0AsoB3YT3tloYyUEkLIsh+q+185n6jAcf21zO1zw3lxbq0RMbwX
         E6V6X4OY6OYN04klQnXz9gEmWuzUWcAOYAcfYenqInKRnfNQfox/ibVOfpTAAZIT+PLS
         tx7Q==
X-Gm-Message-State: AOJu0Yy5hWU1J9ln9ooKsG/YQILramVXHEdbCDgD8CrKFJI7oqUevLGo
	c69ZEEar0NU4UQk3gIjWDZsJm0vZjNsmsKyia0DVv6NmcUosGfcR1iMHAuldvvMQGZ/hHwBPXNO
	l
X-Google-Smtp-Source: AGHT+IEGTLll7CUAudSE9xkn6vyPAMxTcyvciT0m91/FVdrgWezeRNf2xd9R2gT+eT1SED/TgdbqCQ==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr227035ioh.0.1712849892389;
        Thu, 11 Apr 2024 08:38:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:09 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 234/437] watchdog: advantechwdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:14 -0600
Message-ID: <20240411153126.16201-235-axboe@kernel.dk>
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
 drivers/watchdog/advantechwdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 7a0acbc3e4dd..95c1b90abedc 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -106,9 +106,9 @@ static int advwdt_set_heartbeat(int t)
  *	/dev/watchdog handling
  */
 
-static ssize_t advwdt_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t advwdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -117,7 +117,7 @@ static ssize_t advwdt_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					adv_expect_close = 42;
@@ -218,7 +218,7 @@ static int advwdt_close(struct inode *inode, struct file *file)
 static const struct file_operations advwdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= advwdt_write,
+	.write_iter	= advwdt_write,
 	.unlocked_ioctl	= advwdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= advwdt_open,
-- 
2.43.0


