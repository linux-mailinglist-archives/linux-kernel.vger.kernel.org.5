Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EE7929D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353701AbjIEQ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354742AbjIEOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A02C9;
        Tue,  5 Sep 2023 07:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04AD360A05;
        Tue,  5 Sep 2023 14:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5931DC433C8;
        Tue,  5 Sep 2023 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693922415;
        bh=764yMbuNMe5JetI5MaMMRQb1mxEqxLpU0jdCUiYvO2w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pcJUcT6A1q+IhvNaKBGuS9tB/gTtXUinjnY0zK98Lc08Eq4tFiS2LRoCEeHFKlj7d
         vxZbhDMM63vF+tNq2YKA/0FRk1KAgTcSLrqftS4PtfB3M0lpO1JcqQJgKqo4yol6vR
         oNh/XUI/gs0795wz3iJ+kPWe+ba12B+RzzD08vpd01C4YJRVZX/HOuYgQ6WroLadK1
         1nX/1tA5k5GTEEqhMogAUdNpIat6kidxD0gy5vizMmVOJBa9EEfw4o/TJbwAjW4sL/
         Efsx6n6UqqlIh8dryApUAG90RvtSRqhYRKSOL2XjBm8IWo2zfGf5FaT7YLYVPTNa8U
         KMWUmiznTNDlQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EECEACE0CF9; Tue,  5 Sep 2023 07:00:14 -0700 (PDT)
Date:   Tue, 5 Sep 2023 07:00:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org,
        trufanov@swemel.ru, vfh@swemel.ru,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] Fix srcu_struct node grpmask overflow on 64-bit
 systems
Message-ID: <ba1292b4-8feb-4359-9bfc-120082359a17@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230904122114.66757-1-arefev@swemel.ru>
 <a60cf690-2af7-1eee-c1c1-3433d16a1939@efficios.com>
 <40593b16-8232-27fc-808a-37bad7457dc0@efficios.com>
 <751d2afd-fc91-400d-8889-187031f2bbf0@paulmck-laptop>
 <7beb35c3-217a-d3c3-8e75-a1212500d2ac@efficios.com>
 <98c676a6-3c11-48f1-b7cb-81356c362680@paulmck-laptop>
 <2613d958-8e8a-c302-8779-8719a10c82e5@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2613d958-8e8a-c302-8779-8719a10c82e5@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:43:04AM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 09:38, Paul E. McKenney wrote:
> > On Tue, Sep 05, 2023 at 08:57:53AM -0400, Mathieu Desnoyers wrote:
> > > On 9/4/23 09:58, Paul E. McKenney wrote:
> > > > On Mon, Sep 04, 2023 at 08:58:48AM -0400, Mathieu Desnoyers wrote:
> > > > > On 9/4/23 08:42, Mathieu Desnoyers wrote:
> > > > > > On 9/4/23 08:21, Denis Arefev wrote:
> > > > > > > The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> > > > > > > is subject to overflow due to a failure to cast operands to a larger
> > > > > > > data type before performing arithmetic.
> > > > > > > 
> > > > > > > The maximum result of this subtraction is defined by the RCU_FANOUT
> > > > > > > or other srcu level-spread values assigned by rcu_init_levelspread(),
> > > > > > > which can indeed cause the signed 32-bit integer literal ("1") to
> > > > > > > overflow
> > > > > > > when shifted by any value greater than 31.
> > > > > > 
> > > > > > We could expand on this:
> > > > > > 
> > > > > > The maximum result of this subtraction is defined by the RCU_FANOUT
> > > > > > or other srcu level-spread values assigned by rcu_init_levelspread(),
> > > > > > which can indeed cause the signed 32-bit integer literal ("1") to overflow
> > > > > > when shifted by any value greater than 31 on a 64-bit system.
> > > > > > 
> > > > > > Moreover, when the subtraction value is 31, the 1 << 31 expression results
> > > > > > in 0xffffffff80000000 when the signed integer is promoted to unsigned long
> > > > > > on 64-bit systems due to type promotion rules, which is certainly not the
> > > > > > intended result.
> > > > 
> > > > Thank you both!  Could you please also add something to the effect of:
> > > > "Given default Kconfig options, this bug affects only systems with more
> > > > than 512 CPUs."?
> > > 
> > > Hi Paul,
> > > 
> > > I'm trying to understand this "NR_CPUS > 512 CPUs" default Kconfig lower
> > > bound from kernel/rcu/Kconfig and rcu_node_tree.h. Is that on a 32-bit or
> > > 64-bit architecture ? Also, I suspect that something like x86-64 MAXSMP (or
> > > an explicit NR_CPUS) needs to be selected over a default Kconfig to support
> > > that many CPUs.
> > 
> > 64-bit only.  I believe that 32-bit kernels are unaffected by this bug.
> > 
> > The trick is that RCU reshapes the rcu_node tree in rcu_init_geometry(),
> > which is invoked during early boot from rcu_init().  This reshaping is
> > based on nr_cpu_ids.  So if NR_CPUS is (say) 4096, there will be enough
> > rcu_node structures allocated at build time to accommodate 4096 CPUs
> > (259 of them, 256 leaf nodes, four internal nodes, and one root node),
> > but only assuming dense numbering of CPUs.  If rcu_init_geometry() sees
> > that nr_cpu_ids is (say) 64, it will use only five of them, that is,
> > four leaf nodes and one root node.  The leaf nodes will need to shift
> > by at most 16, and the root node by at most 4.
> > 
> > But the possibility of sparse CPU numbering (perhaps to your point)
> > means that the bug can occur in 64-bit kernels booted on systems with
> > 512 CPUs or fewer if that system has sparse CPU IDs.  For example,
> > there have been systems that disable all but one hardware thread per
> > core, but leave places in the CPU numbering for those disabled threads.
> > Such a system with four hardware threads per core could have a CPU 516
> > (and thus be affected by this bug) with as few as 129 CPUs.
> > 
> > So a better request would be for something like: "Given default Kconfig
> > options, this bug affects only 64-bit systems having at least one CPU
> > for which smp_processor_id() returns 512 or greater."
> > 
> > Does that help, or am I missing your point?
> 
> This is a good point, although not the one I was trying to make. See my
> explanation about impact of having exactly 512 wrt signed integer type
> promotion in a separate email. So your last phrasing "returns 512 or
> greater" is better. Previously it appeared that only systems with _more
> than_ 512 cpus were affected, which was off-by-one considering that systems
> with exactly 512 cpus are an issue as well.

