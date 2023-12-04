Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD17803CAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjLDSVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:21:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2FAA;
        Mon,  4 Dec 2023 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AqgRiIU25Iyrb1pK/xZFkXqH0JgFhRw2lfSELu3vTXk=; b=cIQTrzt1QT6PLNkwG/peh1pk9J
        iy3i6f17zLKYQG7VAD4z8aVMiugj5WZAhoM+FfIv9erKT82aoryJFj57uOUx3cjsk2fGj0cTzKFhL
        TUpglAaD0ehEDE3dh5YKhJ7/4Wpb7LTxINIeWdjq8HX3+UljJsexKDLFi3RBih+ub7ti2qU2g0nEM
        5mjxCVasfnlsBaZPpOn1rxAW0GwiM0BZZYB0Vh06emJvmWcXIA/Yv1CEzvXbpZIC598IJAHiJ8vPv
        7ySr1nxlbGGM3y3xrQY35GS7h9PjBo7X/x7cKlh+Xwo0bf2vkk6wm2hLxpeysX19BOrfQROxpnxsQ
        RLg2Guuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rADYi-004PeY-0v;
        Mon, 04 Dec 2023 18:20:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCDDD300427; Mon,  4 Dec 2023 19:20:43 +0100 (CET)
Date:   Mon, 4 Dec 2023 19:20:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH 5/5] x86/tsc: Make __use_tsc __ro_after_init
Message-ID: <20231204182043.GB7299@noisy.programming.kicks-ass.net>
References: <20231120105528.760306-1-vschneid@redhat.com>
 <20231120105528.760306-6-vschneid@redhat.com>
 <20231120120553.GU8262@noisy.programming.kicks-ass.net>
 <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhcyvlc3mi.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:51:49PM +0100, Valentin Schneider wrote:
> On 20/11/23 13:05, Peter Zijlstra wrote:
> > On Mon, Nov 20, 2023 at 11:55:28AM +0100, Valentin Schneider wrote:
> >> __use_tsc is only ever enabled in __init tsc_enable_sched_clock(), so mark
> >> it as __ro_after_init.
> >>
> >> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> >> ---
> >>  arch/x86/kernel/tsc.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> >> index 15f97c0abc9d0..f19b42ea40573 100644
> >> --- a/arch/x86/kernel/tsc.c
> >> +++ b/arch/x86/kernel/tsc.c
> >> @@ -44,7 +44,7 @@ EXPORT_SYMBOL(tsc_khz);
> >>  static int __read_mostly tsc_unstable;
> >>  static unsigned int __initdata tsc_early_khz;
> >>
> >> -static DEFINE_STATIC_KEY_FALSE(__use_tsc);
> >> +static DEFINE_STATIC_KEY_FALSE_RO(__use_tsc);
> >
> > So sure, we can absolutely do that, but do we want to take this one
> > further perhaps? "notsc" on x86_64 makes no sense what so ever. Lets
> > drag things into this millennium.
> >
> 
> Just to make sure I follow: currently, for the static key to be enabled, we
> (mostly) need:
> o X86_FEATURE_TSC is in CPUID
> o determine_cpu_tsc_frequencies()->pit_hpet_ptimer_calibrate_cpu() passes
> 
> IIUC all X86_64 systems have a TSC, so the CPUID feature should be a given.
> 
> AFAICT pit_hpt_ptimer_calibrate_cpu() relies on having either HPET or the
> ACPI PM timer, the latter should be widely available, though X86_PM_TIMER
> can be disabled via EXPERT - is that a fringe case we don't care about, or
> did I miss something? I don't really know this stuff, and I'm trying to
> write a changelog...

Ah, I was mostly just going by the fact that all of x86_64 have TSC and
disabling it makes no sense.

TSC calibration is always 'fun', but I don't know of a system where its
failure causes us to not use TSC, Thomas?
