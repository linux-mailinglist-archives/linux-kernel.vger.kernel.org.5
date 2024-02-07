Return-Path: <linux-kernel+bounces-55821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D383784C21F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B4A1C218B1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1BBDDB3;
	Wed,  7 Feb 2024 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sgWUwPI"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973814A82
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270336; cv=none; b=HmlIM045MQRWOnQXhYUBzCf+JKmeH9fejgDAyhzNw1tlzjsRrPgf7TjVMWJwYLFRJit/NMWwjUe5kjPGSTiBIWFEVmKp/33s/fsaK2BYM6zCFF5lx4w5MEMUN3Ed0sechlMIrKBzPvSN3YzQVSim60vRNUY5Uu3UwGqfRPwf7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270336; c=relaxed/simple;
	bh=jtbEkMgACYBlVC9wzZ15NHjLL3L1OsM3ulBngMq6shI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaRYLbUTw9KXp6vC/rx1PZqseqos3+M2LYu4/qijRlZPxhNXum35ssVEcwI+b/ZORpzhtezXGr0Q3ykttuTBiKVjH83psj3jEsdnfyJ4BOSS31ZHxPEOrmiMgDw4OBr5pWyJCVRoiQuSINyFoFO1FDQUn5ir3hlwZoD8a59tbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sgWUwPI; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7beda6a274bso3832039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 17:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707270332; x=1707875132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i0KokQpsmVwCg2q3ckhuoiEueFde0IBUJuEJrRWd9+k=;
        b=2sgWUwPIMZo5yHQpLDEsTIg87duygcOX7FID7qtPV3d5YlWLAA01TuSmeQX5z3ZTfw
         WAnNZUeupSyJC/2nLa5YnPGuuEHquY3uAvFdfcjswCEJZ/paHIt6f4C1p7wTMloKhjOT
         wWIWNfDY7OhDZKOrQUR/AiH6HO7FBIplRQjbj2gh5eTjCH3/jxry4F2k33rn+KjtmuGr
         F/G9PJmj7X6IpUz5ugnYS+nY7Z5T0deLYKfx9hDMP6yYtzUSCHBRWvL7LAZOTd+bdAND
         sJ7xaeHqGEsmFJXSA5WaXBCaYL+mG8+N8boYOw4Ffvv6VIUmKM1J/jZD47YCAUuETOPY
         QKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707270332; x=1707875132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0KokQpsmVwCg2q3ckhuoiEueFde0IBUJuEJrRWd9+k=;
        b=CdqfwK4tXgTBPL/dGS5ywzRUmyJzauw+L3ZdsWQ76q8DpnwIXS0YhKP5nX1s+9vlEF
         xp2rZd092GA96uh0bG8SBeckPHFQnRhK5w5UcQJCVaa7qaDMqJUmi/T+3wJ9fIDlqAa4
         X/o6yvALhA/6HY+n5nFDH9/vDdH9PE/3ekLz9VJY440Cyk7BgsdNGYGngRP9Y2lR5WyJ
         hdjL1DEKOCW4j8/CgJaVz+o412LGOOeMTt1O63lOBcr6FndZysYa3t2AAWhuAupmwxCd
         qlkoG4aQmBIodZjaoZwcXYYbzNc8Ta8epgcOYpnHB+/xy1jCmepKevKoXEKG+lzFi77l
         +cBQ==
X-Gm-Message-State: AOJu0YyPC6e0OP1ohiMwuBiGaxhNw8WNKNf6hFSE0DSc9QECbr/rb+XL
	33qfLCkIRuVGP60cbQUwMeCOJko+P/M3ne++1QM28iDRvame5R9KtEX/1Aw6qA==
