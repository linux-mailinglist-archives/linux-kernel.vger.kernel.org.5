Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F75783CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbjHVJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbjHVJRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:17:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD49C113;
        Tue, 22 Aug 2023 02:17:45 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RVNvC0NVnztRrB;
        Tue, 22 Aug 2023 17:13:59 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 17:17:41 +0800
Message-ID: <ce499ce6-0b05-a17c-fe03-b2630acb97ce@hisilicon.com>
Date:   Tue, 22 Aug 2023 17:17:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH] cpufreq: Support per-policy performance boost
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <xuwei5@huawei.com>, <wanghuiqiang@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangxiongfeng2@huawei.com>
References: <20230724075827.4160512-1-zhanjie9@hisilicon.com>
 <20230816062757.tocdrqh3isxcrt3r@vireshk-i7>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230816062757.tocdrqh3isxcrt3r@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Many thanks for your sugguestion.

Happy with all the comments. Will send a v2 soon.

Jie

On 16/08/2023 14:27, Viresh Kumar wrote:
> Hi Jie,
>
> I am not sure how useful this per-policy boost is for your use case,
> but I have no objection to the same if it is worth it.
>
> On 24-07-23, 15:58, Jie Zhan wrote:
>> The boost control currently applies to the whole system.  However, users
>> may prefer to boost a subset of cores in order to provide prioritized
>> performance to workloads running on the boosted cores.
>>
>> Enable per-policy boost by adding a 'local_boost' sysfs interface.  This
>> can be found at:
>>
>> 	/sys/devices/system/cpu/cpufreq/policy<*>/local_boost
> Just name it boost instead of local_boost, it is present in the
> policy's directory, that is enough.
>
>> Same to the global boost switch, writing 1/0 to 'local_boost'
>> enables/disables boost on a cpufreq policy respectively.
>>
>> The user view of global and local boost controls should be:
>>
>> 1. Enabling global boost initially enables local boost on all policies, and
>> local boost can then be enabled or disabled individually on each policy,
>> given that the platform does support so.
>>
>> 2. Disabling global boost makes enabling local boost illegal, while writing
>> 0 to 'local_boost' is fine but takes no effect.
>>
>> A possible question could be: why not just limiting 'scaling_max_freq'?
>> Well, the fundamental difference is that 'local_boost' could be more
>> user-friendly.  When global boost is enabled, it is not straightforward to
>> figure out the base frequency for setting 'scaling_max_freq' to a non-boost
>> value. Also, this is supposed to take effect on the physical upper
>> frequency limit, reflected through 'cpuinfo_max_freq'.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
>> Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
>> ---
>>   drivers/cpufreq/cpufreq.c | 33 +++++++++++++++++++++++++++++++++
>>   include/linux/cpufreq.h   |  3 +++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index 6b52ebe5a890..14579c59f7ba 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -621,6 +621,35 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
>>   }
>>   define_one_global_rw(boost);
>>   
>> +static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%d\n", policy->local_boost_enabled);
>> +}
>> +
>> +static ssize_t store_local_boost(struct cpufreq_policy *policy,
>> +				 const char *buf, size_t count)
>> +{
>> +	int ret, enable;
>> +
>> +	ret = kstrtoint(buf, 10, &enable);
>> +	if (ret || enable < 0 || enable > 1)
>> +		return -EINVAL;
>> +
>> +	if (enable && !cpufreq_driver->boost_enabled)
>> +		return -EINVAL;
> Not just while enabling it, you should check for boost_enabled all the
> time.
>
> Also, you can optimize here if the state is being set to existing
> state and quit early. This is done in the case of global boost
> already. Have a look.
>
>> +
>> +	cpus_read_lock();
>> +	ret = cpufreq_driver->set_boost(policy, enable);
>> +	cpus_read_unlock();
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	policy->local_boost_enabled = enable;
> s/local_//
>
>> +
>> +	return count;
>> +}
>> +
>>   static struct cpufreq_governor *find_governor(const char *str_governor)
>>   {
>>   	struct cpufreq_governor *t;
>> @@ -931,6 +960,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
>>   cpufreq_freq_attr_rw(scaling_max_freq);
>>   cpufreq_freq_attr_rw(scaling_governor);
>>   cpufreq_freq_attr_rw(scaling_setspeed);
>> +cpufreq_freq_attr_rw(local_boost);
>>   
>>   static struct attribute *cpufreq_attrs[] = {
>>   	&cpuinfo_min_freq.attr,
>> @@ -944,6 +974,7 @@ static struct attribute *cpufreq_attrs[] = {
>>   	&scaling_driver.attr,
>>   	&scaling_available_governors.attr,
>>   	&scaling_setspeed.attr,
>> +	&local_boost.attr,
> Making this file available if the global boost file isn't present is a
> bit tricky I think. Maybe at least check for cpufreq_boost_supported()
> before doing so.
>
>>   	NULL
>>   };
>>   ATTRIBUTE_GROUPS(cpufreq);
>> @@ -2716,6 +2747,8 @@ int cpufreq_boost_trigger_state(int state)
>>   		ret = cpufreq_driver->set_boost(policy, state);
>>   		if (ret)
>>   			goto err_reset_state;
>> +
>> +		policy->local_boost_enabled = state;
>>   	}
>>   	cpus_read_unlock();
>>   
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 26e2eb399484..a99a48ac9fdb 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -140,6 +140,9 @@ struct cpufreq_policy {
>>   	 */
>>   	bool			dvfs_possible_from_any_cpu;
>>   
>> +	/* Per policy boost enabled flag. */
>> +	bool			local_boost_enabled;
>> +
>>   	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
>>   	unsigned int cached_target_freq;
>>   	unsigned int cached_resolved_idx;
>> -- 
>> 2.30.0

