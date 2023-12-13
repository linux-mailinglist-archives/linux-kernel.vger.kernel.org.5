Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68392811F32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378606AbjLMTob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjLMTo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:44:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D6EB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db7dd9a8bd6so7725195276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496671; x=1703101471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hSasRIKjsrxTOhDGdGR7YDY76bvspnnAtaoJj5GZ1CU=;
        b=J64rz6hm8t+wrgbJf9JO/yMgfnUZr/TcbVocrNbW93qTBCT8Zuo61B9xT7Mwj5J0qc
         5/J+Trw1cMrTo9L/gEcp4zxln4sIuhyeg4kjLkLIYF1ZLmUFjoQCNl/1h/mS2LU8A9Sg
         3MrQw7hU/kZ9LxNtlLd7fQpxc2Y8biu/eJfjnJbPqzKx6tKx7/2NskTJGfsn3s8FPBCr
         XtUyxOxv4dEZG4szdAA7G+c04YlYkcv51CreMwAo3JwR26HAzMkoybXW3gGBW4Iy/kSh
         vKJX79A77hUHsnGyvJlhxU0So12pwp4JkQzYarOrmodwDK2Nvv84hUIFaT10OEino4LO
         7zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496671; x=1703101471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSasRIKjsrxTOhDGdGR7YDY76bvspnnAtaoJj5GZ1CU=;
        b=KLd4O9+vVlzYPTAABVHD43LUmj0U1Wat20TD0LSLKZQOloxHPfQg7ynFiTkNyRM/Jv
         vSSg9ne8Oasek7VCMfppQUoOittfZNDjnYLPpNsgcJp+3K5Mc8uhtlitngx74gvDGHyh
         meigc41RcC4uEDA2HRDRiPNbrIjv5NaNx46RHtE5WR3XqMdohZtnZZR18XeuElAx2V+s
         5o2VdIBqcPoqRuNM7zDyvL9sXZTHEkFVAToyopuAs7NnU6nT/Kfhtx91RMsqq4PU1lnU
         j9wD3thQC648hU9Ah/nP/q1wGh3nyk6z/FBVTD96viis9VCgVX+Pm8I7wqNxeT0rXaJg
         ki4Q==
X-Gm-Message-State: AOJu0Yzyw6UtUdX97YrB89P8TObOIx2jSvycVU1uYTpe4qMvz0Ieqe+Z
        qEvA3ZyCGAQ7gwi2wNNpdH0I7fqduA==
X-Google-Smtp-Source: AGHT+IFcVvSBccWJoQy13WMx3m6+GFYC5e8qqX0/Qfg0ZBRVrVubmi4U5od99Pkg2fJbBPb7E0ZO/sdi5Q==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ada8:0:b0:dbc:d104:51de with SMTP id
 z40-20020a25ada8000000b00dbcd10451demr28117ybi.3.1702496671557; Wed, 13 Dec
 2023 11:44:31 -0800 (PST)
Date:   Wed, 13 Dec 2023 19:44:18 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-3-rmoar@google.com>
Subject: [PATCH v5 3/6] kunit: add example suite to test init suites
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
Changes since v4:
- Mark test as __init and then set cases as __refdata to supress modpost
  warnings

 lib/kunit/kunit-example-test.c | 37 ++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 6bb5c2ef6696..d2f7a3c62c18 100644
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
+static void __init example_init_test(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, init_add(1, 1), 2);
+}
+
+/*
+ * The kunit_case struct cannot be marked as __initdata as this will be
+ * used in debugfs to retrieve results after test has run
+ */
+static struct kunit_case __refdata example_init_test_cases[] = {
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

