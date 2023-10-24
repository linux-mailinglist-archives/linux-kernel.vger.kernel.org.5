Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1CF7D4962
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjJXIJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjJXIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:09:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47EC699;
        Tue, 24 Oct 2023 01:09:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E43E82F4;
        Tue, 24 Oct 2023 01:09:41 -0700 (PDT)
Received: from [10.57.83.179] (unknown [10.57.83.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCC823F762;
        Tue, 24 Oct 2023 01:08:58 -0700 (PDT)
Message-ID: <b68e15d1-87b0-4a60-8f09-3d8856c16919@arm.com>
Date:   Tue, 24 Oct 2023 09:09:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/18] PM: EM: Refactor em_pd_get_efficient_state() to
 be more flexible
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-5-lukasz.luba@arm.com>
 <6786c91e-12ce-a9dd-12fe-bc02c6d782b8@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <6786c91e-12ce-a9dd-12fe-bc02c6d782b8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 18:39, Daniel Lezcano wrote:
> On 25/09/2023 10:11, Lukasz Luba wrote:
>> The Energy Model (EM) is going to support runtime modification. There
>> are going to be 2 EM tables which store information. This patch aims
>> to prepare the code to be generic and use one of the tables. The function
>> will no longer get a pointer to 'struct em_perf_domain' (the EM) but
>> instead a pointer to 'struct em_perf_state' (which is one of the EM's
>> tables).
>>
>> Prepare em_pd_get_efficient_state() for the upcoming changes and
>> make it possible to re-use. Return an index for the best performance
>> state for a given EM table. The function arguments that are introduced
>> should allow to work on different performance state arrays. The caller of
>> em_pd_get_efficient_state() should be able to use the index either
>> on the default or the modifiable EM table.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
> 
> [ ... ]
> 
>> @@ -251,7 +253,9 @@ static inline unsigned long em_cpu_energy(struct 
>> em_perf_domain *pd,
>>        * Find the lowest performance state of the Energy Model above the
>>        * requested frequency.
>>        */
>> -    ps = em_pd_get_efficient_state(pd, freq);
>> +    i = em_pd_get_efficient_state(pd->table, pd->nr_perf_states, freq,
>> +                      pd->flags);
> 
> nitpicking but s/i/state/

Here it makes sense, I'll try to use 'state', but if that could be a bit
odd in later patches code, where I have:

ps = &runtime_table->state[i];

than:

'->state[state]'

won't fly. Although, let me check, because I'm going to drop the
2 tables design so some fields might get different names.

> 
> Other than that:
> 
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks!

> 
> 
>> +    ps = &pd->table[i];
>>       /*
>>        * The capacity of a CPU in the domain at the performance state 
>> (ps)
> 
