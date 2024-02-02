Return-Path: <linux-kernel+bounces-49657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81741846DA1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65001F26B8F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E37E583;
	Fri,  2 Feb 2024 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHi/5CCO"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62287A70A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869006; cv=none; b=mAn2Q/w7xZT3D0hQKBJp7VEwLShbhn+Dk23fgtEJdmf29NRB36CGZ+qBG9laaFUXN1eoZO3NS4FjbQHR4Q28WpUQt6ma1Pv8PzAUQF9KHA0eEAU7praPSo67EtfydH0lRuD254HPm+jJ6nqafxkuaYKFlotLqceUZCFYb7NMwyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869006; c=relaxed/simple;
	bh=81LcZge0w4D9Z3eA6B+rApaqgdau7DNMJpUzowyrc8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hncJlWiLSDbPVAiww/Ue+jXhAmybOU3KdicMWXxR7owui96Z467mJpEYwhECRI946hREjS7nNB1xokTuPyhdqrltfayzZNvypfxuGhUiNBZmpoghZKgl9ng6/RvopSThCe8JGk45UE6HYIrY0yas/RpTfIeo6AobUdh7Sutol4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mHi/5CCO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso1467522a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869003; x=1707473803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/S6R7/9nVoHmk9zF9Fu8HvJ6G5Gizsl3DGB5UcgoVw=;
        b=mHi/5CCOfEEX+BVr5JH611wBTjzwUdeMLsA0B37hxbNepGFdeJrNabgl0JIjCLaPTZ
         Y8lgWt59Y5wSU6+Vwpqldk5t9xRULnl+xBWJM0Cjq7vcLY/Cm0jvfN1Rns8IoayGSahH
         4aeTqHvnv0o/DzdeoPF2euqvvx/kMtaUHHOnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869003; x=1707473803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/S6R7/9nVoHmk9zF9Fu8HvJ6G5Gizsl3DGB5UcgoVw=;
        b=jwh1rFLe2Kz5TK6yDlDXDT3Tbzf/H+tHSHLu413/u6L2WF5Snvp/7LEofuLQOmiY8g
         /udTEpSETyxayfMFuH+hXADxHE+o+YoeLYyxZ1Le71QKkvtT8uSHSMkgo0lBPoRgsmGD
         VqaaPlxicIr9t0vXae2y+W7bFz4MlOL/ddPf2Hr+QIqWRAHQ0ju6KarmZrNjyZgC/cI1
         fz1d/I+1eu42ogs/ArHnFaLqkuZ2KJ7YyLqIwtprTzIDpwDw3Rz5cy/ELp+eCYu1BZYk
         9odaOEYppyMsC8oZBILxXsOL6jY+Iwm9CUL/lucE9Z+E7gryWbZ5CKHeklzykNj9X1bP
         0VRA==
X-Gm-Message-State: AOJu0YzC4JDYtRE7TIW+XKJUWa7+25gBCIQm49JEJ6Ty9DNhNdlHele0
	AUocHLAIvziI4aZsRKVdqmS0Nke8Vq0FqjMtAv8ofu4fB4xp+8tsGrNX9FSKHA==
