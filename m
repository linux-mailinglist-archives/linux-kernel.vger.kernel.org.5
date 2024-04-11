Return-Path: <linux-kernel+bounces-140883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E1F8A195D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8492852ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0297615445E;
	Thu, 11 Apr 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m7V5Dk4z"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203D154427
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849704; cv=none; b=ZuTq19IMYSMKCI/Qgxa49JeUnHuEqOZAyCpf31SH4ZuK1Y7aoM3EKR7p8JYKap6ZaAKLRFHFYa9lDCGpDyfNv4Y2Ja+ksM/BSgAna4pI2OkVVIZfrHx0silziYUdE6W0wVWvJ+D2PqxOO7D4fd30mG7wOD+zvd1bAJo1lq3HpH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849704; c=relaxed/simple;
	bh=3WfvtC0aVxY8sxWr4KA1HiqIcn/eMFvHh7cjcqT6WgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPMXhOfsUnEeWO2goh+MxU68mDsQ9k2O1bGOsH6NdYBpcWj6mjFLygV/dhJtmmcXuIMiiZZldckG0y6ynVT/0y+OObm0EcBUk0ovk5XvUXbKLc87DDbIreQc3WIAqOM1uH2ixGhCm3yHW6/ZpVJuWQFsgt4Uw8mBB5UUrEsxIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m7V5Dk4z; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso69544839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849702; x=1713454502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqPnTCe0Xo6bQ7p9WTFouXnMftwoUpbMZgUNJItMSNs=;
        b=m7V5Dk4zixbqhMckfUhxWYwgIqbgxpfIryjMwTBBslNwiVNnuDRR+CYaC44zI6MQcE
         +2APpCtyTPSFk0Ak1nkQ5fyCqBlmwfiFD1Pl5EFygYx5aes8isBVT83ShMnzoE0TSmiZ
         kc+HZz0dII/hG/9U51AsESQNnYj6a6OWeUI252fyfSXsL00QPc9HWgKFsYvl9XYSo+Is
         FfZZfbYF2k30ahYSvoyzqu7I7yox1gH+3sJTVdyV+Uj6lJyImXZfX5Uad3bgK9iuzLze
         /222DUk9WlbibzA5Qw7FRheZn0yYGgf3ZIRIZm1NP+sj7tZIJgOcHYiHT/gw3vlTRp4K
         Y6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849702; x=1713454502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqPnTCe0Xo6bQ7p9WTFouXnMftwoUpbMZgUNJItMSNs=;
        b=b8ywP50BCXHbmHgNq95s18yZeGZUnx9x0bSZ5J+hgaUQhAYalS5a+TSaHgX1RJD6t1
         NyEidiXkCHjjmCvpVqcZOmBX1HU1SRdezBuhd6flepKY7oImcZa1efIsZqG/JQCLtJmZ
         WYlklBU0tRlHju2EY5GQYJa/gMgI0Q2ai29WwMsx/5HiFhX9vStQ7+C7nqiy850m6P0Q
         reuwyytSnMjL/y+V3tjbOun3If2nmeeB90qEoFsFnknR9ZITTf6cmwEHC9D30bGIJudA
         SBKuD0evqRCSSCjCXStNobdiBwfih8IDz/DOvbwm5JVUxs97rXXCAwP+gKofJRT7n2zK
         oHgA==
X-Gm-Message-State: AOJu0YyVs+aKW9GkJP3DabaxfXs24jqBgdPhpedNuYvKMHqxwPoBOuii
	7QkCb/ix3q7H6olmVIodqg6TliXJBNH3GP1ucPkJEt/hQnpUTZ1sfsr7Pa9YV8PvlmUbGJ+eNBi
	p
X-Google-Smtp-Source: AGHT+IHcHpCnkfouvQ+2eaba/3il0CKvczkXy6Y3eg5a+PlADnftdvwImG1sSqlYsqF2Tl3uLBXYQg==
X-Received: by 2002:a6b:c34e:0:b0:7d6:7b7c:8257 with SMTP id t75-20020a6bc34e000000b007d67b7c8257mr213529iof.0.1712849701999;
        Thu, 11 Apr 2024 08:35:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 119/437] drivers/auxdisplay: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:19 -0600
Message-ID: <20240411153126.16201-120-axboe@kernel.dk>
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
 drivers/auxdisplay/charlcd.c | 3 ++-
 drivers/auxdisplay/panel.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/auxdisplay/charlcd.c b/drivers/auxdisplay/charlcd.c
index 6d309e4971b6..b40af38d69b1 100644
--- a/drivers/auxdisplay/charlcd.c
+++ b/drivers/auxdisplay/charlcd.c
@@ -487,6 +487,7 @@ static ssize_t charlcd_write(struct file *file, const char __user *buf,
 
 	return tmp - buf;
 }
+FOPS_WRITE_ITER_HELPER(charlcd_write);
 
 static int charlcd_open(struct inode *inode, struct file *file)
 {
@@ -521,7 +522,7 @@ static int charlcd_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations charlcd_fops = {
-	.write   = charlcd_write,
+	.write_iter = charlcd_write_iter,
 	.open    = charlcd_open,
 	.release = charlcd_release,
 	.llseek  = no_llseek,
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 049ff443e790..0e5d8d09b60f 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1045,6 +1045,7 @@ static ssize_t keypad_read(struct file *file,
 
 	return tmp - buf;
 }
+FOPS_READ_ITER_HELPER(keypad_read);
 
 static int keypad_open(struct inode *inode, struct file *file)
 {
@@ -1072,7 +1073,7 @@ static int keypad_release(struct inode *inode, struct file *file)
 }
 
 static const struct file_operations keypad_fops = {
-	.read    = keypad_read,		/* read */
+	.read_iter = keypad_read_iter,	/* read */
 	.open    = keypad_open,		/* open */
 	.release = keypad_release,	/* close */
 	.llseek  = default_llseek,
-- 
2.43.0


