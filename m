Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752227ACB03
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjIXRXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:23:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DE109
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:23:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3231df68584so1220505f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1695576184; x=1696180984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz9hAphZ4hbgq5LD/NlJ0pJY551maKJPXOl5M0PmVhc=;
        b=TJoFcbX4gS9pGljVHj+CXzKVIya+ZWavbGkjBFYLg/sER7Aa+oGBvf6I3FUtQeaCeP
         4vR7w6oKawaeP7AGmZlMMtKF2zLOGoGnleoaQKqTCLeBGGtYpcd7N/D2a/Bmi/Ypwmax
         TSjKpMIALqiOqSJaHydJfI2RcpVKTtlgtfIqqfxpkLvGCiXXel/XiCmLP8jVSFPdpR8C
         XWLWhpuOgeMn9UgC26r1RRRdSr8hwpZ8G139v6z7+6Uc9vhZ8vfPt27//eJ0tUX6EQ34
         c70qw1NZ/Y28/NDUhImuJhJj3rzmhI48dCMGDNyOCMGf6YZwuRZGae7FR9Eup/ibHw/M
         uO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695576184; x=1696180984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz9hAphZ4hbgq5LD/NlJ0pJY551maKJPXOl5M0PmVhc=;
        b=gwO9xiAzlP2BcacrYa2urtJsMuqydxdO/PU9wtrA94BKAJ7XDQ5LWH0Xw+Nec99AvL
         Kbp7N9vJHkb0Oz382t1MJRTlILm4X4Gp3jjo0C3IQNyuNZAcGAAbugMPH1yDf7MZZurz
         WdD/+so+0nMPuteMMDkHwQL4lwUWeFRwXH0wqPpBtwDnXATHfPu1JQqHBga7qfyZFzdo
         C+w0BBDmhNbUYAX4B3zNC2320XQbW6xd5Kwc04dxxGwkqI6NEXVxTcUOaVbTXJKBtOB1
         nFk3Miy8rXQGpZep+rGP0P0ISmaymr5Sz93YjJeXtJlFYhfxDlAR5pTkKW8F0WXh9Nkr
         OLrA==
X-Gm-Message-State: AOJu0Yw8ThI0e64tJkNjKua8OxgpmEjs6bdorAMNZRjE2rN26cTotudb
        pHTovuJqZrI7yKNyKOgIYvwX2w==
X-Google-Smtp-Source: AGHT+IEgUK7ZrjO62XF+D4yff/sfL3h4WFmedhMgyH4sHz9AmsE6mLEDH3/51GE7kpEZutZK1lyJFQ==
X-Received: by 2002:a05:6000:12ca:b0:31f:f94e:d276 with SMTP id l10-20020a05600012ca00b0031ff94ed276mr4912977wrx.51.1695576184210;
        Sun, 24 Sep 2023 10:23:04 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d4c4b000000b0031fbbe347ebsm9645933wrt.22.2023.09.24.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 10:23:03 -0700 (PDT)
Date:   Sun, 24 Sep 2023 18:23:01 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230924172301.7lqdcsnpqk7trtno@airbuntu>
References: <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <CAKfTPtBFAXO=CgqSJ1+y=2ppb5t4oErCtvV336fS6J2nSjBCkQ@mail.gmail.com>
 <20230916192509.bportepj7dbgp6ro@airbuntu>
 <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtA5JqNCauG-rP3wGfq+p8EEVx9Tvwj6ksM3SYCwRmfCTg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/24/23 09:58, Vincent Guittot wrote:

