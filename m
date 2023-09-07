Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43232797945
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241090AbjIGRJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbjIGRJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:09:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53334E65
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:08:46 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d75a77b69052e-414c43a48fdso14709671cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694106463; x=1694711263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8i7Jhe9BViu4aMBPbLDU6gPTC4qxWjzqtUEiNX0CLE=;
        b=iFhusV/WTm1dAY58O/80f9236uUuqY2U+TNUJC2Es5btU5tyrXQk0djiE71Ai0oDTy
         Gm1LKlkNwuAKHdjXHdil+phhZmCa+wSV6MVbdNAOA1+c/qqjYEJ+sfGMTVsvJ5QFuF/Z
         f3wK+GPh4JIbRgoYiLcX5B6mk7NOmj4LWcMhBERCZACkXMTPGiflTtjtv7EmAFztqcJ7
         10Swx6xoyH+9ysMjHbDnHjmArX069lvzohz56HXedGZPVAEeCm55NhTXxtj5iNB8u5FP
         PzuCLve8Ykb2gTdYOoDQUIR3YrD9z5MOP8YDOXy+X41HAFuOKyvnvOuzktIVlEHGRVCZ
         9G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694106463; x=1694711263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8i7Jhe9BViu4aMBPbLDU6gPTC4qxWjzqtUEiNX0CLE=;
        b=aKM7R2M7QtMFxR8d7VlS1NyB0JpDuY0H5MTFbQbPS+Uw/ynsfMT+k73GuML8hzzqUx
         pdXkHQQtqMUnq64TSrG3j116ceBz+kO5ITJpEOYQIxfUmp63NxqHy6/olXIIzSkcqFrJ
         rbBF6EaSIEVHhBqq41zi+9PrFP/AqFNtrU3ojBdNBcPBIeEm8A0cQXJ5r0sDVgAMgyRL
         WZ+6sy6bbK+n878OlooyYi8gyYbz3ZYTgumt5KMBCoUOhCgY3XAa99FY/31vA4DqLdue
         448vudCmAde3LkPyndmVkzujw3PE4rkaKjzYrPUTppqPXfK9unTT7UnnI0mnATsV66B+
         9ECQ==
X-Gm-Message-State: AOJu0Yyio0nvqP8Slq6hABSG4F0I9/hgboBKKtp23vr0mtmeGVvgxj28
        35T3ENNSCg7StpE2SMHgmwfHuhaYqQ8=
X-Google-Smtp-Source: AGHT+IEevIijC6sdQUSkGV/Z3VUPtyWQWTY5lHP0KbgSWdAqKt9EUNHzvlQ9r/pckae1MLXf3sJctovYv6g=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:33dd:e36e:b6dc:1a69])
 (user=glider job=sendgmr) by 2002:a25:d20f:0:b0:d78:215f:ba5f with SMTP id
 j15-20020a25d20f000000b00d78215fba5fmr466389ybg.9.1694092010883; Thu, 07 Sep
 2023 06:06:50 -0700 (PDT)
Date:   Thu,  7 Sep 2023 15:06:42 +0200
In-Reply-To: <20230907130642.245222-1-glider@google.com>
Mime-Version: 1.0
References: <20230907130642.245222-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907130642.245222-2-glider@google.com>
Subject: [PATCH 2/2] kmsan: prevent optimizations in memcpy tests
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, dvyukov@google.com, elver@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang 18 learned to optimize away memcpy() calls of small uninitialized
scalar values. To ensure that memcpy tests in kmsan_test.c still perform
calls to memcpy() (which KMSAN replaces with __msan_memcpy()), declare a
separate memcpy_noinline() function with volatile parameters, which
won't be optimized.

Also retire DO_NOT_OPTIMIZE(), as memcpy_noinline() is apparently
enough.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/kmsan_test.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 312989aa2865c..0c32c917b489a 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -407,33 +407,25 @@ static void test_printk(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
-/*
- * Prevent the compiler from optimizing @var away. Without this, Clang may
- * notice that @var is uninitialized and drop memcpy() calls that use it.
- *
- * There is OPTIMIZER_HIDE_VAR() in linux/compier.h that we cannot use here,
- * because it is implemented as inline assembly receiving @var as a parameter
- * and will enforce a KMSAN check. Same is true for e.g. barrier_data(var).
- */
-#define DO_NOT_OPTIMIZE(var) barrier()
+/* Prevent the compiler from inlining a memcpy() call. */
+static noinline void *memcpy_noinline(volatile void *dst,
+				      const volatile void *src, size_t size)
+{
+	return memcpy(dst, src, size);
+}
 
-/*
- * Test case: ensure that memcpy() correctly copies initialized values.
- * Also serves as a regression test to ensure DO_NOT_OPTIMIZE() does not cause
- * extra checks.
- */
+/* Test case: ensure that memcpy() correctly copies initialized values. */
 static void test_init_memcpy(struct kunit *test)
 {
 	EXPECTATION_NO_REPORT(expect);
 	volatile int src;
 	volatile int dst = 0;
 
-	DO_NOT_OPTIMIZE(src);
 	src = 1;
 	kunit_info(
 		test,
 		"memcpy()ing aligned initialized src to aligned dst (no reports)\n");
-	memcpy((void *)&dst, (void *)&src, sizeof(src));
+	memcpy_noinline((void *)&dst, (void *)&src, sizeof(src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -451,8 +443,7 @@ static void test_memcpy_aligned_to_aligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to aligned dst (UMR report)\n");
-	DO_NOT_OPTIMIZE(uninit_src);
-	memcpy((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
+	memcpy_noinline((void *)&dst, (void *)&uninit_src, sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst, sizeof(dst));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -474,8 +465,9 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst (UMR report)\n");
-	DO_NOT_OPTIMIZE(uninit_src);
-	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	kmsan_check_memory(&uninit_src, sizeof(uninit_src));
+	memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
+			sizeof(uninit_src));
 	kmsan_check_memory((void *)dst, 4);
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -498,8 +490,8 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
 	kunit_info(
 		test,
 		"memcpy()ing aligned uninit src to unaligned dst - part 2 (UMR report)\n");
-	DO_NOT_OPTIMIZE(uninit_src);
-	memcpy((void *)&dst[1], (void *)&uninit_src, sizeof(uninit_src));
+	memcpy_noinline((void *)&dst[1], (void *)&uninit_src,
+			sizeof(uninit_src));
 	kmsan_check_memory((void *)&dst[4], sizeof(uninit_src));
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
@@ -513,7 +505,6 @@ static void test_memcpy_aligned_to_unaligned2(struct kunit *test)
                                                                             \
 		kunit_info(test,                                            \
 			   "memset" #size "() should initialize memory\n"); \
-		DO_NOT_OPTIMIZE(uninit);                                    \
 		memset##size((uint##size##_t *)&uninit, 0, 1);              \
 		kmsan_check_memory((void *)&uninit, sizeof(uninit));        \
 		KUNIT_EXPECT_TRUE(test, report_matches(&expect));           \
-- 
2.42.0.283.g2d96d420d3-goog

