Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F3756566
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjGQNr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjGQNrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:47:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4501126;
        Mon, 17 Jul 2023 06:47:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 089BEC15;
        Mon, 17 Jul 2023 06:48:06 -0700 (PDT)
Received: from [10.57.31.114] (unknown [10.57.31.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 162893F67D;
        Mon, 17 Jul 2023 06:47:20 -0700 (PDT)
Message-ID: <aa4a22b8-fc23-8c67-bdea-b6aac8f7e250@arm.com>
Date:   Mon, 17 Jul 2023 14:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/2] cpuidle: teo: Introduce util-awareness
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
 <20230105145159.1089531-3-kajetan.puchalski@arm.com>
 <20230711175814.zfavcn7xn3ia5va4@airbuntu>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20230711175814.zfavcn7xn3ia5va4@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

The rule is 'one size doesn't fit all', please see below.

On 7/11/23 18:58, Qais Yousef wrote:
> Hi Kajetan
> 
> On 01/05/23 14:51, Kajetan Puchalski wrote:
> 
> [...]
> 
>> @@ -510,9 +598,11 @@ static int teo_enable_device(struct cpuidle_driver *drv,
>>   			     struct cpuidle_device *dev)
>>   {
>>   	struct teo_cpu *cpu_data = per_cpu_ptr(&teo_cpus, dev->cpu);
>> +	unsigned long max_capacity = arch_scale_cpu_capacity(dev->cpu);
>>   	int i;
>>   
>>   	memset(cpu_data, 0, sizeof(*cpu_data));
>> +	cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> 
> Given that utilization is invariant, why do we set the threshold based on
> cpu capacity?


To treat CPUs differently, not with the same policy.


> 
> I'm not sure if this is a problem, but on little cores this threshold would be
> too low. Given that util is invariant - I wondered if we need to have a single
> threshold for all type of CPUs instead. Have you tried something like that

A single threshold for all CPUs might be biased towards some CPUs. Let's
pick the value 15 - which was tested to work really good in benchmarks
for the big CPUs. On the other hand when you set that value to little
CPUs, with max_capacity = 124, than you have 15/124 ~= 13% threshold.
That means you prefer to enter deeper idle state ~9x times (at max
freq). What if the Little's freq is set to e.g. < ~20% fmax, which
corresponds to capacity < ~25? Let's try to simulate such scenario.

In a situation we could have utilization 14 on Little CPU, than CPU 
capacity (effectively frequency) voting based on utilization would be
1.2 * 14 = ~17 so let's pick OPP corresponding to 17 capacity.
In such condition the little CPU would run the 14-util-periodic-task for
14/17= ~82% of wall-clock time. That's a lot, and not suited for
entering deeper idle state on that CPU, isn't it?

Apart from that, the little CPUs are tiny in terms of silicon area
and are less leaky in WFI than big cores. Therefore, they don't need
aggressive entries into deeper idle state. At the same time, they
are often used for serving interrupts, where the latency is important
factor.

> while developing the patch?

We have tried different threshold values in terms of %, but for all CPUs
(at the same time) not per-cluster. The reason was to treat those CPUs
differently as described above.

Regards,
Lukasz
