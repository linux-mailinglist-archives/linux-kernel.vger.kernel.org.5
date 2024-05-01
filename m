Return-Path: <linux-kernel+bounces-165311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D08B8B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE651F2337C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AE12E1F8;
	Wed,  1 May 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5O0rKRm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F32312E1D1
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569658; cv=none; b=OSg/RwCFnwvd6fCt1bqF7c7TNUiWzd49RzlwguPBSKF1aWND1sFL0GerLBkcgEvIf65bdd+lZbp+rK/rrRCGdyix1j2i3uNSGZsHpd/jvyxZuZJw5Qrkrppn/ne4Yh8kCBNt5itV7g8YcNA1mcbpRC1EMAgOj2AUwNVIUsQGTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569658; c=relaxed/simple;
	bh=gsmqgT55jmI1YoSgmV71VQ60NHFBPoSm072eHEuw9bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQHf1oW0ifi33mMhlHHzkCYbOnW0RIEU3l/Z0sBQTnfyB0QhXJbC+i8uUQzd1j14pZa9cwe9a3JF/50ajBhBDUf9/eF7+565prxNCRGLt/zeFb0BdGZXbQuxm0iM5RU8kHl8JOty0yh8KAoEMzr/ZEzDVtZT+efHG104eS+HPVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5O0rKRm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eca151075eso1080045ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714569656; x=1715174456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug5j8NW6L9taLItjNKG7FyagsotBbmpdWD8ROPb6uTU=;
        b=Q5O0rKRm0vSuc+eEry8oe2cFIP+fcxTSk2aXgVrFivib4IVE3CRRwogGFb8jDI9DC7
         GwUX1Wt9xhLqL2Zrvh0HbJS0anMK8LFXZa8WPxYIOfW4KtoL4PSA9slJD8ToPatBPpgQ
         RXTVd4gIRjYukyVDLX6pEglyGYIlB51i0S2VpANsZhb8Htsd8x+KETyVBx/Fj//HtMr6
         GxeGGy+jeufFHFM+P9Agjs4NY3lvoWY9Xoy6ObUZtriO12XOVr2izgZ5Q+stGFVufRM5
         /e3lfdyPZCdXNiz2q8wWMadpEuAjuofuhEtF47poOHnfa28pZP8ZodBvlost2679fEs7
         a2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569656; x=1715174456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug5j8NW6L9taLItjNKG7FyagsotBbmpdWD8ROPb6uTU=;
        b=BeMCdbVSNabtLQiTOp4Hk5WIq/jqHYzX6Li058pdoDvLJQvVMp/Nb5rlOWeFBd+z37
         yk+MXqAgwZ2qBN5OnBr8qNfVMXDUr8QvmitFk4t9yx4vfbyn8rApxUBFKCKbu2sZc24n
         GQAbX4r0dfAVYrv0I6aDifczLjRskQtU6n9p1m5pqBzT9Moj2gAkL4HOscql4pp3TVMq
         mZKRORPoL4CtW7kMYQNP/K2fsTLhIbD+9gBeCnyyWmPmRusiIstZyNxO7Nc9zwoz4won
         hgd6PBIwssW0dRdw1a7ATkusbP15ZoeEwqc3YzxtxXCFA4bwHJ2XaSpz62lNpaRWDv1O
         QkJA==
X-Forwarded-Encrypted: i=1; AJvYcCWvJR+rEhBnD2W+injpDhT5pmRpxJFef043TnJQDfmGwn/rFqlSDkTWUSoSsXfrY2GwqxUvN3KRsAZjikpYyQ7YT6+P9MvUQEK3tFU7
X-Gm-Message-State: AOJu0YxPCUl1hiRnvgj7VmqV9nWFf7bYD/TJW776DIqLWSdXABlxLGol
	FMVuzXHR+3QHjcYEPk8mc/m2YfZp3/142MTgkzWcVBI1cPSFRYeU
X-Google-Smtp-Source: AGHT+IFzCZ6HZznvNOXAu/yFWKxAzyj0pXOM6rUwcs+9Mx9Qq03QosJ3QTIoaGjEpkyhmiKZFNshvQ==
X-Received: by 2002:a17:902:ea06:b0:1eb:ac3c:e39f with SMTP id s6-20020a170902ea0600b001ebac3ce39fmr2563942plg.6.1714569656610;
        Wed, 01 May 2024 06:20:56 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001e0648dfd68sm3277164pli.296.2024.05.01.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:20:56 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Date: Wed,  1 May 2024 21:20:46 +0800
Message-Id: <20240501132047.14536-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501132047.14536-1-visitorckw@gmail.com>
References: <20240501132047.14536-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a benchmark test for the fns(). It measures the total time
taken by fns() to process 1,000,000 test data generated using
get_random_bytes() for each n in the range [0, BITS_PER_LONG).

example:
test_bitops: fns:          5876762553 ns, 64000000 iterations

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

Changes in v4:
- Correct get_random_long() -> get_random_bytes() in the commit
  message.

 lib/test_bitops.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index 3b7bcbee84db..ed939f124417 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] = {
 };
 #endif
 
+static unsigned long buf[1000000];
+
+static int __init test_fns(void)
+{
+	unsigned int i, n;
+	ktime_t time;
+
+	get_random_bytes(buf, sizeof(buf));
+	time = ktime_get();
+
+	for (n = 0; n < BITS_PER_LONG; n++)
+		for (i = 0; i < 1000000; i++)
+			fns(buf[i], n);
+
+	time = ktime_get() - time;
+	pr_err("fns:  %18llu ns, %6d iterations\n", time, BITS_PER_LONG * 1000000);
+
+	return 0;
+}
+
 static int __init test_bitops_startup(void)
 {
 	int i, bit_set;
@@ -94,6 +114,8 @@ static int __init test_bitops_startup(void)
 	if (bit_set != BITOPS_LAST)
 		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
 
+	test_fns();
+
 	pr_info("Completed bitops test\n");
 
 	return 0;
-- 
2.34.1


