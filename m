Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF96D7B5435
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbjJBNnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjJBNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:43:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46CC4B0;
        Mon,  2 Oct 2023 06:43:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70AD2C15;
        Mon,  2 Oct 2023 06:44:04 -0700 (PDT)
Received: from [10.57.93.204] (unknown [10.57.93.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD7653F59C;
        Mon,  2 Oct 2023 06:43:23 -0700 (PDT)
Message-ID: <57078a6b-83bc-d558-1071-be23d213a56f@arm.com>
Date:   Mon, 2 Oct 2023 14:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
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
 <f7a6da56-93e4-0b7c-1746-bc3357bf8163@arm.com>
 <CAJZ5v0hBPD8cHJe-Xa8354SE5jdM1bYw94DjG-MVHsRKrUY=gQ@mail.gmail.com>
Content-Language: en-US
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0hBPD8cHJe-Xa8354SE5jdM1bYw94DjG-MVHsRKrUY=gQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 13:59, Rafael J. Wysocki wrote:
> On Fri, Sep 29, 2023 at 11:36 AM Lukasz Luba <lukasz.luba@arm.com> wrote:

[snip]

>> We had a few internal reviews and there were voices where saying that
>> it's better to have 2 identical tables: 'default_table' and
>> 'runtime_table' to make sure it's visible everywhere when it's used.
>> That made the need to actually have also the 'state' table inside.
>> I don't see it as a big problem, though.
> 
> What I'm trying to say is that you can allocate runtime_table along
> with the table pointed to by its state field in one invocation of
> kzalloc() (say).
> 
> Having just one memory region to free eventually instead of two of
> them would help to avoid some complexity, especially in the next
> patch.

I think, I know what you mean, basically:

------------------------------
struct em_perf_table {
	struct rcu_head rcu;
	struct em_perf_state state[];
}

kzalloc(sizeof(struct em_perf_table) + N * sizeof(struct em_perf_state))

------

IMO that should also be OK in the rest of places.
I agree the alloc/free code would be smaller.

Let me do that than.

> 
>>>
>>>> +}
>>>> +
>>>> +static void em_perf_runtime_table_set(struct device *dev,
>>>> +                                     struct em_perf_table *runtime_table)
>>>> +{
>>>> +       struct em_perf_domain *pd = dev->em_pd;
>>>> +       struct em_perf_table *tmp;
>>>> +
>>>> +       tmp = pd->runtime_table;
>>>> +
>>>> +       rcu_assign_pointer(pd->runtime_table, runtime_table);
>>>> +
>>>> +       em_cpufreq_update_efficiencies(dev, runtime_table->state);
>>>> +
>>>> +       /* Don't free default table since it's used by other frameworks. */
>>>
>>> Apparently, some frameworks are only going to use the default table
>>> while the runtime-updatable table will be used somewhere else at the
>>> same time.
>>>
>>> I'm not really sure if this is a good idea.
>>
>> Runtime table is only for driving the task placement in the EAS.
>>
>> The thermal gov IPA won't make better decisions because it already
>> has the mechanism to accumulate the error that it made.
>>
>> The same applies to DTPM, which works in a more 'configurable' way,
>> rather that hard optimization mechanism (like EAS).
> 
> My understanding of the above is that the other EM users don't really
> care that much so they can get away with using the default table all
> the time, but EAS needs more accuracy, so the table used by it needs
> to be adjusted in certain situations.

Yes

> 
> Fair enough, I'm assuming that you've done some research around it.
> Still, this is rather confusing.

Yes, I have presented those ~2y ago in Android Gerrit world
(got feedback from a few vendors) and in a few Linux conferences.

For now we don't plan to have this feature for the thermal
governor or something similar.

> 
>>>
>>>> +       if (tmp != pd->default_table)
>>>> +               call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
>>
>> The em_destroy_rt_table_rcu() is used here ^^^^^^
