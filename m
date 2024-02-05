Return-Path: <linux-kernel+bounces-52330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439B08496C9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF019B26383
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E4134BD;
	Mon,  5 Feb 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oXJjv6tp"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D6134BC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125857; cv=none; b=t0PFh0awDclfKVOicLjzogMzFdNUY1SijOrE4AMpCGY9B5ickfAjC/FIfKLEsf7rZQJ14UZ6FizxCbttiw0V9mOdv5XHmi/GCBjSCUkjr3Hc3hhWQPyhnuM1xo0d00XUUiitQf7nq+yLwahcuuxAAkyIxrTdwYut2Qr/1Wwy46k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125857; c=relaxed/simple;
	bh=B843R/+qtzUW3zjHJinDtuKnCc/TO3v2V71CYIstgfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qO9CAS6qw7iux6YlUObHZi03eYOSP+k1uc17ZZxPl0B1pub+ArYvilSC0adplc4yy96CAtF+dBQC0YQyUNdIkOdfjZkd4XmrDgLkXCZXM/br0BWQZdXxOUFV7RowPnHjLKrKIAMnfTmYiK0TPFsov6aWfiHFIQJUpNHevwU9Kas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oXJjv6tp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bfdc1c0a2aso342310b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707125854; x=1707730654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxCwwNCdFbhbOkkNs+XeuXGgPs25hYCl4cEcrHgPhro=;
        b=oXJjv6tpeTInbFER7BJT/G1+/+96mWP/AEjxlQ0ynlKGuk0hPgdJXDxwWHEIuUQ/RL
         YcYBlPKsqL+d9UROHLh0nlNS207Pemas+oH1S39ee2CJd9BdjyGUs+wHEUvovCf9A/5c
         tI8V0sJ+XrVUvj9R2WhcBKmWY2USRi8lxr9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125854; x=1707730654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxCwwNCdFbhbOkkNs+XeuXGgPs25hYCl4cEcrHgPhro=;
        b=DYVpzUEpTbTSkdvYFQZC1InsdinXK1Gj7SIH8zCYIqdfdJjaAk4Qy7IU4XuUpREkE5
         a4quOJ+BVNjQKJBmnE4GbKm13YYf3xTjP2UwA4qt9LNA6AQVMHrhluSQPzKE+RxvBPGW
         rOeAx/ITEsgug7Ji+WQ8xlrx4iCcyavEvC7/8SMIbhtrlYKDuCo7dNxwNks6FiZSCTDB
         ByC6DvUH8jNnKHLw9ZQWhvqYdP2fmKFc5dmoEhR40jmqpBdZ6UbYVbYq16XmIi4zTx5A
         SQWxfKu8PJHRLsPmgfuvIflsw+duTFwSfqUh9ZALdIbzhNZuznF22cKujxol6mVfDKD5
         2zyA==
X-Gm-Message-State: AOJu0Yzzj7jbD7DXt25PKO1/AkFZmwcqmShGayF4Vns60ws/CsjoksKi
	SGCWZW6j2yVvrU4Ip5N6XF6AUEFAEt7/ALPtG1HWZb8E70h+o7s4I/n80pmYzA==