> > Shouldn't it be (568+128)*1.25 = 870? Which is almost the 860 above. We calmped
> > the 812 to 800, with rounding errors that almost accounts for the 10 points
> > difference between 870 and 860..
> 
> no I voluntarily use 568 + 128*1.25. I added dvfs headroom for irq
> just to ensure that you will not raise that I removed the headroom for
> irq and focus on the use case but it might have created more
> confusion.
> 
> My example above demonstrate that only taking care of cases with null
> irq pressure is not enough and you can still ends up above 800
> 
> IIUC you point with uclamp_max. It is a performance limit that you
> don't want to cross because of CFS.This means that we should not go
> above 800 in my example because of cfs utilization: Irq needs between
> 128 and CFS asks 568 so the system needs 696 which is below the 800
> uclamp. Even if you add the dvfs headroom on irq, the system is still
> below 800. Only when you add dfvs headroom to cfs then you go above
> 800 but it's not needed because uclamp say that you should not go

Yep, absolutely. It seems we agree that CFS shouldn't go above 800 if it is
capped even if there's headroom, but the question you have on the way it is
being applied. As long as we agree on this part which is a fundamental behavior
question that I thought is the pain point, the implementation details are
certainly something that I can improve on.

> above 800 because of CFS so we should stay at 800 whereas both current
> formula and your new formula return a value above 800

I'm not sure how to handle irq, rt and dl here to be honest. They seem to have
been taken as an 'additional' demand on top of CFS. So yes, we'll go above but
irq, and dl don't have knowledge about ucalmp_max. RT does and will be equally
capped like CFS. I kept current behavior the same, but I did wonder about them
too in patch 4.

So in a system where there are active CFS, RT, DL and IRQ and both CFS and RT
had a cap of 800, then they won't ask for me. But once we add IRQ and DL on
top, then we'll go above.

You think we shouldn't? See below for a suggestion.

> > I am still not sure if you mean we are mixing up the code and we need better
> > abstraction or something else.
> >
> > Beside the abstraction problem, which I agree with, I can't see what I am
> > mixing up yet :( Sorry I think I need more helping hand to see it.
> 
> There is a mix between actual utilization and performance limit and
> when we add both we then lose important information as highlighted by
> my example. If the current formula is not correct because we can go
> above uclamp_max value, your proposal is not better. And the root
> cause is mainly coming from adding utilization with performance limit
> (i.e. uclamp)
> 
> That's why I said that we need a new interface to enable cpufreq to
> not blindly apply its headroom but to make smarter decision at cpufreq
> level

Okay I see. I tend to agree here too. The question is should cpufreq take each
util (cfs, rt, dl, irq) as input and do the decision on its own. Or should the
scheduler add them and pass the aggregated value? If the latter, how can
cpufreq know how to apply the limit? From what I see all these decisions has to
happen in the same function but not split.

It seems the sticking point is how we interpret irq pressure with uclamp. It
seems you think we should apply any uclamp capping to this, which I think would
make sense.

And DL bandwidth we need to max() with the aggregated value.

So I think the formula could be

	util = cfs + rt pressure + irq pressure

	unsigned long cpufreq_convert_util_to_freq(rq, util, dl_bw)
	{
		eff_util = apply_dvfs_headroom(util);
		eff_util = uclamp_rq_util_with(rq, util, NULL);

		eff_util = max(eff_util, dl_bw);
	}

so we add the utilization of cfs, rt and irq (as per current formula). And then
let cpufreq do the headroom and limit management.

I changed the way we handle dl_bw as it is actually requesting to run at
a specific level and not really a pressure. So we max() it with eff_util.

If there's a DL task on the rq then it'd be running and the frequency it
needs is defined by its bandwidth.

We could also keep it as it is with

	unsigned long cpufreq_convert_util_to_freq(rq, util, dl_bw)
	{
		eff_util = apply_dvfs_headroom(util);
		eff_util = uclamp_rq_util_with(rq, util, NULL);

		eff_util += dl_bw;
	}

RT has uclamp knowledge so it'll either run at max or whatever value it might
have requested via uclamp_min. But DL doesn't set any uclamp_min and must be
either added or max()ed. I'm not sure which is more correct yet, but maybe
adding actually is better to ensure the CPU runs higher to handle all the tasks
on the rq.

What do you think?


Thanks!

--
Qais Yousef
