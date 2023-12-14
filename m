Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D70812433
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442898AbjLNBAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjLNBAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:00:19 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE815D0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:00:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso13195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702515624; x=1703120424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRvHlx1ueVR+T8aCyBbEeE2myBl+/B4+7nsRvKK9Sw8=;
        b=RQae9X/sVJkMI7eRbOEF1ffBjM/jAbNYORaV1+sjaclEMPbKP9EEsHVSMcuKGinkdq
         Oh53687mUoUJF8lsPrGbMW12Th+VgnvAqsm9IlfBS6WJyJTRonezEi8Std/+r5f/Np5h
         s7Mf7R+/l4qUKia/q7KliYkUb0YZqN4ONwURwlbN4zEdQYT82uI+v76wz2Ob49bO9Hoh
         l9b8Kj3dReiBCkOym18neWBOmCcBmjOBl8AI1CCMzCnwdL43Seqiz63IC1RMEfUOW0ik
         37uDPG1ed3HsvQg/JyGy5Tw67niFX7doXD2KtbL8gJlC4+LL7hjozqewrmmhLLgev/0Y
         wdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515624; x=1703120424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRvHlx1ueVR+T8aCyBbEeE2myBl+/B4+7nsRvKK9Sw8=;
        b=grmPJ0JYdmlKfhnzNurC77DmYEyLsBtf5t5f0p3Cf/pMhFluAn5b2EgzXJKBK7kIbV
         oED/zs25LUOU75ApIjsERIw3qL0uaIEKLtqWMn8XvEAwiUAb6Hk+t2t796GPKy2MPIVI
         y1GhKLUz5e8zhj7nqPL8nS/VSbyf+rtk7CKO5fhBKqVHVKFQRuT/99m+SwWXSnJQiQC8
         ip3JiWAO1Z7PviunGKeFvnnvSobBP/JvZrGetnq55HVyYnLdyqpbD0eCLHye/m8nnkoV
         QC1KVXHjlu3N/untG9jbZPUVmlh2I+HZHAbCs9257/FgEe4fWLOn3wZt5By48aivK9uT
         wp0A==
X-Gm-Message-State: AOJu0YwXVtu7uza5+vY8K80idoMrHY4oTy5Hj1nWXlYXcB7uJtlyCQO+
        pHbD0rILIOs4vnFA0uOcDpqa+iPp8sB8TRN7atP8
X-Google-Smtp-Source: AGHT+IH/F8eTcPsm1iyL4QMRhSSiWZoS6H1D00qyCLiSvgzunuJ5k0OF+36lrB1ykgjLlJWhkRGJOA/JYmOswZDyH2k=
X-Received: by 2002:a05:600c:2941:b0:405:320a:44f9 with SMTP id
 n1-20020a05600c294100b00405320a44f9mr455079wmd.5.1702515624261; Wed, 13 Dec
 2023 17:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
In-Reply-To: <c6787831-f659-12cb-4954-fd13a05ed590@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 13 Dec 2023 17:00:12 -0800
Message-ID: <CANDhNCqZdCqvWzJScKRSb+bSTYjUM7Es2ms=REiDwG8ZU8z1Yg@mail.gmail.com>
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
        "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
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
> I too see this as the most notable regression. Some of the other
> benchmarks I've tested (schbench, tbench, netperf, ycsb-mongodb,
> DeathStarBench) show little to no difference when running with Proxy
> Execution, however sched-messaging sees a 10x blowup in the runtime.
> (taskset -c 0-7,128-125 perf bench sched messaging -p -t -l 100000 -g 1)
...
> The trend I see with hackbench is that the chain migration leads
> to a single runqueue being completely overloaded, followed by some
> amount of the idling on the entire CCX and a similar chain appearing
> on a different CPU. The trace for tip show a lot more CPUs being
> utilized.

So I reproduced a similar issue with the test (I only have 8 cores on
the bare metal box I have so I didn't bother using taskset):

perf bench sched messaging -p -t -l 100000 -g 1
v6.6:                   4.583s
proxy-exec-6.6:         28.842s
proxy-exec-WIP:         26.1033s

So the pre-v7 code does improve things, but not substantially.

Bisecting through the patch series to see how it regressed shows it is
not a single change:
mutex-handoff:          16.957s
blocked-waiter/return:  29.628s
ttwu return:            20.045s
blocked_donor:          25.021s

So it seems like the majority of the regression comes from switching
to mutex handoff instead of optimistic spinning.
This would account for your more cpus being utilized comment, as more
of the blocked tasks would be spinning trying to take the mutex.

Then adding the initial blocked-waiter/return migration change hurts
things further (and this was a known issue with v5/v6).
Then the pending patch to switch back to doing return migration in
ttwu recovers a chunk of that cost.
And then the blocked_donor handoff optimization (which passes the lock
back to the donor boosting us, rather than the next task in the mutex
waitlist) further impacts performance here.

The chain migration feature in proxy-exec-WIP doesn't seem to help or
hurt in this case.

I'll need to look closer at each of those steps to see if there's
anything too daft I'm doing.

The loss of optimistic spinning has been a long term worry with the
patch. Unfortunately as I mentioned in the plumbers talk, the idea
from OSPM on avoiding migration and spinning if the runnable owner of
a blocked_on chain was on a cpu isn't easy to accomplish, as we are
limited to how far off the rq we can look. I feel like I need to come
up with some way to lock the entire blocked_on chain so it can be
traversed safely - as it is now, due to the locking order
(task->pi_lock,  rq_lock,  mutex->wait_lock, task->blocked_on) we
can't stabily traverse go task->mutex->task->mutex, unless the tasks
are all on the same rq (and we're holding the rq_lock).  So we can
only safely look at one mutex owner off of the rq (when we also hold
the mutex wait_lock).

I'm stewing on an idea for some sort of mutex holder (similar to a
runqueue) that would allow the chain of mutexes to be traversed
quickly and stability - but the many-to-one blocked_on relationship
complicates it.
Suggestions or other ideas here would be welcome, as I didn't get a
chance to really discuss it much at plumbers.

thanks
-john
