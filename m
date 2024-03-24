Return-Path: <linux-kernel+bounces-115880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF3889875
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7281C31C93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC462655CA;
	Mon, 25 Mar 2024 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy78UtxB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA12146003;
	Sun, 24 Mar 2024 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322075; cv=none; b=fILy6OSQvVj55jZ/++2CSKkEstWMfb06c8THEyRavkQAIdIsBeSrA81TIfb2IlrFPtIIrCNhL76ZS4pNrS/KBOOgkIlrSMlMko/Jh5DbJ9uwAioQGSKNLp4Fx4Dx3GjZBX78TvnIpTyje8CeYnS5nVI80fEuQZJHdgneKPB1k6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322075; c=relaxed/simple;
	bh=7foTnQmDJHqJbOmlYZaWww4yelruftK70Wcbpl6/S4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtkTv/BcQN9NGnpuJTVWNsnmeHa1FOnGkHtQLl/hCSu0C8hkQQr8KjKVRWpQh5X0+rr+wBAWegkkFzwkr+SqX2KV7hJ8DOFrGG2Hct6ApI/j0RorsPTTjWPolbWKGJYJRcEJ9Ws6oO1TzkWQGrjvJOwXMVYD+/siFu8ha5/WqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy78UtxB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 766DCC433A6;
	Sun, 24 Mar 2024 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322075;
	bh=7foTnQmDJHqJbOmlYZaWww4yelruftK70Wcbpl6/S4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gy78UtxBN81QNZoN06OsBQSStF16qRZ3PCCIXWQBIkicFHpib/3o5ie9S4LvO9/Od
	 z4qdi7ulq9FSmRs2sDGZSBDSJgH4TxHBnYJxo92aqDeWQ2nEoyCiQPg7l5jXlCEFns
	 Y9Guf0i1q77FtKnM2aBYZ/WVr9gvSFyafHeMByOkiyST2gU9Ge/MsQRb70dmoPm7BP
	 Fuvx/67LSHfZIIPC4e8sk+zkNJtS+UknSzyaoKTCFQu8VR7lN0cWBNZOpMvgqq3Yl4
	 I6fGvonN2wvS2UTJ1XE/h4Vf1Ar0tBbT+hvdes9rHScIB9CKEIuOGukcPU/0rbVOWr
	 MaBtfS8K/QsfQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Stanislav Fomichev <sdf@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 148/451] selftests/bpf: Convert test_global_funcs test to test_loader framework
Date: Sun, 24 Mar 2024 19:07:04 -0400
Message-ID: <20240324231207.1351418-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 95ebb376176c52382293e05e63f142114a5e40ef ]

Convert 17 test_global_funcs subtests into test_loader framework for
easier maintenance and more declarative way to define expected
failures/successes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@google.com>
Link: https://lore.kernel.org/bpf/20230216045954.3002473-3-andrii@kernel.org
Stable-dep-of: 879bbe7aa4af ("bpf: don't infer PTR_TO_CTX for programs with unnamed context type")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../bpf/prog_tests/test_global_funcs.c        | 131 +++++-------------
 .../selftests/bpf/progs/test_global_func1.c   |   6 +-
 .../selftests/bpf/progs/test_global_func10.c  |   4 +-
 .../selftests/bpf/progs/test_global_func11.c  |   4 +-
 .../selftests/bpf/progs/test_global_func12.c  |   4 +-
 .../selftests/bpf/progs/test_global_func13.c  |   4 +-
 .../selftests/bpf/progs/test_global_func14.c  |   4 +-
 .../selftests/bpf/progs/test_global_func15.c  |   4 +-
 .../selftests/bpf/progs/test_global_func16.c  |   4 +-
 .../selftests/bpf/progs/test_global_func17.c  |   4 +-
 .../selftests/bpf/progs/test_global_func2.c   |  43 +++++-
 .../selftests/bpf/progs/test_global_func3.c   |  10 +-
 .../selftests/bpf/progs/test_global_func4.c   |  55 +++++++-
 .../selftests/bpf/progs/test_global_func5.c   |   4 +-
 .../selftests/bpf/progs/test_global_func6.c   |   4 +-
 .../selftests/bpf/progs/test_global_func7.c   |   4 +-
 .../selftests/bpf/progs/test_global_func8.c   |   4 +-
 .../selftests/bpf/progs/test_global_func9.c   |   4 +-
 18 files changed, 174 insertions(+), 123 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
