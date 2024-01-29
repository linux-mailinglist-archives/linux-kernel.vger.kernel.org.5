Return-Path: <linux-kernel+bounces-43441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063CF8413EB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE06D1C2383F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B31534F3;
	Mon, 29 Jan 2024 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vti8ww/0"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2915AACA
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558066; cv=none; b=STYuG9OEr4Cd8K5fkeJXYO/XCR2H6maMFf4olASjPyRRNUqg5z6Q3AW/IXxySKnsQaS/ZcslR8Gu8De0uVtPDC+51GDWGobOpCsN9cTkCPAKRivLbf/pcsPGfax4FDuNikcy42mq0X01QzgQAPYTFO0ZlXfQ8ddsvTaWSXRZNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558066; c=relaxed/simple;
	bh=BmB9HD/0oImUWK+FJoOIjIqHiWYHgFrIwZ31s6gU7dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRkG9A7McxFPJdNsj9i4NE65UzYCrKZ45yhTo1/mOctmAgp30VzfgDA9nn40qzZfvJiecK3Axy+GL+ngCBDQwQtU6vBQwMMCYgwvODCBs/ee9W51m8cnd6GpTZBGUr+/0Hx1pAnxf92dndLf+R6XPDwNxD9A2WRgq/nPRUCOVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vti8ww/0; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3637f958e9dso2364195ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706558063; x=1707162863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcVAcQ9OJEQmpN6kmfYHE7jDRpZRaq/hjpCR1i+9f+E=;
        b=Vti8ww/0+Q98CMqkQMV0V+cKjCPqrV5sG61dNGmG0Zdta9NhzAbQ8l/hT6PM8l+HxT
         9eZzpw2psArLkaiRPQIQYEsCUc+zkLUZp6Q4lB+0LVjmT0fl96sTGrLdbr/D9CwRLal1
         AAwjffcI/u4Isp2wvMP43eJlovmHUdJlEHBW+fEj7rwmmvzF3CQ15BohQ8woHeLdDZqM
         E7xexJHmn3sxtDIcaIF1pbydewdD+YgEL6i0HYe+TotTa1NZhfH0c60NpTNLlYpZ2q38
         OoF6ApPDmz+07N5lCxRAeHhK2ncqFr76ld6Ok+usgTkdT3G7QFb0izT15N53dcs3e/ZC
         rq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558063; x=1707162863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcVAcQ9OJEQmpN6kmfYHE7jDRpZRaq/hjpCR1i+9f+E=;
        b=lspoQgJZ6FEeERqHL2hKrOqDDQJzE91lQdxFkSr+8+ALi6A9SWvJ1yi6TnZDGvl3rV
         KqowDeD1nLkrf59ebZNX9VxgDgRgnM2pe3SVLr7Ez6AB4iJdXr4utJxKk7idRha56z6x
         OrAJDe1lmvYUZk1ykkIWuqP9osGzjtVEwr/a8qZARY2255NhMolK18Gf72DM5WKa1BO8
         tOR0kKk9XMaZkne0iLWSdlnn3Ahn4Jwc8EJhRiatWMjC4dp5EGeCb+xR4rXwHDqJPga1
         dEXplv0/PNuJoY3R/fAjWWon8FUc+FYn5PDTu7yspy2nlOOgrGwk88WZg/M7l4K3/t/n
         Af3A==
X-Gm-Message-State: AOJu0YzrliWViftlWNZSsr8wJ9rGQs+aFiSrh5hImzEa59TewCBNZtE1
	mojACZ2JOscfidIykIKK83Tzwq/yEIKCke+tUwMkoQtNmOj4apNx574BTwgTUA==
