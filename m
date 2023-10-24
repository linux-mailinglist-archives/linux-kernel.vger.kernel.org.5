Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED17D499A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjJXINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjJXINb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:13:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6EF2D7B;
        Tue, 24 Oct 2023 01:13:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57E552F4;
        Tue, 24 Oct 2023 01:14:09 -0700 (PDT)
Received: from [10.57.83.179] (unknown [10.57.83.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9DF3F762;
        Tue, 24 Oct 2023 01:13:26 -0700 (PDT)
Message-ID: <2ed209ec-2eef-4a41-9591-275e7d8f7676@arm.com>
Date:   Tue, 24 Oct 2023 09:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/18] PM: EM: Check if the get_cost() callback is
 present in em_compute_costs()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     dietmar.eggemann@arm.com, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, amit.kucheria@verdurent.com,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com, linux-pm@vger.kernel.org,
        rafael@kernel.org
References: <20230925081139.1305766-1-lukasz.luba@arm.com>
 <20230925081139.1305766-7-lukasz.luba@arm.com>
 <3a70280b-8cc4-9f22-92b7-088fa9cb45df@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <3a70280b-8cc4-9f22-92b7-088fa9cb45df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/23/23 19:23, Daniel Lezcano wrote:
> On 25/09/2023 10:11, Lukasz Luba wrote:
>> The em_compute_cost() is going to be re-used in runtime modified EM
>> code path. Thus, make sure that this common code is safe and won't
>> try to use the NULL pointer. The former em_compute_cost() didn't have to
>> care about runtime modification code path. The upcoming changes introduce
>> such option, but with different callback. Those two paths which use
>> get_cost() (during first EM registration) or update_power() (during
>> runtime modification) need to be safely handled in em_compute_costs().
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   kernel/power/energy_model.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
>> index 7ea882401833..35e07933b34a 100644
>> --- a/kernel/power/energy_model.c
>> +++ b/kernel/power/energy_model.c
>> @@ -116,7 +116,7 @@ static int em_compute_costs(struct device *dev, 
>> struct em_perf_state *table,
>>       for (i = nr_states - 1; i >= 0; i--) {
>>           unsigned long power_res, cost;
>> -        if (flags & EM_PERF_DOMAIN_ARTIFICIAL) {
>> +        if (flags & EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost) {
>>               ret = cb->get_cost(dev, table[i].frequency, &cost);
>>               if (ret || !cost || cost > EM_MAX_POWER) {
>>                   dev_err(dev, "EM: invalid cost %lu %d\n",
> 
> I do believe & operator has lower precedence than && operator, thus the 
> test is actually:
> 
>      (flags & (EM_PERF_DOMAIN_ARTIFICIAL && cb->get_cost))
> 
> but it should be
> 
>      ((flags & EM_PERF_DOMAIN_ARTIFICIAL) && cb->get_cost)
> 
> Right ?
> 

The bitwise '&' is stronger than logical '&&', so the code will
work as in your 2nd example. Although, I will change it and add
parentheses for better reading.

Thanks!
