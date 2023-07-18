Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771DE757C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjGRMp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjGRMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:45:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438AB134
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:45:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso58821035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1689684323; x=1692276323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1r09zFzL3DdBWkTL26HjzBBO/TZuWfpjYf8w+kzaQb4=;
        b=5mmrpqcHkHulOpTGUKAJxIzDUeWsiREpjiQqNZndcuAJMzrCg3qjov9efhx8R+JDqC
         OMSSO0GFRgZPaq0bmuxhlGry71zzwhdZJ2CEPm1/Je4SDwy95LG5e/jnTVa1zejm95K6
         J4Hg9k0RhQ5FUl4FkS9C+798W84FDzwYuqduNa90Hcpt8IPAtKBoBEZ5FaFadlW7hEV5
         a4+TuvS9oY6/puOhBoIXcakKXc6haxW42Y6tu/FdI69umGtHj+p4rqr42iNtpfDaf3ud
         dxVKJXm4A+DmVsL/oVgnJSmJ1R37W6wXE1tIDsHZX8CjnAITX5nCbac2Q2wABU5Y5X2D
         PE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689684323; x=1692276323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1r09zFzL3DdBWkTL26HjzBBO/TZuWfpjYf8w+kzaQb4=;
        b=TFBCAXEQ7wqzIgSLHZX6NHuXbO0gJNVlb2bqM4DAZ630PX9QCzOYUlU8LdWZIPaKzq
         wU8ypjFbArvz+JPJxloSH2XZJY2InJS8KGGGJ9PT1TwbYIChlLmCOUebNF141m4fF/W/
         3+IzRSWH+cjMBYpXpGTUF29uGClvCnFQ/aHuY17ZhezVamKTMYGuGCw5BiVUlLcC/tMF
         z0bJPoFntoD1lX6U7Y1XtlRxYm9SSb4KD1/EFu4DpJDI8B0o3xhsX3/KyABMgbOsFaVT
         WikSwWglp2UKOeQ7KY591l+ovpFrD73EY0JeQ8PhE3nQrsmNa0oMvAVytVVZKkHn7TWL
         jwNQ==
X-Gm-Message-State: ABy/qLY8q/nQ8gdsS+sKoSr8lyGkkvI3HoDjY1aJ1GiZHYpsR6jlXrbR
        LEqCqfUvAliYGqgL5XtzwuDhcw==
X-Google-Smtp-Source: APBJJlEzjZgwvQT2ivJzetlMMoX3HVoFEzqtuLWEL/wNZfP6L9mKawcUrySXXNIOqOmfbj9wO8apdg==
X-Received: by 2002:a1c:7319:0:b0:3fb:d1db:5444 with SMTP id d25-20020a1c7319000000b003fbd1db5444mr2130175wmb.19.1689684322421;
        Tue, 18 Jul 2023 05:45:22 -0700 (PDT)
Received: from airbuntu ([104.132.45.110])
        by smtp.gmail.com with ESMTPSA id y20-20020a7bcd94000000b003fa96620b23sm10365909wmj.12.2023.07.18.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:45:19 -0700 (PDT)
Date:   Tue, 18 Jul 2023 13:45:17 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <20230718124517.3pvgvmesdh6eevqb@airbuntu>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
 <aa4a22b8-fc23-8c67-bdea-b6aac8f7e250@arm.com>
 <20230717182106.g6j3jpsjp35psl5y@airbuntu>
 <2bfa9dda-410f-5c8a-bff4-54a5ea308a93@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bfa9dda-410f-5c8a-bff4-54a5ea308a93@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/23 11:23, Lukasz Luba wrote:
