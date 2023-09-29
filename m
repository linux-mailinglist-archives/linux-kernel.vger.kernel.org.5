Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B4A7B2E53
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjI2IpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjI2Ion (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:44:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB83510DE;
        Fri, 29 Sep 2023 01:44:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02282DA7;
        Fri, 29 Sep 2023 01:45:04 -0700 (PDT)
Received: from [10.57.93.169] (unknown [10.57.93.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD9F3F5A1;
        Fri, 29 Sep 2023 01:44:23 -0700 (PDT)
Message-ID: <7e2e64d7-4b10-8d58-03c9-e5a5129f864e@arm.com>
Date:   Fri, 29 Sep 2023 09:45:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 07/18] PM: EM: Refactor struct em_perf_domain and add
 default_table
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-8-lukasz.luba@arm.com>
 <CAJZ5v0iYkVKuVULv9X7EKpC9feh8UPf8S2ZnY+X+1tyOYn0ing@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iYkVKuVULv9X7EKpC9feh8UPf8S2ZnY+X+1tyOYn0ing@mail.gmail.com>
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



On 9/26/23 19:52, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 10:11 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> The Energy Model is going to support runtime modifications. Refactor old
>> implementation which accessed struct em_perf_state and introduce
>> em_perf_domain::default_table to clean up the design. This new field
>> will help to better distinguish 2 performance state tables.
>>
>> Update all drivers or frameworks which used the old field:
>> em_perf_domain::table and now should use em_perf_domain::default_table.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>

[snip]

>> diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
>> index 8069f526c9d8..d236e08e80dc 100644
>> --- a/include/linux/energy_model.h
>> +++ b/include/linux/energy_model.h
>> @@ -36,9 +36,19 @@ struct em_perf_state {
>>    */
>>   #define EM_PERF_STATE_INEFFICIENT BIT(0)
>>
>> +/**
>> + * struct em_perf_table - Performance states table
>> + * @state:     List of performance states, in ascending order
>> + * @rcu:       RCU used for safe access and destruction
>> + */
>> +struct em_perf_table {
>> +       struct em_perf_state *state;
>> +       struct rcu_head rcu;
> 
> There is no explanation of the role of this rcu_head in the changelog
> or anywhere in this patch.
> 
> It is also not used as of this patch AFAICS.
> 
> It would be better to add it when it actually gets used IMV.

That's a good point. I will introduce this 'rcu' field later.
