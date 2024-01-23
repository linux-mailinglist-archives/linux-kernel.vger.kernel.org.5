Return-Path: <linux-kernel+bounces-34474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2808837CEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D488AB2AAE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71182157035;
	Tue, 23 Jan 2024 00:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g6KI+FqU"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B7156984
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969728; cv=none; b=LWr3IgeNuT86QrgSB4bo4akKKP+ISB1ZqngWG0aBsSVMk0puogdWdUzMxgKPeNZYl3+Kn69tp7Nh1xaEw8xdmqB8E0R3aB90IvDC6TSzJlxAUk1OqvX+11kd5hEtQV3DIJVPiNO1Ig7aDiqEJVOC1QsXUxtZsaW42Tmpb3pVLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969728; c=relaxed/simple;
	bh=C+paLqxuFlWRTx/mjhIvhRPgaDtYk9vCEUD11OqlcCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHzj+K6p2q1EGkLN8HpzhPYWBwCXdBCrKaIiEDEWSXtewURO+9HHNFwa3P38XfE2i5cYbDVnxCTPqK62J3ZDQWBbpQF56LLdmdr7GVefMhsNohyqMmrIaihQyk4gEIhx4LwuBnV/CdMy77necJTyBImqZh3dZf6TfrwWMOqZdBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g6KI+FqU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d720c7fc04so19100585ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969726; x=1706574526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOuaDiRRvzJvgJST5lr851xVVDyg4sr9GwwDxREBfGs=;
        b=g6KI+FqUBOdebEdDOJA1SK+ASpBYukkrOtOGOPNBHOWE8PjMl3/IB1eyxjiqtg95fp
         vOaYbEV32Fz9zEtJtkHDqhqRIrSvE+gi9y+DzkhQuTdPr7K59UNpI2ewNxLOCOqH8iFZ
         YW0vpdlt7kiQ6KAt93LianzuAfMpZJrURgX8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969726; x=1706574526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOuaDiRRvzJvgJST5lr851xVVDyg4sr9GwwDxREBfGs=;
        b=XnFUEHtAFR5zPYnv1eT7eGnWAh8IcBpfyvZvqd45PBQ2eXGKcmlNDUlEUAIHXiy5Z7
         NtAg3K9/Q0x2idaKXwWGZb34c0jdIcFhTlFCrmkHNcCFevw3NZ2Dynp1qrjhuvv38H0w
         EqjeuCwrMfPMFjKWzsEo1sI89hf0bJK5KlhIAOg/17KL0nOaZFUTm+KV/Q3h0qNqk3Tm
         OUZ9ia43eO+8VkwUHOQ0pNtidtAgz7e/GS3R/p/U4AojbamTguLFTA7HqPEV4hpakLKq
         wMUFYeiG1SWEC/AuZB9e7lHVUyKX9XUlA9lpQhp18URqRoG4aJCvSOlMHgzdwO/vh12l
         bsxQ==
X-Gm-Message-State: AOJu0YzEYl/HGhCCJpW1YKnH475Uw5Mry1pihkbqODeN3GtE2Z5a0qCZ
	cuT34zbCnJZgqrmCNGLMywLcmK1v7mbWLZI1vs9B6dKlt2Wszom2Xu/R8FibwBqGesPFGLoawQw
	=
X-Google-Smtp-Source: AGHT+IEnqWEYs303ftT0O03yNmO4noVosyfBeQ8RPYpodKlYMbGKmtGGYH7WmtuBxDCTsLTefsiwSA==
X-Received: by 2002:a17:903:2782:b0:1d7:6343:e0f3 with SMTP id jw2-20020a170903278200b001d76343e0f3mr1050390plb.113.1705969726027;
        Mon, 22 Jan 2024 16:28:46 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902bd4500b001d74c170f2dsm2628770plx.90.2024.01.22.16.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:37 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/82] overflow: Introduce CONFIG_UBSAN_POINTER_WRAP
