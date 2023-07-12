Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4177512B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbjGLVem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjGLVek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:34:40 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FE1FD6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:34:34 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76547539775so1277385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689197673; x=1691789673;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nD2UHBnDUTT495iUHIZR2679LgJRZ//qU2Zi+uGyIVE=;
        b=MXhSnUtFz2wxuW06onRo1c6SgRibBWw03flHAsiCbZdWVbW7uagvzcjdLFzL4iZ5d5
         avmBDXQn17tNroJC1XPHIhBGHRoIHnH7yEzTis2YU8+brrDde6AaKa6Sew8Cq/C0E1N5
         cuyCj4F3Zjxmuz9+oVpntgeKCTHRwgXSGPanIV3MQBjafE8Mka/PAYO6mK4j0bths4mV
         +8FJ3sY3okLaSkdu/Cd0DHuUVnclt0Dufmb/tvHaN1ehhhCOdrVK4psDs5lk9WzCC0/B
         KHJLEJr65xFY5asZErb4Y5YyV6+JzF9Z/xLQRuxgCTk7t9/lgPWCQgUSPRZygluNWGHG
         aTDw==
X-Gm-Message-State: ABy/qLZ3Bt2H525WWOXstztLX81ZUUsnNznxWpfKlg1aUROeHgkcFIHs
        XmQI532ol3fVNNKLEimddoM=
X-Google-Smtp-Source: APBJJlFdYfKVnrscOwnimxA8jm43UHALuhOoJC0+XdaXxBUzMy3bSrTFSleX2LkTAMfhXBMLCuXdbA==
X-Received: by 2002:a05:620a:1913:b0:767:7db3:9a32 with SMTP id bj19-20020a05620a191300b007677db39a32mr22374944qkb.3.1689197673089;
        Wed, 12 Jul 2023 14:34:33 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id p10-20020a05620a132a00b00767cc1463e9sm2430907qkj.75.2023.07.12.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:34:32 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:34:30 -0500
From:   David Vernet <void@manifault.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com, clm@meta.com,
        tj@kernel.org, roman.gushchin@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 4/7] sched/fair: Add SHARED_RUNQ sched feature and
 skeleton calls
Message-ID: <20230712213430.GE12207@maniforge>
References: <20230710200342.358255-1-void@manifault.com>
 <20230710200342.358255-5-void@manifault.com>
 <6111b87c-b68c-2ba9-ac60-333af67082fd@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6111b87c-b68c-2ba9-ac60-333af67082fd@bytedance.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:39:03PM +0800, Abel Wu wrote:
> On 7/11/23 4:03 AM, David Vernet wrote:
> > @@ -6467,6 +6489,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >   dequeue_throttle:
> >   	util_est_update(&rq->cfs, p, task_sleep);
> >   	hrtick_update(rq);
> > +
> > +	if (sched_feat(SHARED_RUNQ))
> > +		shared_runq_dequeue_task(p);
> 
> Would disabling SHARED_RUNQ causing task list nodes left
> in the shared stateful runqueue?

Hi Abel,

Yes, good call, there will be some stale tasks. The obvious way to get
around that would of course be to always call
shared_runq_dequeue_task(p) on the __dequeue_entity() path, but it would
be silly to tax a hot path in the scheduler in support of a feature
that's disabled by default.

At first I was thinking that the only issue would be some overhead in
clearing stale tasks once it was re-enabled, but that we'd be OK because
of this check in shared_runq_pick_next_task():

  298         if (task_on_rq_queued(p) && !task_on_cpu(rq, p)) {
  299                 update_rq_clock(src_rq);
  300                 src_rq = move_queued_task(src_rq, &src_rf, p, cpu_of(rq));
  301         }

So we wouldn't migrate tasks that weren't actually suitable. But that's
obviously wrong. It's not safe to keep stale tasks in that list for (at
least) two reasons.

- A task could exit (which would be easy to fix by just adding a dequeue
  call in task_dead_fair())
- We could have a double-add if a task is re-enqueued in the list after
  having been previously enqueued, but then never dequeued due to the
  timing of disabling SHARED_RUNQ.

Not sure what the best solution is here. We could always address this by
draining the list when the feature is disabled, but there's not yet a
mechanism to hook in a callback to be invoked when a scheduler feature
is enabled/disabled. It shouldn't be too hard to add that, assuming
other sched folks are amenable to it. It should just be a matter of
adding another __SCHED_FEAT_NR-sized table of NULL-able callbacks that
are invoked on enable / disable state change, and which can be specified
in a new SCHED_FEAT_CALLBACK or something macro.

Peter -- what do you think?

Thanks,
David
