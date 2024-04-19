Return-Path: <linux-kernel+bounces-150972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CC48AA74C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219131C20B81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186999473;
	Fri, 19 Apr 2024 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ms41cOTN"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D688F62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497846; cv=none; b=igTHsVWCkRsTZjU4kQ/gvwqf602ThqmSXcQAOCyg4uVow+Kv+IJf7U0lb/ullPATP33Eeo1qEbqDn2sqk1z0c3jSlbv80IDybD5V5kO8Ijd/o+XnrEISR8aJnGJnZ9620qq9LjX5Bttan4uGwJfR+5slHuuuD2jmYVz3cvTBSiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497846; c=relaxed/simple;
	bh=PEBdCbx0TjpoU0qRyR9UgNO+bd7GgOVxy4bZVZgDXkw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YDImUnfpmV2Iwztdu2CDNa43npMMrf0QzlxJqV9g3woXfQd5d8fRReZiJkB3LaZbiN3feVmwhNqEYN3fAzPxkUEv8iU55ise5cZn8oSK5fRuKg83afOTwHj+0/tLNpae8huAW4CQRfRIdhyQ9d4EwaTJBV0wip65L1w+GMeN8B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ms41cOTN; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713497841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5AmqXUxi9Y+6QSsEj5aL6VD5dyVy7rAJhd6FAkfGgzQ=;
	b=Ms41cOTNaXBNVM03WIl0ljPNq+cBbcelVT1YAfzDTvfY7jusI7C2mqSFMRlY0ra3SNF7NE
	rtzq1AUuQQVuRNeDAB6lL8mFRP7E/4Otb7eQmi9PF0Qak172EiV8IAi5eeOMSR620EMMs0
	ZQ9ayv2bprYRuCKeIlXB7x3BCv52mVI=
From: Wen Yang <wen.yang@linux.dev>
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array
Date: Fri, 19 Apr 2024 11:36:39 +0800
Message-Id: <20240419033639.259471-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Move boundary checking for proc_dou8ved_minmax into module loading, thereby
reporting errors in advance. And add a kunit test case ensuring the
boundary check is done correctly.

The boundary check in proc_dou8vec_minmax done to the extra elements in
the ctl_table struct is currently performed at runtime. This allows buggy
kernel modules to be loaded normally without any errors only to fail
when used.

This is a buggy example module:
	#include <linux/kernel.h>
	#include <linux/module.h>
	#include <linux/sysctl.h>

	static struct ctl_table_header *_table_header = NULL;
	static unsigned char _data = 0;
	struct ctl_table table[] = {
		{
			.procname       = "foo",
			.data           = &_data,
			.maxlen         = sizeof(u8),
			.mode           = 0644,
			.proc_handler   = proc_dou8vec_minmax,
			.extra1         = SYSCTL_ZERO,
			.extra2         = SYSCTL_ONE_THOUSAND,
		},
	};

	static int init_demo(void) {
		_table_header = register_sysctl("kernel", table);
		if (!_table_header)
			return -ENOMEM;

		return 0;
	}

	module_init(init_demo);
	MODULE_LICENSE("GPL");

And this is the result:
        # insmod test.ko
        # cat /proc/sys/kernel/foo
        cat: /proc/sys/kernel/foo: Invalid argument

Suggested-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
v4: 
- commit log: move the text describing what was done to the top.
- commit log: rework the buggy example module
- proc_sysctl.c: print error messages that can indicate this specific issue
- sysctl.c: leave as (unsigned int *)
v3: 
- kunit: using register_sysctl, and thus unnecessary sentries were removed
- kunit: using constant ctl_tables
v2:
- kunit: detect registration failure with KUNIT_EXPECT_NULL

 fs/proc/proc_sysctl.c | 14 +++++++++++++
 kernel/sysctl-test.c  | 49 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sysctl.c       | 10 ++-------
 3 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b1c2c0b82116..62d80f4d77d5 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1093,6 +1093,7 @@ static int sysctl_err(const char *path, struct ctl_table *table, char *fmt, ...)
 
 static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 {
+	unsigned int extra;
 	int err = 0;
 
 	if ((table->proc_handler == proc_douintvec) ||
@@ -1104,6 +1105,19 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	if (table->proc_handler == proc_dou8vec_minmax) {
 		if (table->maxlen != sizeof(u8))
 			err |= sysctl_err(path, table, "array not allowed");
+
+		if (table->extra1) {
+			extra = *(unsigned int *) table->extra1;
+			if (extra > 255U)
+				err |= sysctl_err(path, table,
+						"range value too large for proc_dou8vec_minmax");
+		}
+		if (table->extra2) {
+			extra = *(unsigned int *) table->extra2;
+			if (extra > 255U)
+				err |= sysctl_err(path, table,
+						"range value too large for proc_dou8vec_minmax");
+		}
 	}
 
 	if (table->proc_handler == proc_dobool) {
diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 6ef887c19c48..4e7dcc9187e2 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -367,6 +367,54 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 	KUNIT_EXPECT_EQ(test, 0, *((int *)table.data));
 }
 
+/*
+ * Test that registering an invalid extra value is not allowed.
+ */
+static void sysctl_test_register_sysctl_sz_invalid_extra_value(
+		struct kunit *test)
+{
+	unsigned char data = 0;
+	struct ctl_table table_foo[] = {
+		{
+			.procname	= "foo",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_FOUR,
+			.extra2		= SYSCTL_ONE_THOUSAND,
+		},
+	};
+
+	struct ctl_table table_bar[] = {
+		{
+			.procname	= "bar",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_NEG_ONE,
+			.extra2		= SYSCTL_ONE_HUNDRED,
+		},
+	};
+
+	struct ctl_table table_qux[] = {
+		{
+			.procname	= "qux",
+			.data		= &data,
+			.maxlen		= sizeof(u8),
+			.mode		= 0644,
+			.proc_handler	= proc_dou8vec_minmax,
+			.extra1		= SYSCTL_ZERO,
+			.extra2		= SYSCTL_TWO_HUNDRED,
+		},
+	};
+
+	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
+	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
+	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
+}
+
 static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_api_dointvec_null_tbl_data),
 	KUNIT_CASE(sysctl_test_api_dointvec_table_maxlen_unset),
@@ -378,6 +426,7 @@ static struct kunit_case sysctl_test_cases[] = {
 	KUNIT_CASE(sysctl_test_dointvec_write_happy_single_negative),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_less_int_min),
 	KUNIT_CASE(sysctl_test_api_dointvec_write_single_greater_int_max),
+	KUNIT_CASE(sysctl_test_register_sysctl_sz_invalid_extra_value),
 	{}
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index e0b917328cf9..c0a1164eaf59 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -977,16 +977,10 @@ int proc_dou8vec_minmax(struct ctl_table *table, int write,
 	if (table->maxlen != sizeof(u8))
 		return -EINVAL;
 
-	if (table->extra1) {
+	if (table->extra1)
 		min = *(unsigned int *) table->extra1;
-		if (min > 255U)
-			return -EINVAL;
-	}
-	if (table->extra2) {
+	if (table->extra2)
 		max = *(unsigned int *) table->extra2;
-		if (max > 255U)
-			return -EINVAL;
-	}
 
 	tmp = *table;
 
-- 
2.25.1