X-Google-Smtp-Source: AGHT+IH/AzQzMwf5V2WCJ5LTkocAFHTct/NGGVoG1H1fT6+Hf9gys/2B65Dqa045gFa0DxfkTjSxsQ==
X-Received: by 2002:a05:6808:2f19:b0:3bf:d03b:327e with SMTP id gu25-20020a0568082f1900b003bfd03b327emr7791024oib.37.1707125854639;
        Mon, 05 Feb 2024 01:37:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXVnQMrzKpeRhuVQrxp8VL7XJSRIXie8Q1oeHWosnnXQB8icBA/Txx5Bep55wKUE29kmWnWiwca9tXC0Xq3xutLgoWD3tjkRsQmQijkPblNLO90yMop4RWbwkUAB9OuZ819QaZ0KKo+TDt4JDwv5+Z2oJwCidg/e9HL4sHZb3EfxDiWR00ZyZzZzuZkoeCalaf+HpziR51EcG+ckrDslHH+fXCBtGAojttYIJJoIXtanHAp4pOZdx/OLGZJo2yw/xqKeMndx2ILSLyk51oiplPBLX1q9tsFwAY/3u9Y+bv4PSozQ5i/ucvQKWfqCVU7SAyzgbj5rGeKWmo9mhkxHP3BCmjzTF8PpxJWeCOB5phLZaN2Uu1RS+aNkA9nNvU/cIeHvlWADOYveybspKRNGa3xoP8pTUQ+5rmgjkLiQXFz5jPGp/LzrIyd8hpuzStuSmAsVPxnfjX+U/BSBA3b5JoTzLMb9945xkNihdxMx+WkpkTB1vFnVWrBrncFiLCPhpV6nbMZIX5JjYltarZcycmMCQDSaL2kMz8=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a056a001acb00b006e025ce0beesm4404980pfv.168.2024.02.05.01.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:37:34 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Marco Elver <elver@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Hao Luo <haoluo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
Date: Mon,  5 Feb 2024 01:37:29 -0800
Message-Id: <20240205093725.make.582-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9230; i=keescook@chromium.org;
 h=from:subject:message-id; bh=B843R/+qtzUW3zjHJinDtuKnCc/TO3v2V71CYIstgfg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwKxZBzdKuy8ud3pw8T9E2DmYiTfvHCUk0jD3N
 BpCnUym4ymJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcCsWQAKCRCJcvTf3G3A
 JskhD/9JYCTa5wf7FnS2pCfrha9Oi4N2gM5sZR7OejTK1cL0yvoY/mqDblqC/xbWC5YGpEDFa9j
 0IuFkJgnmQBhA/0gV4sMZxuBJPbIIn8rrygEh3heAnQ9dX2foVh5aLtjbZjLnZcwT1T4bOjn+HD
 0Adl/jOw+r2VCZwI5mU7tkJWfNBRF5Y4X7JE4cemkFF+4sSepRiGd32bH6p1vWVHwN4ogNFPkL/
 OMMNH3XBgW6Eu7iVZ9SwIyUi319l7PPecOLrfJDhSVkF4q4pCT8+KpzTsaI3RUI1mJQNnNpkARs
 JY1mhhGC+oWxSYgxbWQpZA35MsQrTFuXiW9QK19LuQyemiOxnYOBJDJp1rdu/rOD9dFfEVfFVF1
 Y+dFNNYQUuZnyneTNrWuTnk2Y1yLEz0J4BtyDxVRcO7OjndoLnvp8rYrObO80E582TaYWax9Uih
 C/s1a0/AfT5jzOe24HJsV8AqVFHesweBs0ufcOO+3zdW93XzMoXcnXGmjVlJMqrDXqRfvvRKV7U
 2DRujLplJ+lq/7xoZSliQfe3Oez8vtEfThBJgWm/YjHL1wboWmGWciJiuTHycbkwqtyYZrHz77P
 69fc+OOIqCZrFpWxZMaFBCa/YhSUPJRK8BjH/TtrHiDsAmoxcyGVUyeTUczDH0i9xoHwhYGb/Wx
 THR8NEt ni7QzfXA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In order to mitigate unexpected signed wrap-around[1], bring back the
signed integer overflow sanitizer. It was removed in commit 6aaa31aeb9cf
("ubsan: remove overflow checks") because it was effectively a no-op
when combined with -fno-strict-overflow (which correctly changes signed
overflow from being "undefined" to being explicitly "wrap around").

Compilers are adjusting their sanitizers to trap wrap-around and to
detecting common code patterns that should not be instrumented
(e.g. "var + offset < var"). Prepare for this and explicitly rename
the option from "OVERFLOW" to "WRAP".

