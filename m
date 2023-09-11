Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D4079B5CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbjIKVbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240935AbjIKO53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:57:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731E3E5F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b9eb73dcdso3934130276.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694444242; x=1695049042; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1LA3n6XS+9W5aKwW+ISlF8R6L/zQAaDfcEugGZs2mo=;
        b=RN8bGpFqRy3s0umWUhMKRVIOLxwp/G9Ex6WioMF4KvPornzoeWVrsPMYtFzl5aA+o1
         CM55uNDUUvyfmEACGdLPShFbvBmUbEyVrDay348JF1RcmXz+WmQXYhH+hpruhACIfsEv
         NVOYZ7hzzF0RfCYac+Nj7NAM/OpEO9xZvx8W93Guq6Z56e2niaK8fnBtU7M13+VUQa8r
         CUzoHIYyfbWhDCto1veDUm9Zau97j5K/K6iuP68fuZwzVI6pRlRCVFbIZVU0Il9CNUOD
         tumXKFKckqtkBEDtOz8cxbVWG0Q9CmFec83h14y9TW+1wf5NDEKS48a98kQKtHehp8ET
         3Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444242; x=1695049042;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1LA3n6XS+9W5aKwW+ISlF8R6L/zQAaDfcEugGZs2mo=;
        b=glMpKkfnxPK69UqYVVxC3/kcoYWXJ3Z9j7YN7QnQhinEzIy4U3ZkMYqIIlvQhLA/tc
         H8HUGKgDH0FX0+sC1PpZbGq3Ierp8jU+LkLqTs12dX6f2V7bL/L7JcYKOrWwJ7pVt4UP
         0eETgGzPGh25xr9P7W+d9LDjUAMcHn/9/5M5GdOMIKubhPhDd94Y5lDTyT9MIGddCFGy
         2ezS9LwgwunULLprKNsJOsGpuw5ccBg0mAtReU5NihJGavBZvZ9emZE7o7oVZHiwXvxH
         K59aHlS8NB7arVFBfOA2gnY3uuCqxNGw1okQE6k/vXgFZP4QrW/7yu1iFadETRe9rDL0
         zFRA==
X-Gm-Message-State: AOJu0YwgC5O/nsacYqEk7jFxnQtQ8WLjzx2beb+3cKOOhIHMcaEPuMY1
        5fQbbLDWkO2fgHzwZ5O8octzQuMpUAE=
X-Google-Smtp-Source: AGHT+IGgYo8cMxj1/e+FbOJOJcBQoXTfy8dYxQu7bb+1wqifAQTypCZx7AnQFhZSOBc5IXdfMrMY5NChrpE=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:62e7:6658:cb4:b858])
 (user=glider job=sendgmr) by 2002:a05:6902:68e:b0:d7e:add7:4de6 with SMTP id
 i14-20020a056902068e00b00d7eadd74de6mr237093ybt.4.1694444242566; Mon, 11 Sep
 2023 07:57:22 -0700 (PDT)
Date:   Mon, 11 Sep 2023 16:57:02 +0200
In-Reply-To: <20230911145702.2663753-1-glider@google.com>
Mime-Version: 1.0
References: <20230911145702.2663753-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230911145702.2663753-4-glider@google.com>
Subject: [PATCH v2 4/4] kmsan: introduce test_memcpy_initialized_gap()
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

Add a regression test for the special case where memcpy() previously
failed to correctly set the origins: if upon memcpy() four aligned
initialized bytes with a zero origin value ended up split between two
aligned four-byte chunks, one of those chunks could've received the zero
origin value even despite it contained uninitialized bytes from other
writes.

Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Marco Elver <elver@google.com>
---
 mm/kmsan/kmsan_test.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/mm/kmsan/kmsan_test.c b/mm/kmsan/kmsan_test.c
index 6eb1e1a4d08f9..07d3a3a5a9c52 100644
--- a/mm/kmsan/kmsan_test.c
+++ b/mm/kmsan/kmsan_test.c
@@ -486,6 +486,58 @@ static void test_memcpy_aligned_to_unaligned(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }
 
+/*
+ * Test case: ensure that origin slots do not accidentally get overwritten with
+ * zeroes during memcpy().
+ *
+ * Previously, when copying memory from an aligned buffer to an unaligned one,
+ * if there were zero origins corresponding to zero shadow values in the source
+ * buffer, they could have ended up being copied to nonzero shadow values in the
+ * destination buffer:
+ *
+ *  memcpy(0xffff888080a00000, 0xffff888080900002, 8)
+ *
+ *  src (0xffff888080900002): ..xx .... xx..
+ *  src origins:              o111 0000 o222
+ *  dst (0xffff888080a00000): xx.. ..xx
+ *  dst origins:              o111 0000
+ *                        (or 0000 o222)
+ *
+ * (here . stands for an initialized byte, and x for an uninitialized one.
+ *
+ * Ensure that this does not happen anymore, and for both destination bytes
+ * the origin is nonzero (i.e. KMSAN reports an error).
+ */
+static void test_memcpy_initialized_gap(struct kunit *test)
+{
+	EXPECTATION_UNINIT_VALUE_FN(expect, "test_memcpy_initialized_gap");
+	volatile char uninit_src[12];
+	volatile char dst[8] = { 0 };
+
+	kunit_info(
+		test,
+		"unaligned 4-byte initialized value gets a nonzero origin after memcpy() - (2 UMR reports)\n");
+
+	uninit_src[0] = 42;
+	uninit_src[1] = 42;
+	uninit_src[4] = 42;
+	uninit_src[5] = 42;
+	uninit_src[6] = 42;
+	uninit_src[7] = 42;
+	uninit_src[10] = 42;
+	uninit_src[11] = 42;
+	memcpy_noinline((void *)&dst[0], (void *)&uninit_src[2], 8);
+
+	kmsan_check_memory((void *)&dst[0], 4);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+	report_reset();
+	kmsan_check_memory((void *)&dst[2], 4);
+	KUNIT_EXPECT_FALSE(test, report_matches(&expect));
+	report_reset();
+	kmsan_check_memory((void *)&dst[4], 4);
+	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
+}
+
 /* Generate test cases for memset16(), memset32(), memset64(). */
 #define DEFINE_TEST_MEMSETXX(size)                                          \
 	static void test_memset##size(struct kunit *test)                   \
@@ -579,6 +631,7 @@ static struct kunit_case kmsan_test_cases[] = {
 	KUNIT_CASE(test_init_memcpy),
 	KUNIT_CASE(test_memcpy_aligned_to_aligned),
 	KUNIT_CASE(test_memcpy_aligned_to_unaligned),
+	KUNIT_CASE(test_memcpy_initialized_gap),
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
 	KUNIT_CASE(test_memset64),
-- 
2.42.0.283.g2d96d420d3-goog

