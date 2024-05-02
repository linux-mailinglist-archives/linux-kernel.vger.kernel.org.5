Return-Path: <linux-kernel+bounces-166543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53F58B9C19
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BCAE281D63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D6113C696;
	Thu,  2 May 2024 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/N2vlzf"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586E612DDBF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714659221; cv=none; b=M5j24OTstW3B3aetOyI6QuOdCxSc88X7j/RTMD4zy2VuGf2fftof3MMqmvxj8mc88eDeqsXxCFl9+bzR258WgU2bG6F9SecO1YYcEcbcQfH9jFcnOvysSjRgVDaKzqq4n5Tm3v97eLte7ihA5D68R5uzwaiu4b4K1JY9Hdg/JNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714659221; c=relaxed/simple;
	bh=Qbmrk6jTj9AEBxw0+XAc0e4hQuIbaJCgCwARnd1RUF8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pKtvpHGZLbZ4ChgInhd/n3mHvTNVMqudTs+GKHssnfmG+59LOz8mZO+srgkgB2QvZh28KyaN+HmQvn3QNHiO7sHrf1Ra5gVr9onfIk7DHMWxVCkd6WP1SD+GqyImr2+Do3GywS6QG+BDxXAmfpdBCuguXPniC2OwSAi7YJaF96Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J/N2vlzf; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a524b774e39so182581466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 07:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714659218; x=1715264018; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HsPj+acZKYK2WoyW/9ElzwwE/qj1TMWpdQ6bEOK7unE=;
        b=J/N2vlzfKnOu8yISREc6L4yBocea42VHxrgESAU4PmGsep7ksF9jzLGbm7xdRcjNxx
         T2MR8Vc9Oky2cOnVnMT0PkRvugB89YvorUHKsXRgedqtIacPuWm1HKXqhRNV09OZjwO6
         8Rjtbx2NhZ7aQU/AP/eN8zvBhuQ/yWggICTlKDZneJQ9vsCj3OlKwEoS/AHyEfBi+CdD
         H6olw584uINGGnrRcF5G0g4BNHWMTCNQsFPMxkWFIKaKAWbgm2b7FX83xh02Z90jGW91
         53OZGhGfc74ZLkhmn1eSMV27g9ZO+WmpiuSbAHB7MfYbwzGwCZvLlorR4RqGVlZpcGqo
         KhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714659218; x=1715264018;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HsPj+acZKYK2WoyW/9ElzwwE/qj1TMWpdQ6bEOK7unE=;
        b=Tz2dVc34NIIkeRWJfQRxit8dJ4Ufn/9tZHCn/fsYG6Wof+gm3+7kbJSE+Db7t1o4xP
         ha7v7f4NvzXw4CpX2JP+WrCPBZPU3YVzIkSApL/D7L9PkJDw5fYhVzwwDkntxI697Gsp
         GRa6jziTjA4IhaZnpbtfFaVpjhU38ACFNx4jzI3oLRvZx+8oL/6jJjV94iAlrelUb3eT
         S98p/HH3VEfngDM+QdgvYzXps3/5ByjXm3AxKqLQX/IR6XH3Yn+By1KjDddOy7IO3Uei
         amV+3Md5Cc3eNKvEPrtQYkz1TzsDCio37AM8FaToE6Pgt3Lla7vFdUmLjB/WmxlQxujE
         Gjow==
X-Forwarded-Encrypted: i=1; AJvYcCXUtHsCXMFqXq7PTdQvPJSM4Al1axgwfcxTIOkcVR2H94Rd89ipvm16DTpUM6OjL2dwkktic2rkWPBK2PvMMaGsH/c/wW/VaTZRUMtD
X-Gm-Message-State: AOJu0YwUlPFT5kpVVucVBVRLd01h1DSPXExWT9YohNHdTjZv6td18LZy
	5W+CAP9oShY073/ioFvrKt3YI7Df5Z/KsRqI4ZErCCgBxZQXmBBtpigbtCUZRDdTM3ibIYgrBQ=
	=
X-Google-Smtp-Source: AGHT+IG90K7nqz0LjHaqF5X1kiDf8ecv7f7M66h6CN8mnd3HVZPxhQiQkDD/3ujdkSMcJYCQs8EylB8QQQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:7572:6c35:c45a:3523])
 (user=elver job=sendgmr) by 2002:a17:907:8691:b0:a58:e8cb:2989 with SMTP id
 qa17-20020a170907869100b00a58e8cb2989mr3504ejc.5.1714659217590; Thu, 02 May
 2024 07:13:37 -0700 (PDT)