If 512 CPUs is an issue, then so also is 497 CPUs.  Both result in a
32-bit shift.  If having the upper 33 bits act as a unit is OK (and I
*think* that it is), then you need that 513th CPU (or, better, a CPU
whose smp_processor_id() return value is at least 513) to make something
bad happen.

I would also be OK with noting that with 497 or more CPUs, strange
things start happening.  My intent was definitely that there only be
a single bit set in sdp->grpmask, after all!  The fact that it might
(or might not) happen to work notwithstanding.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > 
> > > > 
> > > > 							Thanx, Paul
> > > > 
> > > > > > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > > > > 
> > > > > > With the commit message updated with my comment above, please also add:
> > > > > > 
> > > > > > Fixes: c7e88067c1 ("srcu: Exact tracking of srcu_data structures
> > > > > > containing callbacks")
> > > > > > Cc: <stable@vger.kernel.org> # v4.11
> > > > > 
> > > > > Sorry, the line above should read:
> > > > > 
> > > > > Cc: <stable@vger.kernel.org> # v4.11+
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Mathieu
> > > > > 
> > > > > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > 
> > > > > > Thanks!
> > > > > > 
> > > > > > Mathieu
> > > > > > 
> > > > > > > 
> > > > > > > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > > > > > > ---
> > > > > > > v3: Changed the name of the patch, as suggested by
> > > > > > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > > v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
> > > > > > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > > >     kernel/rcu/srcutree.c | 4 ++--
> > > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > > index 20d7a238d675..6c18e6005ae1 100644
> > > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > > @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct
> > > > > > > srcu_struct *ssp, gfp_t gfp_flags)
> > > > > > >                     snp->grplo = cpu;
> > > > > > >                 snp->grphi = cpu;
> > > > > > >             }
> > > > > > > -        sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > > > > > +        sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
> > > > > > >         }
> > > > > > >         smp_store_release(&ssp->srcu_sup->srcu_size_state,
> > > > > > > SRCU_SIZE_WAIT_BARRIER);
> > > > > > >         return true;
> > > > > > > @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct
> > > > > > > srcu_struct *ssp, struct srcu_node *snp
> > > > > > >         int cpu;
> > > > > > >         for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > > > > > > -        if (!(mask & (1 << (cpu - snp->grplo))))
> > > > > > > +        if (!(mask & (1UL << (cpu - snp->grplo))))
> > > > > > >                 continue;
> > > > > > >             srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > > > > > >         }
> > > > > > 
> > > > > 
> > > > > -- 
> > > > > Mathieu Desnoyers
> > > > > EfficiOS Inc.
> > > > > https://www.efficios.com
> > > > > 
> > > 
> > > -- 
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> > > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