Date: Mon, 22 Jan 2024 16:26:42 -0800
Message-Id: <20240123002814.1396804-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6942; i=keescook@chromium.org;
 h=from:subject; bh=C+paLqxuFlWRTx/mjhIvhRPgaDtYk9vCEUD11OqlcCI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgE1og5efJNhjKy5Q1+0ssByVxR6aJKZkw//
 XUDXODt8X2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 Jhb8D/oClO4uy32MUB/8Q9w0fFrcHiAthgnFfgxXS9v7zpnRqWirFxjdNMvEosVHK1wH10OEvQj
 OzrmAnWj9nGt2vZCAGk0Yel0I5e05q57I9rK5Qc2H1/5zTunlMIphYJBCzGp6ySKTYuOCEtRzVj
 cIIbHxJbOh9Z9TU3SweMVfOG4LrSqDyzCE0TKxiQkjt9fG7NuoKdqkHQySCMH9kd+6BZjGjP0jK
 yk5/X2K5lR3aTv+dZcsANfdk8s7z3u7yuXGp2rBtZmcs4RrsgsFEjR0fAggKx/65aE2eoZocs3v
 X7RwQbqPdPZef6+GKbEbDFShLokOsGmn2vmyGOi66Ph1buPm5OQsQ1zCU+75rHdTou7wxYLt3li
 nC91e512ZPlE5upQjtRb4BIl+Gnr0kI7IlF9YctYSwGg9QpWB1syjbwVW/53Q9i/lyt8Q/VwE7Z
 AzzKMJJ4Ry+vZomftuWws7kHewjOxEwzwiAJgRZl1a9TOsUq66KTXyRXDob1K7ALMVhO+nh0ftk
 50+m7VWiGiPujZu6hAMGYjMG7dyFAgfeGhrByYKN+DU0G2UOoihqStFIJJwRdUCfoqwvbzFXzej
 fihfMb64SYCKKrJ92PZVSi3mIZ4WYycTSaLsmDsbMUHFBoJXW/2h759jKxMBt7p9/AQU06Q7YNF uiXs1EiNMEkG9dA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Gain coverage for pointer wrap-around checking. Adds support for
-fsanitize=pointer-overflow, and introduces the __pointer_wrap function
attribute to match the signed and unsigned attributes. Also like the
others, it is currently disabled under CONFIG_COMPILE_TEST.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst |  2 +-
 include/linux/compiler_types.h       |  7 +++++-
 lib/Kconfig.ubsan                    |  8 +++++++
 lib/test_ubsan.c                     | 33 ++++++++++++++++++++++++++++
 lib/ubsan.c                          | 21 ++++++++++++++++++
 lib/ubsan.h                          |  1 +
 scripts/Makefile.ubsan               |  1 +
 7 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index aebd7c6cd2fc..15e77cbd4259 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -143,7 +143,7 @@ replaced with a type max subtraction test instead::
 
 For inline helpers that are performing wrapping arithmetic, the entire
 function can be annotated as intentionally wrapping by adding the
-`__signed_wrap` or `__unsigned_wrap` function attribute.
+`__signed_wrap`, `__unsigned_wrap`, or `__pointer_wrap` function attribute.
 
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d24f43fc79c6..84cfd9d55453 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -293,12 +293,17 @@ struct ftrace_likely_data {
 #else
 # define __unsigned_wrap
 #endif
+#ifdef CONFIG_UBSAN_POINTER_WRAP
+# define __pointer_wrap __attribute__((no_sanitize("pointer-overflow")))
+#else
+# define __pointer_wrap
+#endif
 
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
-	__no_sanitize_memory __signed_wrap __unsigned_wrap
+	__no_sanitize_memory __signed_wrap __unsigned_wrap __pointer_wrap
 
 #define noinstr __noinstr_section(".noinstr.text")
 
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index a7003e5bd2a1..04222a6d7fd9 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -135,6 +135,14 @@ config UBSAN_UNSIGNED_WRAP
 	  for wrap-around of any arithmetic operations with unsigned integers. This
 	  currently causes x86 to fail to boot.
 
+config UBSAN_POINTER_WRAP
+	bool "Perform checking for pointer arithmetic wrap-around"
+	depends on !COMPILE_TEST
+	depends on $(cc-option,-fsanitize=pointer-overflow)
+	help
+	  This option enables -fsanitize=pointer-overflow which checks
+	  for wrap-around of any arithmetic operations with pointers.
+
 config UBSAN_BOOL
 	bool "Perform checking for non-boolean values used as boolean"
 	default UBSAN
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index 84d8092d6c32..1cc049b3ef34 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -56,6 +56,36 @@ static void test_ubsan_negate_overflow(void)
 	val = -val;
 }
 
