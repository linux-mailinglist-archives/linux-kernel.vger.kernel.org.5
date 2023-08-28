Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2A478A66A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjH1HZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjH1HZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:25:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92539F1;
        Mon, 28 Aug 2023 00:25:21 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZ26t47s2zNnHV;
        Mon, 28 Aug 2023 15:21:42 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 28 Aug 2023 15:25:18 +0800
Message-ID: <0c50a3da-65e2-eb91-95ea-6a2ca825c16d@huawei.com>
Date:   Mon, 28 Aug 2023 15:25:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] cpufreq: governor: Free dbs_data directly when
 gov->init() fails
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <rafael@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230826012415.1126955-1-liaochang1@huawei.com>
 <20230828065625.ufp66goznd72rcyh@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230828065625.ufp66goznd72rcyh@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh.

在 2023/8/28 14:56, Viresh Kumar 写道:
> On 26-08-23, 01:24, Liao Chang wrote:
>> Due to the kobject embedded in the dbs_data doest not has a release()
>> method yet, it needs to use kfree() to free dbs_data directly when
>> governor fails to allocate the tunner field of dbs_data.
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
>> index 85da677c43d6..6e1ac864e87e 100644
>> --- a/drivers/cpufreq/cpufreq_governor.c
>> +++ b/drivers/cpufreq/cpufreq_governor.c
>> @@ -438,8 +438,10 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>>  	gov_attr_set_init(&dbs_data->attr_set, &policy_dbs->list);
>>  
>>  	ret = gov->init(dbs_data);
>> -	if (ret)
>> +	if (ret) {
>> +		kfree(dbs_data);
>>  		goto free_policy_dbs_info;
>> +	}
> 
> What about this instead ?
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> index 85da677c43d6..af44ee6a6430 100644
> --- a/drivers/cpufreq/cpufreq_governor.c
> +++ b/drivers/cpufreq/cpufreq_governor.c
> @@ -439,7 +439,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> 
>         ret = gov->init(dbs_data);
>         if (ret)
> -               goto free_policy_dbs_info;
> +               goto free_dbs_data;
> 
>         /*
>          * The sampling interval should not be less than the transition latency
> @@ -474,6 +474,8 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
>         if (!have_governor_per_policy())
>                 gov->gdbs_data = NULL;
>         gov->exit(dbs_data);
> +
> +free_dbs_data:
>         kfree(dbs_data);

Sure, less copy-and-paste code is better :)

Do you mind I copy above code in next revision?

Thanks.

> 
>  free_policy_dbs_info:
> 

-- 
BR
Liao, Chang
