Return-Path: <linux-kernel+bounces-34475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009F6837CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253C31C227A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BDE15704A;
	Tue, 23 Jan 2024 00:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A9qDI91W"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61815699C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969729; cv=none; b=mCnT9GHdNP8C0mpuwrJbbrmB5D9RIETk8tFujcYaJ31U6nZ4U0876kp7DHhoFX57nZTM5NEsZhsy60Xqo3MdAH2Kf0TTKT/HwKaUueV7L7fEh9Iz3bLHG0UCplTCpyamySSnFJRPst/hRE3bGl2DnBgaxnkcZ8dpPBqU0Ktodmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969729; c=relaxed/simple;
	bh=gb1n+W1s5M95ctI44Q78KR4JuU4AKXHCS49FRg23Idk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLHxxYQq4e3hqi56Uprob52ArotBNdJf0BdS4XpMebud3IFAZmIu+xXOj6V638gpHuOUdXSRIbElw5iAGyu3+SOczYBjw0vtUTo2tUKrwSQ3kYx+UwBWAaakTPw+3NmfDMhqIvbPS/hE4NNYdTTepvmuVTy1h0eJJRK8VqDnOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A9qDI91W; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd3b34a58dso2445593b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969727; x=1706574527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiCGHQCW4gkVIwAHs5whfe0Jo8nWbZkRUEu+EMnzU5w=;
        b=A9qDI91WAiNRJ2GAcq+oPlJ2gv1qQntYjPDaZuBSwkJPQGRE4JfseG0CguYV3GLi70
         FriJJXtD7FLBCwHzLBi/Vi+hqhtxragxctBtSDZEyzuFKP9O1PkylV0kSRMCPrtz1xTo
         khkVk20L/PuKXAcsJWWcEMIavMGnxdSCy9Mg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969727; x=1706574527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BiCGHQCW4gkVIwAHs5whfe0Jo8nWbZkRUEu+EMnzU5w=;
        b=mazy430KHYLj0irsI8oMy9H7uf6vdiCBR++QUSeFxxGGR9AIxJtdITgcVaxbhnOq8x
         AyuBeOyzNW58BQQa11Gz2CTrdB1oLSa+pwN9IJs75bEKr9Y70mdBT3h+L9xrmLZJowiZ
         Pk+Lhw9KWoJx0YFWFmOxWsAKapsPwXsb11iPe1Bel7Mn/JURS76p7UYZIOMPSlhD9HQ/
         fWlU1CG3W+Hvw2LroP7kplmoY5kyiBX2b3PcHDf03/u6BhioqNq6bcMaa/EmdoXTYnxq
         KmS9IhQ/Ow5wZYH2wpVghBMQ4XG4C779yMdNsWqF/DeVQQDDJnBJ+q7uTeHKjM1itDyK
         Bujg==
X-Gm-Message-State: AOJu0YzuywBuXKa9sNPm4kBGV+g3z0XiMRr+ZeWOLcSZaacNzQUk3lpp
	iAhbUT8DLskCcfSseFf0Jl9be5FpOleiMADaAly9Ua17R5rc7dszpGkh4I3q5w==
X-Google-Smtp-Source: AGHT+IH+t54oOODe+KjnT7B/1MefM50TtYuzHlu62Q+9kRwbDJoedt0TO5uBpgDTYWr0YTeNhOq7eA==
X-Received: by 2002:a05:6808:2094:b0:3bd:c568:faee with SMTP id s20-20020a056808209400b003bdc568faeemr103256oiw.74.1705969726746;
        Mon, 22 Jan 2024 16:28:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v23-20020aa78517000000b006d9b8572e77sm10193889pfn.120.2024.01.22.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/82] overflow: Reintroduce signed and unsigned overflow sanitizers
