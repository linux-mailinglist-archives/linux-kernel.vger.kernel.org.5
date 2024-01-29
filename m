Return-Path: <linux-kernel+bounces-43259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B43841187
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01C27B25931
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17AC15705E;
	Mon, 29 Jan 2024 18:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ENP8xTrO"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2B3F9EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551252; cv=none; b=dmzyjU/Nl22TjSVU+kpfzybYT5Sg1LSdTTkb5UkxUqgM4bLIeJJedOCY0HkeeVgY0m7atBBeKaELpHQo9egdz6H68jwpJF86kdc9s1p3A7fj+4sdOix9CD/XxCOAMvJ0cy8oboE39+m4VQoMk+gL25lOFAEQaQOx8mYMvdnzZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551252; c=relaxed/simple;
	bh=81LcZge0w4D9Z3eA6B+rApaqgdau7DNMJpUzowyrc8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eB0ivctGgou39ndqtRGu2JK8FUn6RiG9rdhIaaxlQyZWnESmM8jPfE9UlGlD4PKzhmvM//g1Wipe38Xp7PSj4T6F6UABfy76QYn+Mvu8eabYBxEMvZXe1TbbwXjXKhSI8rirR4ETrcxwUOZLJdA4vZ9XjqmzvonEle21G0BsQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ENP8xTrO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso1500951b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706551249; x=1707156049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/S6R7/9nVoHmk9zF9Fu8HvJ6G5Gizsl3DGB5UcgoVw=;
        b=ENP8xTrOM+56RJ9/yWCLd8hrOubKjLkWyMnBwI6heJecDzJBAz5UE8faH2U1MeLNS0
         1RWY/qSjXbzbxTvBfZM17565qf9x7s0W7I5Dl9vP3aKXmWfZ85WBWP8ygN8NG1fHTgos
         6RNoJNYopVIH795Tl35VWaY+2nkhHGim+OIzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551249; x=1707156049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/S6R7/9nVoHmk9zF9Fu8HvJ6G5Gizsl3DGB5UcgoVw=;
        b=B1gqfN7h9uSSW7zJL96p1gj47c9Bexb7tv3iL4MNdoFA51j8tSm8l6Kscv9NiOoxlx
         wout+5eLuSono+Cj/aBcTd9B4Ag8RuHwMnpBowz6dUA4BJXFPQKq32bdCDk5vaDElIy7
         I2QwYFN2hSgz8wkMVux7FIXUzqOmlAanXhb9EF6bwu60OvxMuMwklgRJvCvWCxXn2gnu
         BLy86QsJgvi68D9omemIm8OXspffVEF4Q1gmjmr5hNQHMuK1mahPwRx3LqzXWKsPet9a
         TgY023wkDcEqNXJFtbPICZ7KLnEBx1qnj+hy8kZCRP8/2B4mdZZgkKTk00TP4RIMR1Xg
         wI4g==
X-Gm-Message-State: AOJu0YxtJpt+tR2weImr7rzLb3gnCXDb9zG8bij1dabKEUB+hdnHxXKE
	5AHOXFylyd4kYVahULVAx3NYrhjywrZmJ+ldM3OHNr/eGmbpcfsM2grTstybTQ==
X-Google-Smtp-Source: AGHT+IHQnZbc4CDpc/PNRkdgODd8F3N0KDtcFJv5A+utlHT3onN/rSbzWcZBKcR5XR/Xa27nscnRug==
X-Received: by 2002:aa7:8c0e:0:b0:6de:1cae:a4ed with SMTP id c14-20020aa78c0e000000b006de1caea4edmr2155450pfd.3.1706551249541;
        Mon, 29 Jan 2024 10:00:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fb8-20020a056a002d8800b006dd8148efd8sm6085479pfb.103.2024.01.29.10.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:47 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/6] ubsan: Reintroduce signed and unsigned overflow sanitizers
