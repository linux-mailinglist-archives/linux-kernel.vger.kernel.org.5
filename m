Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4107CB283
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjJPS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJPS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:27:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F58A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:27:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B546CC433C7;
        Mon, 16 Oct 2023 18:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697480871;
        bh=KVzc+DtZ0K5HtCSUZgGI0+UechUc26ZCSqZWkVTBSAY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dAYGg8p5ZyWRLCP+QEOdE2PYQTejbW5ZX0mGT+ZwEYC+3wFM2q2KHPsATrdaFsJWW
         IhlXeiOuaNivr7/Q5DkL69M7LWpGET7ya4jgk0VqR6IHX/Y+weoXvrp+KmTZFzgjQm
         CTZg5kP7qEHRdegIWIe0s7EKZ4TLv1Ty8uLBtTnjVMvQOddDQibiPt7mmgf2sBspPD
         Zt3d2m3srwHB9yIg+HHvuat4o81hiYTiSvGaqLFHkvYLcAYw5bOAbQ31t5cj2cRD/a
         ruwUcC3qZU26M+qOMR37o7tVeRBM/oy9Lp3iy+m43oqfnZ5+GX7HT0HaVYDZRN3gdP
         2g4Tq5jXbGp9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 35A4ACE09BE; Mon, 16 Oct 2023 11:27:51 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:27:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Imran Khan <imran.f.khan@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH smp,csd] Throw an error if a CSD lock is stuck for too
 long
Message-ID: <fb3f6a95-5c54-460c-8581-276bc359a1de@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop>
 <c87d7939-a88c-ad2d-82f2-866e04692882@oracle.com>
 <a77da319-3161-4e42-894e-521d29fa8348@paulmck-laptop>
 <ZSlhnu0n9eOfkN-U@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSlhnu0n9eOfkN-U@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:26:22PM -0300, Leonardo Bras wrote:
> On Mon, Oct 09, 2023 at 09:39:38AM -0700, Paul E. McKenney wrote:
> > On Fri, Oct 06, 2023 at 10:32:07AM +1100, Imran Khan wrote:
> > > Hello Paul,
> > > 
> > > On 6/10/2023 3:48 am, Paul E. McKenney wrote:
> > > > The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> > > > temporarily, it usually gets released in a few seconds, and sometimes
> > > > up to one or two minutes.
> > > > 
> > > > If the CSD lock stays stuck for more than several minutes, it never
> > > > seems to get unstuck, and gradually more and more things in the system
> > > > end up also getting stuck.
> > > > 
> > > > In the latter case, we should just give up, so the system can dump out
> > > > a little more information about what went wrong, and, with panic_on_oops
> > > > and a kdump kernel loaded, dump a whole bunch more information about
> > > > what might have gone wrong.
> > > > 
> > > > Question: should this have its own panic_on_ipistall switch in
> > > > /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> > > > way than via BUG_ON?
> > > > 
> > > panic_on_ipistall (set to 1 by default) looks better option to me. For systems
> > > where such delay is acceptable and system can eventually get back to sane state,
> > > this option (set to 0 after boot) would prevent crashing the system for
> > > apparently benign CSD hangs of long duration.
> > 
> > Good point!  How about like the following?
> > 
> > 							Thanx, Paul
> > 
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
> >     Link: https://lore.kernel.org/lkml/bc7cc8b0-f587-4451-8bcd-0daae627bcc7@paulmck-laptop/
> >     Signed-off-by: Rik van Riel <riel@surriel.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Valentin Schneider <vschneid@redhat.com>
> >     Cc: Juergen Gross <jgross@suse.com>
> >     Cc: Jonathan Corbet <corbet@lwn.net>
> >     Cc: Randy Dunlap <rdunlap@infradead.org>
> > 
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
> 
> It could be interesting to have it as an s64 parameter (in {mili,}seconds) 
> instead of bool, this way the user could pick the time to wait before the 
> panic happens. 0 or -1 could mean disabled.
> 
> What do you think?
> 
> Other than that,
> Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thank you for looking this over!

How about with the diff shown below, to be folded into the original?
I went with int instead of s64 because I am having some difficulty
imagining anyone specifying more than a 24-day timeout.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ccb7621eff79..ea5ae9deb753 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5931,8 +5931,10 @@
 
 	smp.panic_on_ipistall= [KNL]
 			If a csd_lock_timeout extends for more than
-			five minutes, panic the system.  By default, let
-			CSD-lock acquisition take as long as they take.
+			the specified number of milliseconds, panic the
+			system.  By default, let CSD-lock acquisition
+			take as long as they take.  Specifying 300,000
+			for this value provides a 10-minute timeout.
 
 	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
 	smsc-ircc2.ircc_cfg=	[HW] Device configuration I/O port
diff --git a/kernel/smp.c b/kernel/smp.c
index b6a0773a7015..d3ca47f32f38 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -170,8 +170,8 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
 
 static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
 module_param(csd_lock_timeout, ulong, 0444);
-static bool panic_on_ipistall;
-module_param(panic_on_ipistall, bool, 0444);
+static int panic_on_ipistall;  /* CSD panic timeout in milliseconds, 300000 for ten minutes. */
+module_param(panic_on_ipistall, int, 0444);
 
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
@@ -256,7 +256,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
 	 * to become unstuck. Use a signed comparison to avoid triggering
 	 * on underflows when the TSC is out of sync between sockets.
 	 */
-	BUG_ON(panic_on_ipistall && (s64)ts_delta > 300000000000LL);
+	BUG_ON(panic_on_ipistall > 0 && (s64)ts_delta > ((s64)panic_on_ipistall * NSEC_PER_MSEC));
 	if (cpu_cur_csd && csd != cpu_cur_csd) {
 		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
 			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
