Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D9C811F39
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379256AbjLMToh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378325AbjLMToa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:44:30 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B19410B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:36 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5ca26c07848so83490237b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702496675; x=1703101475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tncFbKtMEfDV232Jf8Udjxo5BkNQcKRErRNc1mfng=;
        b=EExTdg2wHWobqRKaLEUMOtQz6feP3N2A+c/9riOiNMnyLFl1Yx7YnbxmrvjoKGsJti
         A5cpxYa5v+rKqn7i6d79SHkkcKjVAMxx1RxgMlXQV3DOAGFZPDypgZizkq6e2v0JtdrD
         gwsHuVxymRpEdG2HQ57NRw0r3XUJhU3dbjSBC6RmObw7hqsRbNx/UY2yJXa+F970S6+Z
         7ubQaRNyLF7Y3TgNAjxw46+Pvdp5Xp7UFTo5fqAy3286jz5wNkODa393tKN0pa+qR6zF
         PiqXulLx6foMpBB3pMiD6B0DX7wdblbT1UUOL77EGAPvpCgaTiiFreVxBqG1V3sp+dtR
         vUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702496675; x=1703101475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tncFbKtMEfDV232Jf8Udjxo5BkNQcKRErRNc1mfng=;
        b=w60Q+K+e80f/18fTiLk9tGd73E6SiOUAUPxsW0yyGj64Fjv+g1jugpH0WZfrEvY6BY
         +AknRhemMLoQvjw/hVq3cRGO71Rp4nwI2wohX1cMsty1sz1UTf2gbswqZV0aG8oaocLA
         IgBbKKa9pCho9fD/GXkxseIS22dajT7GLglrRRyvrAztuXjnGGU2zj0gF9dhTl77EE4g
         SrKCSKenZn6ReNOMsWCF8oAIMesqrZU+hQ+rRt5zEuwSjpXjAs4rOnGgK2W/XHNLe6Hg
         jEHPKfurE2NC+AgpWOrzmXMifVIOnTfjpQ12uPA5m62101R0up/LjZyNRhjMvUySbUtD
         OJYQ==
X-Gm-Message-State: AOJu0YyvEbFBJBOO80hadclHhRZACJUPzVqGANSk5bwkqJO2uJw2oxz4
        i37cEOq7Y2GgPnepihVk1Xj74+MdJw==
X-Google-Smtp-Source: AGHT+IGIGpvW5Hth/xS09Z3Wm6iVTz9ZW3JUyPaVJIlkAwr02Gz0pNUos512zjOZrZQLcMeYXah2urnH8Q==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:4d0:b0:dbc:b226:bd23 with SMTP id
 v16-20020a05690204d000b00dbcb226bd23mr50429ybs.0.1702496675240; Wed, 13 Dec
 2023 11:44:35 -0800 (PST)
Date:   Wed, 13 Dec 2023 19:44:20 +0000
In-Reply-To: <20231213194421.2031671-1-rmoar@google.com>
Mime-Version: 1.0
References: <20231213194421.2031671-1-rmoar@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213194421.2031671-5-rmoar@google.com>
Subject: [PATCH v5 5/6] kunit: add ability to run tests after boot using debugfs
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

Add functionality to run built-in tests after boot by writing to a
debugfs file.

Add a new debugfs file labeled "run" for each test suite to use for
this purpose.

As an example, write to the file using the following:

echo "any string" > /sys/kernel/debugfs/kunit/<testsuite>/run

This will trigger the test suite to run and will print results to the
kernel log.

To guard against running tests concurrently with this feature, add a
mutex lock around running kunit. This supports the current practice of
not allowing tests to be run concurrently on the same kernel.

This new functionality could be used to design a parameter
injection feature in the future.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/debugfs.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
 lib/kunit/test.c    | 10 +++++++
 2 files changed, 78 insertions(+)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 382706dfb47d..d548750a325a 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -8,12 +8,14 @@
 #include <linux/module.h>
 
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "string-stream.h"
 #include "debugfs.h"
 
 #define KUNIT_DEBUGFS_ROOT             "kunit"
 #define KUNIT_DEBUGFS_RESULTS          "results"
