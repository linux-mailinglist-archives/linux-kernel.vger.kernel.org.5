Return-Path: <linux-kernel+bounces-56534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487BF84CB5A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E21C25608
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1484476C82;
	Wed,  7 Feb 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCOgnmD8"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DF20B03;
	Wed,  7 Feb 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707312018; cv=none; b=SVrgKoyNdR52cou/cCdJk1xovYFYQceuvLtL0+ZohzeoARkfGIruc4epG2rIwjFHTGDZHB4MXTzkWNUfwf65Y6fdekns1WAoMQUDUyC7lA3wyO2C+FJa6z3YyzKLc3I850S1zna5easiG/wALu5n2TOGp5rfQaLvMg+iYBmXWRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707312018; c=relaxed/simple;
	bh=S1fOPorZfTPT9eruGFGxWNWI93/Yt7GxUMA9bTf8aYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CE/Px50AwPPa1SkXv4nmLQ3nU0yikyekpDoof/uNBWxSZGHDjJdDhn8CYC/0wFdKBAU+3A6hTIadTdnp3zpxcXBgEGfxDSOL/32xCdA7dJQxWQwV4qniRvqJrr2bRTJuqcB5wFYlY8S6k+RlaLvcpg9mRvUp/DhTyjXX9B5viG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCOgnmD8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so5135575e9.1;
        Wed, 07 Feb 2024 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707312015; x=1707916815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtAXcU/XCAZNdV3GEH8KX6/QmDDlUownJGCmq2AEj8c=;
        b=CCOgnmD8uBg8++Fjuh354EP+PeEhfVUOPTr1WQ3PSBR3es+R8gvRA/jxsRq4oZ5nTY
         2aHqKFj9e8uwvYBoLZsskkhrFHJ6AsD/c40KjL2bPPrqwARsMK9oaDS2UEDPYRNmBbPq
         iU9XVTwVz164l9v4h+ZusmqrOEf6v5AuCx9fs/ipzsyaKOToiT/bOhf+vPqqycGJ+G+t
         j3xok28RFaOxLpNpWhqPqlpVGdGKwlcI9btvnjBdey2eeMFZShHchsSx1SQR3WzvHcJv
         SYGzyZbQMTsRtBYwzWWU+gP8MZZBrlhZG1rDVhZled2TiyThBnZ9mPFQMxUf7aZPyoVA
         toBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707312015; x=1707916815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XtAXcU/XCAZNdV3GEH8KX6/QmDDlUownJGCmq2AEj8c=;
        b=B8r6md7kix+SpQgeywJx2OLz30slysYJuksuhIBzMrDGubJ2fcnheI7vz7z+ZFNVEN
         gjxMcaVmFElIWDtYbEx6AL9771Dkx+QezEhjdFrdcIQ7caC5oSyE8HfZdWV8IyvTA7vQ
         8d3p4vQaAAUi0Iw0pd2KHZxdPZe2BDzrZYbBEsCChvuk5itg+fQMk3gbQySybhPI2no9
         cHAg4mGYbXeHy7czjS0BJGtnVlivwoHmiPuxxvdAf6sleRPcVPAYd7pidXoj1AR+EIES
         pMmzCKnrLA6MHjUEhwKPdoDtd5o2L++U9kkLhGmztGsUbodX4jrQx3FRe/k9UiVLyU6Y
         NtRg==
X-Forwarded-Encrypted: i=1; AJvYcCU7pqOvZlnv+P0mPezO3VS36n49hE54CTsa1d51P+s2H2/17quRQNFTT7YgfvO72bntCR23fwWY4Shc2eJW7L8zbkf+E9UtE1ahvozT/w/LMNtcL0Y5jWC9lzU/VD/why360Et+vjm0
X-Gm-Message-State: AOJu0YwkLdyDXb49yrEkO/Ms+lLEpZ3+NEg7Z0qjMHoh32Xfms+kImbh
	8Zh6ROPy04aQ2d1juTyy4GTucBrka22MnL9qcNZIZ49zA2SH4lkd
X-Google-Smtp-Source: AGHT+IFxMqMcwE1PmyIdZoioYqNY+TBc5P4Ddg8jsJbOpAOp8aUECawJxkkRzKIkKi7IX3dnijEZOA==
X-Received: by 2002:a5d:598a:0:b0:33b:47cf:323b with SMTP id n10-20020a5d598a000000b0033b47cf323bmr4833990wri.9.1707312014866;
        Wed, 07 Feb 2024 05:20:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVF9gUdMloeTu0n0vmmkI6dI8+gIIsCG08YVphQ4d2cK8/7jloXuP2hSt+zJD+bkjCA7JP525A9o/tc+NWMW1+ssOgBEiq3sl5A9jOp3qd+7xQuFN7GYGKnjAr/1WJDjNF1pJmoq2o8c4hkXVUn9yLMlV/LKu1RJhKKZij36BugFp9HsV+GP4Wg1YGK0pmlNUvbXhEFp1u03wKkqzQsCyYS89/UCpDycoiFT0UaEMan1mhs6h+BqgDkrAMKgCZIt2YQBXRoPvYFAFitqhXxj9j2cD56DdGmv1QBWg==
Received: from demon-pc.localdomain ([188.24.52.65])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4f05000000b0033b1b1da2adsm1495764wru.99.2024.02.07.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:20:14 -0800 (PST)
From: Cosmin Tanislav <demonsingur@gmail.com>
To: 
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <demonsingur@gmail.com>
Subject: [PATCH 1/2] iio: adc: ad4130: zero-initialize clock init data
Date: Wed,  7 Feb 2024 15:20:05 +0200
Message-ID: <20240207132007.253768-1-demonsingur@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_init_data struct does not have all its members
initialized, causing issues when trying to expose the internal
clock on the CLK pin.

Fix this by zero-initializing the clk_init_data struct.

Fixes: 62094060cf3a ("iio: adc: ad4130: add AD4130 driver")
Signed-off-by: Cosmin Tanislav <demonsingur@gmail.com>
---
 drivers/iio/adc/ad4130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 53e19a863198..c7df499f9775 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -1794,7 +1794,7 @@ static int ad4130_setup_int_clk(struct ad4130_state *st)
 {
 	struct device *dev = &st->spi->dev;
 	struct device_node *of_node = dev_of_node(dev);
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	const char *clk_name;
 	int ret;
 
-- 
2.43.0