+static void test_ubsan_pointer_overflow_add(void)
+{
+	volatile void *top = (void *)ULONG_MAX;
+
+	UBSAN_TEST(CONFIG_UBSAN_POINTER_WRAP);
+	top += 2;
+}
+
+static void test_ubsan_pointer_overflow_sub(void)
+{
+	volatile void *bottom = (void *)1;
+
+	UBSAN_TEST(CONFIG_UBSAN_POINTER_WRAP);
+	bottom -= 3;
+}
+
+struct ptr_wrap {
+	int a;
+	int b;
+};
+
+static void test_ubsan_pointer_overflow_mul(void)
+{
+	volatile struct ptr_wrap *half = (void *)(ULONG_MAX - 128);
+	volatile int bump = 128;
+
+	UBSAN_TEST(CONFIG_UBSAN_POINTER_WRAP);
+	half += bump;
+}
+
 static void test_ubsan_divrem_overflow(void)
 {
 	volatile int val = 16;
@@ -139,6 +169,9 @@ static const test_ubsan_fp test_ubsan_array[] = {
 	test_ubsan_sub_overflow,
 	test_ubsan_mul_overflow,
 	test_ubsan_negate_overflow,
+	test_ubsan_pointer_overflow_add,
+	test_ubsan_pointer_overflow_sub,
+	test_ubsan_pointer_overflow_mul,
 	test_ubsan_shift_out_of_bounds,
 	test_ubsan_out_of_bounds,
 	test_ubsan_load_invalid_value,
diff --git a/lib/ubsan.c b/lib/ubsan.c
index 5fc107f61934..d49580ff6aea 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -289,6 +289,27 @@ void __ubsan_handle_negate_overflow(void *_data, void *old_val)
 }
 EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
 
+void __ubsan_handle_pointer_overflow(void *_data, void *lhs, void *rhs)
+{
+	struct overflow_data *data = _data;
+	unsigned long before = (unsigned long)lhs;
+	unsigned long after  = (unsigned long)rhs;
+
+	if (suppress_report(&data->location))
+		return;
+
+	ubsan_prologue(&data->location, "pointer-overflow");
+
+	if (after == 0)
+		pr_err("overflow wrapped to NULL\n");
+	else if (after < before)
+		pr_err("overflow wrap-around\n");
+	else
+		pr_err("underflow wrap-around\n");
+
+	ubsan_epilogue();
+}
+EXPORT_SYMBOL(__ubsan_handle_pointer_overflow);
 
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
 {
diff --git a/lib/ubsan.h b/lib/ubsan.h
index 0abbbac8700d..5dd27923b78b 100644
--- a/lib/ubsan.h
+++ b/lib/ubsan.h
@@ -128,6 +128,7 @@ void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
 void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
 void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
 void __ubsan_handle_negate_overflow(void *_data, void *old_val);
+void __ubsan_handle_pointer_overflow(void *_data, void *lhs, void *rhs);
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
 void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
 void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index de4fc0ae448a..37e8c31dc655 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -10,6 +10,7 @@ ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
 ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
 ubsan-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)	+= -fsanitize=signed-integer-overflow
 ubsan-cflags-$(CONFIG_UBSAN_UNSIGNED_WRAP)	+= -fsanitize=unsigned-integer-overflow
+ubsan-cflags-$(CONFIG_UBSAN_POINTER_WRAP)	+= -fsanitize=pointer-overflow
 ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
 ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= -fsanitize-undefined-trap-on-error
-- 
2.34.1


