Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41A2811E53
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjLMTLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbjLMTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:11:37 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C5999
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:11:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-55263acefc1so2230a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702494685; x=1703099485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHJ55Kk7aai+pHpHj+Xl232clUcmRT42WTr7UJtOMZM=;
        b=2mRdp/yx0K9H1b3efR21cfeQ3m2djl/tiOAqQi0UIYxUwpMpguHgHmvVlh8MgwfzSZ
         uvjMxbvdOS3JbZPOYXAfhBcE8Iew90tECnsMTy3WVOQuYkKbrldGHrBsqJEkw5VsJnJ8
         60UCu95wvoiAx7xDSrGAFJScTHJzVgAwvMMuE5UErjrLs9xc/h3oKOVOWwE6/nHTk12E
         hglcYoZQXuiog2VuVRNd31tODPxKJDPQ2IPDJgZI1/U9dZd36WNKSIaLCvJtIhFr210c
         Q6b+NQFX0R4QDVXzHl1GoOqYo7QUkcc/VQi4b0nr7jCGA3VLRgI74V76svGPAjh2K9s3
         RD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702494685; x=1703099485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHJ55Kk7aai+pHpHj+Xl232clUcmRT42WTr7UJtOMZM=;
        b=INVIWQApawvlkhYG84NR69h3PfE/+oKURf13SZfxhNfHdFu4kwRKSXMoY6KngruTpz
         WP6buMM/Jp/mpl01foetoqino2o7kXvygsr7cVgtuyObS545iZnVKKxMjQpalM/ZtIZc
         ZTT063CEDzY9ROqtsVaQNFJ7duKvoTkOukFaON6pwgVJcmZsuhNSmst3M92NRC7aETkI
         pDjO5ZY8OfZZIN/QxTAuajWtUsiMyynzni1ujAy9Sz2fT5Zt/1YkzGe7jIwSosb0mauj
         fiz4UET+EpZLn8997cBnM59mB2uZBxGWEOAm3o2HDH+FIc4iRzuqe/tFtcng3/MuccCQ
         Hvgg==
X-Gm-Message-State: AOJu0YxKEsLEy/Y1yZ1Lz4vqgX0X0ISuNj0T7Gk80ig4asE1+W9M+fDF
        7DxBty419SCms8tZJP5gbq3bR9WeFL0xwi1st/UR
X-Google-Smtp-Source: AGHT+IHmQnJXpBBQU4/69NV6VX6vNcyUI+kTuWm+Zt4MLjQLg1zAhUcCev0tT/Qrqw+2jW4AbT0W1/wdXb3GQ1OK7cA=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr533699edj.0.1702494684889; Wed, 13 Dec
 2023 11:11:24 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
In-Reply-To: <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 13 Dec 2023 11:11:12 -0800
Message-ID: <CANDhNCqcviNOZTi2G9R21K-p32uM0U_LLiiEBjveJ4gikk8wrQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qyousef@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        Youssef Esmat <youssefesmat@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com,
        Metin Kaya <Metin.Kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 10:37=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello John,
>
> I may have some data that might help you debug a potential performance
> issue mentioned below.

Hey Prateek,
  Thank you so much for taking the time to try this out and providing
such helpful analysis!
More below.

> On 11/7/2023 1:04 AM, John Stultz wrote:
> > [..snip..]
> >
> > Performance:
> > =E2=80=94----------
> > This patch series switches mutexes to use handoff mode rather
> > than optimistic spinning. This is a potential concern where locks
> > are under high contention. However, earlier performance analysis
> > (on both x86 and mobile devices) did not see major regressions.
> > That said, Chenyu did report a regression[3], which I=E2=80=99ll need t=
o
> > look further into.
>
> I too see this as the most notable regression. Some of the other
> benchmarks I've tested (schbench, tbench, netperf, ycsb-mongodb,
> DeathStarBench) show little to no difference when running with Proxy

This is great to hear! Thank you for providing this input!

> Execution, however sched-messaging sees a 10x blowup in the runtime.
> (taskset -c 0-7,128-125 perf bench sched messaging -p -t -l 100000 -g 1)

Oof. I appreciate you sharing this!

> While investigating, I drew up the runqueue length when running
> sched-messaging pinned to 1CCX (CPUs 0-7,128-125 on my 3rd Generation
> EPYC system) using the following bpftrace script that dumps it csv
> format:

Just so I'm following you properly on the processor you're using, cpus
0-7 and 128-125 are in the same CCX?
(I thought there were only 8 cores per CCX?)

> rqlen.bt
> ---
<snip>
> --
>
> I've attached the csv for tip (rqlen50-tip-pinned.csv) and proxy
> execution (rqlen50-pe-pinned.csv) below.
>
> The trend I see with hackbench is that the chain migration leads
> to a single runqueue being completely overloaded, followed by some
> amount of the idling on the entire CCX and a similar chain appearing
> on a different CPU. The trace for tip show a lot more CPUs being
> utilized.
>
> Mathieu has been looking at hackbench and the effect of task migration
> on the runtime and it appears that lowering the migrations improves
> the hackbench performance significantly [1][2][3]
>
> [1] https://lore.kernel.org/lkml/20230905072141.GA253439@ziqianlu-dell/
> [2] https://lore.kernel.org/lkml/20230905171105.1005672-1-mathieu.desnoye=
rs@efficios.com/
> [3] https://lore.kernel.org/lkml/20231019160523.1582101-1-mathieu.desnoye=
rs@efficios.com/
>
> Since migration itself is not cheap, I believe the chain migration at
> the current scale hampers the performance since sched-messaging
> emulates a worst-case scenario for proxy-execution.

Hrm.

> I'll update the thread once I have more information. I'll continue
> testing and take a closer look at the implementation.
>
> > I also briefly re-tested with this v5 series
> > and saw some average latencies grow vs v4, suggesting the changes
> > to return-migration (and extra locking) have some impact. With v6
> > the extra overhead is reduced but still not as nice as v4. I=E2=80=99ll
> > be digging more there, but my priority is still stability over
> > speed at this point (it=E2=80=99s easier to validate correctness of
> > optimizations if the baseline isn=E2=80=99t crashing).
> >
> >
> > If folks find it easier to test/tinker with, this patch series
> > can also be found here:
> >   https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.=
6
> >   https://github.com/johnstultz-work/linux-dev.git proxy-exec-v6-6.6
>
> P.S. I was using the above tree.

Ok, I've been working on getting v7 ready which includes two main things:
1) I've reworked the return migration back into the ttwu path to avoid
the lock juggling
2) Working to properly conditionalize and re-add Connor's
chain-migration feature (which when a migration happens pulls the full
blocked_donor list with it)

So I'll try to reproduce your results and see if these help any with
this particular case, and then I'll start to look closer at what can
be done.

Again, thanks so much, I've got so much gratitude for your testing and
analysis here. I really appreciate your feedback!
Do let me know if you find anything further!

thanks
-john
