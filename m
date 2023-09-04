Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5FA791934
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjIDN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjIDN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299FCD7;
        Mon,  4 Sep 2023 06:58:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59B861772;
        Mon,  4 Sep 2023 13:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11538C433C7;
        Mon,  4 Sep 2023 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693835888;
        bh=Xmt5MQmExYsuinsLeYQbE2KBIh/St74DYmxoosZ1jLQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fhDeo3gOzqU4OFKcwKNkrKOmS3RQKUaJnlzmpg+4Pb3HkTwfEveRNbznbW3c+lkhl
         DTXLNZabNrbxDSqme6B/dZonaOY4id7UbsTjXkN6dtP3uSmJ6ONEJQga+nVkvImFbY
         cSbF62H/a46nQQEHap2ZTU4EE/CtulVinBDf5NtukhJ3JJji9Wy/0/yQ5eXAZzn/3c
         F2rYLFIXgrNUjxkQ729/lQJPknE2cPnboIm/3JnLdgkNYrwQrHPABN8K39rqpNGLXt
         BBJ1YiaGCHpVF3Lv5KF51S86GRlQScqoK7HKOeJbTKfi3Q5kE02W6iU6VGB4CY2WOM
         LvqMUAtkrtmdA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96602CE02BC; Mon,  4 Sep 2023 06:58:07 -0700 (PDT)
Date:   Mon, 4 Sep 2023 06:58:07 -0700
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
Message-ID: <751d2afd-fc91-400d-8889-187031f2bbf0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230904122114.66757-1-arefev@swemel.ru>
 <a60cf690-2af7-1eee-c1c1-3433d16a1939@efficios.com>
 <40593b16-8232-27fc-808a-37bad7457dc0@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40593b16-8232-27fc-808a-37bad7457dc0@efficios.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 08:58:48AM -0400, Mathieu Desnoyers wrote:
> On 9/4/23 08:42, Mathieu Desnoyers wrote:
> > On 9/4/23 08:21, Denis Arefev wrote:
> > > The value of an arithmetic expression 1 << (cpu - sdp->mynode->grplo)
> > > is subject to overflow due to a failure to cast operands to a larger
> > > data type before performing arithmetic.
> > > 
> > > The maximum result of this subtraction is defined by the RCU_FANOUT
> > > or other srcu level-spread values assigned by rcu_init_levelspread(),
> > > which can indeed cause the signed 32-bit integer literal ("1") to
> > > overflow
> > > when shifted by any value greater than 31.
> > 
> > We could expand on this:
> > 
> > The maximum result of this subtraction is defined by the RCU_FANOUT
> > or other srcu level-spread values assigned by rcu_init_levelspread(),
> > which can indeed cause the signed 32-bit integer literal ("1") to overflow
> > when shifted by any value greater than 31 on a 64-bit system.
> > 
> > Moreover, when the subtraction value is 31, the 1 << 31 expression results
> > in 0xffffffff80000000 when the signed integer is promoted to unsigned long
> > on 64-bit systems due to type promotion rules, which is certainly not the
> > intended result.

Thank you both!  Could you please also add something to the effect of:
"Given default Kconfig options, this bug affects only systems with more
than 512 CPUs."?

							Thanx, Paul

> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > With the commit message updated with my comment above, please also add:
> > 
> > Fixes: c7e88067c1 ("srcu: Exact tracking of srcu_data structures
> > containing callbacks")
> > Cc: <stable@vger.kernel.org> # v4.11
> 
> Sorry, the line above should read:
> 
> Cc: <stable@vger.kernel.org> # v4.11+
> 
> Thanks,
> 
> Mathieu
> 
> > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > 
> > Thanks!
> > 
> > Mathieu
> > 
> > > 
> > > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > > ---
> > > v3: Changed the name of the patch, as suggested by
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > v2: Added fixes to the srcu_schedule_cbs_snp function as suggested by
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >   kernel/rcu/srcutree.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 20d7a238d675..6c18e6005ae1 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -223,7 +223,7 @@ static bool init_srcu_struct_nodes(struct
> > > srcu_struct *ssp, gfp_t gfp_flags)
> > >                   snp->grplo = cpu;
> > >               snp->grphi = cpu;
> > >           }
> > > -        sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
> > > +        sdp->grpmask = 1UL << (cpu - sdp->mynode->grplo);
> > >       }
> > >       smp_store_release(&ssp->srcu_sup->srcu_size_state,
> > > SRCU_SIZE_WAIT_BARRIER);
> > >       return true;
> > > @@ -833,7 +833,7 @@ static void srcu_schedule_cbs_snp(struct
> > > srcu_struct *ssp, struct srcu_node *snp
> > >       int cpu;
> > >       for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > > -        if (!(mask & (1 << (cpu - snp->grplo))))
> > > +        if (!(mask & (1UL << (cpu - snp->grplo))))
> > >               continue;
> > >           srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > >       }
> > 
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
> 
