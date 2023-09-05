Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F156792D14
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbjIESII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbjIESHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:07:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408F50661;
        Tue,  5 Sep 2023 09:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B99E5CE126A;
        Tue,  5 Sep 2023 16:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04890C433CA;
        Tue,  5 Sep 2023 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693932052;
        bh=THH0aq0nNXLuspZFTRqOMQkW5/piGLqHprgarFJgc88=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WfbIM/tpXaz4d7K6JpnRTikz/tvvXt9kZWjJIZi0uXSoTkZ4sydVumIA0GC1OrYGm
         Jg5oILZdROvLu3hjimLMck87WIP41pbuPXLjHqgDg6on+NKZb4RxZ8IpplIKrGwqnX
         J2VqjIT13974qOAXK4rIOLxYyIt58VQboNMVJP+I+luYKTLmAWM+nG+gNSe/P+V8d6
         Djkrx7+bLLKONf3KjLu94beszxWRgwZHUazrT8YvmOjwV4TwpLe0lnghoOv0XO690p
         +aF3STb+bfr5rRSL93SCLtcY6Oc1smcSLhz0atRgFp/99MA2lWVroyNo4gVfUv4wfo
         7qvRSE86/QtiA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8F2BECE0FF4; Tue,  5 Sep 2023 09:40:51 -0700 (PDT)
Date:   Tue, 5 Sep 2023 09:40:51 -0700
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
Message-ID: <abe14f37-ec05-48c3-87fc-9294848d221f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
 <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
 <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com>
 <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 10:34:43AM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 10:15, David Laight wrote:
> > ...
> > > That would instead be more than 512-16=496 CPUs, correct?  496 CPUs would
> > > only require a 31-bit shift, which should be OK, but 497 would require
> > > a 32-bit shift, which would result in sign extension.  If it turns out
> > > that sign extension is OK, then we should get in trouble at 513 CPUs,
> > > which would result in a 33-bit shift (and is that even defined in C?).
> > 
> > Not quite right :-)
> > 
> > (1 << 31) is int and negative, that gets sign extended before
> > being converted to 'unsigned long' - so has the top 33 bits set.

Good point, thank you for the correction.

> > (1 << 32) is undefined, the current x86 cpu ignore the high
> > shift bits so it is (1 << 0).

Which would cause it to attempt to invoke SRCU callbacks on the
lowest-numbered CPU associated with that srcu_node structure.

> Yes, I was about to reply the same thing. A shift of 31 is buggy,
> because shifting 1 << 31 raises the sign bit, which sets the top 33
> bits when cast to unsigned long. A shift of 1 << 32 is undefined,
> with for instance x86 choosing to ignore the top bit.
> 
> But in order to have a 1 << 31 shift from this expression:
> 
>                 sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> 
> I *think* we need the group to have 32 cpus or more (indexed within
> the group from grplo to grplo + 31 (both inclusive)).
> 
> So as soon as we have one group with 32 cpus, the problem should show
> up. With FANOUT_LEAF=16, we can have 15 groups of 31 cpus and 1
> group of 32 cpus, for:
> 
>   15*31 + 32 = 497 cpus.
> 
> AFAIU, this would be the minimum value for smp_processor_id()+1 which
> triggers this issue.

By default, there are 16 CPUs per leaf srcu_node structure.  Each leaf
srcu_node structure takes up one bit in the parent srcu_node structures'
srcu_data_have_cbs[] array.  Up to 30 bits is OK, 31 bits is questionable,
and 32 bits and larger erroneous.

This is the situation as I see it (assuming dense CPU numbering):

	# Leaf srcu_node		Largest
	structures	#CPUs		CPU #		Status

	0-30		0-480		479		Good
	31		481-496		495		Questionable
	32-		497-		496+		Bad.

Tree SRCU differs from Tree RCU in its operation, so this bug should
not hold up SRCU grace periods.  It might instead cause SRCU callbacks
to be ignored (which would admittedly look quite similar to the user).

My attempts to cheat the numbering system ran up against the limited
height of the srcu_node tree.

But there is still the question of why this has not been seen in the
wild, given that there really are systems with more than 479 CPUs
out there.  One possibility is the call to srcu_schedule_cbs_sdp()
from srcu_funnel_gp_start().  But it does not seem likely that this
would happen all that often, as it requires back-to-back grace periods
and then some.

Maybe people with large systems boot with srcutree.convert_to_big=0?

Adding Laurent for his thoughts.

Aha!

Here is what makes it work, given David's description of 1<<32:

static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp,
				  unsigned long mask, unsigned long delay)
{
	int cpu;

	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
		if (!(mask & (1 << (cpu - snp->grplo))))
			continue;
		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
	}
}

As long as at least one bit is set in the result of 1<<N, and as long
as the compiler always does the same thing for a given N, then this loop
will make the right thing happen.

But even that is not relied upon, because the calling code looks like
this:

			spin_lock_irq_rcu_node(snp);
			cbs = false;
			last_lvl = snp >= sup->level[rcu_num_lvls - 1];
			if (last_lvl)
				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
			snp->srcu_have_cbs[idx] = gpseq;
			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
			sgsne = snp->srcu_gp_seq_needed_exp;
			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
			if (ss_state < SRCU_SIZE_BIG)
				mask = ~0;
			else
				mask = snp->srcu_data_have_cbs[idx];
			snp->srcu_data_have_cbs[idx] = 0;
			spin_unlock_irq_rcu_node(snp);
			if (cbs)
				srcu_schedule_cbs_snp(ssp, snp, mask, cbdelay);

So that last_lvl check means that the srcu_schedule_cbs_snp() function
is invoked only for leaf srcu_node structures.  Which by default limit
the shift to 16.

So this bug appears to have no effect for default RCU setups, even on very
large 64-bit systems, which is consistent with field experience.  Even if
this is the case, it still should be fixed, to avoid confusion if nothing
else.  Or just in case someone decides to set CONFIG_RCU_FANOUT_LEAF=32.
Which actually happened the other day due to someone trusting ChatGPT's
opinion about RCU Kconfig options...

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > If the mask is being used to optimise a search the code might
> > just happen to work!
> > 
> > 	David
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