X-Google-Smtp-Source: AGHT+IHOt4QXtkEcxV9O1FCVDBJ/4GN43Js9KOnslqrb7D6ePsbS6hOblVbQghsMZL86x4PbfVNWaQ==
X-Received: by 2002:a05:6602:1d52:b0:7be:f7e5:44fc with SMTP id hi18-20020a0566021d5200b007bef7e544fcmr5190362iob.21.1707270332593;
        Tue, 06 Feb 2024 17:45:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgz0Bk3pqC37J5ry8Hitp4ra1NniLz7Y4v4Tphxf7iyTTW6uwWCALufaKvyh/+5X5pf8Ci3B/VwE4erM2dw7wNGsJN3BkWwQlckmsz+kD8rvAdJRrqdbfDHi7qI5NJ4SclpKgfkKskYgAe+Sgt+/8W+gy28AbW1X1tzm4ESG5ATlNDk+jetgjB5tbXMcK7/2YB7Spu6APCEKEq0JmT74M822R/XzG2ZYcvtXX4U3J/DohfzcR+IJ5j72zJ8fw37StRaKCVYftVKCQSzDicQNNK6PgzuE+DTJWrzuFLPDnwFqltv9slz53wterU3tt7jpG3HVknYUaq4+8UqKXEOa4HXUzpN2FuVoRQzByHikOw7ZTsEBeT2loLAmQ7991loj6fFB3yfkAr0YPCR1FjRjTkeMZKGISsAww5F7vouc9oR1sVxgjfAzAxHRi2hXzaemmLtz2BjUeG2owFlfGUo6lTAkZRtDDwwNYQ8PjUWnc1e/it9sD9+cb/dBJ8ADio1ra6HwSznQM=
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id ed7-20020a056638290700b004713a02614bsm29995jab.10.2024.02.06.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 17:45:31 -0800 (PST)
Date: Wed, 7 Feb 2024 01:45:28 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
Message-ID: <20240207014528.5byuufi5f33bl6e2@google.com>
References: <20240205093725.make.582-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205093725.make.582-kees@kernel.org>

Hi,