Date: Mon, 29 Jan 2024 10:00:39 -0800
Message-Id: <20240129180046.3774731-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129175033.work.813-kees@kernel.org>
References: <20240129175033.work.813-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10079; i=keescook@chromium.org;
 h=from:subject; bh=81LcZge0w4D9Z3eA6B+rApaqgdau7DNMJpUzowyrc8U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlt+fKIaVk0RDXV5BS8oDSW+Q7mjUG3v2lN2MSh
 eQs8Xe4ZXyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbfnygAKCRCJcvTf3G3A
 JgurD/9DkagOyEbI4a5ICzXf6tUpMVcM49hz5oafXbNgdqrn3KUYi97yfRAINw8vUqQElyK4unV
 Kjhojr4O1+jSBa43BSNl+D1Zj0VhtMPS8ouYh7IiM+HGKVSqzaiS20wrzmQXJyHXortxnQmRmCB
 VjPjHEn5dm4bcxGBfB/novnBWipLzaCS+1NzYYo7LLiEmD/uMEGI94sJUTIwWMq2ifse//x2hF9
 h84ACieJ9DbmCqKLkmDc2PcUeu/PugIN1gaXjPLvghoDRZHguTDlToqUzV0Aq8FnRG0uZ4XpgnX
 zoZsCsLP7u9rTynKwkTuSYnHtr3pUIiDlrUs7boNnDSvIURDKbX+GiTuNeTIlZWHuPyIuonsBxZ
 XWoHnuDsIlw933mt1M93EAL/MhHMCTBzZ38v9XiEu0k1saFIsYC2Q7qMbk+RWkpdAWfHI2PsaTw
 1qzLsWJou0+eEsJqdiIaI64dJlzPZ0KzZc7Dism8IXbbrwVtJvMiASS3i0GKn4OgFLK42Ef93Pn
 /Ak/DgfL4o8jf7U7iujwn/MUlZ23s0SvQ6lJPaR9qDu+znd0jf6P0SjUkAZfpUhQv6sAeMUW0qe
 O+zqOsjLq/E3w3kpf4M0mkYy4EZFe3uE8klYi1pKDkxRmwev2QBNVCjrrOxkzwE5fcu/oXIkrhP bQK8kza3tDlUX2g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
checks"), to allow the kernel to be built with the "overflow"
sanitizers again. This gives developers a chance to experiment[1][2][3]
with the instrumentation again, while compilers adjust their sanitizers
to deal with the impact of -fno-strict-oveflow (i.e. moving from
"overflow" checking to "wrap-around" checking).

Notably, the naming of the options is adjusted to use the name "WRAP"
instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
happens when a result exceeds the storage of the type, and is considered
by the C standard and compilers to be undefined behavior for signed
and pointer types (without -fno-strict-overflow). Unsigned arithmetic
overflow is defined as always wrapping around.

Because the kernel is built with -fno-strict-overflow, signed and pointer
arithmetic is defined to always wrap around instead of "overflowing"
(which could either be elided due to being undefined behavior or would
wrap around, which led to very weird bugs in the kernel).

So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
explicitly depend on wrap-around behavior (e.g. counters, atomics, crypto,
etc), also introduce the __signed_wrap and __unsigned_wrap function
attributes for annotating functions where wrapping is expected and should
not be instrumented. This will allow us to distinguish in the kernel
between intentional and unintentional cases of arithmetic wrap-around.

Additionally keep these disabled under CONFIG_COMPILE_TEST for now.

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Cc: Justin Stitt <justinstitt@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Marco Elver <elver@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler_types.h | 14 ++++++-
 lib/Kconfig.ubsan              | 19 ++++++++++
 lib/test_ubsan.c               | 49 ++++++++++++++++++++++++
 lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
 lib/ubsan.h                    |  4 ++
 scripts/Makefile.ubsan         |  2 +
 6 files changed, 155 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6f1ca49306d2..e585614f3152 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -282,11 +282,23 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/* Allow wrapping arithmetic within an annotated function. */
+#ifdef CONFIG_UBSAN_SIGNED_WRAP
+# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
+#else
+# define __signed_wrap
+#endif
+#ifdef CONFIG_UBSAN_UNSIGNED_WRAP
+# define __unsigned_wrap __attribute__((no_sanitize("unsigned-integer-overflow")))
+#else
+# define __unsigned_wrap
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
-	__no_sanitize_memory
+	__no_sanitize_memory __signed_wrap __unsigned_wrap
 
 #define noinstr __noinstr_section(".noinstr.text")
 
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 59e21bfec188..a7003e5bd2a1 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -116,6 +116,25 @@ config UBSAN_UNREACHABLE
 	  This option enables -fsanitize=unreachable which checks for control
 	  flow reaching an expected-to-be-unreachable position.
 
+config UBSAN_SIGNED_WRAP
+	bool "Perform checking for signed arithmetic wrap-around"
+	default UBSAN
+	depends on !COMPILE_TEST
+	depends on $(cc-option,-fsanitize=signed-integer-overflow)
+	help
+	  This option enables -fsanitize=signed-integer-overflow which checks
+	  for wrap-around of any arithmetic operations with signed integers.
+
+config UBSAN_UNSIGNED_WRAP
+	bool "Perform checking for unsigned arithmetic wrap-around"
+	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
+	depends on !X86_32 # avoid excessive stack usage on x86-32/clang
+	depends on !COMPILE_TEST
+	help
+	  This option enables -fsanitize=unsigned-integer-overflow which checks
+	  for wrap-around of any arithmetic operations with unsigned integers. This
+	  currently causes x86 to fail to boot.
+
 config UBSAN_BOOL
 	bool "Perform checking for non-boolean values used as boolean"
 	default UBSAN
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 2062be1f2e80..84d8092d6c32 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -11,6 +11,51 @@ typedef void(*test_ubsan_fp)(void);
 			#config, IS_ENABLED(config) ? "y" : "n");	\
 	} while (0)
 
