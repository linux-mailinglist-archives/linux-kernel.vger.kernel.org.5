Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C07C76FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442453AbjJLTdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 15:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442177AbjJLTcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:32:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFD0D6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 12:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60244C433B8;
        Thu, 12 Oct 2023 19:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139156;
        bh=ZOE33RJAMWGQJdaU6oZoWkIigfB3nCdV+9LKbJA6ToY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVN5/8dYBBcPxYBYK5sFj+GGc37KK72uJ0ciy7QaETHfZIdiT+E1WeOmRFKttX4cW
         9kFsb0sl9cT98dC7n14X32mxKbkWo0bKmhESX6GVihwadGyR5B1sdonGFO32/KKZrW
         9TtRNvzg7cMqerD7L8nDdadI2rwEmtEFZfj4QzTIqiIo0lVURDe40kL2s5DB8nNK88
         hRm9HO/DP3PXaTXJf1Pv8b0QWh/JNL3L5QY0NpufamwICn3MDESufP3nRy/iOjKBS2
         0QVa1D5sj1tE1Rh7TcuJgPYmCQezMkW4JPDpYAeS5uXQz+HzgvjIF4Q26WAP4fR6bZ
         ihhkALCtbHAiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 65D19CE0F15; Thu, 12 Oct 2023 12:32:35 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH nolibc 17/19] tools/nolibc: add support for constructors and destructors
Date:   Thu, 12 Oct 2023 12:32:31 -0700
Message-Id: <20231012193233.207857-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
References: <b34ce3cf-3fcc-4eb0-a658-229c197455ef@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

With the startup code moved to C, implementing support for
constructors and deconstructors is fairly easy to implement.

Examples for code size impact:

   text	   data	    bss	    dec	    hex	filename
  21837	    104	     88	  22029	   560d	nolibc-test.before
  22135	    120	     88	  22343	   5747	nolibc-test.after
  21970	    104	     88	  22162	   5692 nolibc-test.after-only-crt.h-changes

The sections are defined by [0].

[0] https://refspecs.linuxfoundation.org/elf/gabi4+/ch5.dynamic.html

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20231007-nolibc-constructors-v2-1-ef84693efbc1@weissschuh.net/
---
 tools/include/nolibc/crt.h                   | 23 +++++++++++++++++++-
 tools/testing/selftests/nolibc/nolibc-test.c | 17 +++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/crt.h b/tools/include/nolibc/crt.h
index a05655b4ce1d..43b551468c2a 100644
--- a/tools/include/nolibc/crt.h
+++ b/tools/include/nolibc/crt.h
@@ -13,12 +13,23 @@ const unsigned long *_auxv __attribute__((weak));
 static void __stack_chk_init(void);
 static void exit(int);
 
+extern void (*const __preinit_array_start[])(void) __attribute__((weak));
+extern void (*const __preinit_array_end[])(void) __attribute__((weak));
+
+extern void (*const __init_array_start[])(void) __attribute__((weak));
+extern void (*const __init_array_end[])(void) __attribute__((weak));
+
+extern void (*const __fini_array_start[])(void) __attribute__((weak));
+extern void (*const __fini_array_end[])(void) __attribute__((weak));
+
 __attribute__((weak))
 void _start_c(long *sp)
 {
 	long argc;
 	char **argv;
 	char **envp;
+	int exitcode;
+	void (* const *func)(void);
 	const unsigned long *auxv;
 	/* silence potential warning: conflicting types for 'main' */
 	int _nolibc_main(int, char **, char **) __asm__ ("main");
@@ -55,8 +66,18 @@ void _start_c(long *sp)
 		;
 	_auxv = auxv;
 
+	for (func = __preinit_array_start; func < __preinit_array_end; func++)
+		(*func)();
+	for (func = __init_array_start; func < __init_array_end; func++)
+		(*func)();
+
 	/* go to application */
-	exit(_nolibc_main(argc, argv, envp));
+	exitcode = _nolibc_main(argc, argv, envp);
+
+	for (func = __fini_array_end; func > __fini_array_start;)
+		(*--func)();
+
+	exit(exitcode);
 }
 
 #endif /* _NOLIBC_CRT_H */
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7e3936c182dc..8da7f15d010e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -57,6 +57,9 @@ static int test_argc;
 /* will be used by some test cases as readable file, please don't write it */
 static const char *argv0;
 
+/* will be used by constructor tests */
+static int constructor_test_value;
+
 /* definition of a series of tests */
 struct test {
 	const char *name;              /* test name */
@@ -594,6 +597,19 @@ int expect_strne(const char *expr, int llen, const char *cmp)
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
+/* constructors validate that they are executed in definition order */
+__attribute__((constructor))
+static void constructor1(void)
+{
+	constructor_test_value = 1;
+}
+
+__attribute__((constructor))
+static void constructor2(void)
+{
+	constructor_test_value *= 2;
+}
+
 int run_startup(int min, int max)
 {
 	int test;
@@ -630,6 +646,7 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
+		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */
-- 
2.40.1

