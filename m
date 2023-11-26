Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533977F9293
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 13:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKZMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 07:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKZMZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 07:25:44 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0436DDE;
        Sun, 26 Nov 2023 04:25:48 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0Vx6Gb4W_1701001542;
Received: from 30.27.123.85(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vx6Gb4W_1701001542)
          by smtp.aliyun-inc.com;
          Sun, 26 Nov 2023 20:25:45 +0800
Message-ID: <1048123e-b608-4db1-8d5f-456dd113d06f@linux.alibaba.com>
Date:   Sun, 26 Nov 2023 20:25:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task work
 with proper si_code
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
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
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231125121059.GAZWHkU27odMLns7TZ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/25 20:10, Borislav Petkov wrote:

Hi, Borislav,

Thank you for your reply, and sorry for the confusion I made. Please see my rely
inline.

Best Regards,
Shuai

> On Sat, Nov 25, 2023 at 02:44:52PM +0800, Shuai Xue wrote:
>> - an AR error consumed by current process is deferred to handle in a
>>   dedicated kernel thread, but memory_failure() assumes that it runs in the
>>   current context
> 
> On x86? ARM?
> 
> Pease point to the exact code flow.

An AR error consumed by current process is deferred to handle in a
dedicated kernel thread on ARM platform. The AR error is handled in bellow
flow:

-----------------------------------------------------------------------------
[usr space task einj_mem_uc consumd data poison, CPU 3]         STEP 0

-----------------------------------------------------------------------------
[ghes_sdei_critical_callback: current einj_mem_uc, CPU 3]		STEP 1
ghes_sdei_critical_callback
    => __ghes_sdei_callback
        => ghes_in_nmi_queue_one_entry 		// peak and read estatus
        => irq_work_queue(&ghes_proc_irq_work) <=> ghes_proc_in_irq // irq_work
[ghes_sdei_critical_callback: return]
-----------------------------------------------------------------------------
[ghes_proc_in_irq: current einj_mem_uc, CPU 3]			        STEP 2
            => ghes_do_proc
                => ghes_handle_memory_failure
                    => ghes_do_memory_failure
                        => memory_failure_queue	 // put work task on current CPU
                            => if (kfifo_put(&mf_cpu->fifo, entry))
                                  schedule_work_on(smp_processor_id(), &mf_cpu->work);
            => task_work_add(current, &estatus_node->task_work, TWA_RESUME);
[ghes_proc_in_irq: return]
-----------------------------------------------------------------------------
// kworker preempts einj_mem_uc on CPU 3 due to RESCHED flag	STEP 3
[memory_failure_work_func: current kworker, CPU 3]	
     => memory_failure_work_func(&mf_cpu->work)
        => while kfifo_get(&mf_cpu->fifo, &entry);	// until get no work
            => memory_failure(entry.pfn, entry.flags);
-----------------------------------------------------------------------------
[ghes_kick_task_work: current einj_mem_uc, other cpu]           STEP 4
                => memory_failure_queue_kick
                    => cancel_work_sync - waiting memory_failure_work_func finish
                    => memory_failure_work_func(&mf_cpu->work)
                        => kfifo_get(&mf_cpu->fifo, &entry); // no work
-----------------------------------------------------------------------------
[einj_mem_uc resume at the same PC, trigger a page fault        STEP 5

STEP 0: A user space task, named einj_mem_uc consume a poison. The firmware
notifies hardware error to kernel through is SDEI
(ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED).

STEP 1: The swapper running on CPU 3 is interrupted. irq_work_queue() rasie
a irq_work to handle hardware errors in IRQ context

STEP2: In IRQ context, ghes_proc_in_irq() queues memory failure work on
current CPU in workqueue and add task work to sync with the workqueue.

STEP3: The kworker preempts the current running thread and get CPU 3. Then
memory_failure() is processed in kworker.

STEP4: ghes_kick_task_work() is called as task_work to ensure any queued
workqueue has been done before returning to user-space.

STEP5: Upon returning to user-space, the task einj_mem_uc resumes at the
current instruction, because the poison page is unmapped by
memory_failure() in step 3, so a page fault will be triggered.

memory_failure() assumes that it runs in the current context on both x86
and ARM platform.


for example:
	memory_failure() in mm/memory-failure.c:

		if (flags & MF_ACTION_REQUIRED) {
			folio = page_folio(p);
			res = kill_accessing_process(current, folio_pfn(folio), flags);
		}

> 
>> - another page fault is not unnecessary, we can send sigbus to current
>>   process in the first Synchronous External Abort SEA on arm64 (analogy
>>   Machine Check Exception on x86)
> 
> I have no clue what that means. What page fault?

I mean page fault in step 5. We can simplify the above flow by queuing
memory_failure() as a task work for AR errors in step 3 directly.

> 
>> I just give an example that the user space process *really* relys on the
>> si_code of signal to handle hardware errors
> 
> No, don't give examples.
> 
> Explain what the exact problem is you're seeing, in your use case, point
> to the code and then state how you think it should be fixed and why.
> 
> Right now your text is "all over the place" and I have no clue what you
> even want.

Ok, got it. Thank you.

> 
>> The SIGBUS si_codes defined in include/uapi/asm-generic/siginfo.h says:
>>
>>     /* hardware memory error consumed on a machine check: action required */
>>     #define BUS_MCEERR_AR	4
>>     /* hardware memory error detected in process but not consumed: action optional*/
>>     #define BUS_MCEERR_AO	5
>>
>> When a synchronous error is consumed by Guest, the kernel should send a
>> signal with BUS_MCEERR_AR instead of BUS_MCEERR_AO.
> 
> Can you drop this "synchronous" bla and concentrate on the error
> *severity*?
> 
> I think you want to say that there are some types of errors for which
> error handling needs to happen immediately and for some reason that
> doesn't happen.
> 
> Which errors are those? Types?
> 
> Why do you need them to be handled immediately?

Well, the severity defined on x86 and ARM platform is quite different. I
guess you mean taxonomy of producer error types.

- X86: Software recoverable action required (SRAR)

    A UCR error that *requires* system software to take a recovery action on
    this processor *before scheduling another stream of execution on this
    processor*.
    (15.6.3 UCR Error Classification in Intel® 64 and IA-32 Architectures
    Software Developer’s Manual Volume 3)

- ARM: Recoverable state (UER)

    The PE determines that software *must* take action to locate and repair
    the error to successfully recover execution. This might be because the
    exception was taken before the error was architecturally consumed by
    the PE, at the point when the PE was not be able to make correct
    progress without either consuming the error or *otherwise making the
    state of the PE unrecoverable*.
    (2.3.2 PE error state classification in Arm RAS Supplement
    https://documentation-service.arm.com/static/63185614f72fad1903828eda)

I think above two types of error need to be handled immediately.

> 
>> Exactly.
> 
> No, not exactly. Why is it ok to do that? What are the implications of
> this?
> 
> Is immediate killing the right decision?
> 
> Is this ok for *every* possible kernel running out there - not only for
> your use case?
> 
> And so on and so on...
> 

I don't have a clear answer here. I guess the poison data only effects the
user space task which triggers exception. A panic is not necessary.

On x86 platform, the current error handling of memory_failure() in
kill_me_maybe() is just send a sigbus forcely.

    kill_me_maybe():

        ret = memory_failure(pfn, flags);
        if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
        return;

        pr_err("Memory error not recovered");
        kill_me_now(cb);

Do you have any comments or suggestion about this? I don't change x86
behavior.

For arm64 platform, step 3 in above flow, memory_failure_work_func(), the
call site of memory_failure(), does not handle the return code of
memory_failure(). I just add the same behavior.


