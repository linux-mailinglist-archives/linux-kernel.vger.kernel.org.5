Return-Path: <linux-kernel+bounces-140982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202048A19EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFE8286078
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE53BBC7;
	Thu, 11 Apr 2024 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TZPzQtGf"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AD824A0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849858; cv=none; b=l10iaP2Ve0Sie5fQaXRIxWksxFiuyhZedJdaBkGMhkBixS+bDThCJHB/Lir8LMIQUNFG9fvjwCnNYcKduDTo9LriEZftlqQj++g/9BCDSUTBmKg7PeV8YaJ1ecz3mVeKsczD2uqEp79haI4N3Wl2z/rUTJoxg7kCQ1py9tTUJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849858; c=relaxed/simple;
	bh=BAPWAjZLiDROs8jxMHAOxFaSHauyl2uBclzPLslEJ2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgHX9Apjyf7wDcNH4nkNrVaRPyl1kVx2nnoYmRCG6jDh65AOwxP6Q6KJGUZyi8ee2LSW+nMhKaBhTpwLOkMGBQmWNKzBXR1T1V+pkJKUXj5YPhf23B0nHKHKAUlN/WElFHl+0hIuCjDoz095NZMMP5G9p3B+IbU54NouBk8aRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TZPzQtGf; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58108139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849856; x=1713454656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URP2qTC8kfAbg68QrAJNbB4HOOdUB0afPA5uur+wxo0=;
        b=TZPzQtGfkEqixlwJDx/4aMPxQsA650iHZOkSqaLCqhsTJyH+1OtnNRMfduMqkabeZK
         seYzVftWaEpNGKYf7env9x8iIpvM6Mh/xSWeaakIpox1JgrxI7+hNOMkOoJY+/t7j6F7
         5Y76w/u0swX8udv0scANjHrDLeKaCt+AXqZWu4MY4T4KBWHRKOcGHbZA8UGg7b6ockA3
         romxGAt8rBP82GaAvgK/6RKdK0nukJcT94SEhN6xGC09gozArpeE2hPf/91QIYBMRB0z
         gm/+ed2bqgxQW/1KEkY6gPPfRPjKCSROzINOTqhuS6UKzoY6Di1hHzjDx0IY47uWLPS7
         6PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849856; x=1713454656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URP2qTC8kfAbg68QrAJNbB4HOOdUB0afPA5uur+wxo0=;
        b=rXyqNiCS38Wk6aYyV2YG5bicfMyP+QFN8niT8kL0mG30Ez1REVGWoQSnwUA7TXe4jv
         oF8J1mFGh9+b1/TmgbmcYtGdl3bY73c6nvsdF1joOt4fWyiVSvL0tjyGi2/JYMg65l+2
         ul5FPJ/vpVYfK/ZqL5xKzi5NuLuGQSmINrFdRd8g3WYX7VEYn/5FjTtAz8OrRA908ROg
         gerLC8+6+2i0hFdOZK+dZ4s8dpnomgFxj5JPbcFmAf+awJ/X//DH4/wibxTLSjDzekpg
         tV47IuQeLaX/eHExzNKUg4l6SaZFgWn+dFVVxQvPyaI82Qo2m/igi6VaVFrbeM5z4OfS
         9Qeg==
X-Gm-Message-State: AOJu0YwJs0mPs4b4fIICn0EdnLOK1tRcdk06Vdv1YdQXHhKrHgAY+yiK
	werG9nf/TBbc2fHvW5DdOoEATmzEUDy+AyR59NsBWctHvVuzpicDugACdPTE/Uv+CpsfTyHigLo
	p
X-Google-Smtp-Source: AGHT+IG8jZcgUW4t+29t9+YD5GFKkaOIqqAeOZyjQT4aIh4EWqH71jFBjK14TXyyp/9pIy400ODDzw==
X-Received: by 2002:a6b:f312:0:b0:7d5:de23:13a9 with SMTP id m18-20020a6bf312000000b007d5de2313a9mr165215ioh.1.1712849855715;
        Thu, 11 Apr 2024 08:37:35 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:37:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 213/437] misc: lis3lv02d: convert to iterators
Date: Thu, 11 Apr 2024 09:15:53 -0600
Message-ID: <20240411153126.16201-214-axboe@kernel.dk>
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
 drivers/misc/lis3lv02d/lis3lv02d.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 49868a45c0ad..e12677611146 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -27,6 +27,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/atomic.h>
 #include <linux/of.h>
+#include <linux/uio.h>
 #include "lis3lv02d.h"
 
 #define DRIVER_NAME     "lis3lv02d"
@@ -596,12 +597,12 @@ static int lis3lv02d_misc_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
-				size_t count, loff_t *pos)
+static ssize_t lis3lv02d_misc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct lis3lv02d *lis3 = container_of(file->private_data,
+	struct lis3lv02d *lis3 = container_of(iocb->ki_filp->private_data,
 					      struct lis3lv02d, miscdev);
 
+	size_t count = iov_iter_count(to);
 	DECLARE_WAITQUEUE(wait, current);
 	u32 data;
 	unsigned char byte_data;
@@ -617,7 +618,7 @@ static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
 		if (data)
 			break;
 
-		if (file->f_flags & O_NONBLOCK) {
+		if (iocb->ki_filp->f_flags & O_NONBLOCK) {
 			retval = -EAGAIN;
 			goto out;
 		}
@@ -638,7 +639,7 @@ static ssize_t lis3lv02d_misc_read(struct file *file, char __user *buf,
 	/* make sure we are not going into copy_to_user() with
 	 * TASK_INTERRUPTIBLE state */
 	set_current_state(TASK_RUNNING);
-	if (copy_to_user(buf, &byte_data, sizeof(byte_data)))
+	if (!copy_to_iter_full(&byte_data, sizeof(byte_data), to))
 		retval = -EFAULT;
 
 out:
@@ -670,7 +671,7 @@ static int lis3lv02d_misc_fasync(int fd, struct file *file, int on)
 static const struct file_operations lis3lv02d_misc_fops = {
 	.owner   = THIS_MODULE,
 	.llseek  = no_llseek,
-	.read    = lis3lv02d_misc_read,
+	.read_iter    = lis3lv02d_misc_read,
 	.open    = lis3lv02d_misc_open,
 	.release = lis3lv02d_misc_release,
 	.poll    = lis3lv02d_misc_poll,
-- 
2.43.0


