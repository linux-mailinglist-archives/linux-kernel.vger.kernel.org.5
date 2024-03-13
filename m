Return-Path: <linux-kernel+bounces-102517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39E87B329
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EAF2888E0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D041548F2;
	Wed, 13 Mar 2024 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXHAnEp2"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1D53E3E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 21:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363690; cv=none; b=QSWauWGjt0WBjSRb9yJyLEluh7W20NpvGdmEw5xbClXplJWJT2+tYpuWHZqWFiLIFxP6Is0xgTGZL1Wjngc2n8ZzSRRKVLO0LpetsN7d1NYNrn6vcU1aDscaJTGp/gHMeqhTitwOOwM87Vv8yHok/5lFMz6DvVpQhJ5OmuSC+7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363690; c=relaxed/simple;
	bh=lf0Ezrq6sV2vTi6Ku6PoBK22a4QkYPhDCEIeqxlzhyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b5OPyFS1RvJQGIHmTdy3pI1m22U93QfzX6FBrVbv2/89pKB20oYxTWn7o65IypZZgvNyaKQs0DydywTAPnhbu68oWvP+SJ3n8GwnJtdMqP29HhuzlU3wC2X4Nv1RPck9AFGD9fOwmEqAup6xaap5zfdScJbxzo+Qmt4mV2Z0gC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RXHAnEp2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e4d48a5823so275914b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710363688; x=1710968488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fGhwISbVuL7Awql500VL3lEax8ufxO5GMx6PyydUNdU=;
        b=RXHAnEp2F8ulXkExAdKwn9WwJD5xhb+zIeGdbgFFmP62OkdVFLG4N117xH/J4OLwCm
         0SiMPTXMGB9c7SnOzfci9ifFU4JgSeKxw8ZoP/+56hV+FKMQXY7w8VGgwoomp0cL5IMj
         QAgDA0/uGKl/vPuAsFaISBdhwsxeiIKo0pR86I6dN8U80UbqISEHB+5CBZs8pGJQthA9
         mGufKqXL5K9UxOmhKzsd9xhsam4ytzdEZ0YwK42Xp6PHcV+FTAC4GnB54xksRwida1xg
         1LeZuEV7Xqp1t2Eyx7EHG85XqYYT7SFGi6whVVvX6QNwqHYFWgMClGwuXz3egIOlT96b
         Ipkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710363688; x=1710968488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGhwISbVuL7Awql500VL3lEax8ufxO5GMx6PyydUNdU=;
        b=C8q964AvCqUuR5g0bHQzYxXNYaAXfz33XPEoOCqH0f//j7Qn6psPlzeoHhoaW/fyd5
         Db0AXZWafOiW13qF+y3r/JzampdFC0oo1YNtxX3eE+ZEvuP6MYJ8Rha1PFh+N90TDYci
         bB/PoO5PLM0SgXjxI2OWoVG5fiQdIJe5nBUG7K8oADa5XSpB/pLQjxIeb3mjBrUPTrat
         D2eoAZYxHSFVV0qSjVqA5kDbqAxdjJV/Thl+dd0l2drhvITModDTLrRdKP6RuyyDB+Dx
         s4xhVenVze1SpMy7MZc3MuBmz99bms3twuV5A1x7C8ZH+GhF2DeO75uqrGNYCWNTG7vh
         G50w==
X-Forwarded-Encrypted: i=1; AJvYcCVH+IpVN/UvKI6j9IpeGM551jfbTJ6bXRKxhU65gyZJpt6N3CK1cjC4FWP+09DuZt8uYu5fTHuMGgg6GmRfEeUVg6HXDmUeBXkh2hRX
X-Gm-Message-State: AOJu0YyWY4hRlN787QEqi2uWF57I84bdRQaVGk7kKqLEIMuIV1iiAYTn
	YKJ7a2h0MP2tdLmHWtcKfapWo2ycXC+L+pi9qPPTE0q5dtp/uy4BFyC6lzjO
X-Google-Smtp-Source: AGHT+IEIgG//aMbW2AdxO5RyUy8gxUffjty+SyVJ0zda+1NFxzLGPPT2ihYW3PeYlZ4rBt+z9HxQDw==
X-Received: by 2002:a05:6a20:d492:b0:1a3:2d9a:44dc with SMTP id im18-20020a056a20d49200b001a32d9a44dcmr81534pzb.50.1710363688016;
        Wed, 13 Mar 2024 14:01:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ace1100b0029bed2dc95esm1825641pju.56.2024.03.13.14.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:01:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-kernel@vger.kernel.org,
	Daniel Diaz <daniel.diaz@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rae Moar <rmoar@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] kunit: time: Add faster unit test with shorter time range
Date: Wed, 13 Mar 2024 14:01:24 -0700
Message-Id: <20240313210124.2858729-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a547c4ce10bd ("kunit: time: Mark test as slow using test
attributes") marked the time unit test as slow. This means it does not
run anymore if slow tests are disabled. This reduces test coverage and
is thus undesirable. At the same time, the test currently covers a range
of 160,000 years, which has limited value.

Add additional test case covering a total range of 1,600 years. This test
takes less than a second to run even on slow systems while still covering
twice the leap year calculation range of 400 years around the center date.
This test can run even with slow tests disabled.

Cc: Rae Moar <rmoar@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/time/time_test.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/time/time_test.c b/kernel/time/time_test.c
index 3e5d422dd15c..15c6f3a5e73c 100644
--- a/kernel/time/time_test.c
+++ b/kernel/time/time_test.c
@@ -47,18 +47,18 @@ static void advance_date(long *year, int *month, int *mday, int *yday)
 }
 
 /*
- * Checks every day in a 160000 years interval centered at 1970-01-01
+ * Checks every day in a specified interval centered at 1970-01-01
  * against the expected result.
  */
-static void time64_to_tm_test_date_range(struct kunit *test)
+static void time64_to_tm_test_date_range(struct kunit *test, int years)
 {
 	/*
-	 * 80000 years	= (80000 / 400) * 400 years
-	 *		= (80000 / 400) * 146097 days
-	 *		= (80000 / 400) * 146097 * 86400 seconds
+	 * years	= (years / 400) * 400 years
+	 *		= (years / 400) * 146097 days
+	 *		= (years / 400) * 146097 * 86400 seconds
 	 */
-	time64_t total_secs = ((time64_t) 80000) / 400 * 146097 * 86400;
-	long year = 1970 - 80000;
+	time64_t total_secs = ((time64_t) years) / 400 * 146097 * 86400;
+	long year = 1970 - years;
 	int month = 1;
 	int mdday = 1;
 	int yday = 0;
@@ -85,8 +85,27 @@ static void time64_to_tm_test_date_range(struct kunit *test)
 	}
 }
 
+ /*
+  * Checks every day in a 1600 years interval centered at 1970-01-01
+  * against the expected result.
+  */
+static void time64_to_tm_test_date_range_1600(struct kunit *test)
+{
+	time64_to_tm_test_date_range(test, 800);
+}
+
+ /*
+  * Checks every day in a 160000 years interval centered at 1970-01-01
+  * against the expected result.
+  */
+static void time64_to_tm_test_date_range_160000(struct kunit *test)
+{
+	time64_to_tm_test_date_range(test, 80000);
+}
+
 static struct kunit_case time_test_cases[] = {
-	KUNIT_CASE_SLOW(time64_to_tm_test_date_range),
+	KUNIT_CASE(time64_to_tm_test_date_range_1600),
+	KUNIT_CASE_SLOW(time64_to_tm_test_date_range_160000),
 	{}
 };
 
-- 
2.39.2


