Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE237B2F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjI2JgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjI2JgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:36:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D80991A8;
        Fri, 29 Sep 2023 02:36:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7E81FB;
        Fri, 29 Sep 2023 02:36:40 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 002593F5A1;
        Fri, 29 Sep 2023 02:35:59 -0700 (PDT)
Message-ID: <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com>
Date:   Fri, 29 Sep 2023 10:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-11-lukasz.luba@arm.com>
 <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g6jPr3LqTuRfwUWsK4em7F1pfsZDn9pVziyu3tV56m8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/23 20:26, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The EM is going to support runtime modifications of the power data.
>> Introduce RCU safe mechanism to clean up the old allocated EM data.
> 
> "RCU-based" probably and "to clean up the old EM data safely".

Yes, thanks

> 
>> It also adds a mutex for the EM structure to serialize the modifiers.
> 
> This part doesn't match the code changes in the patch.

Good catch. It left from some older version. We use the existing
em_pd_mutex.

> 
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 5b40db38b745..2345837bfd2c 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -23,6 +23,9 @@
>>    */
>>   static DEFINE_MUTEX(em_pd_mutex);
>>
>> +static void em_cpufreq_update_efficiencies(struct device *dev,
>> +                                          struct em_perf_state *table);
>> +
>>   static bool _is_cpu_device(struct device *dev)
>>   {
>>          return (dev->bus == &cpu_subsys);
>> @@ -104,6 +107,32 @@ static void em_debug_create_pd(struct device *dev) {}
>>   static void em_debug_remove_pd(struct device *dev) {}
>>   #endif
>>
>> +static void em_destroy_rt_table_rcu(struct rcu_head *rp)
> 
> Adding static functions without callers will obviously cause the
> compiler to complain, which is one of the reasons to avoid doing that.
> The other is that it is hard to say how these functions are going to
> be used without reviewing multiple patches simultaneously, which is a
> pain as far as I'm concerned.

It is used in this patch, but inside the call_rcu() as 2nd arg.
I have marked that below. The compiler didn't complain IIRC.

> 
>> +{
>> +       struct em_perf_table *runtime_table;
>> +
>> +       runtime_table = container_of(rp, struct em_perf_table, rcu);
>> +       kfree(runtime_table->state);
>> +       kfree(runtime_table);
> 
> If runtime_table and its state were allocated in one go, it would be
> possible to free them in one go either.
> 
> For some reason, you don't seem to want to do that, but why?

We had a few internal reviews and there were voices where saying that
it's better to have 2 identical tables: 'default_table' and
'runtime_table' to make sure it's visible everywhere when it's used.
That made the need to actually have also the 'state' table inside.
I don't see it as a big problem, though.

> 
>> +}
>> +
>> +static void em_perf_runtime_table_set(struct device *dev,
>> +                                     struct em_perf_table *runtime_table)
>> +{
>> +       struct em_perf_domain *pd = dev->em_pd;
>> +       struct em_perf_table *tmp;
>> +
>> +       tmp = pd->runtime_table;
>> +
>> +       rcu_assign_pointer(pd->runtime_table, runtime_table);
>> +
>> +       em_cpufreq_update_efficiencies(dev, runtime_table->state);
>> +
>> +       /* Don't free default table since it's used by other frameworks. */
> 
> Apparently, some frameworks are only going to use the default table
> while the runtime-updatable table will be used somewhere else at the
> same time.
> 
> I'm not really sure if this is a good idea.

Runtime table is only for driving the task placement in the EAS.

The thermal gov IPA won't make better decisions because it already
has the mechanism to accumulate the error that it made.

The same applies to DTPM, which works in a more 'configurable' way,
rather that hard optimization mechanism (like EAS).

> 
>> +       if (tmp != pd->default_table)
>> +               call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);

The em_destroy_rt_table_rcu() is used here ^^^^^^
