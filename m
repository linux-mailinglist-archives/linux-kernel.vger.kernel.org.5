Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1C675F7AF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGXNBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGXNAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:00:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F8C446B3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:58:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C2DFEC;
        Mon, 24 Jul 2023 05:58:55 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8396B3F67D;
        Mon, 24 Jul 2023 05:58:11 -0700 (PDT)
Message-ID: <c31e5667-19b1-33a4-d1f1-a88907e239d3@arm.com>
Date:   Mon, 24 Jul 2023 14:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book> <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu> <ZLqNmpQdiTC2fio5@vingu-book>
 <20230721220430.qv6eqo4dosfrsilo@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230721220430.qv6eqo4dosfrsilo@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2023 00:04, Qais Yousef wrote:
> On 07/21/23 15:52, Vincent Guittot wrote:
>> Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
>>> On 07/20/23 14:31, Vincent Guittot wrote:
>>>
>>>> I was trying to reproduce the behavior but I was failing until I
>>>> realized that this code path is used when the 2 groups are not sharing
>>>> their cache. Which topology do you use ? I thought that dynamiQ and
>>>> shares cache between all 8 cpus was the norm for arm64 embedded device
>>>> now
>>>
>>> Hmm good question. phantom domains didn't die which I think is what causing
>>> this. I can look if this is for a good reason or just historical artifact.
>>>
>>>>
>>>> Also when you say "the little cluster capacity is very small nowadays
>>>> (around 200 or less)", it is the capacity of 1 core or the cluster ?
>>>
>>> I meant one core. So in my case all the littles were busy except for one that
>>> was mostly idle and never pulled a task from mid where two tasks were stuck on
>>> a CPU there. And the logs I have added were showing me that the env->imbalance
>>> was on 150+ range but the task we pull was in the 350+ range.
>>
>> I'm not able to reproduce your problem with v6.5-rc2 and without phantom domain,
>> which is expected because we share cache and weight is 1 so we use the path
>>
>> 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
>> 			/*
>> 			 * When prefer sibling, evenly spread running tasks on
>> 			 * groups.
>> 			 */
>> 			env->migration_type = migrate_task;
>> 			env->imbalance = sibling_imbalance(env, sds, busiest, local);
>> 		} else {
>>
> 
> I missed the deps on topology. So yes you're right, this needs to be addressed
> first. I seem to remember Sudeep merged some stuff that will flatten these
> topologies.
> 
> Let me chase this topology thing out first.

Sudeeps patches align topology cpumasks with cache cpumasks.

tip/sched/core:

root@juno:~# cat /sys/devices/system/cpu/cpu*/topology/package_cpus
3f
3f
3f
3f
3f
3f

v5.9:

root@juno:~# cat /sys/devices/system/cpu/cpu*/topology/package_cpus
39
06
06
39
39
39

So Android userspace won't be able to detect uArch boundaries via
`package_cpus` any longer.

The phantom domain (DIE) in Android is a legacy decision from within
Android. Pre-mainline Energy Model was attached to the sched domain
topology hierarchy. And then IMHO other Android functionality start to
rely on this. It could be removed regardless of Sudeeps patches in case
Android would be OK with it.

The phantom domain is probably set up via DT cpu_map entry:

cpu-map {
  cluster0 { <-- enforce phantom domain
    core0 {
      cpu = <&CPU0>;
    };
...
    core3 {
      cpu = <&CPU1>;
    };
  cluster1 {
...

Juno (arch/arm64/boot/dts/arm/juno.dts) also uses cpu-map to enforce
uarch boundaries on DIE group boundary congruence.

tip/sched/core:

# cat /proc/schedstat | awk '{ print $1 " " $2}' | head -5
...
cpu0 0
domain0 39
domain1 3f

v5.9:

# cat /proc/schedstat | awk '{ print $1 " " $2}' | head -5
...
cpu0 0
domain0 39
domain1 3f

We had a talk at LPC '22 about the influence of the patch-set and the
phantom domain legacy issue:

https://lpc.events/event/16/contributions/1342/attachments/962/1883/LPC-2022-Android-MC-Phantom-Domains.pdf

[...]