On Mon, Feb 05, 2024 at 01:37:29AM -0800, Kees Cook wrote:
> In order to mitigate unexpected signed wrap-around[1], bring back the
> signed integer overflow sanitizer. It was removed in commit 6aaa31aeb9cf
> ("ubsan: remove overflow checks") because it was effectively a no-op
> when combined with -fno-strict-overflow (which correctly changes signed
> overflow from being "undefined" to being explicitly "wrap around").
>
> Compilers are adjusting their sanitizers to trap wrap-around and to
> detecting common code patterns that should not be instrumented
> (e.g. "var + offset < var"). Prepare for this and explicitly rename
> the option from "OVERFLOW" to "WRAP".
>
> To annotate intentional wrap-around arithmetic, the add/sub/mul_wrap()
> helpers can be used for individual statements. At the function level,
> the __signed_wrap attribute can be used to mark an entire function as
> expecting its signed arithmetic to wrap around. For a single object file
> the Makefile can use "UBSAN_WRAP_SIGNED_target.o := n" to mark it as
> wrapping, and for an entire directory, "UBSAN_WRAP_SIGNED := n" can be
> used.
>
> Additionally keep these disabled under CONFIG_COMPILE_TEST for now.
>
> Link: https://github.com/KSPP/linux/issues/26 [1]
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Hao Luo <haoluo@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3:
>  - split out signed overflow sanitizer so we can do each separately
> v2: https://lore.kernel.org/all/20240202101311.it.893-kees@kernel.org/
> v1: https://lore.kernel.org/all/20240129175033.work.813-kees@kernel.org/
> ---
>  include/linux/compiler_types.h |  9 ++++-
>  lib/Kconfig.ubsan              | 14 +++++++
>  lib/test_ubsan.c               | 37 ++++++++++++++++++
>  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
>  lib/ubsan.h                    |  4 ++
>  scripts/Makefile.lib           |  3 ++
>  scripts/Makefile.ubsan         |  3 ++
>  7 files changed, 137 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..ee9d272008a5 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -282,11 +282,18 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>
> +/* Do not trap wrapping arithmetic within an annotated function. */
> +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> +#else
> +# define __signed_wrap
> +#endif
> +
>  /* Section for code which can't be instrumented at all */
>  #define __noinstr_section(section)					\
>  	noinline notrace __attribute((__section__(section)))		\
>  	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> -	__no_sanitize_memory
> +	__no_sanitize_memory __signed_wrap
>
>  #define noinstr __noinstr_section(".noinstr.text")
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 56d7653f4941..129e9bc21877 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -116,6 +116,20 @@ config UBSAN_UNREACHABLE
>  	  This option enables -fsanitize=unreachable which checks for control
>  	  flow reaching an expected-to-be-unreachable position.
>
> +config UBSAN_SIGNED_WRAP
> +	bool "Perform checking for signed arithmetic wrap-around"
> +	default UBSAN
> +	depends on !COMPILE_TEST
> +	depends on $(cc-option,-fsanitize=signed-integer-overflow)
> +	help
> +	  This option enables -fsanitize=signed-integer-overflow which checks
> +	  for wrap-around of any arithmetic operations with signed integers.
> +	  This currently performs nearly no instrumentation due to the
> +	  kernel's use of -fno-strict-overflow which converts all would-be
> +	  arithmetic undefined behavior into wrap-around arithmetic. Future
> +	  sanitizer versions will allow for wrap-around checking (rather than
> +	  exclusively undefined behavior).
> +
>  config UBSAN_BOOL
>  	bool "Perform checking for non-boolean values used as boolean"
>  	default UBSAN
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index f4ee2484d4b5..276c12140ee2 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -11,6 +11,39 @@ typedef void(*test_ubsan_fp)(void);
>  			#config, IS_ENABLED(config) ? "y" : "n");	\
>  	} while (0)
>
> +static void test_ubsan_add_overflow(void)
> +{
> +	volatile int val = INT_MAX;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val += 2;
> +}
> +
> +static void test_ubsan_sub_overflow(void)
> +{
> +	volatile int val = INT_MIN;
> +	volatile int val2 = 2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val -= val2;
> +}
> +
> +static void test_ubsan_mul_overflow(void)
> +{
> +	volatile int val = INT_MAX / 2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val *= 3;
> +}
> +
> +static void test_ubsan_negate_overflow(void)
> +{
> +	volatile int val = INT_MIN;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val = -val;
> +}
> +
>  static void test_ubsan_divrem_overflow(void)
>  {
>  	volatile int val = 16;
> @@ -90,6 +123,10 @@ static void test_ubsan_misaligned_access(void)
>  }
>
>  static const test_ubsan_fp test_ubsan_array[] = {
> +	test_ubsan_add_overflow,
> +	test_ubsan_sub_overflow,
> +	test_ubsan_mul_overflow,
> +	test_ubsan_negate_overflow,

I wouldn't mind also seeing a test_ubsan_div_overflow test case here.

It has some quirky behavior and it'd be nice to test that the sanitizers
properly capture it.

Check out this Godbolt: https://godbolt.org/z/qG5f1j6n1

tl;dr: with -fsanitize=signed-integer-overflow division (/) and
remainder (%) operators still instrument arithmetic even with
-fno-strict-overflow on.

This makes sense as division by 0 and INT_MIN/-1 are UBs that are not
influenced by -fno-strict-overflow.

Really though, the patch is fine and the above test case is optional and
can be shipped later -- as such:

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  	test_ubsan_shift_out_of_bounds,
>  	test_ubsan_out_of_bounds,
>  	test_ubsan_load_invalid_value,
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index df4f8d1354bb..5fc107f61934 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -222,6 +222,74 @@ static void ubsan_epilogue(void)
>  	check_panic_on_warn("UBSAN");
>  }
>
> +static void handle_overflow(struct overflow_data *data, void *lhs,
> +			void *rhs, char op)
> +{
> +
> +	struct type_descriptor *type = data->type;
> +	char lhs_val_str[VALUE_LENGTH];
> +	char rhs_val_str[VALUE_LENGTH];
> +
> +	if (suppress_report(&data->location))
> +		return;
> +
> +	ubsan_prologue(&data->location, type_is_signed(type) ?
> +			"signed-integer-overflow" :
> +			"unsigned-integer-overflow");
> +
> +	val_to_string(lhs_val_str, sizeof(lhs_val_str), type, lhs);
> +	val_to_string(rhs_val_str, sizeof(rhs_val_str), type, rhs);
> +	pr_err("%s %c %s cannot be represented in type %s\n",
> +		lhs_val_str,
> +		op,
> +		rhs_val_str,
> +		type->type_name);
> +
> +	ubsan_epilogue();
> +}
> +
> +void __ubsan_handle_add_overflow(void *data,
> +				void *lhs, void *rhs)
> +{
> +
> +	handle_overflow(data, lhs, rhs, '+');
> +}
> +EXPORT_SYMBOL(__ubsan_handle_add_overflow);
> +
> +void __ubsan_handle_sub_overflow(void *data,
> +				void *lhs, void *rhs)
> +{
> +	handle_overflow(data, lhs, rhs, '-');
> +}
> +EXPORT_SYMBOL(__ubsan_handle_sub_overflow);
> +
> +void __ubsan_handle_mul_overflow(void *data,
> +				void *lhs, void *rhs)
> +{
> +	handle_overflow(data, lhs, rhs, '*');
> +}
> +EXPORT_SYMBOL(__ubsan_handle_mul_overflow);
> +
> +void __ubsan_handle_negate_overflow(void *_data, void *old_val)
> +{
> +	struct overflow_data *data = _data;
> +	char old_val_str[VALUE_LENGTH];
> +
> +	if (suppress_report(&data->location))
> +		return;
> +
> +	ubsan_prologue(&data->location, "negation-overflow");
> +
> +	val_to_string(old_val_str, sizeof(old_val_str), data->type, old_val);
> +
> +	pr_err("negation of %s cannot be represented in type %s:\n",
> +		old_val_str, data->type->type_name);
> +
> +	ubsan_epilogue();
> +}
> +EXPORT_SYMBOL(__ubsan_handle_negate_overflow);
> +
> +
>  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
>  {
>  	struct overflow_data *data = _data;
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 5d99ab81913b..0abbbac8700d 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -124,6 +124,10 @@ typedef s64 s_max;
>  typedef u64 u_max;
>  #endif
>
> +void __ubsan_handle_add_overflow(void *data, void *lhs, void *rhs);
> +void __ubsan_handle_sub_overflow(void *data, void *lhs, void *rhs);
> +void __ubsan_handle_mul_overflow(void *data, void *lhs, void *rhs);
> +void __ubsan_handle_negate_overflow(void *_data, void *old_val);
>  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs);
>  void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr);
>  void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr);
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 52efc520ae4f..7ce8ecccc65a 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -177,6 +177,9 @@ ifeq ($(CONFIG_UBSAN),y)
>  _c_flags += $(if $(patsubst n%,, \
>  		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
>  		$(CFLAGS_UBSAN))
> +_c_flags += $(if $(patsubst n%,, \
> +		$(UBSAN_WRAP_SIGNED_$(basetarget).o)$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_WRAP_SIGNED)$(UBSAN_SANITIZE)y), \
> +		$(CFLAGS_UBSAN_WRAP_SIGNED))
>  endif
>
>  ifeq ($(CONFIG_KCOV),y)
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 7cf42231042b..bc957add0b4d 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -13,3 +13,6 @@ ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
>  ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
>
>  export CFLAGS_UBSAN := $(ubsan-cflags-y)
> +
> +ubsan-wrap-signed-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)     += -fsanitize=signed-integer-overflow
> +export CFLAGS_UBSAN_WRAP_SIGNED := $(ubsan-wrap-signed-cflags-y)
> --
> 2.34.1
>

Thanks
Justin

