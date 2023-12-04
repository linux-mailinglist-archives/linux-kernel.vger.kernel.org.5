Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85CF80419B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbjLDWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbjLDWTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:19:35 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EC3FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:19:41 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5caf86963ecso69992787b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701728381; x=1702333181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCQtNmXpvtLNOrtNSc8AW+fCSTy7TRIqx1fWXO6kAs=;
        b=ZKGiKz/m9hGw7LczcQpuxT3EhjjjO87Nzy4G/3By6FqipWn8u12Tz3dkSc1CykkjZL
         BD86sdoNv+tqPoKuvlGV3YAPB0vumPi6mhXTcXzIocbIMt49cXIAGnnv0KF5wS/NeQYT
         IJxkUvLFPPj2Xu25KNXnxasSi67aTnhlMyI7K48B+8zleccPh+GdSY4KwUGEwKfKdNXR
         OsRgY5db7IMr3i1EIKLBkWdE0akV03KeZcVy0VCRSlWu2xK+3kIMgQeFpvHjWdPLbUFg
         nEB7FxCTvYGGU3VuzQ/LGz7mb7tJYPS1KVIiWv1J3iD8P1PsUGV1HYJxUmhtW7SnpMAe
         2FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728381; x=1702333181;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcCQtNmXpvtLNOrtNSc8AW+fCSTy7TRIqx1fWXO6kAs=;
        b=uTp3pGoE03TxP9hRUzhGURG7NvYYvkSfyASrG7tEeb05mmd2OM89fMdQnZEKGHBURQ
         /8onFRZh2LIj1gKRD+vQK905fvuah1NcEf45SHzR0uBgyZ2WPgywoS9HEc9XQwWGSSLF
         devhq+uw66nrRzgubB3ABxT5+Ek9/GkTvlqBJanvR8XvqCKfiwrp2IQH5qqYasAYh8O5
         d7vNpnzCQ4EQcXXVnlbopLi6e7Rk8qU1gPIWq18/fgtrVj0Yc/fbehKMZnayd6kvGgm0
         BezunbWQcqM9EwRdKyB2Os0b6Ji4pe+J+NAcWz0bHXn2JoOJKmaAaBdYSbKrosumA9xL
         Y7dA==
X-Gm-Message-State: AOJu0YwfB8/lSD1CejAHKJqxTW9UKUJ6AKmqRzepYA7aRu/fqVgEYpHQ
        Xs9OZ8soDYo5JiycULCAK/3asTM3VA==
X-Google-Smtp-Source: AGHT+IFEt3AEceWIxqns4ZzJfYejgTDzoUUTYAgBnKLjQfaNWDnwUkVOcY3Scc+JgzZPWiTKdUHhbNE0uA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:687:0:b0:db4:5e66:4a05 with SMTP id
 129-20020a250687000000b00db45e664a05mr949795ybg.2.1701728381191; Mon, 04 Dec
 2023 14:19:41 -0800 (PST)
Date:   Mon,  4 Dec 2023 22:19:28 +0000
In-Reply-To: <20231204221932.1465004-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204221932.1465004-3-rmoar@google.com>
Subject: [PATCH v3 3/6] kunit: add example suite to test init suites
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev, sadiyakazi@google.com
Cc:     keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..262a68a59800 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -287,4 +287,33 @@ static struct kunit_suite example_test_suite = {
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
+static struct kunit_case example_init_test_cases[] = {
+	KUNIT_CASE(example_init_test),
+	{}
+};
+
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
2.43.0.rc2.451.g8631bc7472-goog