+static void test_ubsan_add_overflow(void)
+{
+	volatile int val = INT_MAX;
+	volatile unsigned int uval = UINT_MAX;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val += 2;
+
+	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
+	uval += 2;
+}
+
+static void test_ubsan_sub_overflow(void)
+{
+	volatile int val = INT_MIN;
+	volatile unsigned int uval = 0;
+	volatile int val2 = 2;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val -= val2;
+
+	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
+	uval -= val2;
+}
+
+static void test_ubsan_mul_overflow(void)
+{
+	volatile int val = INT_MAX / 2;
+	volatile unsigned int uval = UINT_MAX / 2;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val *= 3;
+
+	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
+	uval *= 3;
+}
+
+static void test_ubsan_negate_overflow(void)
+{
+	volatile int val = INT_MIN;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val = -val;
+}
+
 static void test_ubsan_divrem_overflow(void)
 {
 	volatile int val = 16;
@@ -90,6 +135,10 @@ static void test_ubsan_misaligned_access(void)
 }
 
 static const test_ubsan_fp test_ubsan_array[] = {
+	test_ubsan_add_overflow,
+	test_ubsan_sub_overflow,
+	test_ubsan_mul_overflow,
+	test_ubsan_negate_overflow,
 	test_ubsan_shift_out_of_bounds,
 	test_ubsan_out_of_bounds,
 	test_ubsan_load_invalid_value,
diff --git a/lib/ubsan.c b/lib/ubsan.c
index df4f8d1354bb..5fc107f61934 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -222,6 +222,74 @@ static void ubsan_epilogue(void)
 	check_panic_on_warn("UBSAN");
 }
 
+static void handle_overflow(struct overflow_data *data, void *lhs,
+			void *rhs, char op)
+{
+
+	struct type_descriptor *type = data->type;
+	char lhs_val_str[VALUE_LENGTH];
+	char rhs_val_str[VALUE_LENGTH];
+
+	if (suppress_report(&data->location))
+		return;
+
+	ubsan_prologue(&data->location, type_is_signed(type) ?
+			"signed-integer-overflow" :
+			"unsigned-integer-overflow");
+
+	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
+	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
+	pr_err("%s %c %s cannot be represented in type %s\n",
+		lhs_val_str,
+		op,
+		rhs_val_str,
+		type->type_name);
+
+	ubsan_epilogue();
+}
+
+void __ubsan_handle_add_overflow(void *data,
+				void *lhs, void *rhs)
+{
+
+	handle_overflow(data, lhs, rhs, '+');
+}
+EXPORT_SYMBOL(__ubsan_handle_add_overflow);
+
+void __ubsan_handle_sub_overflow(void *data,
+				void *lhs, void *rhs)
+{
+	handle_overflow(data, lhs, rhs, '-');
+}
+EXPORT_SYMBOL(__ubsan_handle_sub_overflow);
+
+void __ubsan_handle_mul_overflow(void *data,
+				void *lhs, void *rhs)
+{
+	handle_overflow(data, lhs, rhs, '*');
+}
+EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
+
+void __ubsan_handle_negate_overflow(void *_data, void *old_val)
+{
+	struct overflow_data *data = _data;
+	char old_val_str[VALUE_LENGTH];
+
+	if (suppress_report(&data->location))
+		return;
+
+	ubsan_prologue(&data->location, "negation-overflow");
+
+	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
+
+	pr_err("negation of %s cannot be represented in type %s:\n",
+		old_val_str, data->type->type_name);
+
+	ubsan_epilogue();
+}
+EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
+
+
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
 {
 	struct overflow_data *data = _data;
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 5d99ab81913b..0abbbac8700d 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -124,6 +124,10 @@ typedef s64 s_max;
 typedef u64 u_max;
 #endif
 
+void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
+void __ubsan_handle_negate_overflow(void *_data, void *old_val);
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
 void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
 void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 7cf42231042b..7b2f3d554c59 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -8,6 +8,8 @@ ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
 ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
 ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
+ubsan-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)	+= -fsanitize=signed-integer-overflow
+ubsan-cflags-$(CONFIG_UBSAN_UNSIGNED_WRAP)	+= -fsanitize=unsigned-integer-overflow
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
-- 
2.34.1


