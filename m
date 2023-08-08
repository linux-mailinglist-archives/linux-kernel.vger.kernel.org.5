Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DA7747D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjHHTUd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Aug 2023 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjHHTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:20:08 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D1445F41;
        Tue,  8 Aug 2023 09:44:16 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3a751bd3372so678596b6e.0;
        Tue, 08 Aug 2023 09:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513038; x=1692117838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7fJlZqm7SkL8DNK44l2eawprG/x5eTjs6OofI30rbg=;
        b=Sn2q+VtCrP+bW3KNjMoMmt4G2r6bBaDP4NWL40tZNZxjNVt7Sy4WkGtwpp6fnE3ErH
         RYdOSJdTjlDJe5FbBGjx0/SQIVYxXdDRczcK6BW2LQ1qP4drey/saQ9If/4G5Q1McXL7
         mB2E5y/8j7O7BwEzJC7CLFhZ73oHjbgb2RIC1eMBHUfil+rNVxSLensVTcqIBGRYxT94
         FnonEgRSPN34BlpVO2PQyhpHpAYb0UlTVoU96jjDAx++dbITSnd7c+eVpu1sloPlhtWa
         KRBSJSR8IgXHBCvoa2zyt0lF1aNZQsRWStzc7SzZ5I8iVN92oMOuRBKB5Z9h5vkLe9qf
         2/tg==
X-Gm-Message-State: AOJu0YyGTzvkYJz/ET1R6+3uL0JQMiPC2dKQWozn08r38Ej0EH9+W3ta
        SU5SyzBw1jXDgNcoXOsBvpve9yLzV/bpI0XtYsNkV0jF
X-Google-Smtp-Source: AGHT+IFP2RLwXNB86i9yjvF4iWGgJA1+zfLkLjE3JrAyQhuMst/saVIe9OyEzX/Ag/dc4w4ADX/Vo+2RYmxh/hifuMc=
X-Received: by 2002:a05:6808:150a:b0:394:25b9:db19 with SMTP id
 u10-20020a056808150a00b0039425b9db19mr296085oiw.2.1691513038157; Tue, 08 Aug
 2023 09:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
 <002201d9ca0c$27606f70$76214e50$@telus.net>
