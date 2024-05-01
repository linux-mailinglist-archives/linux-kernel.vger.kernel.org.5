Return-Path: <linux-kernel+bounces-164983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9168B85DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6B1B220BD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 07:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3694D9FB;
	Wed,  1 May 2024 07:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICzV6ec9"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FB4D13F
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714547819; cv=none; b=RmDueYS+r5EFZPjLF8VuU12I64r8GweIERev+v69ZIYKdXcOx7uZspyYNPTMkcQj44UbGeqgKeAz4M2Gf+wWI/LzEF0JPRD2VMRZfuszaZFofga14v7W9DxNLcnXJ8KANl3FHj3yeuRyBxleei9yT6YVVo1dMSFydIFZ+acpeAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714547819; c=relaxed/simple;
	bh=wleAs3KAWztDL0dCFGFKxp3hSp3edkFRQgnZ399jByI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdCA2G4ZNHWVYJ+vbZuZY5H2n+Jm44JrY0crN+fO/wuahNiLdhhFpcx8JqjHt4nUAoZBoODKYspoMGTLrbXltqjX96rfc49oP+RAwsUa6ge8xryCFQ+1z6W7ztCDRy9rU9PFw92A6WBK3vo/UIriXce/NxsV4SUlU5UxyC5MPjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICzV6ec9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5f803c625c2so320471a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714547817; x=1715152617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHl+vjSQhlOCDo1HkWE4HoBo27/jjplAYwQBRwMSU5k=;
        b=ICzV6ec9CfOICX2QjWNrUxOhVhoH8W1hFlICGJgSSGIoKIrUk9m96HiszoR4aFfDn9
         V+2fSle9COIlS7DRVMesvv4PWOzckAAbvUAALn95OMOJOimE2Gzw5O/CjQTJUFTsCcz4
         s9BnZfffPUWEyMZScjlXKOcDU7RHQcs45XVbs8KP8c1OcDoIs67aoT/Le3yfqQjzJNST
         qYruAYTlJe3nTbgk4jmW/yOfA3ya8dlg5DEv1V6ilbK1/a/qIwCZykfDvuOrpsfCUg0q
         6Fb7lZkEUR1XUKIsmZe4qYdYg6p/r3BST35TLBSStpkv26KyerT1Z1HYHeLEGdjEA7z2
         vvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714547817; x=1715152617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHl+vjSQhlOCDo1HkWE4HoBo27/jjplAYwQBRwMSU5k=;
        b=qhezwtIN/xYAh4NQ34jcPCFxw9a/1s5OA0uzG6g6tsinySa1tBjyY4vI6lUfVQyLQ6
         LarG5GPrJFce/uW3hFCciU3ZykoOaU225SALEiERsyPOexRVOVtNZBfKSeLyEUJhF5Vm
         yuyCRyw/zN+4gzBg2CehkZckKFSzUYVSpOZmzAkgfXJ83VVaJyPLZ9qe7Zvvuf8VUHyA
         FqmkMtPO8CsMMi0SaN3kNEypmeFxtDoOzNQTSOMkryv5UvYqXU3CLMYkKyX8kgffdHTM
         TTlYApK0n41TsPtzH/Tk1BmR0gZ1cQ8W614+qKHHVwxwP0ST1067H4m9/TxiVDsQ5Qho
         Wjjg==
X-Forwarded-Encrypted: i=1; AJvYcCUk8KgM1J45iEuU0Iez5430wDEEULOnqKqCIiWv9tLmo5w2U5pRbobtbzEuc+Q9b2cyKaYzKEAz2fHUBiMHSUQlI5IHbAfkXCftQ2Gr
X-Gm-Message-State: AOJu0YxHUnVRxnkjTHnHY5tkS2k1+Hhya5S74zCmOmhKKuddJQzY3Vln
	dOy6oSv4nlWERNOoOF72NEYgKybi2NhPpG0MaNEn3N9RvfBSgn9O
X-Google-Smtp-Source: AGHT+IH1hik2ZX0W4SU0KnweszilV0tRhRWaVEpHTGUtZVQesVKTdBYaWYX4DrAApFnGF2FfZVQ2Sg==
X-Received: by 2002:a17:902:e88a:b0:1dd:85eb:b11 with SMTP id w10-20020a170902e88a00b001dd85eb0b11mr1838568plg.1.1714547816610;
        Wed, 01 May 2024 00:16:56 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id kk14-20020a170903070e00b001e560db091asm23523013plb.72.2024.05.01.00.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 00:16:56 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 1/2] lib/test_bitops: Add benchmark test for fns()
Date: Wed,  1 May 2024 15:16:46 +0800
Message-Id: <20240501071647.10228-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501071647.10228-1-visitorckw@gmail.com>
References: <20240501071647.10228-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a benchmark test for the fns(). It measures the total time
taken by fns() to process 1,000,000 test data generated using
get_random_long() for each n in the range [0, BITS_PER_LONG).

example:
test_bitops: fns:          5876762553 ns, 64000000 iterations

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---

Changes in v3:
- Move the benchmark test for fns() to lib/test_bitops.c.
- Exclude the overhead of random number generation from the benchmark
  result.
- Change the output to print only a total gross instead of each n in
  the benchmark result.

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


