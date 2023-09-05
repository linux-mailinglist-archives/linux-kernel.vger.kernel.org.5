Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1DE792C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbjIERGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354738AbjIEN42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C730197;
        Tue,  5 Sep 2023 06:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C05B60919;
        Tue,  5 Sep 2023 13:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A22FC433C8;
        Tue,  5 Sep 2023 13:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693922183;
        bh=Xn2TNzoAqHCc/VCubFybeQ4GKXdnUAY+NOzSC+boj54=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QIfknY6ay35rE0l2lHjnQXu1AvRjm2hY9agcf1DPGOYK7B5GcloA4OIkh+nCSxxHI
         bsZT6RKXO5UIGM3MmJjS+OTegVEh2l2gBkoIG1oVfDc+u4WFxWUi50DF/Xn/r3XTfW
         mFY5LMMsk3rUFtBdIFuHQO67EcOIedkeVgg7VqgjAWe8tJ3df5+lLAcrdhzP8uZTin
         ehzTBKtIHgE5aUgfx6fn6IfEvrlnGSpEQZrc/Rl5JMQSXxVg4OYD3Q3+nY9GYGtMmv
         4bFKuSh8Q8afV8CvcjxVvaLpWWjB6UUNnql6hAxT/YprmQYepn/w2c9N/4blK5ywZc
         KQUPqR9CeATHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0456FCE0CF9; Tue,  5 Sep 2023 06:56:23 -0700 (PDT)
Date:   Tue, 5 Sep 2023 06:56:22 -0700
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
        "vfh@swemel.ru" <vfh@swemel.ru>
Subject: Re: [PATCH v2] The value may overflow
Message-ID: <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
 <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:34:45AM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 09:26, Paul E. McKenney wrote:
> > On Tue, Sep 05, 2023 at 08:26:51AM -0400, Mathieu Desnoyers wrote:
> > > On 9/5/23 05:31, David Laight wrote:
> > > > From: Mathieu Desnoyers
> > > > > Sent: 04 September 2023 11:24
> > > > > 
> > > > > On 9/4/23 05:42, Denis Arefev wrote:
> > > > > > The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> > > > > > is subject to overflow due to a failure to cast operands to a larger
> > > > > > data type before performing arithmetic
> > > > > 
> > > > > The patch title should identify more precisely its context, e.g.:
> > > > > 
> > > > > "srcu: Fix srcu_struct node grpmask overflow on 64-bit systems"
> > > > > 
> > > > > Also, as I stated in my reply to the previous version, the patch commit
> > > > > message should describe the impact of the bug it fixes.
> > > > 
> > > > And is the analysis complete?
> > > > Is 1UL right for 32bit archs??
> > > > Is 64 bits even enough??
> > > 
> > > I understand from include/linux/rcu_node_tree.h and kernel/rcu/Kconfig
> > > RCU_FANOUT and RCU_FANOUT_LEAF ranges that a 32-bit integer is sufficient to
> > > hold the mask on 32-bit architectures, and a 64-bit integer is enough on
> > > 64-bit architectures given the current implementation.
> > > 
> > > At least this appears to be the intent. I did not do a thorough analysis of
> > > the various parameter limits.
> > 
> > Mathieu has it right.
> > 
> > 32-bit kernels are unaffected by this bug.
> > 
> > RCU_FANOUT_LEAF defaults to 16, which means that a 64-bit kernel would
> > need more than 32 leaf rcu_node structures for the parent rcu_node
> > structure to need more than 32 bit to track its children.  This means
> > that more than 32*16=512 CPUs are required for this bug to affect 64-bit
> > systems.  And there really are systems this big, so I am surprised that
> > this has not shown up long ago.  But it would not be the first time that
> > objective reality surprised me.  ;-)
> 
> So with a 64-bit kernel, RCU_FANOUT_LEAF=16, if we have exactly 32 leaf
> rcu_node structures (exactly 512 CPUs), we end up in the situation where the
> type promotion from signed integer (32-bit) to unsigned long will carry the
> sign, and thus create a mask of 0xffffffff80000000.

If there is someplace that does a shift of 1UL, yes, this would be a
problem.  I don't see one, but I might have missed something.  If all
the shifts are from 1, then the top 33 bits would be always set and
cleared as a unit, as if they were one bit.

> So if this weird mask is indeed an issue we should state that configurations
> _starting from 512 CPUs_ are affected, not just those with more than 512
> CPUs.

That would instead be more than 512-16=496 CPUs, correct?  496 CPUs would
only require a 31-bit shift, which should be OK, but 497 would require
a 32-bit shift, which would result in sign extension.  If it turns out
that sign extension is OK, then we should get in trouble at 513 CPUs,
which would result in a 33-bit shift (and is that even defined in C?).

But this can be tested.  Let's try setting RCU_FANOUT_LEAF to 2.  Then we
"only" need 64 (maybe 62) CPUs to trigger the bug.  And I happen to
have access to a system with 80 CPUs.  (Those with smaller systems can
try to trigger this bug by changing the current "1 <<" to (say) "4 <<",
which should trigger it on 16-CPU systems.)

I just fired off an 80-CPU test with CONFIG_RCU_FANOUT_LEAF=2 and will
let you know how it goes.

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
> > > > 
> > > > 	David
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Mathieu
> > > > > 
> > > > > 
> > > > > > 
> > > > > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > > > > 
> > > > > > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > > > > > ---
> > > > > > v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
> > > > > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > > >     kernel/rcu/srcutree.c | 4 ++--
> > > > > >     1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > > > index 20d7a238d675..6c18e6005ae1 100644
> > > > > > --- a/kernel/rcu/srcutree.c
> > > > > > +++ b/kernel/rcu/srcutree.c
> > > > > > @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
> > > > > >     				snp->grplo = cpu;
> > > > > >     			snp->grphi = cpu;
> > > > > >     		}
> > > > > > -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > > > > +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
> > > > > >     	}
> > > > > >     	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
> > > > > >     	return true;
> > > > > > @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
> > > > > >     	int cpu;
> > > > > > 
> > > > > >     	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > > > > > -		if (!(mask & (1 << (cpu - snp->grplo))))
> > > > > > +		if (!(mask & (1UL << (cpu - snp->grplo))))
> > > > > >     			continue;
> > > > > >     		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > > > > >     	}
> > > > > 
> > > > > --
> > > > > Mathieu Desnoyers
> > > > > EfficiOS Inc.
> > > > > https://www.efficios.com
> > > > 
> > > > -
> > > > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > > > Registration No: 1397386 (Wales)
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
