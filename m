Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782D800227
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377057AbjLADhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:37:51 -0500
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380110DE;
        Thu, 30 Nov 2023 19:37:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxUmUab_1701401869;
Received: from 30.240.114.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxUmUab_1701401869)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 11:37:53 +0800
Message-ID: <e7d55b9b-9819-434e-b642-8325728b638b@linux.alibaba.com>
Date:   Fri, 1 Dec 2023 11:37:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task work
 with proper si_code
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>
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
 <1758585c-219b-c5df-a3cd-35be8b020fd2@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1758585c-219b-c5df-a3cd-35be8b020fd2@arm.com>
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
> Hi Boris, Shuai,
> 
> On 29/11/2023 18:54, Borislav Petkov wrote:
>> On Sun, Nov 26, 2023 at 08:25:38PM +0800, Shuai Xue wrote:
>>>> On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
>>>>> - an AR error consumed by current process is deferred to handle in a
>>>>>   dedicated kernel thread, but memory_failure() assumes that it runs in the
>>>>>   current context
>>>>
>>>> On x86? ARM?
>>>>
>>>> Pease point to the exact code flow.
> 
> 
>>> An AR error consumed by current process is deferred to handle in a
>>> dedicated kernel thread on ARM platform. The AR error is handled in bellow
>>> flow:
> 
> Please don't think of errors as "action required" - that's a user-space signal code. If
> the page could be fixed by memory-failure(), you may never get a signal. (all this was the
> fix for always sending an action-required signal)
> 
> I assume you mean the CPU accessed a poisoned location and took a synchronous error.

