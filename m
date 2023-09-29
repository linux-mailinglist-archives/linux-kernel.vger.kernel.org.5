Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61027B3825
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjI2Qym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjI2Qyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:54:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725B61AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:54:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae3d7eb7e0so403096866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696006477; x=1696611277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZF3Jl2cGsOksjrDR529LNInBfLdLbBBuGGlbMhw0e+0=;
        b=MKp7AgMdhRRsrrT+eLiJhbchlFbSoouZmYkz9q/gnmm26GtM7SPi+Yz4HQLxSzFV3a
         PgXoiGYNfio/PwcnRzp034R8CK4ykF264u3OJ9y5Gnc5eMTHSQLRrpVB7g5ZHU/vqyGX
         MGX7+Ycl4VETt+FX9q/MfxJrQk08g6/LyPQzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696006477; x=1696611277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZF3Jl2cGsOksjrDR529LNInBfLdLbBBuGGlbMhw0e+0=;
        b=scsp7gV/e89zr/LjKxtFNpT8zloFIrisLvjuuILlHPL3T6quO8IC50iL76/cEzl4T4
         HaaSI+teLHxR9lIw6D+N4gHNOob3hsmn74bUFA63ms45AJF0KEc+3tqoBB3iQdy+qJ+j
         lEAFWKcBxexm0tye+1TVWwq8m28GjHcCZGQqx/NoW715g41FUZrs0lCthadIDGtqPjm9
         NRREl4bd5NYa+ys4Mol+GOfwJAsa6XaNWibh5CHBES9RdNL7lEwi0TYzenjST79IbC0N
         SFrmk9cqbExhUvJDG7TJeSIGaBV3DvPgTnHAp/RtRqxx9UGeEXQWXE75RM6pXpkUd08r
         hDAQ==
X-Gm-Message-State: AOJu0YxuNu79B2ExoP9vLpo0E/0vrlRtZ6wEdrdyx/U9gMdB4wydV0t/
        yLplGkydmwZfahV0EDSUp+3UVLYrKF/UZxMudB+seg==
X-Google-Smtp-Source: AGHT+IFjb3rS2ES1J353hos9r/lXu1KizHPROpKr8M6Tr6u+011YQOMhGdH4AnM989+KB2HTKKd5iX9GeH7ZPC7CGEk=
X-Received: by 2002:a17:906:518c:b0:9a1:aea8:cb5a with SMTP id
 y12-20020a170906518c00b009a1aea8cb5amr4548236ejk.1.1696006476771; Fri, 29 Sep
 2023 09:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net>
In-Reply-To: <20230906131356.GG38741@noisy.programming.kicks-ass.net>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Fri, 29 Sep 2023 11:54:25 -0500
Message-ID: <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> EEVDF fundamentally supports per task request/slice sizes, which is the
> primary motivator for finally finishing these patches.
>
> So the plan is to extend sched_setattr() to allow tasks setting their
> own ideal slice length. But we're not quite there yet.
>
> Having just returned from PTO the mailbox is an utter trainwreck, but
> I'll try and refresh those few patches this week for consideration.
>
> In the meantime I think you found the right knob to twiddle.

Hello Peter,

I am trying to understand a little better the need for the eligibility
checks (entity_eligible). I understand the general concept, but I am
trying to find a scenario where it is necessary. And maybe propose to
have it toggled by a feature flag.

Some of my testing:

All my testing was done on a two core Celeron N400 cpu system 1.1Ghz.
It was done on the 6.5-rc3 kernel with EEVDF changes ported.

I have two CPU bound tasks one with a nice of -4 and the other with a
nice of 0. They are both affinitized to CPU 0. (while 1 { i++ })

With entity_eligible *enabled* and with entity_eligible *disabled*
(always returns 1):
Top showed consistent results, one at ~70% and the other at ~30%

So it seems the deadline adjustment will naturally achieve fairness.

I also added a few trace_printks to see if there is a case where
entity_eligible would have returned 0 before the deadline forced us to
reschedule. There were a few such cases. The following snippet of
prints shows that an entity became ineligible 2 slices before its
deadline expired. It seems like this will add more context switching
but still achieve a similar result at the end.

bprint:               pick_eevdf: eligibility check: tid=4568,
eligible=0, deadline=26577257249, vruntime=26575761118
bprint:               pick_eevdf: found best deadline: tid=4573,
deadline=26575451399, vruntime=26574838855
sched_switch:         prev_comm=loop prev_pid=4568 prev_prio=120
prev_state=R ==> next_comm=loop next_pid=4573 next_prio=116
bputs:                task_tick_fair: tick
bputs:                task_tick_fair: tick
bprint:               pick_eevdf: eligibility check: tid=4573,
eligible=1, deadline=26576270304, vruntime=26575657159
bprint:               pick_eevdf: found best deadline: tid=4573,
deadline=26576270304, vruntime=26575657159
bputs:                task_tick_fair: tick
bputs:                task_tick_fair: tick
bprint:               pick_eevdf: eligibility check: tid=4573,
eligible=0, deadline=26577089170, vruntime=26576476006
bprint:               pick_eevdf: found best deadline: tid=4573,
deadline=26577089170, vruntime=26576476006
bputs:                task_tick_fair: tick
bputs:                task_tick_fair: tick
bprint:               pick_eevdf: eligibility check: tid=4573,
eligible=0, deadline=26577908042, vruntime=26577294838
bprint:               pick_eevdf: found best deadline: tid=4568,
deadline=26577257249, vruntime=26575761118
sched_switch:         prev_comm=loop prev_pid=4573 prev_prio=116
prev_state=R ==> next_comm=loop next_pid=4568 next_prio=120

In a more practical example, I tried this with one of our benchmarks
that involves running Meet and Docs side by side and measuring the
input latency in the Docs document. The following is the average
latency for 5 runs:

(These numbers are after removing our cgroup hierarchy - that might be
a discussion for a later time).

CFS: 168ms
EEVDF with eligibility: 206ms (regression from CFS)
EEVDF *without* eligibility: 143ms (improvement to CFS)
EEVDF *without* eligibility and with a 6ms base_slice_ns (was 1.5ms):
104ms (great improvement)

Removing the eligibility check for this workload seemed to result in a
great improvement. I haven't dug deeper but I suspect it's related to
reduced context switches on our 2 core system.
As an extra test I also increased the base_slice_ns and it further
improved the input latency significantly.

I would love to hear your thoughts. Thanks!
