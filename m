Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525B2792FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjIEUNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243423AbjIEUMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:12:55 -0400
X-Greylist: delayed 238 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:12:35 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E57CDB;
        Tue,  5 Sep 2023 13:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D26C4AF7B;
        Tue,  5 Sep 2023 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693943136;
        bh=K9B2tfIQJAXN5bDD9gWlaF6bGRvQAO9uLcfPHt9fHno=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WkizaLB3G0JJlK0F0THTug6o3SgCEo+Fxhqw5v/FdUDLPR2pCGPnLZL75EJyFPBX2
         iNyLKK6uaFRW7fxWqnJsIpeuuckqakMsqQiQlmwvGaVfRqi9D7U0+UbCDIxWDmfNry
         chrlFl2Lr4Cy+ULuePpPU+ickBFyXEhY/eEl2GYVSkiAz3A8o+E0sYupTAI85225s5
         1Gl6BclcUThIw45M/56l8TyPmjIXzvleKcSC/+4oNqyujnfrSPY17XxPjmskdXVrOQ
         tKjyhDTcYtS2qreamWXgR/LYx9IKTlJLf7wJzVhtmXSqFpg9IQ6wcCl4VZ9fWpXg48
         4f4dnmO0alvnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 680C6CE0FF4; Tue,  5 Sep 2023 12:45:36 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:45:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>, ldufour@linux.ibm.com
Subject: Re: [PATCH v2] The value may overflow
Message-ID: <b561c3a9-dc70-4c3d-b561-3f24398b01d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
 <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
 <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
 <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
 <abe14f37-ec05-48c3-87fc-9294848d221f@paulmck-laptop>
 <83422425-0534-4b12-a6e4-8068b7164a17@paulmck-laptop>
 <d2a3456b-aee9-f5b0-f8e4-5c5030c3217f@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a3456b-aee9-f5b0-f8e4-5c5030c3217f@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 03:36:40PM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 15:27, Paul E. McKenney wrote:
> > On Tue, Sep 05, 2023 at 09:40:51AM -0700, Paul E. McKenney wrote:
> > > On Tue, Sep 05, 2023 at 10:34:43AM -0400, Mathieu Desnoyers wrote:
> > > > On 9/5/23 10:15, David Laight wrote:
> > > > > ...
> > > > > > That would instead be more than 512-16=496 CPUs, correct?  496 CPUs would
> > > > > > only require a 31-bit shift, which should be OK, but 497 would require
> > > > > > a 32-bit shift, which would result in sign extension.  If it turns out
> > > > > > that sign extension is OK, then we should get in trouble at 513 CPUs,
> > > > > > which would result in a 33-bit shift (and is that even defined in C?).
> > > > > 
> > > > > Not quite right :-)
> > > > > 
> > > > > (1 << 31) is int and negative, that gets sign extended before
> > > > > being converted to 'unsigned long' - so has the top 33 bits set.
> > > 
> > > Good point, thank you for the correction.
> > > 
> > > > > (1 << 32) is undefined, the current x86 cpu ignore the high
> > > > > shift bits so it is (1 << 0).
> > > 
> > > Which would cause it to attempt to invoke SRCU callbacks on the
> > > lowest-numbered CPU associated with that srcu_node structure.
> > > 
> > > > Yes, I was about to reply the same thing. A shift of 31 is buggy,
> > > > because shifting 1 << 31 raises the sign bit, which sets the top 33
> > > > bits when cast to unsigned long. A shift of 1 << 32 is undefined,
> > > > with for instance x86 choosing to ignore the top bit.
> > > > 
> > > > But in order to have a 1 << 31 shift from this expression:
> > > > 
> > > >                  sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > > 
> > > > I *think* we need the group to have 32 cpus or more (indexed within
> > > > the group from grplo to grplo + 31 (both inclusive)).
> > > > 
> > > > So as soon as we have one group with 32 cpus, the problem should show
> > > > up. With FANOUT_LEAF=16, we can have 15 groups of 31 cpus and 1
> > > > group of 32 cpus, for:
> > > > 
> > > >    15*31 + 32 = 497 cpus.
> > > > 
> > > > AFAIU, this would be the minimum value for smp_processor_id()+1 which
> > > > triggers this issue.
> > > 
> > > By default, there are 16 CPUs per leaf srcu_node structure.  Each leaf
> > > srcu_node structure takes up one bit in the parent srcu_node structures'
> > > srcu_data_have_cbs[] array.  Up to 30 bits is OK, 31 bits is questionable,
> > > and 32 bits and larger erroneous.
> > > 
> > > This is the situation as I see it (assuming dense CPU numbering):
> > > 
> > > 	# Leaf srcu_node		Largest
> > > 	structures	#CPUs		CPU #		Status
> > > 
> > > 	0-30		0-480		479		Good
> > > 	31		481-496		495		Questionable
> > > 	32-		497-		496+		Bad.
> > > 
> > > Tree SRCU differs from Tree RCU in its operation, so this bug should
> > > not hold up SRCU grace periods.  It might instead cause SRCU callbacks
> > > to be ignored (which would admittedly look quite similar to the user).
> > > 
> > > My attempts to cheat the numbering system ran up against the limited
> > > height of the srcu_node tree.
> > > 
> > > But there is still the question of why this has not been seen in the
> > > wild, given that there really are systems with more than 479 CPUs
> > > out there.  One possibility is the call to srcu_schedule_cbs_sdp()
> > > from srcu_funnel_gp_start().  But it does not seem likely that this
> > > would happen all that often, as it requires back-to-back grace periods
> > > and then some.
> > > 
> > > Maybe people with large systems boot with srcutree.convert_to_big=0?
> > > 
> > > Adding Laurent for his thoughts.
> > > 
> > > Aha!
> > > 
> > > Here is what makes it work, given David's description of 1<<32:
> > > 
> > > static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp,
> > > 				  unsigned long mask, unsigned long delay)
> > > {
> > > 	int cpu;
> > > 
> > > 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > > 		if (!(mask & (1 << (cpu - snp->grplo))))
> > > 			continue;
> > > 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > > 	}
> > > }
> > > 
> > > As long as at least one bit is set in the result of 1<<N, and as long
> > > as the compiler always does the same thing for a given N, then this loop
> > > will make the right thing happen.
> > > 
> > > But even that is not relied upon, because the calling code looks like
> > > this:
> > > 
> > > 			spin_lock_irq_rcu_node(snp);
> > > 			cbs = false;
> > > 			last_lvl = snp >= sup->level[rcu_num_lvls - 1];
> > > 			if (last_lvl)
> > > 				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
> > > 			snp->srcu_have_cbs[idx] = gpseq;
> > > 			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> > > 			sgsne = snp->srcu_gp_seq_needed_exp;
> > > 			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
> > > 				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> > > 			if (ss_state < SRCU_SIZE_BIG)
> > > 				mask = ~0;
> > > 			else
> > > 				mask = snp->srcu_data_have_cbs[idx];
> > > 			snp->srcu_data_have_cbs[idx] = 0;
> > > 			spin_unlock_irq_rcu_node(snp);
> > > 			if (cbs)
> > > 				srcu_schedule_cbs_snp(ssp, snp, mask, cbdelay);
> > > 
> > > So that last_lvl check means that the srcu_schedule_cbs_snp() function
> > > is invoked only for leaf srcu_node structures.  Which by default limit
> > > the shift to 16.
> > > 
> > > So this bug appears to have no effect for default RCU setups, even on very
> > > large 64-bit systems, which is consistent with field experience.  Even if
> > > this is the case, it still should be fixed, to avoid confusion if nothing
> > > else.  Or just in case someone decides to set CONFIG_RCU_FANOUT_LEAF=32.
> > > Which actually happened the other day due to someone trusting ChatGPT's
> > > opinion about RCU Kconfig options...
> > 
> > And I therefore queued Denis's v3 patch with an edited commit log.
> > Of course, if anyone sees some other way that the bug could manifest
> > other than in a 64-bit kernel built with CONFIG_RCU_FANOUT_LEAF greater
> > than 30 on a system with at least 31 CPUs, please let me know so that
> > I can adjust.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit ed083b0e22f1396dee3599896249a3f218845298
> > Author: Denis Arefev <arefev@swemel.ru>
> > Date:   Mon Sep 4 15:21:14 2023 +0300
> > 
> >      Fix srcu_struct node grpmask overflow on 64-bit systems
> >      The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> 
> AFAIU, the overflow resides in the "bitwise expression" and not
> the arithmetic expression.