Yes, I mean that CPU accessed a poisoned location and took a synchronous error.
> 
> 
>>> -----------------------------------------------------------------------------
>>> [usr space task einj_mem_uc consumd data poison, CPU 3]         STEP 0
>>>
>>> -----------------------------------------------------------------------------
>>> [ghes_sdei_critical_callback: current einj_mem_uc, CPU 3]		STEP 1
>>> ghes_sdei_critical_callback
>>>     => __ghes_sdei_callback
>>>         => ghes_in_nmi_queue_one_entry 		// peak and read estatus
>>>         => irq_work_queue(&ghes_proc_irq_work) <=> ghes_proc_in_irq // irq_work
>>> [ghes_sdei_critical_callback: return]
>>> -----------------------------------------------------------------------------
>>> [ghes_proc_in_irq: current einj_mem_uc, CPU 3]			        STEP 2
>>>             => ghes_do_proc
>>>                 => ghes_handle_memory_failure
>>>                     => ghes_do_memory_failure
>>>                         => memory_failure_queue	 // put work task on current CPU
>>>                             => if (kfifo_put(&mf_cpu->fifo, entry))
>>>                                   schedule_work_on(smp_processor_id(), &mf_cpu->work);
>>>             => task_work_add(current, &estatus_node->task_work, TWA_RESUME);
>>> [ghes_proc_in_irq: return]
>>> -----------------------------------------------------------------------------
>>> // kworker preempts einj_mem_uc on CPU 3 due to RESCHED flag	STEP 3
>>> [memory_failure_work_func: current kworker, CPU 3]	
>>>      => memory_failure_work_func(&mf_cpu->work)
>>>         => while kfifo_get(&mf_cpu->fifo, &entry);	// until get no work
>>>             => memory_failure(entry.pfn, entry.flags);
>>
>> From the comment above that function:
>>
>>  * The function is primarily of use for corruptions that
>>  * happen outside the current execution context (e.g. when
>>  * detected by a background scrubber)
>>  *
>>  * Must run in process context (e.g. a work queue) with interrupts
>>  * enabled and no spinlocks held.
>>
>>> -----------------------------------------------------------------------------
>>> [ghes_kick_task_work: current einj_mem_uc, other cpu]           STEP 4
>>>                 => memory_failure_queue_kick
>>>                     => cancel_work_sync - waiting memory_failure_work_func finish
>>>                     => memory_failure_work_func(&mf_cpu->work)
>>>                         => kfifo_get(&mf_cpu->fifo, &entry); // no work
>>> -----------------------------------------------------------------------------
>>> [einj_mem_uc resume at the same PC, trigger a page fault        STEP 5
>>>
>>> STEP 0: A user space task, named einj_mem_uc consume a poison. The firmware
>>> notifies hardware error to kernel through is SDEI
>>> (ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED).
>>>
>>> STEP 1: The swapper running on CPU 3 is interrupted. irq_work_queue() rasie
>>> a irq_work to handle hardware errors in IRQ context
>>>
>>> STEP2: In IRQ context, ghes_proc_in_irq() queues memory failure work on
>>> current CPU in workqueue and add task work to sync with the workqueue.
>>>
>>> STEP3: The kworker preempts the current running thread and get CPU 3. Then
>>> memory_failure() is processed in kworker.
>>
>> See above.
>>
>>> STEP4: ghes_kick_task_work() is called as task_work to ensure any queued
>>> workqueue has been done before returning to user-space.
>>>
>>> STEP5: Upon returning to user-space, the task einj_mem_uc resumes at the
>>> current instruction, because the poison page is unmapped by
>>> memory_failure() in step 3, so a page fault will be triggered.
>>>
>>> memory_failure() assumes that it runs in the current context on both x86
>>> and ARM platform.
>>>
>>>
>>> for example:
>>> 	memory_failure() in mm/memory-failure.c:
>>>
>>> 		if (flags & MF_ACTION_REQUIRED) {
>>> 			folio = page_folio(p);
>>> 			res = kill_accessing_process(current, folio_pfn(folio), flags);
>>> 		}
>>
>> And?
>>
>> Do you see the check above it?
>>
>> 	if (TestSetPageHWPoison(p)) {
>>
>> test_and_set_bit() returns true only when the page was poisoned already.
>>
>>  * This function is intended to handle "Action Required" MCEs on already
>>  * hardware poisoned pages. They could happen, for example, when
>>  * memory_failure() failed to unmap the error page at the first call, or
>>  * when multiple local machine checks happened on different CPUs.
>>
>> And that's kill_accessing_process().
>>
>> So AFAIU, the kworker running memory_failure() would only mark the page
>> as poison.
>>
>> The killing happens when memory_failure() runs again and the process
>> touches the page again.
>>
>> But I'd let James confirm here.
> 
> Yes, this is what is expected to happen with the existing code.
> 
> The first pass will remove the pages from all processes that have it mapped before this
> user-space task can restart. Restarting the task will make it access a poisoned page,
> kicking off the second path which delivers the signal.
> 
> The reason for two passes is send_sig_mceerr() likes to clear_siginfo(), so even if you
> queued action-required before leaving GHES, memory-failure() would stomp on it.
> 
> 
>> I still don't know what you're fixing here.
> 
> The problem is if the user-space process registered for early messages, it gets a signal
> on the first pass. If it returns from that signal, it will access the poisoned page and
> get the action-required signal.
> 
> How is this making Qemu go wrong?

The problem here is that we need to assume, the first pass memory failure
handle and unmap the poisoned page successfully.

- If so, it may work by the second pass action-requried signal because it
  access an unmapped page. But IMHO, we can improve by just sending one
  pass signal, so that the Guest will vmexit only once, right?

- If not, there is no second pass signal. The exist code does not handle
  the error code from memory_failure(), so a exception loop happens
  resulting a hard lockup panic.

Besides, in production environment, a second access to an already known
poison page will introduce more risk of error propagation.

> 
> 
> As to how this works for you given Boris' comments above: kill_procs() is also called from
> hwpoison_user_mappings(), which takes the flags given to memory-failure(). This is where
> the action-optional signals come from.
> 
> 

Thank you very much for involving to review and comment.

Best Regards,
Shuai