> 
> 
> On 7/17/23 19:21, Qais Yousef wrote:
> > +CC Vincent and Peter
> > 
> > On 07/17/23 14:47, Lukasz Luba wrote:
> > > Hi Qais,
> > > 
> > > The rule is 'one size doesn't fit all', please see below.
> > > 
> > > On 7/11/23 18:58, Qais Yousef wrote:
> > > > Hi Kajetan
> > > > 
> > > > On 01/05/23 14:51, Kajetan Puchalski wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> > > > >    			     struct cpuidle_device *dev)
> > > > >    {
> > > > >    	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
> > > > > +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
> > > > >    	int i;
> > > > >    	memset(cpu_data, 0, sizeof(*cpu_data));
> > > > > +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > > > 
> > > > Given that utilization is invariant, why do we set the threshold based on
> > > > cpu capacity?
> > > 
> > > 
> > > To treat CPUs differently, not with the same policy.
> > > 
> > > 
> > > > 
> > > > I'm not sure if this is a problem, but on little cores this threshold would be
> > > > too low. Given that util is invariant - I wondered if we need to have a single
> > > > threshold for all type of CPUs instead. Have you tried something like that
> > > 
> > > A single threshold for all CPUs might be biased towards some CPUs. Let's
> > > pick the value 15 - which was tested to work really good in benchmarks
> > > for the big CPUs. On the other hand when you set that value to little
> > > CPUs, with max_capacity = 124, than you have 15/124 ~= 13% threshold.
> > > That means you prefer to enter deeper idle state ~9x times (at max
> > > freq). What if the Little's freq is set to e.g. < ~20% fmax, which
> > > corresponds to capacity < ~25? Let's try to simulate such scenario.
> > 
> > Hmm what I'm struggling with is that PELT is invariant. So the time it takes to
> > rise and decay to threshold of 15 should be the same for all CPUs, no?
> 
> Yes, but that's not an issue. The idea is to have a threshold value
> set to a level which corresponds to a long enough slip time (in
> wall-clock). Then you don't waste the energy for turning on/off the
> core too often.
> 
> > 
> > > 
> > > In a situation we could have utilization 14 on Little CPU, than CPU capacity
> > > (effectively frequency) voting based on utilization would be
> > > 1.2 * 14 = ~17 so let's pick OPP corresponding to 17 capacity.
> > > In such condition the little CPU would run the 14-util-periodic-task for
> > > 14/17= ~82% of wall-clock time. That's a lot, and not suited for
> > > entering deeper idle state on that CPU, isn't it?
> > 
> > Yes runtime is stretched. But we counter this at utilization level by making
> > PELT invariant. I thought that any CPU in the system will now take the same
> > amount of time to ramp-up and decay to the same util level. No?
> 
> The stretched runtime is what we want to derived out of rq util
> information, mostly after task migration to some next cpu.
> 
> > 
> > But maybe what you're saying is that we don't need to take the invariance into
> > account?
> 
> Invariance is OK, since is the common ground when we migrate those tasks
> across cores and we still can conclude based on util the sleeping
> cpu time.
> 
> > 
> > My concern (that is not backed by real problem yet) is that the threshold is
> > near 0, and since PELT is invariant, the time to gain few points is constant
> > irrespective of any CPU/capacity/freq and this means the little CPUs has to be
> > absolutely idle with no activity almost at all, IIUC.
> 
> As I said, that is good for those Little CPU in term of better latency
> for the tasks they serve and also doesn't harm the energy. The
> deeper idle state for those tiny silicon area cores (and low-power
> cells) doesn't bring much in avg for real workloads.
> This is the trade-off: you don't want to sacrifice the latency factor,
> you would rather pay a bit more energy not entering deep idle
> on Little cores, but get better latency there.

I can follow this argument much better than the time stretch one for sure.

I sort of agree, but feel cautious still this is too aggressive. I guess time
will let us know how suitable this is or we'll need to evolve :-)

FWIW, these patches are now in GKI, so we should get complaints if it is
a real problem.

> For the big cores, which occupy bigger silicon area and are made from
> High-Performance (HP) cells (and low V-threshold) leaking more, that
> trade-off is set differently. That's why a similar small util task on
> big core might be facing larger latency do to facing the need to
> wake-up cpu from deeper idle state.
> 
> > 
> > > 
> > > Apart from that, the little CPUs are tiny in terms of silicon area
> > > and are less leaky in WFI than big cores. Therefore, they don't need
> > > aggressive entries into deeper idle state. At the same time, they
> > > are often used for serving interrupts, where the latency is important
> > > factor.
> > 
> > On Pixel 6 this threshold will translate to util_threshold of 2. Which looks
> > too low to me. Can't TEO do a good job before we reach such extremely low level
> > of inactivity?
> 
> Kajetan has introduced a new trace event 'cpu_idle_miss' which was
> helping us to say how to set the trade-off in different thresholds.
> It appeared that we would rather prefer to miss-predict and be wrong
> about missing opportunity to enter deeper idle. The opposite was more
> harmful. You can enable that trace event on your platform and analyze
> your use cases.

Okay, thanks for the info.


Cheers

--
Qais Yousef
