Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37257AB469
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjIVPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbjIVPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:03:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DCF7DC6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:03:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF4CDDA7;
        Fri, 22 Sep 2023 08:04:20 -0700 (PDT)
Received: from [10.34.100.121] (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49BD13F5A1;
        Fri, 22 Sep 2023 08:03:42 -0700 (PDT)
Message-ID: <2a3c2cf0-44e3-befd-c7b5-d3c1fafbf2cd@arm.com>
Date:   Fri, 22 Sep 2023 17:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Lu, Aaron" <aaron.lu@intel.com>
Cc:     "tj@kernel.org" <tj@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "longman@redhat.com" <longman@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
References: <20230804090858.7605-1-rui.zhang@intel.com>
 <20230814031432.GA574314@ziqianlu-dell>
 <cb305abedea24980c93ce2b436e64039d3796812.camel@intel.com>
 <b886a9af-6c90-c12a-f700-1a9141e25e7a@arm.com>
 <20230911114218.GA334545@ziqianlu-dell>
 <0d1c440becca151db3f3b05b3fb2c63fe69c2904.camel@intel.com>
 <c8baa176-e4cd-41f6-35a9-c69f89b32e79@arm.com>
 <a2a16c0e198a6d722b8923b0eec15dd2b32e4320.camel@intel.com>
 <ea8da512-73df-59ed-6c47-912dd9ef9dba@arm.com>
 <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <0a0ff05cd1ef629cfa0a4c9392f499459fe814e7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 9/20/23 09:24, Zhang, Rui wrote:
> Hi, Pierre,
> 
> Sorry for the late response. I'm still ramping up on the related code.

No worries, I also need to read the code,

> 
> On Thu, 2023-09-14 at 16:53 +0200, Pierre Gondois wrote:
>>
>>
>> On 9/14/23 11:23, Zhang, Rui wrote:
>>> Hi, Pierre,
>>>
>>>>
>>>> Yes right indeed,
>>>> This happens when putting a CPU offline (as you mentioned
>>>> earlier,
>>>> putting a CPU offline clears the CPU in the idle_cpus_mask).
>>>>
>>>> The load balancing related variables
>>>
>>> including?
>>
>> I meant the nohz idle variables in the load balancing, so I was
>> referring to:
>> (struct sched_domain_shared).nr_busy_cpus
>> (struct sched_domain).nohz_idle
>> nohz.idle_cpus_mask
>> nohz.nr_cpus
>> (struct rq).nohz_tick_stopped
> 
> IMO, the problem is that, for an isolated CPU,
> 1. it is not an idle cpu (nohz.idle_cpus_mask should be cleared)
> 2. it is not a busy cpu (sds->nr_busy_cpus should be decreased)
> 
> But current code does not have a third state to describe this, so we
> need to either
> 1. add extra logic, like on_null_domain() checks

I m not sure I understand, do you mean adding on_null_domain() in addition
to the one in the present patch ?

> or
> 2. rely on current logic, but update all related variables correctly,
> like you proposed.
> 
> But in any case, we should stick with one direction.
> 
> If we follow the first one, the original patch should be used, which
> IMO is simple and straight forward.
> If we follow the later one, we'd better audit and remove the current
> on_null_domain() usage at the same time. TBH, I'm not confident enough

Here aswell, I'm not sure I understand whether you are referring to
the on_null_domain() call in the present patch or to the on_null_domain()
calls in fair.c ?

Regards,
Pierre

> to make such a change. But if you want to propose something, I'd glad
> to test it.
> 
> thanks,
> rui
> 
