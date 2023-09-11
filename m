Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CD79BEA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbjIKWip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjIKO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:21 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B09E4B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:16 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-313c930ee0eso2827347f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444235; x=1695049035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCSVjF+G/Yb3+dPBWGz9EuIiyh+/ldUAKZlZ+MbeoHM=;
        b=alo7MMQz1MoiVX26Nna85O1ht7DzrLo13Y80EZEvIRzoNKOm/oR6/TGBaWp9WcwE1J
         gDccdf7Nl6NILf799HOavx4Tbfp7GAQUiMpGXRIJxx0obnPgHrss0/qaSzyxuyTM5I5N
         YGXSYIBWnuR3LByR7hEDPUT3UyEwRpgd9KJZ8GonoddcHvQQJVcr8H+YNO5NYOOAS25P
         gsfa605kNP96KeaaYJL3pUDvIZ4LsBuFc9bnEKmvPioNDO2e1DnvAXwGKpzKPt0jHzgb
         /2pUXkLK+JrzMW8tl1ip+1yaxOAfGXEGHVO4vggCvi9zSm4ivS1BaVjKBGVllcWhCXnF
         SYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444235; x=1695049035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCSVjF+G/Yb3+dPBWGz9EuIiyh+/ldUAKZlZ+MbeoHM=;
        b=DpF67JdNpUbX/q1aj0i5MXqMSD1CmLJ22xeg2rmPf0KS/QkniNCD15gOsLDhkegkCD
         avwww6Jm5Y93luoJkb5+PRgPIS91VkB2zqVSBlAV9pIbZSYRjpE92GBGvNNVMRxSQTYq
         MUu8YSusiA/1XVC0wpDArbLTHknQpPf+UMkybazfl9nc+GNgKvCfgbAbbJzKFsOdTpVG
         j/wS5HzyAhNpBFAeAgwHuwtA5kaXUCnQVTebE6jlMJ0ZdTOIlRnsCTVOymSeIziFsUqV
         og0PXoSnmJ/ouxZ3IFXBgioCCe4eQuXn/R0YvZOlHw+htI6VknLArByfPTO5HJ3Mz1x+
         RE/A==
X-Gm-Message-State: AOJu0YzYH9hjFwC/JoyboSm5VMUA6oTkph945QokIDzooWPLCvCRSI7J
        qmmGDGT04aYCzuZRb5lQ1eIoDM6D9eY=
X-Google-Smtp-Source: AGHT+IF8AQnXMqKw+wXUY955bd2z842BBltBx/W8SpN0YrTJ17nBacddlqEtoES1ZoK3oQ/7F/gHOXNEgb8=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:62e7:6658:cb4:b858])
 (user=glider job=sendgmr) by 2002:adf:ce84:0:b0:317:41be:d871 with SMTP id
 r4-20020adfce84000000b0031741bed871mr114853wrn.14.1694444235317; Mon, 11 Sep
 2023 07:57:15 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:57:00 +0200
In-Reply-To: <20230911145702.2663753-1-glider@google.com>
Mime-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911145702.2663753-2-glider@google.com>
Subject: [PATCH v2 2/4] kmsan: prevent optimizations in memcpy tests
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

Clang 18 learned to optimize away memcpy() calls of small uninitialized
scalar values. To ensure that memcpy tests in kmsan_test.c still perform
calls to memcpy() (which KMSAN replaces with __msan_memcpy()), declare a
separate memcpy_noinline() function with volatile parameters, which
won't be optimized.

Also retire DO_NOT_OPTIMIZE(), as memcpy_noinline() is apparently
enough.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
v2:
 - fix W=1 warnings reported by LKP test robot
---
 mm/kmsan/kmsan_test.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 312989aa2865c..a8d4ca4a1066d 100644
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
+	return memcpy((void *)dst, (const void *)src, size);
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
-	volatile int src;
-	volatile int dst = 0;
+	volatile long long src;
+	volatile long long dst = 0;
 
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
+	kmsan_check_memory((void *)&uninit_src, sizeof(uninit_src));
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

