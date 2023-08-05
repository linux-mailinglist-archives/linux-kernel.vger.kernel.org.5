Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDF77123C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjHEVDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:03:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC4E7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:03:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691269380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSbKeXLBsgKqGj/TwqTJ9+PojQPLuVRP6JDwmEEGuoE=;
        b=G1L7HlLWpNbkQsJ5hzO4fWWiZ+FtA0lxn/PDsGsygDHKd82Z1Dlrc+/V4zug84FWYwNTBe
        /MysUkkx5IjU9x62KFTC8slW5q048LdNDfzZMBpZeqJSQy/30me7wEOUXlVjdPRelQbtal
        PO6QKSTMLwFh1ZFT3SgL5IaxVVsyZYXcDeEnOPSs4sdPvE0UEVxtoBueWh4tk9uHJSamI+
        i5R7rN+6OmoKEx9+5sfv1irx9EVO+J6UgKEYv/QSZ6F+D6Pqc9F5j/CSbBB3bfKsrm+o38
        IuwmqsyUupUM8g7ufi9tYo9fYSwRTi7bhGAE78K3uoeRUpbdCG8xwWbO1DDugQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691269380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gSbKeXLBsgKqGj/TwqTJ9+PojQPLuVRP6JDwmEEGuoE=;
        b=tJDGqJG9ZGL0jQfrmZogiEnjYq0oxLwLymgfLwSzBNsVGW5UDfDiT9E9gA4oG6BZEn37Qr
        KJ2/cN0ZZLuWxOCA==
To:     Peter Zijlstra <peterz@infradead.org>,
        "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Gross, Jurgen" <jgross@suse.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>
Subject: Re: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers'
 second argument error code
In-Reply-To: <20230804190120.GP212435@hirez.programming.kicks-ass.net>
References: <20230804075734.8372-1-xin3.li@intel.com>
 <20230804101321.GH214207@hirez.programming.kicks-ass.net>
 <SA1PR11MB67349385C20E8D3B0C960432A809A@SA1PR11MB6734.namprd11.prod.outlook.com>
 <20230804190120.GP212435@hirez.programming.kicks-ass.net>
Date:   Sat, 05 Aug 2023 23:02:59 +0200
Message-ID: <87o7jlmccc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04 2023 at 21:01, Peter Zijlstra wrote:
> On Fri, Aug 04, 2023 at 05:35:11PM +0000, Li, Xin3 wrote:
>> > > The commit d99015b1abbad ("x86: move entry_64.S register saving out of
>> > > the macros") introduced the changes to set orig_ax to -1, but I can't
>> > > see why it's required. Our tests on x86_64 and x86_32 seem fine if
>> > > orig_ax is left unchanged instead of set to -1.
>> > 
>> > That means that SYSCALL_NUM(regs) get to be garbage; or something like that.
>> 
>> I find SYSCALL_NUM(regs) in tools/testing/selftests/seccomp/seccomp_bpf.c,
>> but nothing obvious to me.
>> 
>> I think it's clear that once exceptions and IRQs are handled, the original
>> context will be fully recovered in a normal case.
>> 
>> Is it related to preemption after such a event?
>> 
>> I must have missed something; can you please elaborate it?
>
> arch/x86/include/asm/syscall.h
>
> syscall_get_nr() syscall_rollback()

Specifically it breaks signal handling. See arch_do_signal_or_restart()
and handle_signal().

So, no. This cannot be changed nilly willy especially not because
orig_ax is part of the UABI.

Even if it would work, this patch is completely unreviewable. There are
smarter ways to make such a change in digestable chunks.

I also looked at the latest FRED series and that's broken vs. orig_ax in
the same way.

Aside of it the series is not applying to any tree I'm aware of. It
fails because its based on a tree which has IRQ_MOVE_CLEANUP_VECTOR
removed, but that's nowhere in mainline or tip. This is not the way it
works, really.

Back to the problem at hand. I'm absolutely not understanding why this
all is so complicated.

FRED pushs the error code or 0 (in case there is no error code) right
into orig_ax. That's where the ERET[US] frame starts. ERT[US] do not
care at all about the error code location, they skip it by adding 8 to
RSP.

So the obvious thing to do is:

fred_entry_from_xxxx(struct pt_regs *regs)
{
        unsigned long error_code = regs->orig_ax;

        regs->orig_ax = -1;

        dispatch_1st_level(regs->type, regs, error_code);
}

Now the dispatching code in your series looks nice and shiny with all
those tables, but in practice it's not so shiny at all.

For one this code forces indirect calls even in places where there are
no indirect calls required.

But what's worse it causes you to make everything uniform one way or the
other and adding all this dispatch_table_##func muck, which is fully
duplicated code for absolutely zero reason. That's error prone and a
maintainence mess.

The vast majority of exceptions, interrupts whatever is not special at
all neither on FRED nor on IDT. The ones which need special treatment
are those which store additional information in the stack frame and
these are the exception - not the rule. And those require special
treatment anyway whether you make the rest look uniform or not.

IOW, your approach of making everything uniform is completely
wrong. There is a reason why some system vectors are not using
DEFINE_IDTENTRY_SYSVEC().  Particularly the RESCHEDULE_VECTOR. This has
been performance optimized with a lot of effort and no, we are not going
to sacrifice that just because it makes it sooo simple for FRED.

This is not about simplicity. This is about sane and maintainable code
which preserves the carefully optimized code paths which are hotpath no
matter whether there is IDT or FRED.

I'm going to reply on your last failed resend attempt after creating a
sane mail thread out of the mess you created (including the insanely
large and inappropriate cc list).

Thanks,

        tglx