X-Google-Smtp-Source: AGHT+IHOT+jrnyXxabnuVwgSk+ZeYFjT4UJk6UQVj4fGy1DYzC2Q/uxEWRfqsv8HGecsM0cphHHXKQ==
X-Received: by 2002:a92:dd0d:0:b0:363:7ed8:f12c with SMTP id n13-20020a92dd0d000000b003637ed8f12cmr2725452ilm.11.1706558063352;
        Mon, 29 Jan 2024 11:54:23 -0800 (PST)
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id y9-20020a92d209000000b00363797f6b00sm1379580ily.8.2024.01.29.11.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 11:54:22 -0800 (PST)
Date: Mon, 29 Jan 2024 19:54:18 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Marco Elver <elver@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Fangrui Song <maskray@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/6] ubsan: Reintroduce signed and unsigned overflow
 sanitizers
Message-ID: <20240129195418.hftkcdksptmpfv3i@google.com>
References: <20240129175033.work.813-kees@kernel.org>
 <20240129180046.3774731-2-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129180046.3774731-2-keescook@chromium.org>

Hi,

On Mon, Jan 29, 2024 at 10:00:39AM -0800, Kees Cook wrote:
> Effectively revert commit 6aaa31aeb9cf ("ubsan: remove overflow
> checks"), to allow the kernel to be built with the "overflow"
> sanitizers again. This gives developers a chance to experiment[1][2][3]
> with the instrumentation again, while compilers adjust their sanitizers
> to deal with the impact of -fno-strict-oveflow (i.e. moving from
> "overflow" checking to "wrap-around" checking).
>
> Notably, the naming of the options is adjusted to use the name "WRAP"
> instead of "OVERFLOW". In the strictest sense, arithmetic "overflow"
> happens when a result exceeds the storage of the type, and is considered
> by the C standard and compilers to be undefined behavior for signed
> and pointer types (without -fno-strict-overflow). Unsigned arithmetic
> overflow is defined as always wrapping around.
>
> Because the kernel is built with -fno-strict-overflow, signed and pointer
> arithmetic is defined to always wrap around instead of "overflowing"
> (which could either be elided due to being undefined behavior or would
> wrap around, which led to very weird bugs in the kernel).
>
> So, the config options are added back as CONFIG_UBSAN_SIGNED_WRAP and
> CONFIG_UBSAN_UNSIGNED_WRAP. Since the kernel has several places that
> explicitly depend on wrap-around behavior (e.g. counters, atomics, crypto,
> etc), also introduce the __signed_wrap and __unsigned_wrap function
> attributes for annotating functions where wrapping is expected and should
> not be instrumented. This will allow us to distinguish in the kernel
> between intentional and unintentional cases of arithmetic wrap-around.
>
> Additionally keep these disabled under CONFIG_COMPILE_TEST for now.

This is present in the patch but perhaps its worth noting here that x86
has trouble booting with the unsigned-integer-overflow sanitizer on.

>
> Link: https://github.com/KSPP/linux/issues/26 [1]
> Link: https://github.com/KSPP/linux/issues/27 [2]
> Link: https://github.com/KSPP/linux/issues/344 [3]
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>


This patch adheres to the language semantics as I understand them.
Moreover, we would've had to send a patch similar to this once we land
some better sanitizer + -fno-strict-oveflow support in the compilers.

Currently, though, -fsanitize=signed-integer-overflow instruments very
little (if anything at all) due to compiler optimizations in conjunction
with -fno-strict-oveflow. I am working on a new
-fsanitize=signed-integer-wrap in Clang which will instrument more
arithmetic even under -fno-strict-oveflow.


Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  include/linux/compiler_types.h | 14 ++++++-
>  lib/Kconfig.ubsan              | 19 ++++++++++
>  lib/test_ubsan.c               | 49 ++++++++++++++++++++++++
>  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
>  lib/ubsan.h                    |  4 ++
>  scripts/Makefile.ubsan         |  2 +
>  6 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 6f1ca49306d2..e585614f3152 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -282,11 +282,23 @@ struct ftrace_likely_data {
>  #define __no_sanitize_or_inline __always_inline
>  #endif
>
> +/* Allow wrapping arithmetic within an annotated function. */
> +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> +#else
> +# define __signed_wrap
> +#endif
> +#ifdef CONFIG_UBSAN_UNSIGNED_WRAP
> +# define __unsigned_wrap __attribute__((no_sanitize("unsigned-integer-overflow")))
> +#else
> +# define __unsigned_wrap
> +#endif
> +
>  /* Section for code which can't be instrumented at all */
>  #define __noinstr_section(section)					\
>  	noinline notrace __attribute((__section__(section)))		\
>  	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> -	__no_sanitize_memory
> +	__no_sanitize_memory __signed_wrap __unsigned_wrap
>
>  #define noinstr __noinstr_section(".noinstr.text")
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 59e21bfec188..a7003e5bd2a1 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -116,6 +116,25 @@ config UBSAN_UNREACHABLE
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
> +
> +config UBSAN_UNSIGNED_WRAP
> +	bool "Perform checking for unsigned arithmetic wrap-around"
> +	depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> +	depends on !X86_32 # avoid excessive stack usage on x86-32/clang
> +	depends on !COMPILE_TEST
> +	help
> +	  This option enables -fsanitize=unsigned-integer-overflow which checks
> +	  for wrap-around of any arithmetic operations with unsigned integers. This
> +	  currently causes x86 to fail to boot.
> +
>  config UBSAN_BOOL
>  	bool "Perform checking for non-boolean values used as boolean"
>  	default UBSAN
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 2062be1f2e80..84d8092d6c32 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -11,6 +11,51 @@ typedef void(*test_ubsan_fp)(void);
>  			#config, IS_ENABLED(config) ? "y" : "n");	\
>  	} while (0)
>
> +static void test_ubsan_add_overflow(void)
> +{
> +	volatile int val = INT_MAX;
> +	volatile unsigned int uval = UINT_MAX;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val += 2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
> +	uval += 2;
> +}
> +
> +static void test_ubsan_sub_overflow(void)
> +{
> +	volatile int val = INT_MIN;
> +	volatile unsigned int uval = 0;
> +	volatile int val2 = 2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val -= val2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
> +	uval -= val2;
> +}
> +
> +static void test_ubsan_mul_overflow(void)
> +{
> +	volatile int val = INT_MAX / 2;
> +	volatile unsigned int uval = UINT_MAX / 2;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_SIGNED_WRAP);
> +	val *= 3;
> +
> +	UBSAN_TEST(CONFIG_UBSAN_UNSIGNED_WRAP);
> +	uval *= 3;
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
> @@ -90,6 +135,10 @@ static void test_ubsan_misaligned_access(void)
>  }
>
>  static const test_ubsan_fp test_ubsan_array[] = {
> +	test_ubsan_add_overflow,
> +	test_ubsan_sub_overflow,
> +	test_ubsan_mul_overflow,
> +	test_ubsan_negate_overflow,
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
> diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
> index 7cf42231042b..7b2f3d554c59 100644
> --- a/scripts/Makefile.ubsan
> +++ b/scripts/Makefile.ubsan
> @@ -8,6 +8,8 @@ ubsan-cflags-$(CONFIG_UBSAN_LOCAL_BOUNDS)	+= -fsanitize=local-bounds
>  ubsan-cflags-$(CONFIG_UBSAN_SHIFT)		+= -fsanitize=shift
>  ubsan-cflags-$(CONFIG_UBSAN_DIV_ZERO)		+= -fsanitize=integer-divide-by-zero
>  ubsan-cflags-$(CONFIG_UBSAN_UNREACHABLE)	+= -fsanitize=unreachable
> +ubsan-cflags-$(CONFIG_UBSAN_SIGNED_WRAP)	+= -fsanitize=signed-integer-overflow
> +ubsan-cflags-$(CONFIG_UBSAN_UNSIGNED_WRAP)	+= -fsanitize=unsigned-integer-overflow
>  ubsan-cflags-$(CONFIG_UBSAN_BOOL)		+= -fsanitize=bool
>  ubsan-cflags-$(CONFIG_UBSAN_ENUM)		+= -fsanitize=enum
>  ubsan-cflags-$(CONFIG_UBSAN_TRAP)		+= $(call cc-option,-fsanitize-trap=undefined,-fsanitize-undefined-trap-on-error)
> --
> 2.34.1
>

Thanks
Justin

