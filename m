Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4948811F38
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377947AbjLMTod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378858AbjLMTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:44:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358E5F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db5416d0fccso5016474276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496673; x=1703101473; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7slFoawBCWkwzVSxACwTipDmNbMlYPdhOIzkAqH/aFw=;
        b=uNVPlWMr+Ahy/amoC39Sf5szLLwYzyOXxFBpwDI1N93AQEE1r4tL7KJUbF/aOipRsg
         cGY0zoNyX2H1G1E6+Wb5ZVjaCU3zjZyt84/xNVvKoS76CEpNov2kWuPqh+m3PZnMXXfa
         VRvyi7YRfNa07k9rLGg4e1KVoK3ggj0fDs/dPIOlh2DonBjwa+WpcNqo7Lj8D1I5IQfu
         UCZzFXlG0aFDMPoXtAhSLJV065Bom+ziG/LHPGWoNLtVtPm1/91aFBE2kUnrLP2oMjG7
         c/rn7Eqx0WyDa3JmddT6+KzX+AMax+z2eVRUEO4SJNzVfhTG4SLFZ1IgJkReeWdTXUeK
         PMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496673; x=1703101473;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7slFoawBCWkwzVSxACwTipDmNbMlYPdhOIzkAqH/aFw=;
        b=JhnVL9SIAikn0PS8pN1x8YlqjJLgmdwTCUjG7ZOmf9y2VOa/AuGUEVBqQHaiXZzY38
         KX7GeGMgxvr0SJs2rHvP7o+1H0aQHZkU+/e9xxEQun5b8aXVCX1zc7je6BWgPWujDiSl
         3+GXnAsuYHABpfcF1YEu4Z/hVpaHRPpXaXVVYZkqMHItBUikxZdBxXbHmnfFO/cYqm+O
         V4OwZIKzwDGzwhARXE0WWgWzazgarnrJaQFLIm9SnrRb5CHvyy4Teby4VXA5z1LT+dlj
         XhZeC3lNwxCEHmSRWElyo6r4225yI8FegwWTw/nnMSQE2vFhIjOfOb1MgcIwyDlXkNZw
         FKWA==
X-Gm-Message-State: AOJu0YyNaFgksUzyH6TdfYrkGygK6awmAsU6URmU+DvLK7tsJ4B40x5B
        rAYfj15FZ+vwIt4Hh3b01n8hKD4cQA==
X-Google-Smtp-Source: AGHT+IF9ad/J/uSSD1qUN7zly9T8SGdMfHHvTDpxfYMPa9v+aOBcNTJrZmczyJwsCd+j/YbaPbNKoTsJzw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a5b:787:0:b0:d9c:801c:4230 with SMTP id
 b7-20020a5b0787000000b00d9c801c4230mr84320ybq.5.1702496673391; Wed, 13 Dec
 2023 11:44:33 -0800 (PST)
Date:   Wed, 13 Dec 2023 19:44:19 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-4-rmoar@google.com>
Subject: [PATCH v5 4/6] kunit: add is_init test attribute
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

Add is_init test attribute of type bool. Add to_string, get, and filter
methods to lib/kunit/attributes.c.

Mark each of the tests in the init section with the is_init=true attribute.

Add is_init to the attributes documentation.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 .../dev-tools/kunit/running_tips.rst          |  7 +++
 include/kunit/test.h                          |  1 +
 lib/kunit/attributes.c                        | 60 +++++++++++++++++++
 lib/kunit/executor.c                          |  6 +-
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 766f9cdea0fa..024e9ad1d1e9 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -428,3 +428,10 @@ This attribute indicates the name of the module associated with the test.
 
 This attribute is automatically saved as a string and is printed for each suite.
 Tests can also be filtered using this attribute.
