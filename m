Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462CB78D105
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbjH3AWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236383AbjH3AVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:21:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8432CC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:21:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d74829dd58fso5869971276.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693354895; x=1693959695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WME0Ze+ifFaCbrf4pzxhX55YR+juKZdsW7/o/oy5q0k=;
        b=y8quO5lllfzlZGcKwGqxOV5I9stXyiKbJPccMoAVHDYj03EobaTUcG1Vb4xRDLCxMO
         OIgoYB9ktpZowlKqI4Wvtsk0eBoSgrnJvqPRWkbg6FClX7uFwta9nk8q7iVJ1OJTJRJx
         Zm39mufGuQ9gyaXJryN8ONYpv9eBX6TNfQQoGytQWjmig++yA260T5QzzKeMHEUP4lt+
         fCbdfO6KLuERtCYzDsSzqf+CDj867+mZcZhxAKx3d3v56JAxwHf3Q/oNSpci0JSOgGN4
         3Fdh3RRO0YmgWuMEmOARKNCNj7SIwmNKj8UnfgCDY1d0GiREMGMD8j2whRkQGpofMORP
         k7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693354895; x=1693959695;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WME0Ze+ifFaCbrf4pzxhX55YR+juKZdsW7/o/oy5q0k=;
        b=RIlTzkZwoLr+5Kh3CsLL+gnYZIiCJ22nChPUf9ka0R9vrJjJZYpxo1hmoIMDgGWcCQ
         wAg+d12ImLHj1K13EajU/UrzlbYbimB+VOJnXZ72UKoVeBBBSD36mc8jUTTKqrADL38m
         m7xSx+u2p1dyJD5eLVLyfQIw8j6mplQowikOIr4chRe01IkOCB74gNJLluSyy6B2h6M/
         eCIseh3TqUmn8CHuEqXxTOrVKOH5r1Zwkp6TjfbydaULsd9iuDUTdOQojacDRY2PL5k2
         w7S5nFDHN3mhT8sHBl9sT2EVdUDf77NxOCEU8asIKfRd++TSoNYp5Nu/uBWwBxWGjJom
         C0OA==
X-Gm-Message-State: AOJu0YzbYGnhnZ1c3CHikkDFZ3lcX7cZ/2JYxLyFOqJyIvWpJ/RxOqO5
        dqV8u3CaXgitgN9Po0Fa6W0bGmp1QJ6QOQ==
X-Google-Smtp-Source: AGHT+IGJmzX2TfHubw3EZ/rAHp1W6ncpiGu7wRHuL61OO2aYXO8SzIQTL3UsdLsq+Un71/uvbyPbZqGaonDW0w==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:dbce:0:b0:c15:cbd1:60da with SMTP id
 g197-20020a25dbce000000b00c15cbd160damr18870ybf.6.1693354895079; Tue, 29 Aug
 2023 17:21:35 -0700 (PDT)
Date:   Wed, 30 Aug 2023 08:21:15 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230830002116.3768675-1-davidgow@google.com>
Subject: [PATCH] kunit: test: Make filter strings in executor_test writable
From:   David Gow <davidgow@google.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>, Guenter Roeck <linux@roeck-us.net>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit's attribute filtering feature needs the filter strings passed in
to be writable, as it modifies them in-place during parsing. This works
for the filters passed on the kernel command line, but the string
literals used in the executor tests are at least theoretically read-only
(though they work on x86_64 for some reason). s390 wasn't fooled, and
crashed when these tests were run.

Use a 'char[]' instead, (and make an explicit variable for the current
filter in parse_filter_attr_test), which will store the string in a
writable segment.

Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
Closes: https://lore.kernel.org/linux-kselftest/55950256-c00a-4d21-a2c0-cf9f0e5b8a9a@roeck-us.net/
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/executor_test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 4084071d0eb5..b4f6f96b2844 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -119,7 +119,7 @@ static void parse_filter_attr_test(struct kunit *test)
 {
 	int j, filter_count;
 	struct kunit_attr_filter *parsed_filters;
-	char *filters = "speed>slow, module!=example";
+	char filters[] = "speed>slow, module!=example", *filter = filters;
 	int err = 0;
 
 	filter_count = kunit_get_filter_count(filters);
@@ -128,7 +128,7 @@ static void parse_filter_attr_test(struct kunit *test)
 	parsed_filters = kunit_kcalloc(test, filter_count, sizeof(*parsed_filters),
 			GFP_KERNEL);
 	for (j = 0; j < filter_count; j++) {
-		parsed_filters[j] = kunit_next_attr_filter(&filters, &err);
+		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
 		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
 	}
 
@@ -154,6 +154,7 @@ static void filter_attr_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[2],
 	};
 	struct kunit_suite_set got;
+	char filter[] = "speed>slow";
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "normal_suite", dummy_attr_test_cases);
@@ -168,7 +169,7 @@ static void filter_attr_test(struct kunit *test)
 	 * attribute is unset and thus, the filtering is based on the parent attribute
 	 * of slow.
 	 */
-	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", NULL, &err);
+	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
@@ -191,12 +192,13 @@ static void filter_attr_empty_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[2],
 	};
 	struct kunit_suite_set got;
+	char filter[] = "module!=dummy";
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite1", dummy_attr_test_cases);
 	subsuite[1] = alloc_fake_suite(test, "suite2", dummy_attr_test_cases);
 
-	got = kunit_filter_suites(&suite_set, NULL, "module!=dummy", NULL, &err);
+	got = kunit_filter_suites(&suite_set, NULL, filter, NULL, &err);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start); /* just in case */
 
@@ -211,12 +213,13 @@ static void filter_attr_skip_test(struct kunit *test)
 		.start = subsuite, .end = &subsuite[1],
 	};
 	struct kunit_suite_set got;
+	char filter[] = "speed>slow";
 	int err = 0;
 
 	subsuite[0] = alloc_fake_suite(test, "suite", dummy_attr_test_cases);
 
 	/* Want: suite(slow, normal), NULL -> suite(slow with SKIP, normal), NULL */
-	got = kunit_filter_suites(&suite_set, NULL, "speed>slow", "skip", &err);
+	got = kunit_filter_suites(&suite_set, NULL, filter, "skip", &err);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
 	KUNIT_ASSERT_EQ(test, err, 0);
 	kfree_at_end(test, got.start);
-- 
2.42.0.283.g2d96d420d3-goog

