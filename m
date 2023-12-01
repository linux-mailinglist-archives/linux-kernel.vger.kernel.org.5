Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA85D800449
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjLAHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377678AbjLAHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:03:36 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF37103;
        Thu, 30 Nov 2023 23:03:40 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxXwK5O_1701414213;
Received: from 30.240.114.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxXwK5O_1701414213)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 15:03:37 +0800
Message-ID: <b56fbae2-0d9b-4c42-94bf-7fd58b3fd738@linux.alibaba.com>
Date:   Fri, 1 Dec 2023 15:03:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] ACPI: APEI: handle synchronous exceptions in task
 work
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, rafael@kernel.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, gregkh@linuxfoundation.org,
        will@kernel.org, jarkko@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-3-xueshuai@linux.alibaba.com>
 <874f0170-a829-47db-8882-52b9ed8e869d@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <874f0170-a829-47db-8882-52b9ed8e869d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/1 01:39, James Morse wrote:
> Hi Shuai,
> 
> On 07/10/2023 08:28, Shuai Xue wrote:
>> Hardware errors could be signaled by synchronous interrupt,
> 
> I'm struggling with 'synchronous interrupt'. Do you mean arm64's 'precise' (all
> instructions before the exception were executed, and none after).
> Otherwise, surely any interrupt from a background scrubber is inherently asynchronous!
> 

I am sorry, this is typo. I mean asynchronous interrupt.

> 
>> e.g.  when an
>> error is detected by a background scrubber, or signaled by synchronous
>> exception, e.g. when an uncorrected error is consumed. Both synchronous and
>> asynchronous error are queued and handled by a dedicated kthread in
>> workqueue.
>>
>> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
>> synchronous errors") keep track of whether memory_failure() work was
>> queued, and make task_work pending to flush out the workqueue so that the
>> work for synchronous error is processed before returning to user-space.
> 
> It does it regardless, if user-space was interrupted by APEI any work queued as a result
> of that should be completed before we go back to user-space. Otherwise we can bounce
> between user-space and firmware, with the kernel only running the APEI code, and never
> making progress.
> 

Agreed.

> 
>> The trick ensures that the corrupted page is unmapped and poisoned. And
>> after returning to user-space, the task starts at current instruction which
>> triggering a page fault in which kernel will send SIGBUS to current process
>> due to VM_FAULT_HWPOISON.
>>
>> However, the memory failure recovery for hwpoison-aware mechanisms does not
>> work as expected. For example, hwpoison-aware user-space processes like
>> QEMU register their customized SIGBUS handler and enable early kill mode by
>> seting PF_MCE_EARLY at initialization. Then the kernel will directly notify
> 
> (setting, directly)

Thank you. Will fix it.

> 
>> the process by sending a SIGBUS signal in memory failure with wrong
> 
>> si_code: the actual user-space process accessing the corrupt memory
>> location, but its memory failure work is handled in a kthread context, so
>> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
>> process instead of BUS_MCEERR_AR in kill_proc().
> 
> This is hard to parse, "the user-space process is accessing"? (dropping 'actual' and
> adding 'is')

Will fix it.


> 
> 
> Wasn't this behaviour fixed by the previous patch?
> 
> What problem are you fixing here?


Nope. The memory_failure() runs in a kthread context, but not the
user-space process which consuming poison data.


    // kill_proc() in memory-failure.c

	if ((flags & MF_ACTION_REQUIRED) && (t == current))
		ret = force_sig_mceerr(BUS_MCEERR_AR,
				 (void __user *)tk->addr, addr_lsb);
	else
		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
				      addr_lsb, t);

So, even we queue memory_failure() with MF_ACTION_REQUIRED flags in
previous patch, it will still send a sigbus with BUS_MCEERR_AO in the else
branch of kill_proc().

> 
> 
>> To this end, separate synchronous and asynchronous error handling into
>> different paths like X86 platform does:
>>
>> - valid synchronous errors: queue a task_work to synchronously send SIGBUS
>>   before ret_to_user.
> 
>> - valid asynchronous errors: queue a work into workqueue to asynchronously
>>   handle memory failure.
> 
> Why? The signal issue was fixed by the previous patch. Why delay the handling of a
> poisoned memory location further?

The signal issue is not fixed completely. See my reply above.

> 
> 
>> - abnormal branches such as invalid PA, unexpected severity, no memory
>>   failure config support, invalid GUID section, OOM, etc.
> 
> ... do what?

If no memory failure work is queued for abnormal errors, do a force kill.
Will also add this comment to commit log.

