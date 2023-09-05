Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23955792A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239910AbjIEQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354672AbjIEN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:26:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDCA12A;
        Tue,  5 Sep 2023 06:26:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 971F5604EF;
        Tue,  5 Sep 2023 13:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00599C433C7;
        Tue,  5 Sep 2023 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693920372;
        bh=uR1L60tg6Q3zWpMHCV8Bm73uXv8eg6vy7Ps7U/amzzc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NPS4Ps0Jjf3g66RB02FzeG7tDhrB6k5drTaDLuokDSYwYj8zh4yoli6valfAnhojH
         YumrNDuWH2EHNRtRD5r3HkhkriTS1gylhLDejwgIey/j5DBH8D1Hk1rp+JzhTu4Fek
         geZ0ImNBFZHoUt3uDIvo3WqqXcHurXt/tf9lwSJat1K/Ocbwj/PlUiVdC4EJwPuvRU
         t+Mm66Z6YHQ7wbQE0lM22evYS2N6pUvU8pKvu3ZugVkLYs0ebaXLvX//V1hTbAQB+W
         II6yRKGMG0Ee51xSk46ZL0eTsQy2i0hu5v0J0hf31KFW8ujVBZDKMRXQyJgD4lF4UR
         JbT+g8N4ffaLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 81B6ECE0CF9; Tue,  5 Sep 2023 06:26:11 -0700 (PDT)
Date:   Tue, 5 Sep 2023 06:26:11 -0700
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
Message-ID: <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230904094251.64022-1-arefev@swemel.ru>
 <bb708695-a513-2006-0985-d6686e525f5a@efficios.com>
 <429249323d5f41ebbfa4f9e0294b2ddb@AcuMS.aculab.com>
 <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89dc5f3f-f959-0586-6f3c-1481c5d3efc4@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:26:51AM -0400, Mathieu Desnoyers wrote:
> On 9/5/23 05:31, David Laight wrote:
> > From: Mathieu Desnoyers
> > > Sent: 04 September 2023 11:24
> > > 
> > > On 9/4/23 05:42, Denis Arefev wrote:
> > > > The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> > > > is subject to overflow due to a failure to cast operands to a larger
> > > > data type before performing arithmetic
> > > 
> > > The patch title should identify more precisely its context, e.g.:
> > > 
> > > "srcu: Fix srcu_struct node grpmask overflow on 64-bit systems"
> > > 
> > > Also, as I stated in my reply to the previous version, the patch commit
> > > message should describe the impact of the bug it fixes.
> > 
> > And is the analysis complete?
> > Is 1UL right for 32bit archs??
> > Is 64 bits even enough??
> 
> I understand from include/linux/rcu_node_tree.h and kernel/rcu/Kconfig
> RCU_FANOUT and RCU_FANOUT_LEAF ranges that a 32-bit integer is sufficient to
> hold the mask on 32-bit architectures, and a 64-bit integer is enough on
> 64-bit architectures given the current implementation.
> 
> At least this appears to be the intent. I did not do a thorough analysis of
> the various parameter limits.

Mathieu has it right.

32-bit kernels are unaffected by this bug.

RCU_FANOUT_LEAF defaults to 16, which means that a 64-bit kernel would
need more than 32 leaf rcu_node structures for the parent rcu_node
structure to need more than 32 bit to track its children.  This means
that more than 32*16=512 CPUs are required for this bug to affect 64-bit
systems.  And there really are systems this big, so I am surprised that
this has not shown up long ago.  But it would not be the first time that
objective reality surprised me.  ;-)

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> > 	David
> > 
> > > 
> > > Thanks,
> > > 
> > > Mathieu
> > > 
> > > 
> > > > 
> > > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > > > 
> > > > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > > > ---
> > > > v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
> > > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > >    kernel/rcu/srcutree.c | 4 ++--
> > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 20d7a238d675..6c18e6005ae1 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
> > > >    				snp->grplo = cpu;
> > > >    			snp->grphi = cpu;
> > > >    		}
> > > > -		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > > +		sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
> > > >    	}
> > > >    	smp_store_release(&ssp->srcu_sup->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
> > > >    	return true;
> > > > @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
> > > >    	int cpu;
> > > > 
> > > >    	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > > > -		if (!(mask & (1 << (cpu - snp->grplo))))
> > > > +		if (!(mask & (1UL << (cpu - snp->grplo))))
> > > >    			continue;
> > > >    		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > > >    	}
> > > 
> > > --
> > > Mathieu Desnoyers
> > > EfficiOS Inc.
> > > https://www.efficios.com
> > 
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> > Registration No: 1397386 (Wales)
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