To annotate intentional wrap-around arithmetic, the add/sub/mul_wrap()
helpers can be used for individual statements. At the function level,
the __signed_wrap attribute can be used to mark an entire function as
expecting its signed arithmetic to wrap around. For a single object file
the Makefile can use "UBSAN_WRAP_SIGNED_target.o := n" to mark it as
wrapping, and for an entire directory, "UBSAN_WRAP_SIGNED := n" can be
used.

Additionally keep these disabled under CONFIG_COMPILE_TEST for now.

Link: https://github.com/KSPP/linux/issues/26 [1]
Cc: Justin Stitt <justinstitt@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hao Luo <haoluo@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v3:
 - split out signed overflow sanitizer so we can do each separately
v2: https://lore.kernel.org/all/20240202101311.it.893-kees@kernel.org/
v1: https://lore.kernel.org/all/20240129175033.work.813-kees@kernel.org/
---
 include/linux/compiler_types.h |  9 ++++-
 lib/Kconfig.ubsan              | 14 +++++++
 lib/test_ubsan.c               | 37 ++++++++++++++++++
 lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
 lib/ubsan.h                    |  4 ++
 scripts/Makefile.lib           |  3 ++
 scripts/Makefile.ubsan         |  3 ++
 7 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 6f1ca49306d2..ee9d272008a5 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -282,11 +282,18 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/* Do not trap wrapping arithmetic within an annotated function. */
+#ifdef CONFIG_UBSAN_SIGNED_WRAP
+# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
+#else
+# define __signed_wrap
+#endif
+
 /* Section for code which can't be instrumented at all */
 #define __noinstr_section(section)					\
 	noinline notrace __attribute((__section__(section)))		\
 	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
-	__no_sanitize_memory
+	__no_sanitize_memory __signed_wrap
 
 #define noinstr __noinstr_section(".noinstr.text")
 
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 56d7653f4941..129e9bc21877 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -116,6 +116,20 @@ config UBSAN_UNREACHABLE
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
+	  This currently performs nearly no instrumentation due to the
+	  kernel's use of -fno-strict-overflow which converts all would-be
+	  arithmetic undefined behavior into wrap-around arithmetic. Future
+	  sanitizer versions will allow for wrap-around checking (rather than
+	  exclusively undefined behavior).
+
 config UBSAN_BOOL
 	bool "Perform checking for non-boolean values used as boolean"
 	default UBSAN
diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
index f4ee2484d4b5..276c12140ee2 100644
--- a/lib/test_ubsan.c
+++ b/lib/test_ubsan.c
@@ -11,6 +11,39 @@ typedef void(*test_ubsan_fp)(void);
 			#config, IS_ENABLED(config) ? "y" : "n");	\
 	} while (0)
 
+static void test_ubsan_add_overflow(void)
+{
+	volatile int val = INT_MAX;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val += 2;
+}
+
+static void test_ubsan_sub_overflow(void)
+{
+	volatile int val = INT_MIN;
+	volatile int val2 = 2;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val -= val2;
+}
+
+static void test_ubsan_mul_overflow(void)
+{
+	volatile int val = INT_MAX / 2;
+
+	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
+	val *= 3;
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
@@ -90,6 +123,10 @@ static void test_ubsan_misaligned_access(void)
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
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 52efc520ae4f..7ce8ecccc65a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -177,6 +177,9 @@ ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
 		$(CFLAGS_UBSAN))
+_c_flags += $(if $(patsubst n%,, \
+		$(UBSAN_WRAP_SIGNED_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_WRAP_SIGNED)$(UBSAN_SANITIZE)y), \
+		$(CFLAGS_UBSAN_WRAP_SIGNED))
 endif
 
 ifeq ($(CONFIG_KCOV),y)
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 7cf42231042b..bc957add0b4d 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -13,3 +13,6 @@ ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
 ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
 
 export CFLAGS_UBSAN := $(ubsan-cflags-y)
+
+ubsan-wrap-signed-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)     += -fsanitize=signed-integer-overflow
+export CFLAGS_UBSAN_WRAP_SIGNED := $(ubsan-wrap-signed-cflags-y)
-- 
2.34.1


