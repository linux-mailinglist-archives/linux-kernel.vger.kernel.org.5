Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B177241A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjHGMcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233559AbjHGMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:32:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FEB1710;
        Mon,  7 Aug 2023 05:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MKVDKc7Pqd1qB2ritThbJyFE9EXb4dytHxurnka2dE0=; b=jnIrvvedq9C7QKCBFwOsCNIJX9
        V9VbOWcczqLVKyrCHG7xIiLwhStLZWwvOyBMTcDULVt3KMgthpASODAmfS/B/IgNy5EzqCdCXA5JT
        3ydHWZoh21co0+w9SFHvWFRvrIU+7Jwe4krDx5HY3VqDHBwyV/oj1920tmMyjQP0lWsgDY8rKX87I
        Nk92DPd9vqruI6mmUagufSoUxHNFk1MRzrdSDG2wKbYOCJIifwnXK62aBYiHXlkeH03CSBLBFaPHo
        imbMMtQakrBaAZsWI1Eo53wsGyWbcTlX11gI98n1fxtBPFD0tBrCeYBDVQJdavGh6hDsf4qe9rxPM
        NdFc0/Rg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qSzOd-003oMs-0g;
        Mon, 07 Aug 2023 12:31:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7727E30014A;
        Mon,  7 Aug 2023 14:31:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 299ED203B463D; Mon,  7 Aug 2023 14:31:37 +0200 (CEST)
Date:   Mon, 7 Aug 2023 14:31:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20230807123137.GA564305@hirez.programming.kicks-ass.net>
References: <20230804090621.400-1-elver@google.com>
 <87il9rgjvw.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il9rgjvw.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 01:41:07PM +0200, Florian Weimer wrote:
> * Marco Elver:
> 
> > [1]: "On X86-64 and AArch64 targets, this attribute changes the calling
> > convention of a function. The preserve_most calling convention attempts
> > to make the code in the caller as unintrusive as possible. This
> > convention behaves identically to the C calling convention on how
> > arguments and return values are passed, but it uses a different set of
> > caller/callee-saved registers. This alleviates the burden of saving and
> > recovering a large register set before and after the call in the
> > caller."
> >
> > [1] https://clang.llvm.org/docs/AttributeReference.html#preserve-most
> 
> You dropped the interesting part:
> 
> | If the arguments are passed in callee-saved registers, then they will
> | be preserved by the callee across the call. This doesn’t apply for
> | values returned in callee-saved registers.
> | 
> |  ·  On X86-64 the callee preserves all general purpose registers, except
> |     for R11. R11 can be used as a scratch register. Floating-point
> |     registers (XMMs/YMMs) are not preserved and need to be saved by the
> |     caller.
> |     
> |  ·  On AArch64 the callee preserve all general purpose registers, except
> |     X0-X8 and X16-X18.
> 
> Ideally, this would be documented in the respective psABI supplement.
> I filled in some gaps and filed:
> 
>   Document the ABI for __preserve_most__ function calls
>   <https://gitlab.com/x86-psABIs/x86-64-ABI/-/merge_requests/45>
> 
> Doesn't this change impact the kernel module ABI?
> 
> I would really expect a check here
> 
> > +#if __has_attribute(__preserve_most__)
> > +# define __preserve_most notrace __attribute__((__preserve_most__))
> > +#else
> > +# define __preserve_most
> > +#endif
> 
> that this is not a compilation for a module.  Otherwise modules built
> with a compiler with __preserve_most__ attribute support are
> incompatible with kernels built with a compiler without that attribute.

We have a metric ton of options that can break module ABI. If you're
daft enough to not build with the exact same compiler and .config you
get to keep the pieces.
