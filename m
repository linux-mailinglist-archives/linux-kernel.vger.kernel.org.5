Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471377D7AF2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjJZCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZCgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:36:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D164910A;
        Wed, 25 Oct 2023 19:36:18 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SG8vd5cJbzNpW6;
        Thu, 26 Oct 2023 10:32:13 +0800 (CST)
Received: from [10.174.179.163] (10.174.179.163) by
 kwepemi500024.china.huawei.com (7.221.188.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 10:36:16 +0800
Message-ID: <1369cedf-e66b-82eb-4501-a6976bb8c558@huawei.com>
Date:   Thu, 26 Oct 2023 10:36:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH -next] cpufreq: userspace: Keep the current frequency when
 set userspace policy
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <liwei391@huawei.com>,
        <linux-pm@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <wangxiongfeng2@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231025080910.3245690-1-zengheng4@huawei.com>
 <20231025111821.pp3hdpilddbx4yzr@vireshk-i7>
From:   Zeng Heng <zengheng4@huawei.com>
In-Reply-To: <20231025111821.pp3hdpilddbx4yzr@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.163]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/10/25 19:18, Viresh Kumar 写道:
> On 25-10-23, 16:09, Zeng Heng wrote:
>> When switching to the userspace policy, if the current frequency is within
>> the range of policy's min and max values, the current frequency value
>> should be remained. The .limit() function is called when changing governor
>> or updating governor limits, so in both cases, there is no need to update
>> frequency if the current frequency does not exceed the threshold.
>>
>> Additionally, when changing to userspace governor, the default value of
>> set_speed is set by reading the current frequency of the CPU, but there
>> is inevitable error between the frequency coming from .get_rate() interface
>> and the actual working frequency. Consequently, when switching to userspace
>> policy, keeping the current frequency can avoid unexpected changes.
>>
>> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
>> ---
>>   drivers/cpufreq/cpufreq_userspace.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
>> index 2c42fee76daa..fe55a7bb663c 100644
>> --- a/drivers/cpufreq/cpufreq_userspace.c
>> +++ b/drivers/cpufreq/cpufreq_userspace.c
>> @@ -117,9 +117,7 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
>>   	else if (policy->min > userspace->setspeed)
>>   		__cpufreq_driver_target(policy, policy->min,
>>   					CPUFREQ_RELATION_L);
>> -	else
>> -		__cpufreq_driver_target(policy, userspace->setspeed,
>> -					CPUFREQ_RELATION_L);
>> +	/* Otherwise, keep the current frequency. */
>>
>>   	mutex_unlock(&userspace->mutex);
>>   }
> Here is some reasoning why it should be done the way it is:
>
> commit e43e94c1eda7 ("cpufreq: Fix GOV_LIMITS handling for the userspace governor")


Get it, thanks for the response.

Zeng Heng

