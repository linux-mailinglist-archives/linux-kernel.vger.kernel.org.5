Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68887DB935
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjJ3LpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3LpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:45:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CC3C5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cwVuwgnOv5r0BduS2NFCQTDkWPxIV5qbAn/Ows6hD4E=; b=S/jAle9cEv4vC60/nLAV/3eums
        L7uQfrndiWKgTYNf738nhe/7bL49uGKYef+bR1pFxUu4jWojXwwpYWkF4UY36nIvoJYyq10kiFCab
        Z7QQMsuiZ/PzNTQBiZ/2ZzxkhHR9chQHFyHg7m8Rjzp1eUUiKW3uZVxW4Of14XTgbDqv0yPYwygUW
        MLHVxVYZX5cMoGgLLlboMmPs8eMg5A4Gz+S4Y1Vvn1QKxTRx3tvOqb0E0hIIByt1jFB/T+/f4DOLn
        ue+S/9/vx2iH+u7WdlCyRJXlvr2wNKfuN3Jc7i0goGlE7d5MQyu8o4TlJOMFF16nY8bEb/6rj48kq
        /mDRdg4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qxQhP-003rSf-BB; Mon, 30 Oct 2023 11:44:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF910300478; Mon, 30 Oct 2023 12:44:50 +0100 (CET)
Date:   Mon, 30 Oct 2023 12:44:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
Message-ID: <20231030114450.GB12604@noisy.programming.kicks-ass.net>
References: <ZT6narvE+LxX+7Be@windriver.com>
 <20231030082644.GK26550@noisy.programming.kicks-ass.net>
 <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:55:26AM +0000, Richard Purdie wrote:
> On Mon, 2023-10-30 at 09:26 +0100, Peter Zijlstra wrote:
> > On Sun, Oct 29, 2023 at 02:41:46PM -0400, Paul Gortmaker wrote:
> > > The TL;DR is that the Yocto folks encountered a regression in their
> > > automated QA tests (after a move from v6.4 --> v6.5) where non-KVM
> > > enabled boot tests on 32 bit x86 would (with ~2% frequency) splat with:
> > 
> > You're sure you're not running into this here:
> > 
> >   https://lkml.kernel.org/r/20230706170537.95959-1-richard.henderson@linaro.org
> > 
> > ?
> 
> We're using qemu 8.1.0. Whilst I will get us updated to 8.1.2 and see
> if that helps, I think those commits are in 8.1.0:
> 
> $ git show cb62bd15e14e304617d250158b77d0deb032f03
> commit cb62bd15e14e304617d250158b77d0deb032f032
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Thu Jul 6 08:45:13 2023 +0100
> 
>     accel/tcg: Split out cpu_exec_longjmp_cleanup
> [...]
> $ git tag --contains cb62bd15e14e304617d250158b77d0deb032f03
> v8.1.0
> v8.1.0-rc0
> v8.1.0-rc1
> v8.1.0-rc2
> v8.1.0-rc3
> v8.1.0-rc4
> v8.1.1
> v8.1.2
> 
> Similarly for:
> 
> commit deba78709ae8ce103e2248413857747f804cd1ef
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Thu Jul 6 17:55:48 2023 +0100
> 
>     accel/tcg: Always lock pages before translation
> 
> and
> 
> commit ad17868eb162a5466d8ad43e5ccb428776403308
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Wed Jul 26 12:58:08 2023 -0700
> 
>     accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
> [...]
>     Fixes: deba78709ae8 ("accel/tcg: Always lock pages before translation")
> 
> Both of which are also in 8.1.0.
> 
> Is there any other patch related to those we might be missing?

Not sure -- afaik that was it.

Thomas was looking at this and wondered if something like the below
would help?

---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 73be3931e4f0..fd44739828f7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1685,8 +1685,8 @@ void __init_or_module text_poke_early(void *addr, const void *opcode,
 	} else {
 		local_irq_save(flags);
 		memcpy(addr, opcode, len);
-		local_irq_restore(flags);
 		sync_core();
+		local_irq_restore(flags);
 
 		/*
 		 * Could also do a CLFLUSH here to speed up CPU recovery; but
