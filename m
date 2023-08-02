Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176D076CC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjHBMUn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 08:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjHBMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:20:41 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C28326AF;
        Wed,  2 Aug 2023 05:20:40 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1bb3df62b34so881086fac.0;
        Wed, 02 Aug 2023 05:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690978839; x=1691583639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VORnzW/QpwQXhPl9SE+Jx3veoxk4wpWoU9SWAgDYUEU=;
        b=j1ROu5LZycWtabVbFHtue6htCqQB5Y80wqn/LwGuOYkf/xR5TCyEOrmvO2EGllQaol
         29JUr1+tEQASDCwR1zQgAZS6/qacSxGWCracLk4ZdUQd9q9eu/yY+a3tBS3G16ii+Plm
         CrRxt5ebFoGRv5O+U5DWcjNNochsIIa6wwyPz5i5qJFo9dDh41Be5P/MZULYaSH5KosM
         9DeNJ/k3bSi4lNeG5U7tlq7MDXXK1443l0lE+zVM71/OfS249bGZLdESG2V4mQ9hfTpQ
         IVPizB0FVs9Gu0OyTg2poRQIEanH4tPiirVRzqVNeQ+ER/B5Sxd37My78l+BjtBPo0In
         ryFg==
X-Gm-Message-State: ABy/qLZhqzAhe7yXAMbJlnA2PcMt0H3da98QCuinpDkVzOlHBWvz0g9b
        QtAIN/vvQVNIzmdDuvRWYLiGjMSMeOx0MsO05+AdpYfo
X-Google-Smtp-Source: APBJJlGIcF4+HcMFuhetkl9UJwu6PjHO5Gs8MUcoQCh/U2SusCOe1NGS0JTdoXb3NI8DtessbXrRcKRYK2LvnKFu7jY=
X-Received: by 2002:a05:6870:d793:b0:1b3:afdc:6c08 with SMTP id
 bd19-20020a056870d79300b001b3afdc6c08mr11960946oab.0.1690978839408; Wed, 02
 Aug 2023 05:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <4515817.LvFx2qVVIh@kreacher> <ZMl+yH42Ir0AZzoX@e126311.manchester.arm.com>
