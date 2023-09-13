Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B279E2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbjIMJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbjIMJEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:04:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6BF1999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CcPs1loMse6j9I5mnXT5xMOl9FMdZpWS3PB4AoazHUs=; b=AigZBCojNkNHoE2JG0mWdvw/9K
        sp7rSb1+2jyE9ucAnnmaCkpP7G3qGMM5TgaW53nO1FZe1SP5R6IDPtxbj5mBqCndi8I7fjGT8Dl4I
        MFpibKiyVZs9Ja0evQ4cj/7m7eQ6MeAlmfZxG1U4bJBcJz2WJHUTYq/lwFNTwYT09OqrYKURvvNok
        bM2lHthmhE+9qc9aF53OGTwZx5vS8YQxRtAz3VHadqmIPc+cU/ARt/mVyTcH74VgpGPW/wd/ZYAeo
        RTayjqrZQ5+LDt8Cu0WqYxapvjsEb2DXTqME6KM/SnAx/IsfMCRb6dz0i7GENYB0HELSOezSmViLH
        tPvJeKbQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qgLmT-006wJM-0Z;
        Wed, 13 Sep 2023 09:03:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 48F39300348; Wed, 13 Sep 2023 11:03:30 +0200 (CEST)
Date:   Wed, 13 Sep 2023 11:03:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Subject: Re: [PATCH 07/15] sched/smp: Use lag to simplify cross-runqueue
 placement
Message-ID: <20230913090330.GC692@noisy.programming.kicks-ass.net>
References: <20230531115839.089944915@infradead.org>
 <20230531124604.068911180@infradead.org>
 <20230912153221.lSL8YgJJ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912153221.lSL8YgJJ@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:32:21PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-05-31 13:58:46 [+0200], Peter Zijlstra wrote:
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -12492,22 +12440,9 @@ static void task_fork_fair(struct task_s
> >  
> >  	cfs_rq = task_cfs_rq(current);
> >  	curr = cfs_rq->curr;
> > -	if (curr) {
> > +	if (curr)
> >  		update_curr(cfs_rq);
> > -		se->vruntime = curr->vruntime;
> > -	}
> >  	place_entity(cfs_rq, se, 1);
> > -
> > -	if (sysctl_sched_child_runs_first && curr && entity_before(curr, se)) {
> 
> Since the removal of sysctl_sched_child_runs_first there is no user of
> this anymore. There is still the sysctl file sched_child_runs_first with
> no functionality.
> Is this intended or should it be removed?

Hurmph... I think that knob has been somewat dysfunctional for a long
while and it might be time to remove it.

Ingo?
