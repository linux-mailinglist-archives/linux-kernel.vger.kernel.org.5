Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2847B2FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjI2J7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjI2J7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:59:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C085199;
        Fri, 29 Sep 2023 02:59:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727841FB;
        Fri, 29 Sep 2023 03:00:25 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC5353F59C;
        Fri, 29 Sep 2023 02:59:44 -0700 (PDT)
Message-ID: <a3907ec0-7e20-e3a5-3814-476a25e1efaa@arm.com>
Date:   Fri, 29 Sep 2023 11:00:24 +0100
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
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iebSOT--AiP-9-CYwqtTe7+kRddryJ3DdvFb3WUeji7w@mail.gmail.com>
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



On 9/26/23 20:48, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> 
> First off, I would merge this with the previous patch, as the changes
> would be much clearer then IMO.

I was trying to avoid a big patch ~150 lines. I will do that merge.

> 
>> Add an interface which allows to modify EM power data at runtime.
>> The new power information is populated by the provided callback, which
>> is called for each performance state.
> 
> But it all starts with copying the frequencies from the default table.

Yes, I can add that to the description.

> 
>> The CPU frequencies' efficiency is
>> re-calculated since that might be affected as well. The old EM memory
>> is going to be freed later using RCU mechanism.
> 
> Not all of it, but the old runtime table that is not going to be used any more.

True, I will rephrase that, to make it more precised.

> 
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

[snip]

>>
>> +/**
>> + * em_dev_update_perf_domain() - Update runtime EM table for a device
>> + * @dev                : Device for which the EM is to be updated
>> + * @cb         : Callback function providing the power data for the EM
>> + * @priv       : Pointer to private data useful for passing context
>> + *             which might be required while calling @cb
> 
> It is still unclear to me who is going to use this priv pointer and how.

I have explained that in some previous patch response. A driver or
kernel module which monitors the thermal situation and has context.

> 
>> + *
>> + * Update EM runtime modifiable table for a @dev using the callback
>> + * defined in @cb. The EM new power values are then used for calculating
>> + * the em_perf_state::cost for associated performance state.
> 
> It actually allocates a new runtime table and populates it from
> scratch, using the frequencies from the default table and the
> callback.

Yes, it allocated new table and put the updated power values there.
I can add that to the comment.

> 
>> + *
>> + * This function uses mutex to serialize writers, so it must not be called
> 
> "a mutex"

ACK

> 
>> + * from non-sleeping context.

[snip]

>> +
>> +       if (!dev || !dev->em_pd) {
> 
> Checking dev against NULL under the mutex is pointless (either it is
> NULL or it isn't, so check it earlier).

ACK

> 
>> +               ret = -EINVAL;
>> +               goto unlock_em;
>> +       }
>> +
>> +       pd = dev->em_pd;
> 
> And I would check pd against NULL here.

It's done above, next to '!dev || !dev->em_pd'

> 
>> +
>> +       runtime_table = kzalloc(sizeof(*runtime_table), GFP_KERNEL);
>> +       if (!runtime_table) {
>> +               ret = -ENOMEM;
>> +               goto unlock_em;
>> +       }
>> +
>> +       runtime_table->state = kcalloc(pd->nr_perf_states,
>> +                                      sizeof(struct em_perf_state),
>> +                                      GFP_KERNEL);
>> +       if (!runtime_table->state) {
>> +               ret = -ENOMEM;
>> +               goto free_runtime_table;
>> +       }
> 
> The above allocations can be merged into one and allocating memory
> under the mutex is questionable.

So how to make sure that there is no 2 callers trying to update the
same EM or unregistration is not in the background?

[snip]

>>
>> @@ -501,9 +598,23 @@ void em_dev_unregister_perf_domain(struct device *dev)
>>
>>          runtime_table = pd->runtime_table;
>>
>> +       /*
>> +        * Safely destroy runtime modifiable EM. By using the call
>> +        * synchronize_rcu() we make sure we don't progress till last user
>> +        * finished the RCU section and our update got applied.
>> +        */
>>          rcu_assign_pointer(pd->runtime_table, NULL);
>>          synchronize_rcu();
>>
>> +       /*
>> +        * After the sync no updates will be in-flight, so free the
>> +        * memory allocated for runtime table (if there was such).
>> +        */
>> +       if (runtime_table != pd->default_table) {
>> +               kfree(runtime_table->state);
>> +               kfree(runtime_table);
>> +       }
> 
> Can't this race with the RCU callback freeing the runtime table?

That's why there is this 'synchronize_rcu()' above and the mutex. The
updating caller if finished the update, would unlock the mutex and this
unregister code can go. Here we call the synchronize_rcu() so we assure
the callback has finished for the update path and than we explicitly
free the saved 'runtime_table' here. So all data should be freed and
code serialized in those two paths.
