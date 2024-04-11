Return-Path: <linux-kernel+bounces-141055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EDE8A1A41
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ABA1F22B23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C615533C;
	Thu, 11 Apr 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HTUh/qrv"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D975C1D0F1F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849969; cv=none; b=pCZz0rhMKlUgLSOVFGAyFbhgTvuiaRyzaWD01ZDB7yL3+fL+v9TUl06fTH4HnAKKfzAitRCWrGJkWVDiN6zACfqk6X3pY1y+OW1B5K0rnE/n7mRmg7+Db2FIYgBzuHyiN8BupjtBlZZJUteLkP5ElP0RVhxK9qFQ+AyVdE+co6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849969; c=relaxed/simple;
	bh=LvjgQGgL0Wz/MDWHW7PN3eTY0hDprMvFuMvVC4I1sGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZsPeygrfEL8XijBWeBpqDaYlWYQizN4U0TMz+hlZxg/1o3duYfK0O9QWcxVsagGS8rvtHKCF7ToN9eGMM+6+IEOGNUj+nMrvVmwOFWVTmiVp4h7VffTyvkTcdjzycYeS/mzZzngxVyT6Ipzb3QKOCg5bdYF7jw7uYBwNcbgCDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HTUh/qrv; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170579939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849967; x=1713454767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5mzaQmM9seghk8pfFNXBPZTgd7LDqNjJYdodgsGpAU=;
        b=HTUh/qrvAkRD7QRTxzz/S0gTx3eWIGoUQrqSuoVMJZlnzDa264jhgYX8wzJJOG33Wk
         l9vQpi9OKMDJOum3NOGj/t+fF0OyXWzh5U/M8U5unbK25H1pbsnmN+3ZYBsSurXiWPM8
         iTdWb3ItUD5YVDeCiHUjs95R+zKVPsEbJVtJ4n91Bx4k4eigY4hQN3yeAmpOt9aMmWC1
         yImrGr+fJkSiQE0eNFQvZbdE4yKWmH1NIXNy6wXx1CBvDTLrVrsMHbtZFu9qElpJulPE
         L7icwgibNCPF4iRdl8hNUKRG9XMjtc/XOsdNcpF9x4JJs1m9+MY08fIC87oIUBQctgHP
         r6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849967; x=1713454767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5mzaQmM9seghk8pfFNXBPZTgd7LDqNjJYdodgsGpAU=;
        b=WrAmpy1nJ0o3pbBhVOL3LFjcDPBhlauehh8O7c2nSIlq3Xl92JOyQyRT7YkqVSr0u6
         JdHFLOefYq0TIJ15QUIWpenSnh9pF+9aKxloBcb+YZSVHqjsDoThqnSTYPSyusVJ7dge
         hfEAYL5lQxZw9b7yZqN1XJJ0ydO5ZOpXlPflSvvXAuDTDl+SwGrPX7EyWgsKkSjon22D
         2tQhnPbjWVtoZ1bcnQ6TdNsHnr4OGDTJK22xmu57LDydq5+j/GHwSU+5reQ6yEl2CIKB
         7RxhtR2n0fGac/3YhFNWmwUK/nAYn9gCOuDnEjj+JvInyQs9qZ+sn7XE8vU0E0wwc1IW
         pgow==
X-Gm-Message-State: AOJu0YyLN9ct6/FpCOUoz0ZTJR3u/vilOYdpzEpBWiRgt9YbTj4diDQ0
	hme72V2zWFXtimJpc2seDx00FYjBuSFH9vtRmIAAsyKnZ99OofvoiCGmILWicLpFS0HEjmmxu6/
	M
X-Google-Smtp-Source: AGHT+IHc+e+Yl91tLQa26taE8mJivesenFYJc1bk1daajtTdP/TkXDV5gl8C2bBHDvHXpIyxGt86EA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr189480ioj.2.1712849966730;
        Thu, 11 Apr 2024 08:39:26 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 281/437] watchdog: wdt285: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:01 -0600
Message-ID: <20240411153126.16201-282-axboe@kernel.dk>
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
 drivers/watchdog/wdt285.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index 5b7be7a62d54..eee5aada2ddd 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -114,9 +114,10 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t watchdog_write(struct file *file, const char __user *data,
-			      size_t len, loff_t *ppos)
+static ssize_t watchdog_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	/*
 	 *	Refresh the timer.
 	 */
@@ -179,7 +180,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations watchdog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= watchdog_write,
+	.write_iter	= watchdog_write,
 	.unlocked_ioctl	= watchdog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= watchdog_open,
-- 
2.43.0


