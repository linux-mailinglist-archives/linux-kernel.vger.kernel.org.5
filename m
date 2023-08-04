Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD7770566
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHDP6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHDP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C952D71;
        Fri,  4 Aug 2023 08:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5771D62077;
        Fri,  4 Aug 2023 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275F2C433C7;
        Fri,  4 Aug 2023 15:58:45 +0000 (UTC)
Date:   Fri, 4 Aug 2023 11:58:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
Message-ID: <20230804115843.5be5f2b2@gandalf.local.home>
In-Reply-To: <20230804090621.400-1-elver@google.com>
References: <20230804090621.400-1-elver@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Aug 2023 11:02:56 +0200
Marco Elver <elver@google.com> wrote:

> [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> convention of a function. The preserve_most calling convention attempts
> to make the code in the caller as unintrusive as possible. This
> convention behaves identically to the C calling convention on how
> arguments and return values are passed, but it uses a different set of
> caller/callee-saved registers. This alleviates the burden of saving and
> recovering a large register set before and after the call in the
> caller."
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
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Imply notrace, to avoid any conflicts with tracing which is inserted
>   on function entry. See added comments.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  include/linux/compiler_types.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index 547ea1ff806e..12c4540335b7 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -106,6 +106,33 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
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
> + * is supported, __preserve_most implies notrace.
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

