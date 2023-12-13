Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1481072B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378072AbjLMBCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378076AbjLMBCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:02:13 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67027D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5e2677b9d3dso8609747b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429337; x=1703034137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=HrZF9X5YmvD0GskdZCZQpePwImD3tsPLvsOosEn2DDBbrl4XjLQEBLzeKmtRHiKvX5
         dyeZHJBuemQ/bCbdoXpdFjaQWnGh4xWXxbSS14vLrDNSeg7I0TtLruqHMjKtiv4MquiE
         4nM2n91CYSxUfziR1Q+K3UGkpfUvmfDBaIrP+uJmSxjjOnDP5V3TrlaMSuVYinIn2drJ
         DKfVsJ44V80B2DmAj55XqXOaZb4DvQ6//C3RecfrA7Dt8LDtJ3oQNuMf4kPNmp+3wd73
         moVa3uZKIop4xYIfblTX2nUM/h6IoKB0dky9frLonJdC5oQ2l6TuLLfzrraZtflN31Na
         cHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429337; x=1703034137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E22eCM3LpsQRbUKK8mf1gNlUuS672sImUrgswyDx+34=;
        b=ZcO6auSevcVgn6yt88/BqDdyiJeLbm52veWD8b29mASBfWRslvL165TK0NfZdZBy8M
         Cw7foeRF+Wid9dgOTMEjUIz1fG27GTICd9oYjOqMeZwNC6VvOxmen/ME7z1Oh+KHE+Au
         cTBP6wNhH+aU+KBfC6hQ17qWjwKKQXVhrFkxLn3AX71T2kfle37BmnIPAgebaGQRR3hK
         oNrndZDUHLBUP1JrXpbrbfcz2DI+aFx2forbgtMI2g3L2jmvOiLjjC30/m8oJkiSsuoJ
         UkrCyYQ5r1umCyKOgbKB16xsuEu2PtJlAKEpvjYTuGbYrVS26UXIWM491MGdqgHhlRb1
         M7VA==
X-Gm-Message-State: AOJu0YznRkthddJ9iIRIJyXzV5yF/qM/V799bPRcvxML0lBnLoKY8H+L
        jrCghbaG/uZraRJ2vsfhRagBxaW3fw==
X-Google-Smtp-Source: AGHT+IGltObfsdg01UYA5d4+n+6B+G0+b86q4J7GB+VeEGumubgZh3WUZ1xvjp8dhZKDMCUJj4j1VIDHfQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:4b1:b0:dbc:bfb7:1f48 with SMTP id
 r17-20020a05690204b100b00dbcbfb71f48mr7176ybs.9.1702429337531; Tue, 12 Dec
 2023 17:02:17 -0800 (PST)
Date:   Wed, 13 Dec 2023 01:01:58 +0000
In-Reply-To: <20231213010201.1802507-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231213010201.1802507-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-3-rmoar@google.com>
Subject: [PATCH v4 3/6] kunit: add example suite to test init suites
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add example_init_test_suite to allow for testing the feature of running
test suites marked as init to indicate they use init data and/or
functions.

This suite should always pass and uses a simple init function.

This suite can also be used to test the is_init attribute introduced in
the next patch.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- I ended up not changing anything as adding __init to the test gave
  a build warning. It did still work so I could add it back if wanted.

 lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..18495778de7c 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -287,4 +287,41 @@ static struct kunit_suite example_test_suite = {
  */
 kunit_test_suites(&example_test_suite);
 
+static int __init init_add(int x, int y)
+{
+	return (x + y);
+}
+
+/*
+ * This test should always pass. Can be used to test init suites.
+ */
+static void example_init_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
+}
+
+/*
+ * The kunit_case struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_case example_init_test_cases[] = {
+	KUNIT_CASE(example_init_test),
+	{}
+};
+
+/*
+ * The kunit_suite struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_suite example_init_test_suite = {
+	.name = "example_init",
+	.test_cases = example_init_test_cases,
+};
+
+/*
+ * This registers the test suite and marks the suite as using init data
+ * and/or functions.
+ */
+kunit_test_init_section_suites(&example_init_test_suite);
+
 MODULE_LICENSE("GPL v2");
-- 
2.43.0.472.g3155946c3a-goog

