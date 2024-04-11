Return-Path: <linux-kernel+bounces-141062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25E68A1A49
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B45D1F252D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411601756A;
	Thu, 11 Apr 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fLgqN+Ju"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9F14F64
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849980; cv=none; b=TX/s0GaxYFHjCEVTsSRwIgU/hIVTfk/7ElA7j9u3mh2RbdKPfS99ON+oVNugBMpT2h3tb1i+J+aOZxGKcSeFNDzE7qa8yq7NvaHDv1fptBwugCqphUd2rdn9OtMcj0DgqYv02gV0DUndWsPJyg9Rnkj0aS9h7EqYDuTUftuDEcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849980; c=relaxed/simple;
	bh=XiXOfTTNOd1sJPDc63QHE7E6r8vBnGvBV/iAtaV5FJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE+0bTCAEVB590QND+9cWl4SIUK9vgtyKW4DMpWdRNsVOa/4dPY88yzWQ5c4hxBtXESDPRALhdNM1K+PJpoogNdGv91gaVDL9ZI+y+mGgMTmLAzSM2e0IKjv4u/QLmTwqkB/uMae6ZX5KGE9lhZPiHMh3p58AqurHxzRGkV5tNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fLgqN+Ju; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36a34b68277so115975ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849978; x=1713454778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcj7frfmKf3TG9j28sfetheUjR7sb7AoMM45ttfCxdo=;
        b=fLgqN+JuClkupZsDsa1SPi5ZusoElc/QpWhs+3ivK2q/Xmo5L+ZiajF3vJ4x2qydqn
         IEX0psf2aSieYxDdFBs1Rxl3wTwwzcYDVQRihAVAZi/Vl5ACYfG8WI//B3WZUAl1xLgP
         Rb9RCyIt0tJq5w7AI3/SkkP3O8IK0j7nmFFrqjr4/aaVT3GixJB0TYVaIbPT1SLbYaaH
         LjTiioZ94G9p1wuJ4PTHPPoTj9TpOphbI3IAar/bftMIsGwmQLIbfNuxNrK3GNYeSAxb
         Ccp++LJRUSzQAlBGezfDtbAz+3I6869rr0AmanQUA4a8nQOxIzqctfOn4VajJGFaSF85
         RFCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849978; x=1713454778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xcj7frfmKf3TG9j28sfetheUjR7sb7AoMM45ttfCxdo=;
        b=Zq1cX7QXx8xb/LaAQok6pEGQjKnIrHI1a8B0lvOMioysfVYmfO0UAioN+/qd+ZljNr
         0hkJpcHh5kU+tEJtw+mAiXz8g6ONfwF7GW+fC5dKRW9sk8eMR6ZIFuGcXD/NH71DtPeb
         om0RWRKLxmd7JhxaLmfpGv3iZEnOkGBTGiCc+8bHAKnMu7ejcLFBJpSHrniFlZlPO13j
         eCm6K+UG+wZEm3PEM/+oxESqrJBWKaKkuSIbKywEON6+BWd3HZ+T1kfRmUkB2b+J8aJy
         aBkC1LSnohC1Flih0aznhLVpr6tSjcQJgcKrkaS9ebv8qlE6zabCC5c86t76mwY7fsSM
         YOEA==
X-Gm-Message-State: AOJu0Yylx2QwhdaLsgk65W2y/wkVevcPSrdKsCY9Fq/OO8t/Y7ot/fld
	bb1dQ0kqWBNcQySOo/L40rCVWIbemR9EcRxoid5Pf6KV+4t+AYg4XRLMb8NhZuNq4mTAXbCt2em
	b
X-Google-Smtp-Source: AGHT+IGEpbjvDzN2GlW9PZ/5cx0O1gBDadkYDq+bNS3Wgl6WnkWnqURHxy8JV82XFrTBukdYX2EXRQ==
X-Received: by 2002:a92:c56f:0:b0:369:e37d:541f with SMTP id b15-20020a92c56f000000b00369e37d541fmr6997412ilj.1.1712849977921;
        Thu, 11 Apr 2024 08:39:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 288/437] fs/xfs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:08 -0600
Message-ID: <20240411153126.16201-289-axboe@kernel.dk>
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
 fs/xfs/scrub/stats.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/xfs/scrub/stats.c b/fs/xfs/scrub/stats.c
index 42cafbed94ac..bd546b61334d 100644
--- a/fs/xfs/scrub/stats.c
+++ b/fs/xfs/scrub/stats.c
@@ -235,12 +235,10 @@ xchk_stats_merge(
 
 static ssize_t
 xchk_scrub_stats_read(
-	struct file		*file,
-	char __user		*ubuf,
-	size_t			count,
-	loff_t			*ppos)
+	struct kiocb		*iocb,
+	struct iov_iter		*to)
 {
-	struct xchk_stats	*cs = file->private_data;
+	struct xchk_stats	*cs = iocb->ki_filp->private_data;
 	char			*buf;
 	size_t			bufsize;
 	ssize_t			avail, ret;
@@ -250,7 +248,7 @@ xchk_scrub_stats_read(
 	 * do not want userspace to receive garbled text from multiple calls.
 	 * If the file position is greater than 0, return a short read.
 	 */
-	if (*ppos > 0)
+	if (iocb->ki_pos > 0)
 		return 0;
 
 	bufsize = xchk_stats_estimate_bufsize(cs);
@@ -265,7 +263,7 @@ xchk_scrub_stats_read(
 		goto out;
 	}
 
-	ret = simple_read_from_buffer(ubuf, count, ppos, buf, avail);
+	ret = simple_copy_to_iter(buf, &iocb->ki_pos, avail, to);
 out:
 	kvfree(buf);
 	return ret;
@@ -273,21 +271,20 @@ xchk_scrub_stats_read(
 
 static const struct file_operations scrub_stats_fops = {
 	.open			= simple_open,
-	.read			= xchk_scrub_stats_read,
+	.read_iter		= xchk_scrub_stats_read,
 };
 
 static ssize_t
 xchk_clear_scrub_stats_write(
-	struct file		*file,
-	const char __user	*ubuf,
-	size_t			count,
-	loff_t			*ppos)
+	struct kiocb 		*iocb,
+	struct iov_iter		*from)
 {
-	struct xchk_stats	*cs = file->private_data;
+	struct xchk_stats	*cs = iocb->ki_filp->private_data;
+	size_t			count = iov_iter_count(from);
 	unsigned int		val;
 	int			ret;
 
-	ret = kstrtouint_from_user(ubuf, count, 0, &val);
+	ret = kstrtouint_from_iter(from, count, 0, &val);
 	if (ret)
 		return ret;
 
@@ -300,7 +297,7 @@ xchk_clear_scrub_stats_write(
 
 static const struct file_operations clear_scrub_stats_fops = {
 	.open			= simple_open,
-	.write			= xchk_clear_scrub_stats_write,
+	.write_iter		= xchk_clear_scrub_stats_write,
 };
 
 /* Initialize the stats object. */
-- 
2.43.0


