Return-Path: <linux-kernel+bounces-141048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5368A1A42
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A2F8B2DD62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0941CFD39;
	Thu, 11 Apr 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l6fcmBw4"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641A01CFD1C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849958; cv=none; b=r3GQIssCcuWKtG/kbut1U4V/9LmTitDmBr4FbaqotsoCwUDHf0trHYEh3UUSqNtZ3BFN36aGSvaHGdTHgf2mN65gxNZB2BZje72KoRzV/00WdggYQGHFgwS+zyrWUoNmvoOPTS1jj0DRsAv6ypjCFe8pIx1GjNm1xxbEiHQLRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849958; c=relaxed/simple;
	bh=lz0rOiedaWxp+pS40Kc92MD0eOVvy2p5WRBw8pg/VqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+hNG1bu+vLtNvZfn5my2CxpQinEc8nQLeC8y60XRnITZkNS00ziWc2xI6LdSx/lapDEtpb4gTkMxzMn60bdwZxRBS70W9YkM8PFKNFIp7Y8oydJ1eyHA7HBYEZa4QDS6kcyownZ9NMISk0VH/Zy8EDdZJ6HxEKiz4+bF6iXWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l6fcmBw4; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170574039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849956; x=1713454756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub05T/jdp78Vmeoz4SlijoCMJBTdavqApNfMHzHgYRw=;
        b=l6fcmBw43na1wTWjoUgGQP9pO9zjDZ6fgNmX79oLrN4NAu4ACMfOn4J00LD3mzAbU1
         /NmvIbfLvVZ0igF6/mPZPI+5EYGH5AWNqEW+MNLqof2E8OCGglZb8YSwUb2Msl9V7bFf
         bybVB+0xbTIohjRaR7CHRBfWcVVyDo93yuRJMVqh21kP+lh69zHtoPpWCKVTnCt/ttS0
         T5RSnbUhUTOTm91aDHmH2dYxg5D4RvmpB4kk2Bo4Z+gjuyK2agdYqRB9tfI82+md/Bvi
         t6q0eGYchMnsN4d5kFFdSvOlX2IM9wMadT8g89HNoLfAb8N1tPjyEfoSqv4SkPpJi7IU
         T9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849956; x=1713454756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub05T/jdp78Vmeoz4SlijoCMJBTdavqApNfMHzHgYRw=;
        b=C5teWNB1e85cYj2PGeQPxn6lwzfKSWkxXZzB3oQFUNYJnfWH32ENsahaKQzeRT2Ert
         jT3z2Ihe8kpxaMha0AmVgfJHWPLPW1wyZpvGgDBVp+01oWsuEc7SZm9Yit0ijSVjw6TZ
         aRIultX0bQ8KeBorf0eFyUGdWp0axi1Je9Xb15P+6TJxkGu3inQqwMpEvg599Lo6zEbP
         a1eJGmQOoO27SBbvo1ZgXV0RLAuHW2IMy8uGqumOVnxj9UGa7fBHU9iSAFa+SnNbLmYv
         d2ysiJXg2YhAxWAN/t2oAxfpmAxjzujGk7PnN+W5TsV+tKPT9dI4z+fYpcszDPA/etbG
         z4jw==
X-Gm-Message-State: AOJu0YydXwMm2nFbpiog0ZLDs401nrCNb7QVT40Em+ENA2v5eHpvVU3R
	PVAM+xjSRPo1B7os977ngLNMjFMsuAmt+rBKFEZE3aURU76q4YP6ai9zikhDPixOeaFvj15lkRV
	X
X-Google-Smtp-Source: AGHT+IHHztP40vc+223DwzjfTKflzZtg7zX7jwhpbjEd3mzgNVprpjE3b/tOu21UjmrU+7iYYwhMGA==
X-Received: by 2002:a6b:5b10:0:b0:7d0:bd2b:43ba with SMTP id v16-20020a6b5b10000000b007d0bd2b43bamr229809ioh.0.1712849955896;
        Thu, 11 Apr 2024 08:39:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 274/437] watchdog: riowd: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:54 -0600
Message-ID: <20240411153126.16201-275-axboe@kernel.dk>
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
 drivers/watchdog/riowd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index b293792a292a..d9a85b4c1de2 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -145,10 +145,10 @@ static long riowd_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	return 0;
 }
 
-static ssize_t riowd_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t riowd_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct riowd *p = riowd_device;
+	size_t count = iov_iter_count(from);
 
 	if (count) {
 		riowd_writereg(p, riowd_timeout, WDTO_INDEX);
@@ -164,7 +164,7 @@ static const struct file_operations riowd_fops = {
 	.unlocked_ioctl =	riowd_ioctl,
 	.compat_ioctl	=	compat_ptr_ioctl,
 	.open =			riowd_open,
-	.write =		riowd_write,
+	.write_iter =		riowd_write,
 	.release =		riowd_release,
 };
 
-- 
2.43.0


