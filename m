Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575DA7B546D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbjJBOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjJBOJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:09:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A706E9B;
        Mon,  2 Oct 2023 07:09:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2718C15;
        Mon,  2 Oct 2023 07:09:55 -0700 (PDT)
Received: from [10.57.93.204] (unknown [10.57.93.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 172413F762;
        Mon,  2 Oct 2023 07:09:14 -0700 (PDT)
Message-ID: <91d6e9be-d50c-d157-55a0-79134cbd01fb@arm.com>
Date:   Mon, 2 Oct 2023 15:09:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 11/18] PM: EM: Add runtime update interface to modify
 EM power
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-12-lukasz.luba@arm.com>
 <CAJZ5v0iebSOT--AiP-9-CYwqtTe7+kRddryJ3DdvFb3WUeji7w@mail.gmail.com>
 <a3907ec0-7e20-e3a5-3814-476a25e1efaa@arm.com>
 <CAJZ5v0jU1SZ5kPHYqM3DLGY9j8DgGp7XCciyy=fJAyHnkyGgtA@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0jU1SZ5kPHYqM3DLGY9j8DgGp7XCciyy=fJAyHnkyGgtA@mail.gmail.com>
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



On 9/29/23 14:18, Rafael J. Wysocki wrote:
> On Fri, Sep 29, 2023 at 11:59 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>

[snip]

>>
>> It's done above, next to '!dev || !dev->em_pd'
> 
> Yes, it is, I meant something like this:
> 
>      if (!cb || !cb->update_power || !dev)
>          return -EINVAL;
> 
>      mutex_lock(&em_pd_mutex);
> 
>      pd = dev->em_pd;
>      if (!pd) {
>          ret = -EINVAL; /* or perhaps -ENODATA */
>          goto unlock_em;
>      }
> 
> 

OK, I see what you mean. Let me change that.

>>>
>>>> +
>>>> +       runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
>>>> +       if (!runtime_table) {
>>>> +               ret = -ENOMEM;
>>>> +               goto unlock_em;
>>>> +       }
>>>> +
>>>> +       runtime_table->state = kcalloc(pd->nr_perf_states,
>>>> +                                      sizeof(struct em_perf_state),
>>>> +                                      GFP_KERNEL);
>>>> +       if (!runtime_table->state) {
>>>> +               ret = -ENOMEM;
>>>> +               goto free_runtime_table;
>>>> +       }
>>>
>>> The above allocations can be merged into one and allocating memory
>>> under the mutex is questionable.
>>
>> So how to make sure that there is no 2 callers trying to update the
>> same EM or unregistration is not in the background?
> 
> You can allocate memory upfront and take the mutex before accessing
> the shared data structures.  If there's an error in the code running
> under the mutex, release it and then free the memory.
> 
> Allocating memory is one operation, updating the shared data
> structures to use it is another one.  The former doesn't affect the
> shared state in any way, so why do it under the mutex?

Yes, make sense. I will shrink that critical section. Good catch,
thanks!

> 
>> [snip]
>>
>>>>
>>>> @@ -501,9 +598,23 @@ void em_dev_unregister_perf_domain(struct device *dev)
>>>>
>>>>           runtime_table = pd->runtime_table;
>>>>
>>>> +       /*
>>>> +        * Safely destroy runtime modifiable EM. By using the call
>>>> +        * synchronize_rcu() we make sure we don't progress till last user
>>>> +        * finished the RCU section and our update got applied.
>>>> +        */
>>>>           rcu_assign_pointer(pd->runtime_table, NULL);
>>>>           synchronize_rcu();
>>>>
>>>> +       /*
>>>> +        * After the sync no updates will be in-flight, so free the
>>>> +        * memory allocated for runtime table (if there was such).
>>>> +        */
>>>> +       if (runtime_table != pd->default_table) {
>>>> +               kfree(runtime_table->state);
>>>> +               kfree(runtime_table);
>>>> +       }
>>>
>>> Can't this race with the RCU callback freeing the runtime table?
>>
>> That's why there is this 'synchronize_rcu()' above and the mutex. The
>> updating caller if finished the update, would unlock the mutex and this
>> unregister code can go. Here we call the synchronize_rcu() so we assure
>> the callback has finished for the update path and than we explicitly
>> free the saved 'runtime_table' here. So all data should be freed and
>> code serialized in those two paths.
> 
> This doesn't quite agree with my understanding of what synchronize_rcu() does.
> 
> IIUC, RCU callbacks can run as soon as the grace period has elapsed
> and they need not wait for synchronize_rcu() to return.  Conversely,
> synchronize_rcu() doesn't wait for all of the RCU callbacks to
> complete.
> 
> Now, em_destroy_rt_table_rcu() doesn't actually use the mutex, so how
> exactly is it protected against racing with this code?


I'll try to draw in on some pictures...

(previous instance )
+---------------------+
|                     |
| runtime table    #1 |
|                     |
+---------------------+


(next instance )
+---------------------+
|                     |
| runtime table    #2 |
|                     |
+---------------------+


(not possible new instance)
+.....................+
.                     .
. runtime table    #3 .
.                     .
+.....................+



    cpu A - "updater"          |    cpu B - "remover"
                               |
------------------------------|------------------------------
    lock em_pd_mutex           |
                               |
       alloc runtime table #2  |   lock em_pd_mutex
                               |   (waiting)
       async free instance #1  |    .
                               |    .
    unlock em_pd_mutex         |    .
                               |   (enter critical section)
                               |
    lock em_pd_mutex           |   set NULL to runtime table ptr
    (waiting)                  |
    (wanted to create #3 inst) |   synchronize rcu to make it is visible
    .                          |
    .                          |   implicit free instance #2
    .                          |
    .                          |   free the rest of EM and EM
    .                          |
    .                          |   unlock em_pd_mutex
    (enter critical section)   |
    !dev->em_pd so             |
    unlock & exit              |
                               |
                               |


This should clean all involved memory and also prevent
of allocating new instance, when we unregister EM.
