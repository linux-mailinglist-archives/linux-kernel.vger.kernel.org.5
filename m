Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A4F7B5734
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbjJBPzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjJBPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:24 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC9CB3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:55:20 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3232bb059d3so2135650f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696262119; x=1696866919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGfD3EsOhCPHxJ4Rl3lYuOaMap+K2ZL+vWFDt8KFJ28=;
        b=HHfAnIUhzV8vLOEnnGLGmbBnmM56lb/EB86DscWHT3qrwiCd2mqD0m2AVEISlqzfkl
         MCJ8ZR6iuNlBi7uFFFRjk7j1ijYrEK4AJ8Emwur8seJzrMvADUijpxQjgehBLvwfUIvJ
         f1SpKjKZYnX7SVbRIssWybQhH6nrkHUFZbRas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262119; x=1696866919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGfD3EsOhCPHxJ4Rl3lYuOaMap+K2ZL+vWFDt8KFJ28=;
        b=oXb6n558aqee66LMrhNs8+Bkr+5kvkIu8yGW2pItZnxsLnodZssOLdp3nPgh5rOuUF
         RnwXS2jGjPZRKsykBva4jYVf5z9hK+Abmj2g9mv9oKyxZ6HLx5JIfZ09REhbk7FsmDLo
         7zMiDRw/Zws7Xw3vR6WBxXbrqiexQv51O4jrQ7EVjFkqPTYbW7HUfi2Qc+vNuPyxpeku
         Smdx19IvoWLLePx8Du9aCdb/RdhZ2/mcb0vYT0f2ZaOqLHXWrlHUEOOWuUsJ/XokFBh/
         I3xvqNyoikYo62ufnrxhC/WGJ4zXyjKcG4/3vL2nLcyflkRZO72ZGyoE3EzFVNLUcDCj
         X5Tw==
X-Gm-Message-State: AOJu0YxYIO8lslmC7gq1UuNoPvYlGWBN5KGjWcV0ZUKt/94cbJ3xqngc
        WWSXRWohUKEy/bP2VPdq3wX6XXN0RaDSmhTt+EWkBA==
X-Google-Smtp-Source: AGHT+IHxVFEDqLp2sUZQjW2AQmELQ/eh6iYKQ7ldxQBCmd6NGUn/kM5q5RUBB4Hz/p3glHqhjeS5tpaZ3wMJJxPtLZ8=
X-Received: by 2002:a5d:5385:0:b0:323:2df9:618f with SMTP id
 d5-20020a5d5385000000b003232df9618fmr8974432wrv.0.1696262118565; Mon, 02 Oct
 2023 08:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net> <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
