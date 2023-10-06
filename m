Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81A97BB2C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjJFIDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJFIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:03:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 762DECA;
        Fri,  6 Oct 2023 01:03:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46EE7C15;
        Fri,  6 Oct 2023 01:03:43 -0700 (PDT)
Received: from [10.57.94.224] (unknown [10.57.94.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04E863F762;
        Fri,  6 Oct 2023 01:03:01 -0700 (PDT)
Message-ID: <e0eeb507-9d56-650d-bd49-6b3ca41b4d8e@arm.com>
Date:   Fri, 6 Oct 2023 09:03:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 09/18] PM: EM: Introduce runtime modifiable table
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-10-lukasz.luba@arm.com>
 <CAJZ5v0gxjJRoZpGjs4qWy_CQbwnztgrQxHJpffdFHeEL7ikbYQ@mail.gmail.com>
 <e1b36a7b-0524-0559-7ae1-801bdda91e60@arm.com>
 <CAJZ5v0g1MYxABDEYJxjveWALV6yecuV1=Ly6REkR4eb1kS-cUA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g1MYxABDEYJxjveWALV6yecuV1=Ly6REkR4eb1kS-cUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 13:27, Rafael J. Wysocki wrote:
> On Fri, Sep 29, 2023 at 11:15 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>

[snip]

>>>>           em_debug_remove_pd(dev);
>>>>
>>>> +       runtime_table = pd->runtime_table;
>>>> +
>>>> +       rcu_assign_pointer(pd->runtime_table, NULL);
>>>> +       synchronize_rcu();
>>>
>>> Is it really a good idea to call this under a mutex?
>>
>> This is the unregistration of the EM code path, so a thermal
>> driver which gets some IRQs might not be aware that the EM
>> is going to vanish. That's why those two code paths: update
>> & unregister are protected with the same lock.
>>
>> This synchronize_rcu() won't be long,
> 
> Are you sure?  This potentially waits for all of the CPUs in the
> system to go through a quiescent state which may take a while in
> principle.
> 
> In any case, though, this effectively makes everyone waiting for the
> mutex also wait for the grace period to elapse and they may not care
> about it.

My apologies for the delay, I had to check this. Yes, should be possible
and safe to not wait here as you described on this synchronize_rcu().

What I have drawn in other response to patch 11/18 [1] should still be
true.

Thanks, I will remove this sync call from here.

> 
>> but makes sure that when we free(dev->em_pd) we don't leak runtime_table.
>>
>>>
>>>> +
>>>>           kfree(pd->default_table->state);
>>>>           kfree(pd->default_table);
>>>>           kfree(dev->em_pd);
>>>> +
>>>
>>> Unrelated change.
>>
>> ACK
>>
>>>
>>>>           dev->em_pd = NULL;
>>>>           mutex_unlock(&em_pd_mutex);
>>>>    }
>>>> --
>>>
>>> So this really adds a pointer to a table that can be dynamically
>>> updated to struct em_perf_domain without any users so far.  It is not
>>> used anywhere as of this patch AFAICS, which is not what the changelog
>>> is saying.
>>
>> Good catch. I will adjust the changlog in header and say:
>>
>> 'Add infrastructure and mechanisms for the new runtime table.
>> The runtime modifiable EM data is used by the Energy Aware Scheduler
>> (EAS)for the task placement.
> 
> I would make it more clear that this is going to happen after some
> other subsequent changes.
> 

OK, I will add that information too.

[1] 
https://lore.kernel.org/lkml/91d6e9be-d50c-d157-55a0-79134cbd01fb@arm.com/
