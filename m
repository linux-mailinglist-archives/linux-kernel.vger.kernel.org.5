Return-Path: <linux-kernel+bounces-141015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5EC8A1A19
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B526E1F21BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C31C65F1;
	Thu, 11 Apr 2024 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="C9HpiM9R"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF917D02E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849906; cv=none; b=VxVzesLS85FZQ9s1+o7pf8UNAb4TJg9a/c8Z8x6k+wwcGaUy69DszlvqZaCCb/bkM/xu1S4oV5TSRb+6/zOm3XQ2kvMqFliM1eV99SIzAICjNi8O/3rDOku9Q9hAD3e5rE6ezkSvfW9zH45Jwe5R70jrp0BAHNVLG9rFZ6wadCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849906; c=relaxed/simple;
	bh=N4nExDWA7OmsTzkEctqwF2b4RV4IXx38lL/NmgBXH/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXQXXLdPJfNwh8gERWdnIQ5ZHHIjEEac3jLDkb2epQhc7629SaiLc3Lg+YHdOfLxqKU8F/hRWugVzLhq40KUn0DFJuOP43b3GCieJJQjQMaRiDjgo2bmOmUqQtgf6qAdZ1MFWqE28FBcKQjRqkP2pMH151O323pVbT75E/z1i7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=C9HpiM9R; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16196339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849903; x=1713454703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuUzYYjLzz4CaZgUUCfgVZo9cOAScMQAGckrv6qJaRc=;
        b=C9HpiM9RVc1Oz/vSYIUaZ6/kQceRidt0B1ke/2Cx+7Esi7KVGD7DmEspEvCnPLmxGy
         dWATAcyGlEFjYXTVj8qMyEaTX7wRn43FHNwqfi/+IOtwCMCvrOyqRA7Zcl5i+p9pF+vR
         QcGkZffCRzlFhQy3aGYY67xLsEl98q5RZK+5mxrXKC1IAECSSrs2vGFP11Qo8sxTvHJG
         CntsrsWjsEoOJJHshpcv+xhy7adyN3HI+xh4T9EpWg/2UsSjA+wF5Pr8GNMhuw74uMB/
         ag/VIh80OD9Rzh8x1AWf+VOFfd5GyUuXDaZO94UQBDB5XA38wQw+bqIbHDhYmG77MSSz
         wZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849903; x=1713454703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KuUzYYjLzz4CaZgUUCfgVZo9cOAScMQAGckrv6qJaRc=;
        b=KjDYDEPjp1ZrcOiC6jl1s+bPYsOxRJ9nHnZOjyIHrwQFANPb7m0p9pyQ8KajCz2yzz
         4gPKbJnCRSIBQ8QrXEXWGa1oNZIAwr3JEEfrml4iHJHLoFmR5xcJncKMBZjns5yAQX9z
         RTDRw1S5NXgs6oNX25Xq4rrL6iO5vhX0miuKaJKjCQmOnpVo8KGE5AvkteQPOt03R/qi
         oQMtinuTBBTD8sXCrqBKaNNmztwTMzjScVNFE5uE0gAqNEK4P29AuGezpydTmwHkqor/
         LgRds6hwYXpK6FtScdraqRFKUhh9AJERJ1X026sl6Xm1zxMPanjq8N93ncnJIdlUlNeP
         xMUg==
X-Gm-Message-State: AOJu0YwX+KpPJ5H5IvwBDKeVDtJeI72kighetSXAaAsTMXiNriT0ocdT
	LFcYVmGigrsYbOKKtV8knGC8cD0nDtuh+CREyBSrEpqCZoHCOqqoUoLGet9EJRaISMhO0NqnOG+
	L
X-Google-Smtp-Source: AGHT+IHTpawGEPV0gQ3wIVBu/3Mu7Yg9/nvQWbK3jXBoAd38lfG/nreJRNcDYM8bsAIU7XoCZROtZQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr191847iov.2.1712849903603;
        Thu, 11 Apr 2024 08:38:23 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 242/437] watchdog: ibmasr: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:22 -0600
Message-ID: <20240411153126.16201-243-axboe@kernel.dk>
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
 drivers/watchdog/ibmasr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index 6955c693b5fd..6f0931f33a6d 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -243,9 +243,9 @@ static int __init asr_get_base_address(void)
 }
 
 
-static ssize_t asr_write(struct file *file, const char __user *buf,
-			 size_t count, loff_t *ppos)
+static ssize_t asr_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (count) {
 		if (!nowayout) {
 			size_t i;
@@ -255,7 +255,7 @@ static ssize_t asr_write(struct file *file, const char __user *buf,
 
 			for (i = 0; i != count; i++) {
 				char c;
-				if (get_user(c, buf + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					asr_expect_close = 42;
@@ -341,7 +341,7 @@ static int asr_release(struct inode *inode, struct file *file)
 static const struct file_operations asr_fops = {
 	.owner =		THIS_MODULE,
 	.llseek =		no_llseek,
-	.write =		asr_write,
+	.write_iter =		asr_write,
 	.unlocked_ioctl =	asr_ioctl,
 	.compat_ioctl =		compat_ptr_ioctl,
 	.open =			asr_open,
-- 
2.43.0


