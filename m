Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A657FF87C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346545AbjK3Rjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3Rjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:39:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CE4710D9;
        Thu, 30 Nov 2023 09:39:50 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC541042;
        Thu, 30 Nov 2023 09:40:36 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C07AD3F6C4;
        Thu, 30 Nov 2023 09:39:45 -0800 (PST)
Message-ID: <1758585c-219b-c5df-a3cd-35be8b020fd2@arm.com>
Date:   Thu, 30 Nov 2023 17:39:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task work
 with proper si_code
Content-Language: en-GB
To:     Borislav Petkov <bp@alien8.de>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, lenb@kernel.org,
        hpa@zytor.com, robert.moore@intel.com, lvying6@huawei.com,
        xiexiuqi@huawei.com, zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
 <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
 <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
 <20231125121059.GAZWHkU27odMLns7TZ@fat_crate.local>
 <1048123e-b608-4db1-8d5f-456dd113d06f@linux.alibaba.com>
 <20231129185406.GBZWeIzqwgRQe7XDo/@fat_crate.local>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20231129185406.GBZWeIzqwgRQe7XDo/@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris, Shuai,

On 29/11/2023 18:54, Borislav Petkov wrote:
> On Sun, Nov 26, 2023 at 08:25:38PM +0800, Shuai Xue wrote:
>>> On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
>>>> - an AR error consumed by current process is deferred to handle in a
>>>>   dedicated kernel thread, but memory_failure() assumes that it runs in the
>>>>   current context
>>>
>>> On x86? ARM?
>>>
>>> Pease point to the exact code flow.


>> An AR error consumed by current process is deferred to handle in a
>> dedicated kernel thread on ARM platform. The AR error is handled in bellow
>> flow:

Please don't think of errors as "action required" - that's a user-space signal code. If
the page could be fixed by memory-failure(), you may never get a signal. (all this was the
fix for always sending an action-required signal)

I assume you mean the CPU accessed a poisoned location and took a synchronous error.


>> -----------------------------------------------------------------------------
>> [usr space task einj_mem_uc consumd data poison, CPU 3]         STEP 0
>>
>> -----------------------------------------------------------------------------
>> [ghes_sdei_critical_callback: current einj_mem_uc, CPU 3]		STEP 1
>> ghes_sdei_critical_callback
>>     => __ghes_sdei_callback
>>         => ghes_in_nmi_queue_one_entry 		// peak and read estatus
>>         => irq_work_queue(&ghes_proc_irq_work) <=> ghes_proc_in_irq // irq_work
>> [ghes_sdei_critical_callback: return]
>> -----------------------------------------------------------------------------
>> [ghes_proc_in_irq: current einj_mem_uc, CPU 3]			        STEP 2
>>             => ghes_do_proc
>>                 => ghes_handle_memory_failure
>>                     => ghes_do_memory_failure
>>                         => memory_failure_queue	 // put work task on current CPU
>>                             => if (kfifo_put(&mf_cpu->fifo, entry))
>>                                   schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>             => task_work_add(current, &estatus_node->task_work, TWA_RESUME);
>> [ghes_proc_in_irq: return]
>> -----------------------------------------------------------------------------
>> // kworker preempts einj_mem_uc on CPU 3 due to RESCHED flag	STEP 3
>> [memory_failure_work_func: current kworker, CPU 3]	
>>      => memory_failure_work_func(&mf_cpu->work)
>>         => while kfifo_get(&mf_cpu->fifo, &entry);	// until get no work
>>             => memory_failure(entry.pfn, entry.flags);
> 
> From the comment above that function:
> 
>  * The function is primarily of use for corruptions that
>  * happen outside the current execution context (e.g. when
>  * detected by a background scrubber)
>  *
>  * Must run in process context (e.g. a work queue) with interrupts
>  * enabled and no spinlocks held.
> 
>> -----------------------------------------------------------------------------
>> [ghes_kick_task_work: current einj_mem_uc, other cpu]           STEP 4
>>                 => memory_failure_queue_kick
>>                     => cancel_work_sync - waiting memory_failure_work_func finish
>>                     => memory_failure_work_func(&mf_cpu->work)
>>                         => kfifo_get(&mf_cpu->fifo, &entry); // no work
>> -----------------------------------------------------------------------------
>> [einj_mem_uc resume at the same PC, trigger a page fault        STEP 5
>>
>> STEP 0: A user space task, named einj_mem_uc consume a poison. The firmware
>> notifies hardware error to kernel through is SDEI
>> (ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED).
>>
>> STEP 1: The swapper running on CPU 3 is interrupted. irq_work_queue() rasie
>> a irq_work to handle hardware errors in IRQ context
>>
>> STEP2: In IRQ context, ghes_proc_in_irq() queues memory failure work on
>> current CPU in workqueue and add task work to sync with the workqueue.
>>
>> STEP3: The kworker preempts the current running thread and get CPU 3. Then
>> memory_failure() is processed in kworker.
> 
> See above.
> 
>> STEP4: ghes_kick_task_work() is called as task_work to ensure any queued
>> workqueue has been done before returning to user-space.
>>
>> STEP5: Upon returning to user-space, the task einj_mem_uc resumes at the
>> current instruction, because the poison page is unmapped by
>> memory_failure() in step 3, so a page fault will be triggered.
>>
>> memory_failure() assumes that it runs in the current context on both x86
>> and ARM platform.
>>
>>
>> for example:
>> 	memory_failure() in mm/memory-failure.c:
>>
>> 		if (flags & MF_ACTION_REQUIRED) {
>> 			folio = page_folio(p);
>> 			res = kill_accessing_process(current, folio_pfn(folio), flags);
>> 		}
> 
> And?
> 
> Do you see the check above it?
> 
> 	if (TestSetPageHWPoison(p)) {
> 
> test_and_set_bit() returns true only when the page was poisoned already.
> 
>  * This function is intended to handle "Action Required" MCEs on already
>  * hardware poisoned pages. They could happen, for example, when
>  * memory_failure() failed to unmap the error page at the first call, or
>  * when multiple local machine checks happened on different CPUs.
> 
> And that's kill_accessing_process().
> 
> So AFAIU, the kworker running memory_failure() would only mark the page
> as poison.
> 
> The killing happens when memory_failure() runs again and the process
> touches the page again.
> 
> But I'd let James confirm here.

Yes, this is what is expected to happen with the existing code.

The first pass will remove the pages from all processes that have it mapped before this
user-space task can restart. Restarting the task will make it access a poisoned page,
kicking off the second path which delivers the signal.

The reason for two passes is send_sig_mceerr() likes to clear_siginfo(), so even if you
queued action-required before leaving GHES, memory-failure() would stomp on it.


> I still don't know what you're fixing here.

The problem is if the user-space process registered for early messages, it gets a signal
on the first pass. If it returns from that signal, it will access the poisoned page and
get the action-required signal.

How is this making Qemu go wrong?


As to how this works for you given Boris' comments above: kill_procs() is also called from
hwpoison_user_mappings(), which takes the flags given to memory-failure(). This is where
the action-optional signals come from.


Thanks,

James
