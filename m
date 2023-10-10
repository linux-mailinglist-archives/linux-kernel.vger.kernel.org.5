Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73F7BFE57
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjJJNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJJNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:47:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6ED6D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:47:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C15C433C8;
        Tue, 10 Oct 2023 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696945648;
        bh=aav3RU+ABv4Umdi+fIPyKqi7MUlpgMHs/uTgTKUBBDM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=li/p1ogTyu72T9DPHf99PjwD3iFxVvQaES6Y711FN240Midm3m4OgX46Bkfv9tNCF
         qxsi44/3/0DwYGcnwZ4HwXxDI7Tq6DC4mYZUUEVfy9Sex1DC9PN+j8awl1VBsV5sj6
         4qB5M3epsNrltj9dlnqkf9tZikHL6FLoQlmfZNL5kkSWYS+8vWuwFpAr7bIJ8OKUCY
         5aADHbpWDxCVdDcXwTP8GDcOQq/7MQ2IZjzT1MrFA5lnh6zGA54xaBc8u1WtTb6wT6
         qm7qae2yxgKAhrkfv3BbrLbOc5d6dphLqzfwICijubKASotadQWg6CR/Pqzlp3cdYM
         /OML5Rw1TM36A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E55BFCE0C54; Tue, 10 Oct 2023 06:47:27 -0700 (PDT)
Date:   Tue, 10 Oct 2023 06:47:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Leonardo Bras <leobras@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Message-ID: <bf012ea1-d4aa-4f89-be14-8ae8a4ea4b5c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
 <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
 <89062478-fa97-c265-3b18-de55eeae3c1f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89062478-fa97-c265-3b18-de55eeae3c1f@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:58:43PM +1100, Imran Khan wrote:
> Hello Paul,
> 
> On 10/10/2023 3:39 am, Paul E. McKenney wrote:
> > On Fri, Oct 06, 2023 at 10:32:07AM +1100, Imran Khan wrote:
> >> Hello Paul,
> >>
> >> On 6/10/2023 3:48 am, Paul E. McKenney wrote:
> >>> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> >>> temporarily, it usually gets released in a few seconds, and sometimes
> >>> up to one or two minutes.
> >>>
> >>> If the CSD lock stays stuck for more than several minutes, it never
> >>> seems to get unstuck, and gradually more and more things in the system
> >>> end up also getting stuck.
> >>>
> >>> In the latter case, we should just give up, so the system can dump out
> >>> a little more information about what went wrong, and, with panic_on_oops
> >>> and a kdump kernel loaded, dump a whole bunch more information about
> >>> what might have gone wrong.
> >>>
> >>> Question: should this have its own panic_on_ipistall switch in
> >>> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> >>> way than via BUG_ON?
> >>>
> >> panic_on_ipistall (set to 1 by default) looks better option to me. For systems
> >> where such delay is acceptable and system can eventually get back to sane state,
> >> this option (set to 0 after boot) would prevent crashing the system for
> >> apparently benign CSD hangs of long duration.
> > 
> > Good point!  How about like the following?
> > 
> 
> Yes, this looks good.
> Just realized that keeping panic_on_ipistall set by default(as suggested earlier
> by me) would not follow convention of other similar switches like
> hard/softlockup_panic etc. which are 0 by deafault.
> So default value of 0 looks better choice for panic_on_ipistall as well.

Plus if a new option is set by default and causes problems, people
get (understandably) annoyed.  ;-)

> > ------------------------------------------------------------------------
> > 
> > commit 6bcf3786291b86f13b3e13d51e998737a8009ec3
> > Author: Rik van Riel <riel@surriel.com>
> > Date:   Mon Aug 21 16:04:09 2023 -0400
> > 
> >     smp,csd: Throw an error if a CSD lock is stuck for too long
> >     
> >     The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> >     temporarily, it usually gets released in a few seconds, and sometimes
> >     up to one or two minutes.
> >     
> >     If the CSD lock stays stuck for more than several minutes, it never
> >     seems to get unstuck, and gradually more and more things in the system
> >     end up also getting stuck.
> >     
> >     In the latter case, we should just give up, so the system can dump out
> >     a little more information about what went wrong, and, with panic_on_oops
> >     and a kdump kernel loaded, dump a whole bunch more information about what
> >     might have gone wrong.  In addition, there is an smp.panic_on_ipistall
> >     kernel boot parameter that by default retains the old behavior, but when
> >     set enables the panic after the CSD lock has been stuck for more than
> >     five minutes.
> >     
> >     [ paulmck: Apply Imran Khan feedback. ]
> >     
> >     Link: https://urldefense.com/v3/__https://lore.kernel.org/lkml/bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop/__;!!ACWV5N9M2RV99hQ!PDFpjgGTCPjxqCyusua5IZWkvdWEMf51igFDc-yb9cVK9PYr7FpEE1oGpWp09YK4lc15C2taMdcuEOqyH8k$ 
> >     Signed-off-by: Rik van Riel <riel@surriel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Valentin Schneider <vschneid@redhat.com>
> >     Cc: Juergen Gross <jgross@suse.com>
> >     Cc: Jonathan Corbet <corbet@lwn.net>
> >     Cc: Randy Dunlap <rdunlap@infradead.org>
> >
> Reviewed-by: Imran Khan <imran.f.khan@oracle.com>

Thank you, and I will apply this on my next rebase.

							Thanx, Paul

> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 0a1731a0f0ef..592935267ce2 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -5858,6 +5858,11 @@
> >  			This feature may be more efficiently disabled
> >  			using the csdlock_debug- kernel parameter.
> >  
> > +	smp.panic_on_ipistall= [KNL]
> > +			If a csd_lock_timeout extends for more than
> > +			five minutes, panic the system.  By default, let
> > +			CSD-lock acquisition take as long as they take.
> > +
> >  	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
> >  	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
> >  	smsc-ircc2.ircc_sir=	[HW] SIR base I/O port
> > diff --git a/kernel/smp.c b/kernel/smp.c
> > index 8455a53465af..b6a0773a7015 100644
> > --- a/kernel/smp.c
> > +++ b/kernel/smp.c
> > @@ -170,6 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
> >  
> >  static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
> >  module_param(csd_lock_timeout, ulong, 0444);
> > +static bool panic_on_ipistall;
> > +module_param(panic_on_ipistall, bool, 0444);
> >  
> >  static atomic_t csd_bug_count = ATOMIC_INIT(0);
> >  
> > @@ -230,6 +232,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >  	}
> >  
> >  	ts2 = sched_clock();
> > +	/* How long since we last checked for a stuck CSD lock.*/
> >  	ts_delta = ts2 - *ts1;
> >  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
> >  		return false;
> > @@ -243,9 +246,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
> >  	else
> >  		cpux = cpu;
> >  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> > +	/* How long since this CSD lock was stuck. */
> > +	ts_delta = ts2 - ts0;
> >  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> > -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> > +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
> >  		 cpu, csd->func, csd->info);
> > +	/*
> > +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> > +	 * to become unstuck. Use a signed comparison to avoid triggering
> > +	 * on underflows when the TSC is out of sync between sockets.
> > +	 */
> > +	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
> >  	if (cpu_cur_csd && csd != cpu_cur_csd) {
> >  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
> >  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
