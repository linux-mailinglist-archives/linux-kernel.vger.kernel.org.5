Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FD47BA78F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjJERQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjJERPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:15:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475FA3AB4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:07:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEEFBC15;
        Thu,  5 Oct 2023 10:08:02 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01E193F5A1;
        Thu,  5 Oct 2023 10:07:20 -0700 (PDT)
Message-ID: <331b165a-f650-37fd-7990-2704c668f6f2@arm.com>
Date:   Thu, 5 Oct 2023 18:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 12/24] x86/resctrl: Add cpumask_any_housekeeping() for
 limbo/overflow
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-13-james.morse@arm.com>
 <cc656e8e-e652-baf9-7724-4507a9f7786d@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <cc656e8e-e652-baf9-7724-4507a9f7786d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 03/10/2023 22:15, Reinette Chatre wrote:
> On 9/14/2023 10:21 AM, James Morse wrote:
>> The limbo and overflow code picks a CPU to use from the domain's list
>> of online CPUs. Work is then scheduled on these CPUs to maintain
>> the limbo list and any counters that may overflow.
>>
>> cpumask_any() may pick a CPU that is marked nohz_full, which will
>> either penalise the work that CPU was dedicated to, or delay the
>> processing of limbo list or counters that may overflow. Perhaps
>> indefinitely. Delaying the overflow handling will skew the bandwidth
>> values calculated by mba_sc, which expects to be called once a second.
>>
>> Add cpumask_any_housekeeping() as a replacement for cpumask_any()
>> that prefers housekeeping CPUs. This helper will still return
>> a nohz_full CPU if that is the only option. The CPU to use is
>> re-evaluated each time the limbo/overflow work runs. This ensures
>> the work will move off a nohz_full CPU once a housekeeping CPU is
>> available.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index 0bbed8c62d42..993837e46db1 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -793,8 +793,10 @@ void cqm_handle_limbo(struct work_struct *work)
>>  
>>  	__check_limbo(d, false);
>>  
>> -	if (has_busy_rmid(d))
>> +	if (has_busy_rmid(d)) {
>> +		cpu = cpumask_any_housekeeping(&d->cpu_mask);
>>  		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
>> +	}
>>  
> 
> ok - but if you do change the CPU the worker is running on then
> I also expect d->cqm_work_cpu to be updated. Otherwise the offline
> code will not be able to determine if the worker needs to move.

Good point - I missed this.


Thanks,

James
