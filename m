Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DC78A8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjH1J3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjH1J3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:29:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836B9E;
        Mon, 28 Aug 2023 02:29:07 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RZ4sR3p4KzhZHm;
        Mon, 28 Aug 2023 17:25:15 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Mon, 28 Aug 2023 17:29:04 +0800
Message-ID: <6583cf83-3598-7b7c-4753-611951c5d09b@huawei.com>
Date:   Mon, 28 Aug 2023 17:29:04 +0800
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
 <bcac1b3c-a2f7-7f18-4c2f-5cf27f4e89b5@huawei.com>
 <20230828085248.sz6aljr5aln7j435@vireshk-i7>
From:   "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20230828085248.sz6aljr5aln7j435@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/28 16:52, Viresh Kumar 写道:
> On 28-08-23, 16:29, Liao, Chang wrote:
>> Task B does not necessarily go to sleep when it calls wait_event(), it depends on
>> the condition to wait for evaluate false or not. So there is a small race window
>> where Task A already set 'transition_ongoing' to false and Task B can cross wait_event()
>> immediately.
>>
>> wait_event:
>> do {
>> 	might_sleep();
>> 	if (condition) // !transition_ongoing
>> 		break;
>> 	__wait_event();
>> };
>>
>> I hope I do not miss something important in the code above.
>  
>> Yes, if the CPU uses weak memroy model, it is possible for the instructions to be reordered.
>> therefore, it is a good idea to insert an smb() between these two lines if there is race here.
> 
> Maybe it would be better to do this instead ?
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6b52ebe5a890..f11b01b25e8d 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -455,8 +455,10 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
>                             policy->cur,
>                             policy->cpuinfo.max_freq);
> 
> +       spin_lock(&policy->transition_lock);
>         policy->transition_ongoing = false;
>         policy->transition_task = NULL;
> +       spin_unlock(&policy->transition_lock);

I think it is more straightforward, I will use it in next revision.

Thanks.

> 
>         wake_up(&policy->transition_wait);
>  }
> 

-- 
BR
Liao, Chang
