Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4422379AEC2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358715AbjIKWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240925AbjIKO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299DE4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b56dab74bso32442447b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444238; x=1695049038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=35Wzlz8R5vpRX3Qc5T9eOyq5a0RR6jvjL1w5jIKVlmg=;
        b=ykZfkkFfQBXr57so9r9i4q4+ySu+/cBx6ZuE8KtoZgyk7S5ebuvkxpIYB6drmOV6YE
         K+n6X5aIKQ16EP1Nipacdn2L5YsL4RGy871fQ6tdpgMEWNbt1uQRbSrnLsMhvwe77F8o
         gThgQ3XP2fZ6HubedYzu6Zy+Dxt/7huxR6r/qxVmxIHL7HFMvUL1jlDFZyYATH2SNRk7
         m3MHEBzBuNk20YiqWIz1zG3zp+T5Y9PXzuh41/gPUOOIp81DlxFxnaPNsF19Zs4rnCIS
         lZyooIjcefpy8VknXwUciq3UdCnm2h6idqY5zCWCvv0Khwqq4MGgN+Cl0AQTNSokhLMp
         5nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444238; x=1695049038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35Wzlz8R5vpRX3Qc5T9eOyq5a0RR6jvjL1w5jIKVlmg=;
        b=EC3bzdfGzkTGNFYHxuANnXr0hOxVEzoicl3H1UVDX2P+TSAiBr7xU45vMg7ckQ6a5u
         aalrA8fMMPKNF+xCWV1f2cIsvLi1246S+ywAqdMOAMntO8fm1+hsEngdKIjEAuPUEeGj
         PS9KeL9xdd1fZb2TkkoRe7//sHgzPb1DxNPgtlpu+0or5O9rGzSF9WihqEjKqFpmK7NP
         YrldjjCUX52UgMU9jtUb+SC1hhiV/nFWXLjSsvLuxaOlKsjcEvnGnnvRh7LSFALeFcAM
         nmlo4AVETP9qobdbhUM52fKrfTAyZbJz8fb3+tHqEm+20HQ68Dz6GYwLYQmgg6byG2N4
         SQeQ==
X-Gm-Message-State: AOJu0YwdEpRfZ1f3uiyGxC154RUxRsdz8iLlyOQiwnaUrLemY9eokCAr
        ensLw60NvQmcl0zN4n+thJNHMU/FiNI=
X-Google-Smtp-Source: AGHT+IFbDjXsFCpFPMP4O6untSuU2SDiFHSQUeHMJpN9MUJc//PbV795sAl5SlWWtJvTh2d0prjfDsssd4U=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:62e7:6658:cb4:b858])
 (user=glider job=sendgmr) by 2002:a81:7647:0:b0:57a:e0b:f66 with SMTP id
 j7-20020a817647000000b0057a0e0b0f66mr249145ywk.7.1694444238744; Mon, 11 Sep
 2023 07:57:18 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:57:01 +0200
In-Reply-To: <20230911145702.2663753-1-glider@google.com>
Mime-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911145702.2663753-3-glider@google.com>
Subject: [PATCH v2 3/4] kmsan: merge test_memcpy_aligned_to_unaligned{,2}() together
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, dvyukov@google.com, elver@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce report_reset() that allows checking for more than one KMSAN
report per testcase.
Fold test_memcpy_aligned_to_unaligned2() into
test_memcpy_aligned_to_unaligned(), so that they share the setup phase
and check the behavior of a single memcpy() call.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index a8d4ca4a1066d..6eb1e1a4d08f9 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -67,6 +67,17 @@ static bool report_available(void)
 	return READ_ONCE(observed.available);
 }
 
+/* Reset observed.available, so that the test can trigger another report. */
+static void report_reset(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&observed.lock, flags);
+	WRITE_ONCE(observed.available, false);
+	observed.ignore = false;
+	spin_unlock_irqrestore(&observed.lock, flags);
+}
+
 /* Information we expect in a report. */
 struct expect_report {
 	const char *error_type; /* Error type. */
@@ -454,7 +465,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
  *
  * Copying aligned 4-byte value to an unaligned one leads to touching two
  * aligned 4-byte values. This test case checks that KMSAN correctly reports an
- * error on the first of the two values.
+ * error on the mentioned two values.
  */
 static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 {
@@ -470,28 +481,7 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 			sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
-}
-
-/*
- * Test case: ensure that memcpy() correctly copies uninitialized values between
- * aligned `src` and unaligned `dst`.
- *
- * Copying aligned 4-byte value to an unaligned one leads to touching two
- * aligned 4-byte values. This test case checks that KMSAN correctly reports an
- * error on the second of the two values.
- */
-static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
-{
-	EXPECTATION_UNINIT_VALUE_FN(expect,
-				    "test_memcpy_aligned_to_unaligned2");
-	volatile int uninit_src;
-	volatile char dst[8] = { 0 };
-
-	kunit_info(
-		test,
-		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
-	memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
-			sizeof(uninit_src));
+	report_reset();
 	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -589,7 +579,6 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_init_memcpy),
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
-	KUNIT_CASE(test_memcpy_aligned_to_unaligned2),
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
-- 
2.42.0.283.g2d96d420d3-goog