Date: Thu,  2 May 2024 16:12:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240502141242.2765090-1-elver@google.com>
Subject: [PATCH] kcsan, compiler_types: Introduce __data_racy type qualifier
From: Marco Elver <elver@google.com>
To: elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"

Based on the discussion at [1], it would be helpful to mark certain
variables as explicitly "data racy", which would result in KCSAN not
reporting data races involving any accesses on such variables. To do
that, introduce the __data_racy type qualifier:

	struct foo {
		...
		int __data_racy bar;
		...
	};

In KCSAN-kernels, __data_racy turns into volatile, which KCSAN already
treats specially by considering them "marked". In non-KCSAN kernels the
type qualifier turns into no-op.

The generated code between KCSAN-instrumented kernels and non-KCSAN
kernels is already huge (inserted calls into runtime for every memory
access), so the extra generated code (if any) due to volatile for few
such __data_racy variables are unlikely to have measurable impact on
performance.

Link: https://lore.kernel.org/all/CAHk-=wi3iondeh_9V2g3Qz5oHTRjLsOpoy83hb58MVh=nRZe0A@mail.gmail.com/ [1]
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Marco Elver <elver@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 Documentation/dev-tools/kcsan.rst | 10 ++++++++++
 include/linux/compiler_types.h    |  7 +++++++
 kernel/kcsan/kcsan_test.c         | 17 +++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 94b6802ab0ab..02143f060b22 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -91,6 +91,16 @@ the below options are available:
   behaviour when encountering a data race is deemed safe.  Please see
   `"Marking Shared-Memory Accesses" in the LKMM`_ for more information.
 
+* Similar to ``data_race(...)``, the type qualifier ``__data_racy`` can be used
+  to document that all data races due to accesses to a variable are intended
+  and should be ignored by KCSAN::
+
+    struct foo {
+        ...
+        int __data_racy stats_counter;
+        ...
+    };
+
 * Disabling data race detection for entire functions can be accomplished by
   using the function attribute ``__no_kcsan``::
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2abaa3a825a9..a38162a8590d 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -273,9 +273,16 @@ struct ftrace_likely_data {
  * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
  */
 # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
+/*
+ * Type qualifier to mark variables where all data-racy accesses should be
+ * ignored by KCSAN. Note, the implementation simply marks these variables as
+ * volatile, since KCSAN will treat such accesses as "marked".
+ */
+# define __data_racy volatile
 # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #else
 # define __no_kcsan
+# define __data_racy
 #endif
 
 #ifndef __no_sanitize_or_inline
diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 015586217875..0c17b4c83e1c 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -304,6 +304,7 @@ static long test_array[3 * PAGE_SIZE / sizeof(long)];
 static struct {
 	long val[8];
 } test_struct;
+static long __data_racy test_data_racy;
 static DEFINE_SEQLOCK(test_seqlock);
 static DEFINE_SPINLOCK(test_spinlock);
 static DEFINE_MUTEX(test_mutex);
@@ -358,6 +359,8 @@ static noinline void test_kernel_write_uninstrumented(void) { test_var++; }
 
 static noinline void test_kernel_data_race(void) { data_race(test_var++); }
 
+static noinline void test_kernel_data_racy_qualifier(void) { test_data_racy++; }
+
 static noinline void test_kernel_assert_writer(void)
 {
 	ASSERT_EXCLUSIVE_WRITER(test_var);
@@ -1009,6 +1012,19 @@ static void test_data_race(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, match_never);
 }
 
+/* Test the __data_racy type qualifier. */
+__no_kcsan
+static void test_data_racy_qualifier(struct kunit *test)
+{
+	bool match_never = false;
+
+	begin_test_checks(test_kernel_data_racy_qualifier, test_kernel_data_racy_qualifier);
+	do {
+		match_never = report_available();
+	} while (!end_test_checks(match_never));
+	KUNIT_EXPECT_FALSE(test, match_never);
+}
+
 __no_kcsan
 static void test_assert_exclusive_writer(struct kunit *test)
 {
@@ -1424,6 +1440,7 @@ static struct kunit_case kcsan_test_cases[] = {
 	KCSAN_KUNIT_CASE(test_read_plain_atomic_rmw),
 	KCSAN_KUNIT_CASE(test_zero_size_access),
 	KCSAN_KUNIT_CASE(test_data_race),
+	KCSAN_KUNIT_CASE(test_data_racy_qualifier),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_writer),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access),
 	KCSAN_KUNIT_CASE(test_assert_exclusive_access_writer),
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


