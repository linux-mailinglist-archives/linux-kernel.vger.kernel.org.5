Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FBB7D7ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjJZCZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZCZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:25:02 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922D12F;
        Wed, 25 Oct 2023 19:24:59 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SG8fL58PbzMmF3;
        Thu, 26 Oct 2023 10:20:42 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 10:24:55 +0800
Message-ID: <dcc4dfd7-fbef-7b46-5037-3916077ec696@huawei.com>
Date:   Thu, 26 Oct 2023 10:24:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] cpufreq: CPPC: Keep the target core awake when
 reading its cpufreq rate
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <broonie@kernel.org>, <joey.gouly@arm.com>, <will@kernel.org>,
        <amit.kachhap@arm.com>, <rafael@kernel.org>,
        <catalin.marinas@arm.com>, <james.morse@arm.com>,
        <mark.rutland@arm.com>, <maz@kernel.org>,
        <viresh.kumar@linaro.org>, <sumitg@nvidia.com>,
        <yang@os.amperecomputing.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>
References: <20231025093847.3740104-1-zengheng4@huawei.com>
 <20231025093847.3740104-3-zengheng4@huawei.com>
 <20231025111301.ng5eaeaixfs3jjpg@bogus>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20231025111301.ng5eaeaixfs3jjpg@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


在 2023/10/25 19:13, Sudeep Holla 写道:
> On Wed, Oct 25, 2023 at 05:38:46PM +0800, Zeng Heng wrote:
>> As ARM AMU's document says, all counters are subject to any changes
>> in clock frequency, including clock stopping caused by the WFI and WFE
>> instructions.
>>
>> Therefore, using smp_call_on_cpu() to trigger target CPU to
>> read self's AMU counters, which ensures the counters are working
>> properly while cstate feature is enabled.
>>
>> Reported-by: Sumit Gupta <sumitg@nvidia.com>
>> Link: https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 39 ++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index fe08ca419b3d..321a9dc9484d 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
> [...]
>
>> @@ -850,18 +871,18 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
>>   
>>   	cpufreq_cpu_put(policy);
>>   
>> -	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
>> -	if (ret)
>> -		return 0;
>> -
>> -	udelay(2); /* 2usec delay between sampling */
>> +	if (cpu_has_amu_feat(cpu))
> Have you compiled this on x86 ? Even if you have somehow managed to,
> this is not the right place to check the presence of AMU feature on
> the CPU.
> If AMU registers are used in CPPC, they must be using FFH GAS, in which
> case the interpretation of FFH is architecture dependent code.


According to drivers/cpufreq/Makefile, cppc_cpufreq.c is only compiled with

ARM architecture.

But here, I would change cpu_has_amu_feat() with cpc_ffh_supported(), which

belongs to FFH APIs.

Thanks for the suggestion.


Thanks again,

Zeng Heng



> --
> Regards,
> Sudeep
>
