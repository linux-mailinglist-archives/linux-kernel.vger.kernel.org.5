Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89C87D7A86
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjJZBzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZBzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:55:46 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B094E115;
        Wed, 25 Oct 2023 18:55:43 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SG80p2JlFzNpB9;
        Thu, 26 Oct 2023 09:51:38 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 09:55:40 +0800
Message-ID: <abb15757-cbe6-037f-e8d3-5df9fbbf6c04@huawei.com>
Date:   Thu, 26 Oct 2023 09:55:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] cpufreq: CPPC: Eliminate the impact of cpc_read()
 latency error
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
CC:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        <amit.kachhap@arm.com>, <rafael@kernel.org>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-4-zengheng4@huawei.com>
 <ZTj1fMsMj-Mekfn3@FVFF77S0Q05N>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <ZTj1fMsMj-Mekfn3@FVFF77S0Q05N>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/25 19:01, Mark Rutland 写道:
> On Wed, Oct 25, 2023 at 05:38:47PM +0800, Zeng Heng wrote:
>
> The previous patch added this function, and calls it with smp_call_on_cpu(),
> where it'll run in IRQ context with IRQs disabled...

smp_call_on_cpu() puts the work to the bind-cpu worker.

And this function will be called in task context, and IRQs is certainly enabled.


Zeng Heng

>>   	struct fb_ctr_pair *fb_ctrs = val;
>>   	int cpu = fb_ctrs->cpu;
>>   	int ret;
>> +	unsigned long timeout;
>>   
>>   	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t0);
>>   	if (ret)
>>   		return ret;
>>   
>> -	udelay(2); /* 2usec delay between sampling */
>> +	if (likely(!irqs_disabled())) {
>> +		/*
>> +		 * Set 1ms as sampling interval, but never schedule
>> +		 * to the idle task to prevent the AMU counters from
>> +		 * stopping working.
>> +		 */
>> +		timeout = jiffies + msecs_to_jiffies(1);
>> +		while (!time_after(jiffies, timeout))
>> +			cond_resched();
>> +
>> +	} else {
> ... so we'll enter this branch of the if-else ...
>
>> +		pr_warn_once("CPU%d: Get rate in atomic context", cpu);
> ... and pr_warn_once() for something that's apparently normal and outside of
> the user's control?
>
> That doesn't make much sense to me.
>
> Mark.
>
>> +		udelay(2); /* 2usec delay between sampling */
>> +	}
>>   
>>   	return cppc_get_perf_ctrs(cpu, &fb_ctrs->fb_ctrs_t1);
>>   }
>> -- 
>> 2.25.1
>>
