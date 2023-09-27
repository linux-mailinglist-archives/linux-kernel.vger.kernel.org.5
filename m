Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33717B09B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjI0QMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjI0QMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:12:03 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491BE4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1695831118;
        bh=fgc9IdmUaNy4X1jVRlgY4R36W4JC1ydNBrzr1sOs/ZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=xb2fUbJMvbXaNDx8YLGRV7YvzWrZvqDn43Mjqc2SsT28q/YgS/2nP2/NXqnw4pa9O
         i32kJRNTj3dj1/dU29xI0EF6zB223r3azREs5nhr2Zghd+fbXMAxUXuWSKDRXkOAzC
         CPWszQFSDMyz9F3I3cUM1n1lTnKRJcWMV3hdYTmUInDPPUN58DP6cJ+Z0wVkCydyTV
         q++AwQiSBRIkn++JyAR01HEo7AP/NbGFCH5dRlCArkHvwXVoUJne+P4+5qnft8GK/m
         4U+tNx6aYP9V/zckGWw8KRBQok2L1GfPtaQPJdAdtWL4blmGEYDg9fQNWAFu4EfPSQ
         HDUKGIpfJjW2A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4RwhSs6TTDz1QnK;
        Wed, 27 Sep 2023 12:11:57 -0400 (EDT)
Message-ID: <5a7d9084-a716-5641-6319-ae8c918ac3f9@efficios.com>
Date:   Wed, 27 Sep 2023 12:11:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] sched/fair: skip the cache hot CPU in
 select_idle_cpu()
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.chen.surf@gmail.com>
References: <cover.1695704179.git.yu.c.chen@intel.com>
 <4f2131940d43060eda55847a2affc8042179b4ee.1695704179.git.yu.c.chen@intel.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <4f2131940d43060eda55847a2affc8042179b4ee.1695704179.git.yu.c.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/23 06:11, Chen Yu wrote:
> Problem statement:
> When task p is woken up, the scheduler leverages select_idle_sibling()
> to find an idle CPU for it. p's previous CPU is usually a preference
> because it can improve cache locality. However in many cases, the
> previous CPU has already been taken by other wakees, thus p has to
> find another idle CPU.
> 
> Proposal:
> Inspired by Mathieu's idea[1], introduce the SIS_CACHE. It considers
> the sleep time of the task for better task placement. Based on the
> task's short sleeping history, keep p's previous CPU idle for a short
> while. Later when p is woken up, it can choose its previous CPU in
> select_idle_sibling(). When p's previous CPU is reserved, another wakee
> is not allowed to choose this CPU in select_idle_idle(). The reservation
> period is set to the task's average short sleep time, AKA, se->sis_rsv_avg.
> 
> This does not break the work conservation of the scheduler, because
> wakee will still try its best to find an idle CPU. The difference is that
> different idle CPUs might have different priorities.
> 
> Prateek pointed out that, with SIS_CACHE enabled, if all idle CPUs are
> cache-hot, select_idle_cpu() might have to choose a non-idle target CPU,
> which brings task stacking. Mitigate this by returning the first cache-hot
> idle CPU if no cache-cold CPU is found.

I've tried your patches on my reference hackbench workload:

./hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100

Unfortunately they don't appear to help for that specific load.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

