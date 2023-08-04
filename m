Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BE7707AB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjHDSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHDSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:15:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16594C04;
        Fri,  4 Aug 2023 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YnOa/6fvU8ss9SgEPYf5nmoqAHQ4nJbGjVNgPXhtNF8=; b=f1vfHE4LOsBk/kJDL0KtcEta9F
        nqzJcfT4NAgaWZQEUymYvdpHddU18BqjRduXfVSAUl1IuFi7j328jMeYJ825K1HGucnmoZWKEzVi4
        lvG3y4179RFoxwmgvwXiahbNwCMbzLozENn+v43ZAFgh/pHHmVXu1OHITOgYG+l1S4fbIYeudqmFg
        th2KzGm+kZN4adHbUP1qR6cfoK+mOmtdEE2BfZbRYW1W8qmJ9Pr1edAbsunLMpp8Ls3SoSk2bvlai
        Xs33K0bWT8lNsJLYxGYmx7E0XY80dQ5k+vy7yoqbMan23AFpiZUVqH9MeC/6VpJMmNFLvJGcOwAt6
        lNb3lYcQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRzK0-00BK0t-UW; Fri, 04 Aug 2023 18:14:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE059300235;
        Fri,  4 Aug 2023 20:14:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 79E6127436E16; Fri,  4 Aug 2023 20:14:43 +0200 (CEST)
Date:   Fri, 4 Aug 2023 20:14:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
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
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev@googlegroups.com, linux-toolchains@vger.kernel.org
Subject: Re: [PATCH v2 1/3] compiler_types: Introduce the Clang
 __preserve_most function attribute
Message-ID: <20230804181443.GJ214207@hirez.programming.kicks-ass.net>
References: <20230804090621.400-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804090621.400-1-elver@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 11:02:56AM +0200, Marco Elver wrote:
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

This seems to shrink the ARM64 vmlinux just a little and mirrors what we
do on x86 in asm. I'll leave it to the arm64 people to judge if this is
worth the hassle.

Index: linux-2.6/arch/arm64/include/asm/preempt.h
===================================================================
--- linux-2.6.orig/arch/arm64/include/asm/preempt.h
+++ linux-2.6/arch/arm64/include/asm/preempt.h
@@ -88,15 +88,18 @@ void preempt_schedule_notrace(void);
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
-void dynamic_preempt_schedule(void);
+void __preserve_most dynamic_preempt_schedule(void);
 #define __preempt_schedule()		dynamic_preempt_schedule()
-void dynamic_preempt_schedule_notrace(void);
+void __preserve_most dynamic_preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
 
 #else /* CONFIG_PREEMPT_DYNAMIC */
 
-#define __preempt_schedule()		preempt_schedule()
-#define __preempt_schedule_notrace()	preempt_schedule_notrace()
+void __preserve_most preserve_preempt_schedule(void);
+void __preserve_most preserve_preempt_schedule_notrace(void);
+
+#define __preempt_schedule()		preserve_preempt_schedule()
+#define __preempt_schedule_notrace()	preserve_preempt_schedule_notrace()
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -6915,7 +6915,7 @@ DEFINE_STATIC_CALL(preempt_schedule, pre
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule);
-void __sched notrace dynamic_preempt_schedule(void)
+void __sched __preserve_most dynamic_preempt_schedule(void)
 {
 	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule))
 		return;
@@ -6924,6 +6924,11 @@ void __sched notrace dynamic_preempt_sch
 NOKPROBE_SYMBOL(dynamic_preempt_schedule);
 EXPORT_SYMBOL(dynamic_preempt_schedule);
 #endif
+#else
+void __sched __preserve_most preserve_preempt_schedule(void)
+{
+	preempt_schedule();
+}
 #endif
 
 /**
@@ -6988,7 +6993,7 @@ DEFINE_STATIC_CALL(preempt_schedule_notr
 EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
 static DEFINE_STATIC_KEY_TRUE(sk_dynamic_preempt_schedule_notrace);
-void __sched notrace dynamic_preempt_schedule_notrace(void)
+void __sched __preserve_most dynamic_preempt_schedule_notrace(void)
 {
 	if (!static_branch_unlikely(&sk_dynamic_preempt_schedule_notrace))
 		return;
@@ -6997,6 +7002,11 @@ void __sched notrace dynamic_preempt_sch
 NOKPROBE_SYMBOL(dynamic_preempt_schedule_notrace);
 EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
 #endif
+#else
+void __sched __preserve_most preserve_preempt_schedule_notrace(void)
+{
+	preempt_schedule_notrace();
+}
 #endif
 
 #endif /* CONFIG_PREEMPTION */
