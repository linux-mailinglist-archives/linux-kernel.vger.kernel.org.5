Return-Path: <linux-kernel+bounces-141111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8E98A1A89
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA66F2842F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F21165FCD;
	Thu, 11 Apr 2024 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EjqQspbx"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51574165FA6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850056; cv=none; b=sEpTBdNY1XbHvkhHkwhYW/Q7pxAS1mlBKIvnBZpJyW4mJNnJ0pVxTm3nMSnjA1Jpb14BLafiwBFT+RF/SyIc2O+Vx55zFBrou7AOvX8mFFWiMSsHzrYQFQ5k2GmCLjzHWxiKmzrwln6VT8QvwgvmOhAy1oK7AIgnl3CYAB4yDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850056; c=relaxed/simple;
	bh=xijPwjWmymtw1tBt+Sizqj7Uo+0bAjoiGy+bdtcRnB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKEUz04Ch7dgOXE3NLK4lh1r3cIn+JBaQZyce7X2MBTDa9bjA7pRh7s/2JuOnx8QFkofPwtufeztSptHNZ0M2hR6nShMlr9OTh6xPeZtVMWDcoD7duRJhsqBSdpwaMnol8u/pZ8kBoAfAUgPylLa6Ds2iztAbK/gxxAzKTeCKuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EjqQspbx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58218839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850054; x=1713454854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTDbZ/sPhGUL0gp8p6TK4lEEPdBeX2CDKpqOn++pqBo=;
        b=EjqQspbxwS42ThAvrpXFJM0rsN2U+rj7A+ETa8dZuXWrEydFwK5fiEehTqDg2VQEF7
         3OCKP03+RkeTfWAJWOO1qyLKKBVfk3IgpTbME+7gv1pa9/q/wDzzQxf1jTvF0JlNfmlN
         IfziCMtJTgaEYgxaDSTbQjwBzROgjjJco9vQRHe6TUbbABx+K25UKd+4mQxhKaZdXkgU
         Z21MIGcAL4SrNVdarC00XRagtwX/OY/u/ovWv+tWM5TkK4WUmCYziS10C2pOs5NEyceU
         usmtrwz+Ir3YErLykUQlHJj6uWpyB1mt4MODPjwqogAmTx2H/I0zMaTzFnn5Sur+gkAe
         q4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850054; x=1713454854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTDbZ/sPhGUL0gp8p6TK4lEEPdBeX2CDKpqOn++pqBo=;
        b=vUC8+JFgeHSXSmp93szjSfLuCwtfSdTCl5nDpHcw/EeCwliaGM0uEwzS76TLHZBaex
         cbCAh9o9wseYN4PuJ4jhknQlnWv1kKomfqN9Uqg0Mg5aDmpqXTs0rbC7UWwlqoJaPQuK
         J9ML8nwJXhToI0pbOlPnHUyOj+cjhgwIynkUq0MZzf+W0Uc3G5IZGOcJBNEbmUlnaY14
         2TnWADcK4l5AgBQLl9vIhFeq7/7g74cTBO0zZrw2bPc/NJey12YdSDo+PwsQTC6pUKaF
         R245/A47pho4ioC0dkTiTIaVIjpvFqDzHXauagkJz+98JAyK7qtw815dEXjriduOYR0i
         WCpQ==
X-Gm-Message-State: AOJu0Yxz2+ufpsgsL3V8SN1fUzf13+0lsqFKYpwZJFbUIHT5q0Z88ZSz
	/vjCmWRUmagJBOGQXrGpjJ0jmTWMXAzMBA9nurOGMo1NLUdCF01AhqkX2qCu6ZsATu85t0l6zCi
	N
X-Google-Smtp-Source: AGHT+IHx0vzBojxjEkNzN1xSh6k/Zd36JJgrX5mOouhwIzrW4FgX4xfMB94LJa3JXVYQRel78JooHg==
X-Received: by 2002:a6b:cd08:0:b0:7d5:fe3e:90ff with SMTP id d8-20020a6bcd08000000b007d5fe3e90ffmr211331iog.0.1712850053760;
        Thu, 11 Apr 2024 08:40:53 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 333/437] arch/arm: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:53 -0600
Message-ID: <20240411153126.16201-334-axboe@kernel.dk>
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
 arch/arm/common/bL_switcher_dummy_if.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/bL_switcher_dummy_if.c b/arch/arm/common/bL_switcher_dummy_if.c
index cabc0659b329..f9794c4a6a40 100644
--- a/arch/arm/common/bL_switcher_dummy_if.c
+++ b/arch/arm/common/bL_switcher_dummy_if.c
@@ -15,9 +15,9 @@
 #include <linux/uaccess.h>
 #include <asm/bL_switcher.h>
 
-static ssize_t bL_switcher_write(struct file *file, const char __user *buf,
-			size_t len, loff_t *pos)
+static ssize_t bL_switcher_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	unsigned char val[3];
 	unsigned int cpu, cluster;
 	int ret;
@@ -27,7 +27,7 @@ static ssize_t bL_switcher_write(struct file *file, const char __user *buf,
 	if (len < 3)
 		return -EINVAL;
 
-	if (copy_from_user(val, buf, 3))
+	if (!copy_from_iter_full(val, 3, fro))
 		return -EFAULT;
 
 	/* format: <cpu#>,<cluster#> */
@@ -44,7 +44,7 @@ static ssize_t bL_switcher_write(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations bL_switcher_fops = {
-	.write		= bL_switcher_write,
+	.write_iter	= bL_switcher_write,
 	.owner	= THIS_MODULE,
 };
 
-- 
2.43.0


