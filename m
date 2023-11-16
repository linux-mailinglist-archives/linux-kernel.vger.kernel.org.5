Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274987EE704
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 19:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKPStA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKPSs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 13:48:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D138C181
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 10:48:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115D7C433C7;
        Thu, 16 Nov 2023 18:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700160536;
        bh=0KG7GdzP336+0cjZwUNxFr0qe0BUvljcO4RomC7f7nI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHTwRTm7/D2J7jeuVpmBKgYqMUX5QcAnwsYrmyNaxDYK3PcabLuiWSozYDuMFsHTn
         eB6OM9gOD2DshqlUCufpO4SnFaGWhV72cjygNi6NUU8zLmM7MLLyRab3q7NdyP30wo
         hgc8uewEAGuB6oxiHcByzefcglPCNh/xwx3lr2kg4a6F/9qOi3QH7vTpHEjTwn+8ps
         a1vowyJvO2+O1wh6H8Ufx/TNhAwYfJcku1daxzoJje4zu65EAZg4hC83iEAXFNRiQr
         hVJAchK7WprnjQJhoDHaXPuFEOPSwANGc1hvqfTejIc1Fe+x3E6gktAdsuzIa2iQaz
         YsXITMmodmqUQ==
Date:   Thu, 16 Nov 2023 13:48:47 -0500
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/4] x86: Remove __current_clr_polling() from mwait_idle()
Message-ID: <ZVZkD3FvmNQ39Kk9@localhost.localdomain>
References: <20231115151325.6262-1-frederic@kernel.org>
 <20231115151325.6262-4-frederic@kernel.org>
 <20231116151316.GH8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116151316.GH8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Nov 16, 2023 at 04:13:16PM +0100, Peter Zijlstra a écrit :
> On Wed, Nov 15, 2023 at 10:13:24AM -0500, Frederic Weisbecker wrote:
> > mwait_idle() is only ever called through by cpuidle, either from
> > default_idle_call() or from cpuidle_enter(). In any case
> > cpuidle_idle_call() sets again TIF_NR_POLLING after calling it so there
> > is no point for this atomic operation upon idle exit.
> > 
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  arch/x86/kernel/process.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index b6f4e8399fca..fc7a38084606 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -930,7 +930,6 @@ static __cpuidle void mwait_idle(void)
> >  			raw_local_irq_disable();
> >  		}
> >  	}
> > -	__current_clr_polling();
> >  }
> >  
> >  void select_idle_routine(const struct cpuinfo_x86 *c)
> 
> 
> Urgh at this and the next one... That is, yes we can do this, but it
> makes these function asymmetric and doesn't actually solve the
> underlying problem that all of the polling stuff is inside-out.
> 
> Idle loop sets polling, then clears polling because it assumes all
> arch/driver idle loops are non-polling, then individual drivers re-set
> polling, and to be symmetric (above) clear it again, for the generic
> code to set it again, only to clear it again when leaving idle.
> 
> Follow that? ;-)

That's right :-)

> 
> Anyway, drivers ought to tell up-front if they're polling and then we
> can avoid the whole dance and everything is better.
> 
> Something like the very crude below.

Yeah that makes perfect sense (can I use your SoB right away?)

Though I sometimes wonder why we even bother with setting TIF_NR_POLLING
for some short parts in the generic idle loop even on !mwait and
!cpuidle-state-polling states.

Like for example why do we bother with setting TIF_NR_POLLING for just
the portion in the generic idle loop that looks up the cpuidle state
and stops the tick then clear TIF_NR_POLLING before calling wfi on ARM?

Or may be it's a frequent pattern to have a remote wake up happening while
entering the idle loop?

Thanks.