+#define KUNIT_DEBUGFS_RUN              "run"
 
 /*
  * Create a debugfs representation of test suites:
@@ -21,6 +23,8 @@
  * Path						Semantics
  * /sys/kernel/debug/kunit/<testsuite>/results	Show results of last run for
  *						testsuite
+ * /sys/kernel/debug/kunit/<testsuite>/run	Write to this file to trigger
+ *						testsuite to run
  *
  */
 
@@ -101,6 +105,51 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
 	return single_open(file, debugfs_print_results, suite);
 }
 
+/*
+ * Print a usage message to the debugfs "run" file
+ * (/sys/kernel/debug/kunit/<testsuite>/run) if opened.
+ */
+static int debugfs_print_run(struct seq_file *seq, void *v)
+{
+	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
+
+	seq_puts(seq, "Write to this file to trigger the test suite to run.\n");
+	seq_printf(seq, "usage: echo \"any string\" > /sys/kernel/debugfs/kunit/%s/run\n",
+			suite->name);
+	return 0;
+}
+
+/*
+ * The debugfs "run" file (/sys/kernel/debug/kunit/<testsuite>/run)
+ * contains no information. Write to the file to trigger the test suite
+ * to run.
+ */
+static int debugfs_run_open(struct inode *inode, struct file *file)
+{
+	struct kunit_suite *suite;
+
+	suite = (struct kunit_suite *)inode->i_private;
+
+	return single_open(file, debugfs_print_run, suite);
+}
+
+/*
+ * Trigger a test suite to run by writing to the suite's "run" debugfs
+ * file found at: /sys/kernel/debug/kunit/<testsuite>/run
+ *
+ * Note: what is written to this file will not be saved.
+ */
+static ssize_t debugfs_run(struct file *file,
+		const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct inode *f_inode = file->f_inode;
+	struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
+
+	__kunit_test_suites_init(&suite, 1);
+
+	return count;
+}
+
 static const struct file_operations debugfs_results_fops = {
 	.open = debugfs_results_open,
 	.read = seq_read,
@@ -108,11 +157,23 @@ static const struct file_operations debugfs_results_fops = {
 	.release = debugfs_release,
 };
 
+static const struct file_operations debugfs_run_fops = {
+	.open = debugfs_run_open,
+	.read = seq_read,
+	.write = debugfs_run,
+	.llseek = seq_lseek,
+	.release = debugfs_release,
+};
+
 void kunit_debugfs_create_suite(struct kunit_suite *suite)
 {
 	struct kunit_case *test_case;
 	struct string_stream *stream;
 
+	/* If suite log already allocated, do not create new debugfs files. */
+	if (suite->log)
+		return;
+
 	/*
 	 * Allocate logs before creating debugfs representation.
 	 * The suite->log and test_case->log pointer are expected to be NULL
@@ -140,6 +201,13 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
 	debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
 			    suite->debugfs,
 			    suite, &debugfs_results_fops);
+
+	/* Do not create file to re-run test if test runs on init */
+	if (!suite->is_init) {
+		debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0644,
+				    suite->debugfs,
+				    suite, &debugfs_run_fops);
+	}
 	return;
 
 err:
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 6c082911a85f..a52fcb9a4457 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/panic.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
@@ -22,6 +23,8 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+static DEFINE_MUTEX(kunit_run_lock);
+
 /*
  * Hook to fail the current test and print an error message to the log.
  */
@@ -654,6 +657,7 @@ static void kunit_init_suite(struct kunit_suite *suite)
 	kunit_debugfs_create_suite(suite);
 	suite->status_comment[0] = '\0';
 	suite->suite_init_err = 0;
+	string_stream_clear(suite->log);
 }
 
 bool kunit_enabled(void)
@@ -670,6 +674,11 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 		return 0;
 	}
 
+	/* Use mutex lock to guard against running tests concurrently. */
+	if (mutex_lock_interruptible(&kunit_run_lock)) {
+		pr_err("kunit: test interrupted\n");
+		return -EINTR;
+	}
 	static_branch_inc(&kunit_running);
 
 	for (i = 0; i < num_suites; i++) {
@@ -678,6 +687,7 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
 	}
 
 	static_branch_dec(&kunit_running);
+	mutex_unlock(&kunit_run_lock);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
-- 
2.43.0.472.g3155946c3a-goog

