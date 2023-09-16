Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457137A3240
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbjIPTZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbjIPTZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:25:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6A7F7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:25:29 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso36575785e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1694892328; x=1695497128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2ak/x1WTkgqGnFpeeTytapXoHBG+0Maebkw6pQDONU=;
        b=dtEzH7+g9SIAzBkQl+6oIjBcLF3jsMrtL20qxebkWPMQg7ELUAjrNsvsu7BV7RJkOl
         2r+ay+Fihb0igBpvrSmEf3gOQHRKHrGwBMI4BDJPJJ0NrWt8NJQuil2sMfeP32HzaA+m
         AVEmSq+GOmWNvicy2ghbtxZnKlybCvMNoM/mb7zFHKQuJaSneur1qAu3NKbY/alV8sWE
         bURdIM/RVfK8cLs6u6wK8P8SbzjtnWFItB6e/wW76OoD8JfsRay8uukAtoWA6mLdjg0l
         MTysKazqquDvOeA/Gv9qSa3mFZTJZAYdxkxJaOchtqnM78raK64EFTXZOHDWHH4hLTgH
         rp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694892328; x=1695497128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2ak/x1WTkgqGnFpeeTytapXoHBG+0Maebkw6pQDONU=;
        b=UIAeZLl3MaVhczPh9k6iI2KIcVeiFqMiC/AwK+vO42VyRekg7DUghsK4DxfhoB3RCt
         E8GYPyIDNnk8Y4UXhqh2RGPzCBv99Mje2mGb7+fVxD/xvxaOteOcu6kijMQR0S76IdXn
         /C7qGRaWvXDacgC+l7lqUkn4lh0QKMBFRabsmTV+OBi1+diTrZHO/v1wZZNWyWPYAGF3
         Z1RC62GV3eVwForDuISjZsDp/Kw8b8pftSjxJzxqKJY/AaOC1SIQcOeCk4deLBv47ot4
         ZP5z11fVIQDQXftxe7ADgEmd65nnWDPze3t2keYgulCCBErqP94rLi1nClGM+vNOepa7
         00qA==
X-Gm-Message-State: AOJu0YyC+GaA6hFz5X6s8+XxqnhNzP8lAxo7j3p/tXBiT/d3fkDSnJTW
        afrIcAszP2tIomz1QYPoAb93Iw==
X-Google-Smtp-Source: AGHT+IG7h8jkNjHayxzj7qQhK5Y+fTM3y8iZsizQkXy9tbdxFhcqElXj7FcXFolcLjlQMVp+WdkMuQ==
X-Received: by 2002:a05:600c:21cb:b0:401:b53e:6c57 with SMTP id x11-20020a05600c21cb00b00401b53e6c57mr4630266wmj.9.1694892328167;
        Sat, 16 Sep 2023 12:25:28 -0700 (PDT)
Received: from airbuntu (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b004013797efb6sm10866566wmj.9.2023.09.16.12.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 12:25:27 -0700 (PDT)
Date:   Sat, 16 Sep 2023 20:25:26 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 2/4] sched: cpufreq: Fix apply_dvfs_headroom() escaping
 uclamp constraints
Message-ID: <20230916192526.gd2kevpq5okondjm@airbuntu>
References: <20230820210640.585311-1-qyousef@layalina.io>
 <20230820210640.585311-3-qyousef@layalina.io>
 <CAKfTPtDY48jpO+b-2KXawzxh-ty+FMKX6YUXioNR7kpgO=ua6Q@mail.gmail.com>
 <20230829163740.uadhv2jfjuumqk3w@airbuntu>
 <CAKfTPtCP6uX79dOrzN4PxFTMBFrDAMOOrWyZrsVypUQ0RY7BAA@mail.gmail.com>
 <20230907215555.exjxho34ntkjmn6r@airbuntu>
 <CAKfTPtA8Ljy4NBqjw8Wj4pEFc-OCR55QPuwh+5GgrHN6u+ugsg@mail.gmail.com>
 <20230910174638.qe7jqq6mq36brh6o@airbuntu>
 <979a9e2f-06a8-1936-b5cd-2949eca99b21@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <979a9e2f-06a8-1936-b5cd-2949eca99b21@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/23 15:40, Dietmar Eggemann wrote:
> On 10/09/2023 19:46, Qais Yousef wrote:
> > On 09/08/23 16:30, Vincent Guittot wrote:
> > 
> 
> [...]
> 
> >>>> above 512 whatever the current (720)  formula or your proposal (608).
> >>>> In the case of uclamp, it should be applied after having been scaled
> >>>> by irq time.
> >>>
> >>> I lost you a bit here. I'm not sure how you reached the 720 and 608 numbers.
> >>
> >> My bad, I finally decided to use an irq pressure of 128 in my
> >> calculation but forgot to change the value in my email
> >>
> >>>
> >>> So the way I'm proposing it here
> >>>
> >>>         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> >>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >>>         util = scale_rq_capacity(512, 256, 1024) = 0.75 * 512 = 384
> >>>         util += dvfs_headroom(irq) = 384 + 256 + 0.25 * 256 = 704
> >>>         util += dvfs_headroom(dl_bw) = 704
> >>>
> >>>>
> >>>> So we should have reported utilization of 720 with a bandwidth
> >>>> requirement of 512 and then cpufreq can applies its headroom if needed
> >>>
> >>> The key part I'm changing is this
> >>>
> >>>         util = cfs + rt + dvfs_headroom(cfs+rt) = 800 + 0.25 * 800 = 1000
> >>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >>>
> >>> Before we had (assume irq, rt and dl are 0 for simplicity and a single task is
> >>> running)
> >>>
> >>>         util = cfs = 800
> >>>         util = uclamp_rq_util_with(rq, util, NULL) = 512
> >>>         util = dvfs_headroom(util) = 512 * 0.25 * 512 = 640
> >>>
> >>> So we are running higher than we are allowed to. So applying the headroom
> >>> after taking uclamp constraints into account is the problem.
> 
> I'm not sure I understood all the example math in this thread correctly:
> 
> Examples:
> 
> irq = 128 or 256
> 
> util = 800 uclamp = 512
> 
> 
> --- current code:
> 
> ((util_cfs + util_rt) * ((max - irq) / max) + irq + dl_bw) * scale
> 
> <- uclamped(cfs+rt) ->
> 
> <--               scale_irq_capacity()                  -->|<-- map_util_perf() 
>                                                                / (headroom())  
> 
> irq = 128: (512 * (1024 - 128) / 1024 + 128 + 0) * 1.25 = 576 * 1.25 = 720
> 
> irq = 256: (512 * (1024 - 256) / 1024 + 256 + 0) * 1.25 = 640 * 1.25 = 800
> 
> 
> --- new approach:
> 
> irq = 128: (512 * (1024 - 128) / 1024 + 128 + 0.25 * 128)            = 608
> 
> irq = 256: (512 * (1024 - 256) / 1024 + 256 + 0.25 * 256)            = 704
> 
>             <->
>             uclamped(cfs+rt+headroom(cfs+rt))
> 
>             <- scale_irq_capacity() ->
> 
>             <--               headroom(irq) ?        -->
> 
> 
> Is the correct?

Yes, this is my understanding too. But I'm not sure anymore as it seems I'm
missing something from what Vincent is saying.


Thanks!

--
Qais Yousef