In-Reply-To: <ZMl+yH42Ir0AZzoX@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Aug 2023 14:20:27 +0200
Message-ID: <CAJZ5v0grLBbRNJHq=_OvC3HqE3BEy=BOwgde_gPk2qyUOWKuZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] cpuidle: teo: Avoid stopping scheduler tick too often
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 11:53 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi Rafael,
>
> > Hi Folks,
> >
> > Patch [1/3] in this series is a v3 of this patch posted last week:
> >
> > https://lore.kernel.org/linux-pm/4506480.LvFx2qVVIh@kreacher/
> >
> > Patch [2/3] (this is the second version of it) addresses some bail out paths
> > in teo_select() in which the scheduler tick may be stopped unnecessarily too.
> >
> > Patch [3/3] replaces a structure field with a local variable (while at it)
> > and it is the same as its previous version.
> >
> > According to this message:
> >
> > https://lore.kernel.org/linux-pm/CAJZ5v0jJxHj65r2HXBTd3wfbZtsg=_StzwO1kA5STDnaPe_dWA@mail.gmail.com/
> >
> > this series significantly reduces the number of cases in which the governor
> > requests stopping the tick when the selected idle state is shallow, which is
> > incorrect.
> >
> > Thanks!
> >
> >
>
> I did some initial testing with this on Android (Pixel 6, Android 13).
>
> 1. Geekbench 6
>
> +---------------------------+---------------+-----------------+
> |          metric           |      teo      |     teo_tick    |
> +---------------------------+---------------+-----------------+
> |      multicore_score      | 3320.9 (0.0%) | 3303.3 (-0.53%) |
> |           score           | 1415.7 (0.0%) | 1417.7 (0.14%)  |
> |      CPU_total_power      | 2421.3 (0.0%) | 2429.3 (0.33%)  |
> |  latency (AsyncTask #1)   | 49.41μ (0.0%) | 51.07μ (3.36%)  |
> | latency (labs.geekbench6) | 65.63μ (0.0%) | 77.47μ (18.03%) |
> | latency (surfaceflinger)  | 39.46μ (0.0%) | 36.94μ (-6.39%) |
> +---------------------------+---------------+-----------------+
>
> So the big picture for this workload looks roughly the same, the
> differences are too small for me to be confident in saying that the
> score/power difference is the result of the patches and not something
> random in the system.
> Same with the latency, the difference for labs.gb6 stands out but that's
> a pretty irrelevant task that sets up the benchmark, not the benchmark
> itself so not the biggest deal I think.
>
> +---------------+---------+------------+--------+
> |     kernel    | cluster | idle_state |  time  |
> +---------------+---------+------------+--------+
> |      teo      | little  |    0.0     | 146.75 |
> |      teo      | little  |    1.0     | 53.75  |
> |    teo_tick   | little  |    0.0     |  63.5  |
> |    teo_tick   | little  |    1.0     | 146.78 |
> +---------------+---------+------------+--------+
>
> +---------------+-------------+------------+
> |     kernel    |    type     | count_perc |
> +---------------+-------------+------------+
> |   teo         |  too deep   |   2.034    |
> |   teo         | too shallow |   15.791   |
> |   teo_tick    |  too deep   |    2.16    |
> |   teo_tick    | too shallow |   20.881   |
> +---------------+-------------+------------+
>
> The difference shows up in the idle numbers themselves, looks like we
> get a big shift towards deeper idle on our efficiency cores (little
> cluster) and more missed wakeups overall, both too deep & too shallow.
>
> Notably, the percentage of too shallow sleeps on the performance cores has
> more or less doubled (2% + 0.8% -> 4.3% + 1.8%). This doesn't
> necessarily have to be an issue but I'll do more testing just in case.
>
> 2. JetNews (Light UI workload)
>
> +------------------+---------------+----------------+
> |      metric      |      teo      |    teo_tick    |
> +------------------+---------------+----------------+
> |       fps        |  86.2 (0.0%)  |  86.4 (0.16%)  |
> |     janks_pc     |  0.8 (0.0%)   |  0.8 (-0.00%)  |
> | CPU_total_power  | 185.2 (0.0%)  | 178.2 (-3.76%) |
> +------------------+---------------+----------------+
>
> For the UI side, the frame data comes out the same on both variants but
> alongside better power usage which is nice to have.
>
> +---------------+---------+------------+-------+
> |    kernel     | cluster | idle_state | time  |
> +---------------+---------+------------+-------+
> |      teo      | little  |    0.0     | 25.06 |
> |      teo      | little  |    1.0     | 12.21 |
> |      teo      |   mid   |    0.0     | 38.32 |
> |      teo      |   mid   |    1.0     | 17.82 |
> |      teo      |   big   |    0.0     | 30.45 |
> |      teo      |   big   |    1.0     | 38.5  |
> |    teo_tick   | little  |    0.0     | 23.18 |
> |    teo_tick   | little  |    1.0     | 14.21 |
> |    teo_tick   |   mid   |    0.0     | 36.31 |
> |    teo_tick   |   mid   |    1.0     | 19.88 |
> |    teo_tick   |   big   |    0.0     | 27.13 |
> |    teo_tick   |   big   |    1.0     | 42.09 |
> +---------------+---------+------------+-------+
>
> +---------------+-------------+------------+
> |    kernel     |    type     | count_perc |
> +---------------+-------------+------------+
> |      teo      |  too deep   |   0.992    |
> |      teo      | too shallow |   17.085   |
> |   teo_tick    |  too deep   |   0.945    |
> |   teo_tick    | too shallow |   15.236   |
> +---------------+-------------+------------+
>
> For the idle stuff here all 3 clusters shift a bit towards deeper idle
> but the overall miss rate is lower across the board which is perfectly
> fine.
>
> TLDR:
> Mostly no change for a busy workload, no change + better power for a UI
> one. The patches make sense to me & the results look all right so no big
> problems at this stage. I'll do more testing (including the RFC you sent
> out a moment ago) over the next few days and send those out as well.
>
> Short of bumping into any other problems along the way, feel free to
> grab this if you'd like:
> Reviewed-and-tested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>

Thank you!
