Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27B77FE77B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjK3C7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 21:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3C66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 21:58:58 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE0CC;
        Wed, 29 Nov 2023 18:59:03 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxQ.im6_1701313137;
Received: from 30.240.112.131(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxQ.im6_1701313137)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 10:59:00 +0800
Message-ID: <a3cd9b79-4be5-4f77-b32a-51a624a65ec0@linux.alibaba.com>
Date:   Thu, 30 Nov 2023 10:58:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task work
 with proper si_code
To:     Borislav Petkov <bp@alien8.de>, james.morse@arm.com
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
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231129185406.GBZWeIzqwgRQe7XDo/@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/30 02:54, Borislav Petkov wrote:
> Moving James to To:
> 
> On Sun, Nov 26, 2023 at 08:25:38PM +0800, Shuai Xue wrote:
>>> On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
>>>> - an AR error consumed by current process is deferred to handle in a
>>>>   dedicated kernel thread, but memory_failure() assumes that it runs in the
>>>>   current context
>>>
>>> On x86? ARM?
>>>
>>> Pease point to the exact code flow.
>>
>> An AR error consumed by current process is deferred to handle in a
>> dedicated kernel thread on ARM platform. The AR error is handled in bellow
>> flow:
>>
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

Hi, Borislav,

Thank you for your comments.

But we are talking about Action Required error, it does happen *inside the
current execution context*.  The Action Required error does not meet the
function comments.

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

When a Action Required error occurs, it triggers a MCE-like exception
(SEA).  In the first call of memory_failure(), it will poison the page. If
it failed to unmap the error page, the user space task resumes at the
current PC and triggers another SEA exception, then the second call of
memory_failure() will run into kill_accessing_process() which do nothing
and just return -EFAULT. As a result, a third SEA exception will be
triggered.  Finally, a exception loop happens resulting a hard lockup
panic.

> 
> But I'd let James confirm here.
>
> 
> I still don't know what you're fixing here.

In ARM64 platform, when a Action Required error occurs, the kernel should
send SIGBUS with si_code BUS_MCEERR_AR instead of BUS_MCEERR_AO. (It is
also the subject of this thread)

> 
> Is this something you're encountering on some machine or you simply
> stared at code?

I met the wrong si_code problem on Yitian 710 machine which is based on
ARM64 platform. And I think it is gernel on ARM64 platfrom.

To reproduce this problem:

	# STEP1: enable early kill mode
	#sysctl -w vm.memory_failure_early_kill=1
	vm.memory_failure_early_kill = 1

	# STEP2: inject an UCE error and consume it to trigger a synchronous error
	#einj_mem_uc single
	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
	injecting ...
	triggering ...
	signal 7 code 5 addr 0xffffb0d75000
	page not present
	Test passed

The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
and it is not fact.

After this patch set:

	# STEP1: enable early kill mode
	#sysctl -w vm.memory_failure_early_kill=1
	vm.memory_failure_early_kill = 1

	# STEP2: inject an UCE error and consume it to trigger a synchronous error
	#einj_mem_uc single
	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
	injecting ...
	triggering ...
	signal 7 code 4 addr 0xffffb0d75000
	page not present
	Test passed

The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
as we expected.


> 
> What does that
> 
> "Both Alibaba and Huawei met the same issue in products, and we hope it
> could be fixed ASAP."
> 
> mean?
> 
> What did you meet?
> 
> What was the problem?

We both got wrong si_code of SIGBUS from kernel side on ARM64 platform.

The VMM in our product relies on the si_code of SIGBUS to handle memory
failure in userspace.

- For BUS_MCEERR_AO, we regard that the corruptions happen *outside the
  current execution context* e.g. detected by a background scrubber, the
  VMM will ignore the error and the VM will not be killed immediately.
- For BUS_MCEERR_AR, we regard that the corruptions happen *insdie the
  current execution context*, e.g. when a data poison is consumed, the VMM
  will kill the VM immediately to avoid any further potential data
  propagation.

> 
> I still note that you're avoiding answering the question what the issue
> is and if you keep avoiding it, I'll ignore this whole thread.
> 

Sorry, Borislav, thank you for your patient and time. I really appreciate
that you are involving in to review this patchset. But I have to say it is
not the truth, I am avoiding anything. I tried my best to answer every comments
you raised, give the details of ARM RAS specific and code flow.

Best Regards,
Shuai

