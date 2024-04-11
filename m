Return-Path: <linux-kernel+bounces-141135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DB98A1AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35E81C239CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F259167A5D;
	Thu, 11 Apr 2024 15:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cCH3HmXs"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EB6167A55
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850099; cv=none; b=Ho9S2FSr2Mr1Tz+KStc2Gl4GBQBkwjrzBkalLVTkLK/d2LChAT740A1MGHkWeYY75VXez7viyJrdgO+ElcHdvbVEr33LG4Upv6/MNNm12nh4fTyFovYgw/SXavmtt72zGz3CafBd9BFiYwWvDi5zF5AUfbvAQytW36U59Mveuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850099; c=relaxed/simple;
	bh=g+zwEFWI8VvsoSwOW1FTDAA15YfoeDjQvAm+jbBBB50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhAJKaKhn94jMu3K78sh1jHOFfYGtsi93Y42bFFvGNhHhqU6mQYMUrGl3BSPiVOlRPLLYzNS9uVVYNEv4NXGLuXB2p8TYageSfu9tQg6w8HtdYMCtTrZp1tG5+axwqonJ1jwYvPZsLL8vH1q4MgOsPIcODp6YHJNMXtrZHAaBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cCH3HmXs; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16252439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850097; x=1713454897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Llyi1IogZE1nUb7GHT6MuAncAwq5FXJrNFNMt9VY/9U=;
        b=cCH3HmXss12X+5z90iWJQZCqbQJIF0G8fiEML4+34ZgdXkT5eoUHMt8xr2CBleRWxz
         xvZm6qcP6CqChN1CiSEuPFLDEYKAet//jiyVJguCFtofdeWY81CRm3BZhMiHK5zDhvwo
         sVAWneC2sX5Tx4QFOKLTjR9MpDVaX6nAkXpx5bPzyCcC8AnBb12/Pc2oRkbUPRO3FKcI
         nNW0sWyUt06PMaLUXOvpSvgysrVwi1f/n9Ui8YtE7EqwKEIHOiPc20n4lRN7SPbDk5kL
         m2SUES841EDNk/0zPchlIkbaYqFGtgS9eCreKsDUpTb5BpPji7EkFvlDP/zfoIxaEC5T
         VdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850097; x=1713454897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Llyi1IogZE1nUb7GHT6MuAncAwq5FXJrNFNMt9VY/9U=;
        b=m57farIKWul6cqQizEozG2W9WM03SLcyBYiB+AG1FcUOwCc1Bx+tqQNRFKn1u2AcWw
         zlkt9LDIK6TCj3YBtXE8pGxtQWgHWQGOL6b5G7JUoVNgisiE6YiIPiMX6ByJby1xrpPd
         5FhfaXn4MqA6yI2E+CXZ8DIt9nQkCSZLYwPMvS7eKARhMMIFhwImezlXq4z9G5+ECSQW
         QrkFEIj9TbCkHI2ySWQTY/Qd+d3RktBIXuKo+Ra898nEMb1jK5yhtqiklhoJzh2J7GkK
         1PFCa6d6KfxLHpyQxQ1IoiyP2iMDVkceE6+iwCV45j1CGU7a96zAm6MfT+fSyvM8fQUR
         elJA==
X-Gm-Message-State: AOJu0YweB0FDv0Jhy0syQS+yy0ITMS6UocAtPO63SH2GVkFRBoYxH1U5
	1usAcfwzmVxUQ1XnFr8KMvDV2wNyfsXkzi6m0ngfieDJ8yh6OjYcUMCatY5GQ8MsQ7IiL+LGpj6
	4
X-Google-Smtp-Source: AGHT+IGsrgKlOcRW6JLDKSDUd7s4tPQ88iiCTlC9fABCJbV1e1lJBPo+GL//qM2yk9yOO95wNQQ5HA==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr201911iov.2.1712850097234;
        Thu, 11 Apr 2024 08:41:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:41:35 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 356/437] arch/sparc: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:18:16 -0600
Message-ID: <20240411153126.16201-357-axboe@kernel.dk>
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
 arch/sparc/kernel/mdesc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 30f171b7b00c..bcc3afbc8760 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -1261,24 +1261,24 @@ static int mdesc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t mdesc_read(struct file *file, char __user *buf,
-			  size_t len, loff_t *offp)
+static ssize_t mdesc_read(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct mdesc_handle *hp = file->private_data;
+	struct mdesc_handle *hp = iocb->ki_filp->private_data;
+	size_t len = iov_iter_count(to);
 	unsigned char *mdesc;
 	int bytes_left, count = len;
 
-	if (*offp >= hp->handle_size)
+	if (iocb->ki_pos >= hp->handle_size)
 		return 0;
 
-	bytes_left = hp->handle_size - *offp;
+	bytes_left = hp->handle_size - iocb->ki_pos;
 	if (count > bytes_left)
 		count = bytes_left;
 
 	mdesc = (unsigned char *)&hp->mdesc;
-	mdesc += *offp;
-	if (!copy_to_user(buf, mdesc, count)) {
-		*offp += count;
+	mdesc += iocb->ki_pos;
+	if (!copy_to_iter_full(mdesc, count, to)) {
+		iocb->ki_pos += count;
 		return count;
 	} else {
 		return -EFAULT;
@@ -1303,7 +1303,7 @@ static int mdesc_close(struct inode *inode, struct file *file)
 
 static const struct file_operations mdesc_fops = {
 	.open    = mdesc_open,
-	.read	 = mdesc_read,
+	.read_iter	 = mdesc_read,
 	.llseek  = mdesc_llseek,
 	.release = mdesc_close,
 	.owner	 = THIS_MODULE,
-- 
2.43.0