+
+``is_init``
+
+This attribute indicates whether the test uses init data or functions.
+
+This attribute is automatically saved as a boolean and tests can also be
+filtered using this attribute.
diff --git a/include/kunit/test.h b/include/kunit/test.h
index fe79cd736e94..b163b9984b33 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -253,6 +253,7 @@ struct kunit_suite {
 	struct dentry *debugfs;
 	struct string_stream *log;
 	int suite_init_err;
+	bool is_init;
 };
 
 /* Stores an array of suites, end points one past the end */
diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 1b512f7e1838..2cf04cc09372 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -58,6 +58,16 @@ static const char *attr_enum_to_string(void *attr, const char * const str_list[]
 	return str_list[val];
 }
 
+static const char *attr_bool_to_string(void *attr, bool *to_free)
+{
+	bool val = (bool)attr;
+
+	*to_free = false;
+	if (val)
+		return "true";
+	return "false";
+}
+
 static const char *attr_speed_to_string(void *attr, bool *to_free)
 {
 	return attr_enum_to_string(attr, speed_str_list, to_free);
@@ -166,6 +176,37 @@ static int attr_string_filter(void *attr, const char *input, int *err)
 	return false;
 }
 
+static int attr_bool_filter(void *attr, const char *input, int *err)
+{
+	int i, input_int = -1;
+	long val = (long)attr;
+	const char *input_str = NULL;
+
+	for (i = 0; input[i]; i++) {
+		if (!strchr(op_list, input[i])) {
+			input_str = input + i;
+			break;
+		}
+	}
+
+	if (!input_str) {
+		*err = -EINVAL;
+		pr_err("kunit executor: filter value not found: %s\n", input);
+		return false;
+	}
+
+	if (!strcmp(input_str, "true"))
+		input_int = (int)true;
+	else if (!strcmp(input_str, "false"))
+		input_int = (int)false;
+	else {
+		*err = -EINVAL;
+		pr_err("kunit executor: invalid filter input: %s\n", input);
+		return false;
+	}
+
+	return int_filter(val, input, input_int, err);
+}
 
 /* Get Attribute Methods */
 
@@ -194,6 +235,17 @@ static void *attr_module_get(void *test_or_suite, bool is_test)
 		return (void *) "";
 }
 
+static void *attr_is_init_get(void *test_or_suite, bool is_test)
+{
+	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
+	struct kunit_case *test = is_test ? test_or_suite : NULL;
+
+	if (test)
+		return ((void *) NULL);
+	else
+		return ((void *) suite->is_init);
+}
+
 /* List of all Test Attributes */
 
 static struct kunit_attr kunit_attr_list[] = {
@@ -212,6 +264,14 @@ static struct kunit_attr kunit_attr_list[] = {
 		.filter = attr_string_filter,
 		.attr_default = (void *)"",
 		.print = PRINT_SUITE,
+	},
+	{
+		.name = "is_init",
+		.get_attr = attr_is_init_get,
+		.to_string = attr_bool_to_string,
+		.filter = attr_bool_filter,
+		.attr_default = (void *)false,
+		.print = PRINT_SUITE,
 	}
 };
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 847329c51e91..717b9599036b 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -300,6 +300,7 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	struct kunit_suite_set total_suite_set = {NULL, NULL};
 	struct kunit_suite **total_suite_start = NULL;
 	size_t init_num_suites, num_suites, suite_size;
+	int i = 0;
 
 	init_num_suites = init_suite_set.end - init_suite_set.start;
 	num_suites = suite_set.end - suite_set.start;
@@ -310,8 +311,11 @@ struct kunit_suite_set kunit_merge_suite_sets(struct kunit_suite_set init_suite_
 	if (!total_suite_start)
 		return total_suite_set;
 
-	/* Append init suites and then all other kunit suites */
+	/* Append and mark init suites and then append all other kunit suites */
 	memcpy(total_suite_start, init_suite_set.start, init_num_suites * suite_size);
+	for (i = 0; i < init_num_suites; i++)
+		total_suite_start[i]->is_init = true;
+
 	memcpy(total_suite_start + init_num_suites, suite_set.start, num_suites * suite_size);
 
 	/* Set kunit suite set start and end */
-- 
2.43.0.472.g3155946c3a-goog