index 7295cc60f7248..2ff4d5c7abfce 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_global_funcs.c
@@ -1,104 +1,41 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2020 Facebook */
 #include <test_progs.h>
-
-const char *err_str;
-bool found;
-
-static int libbpf_debug_print(enum libbpf_print_level level,
-			      const char *format, va_list args)
-{
-	char *log_buf;
-
-	if (level != LIBBPF_WARN ||
-	    strcmp(format, "libbpf: \n%s\n")) {
-		vprintf(format, args);
-		return 0;
-	}
-
-	log_buf = va_arg(args, char *);
-	if (!log_buf)
-		goto out;
-	if (err_str && strstr(log_buf, err_str) == 0)
-		found = true;
-out:
-	printf(format, log_buf);
-	return 0;
-}
-
-extern int extra_prog_load_log_flags;
-
-static int check_load(const char *file)
-{
-	struct bpf_object *obj = NULL;
-	struct bpf_program *prog;
-	int err;
-
-	found = false;
-
-	obj = bpf_object__open_file(file, NULL);
-	err = libbpf_get_error(obj);
-	if (err)
-		return err;
-
-	prog = bpf_object__next_program(obj, NULL);
-	if (!prog) {
-		err = -ENOENT;
-		goto err_out;
-	}
-
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
-	bpf_program__set_log_level(prog, extra_prog_load_log_flags);
-
-	err = bpf_object__load(obj);
-
-err_out:
-	bpf_object__close(obj);
-	return err;
-}
-
-struct test_def {
-	const char *file;
-	const char *err_str;
-};
+#include "test_global_func1.skel.h"
+#include "test_global_func2.skel.h"
+#include "test_global_func3.skel.h"
+#include "test_global_func4.skel.h"
+#include "test_global_func5.skel.h"
+#include "test_global_func6.skel.h"
+#include "test_global_func7.skel.h"
+#include "test_global_func8.skel.h"
+#include "test_global_func9.skel.h"
+#include "test_global_func10.skel.h"
+#include "test_global_func11.skel.h"
+#include "test_global_func12.skel.h"
+#include "test_global_func13.skel.h"
+#include "test_global_func14.skel.h"
+#include "test_global_func15.skel.h"
+#include "test_global_func16.skel.h"
+#include "test_global_func17.skel.h"
 
 void test_test_global_funcs(void)
 {
-	struct test_def tests[] = {
-		{ "test_global_func1.bpf.o", "combined stack size of 4 calls is 544" },
-		{ "test_global_func2.bpf.o" },
-		{ "test_global_func3.bpf.o", "the call stack of 8 frames" },
-		{ "test_global_func4.bpf.o" },
-		{ "test_global_func5.bpf.o", "expected pointer to ctx, but got PTR" },
-		{ "test_global_func6.bpf.o", "modified ctx ptr R2" },
-		{ "test_global_func7.bpf.o", "foo() doesn't return scalar" },
-		{ "test_global_func8.bpf.o" },
-		{ "test_global_func9.bpf.o" },
-		{ "test_global_func10.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func11.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func12.bpf.o", "invalid mem access 'mem_or_null'" },
-		{ "test_global_func13.bpf.o", "Caller passes invalid args into func#1" },
-		{ "test_global_func14.bpf.o", "reference type('FWD S') size cannot be determined" },
-		{ "test_global_func15.bpf.o", "At program exit the register R0 has value" },
-		{ "test_global_func16.bpf.o", "invalid indirect read from stack" },
-		{ "test_global_func17.bpf.o", "Caller passes invalid args into func#1" },
-	};
-	libbpf_print_fn_t old_print_fn = NULL;
-	int err, i, duration = 0;
-
-	old_print_fn = libbpf_set_print(libbpf_debug_print);
-
-	for (i = 0; i < ARRAY_SIZE(tests); i++) {
-		const struct test_def *test = &tests[i];
-
-		if (!test__start_subtest(test->file))
-			continue;
-
-		err_str = test->err_str;
-		err = check_load(test->file);
-		CHECK_FAIL(!!err ^ !!err_str);
-		if (err_str)
-			CHECK(found, "", "expected string '%s'", err_str);
-	}
-	libbpf_set_print(old_print_fn);
+	RUN_TESTS(test_global_func1);
+	RUN_TESTS(test_global_func2);
+	RUN_TESTS(test_global_func3);
+	RUN_TESTS(test_global_func4);
+	RUN_TESTS(test_global_func5);
+	RUN_TESTS(test_global_func6);
+	RUN_TESTS(test_global_func7);
+	RUN_TESTS(test_global_func8);
+	RUN_TESTS(test_global_func9);
+	RUN_TESTS(test_global_func10);
+	RUN_TESTS(test_global_func11);
+	RUN_TESTS(test_global_func12);
+	RUN_TESTS(test_global_func13);
+	RUN_TESTS(test_global_func14);
+	RUN_TESTS(test_global_func15);
+	RUN_TESTS(test_global_func16);
+	RUN_TESTS(test_global_func17);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func1.c b/tools/testing/selftests/bpf/progs/test_global_func1.c
index 7b42dad187b89..23970a20b3249 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func1.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func1.c
@@ -3,10 +3,9 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
-#ifndef MAX_STACK
 #define MAX_STACK (512 - 3 * 32 + 8)
-#endif
 
 static __attribute__ ((noinline))
 int f0(int var, struct __sk_buff *skb)
@@ -39,7 +38,8 @@ int f3(int val, struct __sk_buff *skb, int var)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("combined stack size of 4 calls is 544")
+int global_func1(struct __sk_buff *skb)
 {
 	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
index 97b7031d0e227..98327bdbbfd24 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func10.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct Small {
 	int x;
@@ -21,7 +22,8 @@ __noinline int foo(const struct Big *big)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect read from stack")
+int global_func10(struct __sk_buff *skb)
 {
 	const struct Small small = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index ef5277d982d92..283e036dc401e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func11(struct __sk_buff *skb)
 {
 	return foo((const void *)skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func12.c b/tools/testing/selftests/bpf/progs/test_global_func12.c
index 62343527cc598..7f159d83c6f67 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func12.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func12.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -13,7 +14,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid mem access 'mem_or_null'")
+int global_func12(struct __sk_buff *skb)
 {
 	const struct S s = {.x = skb->len };
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func13.c b/tools/testing/selftests/bpf/progs/test_global_func13.c
index ff8897c1ac22b..02ea80da75b57 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func13.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func13.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -16,7 +17,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func13(struct __sk_buff *skb)
 {
 	const struct S *s = (const struct S *)(0xbedabeda);
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func14.c b/tools/testing/selftests/bpf/progs/test_global_func14.c
index 698c77199ebf7..33b7d5efd7b26 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func14.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func14.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S;
 
@@ -14,7 +15,8 @@ __noinline int foo(const struct S *s)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("reference type('FWD S') size cannot be determined")
+int global_func14(struct __sk_buff *skb)
 {
 
 	return foo(NULL);
diff --git a/tools/testing/selftests/bpf/progs/test_global_func15.c b/tools/testing/selftests/bpf/progs/test_global_func15.c
index c19c435988d55..b512d6a6c75e5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func15.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func15.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(unsigned int *v)
 {
@@ -12,7 +13,8 @@ __noinline int foo(unsigned int *v)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("At program exit the register R0 has value")
+int global_func15(struct __sk_buff *skb)
 {
 	unsigned int v = 1;
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func16.c b/tools/testing/selftests/bpf/progs/test_global_func16.c
index 0312d1e8d8c06..e7206304632e1 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func16.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func16.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int (*arr)[10])
 {
@@ -12,7 +13,8 @@ __noinline int foo(int (*arr)[10])
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("invalid indirect read from stack")
+int global_func16(struct __sk_buff *skb)
 {
 	int array[10];
 
diff --git a/tools/testing/selftests/bpf/progs/test_global_func17.c b/tools/testing/selftests/bpf/progs/test_global_func17.c
index 2b8b9b8ba0183..a32e11c7d933e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func17.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func17.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(int *p)
 {
@@ -10,7 +11,8 @@ __noinline int foo(int *p)
 const volatile int i;
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("Caller passes invalid args into func#1")
+int global_func17(struct __sk_buff *skb)
 {
 	return foo((int *)&i);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func2.c b/tools/testing/selftests/bpf/progs/test_global_func2.c
index 2c18d82923a2d..3dce97fb52a4b 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func2.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func2.c
@@ -1,4 +1,45 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
 #define MAX_STACK (512 - 3 * 32)
-#include "test_global_func1.c"
+
+static __attribute__ ((noinline))
+int f0(int var, struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return f0(0, skb) + skb->len;
+}
+
+int f3(int, struct __sk_buff *skb, int);
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + f3(val, skb, 1);
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	volatile char buf[MAX_STACK] = {};
+
+	return skb->ifindex * val * var;
+}
+
+SEC("tc")
+__success
+int global_func2(struct __sk_buff *skb)
+{
+	return f0(1, skb) + f1(skb) + f2(2, skb) + f3(3, skb, 4);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func3.c b/tools/testing/selftests/bpf/progs/test_global_func3.c
index 01bf8275dfd64..142b682d3c2f0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func3.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func3.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -46,20 +47,15 @@ int f7(struct __sk_buff *skb)
 	return f6(skb);
 }
 
-#ifndef NO_FN8
 __attribute__ ((noinline))
 int f8(struct __sk_buff *skb)
 {
 	return f7(skb);
 }
-#endif
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("the call stack of 8 frames")
+int global_func3(struct __sk_buff *skb)
 {
-#ifndef NO_FN8
 	return f8(skb);
-#else
-	return f7(skb);
-#endif
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func4.c b/tools/testing/selftests/bpf/progs/test_global_func4.c
index 610f75edf2764..1733d87ad3f3e 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func4.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func4.c
@@ -1,4 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (c) 2020 Facebook */
-#define NO_FN8
-#include "test_global_func3.c"
+#include <stddef.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+__attribute__ ((noinline))
+int f1(struct __sk_buff *skb)
+{
+	return skb->len;
+}
+
+__attribute__ ((noinline))
+int f2(int val, struct __sk_buff *skb)
+{
+	return f1(skb) + val;
+}
+
+__attribute__ ((noinline))
+int f3(int val, struct __sk_buff *skb, int var)
+{
+	return f2(var, skb) + val;
+}
+
+__attribute__ ((noinline))
+int f4(struct __sk_buff *skb)
+{
+	return f3(1, skb, 2);
+}
+
+__attribute__ ((noinline))
+int f5(struct __sk_buff *skb)
+{
+	return f4(skb);
+}
+
+__attribute__ ((noinline))
+int f6(struct __sk_buff *skb)
+{
+	return f5(skb);
+}
+
+__attribute__ ((noinline))
+int f7(struct __sk_buff *skb)
+{
+	return f6(skb);
+}
+
+SEC("tc")
+__success
+int global_func4(struct __sk_buff *skb)
+{
+	return f7(skb);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_global_func5.c b/tools/testing/selftests/bpf/progs/test_global_func5.c
index 9248d03e0d06f..cc55aedaf82d5 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func5.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func5.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("expected pointer to ctx, but got PTR")
+int global_func5(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func6.c b/tools/testing/selftests/bpf/progs/test_global_func6.c
index af8c78bdfb257..46c38c8f2cf03 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func6.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func6.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 int f1(struct __sk_buff *skb)
@@ -25,7 +26,8 @@ int f3(int val, struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("modified ctx ptr R2")
+int global_func6(struct __sk_buff *skb)
 {
 	return f1(skb) + f2(2, skb) + f3(3, skb);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_global_func7.c b/tools/testing/selftests/bpf/progs/test_global_func7.c
index 6cb8e2f5254cf..f182febfde3c0 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func7.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func7.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __attribute__ ((noinline))
 void foo(struct __sk_buff *skb)
@@ -11,7 +12,8 @@ void foo(struct __sk_buff *skb)
 }
 
 SEC("tc")
-int test_cls(struct __sk_buff *skb)
+__failure __msg("foo() doesn't return scalar")
+int global_func7(struct __sk_buff *skb)
 {
 	foo(skb);
 	return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func8.c b/tools/testing/selftests/bpf/progs/test_global_func8.c
index d55a6544b1abd..9b9c57fa2dd34 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func8.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func8.c
@@ -3,6 +3,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 __noinline int foo(struct __sk_buff *skb)
 {
@@ -10,7 +11,8 @@ __noinline int foo(struct __sk_buff *skb)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func8(struct __sk_buff *skb)
 {
 	if (!foo(skb))
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/test_global_func9.c b/tools/testing/selftests/bpf/progs/test_global_func9.c
index bd233ddede98a..1f2cb0159b8d8 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func9.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func9.c
@@ -2,6 +2,7 @@
 #include <stddef.h>
 #include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
 
 struct S {
 	int x;
@@ -74,7 +75,8 @@ __noinline int quuz(int **p)
 }
 
 SEC("cgroup_skb/ingress")
-int test_cls(struct __sk_buff *skb)
+__success
+int global_func9(struct __sk_buff *skb)
 {
 	int result = 0;
 
-- 
2.43.0


