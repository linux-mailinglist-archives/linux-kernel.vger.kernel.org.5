Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBACF7B20C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjI1PQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjI1PQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:16:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EFB1A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=1aMZSHFJ00QdHHcRXWNmjtWw9D0/fDe8zQRO1jC0Y6c=; b=ksh//XmFWudVXcwZB/50DEfC2b
        S71MVheqbnADXAn7PH/N3RCcPF5sbzGGR2lQ3Qm1i66oCNNvF8KKBQMmL37ZX3hcmQbVI30NxsNVG
        TPvPdA8T6HHf08D/1X0JHIKJzW6h9x8OninTY8z+y9mZ30mVQy+nRoUy4jQrG3gICpcdTZl1qnife
        VgGcxFjLIWhmikV2TaSyYQhUGvRo+etPZlac8lh+KVNSU2VXjNk7C1HNbCjg9HjV5ZD39kw3HYa7P
        e/JPfxnUOIL0blFRQqQ7aEZvqmF9w+Sd+OLEO994Fic7j6yTH64hnaq9KO5VM54GjU7Ho3io5IEqY
        1PlJZOsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlskS-003CWF-JS; Thu, 28 Sep 2023 15:16:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4669A3002E3; Thu, 28 Sep 2023 17:16:16 +0200 (CEST)
Date:   Thu, 28 Sep 2023 17:16:16 +0200
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
Subject: Re: [PATCH 1/1] sched/core: Fix stuck on completion for
 affine_move_task() when stopper disable
Message-ID: <20230928151616.GD27245@noisy.programming.kicks-ass.net>
References: <20230927033431.12406-1-kuyo.chang@mediatek.com>
 <20230927080850.GB21824@noisy.programming.kicks-ass.net>
 <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9def8f3d9426bc158b302f4474b6e643b46d206.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 03:57:35PM +0000, Kuyo Chang (張建文) wrote:
> On Wed, 2023-09-27 at 10:08 +0200, Peter Zijlstra wrote:
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Wed, Sep 27, 2023 at 11:34:28AM +0800, Kuyo Chang wrote:
> > > From: kuyo chang <kuyo.chang@mediatek.com>
> > > 
> > > [Syndrome] hung detect shows below warning msg
> > > [ 4320.666557] [   T56] khungtaskd: [name:hung_task&]INFO: task
> > stressapptest:17803 blocked for more than 3600 seconds.
> > > [ 4320.666589] [   T56] khungtaskd:
> > [name:core&]task:stressapptest   state:D stack:0     pid:17803
> > ppid:17579  flags:0x04000008
> > > [ 4320.666601] [   T56] khungtaskd: Call trace:
> > > [ 4320.666607] [   T56] khungtaskd:  __switch_to+0x17c/0x338
> > > [ 4320.666642] [   T56] khungtaskd:  __schedule+0x54c/0x8ec
> > > [ 4320.666651] [   T56] khungtaskd:  schedule+0x74/0xd4
> > > [ 4320.666656] [   T56] khungtaskd:  schedule_timeout+0x34/0x108
> > > [ 4320.666672] [   T56] khungtaskd:  do_wait_for_common+0xe0/0x154
> > > [ 4320.666678] [   T56] khungtaskd:  wait_for_completion+0x44/0x58
> > > [ 4320.666681] [   T56]
> > khungtaskd:  __set_cpus_allowed_ptr_locked+0x344/0x730
> > > [ 4320.666702] [   T56]
> > khungtaskd:  __sched_setaffinity+0x118/0x160
> > > [ 4320.666709] [   T56] khungtaskd:  sched_setaffinity+0x10c/0x248
> > > [ 4320.666715] [   T56]
> > khungtaskd:  __arm64_sys_sched_setaffinity+0x15c/0x1c0
> > > [ 4320.666719] [   T56] khungtaskd:  invoke_syscall+0x3c/0xf8
> > > [ 4320.666743] [   T56] khungtaskd:  el0_svc_common+0xb0/0xe8
> > > [ 4320.666749] [   T56] khungtaskd:  do_el0_svc+0x28/0xa8
> > > [ 4320.666755] [   T56] khungtaskd:  el0_svc+0x28/0x9c
> > > [ 4320.666761] [   T56] khungtaskd:  el0t_64_sync_handler+0x7c/0xe4
> > > [ 4320.666766] [   T56] khungtaskd:  el0t_64_sync+0x18c/0x190
> > > 
> > > [Analysis]
> > > 
> > > After add some debug footprint massage, this issue happened at
> > stopper
> > > disable case.
> > > It cannot exec migration_cpu_stop fun to complete migration.
> > > This will cause stuck on wait_for_completion.
> > 
> > How did you get in this situation?
> > 
> 
> This issue occurs at CPU hotplug/set_affinity stress test.
> The reproduce ratio is very low(about once a week).
> 
> So I add/record some debug message to snapshot the task status while it
> stuck on wait_for_completion.
> 
> Below is the snapshot status while issue happened:
> 
> cpu_active_mask is 0xFC
> new_mask is 0x8
> pending->arg.dest_cpu is 0x3
> task_on_cpu(rq,p) is 1
> task_cpu is 0x2
> p__state = TASK_RUNNING
> flag is SCA_CHACK|SCA_USER
> stop_one_cpu_nowait(stopper->enabled) return value is false.
> 
> I also record the footprint at migration_cpu_stop.
> It shows the migration_cpu_stop is not execute.

AFAICT this is migrate_enable(), which acts on current, so how can the
CPU that current runs on go away?

That is completely unexplained. You've not given a proper description of
the race scenario. And because you've not, we can't even begin to talk
about how best to address the issue.

> > struct task_struct *p, struct rq_flag
> > >  task_rq_unlock(rq, p, rf);
> > >  
> > >  if (!stop_pending) {
> > > -stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> > > -    &pending->arg, &pending->stop_work);
> > > +if (!stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> > > +    &pending->arg, &pending->stop_work))
> > > +return -ENOENT;
> > 
> > And -ENOENT is the right return code for when the target CPU is not
> > available?
> > 
> > I suspect you're missing more than halp the picture and this is a
> > band-aid solution at best. Please try harder.
> > 
> 
> I think -ENOENT means stopper is not execute? 
> Perhaps the error code is abused, or could you kindly give me some
> suggestions?

Well, at this point you're leaving the whole affine_move_task()
machinery in an undefined state, which is a much bigger problem than the
weird return value.

Please read through that function and its comments a number of times. If
you're not a little nervous, you've not understood the thing.

Your patch has at least one very obvious resource leak.

