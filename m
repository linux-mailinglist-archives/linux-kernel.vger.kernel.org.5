Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5E077EF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347622AbjHQCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjHQCdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:33:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97900270C;
        Wed, 16 Aug 2023 19:33:16 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RR89259nMzNmyn;
        Thu, 17 Aug 2023 10:29:42 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 10:33:14 +0800
Message-ID: <e727d702-314a-e3ec-4ee6-8d4e2df73c92@huawei.com>
Date:   Thu, 17 Aug 2023 10:33:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if
 fails to create kworker_fie
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230816094938.862186-1-liaochang1@huawei.com>
 <20230816103731.qwx3j3rmwyszq45j@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230816103731.qwx3j3rmwyszq45j@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/16 18:37, Viresh Kumar 写道:
> On 16-08-23, 09:49, Liao Chang wrote:
>> The function cppc_freq_invariance_init() may failed to create
>> kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
>> to prevent an invalid pointer dereference in kthread_destroy_worker(),
>> which called from cppc_freq_invariance_exit().
>>
>> Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 28 ++++++++++++++++------------
>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 022e3555407c..bff4cde06083 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -220,6 +220,15 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
>>  	}
>>  }
>>  
>> +static void cppc_freq_invariance_exit(void)
>> +{
>> +	if (fie_disabled)
>> +		return;
>> +
>> +	kthread_destroy_worker(kworker_fie);
>> +	kworker_fie = NULL;
>> +}
>> +
>>  static void __init cppc_freq_invariance_init(void)
>>  {
>>  	struct sched_attr attr = {
>> @@ -249,27 +258,22 @@ static void __init cppc_freq_invariance_init(void)
>>  		return;
>>  
>>  	kworker_fie = kthread_create_worker(0, "cppc_fie");
>> -	if (IS_ERR(kworker_fie))
>> +	if (IS_ERR(kworker_fie)) {
>> +		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
>> +			PTR_ERR(kworker_fie));
>> +		fie_disabled = FIE_DISABLED;
>>  		return;
>> +	}
>>  
>>  	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
>>  	if (ret) {
>>  		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
>>  			ret);
>> -		kthread_destroy_worker(kworker_fie);
>> -		return;
>> +		cppc_freq_invariance_exit();
> 
> I don't really like this change, there aren't a lot of things that we
> need to do here on cleanup, but just kthread_destroy_worker(). Calling
> it directly makes more sense I guess.

OK，I will simplify code in next revisoin.

> 
>> +		fie_disabled = FIE_DISABLED;
>>  	}
>>  }
>>  
>> -static void cppc_freq_invariance_exit(void)
>> -{
>> -	if (fie_disabled)
>> -		return;
>> -
>> -	kthread_destroy_worker(kworker_fie);
> 
>> -	kworker_fie = NULL;
> 
> I don't see the point of this line. Probably it can be dropped.

I agree with you, when fie_disbaled is set to FIE_DISABLED and kthred_destroy_worker() is called,
the driver has no chance to access the invalid kworker_fie pointer.

Thanks.

> 
>> -}
>> -
>>  #else
>>  static inline void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
>>  {
>> -- 
>> 2.34.1
> 

-- 
BR
Liao, Chang