In-Reply-To: <002201d9ca0c$27606f70$76214e50$@telus.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Aug 2023 18:43:45 +0200
Message-ID: <CAJZ5v0gYsH9EKgCO_LESuvd0dcOJLgPrWeN=6V-bY4gq-w1oyA@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers
 unconditionally every time
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 5:22 PM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2023.08.03 14:33 Rafael wrote:
> > On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>
> >> Hi Folks,
> >>
> >> This is the second iteration of:
> >>
> >> https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> >>
> >> with an additional patch.
> >>
> >> There are some small modifications of patch [1/3] and the new
> >> patch causes governor statistics to play a role in deciding whether
> >> or not to stop the scheduler tick.
> >>
> >> Testing would be much appreciated!
> >
> > For convenience, this series is now available in the following git branch:
> >
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> > pm-cpuidle-teo
>
> Hi Rafael,
>
> Thank you for the git branch link.
>
> I did some testing:
>
> Disclaimer: I used areas of focus derived
> from the original teo-util work last fall,
> and did not check if they were still the best
> places to look for issues.
>
> CPU: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
> HWP: enabled
> CPU frequency scaling driver: intel_pstate
> CPU frequency scaling governor: performance
> Kernel 1: 6.5-rc4 (1000 Hz tick rate)
> Kernel 2: kernel 1 + this patch series (called "rjw")
> System is extremely idle, other than the test work.
>
> All tests were done with all idle governors:
> menu, teo, ladder, rjw.
>
> Test 1: 2 core ping pong sweep:
>
> Pass a token between 2 CPUs on 2 different cores.
> Do a variable amount of work at each stop.
>
> Purpose: To utilize the shallowest idle states
> and observe the transition from using more of 1
> idle state to another.
>
> Results:
>
> teo and rjw track fairly well, with
> rjw reducing its use of idle state 0 before
> teo as the work packet increases. The menu governor
> does best overall, but performs worse over a greater
> range of token loop times.
>
> Details (power and idle stats; times):
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/2-1/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/2-1/2-core-ping-pong-sweep.png
>
> Test 2: 6 core ping pong sweep:
>
> Pass a token between 6 CPUs on 6 different cores.
> Do a variable amount of work at each stop.
>
> Purpose: To utilize the midrange idle states
> and observe the transitions from between use of
> idle states.
>
> Results: There is some instability in the results
> in the early stages.
> For unknown reasons, the rjw governor sometimes works
> slower and at lower power. The condition is not 100%
> repeatable.
>
> Overall teo completed the test fastest (54.9 minutes)
> Followed by menu (56.2 minutes), then rjw (56.7 minutes),
> then ladder (58.4 minutes). teo is faster throughout the
> latter stages of the test, but at the cost of more power.
> The differences seem to be in the transition from idle
> state 1 to idle state 2 usage.
>
> Details (power and idle stats; times):
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping-pong-sweep.png
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping-pong-sweep-detail-a.png
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping-pong-sweep-detail-b.png
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-2/6-core-ping-pong-sweep-diffs.png
>
> a re-run power and idle stats, showing inconsistent behaviour.
> teo and rjw only, and no timing data:
> http://smythies.com/~doug/linux/idle/teo-util2/ping-sweep/6-1/perf/
>
> Test 3: sleeping ebizzy - 128 threads.
>
> Purpose: This test has given interesting results in the past.
> The test varies the sleep interval between record lookups.
> The result is varying usage of idle states.
>
> Results: It can be difficult to see any differences in
> the overall timing graph, but a graph of differences
> is revealing. teo outperforms rjw in the longer intervals
> region of the test, at the cost of more power.
>
> Details: (power and idle stats; times):
> http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/ebizzy-128-perf.png
> http://smythies.com/~doug/linux/idle/teo-util2/ebizzy/ebizzy-128-perf-diffs.png
>
> Test 4: 2 X 2 pair token passing. Dwell test. Fast:
>
> Purpose: Dwell under one set of conditions. Observe
> noise and/or any bi-stability.
>
> Results (reference time is menu):
> rjw: 3.0723 usecs/loop average. +3.15%
> teo: 2.9917 usecs/loop average. +0.44%
> menu: 2.97845 usecs/loop average. Reference
> ladder: 4.077375 usecs/loop average. +36.9%
>
> Powers are all similar, with ladder a bit lower.
>
> Details: (power and idle stats; times):
> http://smythies.com/~doug/linux/idle/teo-util2/many-0-400000000-2/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/many-0-400000000-2/times.txt
>
> Test 5: 2 X 2 pair token passing. Dwell test. Medium:
>
> Purpose: Dwell under one set of conditions. Observe
> noise and/or any bi-stability.
>
> Results (reference time is menu):
> rjw: 11.3406 usecs/loop average. -0.69%
> teo: 11.36765 usecs/loop average. -0.45%
> menu: 11.41905 usecs/loop average. reference
> ladder: 11.9535 usecs/loop average. +4.68%
>
> Powers are all similar.
>
> Details:
> http://smythies.com/~doug/linux/idle/teo-util2/many-3000-100000000-2/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/many-3000-100000000-2/times.txt
>
> Test 6: 2 X 2 pair token passing. Dwell test. Slow:
>
> Purpose: Dwell under one set of conditions. Observe
> noise and/or any bi-stability.
>
> Results (reference time is menu):
> rjw: 2591.70 usecs/loop average. +0.26%
> teo: 2566.34 usecs/loop average. -0.72%
> menu: 2585.00 usecs/loop average. reference
> ladder: 2635.36 usecs/loop average. +1.95%
>
> Powers are all similar, with ladder a bit lower.
> Due to the strong temperature to power use curve,
> a much longer dwell test would need to be run to
> be sure to get to steady state power usage.
>
> Details:
> http://smythies.com/~doug/linux/idle/teo-util2/many-1000000-342000-2/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/many-1000000-342000-2/times.txt
>
> Test 7: 500 low load threads.
>
> Purpose: This test has given interesting results
> in the past.
>
> 500 threads at approximately 10 hertz work/sleep frequency
> and about 0.0163 load per thread, 8.15 total.
> CPUs about 32% idle.
>
> Results:
> rjw executed 0.01% faster than teo.
> rjw used 5% less energy than teo.
>
> Details:
> http://smythies.com/~doug/linux/idle/teo-util2/waiter/perf/
> http://smythies.com/~doug/linux/idle/teo-util2/waiter/times.txt

Thanks a lot for doing this work, much appreciated!

> Conclusions: Overall, I am not seeing a compelling reason to
> proceed with this patch set.

On the other hand, if there is a separate compelling reason to do
that, it doesn't appear to lead to a major regression.
