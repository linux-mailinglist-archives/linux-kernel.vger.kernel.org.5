Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F229E7DE355
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344461AbjKAOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjKAOix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:38:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086383
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 07:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VYAYOAUM0f21UoZopL6UQoz3bQ50cgRdV9XxeLOz8Kw=; b=hehd9o16JJHfFnyJYCBD7eG3MX
        62Z2O5bsjEs5fH0g4E19XeCTTpdzjws4YKIs2MIkr8vqptkDDuD0FOmJp4rO/qdx7xzQdTNjcPwpi
        FUmTFX6updIbhrC9WHDP2A6mfoDkYvkvdIeXrkYIWQ7l3fMEC2Dnja/OZwyBYFiDKZorc0p/PFbQY
        eOQ8HxzYe+xcOz9Cog1LXvTLwnbhasdQGumDQIehVc2+dYg1NMgvm36CL3AWxIBu/dzS5DqpU82nZ
        1Gu+yqh9hem6QgIOc2odGKGhG7OeDKsMH42E88IPqoqMzpOgEsSsx7qy33n/p3J1/7QNRFzGwFC9B
        PmUono5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qyCMJ-005lTq-0Q;
        Wed, 01 Nov 2023 14:38:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C252F3002AF; Wed,  1 Nov 2023 15:38:14 +0100 (CET)
Date:   Wed, 1 Nov 2023 15:38:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        aubrey.li@linux.intel.com, yu.c.chen@intel.com,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        boqun.feng@gmail.com, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH] rcu: Break rcu_node_0 --> &rq->__lock order
Message-ID: <20231101143814.GL15024@noisy.programming.kicks-ass.net>
References: <20231031001418.274187-1-longman@redhat.com>
 <20231031085308.GB35651@noisy.programming.kicks-ass.net>
 <a46f5614-53ec-49fb-86d0-fa5aea4d0a42@paulmck-laptop>
 <20231031200228.GG15024@noisy.programming.kicks-ass.net>
 <CALm+0cWuZZLWkwMPS6n1YyTWzkex9=c1E9CB-m6e_F38MNLVqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm+0cWuZZLWkwMPS6n1YyTWzkex9=c1E9CB-m6e_F38MNLVqw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 07:21:09PM +0800, Z qiang wrote:

> >  static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
> >  {
> >         unsigned long jtsq;
> > +       int ret = 0;
> >         struct rcu_node *rnp = rdp->mynode;
> >
> >         /*
> > @@ -847,8 +852,8 @@ static int rcu_implicit_dynticks_qs(stru
> >             (time_after(jiffies, READ_ONCE(rdp->last_fqs_resched) + jtsq * 3) ||
> >              rcu_state.cbovld)) {
> >                 WRITE_ONCE(rdp->rcu_urgent_qs, true);
> > -               resched_cpu(rdp->cpu);
> >                 WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> > +               ret = -1;
> >         }
> >
> 
> 
> Maybe some modifications are missing here:
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index aa4c808978b8..77e7a0dc722a 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -867,8 +867,8 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
>         if (time_after(jiffies, rcu_state.jiffies_resched)) {
>                 if (time_after(jiffies,
>                                READ_ONCE(rdp->last_fqs_resched) + jtsq)) {
> -                       resched_cpu(rdp->cpu);
>                         WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> +                       ret = -1;
>                 }
>                 if (IS_ENABLED(CONFIG_IRQ_WORK) &&
>                     !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> 
> 

Bah, you're quite right, I missed that there were two sites calling
resched_cpu().

Paul, do you want a fixed up version or will you fold in the fix?