> 
> 
>> Then for valid synchronous errors, the current context in memory failure is
>> exactly belongs to the task consuming poison data and it will send SIBBUS
>> with proper si_code.
> 
> 
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 6f35f724cc14..1675ff77033d 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1334,17 +1334,10 @@ static void kill_me_maybe(struct callback_head *cb)
>>  		return;
>>  	}
>>  
>> -	/*
>> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> -	 * to the current process with the proper error info,
>> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> -	 *
>> -	 * In both cases, no further processing is required.
>> -	 */
>>  	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>  		return;
>>  
>> -	pr_err("Memory error not recovered");
>> +	pr_err("Sending SIGBUS to current task due to memory error not recovered");
>>  	kill_me_now(cb);
>>  }
>>  
> 
> I'm not sure how this hunk is relevant to the commit message.

I handle memory_failure() error code in its arm64 call site
memory_failure_cb() with some comments, similar to x86 call site
kill_me_maybe(). I moved these two part comments to function declaration,
followed by review comments from Kefeng.

I should split this into a separate patch. Will do it in next version.

> 
> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 88178aa6222d..014401a65ed5 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -484,6 +497,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>  		return false;
>>  	}
>>  
>> +	if (flags == MF_ACTION_REQUIRED && current->mm) {
>> +		twcb = kmalloc(sizeof(*twcb), GFP_ATOMIC);
>> +		if (!twcb)
>> +			return false;
> 
> Yuck - New failure modes! This is why the existing code always has this memory allocated
> in struct ghes_estatus_node.

Are you suggesting to move fields of struct sync_task_work to struct
ghes_estatus_node, and use ghes_estatus_node here? Or we can just alloc
struct sync_task_work with gen_pool_alloc from ghes_estatus_pool.

> 
> 
>> +		twcb->pfn = pfn;
>> +		twcb->flags = flags;
>> +		init_task_work(&twcb->twork, memory_failure_cb);
>> +		task_work_add(current, &twcb->twork, TWA_RESUME);
>> +		return true;
>> +	}
>> +
>>  	memory_failure_queue(pfn, flags);
>>  	return true;
>>  }
> 
> [..]
> 
>> @@ -696,7 +721,14 @@ static bool ghes_do_proc(struct ghes *ghes,
>>  		}
>>  	}
>>  
>> -	return queued;
>> +	/*
>> +	 * If no memory failure work is queued for abnormal synchronous
>> +	 * errors, do a force kill.
>> +	 */
>> +	if (sync && !queued) {
>> +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
>> +		force_sig(SIGBUS);
>> +	}
>>  }
> 
> I think this is a lot of churn, and this hunk is the the only meaningful change in
> behaviour. Can you explain how this happens?

For example:
- invalid GUID section in ghes_do_proc()
- CPER_MEM_VALID_PA is not set, unexpected severity in
  ghes_handle_memory_failure().
- CONFIG_ACPI_APEI_MEMORY_FAILURE is not enabled, !pfn_vaild(pfn) in
  ghes_do_memory_failure()

> 
> 
> Wouldn't it be simpler to split ghes_kick_task_work() to have a sync/async version.
> The synchronous version can unconditionally force_sig_mceerr(BUS_MCEERR_AR, ...) after
> memory_failure_queue_kick() - but that still means memory_failure() is unable to disappear
> errors that it fixed - see MF_RECOVERED.

Sorry, I don't think so. Unconditionally send a sigbus is not a good
choice.  For example, if a sync memory error detected in instruction memory
error, the kernel should transparently fix and no signal should be send.

    ./einj_mem_uc instr
    [168522.751671] Memory failure: 0x89dedd: corrupted page was clean: dropped without side effects
    [168522.751679] Memory failure: 0x89dedd: recovery action for clean LRU page: Recovered

With this patch set, the instr case behaves consistently on both the arm64 and x86 platforms.

The complex page error_states are handled in memory_failure(). IMHO, we
should left this part to it.

> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 4d6e43c88489..0d02f8a0b556 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2161,9 +2161,12 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   * Must run in process context (e.g. a work queue) with interrupts
>>   * enabled and no spinlocks held.
>>   *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return values:
>> + *   0             - success
>> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
>> + *   -EHWPOISON    - sent SIGBUS to the current process with the proper
>> + *                   error info by kill_accessing_process().
>> + *   other negative values - failure
>>   */
>>  int memory_failure(unsigned long pfn, int flags)
>>  {
> 
> I'm not sure how this hunk is relevant to the commit message.


As mentioned, I will split this into a separate patch.

> 
> 
> Thanks,
> 
> James


Thank you for valuable comments.
Best Regards,
Shuai
