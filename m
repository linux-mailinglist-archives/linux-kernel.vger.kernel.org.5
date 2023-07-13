Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B0752DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbjGMX2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGMX2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF1426B3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689290846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMEnf8rXxOUbhCoMjSDXkxxMaYDWouwwWK2L8mM+xTY=;
        b=PcjdwTIk15zmrkA0wf2cmB/fmJIK0+ZJ/NupIjP3Vt/hM37FcLiYGNbdyQFKh1ZB+paFSv
        8IWdOm+WN7woPSDA2SFazLqbiuT+uu5x1ZBZM/hTY9WEd67A/KiRGAcpi/dlPORPbNib24
        oMmLcc304zRJ2TDsMdiBbsWuy2fg9GY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-D7yz2JQ4MiSjr_yOG0uqWw-1; Thu, 13 Jul 2023 19:27:23 -0400
X-MC-Unique: D7yz2JQ4MiSjr_yOG0uqWw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88C47800B35;
        Thu, 13 Jul 2023 23:27:22 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.34.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E02EA492B01;
        Thu, 13 Jul 2023 23:27:21 +0000 (UTC)
Date:   Thu, 13 Jul 2023 19:27:19 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Benjamin Segall <bsegall@google.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <20230713232719.GA32912@lorien.usersys.redhat.com>
References: <20230712133357.381137-1-pauld@redhat.com>
 <20230712133357.381137-2-pauld@redhat.com>
 <xm268rbkg4tg.fsf@google.com>
 <20230713132306.GA13342@lorien.usersys.redhat.com>
 <xm26zg3zefl7.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26zg3zefl7.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 01:12:04PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > On Wed, Jul 12, 2023 at 03:09:31PM -0700 Benjamin Segall wrote:
> >> Phil Auld <pauld@redhat.com> writes:
> >> 
> >> > In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> >> > groups due to the previous fix simply taking the min.  It should
> >> > reflect a limit imposed at that level or by an ancestor. Even
> >> > though cgroupv2 does not require child quota to be less than or
> >> > equal to that of its ancestors the task group will still be
> >> > constrained by such a quota so this should be shown here. Cgroupv1
> >> > continues to set this correctly.
> >> >
> >> > In both cases, add initialization when a new task group is created
> >> > based on the current parent's value (or RUNTIME_INF in the case of
> >> > root_task_group). Otherwise, the field is wrong until a quota is
> >> > changed after creation and __cfs_schedulable() is called.
> >> >
> >> > Fixes: c53593e5cb69 ("sched, cgroup: Don't reject lower cpu.max on ancestors")
> >> > Signed-off-by: Phil Auld <pauld@redhat.com>
> >> > Reviewed-by: Ben Segall <bsegall@google.com>
> >> > Cc: Ingo Molnar <mingo@redhat.com>
> >> > Cc: Peter Zijlstra <peterz@infradead.org>
> >> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> >> > Cc: Juri Lelli <juri.lelli@redhat.com>
> >> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >> > Cc: Valentin Schneider <vschneid@redhat.com>
> >> > Cc: Ben Segall <bsegall@google.com>
> >> > Cc: Frederic Weisbecker <frederic@kernel.org>
> >> > Cc: Tejun Heo <tj@kernel.org>
> >> > ---
> >> >
> >> > v2: Improve comment about how setting hierarchical_quota correctly
> >> >
> >> > helps the scheduler. Remove extra parens.
> >> >  kernel/sched/core.c  | 13 +++++++++----
> >> >  kernel/sched/fair.c  |  7 ++++---
> >> >  kernel/sched/sched.h |  2 +-
> >> >  3 files changed, 14 insertions(+), 8 deletions(-)
> >> >
> >> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> > index a68d1276bab0..f80697a79baf 100644
> >> > --- a/kernel/sched/core.c
> >> > +++ b/kernel/sched/core.c
> >> > @@ -9904,7 +9904,7 @@ void __init sched_init(void)
> >> >  		ptr += nr_cpu_ids * sizeof(void **);
> >> >  
> >> >  		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> >> > -		init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
> >> > +		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
> >> >  #endif /* CONFIG_FAIR_GROUP_SCHED */
> >> >  #ifdef CONFIG_RT_GROUP_SCHED
> >> >  		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> >> > @@ -11038,11 +11038,16 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
> >> >  
> >> >  		/*
> >> >  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> >> > -		 * always take the min.  On cgroup1, only inherit when no
> >> > -		 * limit is set:
> >> > +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> >> > +		 * inherit when no limit is set. In cgroup2 this is used
> >> > +		 * by the scheduler to determine if a given CFS task has a
> >> > +		 * bandwidth constraint at some higher level.
> >> >  		 */
> >> 
> >> It's still used for determining this on cgroup1 (and the cgroup1 code
> >> still works for that), right?
> >>
> >
> > It would, except that the enforcement of child quota <= parent quota
> > means that cfs_rq->runtime_enabled will be set and we'll hit that first
> > on cgroup1.  So we don't really use it for this determination in
> > cgroup1.
> 
> cgroup1 tg_cfs_schedulable_down only constricts child quota when it's
> set. You can set quota=RUNTIME_INF on any cgroup, no matter what its
> parent is. (The schedulable constraint is a little silly)
> 

Aargh :)   I had "In both cases this ..." there before I talked myself out
of it.

I'll update this one.



Cheers,
Phil



-- 

