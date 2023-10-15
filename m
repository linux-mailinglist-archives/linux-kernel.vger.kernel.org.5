Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156E27C98B8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjJOKpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 06:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOKpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 06:45:53 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F295FA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OMXIfKJtP8Zr21SLnkQc019y62ZA5kcIt5+lgRa0zu0=; b=I8e6tOtk0j4vCBAqKN82Uj3a/T
        3h+19CT7hkYdSa08ZGlG7qpiMGh1+WSpRZk3WInvKorKLQ3IxHFaLo8duLcQ4hz73Jj1jjv7mdpkZ
        xYGZoqeeSAbOnkzy2PmJjcjttWhQyBVeAkMNJ+TIfT0TCjGmR0uxOsJGzrh6kHSOCOPZHl+o/z1zz
        REP80ngeSHBFNFDICygeoJHWm+bDAzyn1+tr7tTs3zQ3B4jGZvn4/0Udn9qReQ+hqSM3C41kFUoHC
        9KEopG8XuQxD20SG5Jv9qrHmtQROUFyDoUoFQtyxJuIkX1DI8e5qFgI95JbBH2ghA2Iku+mvQd+qg
        E7l2pVjQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qrybj-004nqf-2a;
        Sun, 15 Oct 2023 10:44:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAB42300513; Sun, 15 Oct 2023 12:44:28 +0200 (CEST)
Date:   Sun, 15 Oct 2023 12:44:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Youssef Esmat <youssefesmat@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bsegall@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        corbet@lwn.net, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de,
        wuyun.abel@bytedance.com
Subject: Re: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
Message-ID: <20231015104428.GA11840@noisy.programming.kicks-ass.net>
References: <20231013030213.2472697-1-youssefesmat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013030213.2472697-1-youssefesmat@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:02:13PM -0500, Youssef Esmat wrote:
> Interactive workloads see performance gains by disabling eligibility
> checks (EEVDF->EVDF). Disabling the checks reduces the number of
> context switches and delays less important work (higher deadlines/nice
> values) in favor of more important work (lower deadlines/nice values).
> 
> That said, that can add large latencies for some work loads and as the
> default is eligibility on, but allowing it to be turned off when
> beneficial.
> 
> Signed-off-by: Youssef Esmat <youssefesmat@chromium.org>
> Link: https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com/
> ---
>  kernel/sched/fair.c     | 3 +++
>  kernel/sched/features.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a751e552f253..16106da5a354 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -728,6 +728,9 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  	s64 avg = cfs_rq->avg_vruntime;
>  	long load = cfs_rq->avg_load;
>  
> +	if (!sched_feat(ENFORCE_ELIGIBILITY))
> +		return 1;
> +
>  	if (curr && curr->on_rq) {
>  		unsigned long weight = scale_load_down(curr->load.weight);
>  

Right.. could you pretty please try:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/eevdf

as of yesterday or so.

It defaults to (EEVDF relevant features):

SCHED_FEAT(PLACE_LAG, true)
SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
SCHED_FEAT(PREEMPT_SHORT, true)
SCHED_FEAT(PLACE_SLEEPER, false)
SCHED_FEAT(GENTLE_SLEEPER, true)
SCHED_FEAT(EVDF, false)
SCHED_FEAT(DELAY_DEQUEUE, true)
SCHED_FEAT(GENTLE_DELAY, true)

If that doesn't do well enough, could you please try, in order of
preference:

2) NO_GENTLE_DELAY
3) NO_DELAY_DEQUEUE, PLACE_SLEEPER
4) NO_DELAY_DEQUEUE, PLACE_SLEEPER, NO_GENTLE_SLEEPER

I really don't like the EVDF option, and I think you'll end up
regretting using it sooner rather than later, just to make this one
benchmark you have happy.

I'm hoping the default is enough, but otherwise any of the above should
be a *much* better scheduler.

Also, bonus points if you can create us a stand alone benchmark that
captures your metric (al-la facebook's schbench) without the whole
chrome nonsense, that'd be epic.