Date: Mon, 22 Jan 2024 16:26:41 -0800
Message-Id: <20240123002814.1396804-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10721; i=keescook@chromium.org;
 h=from:subject; bh=gb1n+W1s5M95ctI44Q78KR4JuU4AKXHCS49FRg23Idk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEA8JtBdMXVlroZLnnJVqsE33+zfz01FBiy
 8wUuHAFgcuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 Jj7NEACQQm0AHeLUrG6Oi/9wnlDXtoUdVl1Mv/wQrYOsP79X65ZjO3hVSGvZCS7S0NNRNJ0+nM6
 faKW9qCG6h1SeV7Mq9tvvaeCPuz3eIpIwMMS3fbAESR0tYSuFgeKwKuUVbjEuNxqoUsjqfdU/XY
 Mujtuxq0jUTmXnSlLLCxjlYOtGJZM5rHwDsFRQYqF2hNNU1a6y5Bli0xLbT7KIYKOkYcKyYzo4h
 kmlDcYc1Hz4u3u5034zX8ThC77WVARvs//wMN6gQrNQl6jsb3Lmb2SYDb0L9Z6fGMctdDDHCzxZ
 coY9O2cJfrEZmoZSHxKW9OJfhIvbh14/2OIgP/GDqgQOh3l3elc48kUJprXmkH4F3GG+2xAIPBy
 riT7ABS/uMTCYdTgB0FqU9sEF9bWr/bbho0UDv49OphdQRwITiU1MjU3elMsFVSbXBt1MiByaMc
 Q6PMq91AfNUkClrlc3b2z1CmZKUzUQ6CwGtYUvwLRA5ggnEa6LsvOzIbTxpTxPTfofKpvdInh3k
 LmU6tamHSR6Q6mil7gT3LFOGB7kkzr2T6R2R6DaxrT4I1iQtD6WXGUnNYqSQLeYH7IrDmI1Q/57
 XX/8YpLCx9jHKWB6Yp6z9elE2HGVjb4BKKDGsU94dCJ3Zl8qf9GIt/pX2+nx2TmmYPzWNEm81VL zIsWJE46ig2NcLA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
checks"), to allow the kernel to be built with the "*-overflow"
sanitizers again. This gives developers a chance to experiment[1][2][3]
with the instrumentation again, while dealing with the impact of
-fno-strict-oveflow.

Notably, the naming of the options is adjusted to use the name "WRAP"
instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
happens when a result exceeds the storage of the type, and is considered
by the C standard and compilers to be undefined behavior for signed
and pointer types (without -fno-strict-overflow). Unsigned arithmetic
overflow is defined as always wrapping around.

Because the kernel is built with -fno-strict-overflow, signed and pointer
arithmetic is defined to always wrap around instead of "overflowing"
(which would either be elided due to being undefined behavior or would
wrap around, which led to very weird bugs in the kernel).

So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
explicitly depend on wrap-around behavior (e.g. counters, atomics, etc),
also introduce the __signed_wrap and __unsigned_wrap function attributes
for annotating functions where wrapping is expected and should not
be caught. This will allow us to distinguish in the kernel between
intentional and unintentional cases of arithmetic wrap-around.

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
 Documentation/process/deprecated.rst |  4 ++
 include/linux/compiler_types.h       | 14 +++++-
 lib/Kconfig.ubsan                    | 19 ++++++++
 lib/test_ubsan.c                     | 49 ++++++++++++++++++++
 lib/ubsan.c                          | 68 ++++++++++++++++++++++++++++
 lib/ubsan.h                          |  4 ++
 scripts/Makefile.ubsan               |  2 +
 7 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 270f3af13b86..aebd7c6cd2fc 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -141,6 +141,10 @@ replaced with a type max subtraction test instead::
 	...
 	if (INT_MAX - var < offset) ...
 
+For inline helpers that are performing wrapping arithmetic, the entire
+function can be annotated as intentionally wrapping by adding the
+`__signed_wrap` or `__unsigned_wrap` function attribute.
+
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
 The simple_strtol(), simple_strtoll(),
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d27b58fddfaa..d24f43fc79c6 100644
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
index 4749865c1b2c..de4fc0ae448a 100644
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
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
-- 
2.34.1