In-Reply-To: <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Mon, 2 Oct 2023 10:55:07 -0500
Message-ID: <CA+q576PvB2-rCMeC6SiONLz4s+9JeAwMtq0vK=SQnR+WicQtew@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:54=E2=80=AFAM Youssef Esmat
<youssefesmat@chromium.org> wrote:
>
> >
> > EEVDF fundamentally supports per task request/slice sizes, which is the
> > primary motivator for finally finishing these patches.
> >
> > So the plan is to extend sched_setattr() to allow tasks setting their
> > own ideal slice length. But we're not quite there yet.
> >
> > Having just returned from PTO the mailbox is an utter trainwreck, but
> > I'll try and refresh those few patches this week for consideration.
> >
> > In the meantime I think you found the right knob to twiddle.
>
> Hello Peter,
>
> I am trying to understand a little better the need for the eligibility
> checks (entity_eligible). I understand the general concept, but I am
> trying to find a scenario where it is necessary. And maybe propose to
> have it toggled by a feature flag.
>
> Some of my testing:
>
> All my testing was done on a two core Celeron N400 cpu system 1.1Ghz.
> It was done on the 6.5-rc3 kernel with EEVDF changes ported.
>
> I have two CPU bound tasks one with a nice of -4 and the other with a
> nice of 0. They are both affinitized to CPU 0. (while 1 { i++ })
>
> With entity_eligible *enabled* and with entity_eligible *disabled*
> (always returns 1):
> Top showed consistent results, one at ~70% and the other at ~30%
>
> So it seems the deadline adjustment will naturally achieve fairness.
>
> I also added a few trace_printks to see if there is a case where
> entity_eligible would have returned 0 before the deadline forced us to
> reschedule. There were a few such cases. The following snippet of
> prints shows that an entity became ineligible 2 slices before its
> deadline expired. It seems like this will add more context switching
> but still achieve a similar result at the end.
>
> bprint:               pick_eevdf: eligibility check: tid=3D4568,
> eligible=3D0, deadline=3D26577257249, vruntime=3D26575761118
> bprint:               pick_eevdf: found best deadline: tid=3D4573,
> deadline=3D26575451399, vruntime=3D26574838855
> sched_switch:         prev_comm=3Dloop prev_pid=3D4568 prev_prio=3D120
> prev_state=3DR =3D=3D> next_comm=3Dloop next_pid=3D4573 next_prio=3D116
> bputs:                task_tick_fair: tick
> bputs:                task_tick_fair: tick
> bprint:               pick_eevdf: eligibility check: tid=3D4573,
> eligible=3D1, deadline=3D26576270304, vruntime=3D26575657159
> bprint:               pick_eevdf: found best deadline: tid=3D4573,
> deadline=3D26576270304, vruntime=3D26575657159
> bputs:                task_tick_fair: tick
> bputs:                task_tick_fair: tick
> bprint:               pick_eevdf: eligibility check: tid=3D4573,
> eligible=3D0, deadline=3D26577089170, vruntime=3D26576476006
> bprint:               pick_eevdf: found best deadline: tid=3D4573,
> deadline=3D26577089170, vruntime=3D26576476006
> bputs:                task_tick_fair: tick
> bputs:                task_tick_fair: tick
> bprint:               pick_eevdf: eligibility check: tid=3D4573,
> eligible=3D0, deadline=3D26577908042, vruntime=3D26577294838
> bprint:               pick_eevdf: found best deadline: tid=3D4568,
> deadline=3D26577257249, vruntime=3D26575761118
> sched_switch:         prev_comm=3Dloop prev_pid=3D4573 prev_prio=3D116
> prev_state=3DR =3D=3D> next_comm=3Dloop next_pid=3D4568 next_prio=3D120
>
> In a more practical example, I tried this with one of our benchmarks
> that involves running Meet and Docs side by side and measuring the
> input latency in the Docs document. The following is the average
> latency for 5 runs:
>
> (These numbers are after removing our cgroup hierarchy - that might be
> a discussion for a later time).
>
> CFS: 168ms
> EEVDF with eligibility: 206ms (regression from CFS)
> EEVDF *without* eligibility: 143ms (improvement to CFS)
> EEVDF *without* eligibility and with a 6ms base_slice_ns (was 1.5ms):
> 104ms (great improvement)
>
> Removing the eligibility check for this workload seemed to result in a
> great improvement. I haven't dug deeper but I suspect it's related to
> reduced context switches on our 2 core system.
> As an extra test I also increased the base_slice_ns and it further
> improved the input latency significantly.
>
> I would love to hear your thoughts. Thanks!

For completeness I ran two more tests:

1. EEVDF with eligibility and 6ms base_slice_ns.
2. EEVDF with eligibility with Benjamin Segall's patch
(https://lore.kernel.org/all/xm261qego72d.fsf_-_@google.com/).

I copied over all the previous results for easier comparison.

CFS:                                          168ms
EEVDF, eligib, 1.5ms slice:        206ms
EEVDF, eligib, 6ms slice:           167ms
EEVDF_Fix, eligib, 1.5ms slice: 190ms
EEVDF, *no*eligib, 1.5ms slice: 143ms
EEVDF, *no*eligib, 6ms slice:    104ms

It does seem like Benjamin's fix did have an improvement.