X-Google-Smtp-Source: AGHT+IHGVoXnALk3e0KTnUW+XJTOeoAchvqfVfnhBeIvjgWfKsbk+scsS2uNvD0mrKl6RkxK9v0AEQ==
X-Received: by 2002:a05:6a20:d80a:b0:19e:3172:b8ac with SMTP id iv10-20020a056a20d80a00b0019e3172b8acmr8509849pzb.22.1706869003182;
        Fri, 02 Feb 2024 02:16:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWoz46bwT+tJO8xy56NbLr1KS+igx2daYsByMo02TKngsVRwUuFg7rM8d2fC9gniw/eE1Q+M8gYLGV0R77HWl5kkLuEJZYFcd3ZpZKGRtahgInsMSopUwFERg7zuZHYNtJ5cJY9S2MraM2AOdZTTsl6P817jdn3+0hoVV2s43CNN5/nYeQK3ywIAd7TM2tMMv736L+PU5oEIuAwAF6QxY7hk6ZUYTxy0dptEOM02zqUvp11bDVVbi6S3n6ojbgp4xa9zL5Pl1AK7tfwa9hB2HWWUqQJAG1beGvKFdo7Mom3kiQCGh3TESzslYvSA98vnLsC4EJqMD9Uz8azrFX1Ex75q3xcLnhW2kZqdFqM+4BashtXkOJBquFxMijWLtVQMr4ZE2M1tUiRNGANdexlJ96uetelZ97X/PY/9FFiBdNHkgVQSScQTlNDriahUrbVN3f1x2A5SrEDHUYfRek4LjMjYi3p5UMVzy3MM2AYFHjg6ci4bdjFS8hPv4iQCGoeEYZuQp88sa54C908gCbMdO7a77djfDP9t5GC659+wIXuW5inYCBGQotSrYlfFNKhSKwT7bfBvkZuJCPGJTWGXk0+KPs/zoTpSkJ430g2C9DO1V/7d3r5Q6mZ8bhuHeko5NNBwMH5NODDFj2P6245q/GN+6UxZLLmpRUazUMVySJWK+qZCmIgUtRAeYTjxOxNK6dirVDW6ImDqWqJGDVldIDW+I7jV/5M5VWcgIUx4uDclV4lMY6o/UR8yI1NO/c=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j24-20020a62b618000000b006dd850bbd21sm1236764pff.36.2024.02.02.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:42 -0800 (PST)
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
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bill Wendling <morbo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/6] ubsan: Reintroduce signed and unsigned overflow sanitizers
Date: Fri,  2 Feb 2024 02:16:35 -0800
Message-Id: <20240202101642.156588-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10079; i=keescook@chromium.org;
 h=from:subject; bh=81LcZge0w4D9Z3eA6B+rApaqgdau7DNMJpUzowyrc8U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHIaVk0RDXV5BS8oDSW+Q7mjUG3v2lN2MSh
 eQs8Xe4ZXyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 JlV3EACFj6qzRW/Dmz2j427eAnNRW/hFiqg76oZtLKt19NBhwQSxqIEDMXQp9hgoLImHy3cIsTz
 /3Rn02fPcHAlgbHbphdnoxIxF9d3JIMOflSJOWUtksgIa2hMlnS7dKbdvmr6YMMT9DzhneaK/ah
 m8bVM9Mgc+Fzxr+ruzOV0BX8GlCxuFOL12H1D3nZvF82gmkuNPMCYslbh8l0P1WdKLSV4yEaD08
 RWG3VMBfMNhEMTzybJOFwIVklb0tu91BdUOI2awvdIBY0hXH+0T8ZI/JIgN0J39lmVCxQ2TuCZo
 JXBXbL0GsukvIx/3oo5JDt9pGOql4COz2gyh82QHnis0ssIlLtiNNgL23O0EDJOU00/BF81oVyA
 d58a5k99+BTYT48jsn1iwhsoIQaNvM2SQJcoE8FF6JeOqbElxHIUlp7L7ptRp6hNg2DFKQye4TZ
 DnJ1KTK0D9Se94Y/mmh2I1UBV/V6e+gaUPjzlq0ZVxwnNKlRtycg3Mjhv/0lTzGBlp+Bl+eE7g/
 7brRWwsZKFQ5Qgqu9kddHySyRFw4vwh55F6AqwHkg1EtoQWExp32wuEYmFa1j3Ap2p8TTTTlwVK
 dban4NYVGvUX/JjOynleWT2vjJ1Sz7/q5MFDcRNYcOuyP9b+jZPKfdD9BJHpPVkdE/OfPQV27r1 FhYPbS9aNfwli2Q==
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