Rather than quibble about exactly what constitutes arithmetic, I
updated the first paragraph and added your Reviewed-by as shown
below.  ;-)

> Other than this, please add my
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thank you all!!!

------------------------------------------------------------------------

commit 50477ff756ab99402b1523b7c6be8b5d790d05e7
Author: Denis Arefev <arefev@swemel.ru>
Date:   Mon Sep 4 15:21:14 2023 +0300

    Fix srcu_struct node grpmask overflow on 64-bit systems
    
    The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
    is subject to overflow due to a failure to cast operands to a larger
    data type before performing the bitwise operation.
    
    The maximum result of this subtraction is defined by the RCU_FANOUT_LEAF
    Kconfig option, which on 64-bit systems defaults to 16 (resulting in a
    maximum shift of 15), but which can be set up as high as 64 (resulting
    in a maximum shift of 63).  A value of 31 can result in sign extension,
    resulting in 0xffffffff80000000 instead of the desired 0x80000000.
    A value of 31 or greater triggers undefined behavior per the C standard.
    
    This bug has not been known to cause issues because almost all kernels
    take the default CONFIG_RCU_FANOUT_LEAF=16.  Furthermore, as long as
    a given compiler gives a deterministic result for 1<<N for N>=32, the
    code correctly invokes all SRCU callbacks, albeit wasting CPU time along
    the way.
    
    This commit therefore substitutes the correct 1UL for the buggy 1.
    
    Found by Linux Verification Center (linuxtesting.org) with SVACE.
    
    Signed-off-by: Denis Arefev <arefev@swemel.ru>
    Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: David Laight <David.Laight@aculab.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 833a8f848a90..5602042856b1 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 				snp->grplo = cpu;
 			snp->grphi = cpu;
 		}
-		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
+		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
 	}
 	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
 	return true;
@@ -835,7 +835,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 	int cpu;
 
 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1 << (cpu - snp->grplo))))
+		if (!(mask & (1UL << (cpu - snp->grplo))))
 			continue;
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 	}
