Return-Path: <linux-kernel+bounces-141041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961C18A1A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87A51C22653
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E561CEBE7;
	Thu, 11 Apr 2024 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AJXzLw4/"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F91CE14F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849947; cv=none; b=Gs/KT2BCPNl8hW1XQx+qULSNLHr5ptRbMUmg7bluyqmXhprKJPziZl6NEH6yULw5uXvLoduLRh3vXPCS34esp5mrS5OGPfcAmIvet/GPMJ0M81I0Am7nrhSf3ugMNQzQypJB/sXWtLyoVh03cuegi/FZMJgYrxED+zoELO+V37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849947; c=relaxed/simple;
	bh=h05w1fIvvQ/GeEEHj7/5r7NdU+VBB3mOK+XJzBiSv1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d03Ga7//sXvr3gh12DOD4vtWxv2oyUeDygX5nNIhmtiYHOD7LU38Dh2qemMDUYO46MR4EoULJwUqRWQwxzdZT9Fc7+rPU3w+IM/qFME2U1rd/dxCmgPdYiWKeSNVeqpHGbK8DLC5cYX3QRMXz3yLwbsAbJ+nz/YVWvHxt7iLAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AJXzLw4/; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36a224d7414so188735ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849945; x=1713454745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbF3UXpuNXnX+RWcPteWXT9lUZLHHoAbQrgAhbldMKM=;
        b=AJXzLw4/yyPKkF4bAQtuB6J5YKMWSV42JJMd6BUn+YsCHNOfTD6RpXbxBrmB9a25pG
         8GfBfc0/1iTQNPwCE82vFTQdMHZMxUOM9wJv6kF2MCj6ejc+p9EBscZ7eShVlKLn+AdZ
         9pgRRln9W5tJCYcGsy/fQZQ7ImI6FUHWv+d5jCLakrh+H0kZ1xd2rVWqOxy+P9QH2RMa
         ZtwjhTulHeODfAUkJdWR3uHm2Xs0Yo7QXclio2FzLfTCsT/GhkNxaYLgVuSe1t/JdnQM
         fMOhYW8Mv4XguX1vLj+s89h6MZMBYlW9yt7+1aTkAV3Ti+2XMj80bhogjfkb8PK1UaLF
         Qw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849945; x=1713454745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbF3UXpuNXnX+RWcPteWXT9lUZLHHoAbQrgAhbldMKM=;
        b=wL5dmwphtrtixatZ8344dpxBr95JUHauTmk8z5c98YzxpCbo1+8IF2+s9uOo6OxxPl
         ZXgtqUamgNomTpJDITSaBYp4NtEbUfxlLqurDr+QCi9h5DL2x9sCzjHRNE8RcW+w09Rj
         /s0vV6hmCpvq9/XbNhkXSqTcnSwW0W3vECMgvi1fycHLAwQ/RYu5ttxMBRbeRWkgV6Ab
         tctxV/ElTL1vHVvO+VzlsJ6XiwqoIFqKGub2N9dK4GHGlbMKc6KJJB0FVaqBuLetIr35
         r7lOJOeHdd7Sk25Ok3Yxtci30KvkNe/jK4C/Dfkvsjfxxx4wELFjRy57Clkt+iGYt21l
         syaw==
X-Gm-Message-State: AOJu0Yw4E6fsQhRWWE03pRoJA/fPtRYaQKPtRjDQ6OWw8cl2dWwJmue3
	Il9Cb4GQx3G/sAL9PIm7/pZL7H+0mdteWdDtNjIsHT1TC6SDmaQ0d9Wrlmo+8ing46YEibGbrVw
	N
X-Google-Smtp-Source: AGHT+IFk4CQ80j/TNHVe/xNKfOPLRdzp8/k+5dSMnIN2J1B6bRGjgxJE6OmhCi1Wg0FAAy6TiAUhlA==
X-Received: by 2002:a05:6e02:1d99:b0:36a:38bf:5fb2 with SMTP id h25-20020a056e021d9900b0036a38bf5fb2mr7484896ila.2.1712849945541;
        Thu, 11 Apr 2024 08:39:05 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 267/437] watchdog: indydog: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:47 -0600
Message-ID: <20240411153126.16201-268-axboe@kernel.dk>
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
 drivers/watchdog/indydog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 9857bb74a723..967a95a886a4 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -86,9 +86,9 @@ static int indydog_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t indydog_write(struct file *file, const char *data,
-						size_t len, loff_t *ppos)
+static ssize_t indydog_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t len = iov_iter_count(from);
 	/* Refresh the timer. */
 	if (len)
 		indydog_ping();
@@ -150,7 +150,7 @@ static int indydog_notify_sys(struct notifier_block *this,
 static const struct file_operations indydog_fops = {
 	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
-	.write		= indydog_write,
+	.write_iter	= indydog_write,
 	.unlocked_ioctl	= indydog_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= indydog_open,
-- 
2.43.0


