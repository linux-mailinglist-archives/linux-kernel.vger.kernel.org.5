Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1482B78B061
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjH1McC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjH1Mbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:31:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2612E;
        Mon, 28 Aug 2023 05:31:14 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZ8x84hPZzVk1Q;
        Mon, 28 Aug 2023 20:28:44 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 28 Aug 2023 20:31:07 +0800
Message-ID: <b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com>
Date:   Mon, 28 Aug 2023 20:31:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: Fix inconsistency in error messages of
 cpufreq_resume/suspend()
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230826095201.1137288-1-liaochang1@huawei.com>
 <20230828070000.ooymfbw3qhs5xl5y@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230828070000.ooymfbw3qhs5xl5y@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Hi, Viresh

在 2023/8/28 15:00, Viresh Kumar 写道:
> On 26-08-23, 09:52, Liao Chang wrote:
>> The error message printed by cpufreq_resume() currently is the pointer
>> value of the policy structure, while the error message printed by
>> cpufreq_suspend() is the name of the driver. In order to make the error
>> messages more consistent and easier to understand, change the error
>> message printed by cpufreq_resume() to the name of driver.
> 
> Also I don't think printing kernel addresses will help much anyway,
> and it also may not be recommended.
> 
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
>> index c835ff117386..2199c04ac64d 100644
>> --- a/drivers/cpufreq/cpufreq.c
>> +++ b/drivers/cpufreq/cpufreq.c
>> @@ -1943,8 +1943,8 @@ void cpufreq_resume(void)
>>  
>>  	for_each_active_policy(policy) {
>>  		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
>> -			pr_err("%s: Failed to resume driver: %p\n", __func__,
>> -				policy);
>> +			pr_err("%s: Failed to resume driver: %s\n", __func__,
>> +				cpufreq_driver->name);
>>  		} else if (has_target()) {
>>  			down_write(&policy->rwsem);
>>  			ret = cpufreq_start_governor(policy);
> 
> There is another print down here which prints policy, please update
> that too in a similar way.

What about printing message like this below when cpufreq_start_governor() fails.

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..b78b509429a6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1943,16 +1943,16 @@ void cpufreq_resume(void)

                        if (ret)
-                               pr_err("%s: Failed to start governor for policy: %p\n",
-                                      __func__, policy);
+                               pr_err("%s: Failed to start governor for policy%u\n",
+                                      __func__, policy->cpu);
                }
        }
 }



> 

-- 
BR
Liao, Chang
