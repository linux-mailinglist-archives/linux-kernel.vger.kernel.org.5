Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82118773D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjHHQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjHHQOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:14:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F2213AAB;
        Tue,  8 Aug 2023 08:40:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 681661576;
        Tue,  8 Aug 2023 05:36:21 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.35.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 36E633F59C;
        Tue,  8 Aug 2023 05:35:35 -0700 (PDT)
Date:   Tue, 8 Aug 2023 13:35:29 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v3 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
Message-ID: <ZNI2kStGIPInDYIK@FVFF77S0Q05N.cambridge.arm.com>
References: <20230808102049.465864-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808102049.465864-1-elver@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 12:17:25PM +0200, Marco Elver wrote:
> [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> convention of a function. The preserve_most calling convention attempts
> to make the code in the caller as unintrusive as possible. This
> convention behaves identically to the C calling convention on how
> arguments and return values are passed, but it uses a different set of
> caller/callee-saved registers. This alleviates the burden of saving and
> recovering a large register set before and after the call in the caller.
> If the arguments are passed in callee-saved registers, then they will be
> preserved by the callee across the call. This doesn't apply for values
> returned in callee-saved registers.
> 
>  * On X86-64 the callee preserves all general purpose registers, except
>    for R11. R11 can be used as a scratch register. Floating-point
>    registers (XMMs/YMMs) are not preserved and need to be saved by the
>    caller.
> 
>  * On AArch64 the callee preserve all general purpose registers, except
>    x0-X8 and X16-X18."
> 
> [1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> 
> Introduce the attribute to compiler_types.h as __preserve_most.
> 
> Use of this attribute results in better code generation for calls to
> very rarely called functions, such as error-reporting functions, or
> rarely executed slow paths.
> 
> Beware that the attribute conflicts with instrumentation calls inserted
> on function entry which do not use __preserve_most themselves. Notably,
> function tracing which assumes the normal C calling convention for the
> given architecture.  Where the attribute is supported, __preserve_most
> will imply notrace. It is recommended to restrict use of the attribute
> to functions that should or already disable tracing.
> 
> The attribute may be supported by a future GCC version (see
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110899).
> 
> Signed-off-by: Marco Elver <elver@google.com>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

So long as this implies notrace I believe it is safe, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> v3:
> * Quote more from LLVM documentation about which registers are
>   callee/caller with preserve_most.
> * Code comment to restrict use where tracing is meant to be disabled.
> 
> v2:
> * Imply notrace, to avoid any conflicts with tracing which is inserted
>   on function entry. See added comments.
> ---
>  include/linux/compiler_types.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 547ea1ff806e..c88488715a39 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -106,6 +106,34 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
>  #define __cold
>  #endif
>  
> +/*
> + * On x86-64 and arm64 targets, __preserve_most changes the calling convention
> + * of a function to make the code in the caller as unintrusive as possible. This
> + * convention behaves identically to the C calling convention on how arguments
> + * and return values are passed, but uses a different set of caller- and callee-
> + * saved registers.
> + *
> + * The purpose is to alleviates the burden of saving and recovering a large
> + * register set before and after the call in the caller.  This is beneficial for
> + * rarely taken slow paths, such as error-reporting functions that may be called
> + * from hot paths.
> + *
> + * Note: This may conflict with instrumentation inserted on function entry which
> + * does not use __preserve_most or equivalent convention (if in assembly). Since
> + * function tracing assumes the normal C calling convention, where the attribute
> + * is supported, __preserve_most implies notrace.  It is recommended to restrict
> + * use of the attribute to functions that should or already disable tracing.
> + *
> + * Optional: not supported by gcc.
> + *
> + * clang: https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> + */
> +#if __has_attribute(__preserve_most__)
> +# define __preserve_most notrace __attribute__((__preserve_most__))
> +#else
> +# define __preserve_most
> +#endif
> +
>  /* Builtins */
>  
>  /*
> -- 
> 2.41.0.640.ga95def55d0-goog
> 
