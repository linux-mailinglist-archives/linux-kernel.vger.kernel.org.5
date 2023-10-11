Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF49A7C5561
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJKN0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbjJKN0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:26:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A515A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4YrjkmK5upRYwbkDcj+pSMAUrTHwaFr1/OzjFdDvbY8=; b=aAQZAN+flZxWL8H0Ca9UqhgfV4
        W9SfV9Zn5blzAAWfrdp15Js+iKQgYPSrisaRei+aNk+qb4AJCIO3Rq5CGmV0JXbIiPU2Th9EJmu4T
        iixjwSloJZnVUquxcZuVYNJ9Upto+l4Q6xMJLTGL36lt19m+ACqAb9n1e4lyCNtgFw5FVGfp/p7CC
        tk/HJ7XOAZs6uKo54rdKZ9PmfG1G7wg6H78NJvCRnTROsQ7NtVAv1moa8w8ljlg3ocAw9qL0y1S0H
        x9LnP40TxO6q/6TdJJX4yYQF7uRyA+tMOOIbtl03cVzV/h/4FXh6ke4+gi8pEo3VznwxjIZyKpYuB
        a4hoboFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqZEJ-00AzIj-BZ; Wed, 11 Oct 2023 13:26:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BB0C30026F; Wed, 11 Oct 2023 15:26:27 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:26:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kuyo Chang =?utf-8?B?KOW8teW7uuaWhyk=?= <Kuyo.Chang@mediatek.com>
Cc:     "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] sched: Fix stop_one_cpu_nowait() vs hotplug
Message-ID: <20231011132626.GP14330@noisy.programming.kicks-ass.net>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
 <20230927080850.GB21824@noisy.programming.kicks-ass.net>
 <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
 <20230929102135.GD6282@noisy.programming.kicks-ass.net>
 <8ad1b617a1040ce4cc56a5d04e8219b5313a9a6e.camel@mediatek.com>
 <20231010145747.GQ377@noisy.programming.kicks-ass.net>
 <20231010200442.GA16515@noisy.programming.kicks-ass.net>
 <172a3c89d7937725b61721e869eab3e5ae582643.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172a3c89d7937725b61721e869eab3e5ae582643.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:24:19AM +0000, Kuyo Chang (張建文) wrote:
> On Tue, 2023-10-10 at 22:04 +0200, Peter Zijlstra wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Tue, Oct 10, 2023 at 04:57:47PM +0200, Peter Zijlstra wrote:
> > > On Tue, Oct 10, 2023 at 02:40:22PM +0000, Kuyo Chang (張建文) wrote:
> > 
> > > > It is running good so far(more than a week)on hotplug/set
> > affinity
> > > > stress test. I will keep it testing and report back if it happens
> > > > again.
> > > 
> > > OK, I suppose I should look at writing a coherent Changelog for
> > this
> > > then...
> > 
> > Something like the below... ?
> > 
> Thanks for illustrate the race scenario. It looks good to me.
> But how about RT? Does RT also need this invocations as below?
> 
> ---
>  kernel/sched/rt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e93b69ef919b..6aaf0a3d6081 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2063,9 +2063,11 @@ static int push_rt_task(struct rq *rq, bool
> pull)
>                  */
>                 push_task = get_push_task(rq);
>                 if (push_task) {
> +                       preempt_disable();
>                         raw_spin_rq_unlock(rq);
>                         stop_one_cpu_nowait(rq->cpu, push_cpu_stop,
>                                             push_task, &rq->push_work);
> +                       preempt_enable();
>                         raw_spin_rq_lock(rq);
>                 }
> 
> @@ -2402,9 +2404,11 @@ static void pull_rt_task(struct rq *this_rq)
>                 double_unlock_balance(this_rq, src_rq);
> 
>                 if (push_task) {
> +                       preempt_disable();
>                         raw_spin_rq_unlock(this_rq);
>                         stop_one_cpu_nowait(src_rq->cpu, push_cpu_stop,
>                                             push_task, &src_rq-
> >push_work);
> +                       preempt_enable();
>                         raw_spin_rq_lock(this_rq);
>                 }
>         }

bah, clearly git-grep didn't work for me last night, I'll go fix up.
