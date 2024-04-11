Return-Path: <linux-kernel+bounces-140869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16E88A194A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128211C20FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFBA14F13A;
	Thu, 11 Apr 2024 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q9jUByJA"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2214F10D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849684; cv=none; b=fbVzp80c6X8CxuHW5VWLdxMe2YRsYUz08sIHyfNxDjf91qqBZL9M4IIRCpf6Xso0701e1IDqGxwVf9naNY2aMzC4BqFS1SVF+08Xzm9BZ2hEh/2Ynq3UYSNczbaUb+pdo2+6wfia2oALoBwCC3LUjFR5UppXr9nHErne4LXwQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849684; c=relaxed/simple;
	bh=/V2nDSGA2WJ8j0aJzxxZ7WU80ll3brlP0dqm97rRTxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISwcfD+WJz38tvKmDPaY7HgcKjswA6mUvbtBMELI5Fg5rRmtRu26PXbZeMEAdKmunjeGcTCI+5Z4oAdD3OAUbDhpGbO69OHrplUnGUaFgItxcFrKLW2rSFWSxmynwCYX8shxWKcK8LsB7R52Bn+v/hWH64aKcdWCWd0afU8Wfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q9jUByJA; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7cc0e831e11so170483639f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849681; x=1713454481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kh1ucZljRBsvFGWd0sOkihqQbHDmkAAiC0gmdJ8NTkA=;
        b=q9jUByJAsV78D+4DJcbTQRI+oFfsiRbA2r5JSqhZ+EYVsd/qSe6+TtafZV1rajxn/V
         9vmz6dw10MtP97nsDGsUoDoO0x3WQrlofttUjuzz7QWrBKqvvtwrxjgHYikFEh0LVw1Y
         Gad5tYpaGsYmv3uipIHowk4Od8KcuLZzQXN4LkpJB6qHYYzn23DV99Iu/rxSZ6p4gafX
         4MgsXf0fIYpg9yY75kSFkqANmCYVPX5gghp7Q9J0g6SeI43c63e7RwUOLW68VNUqD7m8
         D4Xj3byplZf5Ojto5gHn/9uC3NnyDz/PQUGO20YVjoFYewx5soc4gXHVeyd8/LSJbPyc
         Vtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849681; x=1713454481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kh1ucZljRBsvFGWd0sOkihqQbHDmkAAiC0gmdJ8NTkA=;
        b=UFmdLr6PbdTNv9iwClAZamU9D9opw8shPD8msV6xY2VyBTxY4ti/Hi3pvM8M8y4qPq
         CJGIG1sch+TCk7dz36j3tGgn5WvebVzhWadoHAsSIfKttQnQxgq0FpD/UVcurwQA6BDB
         Zft6xlXW2NIKPKSZdb8mPnJs2GOgUgU6FEsgayeXAHqy5b3BasUhLHIXYCu5cFdb00vW
         3dUDBCWtgag39+usUTIoJwXcKGw4OLYc+f++e0PtvFv00hWiJP2aOiUHyuuf4aiCvi8P
         PgTRys+5urX6tdrnUPkbqgnuU48P7UCSYj1Ptu4OH9NbPyZvook4GPIDj0O7/rh8AwjE
         WFRQ==
X-Gm-Message-State: AOJu0YwL8JYd+T9hpC+Nc1yBDF2U0XeSFnBYfD35+FS6z79xHccyIZhL
	xbOjQR1hNADFO2W6e/5v8kB5BPPoY8xhXdC5pQ791z66J8C/G9njFnwFa8kjt1fC3JwVcal23pA
	P
X-Google-Smtp-Source: AGHT+IHKRJzVb/E63cNfhPXysdLBm0GQJMZ0fxu/1JRstY55LUiAf+g7OGQZ3MTvalu/7S88ruQVtg==
X-Received: by 2002:a92:2912:0:b0:36a:f9aa:5757 with SMTP id l18-20020a922912000000b0036af9aa5757mr3578867ilg.2.1712849681293;
        Thu, 11 Apr 2024 08:34:41 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:34:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 107/437] crypto: iaa: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:07 -0600
Message-ID: <20240411153126.16201-108-axboe@kernel.dk>
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
 drivers/crypto/intel/iaa/iaa_crypto_stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index c9f83af4b307..8ae1cf87ddca 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -238,7 +238,7 @@ static int wq_stats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations wq_stats_fops = {
 	.open = wq_stats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
-- 
2.43.0


