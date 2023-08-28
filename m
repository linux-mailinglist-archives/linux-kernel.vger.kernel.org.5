Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A8378A7AE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjH1I3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjH1I3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:29:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC4F9C;
        Mon, 28 Aug 2023 01:29:07 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZ3XQ5zYfzNnKb;
        Mon, 28 Aug 2023 16:25:26 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 28 Aug 2023 16:29:03 +0800
Message-ID: <bcac1b3c-a2f7-7f18-4c2f-5cf27f4e89b5@huawei.com>
Date:   Mon, 28 Aug 2023 16:29:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: Fix the race condition while updating the
 transition_task of policy
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <srivatsa.bhat@linux.vnet.ibm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230826095836.1138608-1-liaochang1@huawei.com>
 <20230828072347.ly23mbptu3yw4zkv@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230828072347.ly23mbptu3yw4zkv@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh.

在 2023/8/28 15:23, Viresh Kumar 写道:
> On 26-08-23, 09:58, Liao Chang wrote:
>> The field 'transition_task' of policy structure is used to track the
>> task which is performing the frequency transition. Using this field to
>> print a warning once detect a case where the same task is calling
>> _begin() again before completing the preivous frequency transition via
>> the _end().
>>
>> However, there is a potential race condition in _end() and _begin() APIs
>> while updating the field 'transition_task' of policy, the scenario is
>> depicted below:
>>
>>              Task A                            Task B
>>
>>         /* 1st freq transition */
>>         Invoke _begin() {
>>                 ...
>>                 ...
>>         }
>>                                         /* 2nd freq transition */
>>                                         Invoke _begin() {
>>                                                 ... //waiting for A to
>>                                                 ... //clear
>>                                                 ... //transition_ongoing
>>                                                 ... //in _end() for
>>                                                 ... //the 1st transition
>>                                                         |
>>         Change the frequency                            |
>>                                                         |
>>         Invoke _end() {                                 |
>>                 ...                                     |
>>                 ...                                     |
>>                 transition_ongoing = false;             V
>>                                                 transition_ongoing = true;
>>                                                 transition_task = current;
> 
> Task B here won't move ahead until "wake_up(&policy->transition_wait)"
> is called, isn't it ?

Task B does not necessarily go to sleep when it calls wait_event(), it depends on
the condition to wait for evaluate false or not. So there is a small race window
where Task A already set 'transition_ongoing' to false and Task B can cross wait_event()
immediately.

wait_event:
do {
	might_sleep();
	if (condition) // !transition_ongoing
		break;
	__wait_event();
};

I hope I do not miss something important in the code above.

> 
> Also I think the CPU is free to change the order of the two
> instructions and so this commit won't make a difference. Also I don't

Yes, if the CPU uses weak memroy model, it is possible for the instructions to be reordered.
therefore, it is a good idea to insert an smb() between these two lines if there is race here.

Thanks.

> feel there is a race here as wake_up() hasn't happened.
> 
>>                 transition_task = NULL;
>>                 ... //A overwrites the task
>>                 ... //performing the transition
>>                 ... //result in error warning.
>>         }
>>
>> To fix this race condition, the order of the updates to the
>> 'transition_task' and 'transition_ongoing' fields has been changed, the
>> 'transition_task' field is now cleared before the 'transition_ongoing'
>> field, which ensure that only one task can update the 'transition_task'
>> field at a time.
>>
>> Fixes: ca654dc3a93d ("cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end")
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index a757f90aa9d6..f8eb6dde57f2 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -455,8 +455,8 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>>  			    policy->cur,
>>  			    policy->cpuinfo.max_freq);
>>  
>> -	policy->transition_ongoing = false;
>>  	policy->transition_task = NULL;
>> +	policy->transition_ongoing = false;
>>  
>>  	wake_up(&policy->transition_wait);
>>  }
>> -- 
>> 2.34.1
> 

-- 
BR
Liao, Chang
