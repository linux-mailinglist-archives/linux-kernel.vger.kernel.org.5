Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9247F52EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbjKVWB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjKVWB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:01:26 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FCE1B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:01:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839652b97so1325165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1700690480; x=1701295280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Co9LVBS9UVls7Yfkp1g/G/0zm2miePVKqu+VmR9GULg=;
        b=CUUhkC3aCNRMDb7cJsp1Oyp8W6ggrDS9JgXsHVHKqv+tKKoOTr8pcHEK8//WWQUhrU
         /YVjA70bMuYOW30W9zyOc+nXyCwfiIF8New3QYQz6Ge3DhwEe4c+kMxFQNks1ip7SAz4
         zRW3rJRKomcseyprsbdRPDE/0bCDSX5am7pztquxlUMPjqLTor0OC7Uc+t6ZsbUbz2wL
         giV44mkKIaHH9Il5jSLgAni47wYvwJuXIBba4eAGl8rmidmvszjuBiMdKZpiuSfP5PNs
         ymoOO3Il3fZ9WvxZ9uITDn4+IRUq4x/zMu2yJHKlHy1U/NVA9XcZWO3DPAOmPMY5AU2+
         iGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700690480; x=1701295280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co9LVBS9UVls7Yfkp1g/G/0zm2miePVKqu+VmR9GULg=;
        b=lkMpAIN5xHOtQG1Aen5XIPBWM4NUJ0K03HmSHxgXqfay+z0ZY3SKH/PFmxrEgefhfM
         XzrZsFCnwKt6UbmdsJhVDNnDMN59ilJ53n/yiwvAwAe5H4s/oF86DDbNcfEBdI12jGx+
         NuxS/1y3JUvYqakG37QASTE/c46xHqffWKeRuf+269C+A87dcSpNXYXsnwTWDpsJPDSw
         FH2xGNcPeDEJsQV3wCYpuGS7nniMUJv8+0lEt38GXUnTcJB3v7CfS5BYGX4822sz/tp0
         t7SUrVnbXsT10VljzK+NiZ8+T2GfCfv0wwpjLI9tlTdDBBRj/KWP4hq+DXQx/UBfX3L1
         blYg==
X-Gm-Message-State: AOJu0Yy7ZG7Jk3zMaOQjY9PlqWdo8sSPURkwN2akjxhGWdIjqJlzcdVC
        A4tjt8Ys+oqIsSDloW0b9vSdHw==
X-Google-Smtp-Source: AGHT+IH4rB5Gnc+aWlXBbdw4olewehGSvln615Pk9fVGk663855Rnwjbt7cGY19KNvWtTEqtko92WA==
X-Received: by 2002:a05:600c:4514:b0:409:787b:5ab5 with SMTP id t20-20020a05600c451400b00409787b5ab5mr2834278wmo.23.1700690480328;
        Wed, 22 Nov 2023 14:01:20 -0800 (PST)
Received: from airbuntu (host109-151-228-202.range109-151.btcentralplus.com. [109.151.228.202])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c19cb00b0040a507f546fsm709634wmq.8.2023.11.22.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 14:01:19 -0800 (PST)
Date:   Tue, 21 Nov 2023 21:17:25 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, wyes.karny@amd.com, beata.michalska@arm.com
Subject: Re: [PATCH v3 1/2] sched/schedutil: Rework performance estimation
Message-ID: <20231121211725.gaekv6svnqdiq5l4@airbuntu>
References: <20231103131821.1176294-1-vincent.guittot@linaro.org>
 <20231103131821.1176294-2-vincent.guittot@linaro.org>
 <20231114205422.k5m6y4m5vnw7dvzj@airbuntu>
 <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtDMEes6V2xRHavAwWrVuiZBdFAsaaxv9=-psAZCTPQWKg@mail.gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/23 08:38, Vincent Guittot wrote:

> > > +unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
> > > +                              unsigned long min,
> > > +                              unsigned long max)
> > > +{
> > > +     struct rq *rq = cpu_rq(cpu);
> > > +
> > > +     if (rt_rq_is_runnable(&rq->rt))
> > > +             return max;
> >
> > I think this breaks old behavior. When uclamp_is_used() the frequency of the RT
> > task is determined by uclamp_min; but you revert this to the old behavior where
> > we always return max, no? You should check for !uclamp_is_used(); otherwise let
> > the rest of the function exec as usual.
> 
> Yes, I made a shortcut assuming that max would be adjusted to the max
> allowed freq for RT task whereas it's the min freq that is adjusted by
> uclamp and that should also be adjusted without uclamp. Let me fix
> that in effective_cpu_util and remove this early return from
> sugov_effective_cpu_perf()

+1

> > Can we rename this function please? It is not mapping anything, but applying
> > a dvfs headroom (I suggest apply_dvfs_headroom()). Which would make the comment
> > also unnecessary ;-)
> 
> I didn't want to add unnecessary renaming which often confuses
> reviewers so I kept  the current function name. But this can the be
> rename in a follow up patch

Okay.

> > >  static void sugov_get_util(struct sugov_cpu *sg_cpu)
> > >  {
> > > -     unsigned long util = cpu_util_cfs_boost(sg_cpu->cpu);
> > > -     struct rq *rq = cpu_rq(sg_cpu->cpu);
> > > +     unsigned long min, max, util = cpu_util_cfs_boost(sg_cpu->cpu);
> > >
> > > -     sg_cpu->bw_dl = cpu_bw_dl(rq);
> > > -     sg_cpu->util = effective_cpu_util(sg_cpu->cpu, util,
> > > -                                       FREQUENCY_UTIL, NULL);
> > > +     util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> > > +     sg_cpu->bw_min = map_util_perf(min);
> >
> > Hmm. I don't think we need to apply_dvfs_headroom() to min here. What's the
> > rationale to give headroom for min perf requirement? I think the headroom is
> > only required for actual util.
> 
> This headroom only applies for bw_min that is used with
> cpufreq_driver_adjust_perf(). Currently it only takes cpu_bw_dl()

It is also used in ignore_dl_rate_limit() - which is the user that caught my
eyes more.

I have to admit, I always get caught out with the new adjust_perf stuff. The
down side of working on older LTS kernels for prolonged time :p

> which seems too low because IRQ can preempt DL. So I added the average
> irq utilization into bw_min which is only an estimate and needs some
> headroom. That being said I can probably stay with current behavior
> for now and remove headroom

I think this is more logical IMHO. DL should never need any headroom. And irq
needing headroom is questionable everytime I think about it. Does an irq storm
need a dvfs headroom? I don't think it's a clear cut answer, but I tend towards
no.

> > And is it right to mix irq and uclamp_min with bw_min which is for DL? We might
> 
> cpu_bw_dl() is not the actual utilization by DL task but the computed
> bandwidth which can be seen as min performance level

Yep. That's why I am not in favour of a dvfs headroom for DL.

But what I meant here is that in effective_cpu_util(), where we populate min
and max we have

	if (min) {
	        /*
	         * The minimum utilization returns the highest level between:
	         * - the computed DL bandwidth needed with the irq pressure which
	         *   steals time to the deadline task.
	         * - The minimum performance requirement for CFS and/or RT.
	         */
	        *min = max(irq + cpu_bw_dl(rq), uclamp_rq_get(rq, UCLAMP_MIN));

So if there was an RT/CFS task requesting a UCLAMP_MIN of 1024 for example,
bw_min will end up being too high, no?

Should we add another arg to sugov_effective_cpu_perf() to populate bw_min too
for the single user who wants it?


Thanks!

--
Qais Yousef
