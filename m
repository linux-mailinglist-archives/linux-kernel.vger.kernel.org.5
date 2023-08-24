Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E148A787638
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242823AbjHXQ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242887AbjHXQ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:58:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB4681BC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:57:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EB451042;
        Thu, 24 Aug 2023 09:58:35 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A50A33F64C;
        Thu, 24 Aug 2023 09:57:52 -0700 (PDT)
Message-ID: <9fca4876-01f4-6a84-2dc6-d92458d3b72c@arm.com>
Date:   Thu, 24 Aug 2023 17:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 21/24] x86/resctrl: Allow overflow/limbo handlers to be
 scheduled on any-but cpu
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-22-james.morse@arm.com>
 <b8103525-83d7-b8f1-105a-178625b89da4@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <b8103525-83d7-b8f1-105a-178625b89da4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/08/2023 23:38, Reinette Chatre wrote:
> On 7/28/2023 9:42 AM, James Morse wrote:
>> When a CPU is taken offline resctrl may need to move the overflow or
>> limbo handlers to run on a different CPU.
>>
>> Once the offline callbacks have been split, cqm_setup_limbo_handler()
>> will be called while the CPU that is going offline is still present
>> in the cpu_mask.
>>
>> Pass the CPU to exclude to cqm_setup_limbo_handler() and
>> mbm_setup_overflow_handler(). These functions can use a variant of
>> cpumask_any_but() when selecting the CPU. -1 is used to indicate no CPUs
>> need excluding.
>>
>> A subsequent patch moves these calls to be before CPUs have been removed,
>> so this exclude_cpus behaviour is temporary.

>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index c0b1ad8d8f6d..471cdc4e4eae 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c

>> @@ -816,15 +817,28 @@ void cqm_handle_limbo(struct work_struct *work)
>>  	mutex_unlock(&rdtgroup_mutex);
>>  }
>>  
>> -void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms)
>> +/**
>> + * cqm_setup_limbo_handler() - Schedule the limbo handler to run for this
>> + *                             domain.
>> + * @delay_ms:      How far in the future the handler should run.
>> + * @exclude_cpu:   Which CPU the handler should not run on,
>> + *		   RESCTRL_PICK_ANY_CPU to pick any CPU.
>> + */
>> +void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms,
>> +			     int exclude_cpu)
>>  {
>>  	unsigned long delay = msecs_to_jiffies(delay_ms);
>>  	int cpu;
>>  
>> -	cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>> +	if (exclude_cpu == RESCTRL_PICK_ANY_CPU)
>> +		cpu = cpumask_any_housekeeping(&dom->cpu_mask);
>> +	else
>> +		cpu = cpumask_any_housekeeping_but(&dom->cpu_mask,
>> +						   exclude_cpu);
> 
> Having callers need to do this checking seems unnecessary and makes the
> code complicated. Can cpumask_any_housekeeping_but() instead be made
> slightly smarter to handle the case where exclude_cpu == RESCTRL_PICK_ANY_CPU ?
> 
> Looks like there is a bit of duplication between 
> cpumask_any_housekeeping() and cpumask_any_housekeeping_but().

Yup, this was because I was originally going to add them to cpumask.h, but figured it
would be easier to leave them here - in a shape that could be moved to cpumask.h if anyone
else needs them.

Using one helper for both would simplify things for resctrl, I'll do that.


Thanks,

James
