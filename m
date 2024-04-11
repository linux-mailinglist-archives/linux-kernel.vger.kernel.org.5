Return-Path: <linux-kernel+bounces-140946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 442398A19C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27B21F22074
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C221018A;
	Thu, 11 Apr 2024 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="HOH0fRpl"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EFD20FAB0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849801; cv=none; b=hjuqdP+nIfipEo6WHw30oCaXS8yk1ESj9sF/SPpu1AdoVb0FiWa+3YA4mwCAG8vlilizzPUrB997hNm6SQj8iFF8Chmxk4tTqnMAoDKUxqTLwq+ur15qwDQ3txtyGu8ByWfrGAauUm3fL+X/tUjYwhWjnwuBxlLokYDMwZAHOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849801; c=relaxed/simple;
	bh=KOH87F7Hovfayly8ms8RyViBM54trilhav2y778SWxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANcg5Ng2ZIYstVcjZTE3+RTBsMPDgATMLxjDflo38eMJB9uKAeRYT60y/UXuitjwYS47CU+sX/YFaVq5p2T0R3av/UklYUdJHf1nBk51qk6bScPnRLiPgX8AhUEFj+alQH5ewd+R87OLH/NC7Jmu1vhxoZFHAQdRSfT9QBwnk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=HOH0fRpl; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a224d7414so184095ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849799; x=1713454599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwRCF1nnEbSrjuWDtl4ruNj2l8f6lTNKa8/0YdrjcDA=;
        b=HOH0fRpl7rALyWfCED1/Qh0QieXTzdLPREo4fqBKHAvMO8f+V86XzKXc4m2/nS8kKo
         WSW/0t5IqQdaHDHPKxRLxVXzK9t4FNJMyMnTIAdO7T+FYGXQ94F1hcF8kFMHIEy+rGaL
         cPkfYsrndDnsH/8YWlHhy6bINQCOAu4j/TXcFaZxj6jLxC0nw79x9BTtdY5hMGVLUX9a
         ec1F+OIYGQjzvc/KnAHpgRurdbK+HukMIYwYCw5o1OENsX7d3F0OTWdx/GpdLaAWRKnT
         m8RjMm4F7Vsnn7+P5gaoS9RN9+fGDLcsUL3Vvewez55NzauMkIPlZhRXGPmfJJMWzJND
         94dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849799; x=1713454599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwRCF1nnEbSrjuWDtl4ruNj2l8f6lTNKa8/0YdrjcDA=;
        b=bt8FhDlQjaBknEfDkSHbYIqygK59U3NXsA8nNUTzpiFeyA0jgjkXKuvv09Vg8Di4kt
         B+3gVmQ6CfwTAoskmcuzOw6HBoV+DWw8ZbIN0kbnHXVddvYKge4Y6psziFPcbo8Sbl4q
         osy6Wx2iBXg1qqIfSHuKiv1GtT8G3De8iiPf4MxmwIhbjwGPKFVfp7k+YMMK0nH1fqnE
         0vCFtEAlq/xwh3GM3tQFWSZ95qlv99UVVIbvtFXQl+3ffZpaJUUig0UVrN1SiTlRPEtI
         DV06EZngpvvtDjNVpNJD5YvPixqM2m9dyJ5uW3Oll0A0fkSkZmXIcf9pLTPOh+ZAJldO
         NhHw==
X-Gm-Message-State: AOJu0YyozeNLUh2bJ91pDuBZw3J163E6eiC80kps17k37K+MXto0NpC9
	QF1Y1vKf2ygOGvPZQy6xoNrCK1rWZPyPNy4SSLOLxRpvZQVE0hVAMj1oRp+J1GPdaiL7YrY7qZ6
	9
X-Google-Smtp-Source: AGHT+IGHpjcd7IwU6M93tHoNcco7LOUxBXMjppSo0GW9P0W7q0ePB1Ps3ef/woGHVOoSFT+OYl3uhg==
X-Received: by 2002:a6b:4e14:0:b0:7d6:631d:7b0 with SMTP id c20-20020a6b4e14000000b007d6631d07b0mr188247iob.1.1712849798978;
        Thu, 11 Apr 2024 08:36:38 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:36:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 177/437] soc: mediatek: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:15:17 -0600
Message-ID: <20240411153126.16201-178-axboe@kernel.dk>
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
 drivers/soc/mediatek/mtk-svs.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index c832f5c670bc..49e687a96aa0 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -149,7 +149,7 @@ static DEFINE_SPINLOCK(svs_lock);
 	static const struct file_operations svs_##name##_debug_fops = {	\
 		.owner = THIS_MODULE,					\
 		.open = svs_##name##_debug_open,			\
-		.read = seq_read,					\
+		.read_iter = seq_read_iter,				\
 		.llseek = seq_lseek,					\
 		.release = single_release,				\
 	}
@@ -164,8 +164,8 @@ static DEFINE_SPINLOCK(svs_lock);
 	static const struct file_operations svs_##name##_debug_fops = {	\
 		.owner = THIS_MODULE,					\
 		.open = svs_##name##_debug_open,			\
-		.read = seq_read,					\
-		.write = svs_##name##_debug_write,			\
+		.read_iter = seq_read_iter,				\
+		.write_iter = svs_##name##_debug_write,			\
 		.llseek = seq_lseek,					\
 		.release = single_release,				\
 	}
@@ -782,19 +782,18 @@ static int svs_enable_debug_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static ssize_t svs_enable_debug_write(struct file *filp,
-				      const char __user *buffer,
-				      size_t count, loff_t *pos)
+static ssize_t svs_enable_debug_write(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct svs_bank *svsb = file_inode(filp)->i_private;
+	struct svs_bank *svsb = file_inode(iocb->ki_filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
+	size_t count = iov_iter_count(from);
 	int enabled, ret;
 	char *buf = NULL;
 
 	if (count >= PAGE_SIZE)
 		return -EINVAL;
 
-	buf = (char *)memdup_user_nul(buffer, count);
+	buf = iterdup_nul(from, count);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-- 
2.43.0


