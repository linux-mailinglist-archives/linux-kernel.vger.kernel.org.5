Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC97937E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjIFJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbjIFJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:17:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E200ECE2;
        Wed,  6 Sep 2023 02:17:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1A11063;
        Wed,  6 Sep 2023 02:18:18 -0700 (PDT)
Received: from [10.57.91.205] (unknown [10.57.91.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 685523F7C5;
        Wed,  6 Sep 2023 02:17:38 -0700 (PDT)
Message-ID: <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
Date:   Wed, 6 Sep 2023 10:18:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230827233203.1315953-1-qyousef@layalina.io>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230827233203.1315953-1-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 8/28/23 00:31, Qais Yousef wrote:
> Since the introduction of EAS and schedutil, we had two magic 0.8 and 1.25
> margins applied in fits_capacity() and apply_dvfs_headroom().
> 
> As reported two years ago in
> 
> 	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/
> 
> these values are not good fit for all systems and people do feel the need to
> modify them regularly out of tree.

That is true, in Android kernel those are known 'features'. Furthermore,
in my game testing it looks like higher margins do help to shrink
number of dropped frames, while on other types of workloads (e.g.
those that you have in the link above) the 0% shows better energy.

I remember also the results from MTK regarding the PELT HALF_LIFE

https://lore.kernel.org/all/0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com/

The numbers for 8ms half_life where showing really nice improvement
for the 'min fps' metric. I got similar with higher margin.

IMO we can derive quite important information from those different
experiments:
More sustainable workloads like "Yahoo browser" don't need margin.
More unpredictable workloads like "Fortnite" (shooter game with 'open
world') need some decent margin.

The problem is that the periodic task can be 'noisy'. The low-pass
filter which is our exponentially weighted moving avg PELT will
'smooth' the measured values. It will block sudden 'spikes' since
they are high-frequency changes. Those sudden 'spikes' are
the task activations where we need to compute a bit longer, e.g.
there was explosion in the game. The 25% margin helps us to
be ready for this 'noisy' task - the CPU frequency is higher
(and capacity). So if a sudden need for longer computation
is seen, then we have enough 'idle time' (~25% idle) to serve this
properly and not loose the frame.

The margin helps in two ways for 'noisy' workloads:
1. in fits_capacity() to avoid a CPU which couldn't handle it
    and prefers CPUs with higher capacity
2. it asks for longer 'idle time' e.g. 25-40% (depends on margin) to
    serve sudden computation need

IIUC, your proposal is to:
1. extend the low-pass filter to some higher frequency, so we
    could see those 'spikes' - that's the PELT HALF_LIFE boot
    parameter for 8ms
1.1. You are likely to have a 'gift' from the Util_est
      which picks the max util_avg values and maintains them
      for a while. That's why the 8ms PELT information can last longer
      and you can get higher frequency and longer idle time.
2. Plumb in this new idea of dvfs_update_delay as the new
    'margin' - this I don't understand

For the 2. I don't see that the dvfs HW characteristics are best
for this problem purpose. We can have a really fast DVFS HW,
but we need some decent spare idle time in some workloads, which
are two independent issues IMO. You might get the higher
idle time thanks to 1.1. but this is a 'side effect'.

Could you explain a bit more why this dvfs_update_delay is
crucial here?

Regards,
Lukasz

