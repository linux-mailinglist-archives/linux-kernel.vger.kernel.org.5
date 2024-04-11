Return-Path: <linux-kernel+bounces-141044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D68A1A32
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05301C22B12
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AF445C14;
	Thu, 11 Apr 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ykytTZEr"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFC51CEC0A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849952; cv=none; b=od27YtDq92KfRbKMvp/YoJ4ECLEib+8YXXXjPKkaIUzLNOHYsptawDGKp01VLSZ/b+6p60tlDfkY4FQUIBLgrWbv17LXNMtsjNVKE8DH1vFTWRGqKtFb37jBLpsV40wpvRmYOp2jPsQJs93oRkoCdGHTLg9M/YBJqkb4jsHkAu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849952; c=relaxed/simple;
	bh=5RokoYY97O92F3nBGNpj79AYkayDk+hD9WXYds/TkwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2MBAP0wT9jOjit0lHrCwdk8VxEKk17gdXWhQvmd22SJsgTq94Pueox6Gv1dum2QnVuwYDUQe63hcwGyUD+wlL/qs4IoOsi6kV8rN55/irHGsR2zjnSB65Ma3tAUra7U84c7VPY+4odcfRyz79B7i48nzY3+c71xQ9b1CkrEF9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ykytTZEr; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58154239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849948; x=1713454748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgRqu6yvlu9SBgogevmne3UKzxDxb2/oRz4MOUfYFjQ=;
        b=ykytTZErCQdf4IrjShyo4N4HbLe/GZpizxhN7jwcSmCG/sFZasPnCwjg9/Ai12lg8f
         LK2wnfv5PMbvfHjj6PvxoPDwB7vwfrOUAuoI2uyqMwQadjA2jdC5uZ/yV2QXA1hqsEKU
         vNmrT+UEZDIDUG2dPF75CIkwgm2vONZWugPrMhexKxjEWaZ4tyOQWc34fcPsA/p07+FE
         Fo1OIORGztVMehVMTSDXQPxZmiiiBoTiHF0WEpn4vqIVFdrwMRtlXX9Ld8SvXNezFZYr
         2MQgqyAxm/5YJDmoJIMmD6OEBJgsNczdhKIXpvsbqd5qVHHbGjjOHnkSReK8TJ7mysqb
         K1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849948; x=1713454748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgRqu6yvlu9SBgogevmne3UKzxDxb2/oRz4MOUfYFjQ=;
        b=MRfZeSyKnWHJR4LxcYqg/TDhA9dbfdzS6cq3nNqjfEtegQ+iMs4TdvKtN3tWPeOmam
         8Ij8RYFSBGets+hLtTnHdyVdZueeLyfmdyRafrd261Kslpn3Js7A/9APdOwH63XKFZCz
         pFu1Zb3upKxB25miaz3Pyrkxb+j7/cKTNyTZZUPulx06sjbRtTBA1yZ9dREdlZHyAjrO
         /dug9yWUp7r4YcFsBzeFDKfOMNDLt9oB2bPlMNe3cNjt/UpIchK2lguScfmMf/YXR2eg
         kOkd+kvdEMFd6vciyBvFyVxaoVB6Rlny/K3/pqtBSSZJzVAq8PoPUx6We4Hstk26dOhg
         806g==
X-Gm-Message-State: AOJu0YwzX+k/xDx7fxeOmA4F3+1rRVNft7qsJqZLHLBC+IZIxDLKbxug
	QVPxvc6NF6Gzl5peASBRthPpAaNukGn9zeYqy0sl5l+82QYCR78vKUW5jB/mq2QWbemt3MHFLAu
	e
X-Google-Smtp-Source: AGHT+IFxY6DuhZNb2Yvzn6ZfmJq29RiKLmpUXOLomlIbyp7EmkTNQWa0F194HE1QxoJTEy3c/ZfgwQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr194338iov.2.1712849947071;
        Thu, 11 Apr 2024 08:39:07 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 268/437] watchdog: m54xx_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:48 -0600
Message-ID: <20240411153126.16201-269-axboe@kernel.dk>
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
 drivers/watchdog/m54xx_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index 062ea3e6497e..1421e305ca12 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -87,9 +87,10 @@ static int m54xx_wdt_open(struct inode *inode, struct file *file)
 	return stream_open(inode, file);
 }
 
-static ssize_t m54xx_wdt_write(struct file *file, const char *data,
-						size_t len, loff_t *ppos)
+static ssize_t m54xx_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
+
 	if (len) {
 		if (!nowayout) {
 			size_t i;
@@ -99,7 +100,7 @@ static ssize_t m54xx_wdt_write(struct file *file, const char *data,
 			for (i = 0; i != len; i++) {
 				char c;
 
-				if (get_user(c, data + i))
+				if (get_iter(c, from))
 					return -EFAULT;
 				if (c == 'V')
 					set_bit(WDT_OK_TO_CLOSE, &wdt_status);
@@ -180,7 +181,7 @@ static int m54xx_wdt_release(struct inode *inode, struct file *file)
 static const struct file_operations m54xx_wdt_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= m54xx_wdt_write,
+	.write_iter	= m54xx_wdt_write,
 	.unlocked_ioctl	= m54xx_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= m54xx_wdt_open,
-- 
2.43.0


