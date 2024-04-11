Return-Path: <linux-kernel+bounces-140793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26B8A18FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69AAA1C218E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F5A17BD8;
	Thu, 11 Apr 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lEyvn0b8"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5156B74
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849552; cv=none; b=Rws0jJYZXKPClEZdQxRekIJpckkJFXL9gFEtQPuuOq986yLvcNDblAjH3tfJZvtA7njdXFjS8PyH5FXHLkR+zRg5Fpc5TWVppSK8ifH1OOaDKum6FqCgBkgjq8JT977/D7NNh8KyNM6atLyhNOxjSbd7Hg25EEf5axiHVMpT04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849552; c=relaxed/simple;
	bh=6268x62L6WIdDjsTBaoEBBwaYe8Rr544YAr9jCnE47g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLMbe54pCD3jYHtTvcWQ84QLx5qMsuTAehnhw90urM5hTdUpbY86CGnc0fGtzVwnjXZUVCrYd/vQv7IWVJRyxzNW7LIy4ag8q/UoHLaHOBiCVwK4lU+QnaHvh0J0JmEjGEf8ZM67WpBW8R2eSp56loug/D0b4gRd33A247dibSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lEyvn0b8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180596539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849548; x=1713454348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taZOi4hUKpJxluTrTDLOaUbYF+g9d+ckZsstHCEwYpQ=;
        b=lEyvn0b8VZ19VjDdnZXBgvUNg2dtgubDOesi9Bvf1QdL10wCUnLHCvp1cuBXUVANaq
         VNpLeF++klo27WNt8JBkEfgmTj+XLVbojXAl8XT2HuVyHZpz5/fxYFvkbQVUzYxqTgFf
         4qq90shuGbtSj+IyOVhisTQ/3ein76xqHC3fxX9eFyKIlWuiAYlPp59IILQates3lpRx
         Xci05kwF/DPETbpM6IizhlVJ/APiej66n5E0PXxgLztgQOJb4Hdvi9EbsyLmpWpqXGpe
         BQIPE6Kbti2PmpBsqcXL62zbf5FUZ0tXzSWQByTaqX+e+rzOKVbPk8pdAyLUQKpPL9Y8
         qqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849548; x=1713454348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taZOi4hUKpJxluTrTDLOaUbYF+g9d+ckZsstHCEwYpQ=;
        b=NChjUrF2/PHUdIG26wppchyr9gTgHRXbksqCGRWEVmXqVepisMrBrGp6FAKf0IznYM
         8nLLvLm3Q6r91imejFSF4/mDh4Du+MFpCqjFD3WItsYyqGMRR4T3TX7VuNM50KrgHCH+
         HJ68og/1aowh3DGtDSNcYPnFsQXRaV/w/8flhZzFiMnTPzT6hA3cMNYrcNSwzI7qvIxs
         q6loZqpTVivSc2pPl6PhzI3mgym8t09nGMqfTi6GbFfQpUuVuB6IT9QFEWlOC9KyACFX
         bBromgT5IbUeASFCnkZ7VTmFc4uSCRJwmYF2ZwbK5C/4ck04lLEWksYOEQyp6BHtRjBJ
         +fUg==
X-Gm-Message-State: AOJu0YzVKUrgfUZoJqT0F3RPlGaY5vVmEBRSrop60f1pOtCDes6UpTLM
	d+X0lt6ZrJAHs/dDefaoTFCSY3iOWIvGaLxA72kqiacQ1E1qp81vsFsnA10Hs0OBI7m5R6sY+Xv
	y
X-Google-Smtp-Source: AGHT+IFl0Hhw4N4j0oLICJ0mLOjjE/VE0Nh2eKrmAyCDW0FxCUCkDQiXqxncyduY30jedob0Qi64Lg==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr174575iob.1.1712849548480;
        Thu, 11 Apr 2024 08:32:28 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 035/437] char/tlclk: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:12:55 -0600
Message-ID: <20240411153126.16201-36-axboe@kernel.dk>
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
 drivers/char/tlclk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tlclk.c b/drivers/char/tlclk.c
index 896a3550fba9..17a312cfe46a 100644
--- a/drivers/char/tlclk.c
+++ b/drivers/char/tlclk.c
@@ -240,9 +240,10 @@ static int tlclk_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
-		loff_t *f_pos)
+static ssize_t tlclk_read(struct kiocb *iocb, struct iov_iter *to)
 {
+	size_t count = iov_iter_count(to);
+
 	if (count < sizeof(struct tlclk_alarms))
 		return -EIO;
 	if (mutex_lock_interruptible(&tlclk_mutex))
@@ -250,7 +251,7 @@ static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
 
 
 	wait_event_interruptible(wq, got_event);
-	if (copy_to_user(buf, alarm_events, sizeof(struct tlclk_alarms))) {
+	if (!copy_to_iter_full(alarm_events, sizeof(struct tlclk_alarms), to)) {
 		mutex_unlock(&tlclk_mutex);
 		return -EFAULT;
 	}
@@ -263,7 +264,7 @@ static ssize_t tlclk_read(struct file *filp, char __user *buf, size_t count,
 }
 
 static const struct file_operations tlclk_fops = {
-	.read = tlclk_read,
+	.read_iter = tlclk_read,
 	.open = tlclk_open,
 	.release = tlclk_release,
 	.llseek = noop_llseek,
-- 
2.43.0


