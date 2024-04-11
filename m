Return-Path: <linux-kernel+bounces-141043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A78A1A31
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 775DE283205
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A66C1CEC1B;
	Thu, 11 Apr 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O5kkwLrA"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557DF1CEBE4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849951; cv=none; b=a/cqu7vLxbM0+YRDzkuh6GuKxIBgRY2wJFT8LhwQHUSLM7ijrqdNKIjM+ebRcNwDRYTjp49+P/PFgFwr4S5p6+X1nOOFIPYq+VhwfAnlQOPkBlfdMXrzd/LLD89TsulqwIZVg+tNxpCCWyvezHdO84adbWUyoVTPoWisJgP4Zy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849951; c=relaxed/simple;
	bh=X6nzda4eNRoIOHJaJaQB1VJEo53IsCvtdTl+QikkZdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTaeuj8bihLggiuCAdSs8TGGWHRER4jxhvQ6f0hmH55DQGTuhd20kCztgs9PNfvxGHFRryIidBmVf4tiUQ7i84NxykGA5f58ECtfC/Hb2p/Mo/kGFrYsA+UBp3vrN0GnUt/zA8fGMvUQDNp/Fcujz4l64uVfqajuXcVvbS+xlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O5kkwLrA; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170571539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849948; x=1713454748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmEx9YmC+id1TZPj4p7DnNRAPC699v0oUB7DGNRCskA=;
        b=O5kkwLrA15lnRv/g9lRYbJD5pSCcEyOJ+CpxEW44wbiLtXRfBoLeUwLnP0cZVddYad
         rEpM49Tvngi5//98JfU9cjq82AYkZNbNxCmEfiGgPHVBVQ8+i7YrckpCPEMJwIva30pG
         JupnD4ePrb6WMI1rixTKbvnIeS/1P0LjmrmQNW9AE0WhinvzzdszrwuIHLNxlCatbM/x
         /DKD+ENycLf8BCEBlpkmEKlTQajt5frGYXgqEEKkE8nKqG7tGo+Cz9laD23xa8JnSrAa
         6GH1DwXanPbbrXumFU+lrPdukYllPTMgSodWd6jw6BVVVnmdUErBFFn03G4yerjTS047
         dzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849948; x=1713454748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmEx9YmC+id1TZPj4p7DnNRAPC699v0oUB7DGNRCskA=;
        b=enMio4k+CIbB53kA21v7Xyn0bEDfRCAeWQGPGnxylfZB0x9TMb6GOyOWYCIFnTK9fY
         HvQUDIf0Wjckqz3EF5QUN80AP0s5/k3GlJyVvtRTfdob32eV9GnFJzPdJVSSdJ6WW+QT
         6cULWrirEF0vXXpjlhLvdVfcy2byGj9T1MT3PjY5P4mTLXE6NJZ1H59S2tfbY/JKdZYQ
         lrjq6FWHvZ/o4omm+np2KK6aQdup5Vmp2FawGCxoExEqXokvaX8ZsE3zYmGOs7wdFbZJ
         qTeDqe0JxroOsBBWK/CtAseQtkmpDDCD729qmu9ZLJ+39xUCi3QTRvVlbnlp7kAzO6b3
         QoBA==
X-Gm-Message-State: AOJu0YxHUx00KZwfcOTx9DEJe6B/3toSsw8tTWIvKG2TipiYl9IYi0IT
	8qORqFyORpm+CuKgoH+HGY03YkaVwU7aKS8l2wYagtPn8Ua3L5DO1KAuYqy3I4X8iJIgDZ4NGVd
	9
X-Google-Smtp-Source: AGHT+IHz+2RSJBbM/HwLPknABONCodw6JwzOq1bMFJzvsGerMZg3xAP+BnP3118pOgNPOtzqqz7n6A==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr188842ioj.2.1712849948652;
        Thu, 11 Apr 2024 08:39:08 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 270/437] watchdog: mtx-1_wdt: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:16:50 -0600
Message-ID: <20240411153126.16201-271-axboe@kernel.dk>
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
 drivers/watchdog/mtx-1_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 152e41ecbb14..1d7f5154c144 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -166,9 +166,9 @@ static long mtx1_wdt_ioctl(struct file *file, unsigned int cmd,
 }
 
 
-static ssize_t mtx1_wdt_write(struct file *file, const char *buf,
-						size_t count, loff_t *ppos)
+static ssize_t mtx1_wdt_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	size_t count = iov_iter_count(from);
 	if (!count)
 		return -EIO;
 	mtx1_wdt_reset();
@@ -181,7 +181,7 @@ static const struct file_operations mtx1_wdt_fops = {
 	.unlocked_ioctl	= mtx1_wdt_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.open		= mtx1_wdt_open,
-	.write		= mtx1_wdt_write,
+	.write_iter	= mtx1_wdt_write,
 	.release	= mtx1_wdt_release,
 };
 
-- 
2.43.0


