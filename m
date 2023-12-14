Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBB9812EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444093AbjLNLhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443993AbjLNLhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:37:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 437E4132
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:37:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DAAD11FB;
        Thu, 14 Dec 2023 03:38:16 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72AE53F738;
        Thu, 14 Dec 2023 03:37:28 -0800 (PST)
Message-ID: <7c9b0656-fb09-1adf-664b-e2cbcc04b1db@arm.com>
Date:   Thu, 14 Dec 2023 11:37:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 13/24] x86/resctrl: Queue mon_event_read() instead of
 sending an IPI
Content-Language: en-GB
To:     babu.moger@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-14-james.morse@arm.com>
 <c0cc5cfc-c22b-4a27-b512-75f2e27b59cb@amd.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <c0cc5cfc-c22b-4a27-b512-75f2e27b59cb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 09/11/2023 20:40, Moger, Babu wrote:
> On 10/25/23 13:03, James Morse wrote:
>> Intel is blessed with an abundance of monitors, one per RMID, that can be
>> read from any CPU in the domain. MPAMs monitors reside in the MMIO MSC,
>> the number implemented is up to the manufacturer. This means when there are
>> fewer monitors than needed, they need to be allocated and freed.
>>
>> MPAM's CSU monitors are used to back the 'llc_occupancy' monitor file. The
>> CSU counter is allowed to return 'not ready' for a small number of
>> micro-seconds after programming. To allow one CSU hardware monitor to be
>> used for multiple control or monitor groups, the CPU accessing the
>> monitor needs to be able to block when configuring and reading the
>> counter.
>>
>> Worse, the domain may be broken up into slices, and the MMIO accesses
>> for each slice may need performing from different CPUs.
>>
>> These two details mean MPAMs monitor code needs to be able to sleep, and
>> IPI another CPU in the domain to read from a resource that has been sliced.
>>
>> mon_event_read() already invokes mon_event_count() via IPI, which means
>> this isn't possible. On systems using nohz-full, some CPUs need to be
>> interrupted to run kernel work as they otherwise stay in user-space
>> running realtime workloads. Interrupting these CPUs should be avoided,
>> and scheduling work on them may never complete.
>>
>> Change mon_event_read() to pick a housekeeping CPU, (one that is not using
>> nohz_full) and schedule mon_event_count() and wait. If all the CPUs
>> in a domain are using nohz-full, then an IPI is used as the fallback.
>>
>> This function is only used in response to a user-space filesystem request
>> (not the timing sensitive overflow code).
>>
>> This allows MPAM to hide the slice behaviour from resctrl, and to keep
>> the monitor-allocation in monitor.c. When the IPI fallback is used on
>> machines where MPAM needs to make an access on multiple CPUs, the counter
>> read will always fail.

>> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> index beccb0e87ba7..d07f99245851 100644
>> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
>> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c

>> @@ -522,12 +524,21 @@ int rdtgroup_schemata_show(struct kernfs_open_file *of,
>>  	return ret;
>>  }
>>  
>> +static int smp_mon_event_count(void *arg)
>> +{
>> +	mon_event_count(arg);
>> +
>> +	return 0;
>> +}
> 
> Shouldn't this function defined as "void" similar to mon_event_count?
> Return code is not used anywhere.

smp_call_on_cpu() requires it to return an int, even if the value is not used.

This wrapper only exists because smp_call_on_cpu() takes a different prototype to
smp_call_function_any().


Thanks,

James

>> @@ -536,7 +547,18 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>  	rr->val = 0;
>>  	rr->first = first;
>>  
>> -	smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>> +	cpu = cpumask_any_housekeeping(&d->cpu_mask);
>> +
>> +	/*
>> +	 * cpumask_any_housekeeping() prefers housekeeping CPUs, but
>> +	 * are all the CPUs nohz_full? If yes, pick a CPU to IPI.
>> +	 * MPAM's resctrl_arch_rmid_read() is unable to read the
>> +	 * counters on some platforms if its called in irq context.
>> +	 */
>> +	if (tick_nohz_full_cpu(cpu))
>> +		smp_call_function_any(&d->cpu_mask, mon_event_count, rr, 1);
>> +	else
>> +		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
>>  }
>>  

