Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E719279A0D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjIKAoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIKAoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:44:22 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6D12D;
        Sun, 10 Sep 2023 17:44:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0Vrj888v_1694393049;
Received: from 30.240.112.142(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vrj888v_1694393049)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 08:44:13 +0800
Message-ID: <b7a97ef1-c804-41bd-d9d5-8086a02c6ae4@linux.alibaba.com>
Date:   Mon, 11 Sep 2023 08:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [RESEND PATCH v7 0/2] ACPI: APEI: handle synchronous exceptions
 with proper si_code
To:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        naoya.horiguchi@nec.com,
        "james.morse@arm.com" <james.morse@arm.com>,
        gregkh@linuxfoundation.org, Will Deacon <will@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, justin.he@arm.com,
        akpm@linux-foundation.org, ardb@kernel.org, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de,
        cuibixuan@linux.alibaba.com, dave.hansen@linux.intel.com,
        jarkko@kernel.org, lenb@kernel.org, linmiaohe@huawei.com,
        lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com, stable <stable@vger.kernel.org>
References: <20230606074238.97166-1-xueshuai@linux.alibaba.com>
 <a2b16cca-5449-1d16-f49c-7b83fb45771c@linux.alibaba.com>
 <1fe4f86e-63ce-3702-4e08-4bc0e7bb391b@linux.alibaba.com>
 <19bc33e2-1f47-43d6-599c-3e48bb697f7c@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <19bc33e2-1f47-43d6-599c-3e48bb697f7c@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/8 11:17, Shuai Xue wrote:
> 
> 
> On 2023/7/10 11:15, Shuai Xue wrote:
>>
>>
>> On 2023/6/16 15:15, Shuai Xue wrote:
>>>
>>>
>>> On 2023/6/6 15:42, Shuai Xue wrote:
>>>> changes since v6:
>>>> - add more explicty error message suggested by Xiaofei
>>>> - pick up reviewed-by tag from Xiaofei
>>>> - pick up internal reviewed-by tag from Baolin
>>>>
>>>> changes since v5 by addressing comments from Kefeng:
>>>> - document return value of memory_failure()
>>>> - drop redundant comments in call site of memory_failure() 
>>>> - make ghes_do_proc void and handle abnormal case within it
>>>> - pick up reviewed-by tag from Kefeng Wang 
>>>>
>>>> changes since v4 by addressing comments from Xiaofei:
>>>> - do a force kill only for abnormal sync errors
>>>>
>>>> changes since v3 by addressing comments from Xiaofei:
>>>> - do a force kill for abnormal memory failure error such as invalid PA,
>>>> unexpected severity, OOM, etc
>>>> - pcik up tested-by tag from Ma Wupeng
>>>>
>>>> changes since v2 by addressing comments from Naoya:
>>>> - rename mce_task_work to sync_task_work
>>>> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
>>>> - add steps to reproduce this problem in cover letter
>>>>
>>>> changes since v1:
>>>> - synchronous events by notify type
>>>> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
>>>>
>>>>
>>>> Shuai Xue (2):
>>>>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>>>>     synchronous events
>>>>   ACPI: APEI: handle synchronous exceptions in task work
>>>>
>>>>  arch/x86/kernel/cpu/mce/core.c |   9 +--
>>>>  drivers/acpi/apei/ghes.c       | 113 ++++++++++++++++++++++-----------
>>>>  include/acpi/ghes.h            |   3 -
>>>>  mm/memory-failure.c            |  17 +----
>>>>  4 files changed, 79 insertions(+), 63 deletions(-)
>>>>
>>>
>>>
>>> Hi, Rafael,
>>>
>>> Gentle ping.
>>>
>>> Are you happy to queue this patch set or anything I can do to improve it?
>>> As @Kefeng said, this issue is met in Alibaba and Huawei products, we hope it
>>> could be fixed ASAP.
>>
>> Hi Rafael, Tony, and Naoya,
>>
>> Gentle ping. I am sorry to see that we have missed v6.3 and v6.4 merge window
>> since three Reviewed-by tags and one Tested-by tag.
>>
>> Do we still need any designated APEI reviewers Reviewed-by? Could you give me your
>> Reviewed-by @Tony, and @Naoya if you are happy with the change.
>>
>> Or Please could you Ack this change if you are happy with the proposal and the
>> change? @Rafael
>>
> 
> Hi, ALL,
> 
> Gentle ping.
> 

Hi, ALL,

I have rewritten the cover letter with the hope that the maintainer will truly
understand the necessity of this patch. Both Alibaba and Huawei met the same
issue in products, and we hope it could be fixed ASAP.

There are two major types of uncorrected recoverable (UCR) errors :

- Action Required (AR): The error is detected and the processor already
  consumes the memory. OS requires to take action (for example, offline
  failure page/kill failure thread) to recover this error.

- Action Optional (AO): The error is detected out of processor execution
  context. Some data in the memory are corrupted. But the data have not
  been consumed. OS is optional to take action to recover this error.

The main difference between AR and AO errors is that AR errors are synchronous
events, while AO errors are asynchronous events. Synchronous exceptions, such as
Machine Check Exception (MCE) on X86 and Synchronous External Abort (SEA) on
Arm64, are signaled by the hardware when an error is detected and the memory
access has architecturally been executed.

Currently, both synchronous and asynchronous errors are queued as AO errors and
handled by a dedicated kernel thread in a work queue on the ARM64 platform. For
synchronous errors, memory_failure() is synced using a cancel_work_sync trick to
ensure that the corrupted page is unmapped and poisoned. Upon returning to
user-space, the process resumes at the current instruction, triggering a page
fault. As a result, the kernel sends a SIGBUS signal to the current process due
to VM_FAULT_HWPOISON.

However, this trick is not always be effective, this patch set improves the
recovery process in three specific aspects:

1. Handle synchronous exceptions with proper si_code

ghes_handle_memory_failure() queue both synchronous and asynchronous errors with
flag=0. Then the kernel will notify the process by sending a SIGBUS signal in
memory_failure() with wrong si_code: BUS_MCEERR_AO to the actual user-space
process instead of BUS_MCEERR_AR. The user-space processes rely on the si_code
to distinguish to handle memory failure.

For example, hwpoison-aware user-space processes use the si_code: BUS_MCEERR_AO
for 'action optional' early notifications, and BUS_MCEERR_AR for 'action
required' synchronous/late notifications. Specifically, when a SIGBUS_MCEERR_AR
synchronous signal is delivered to QEMU, it will inject a vSEA to Guest
kernel.[1]

Fix it by seting memory failure flags as MF_ACTION_REQUIRED on synchronous events. (PATCH 1)

2. Handle memory_failure() abnormal fails to avoid a unnecessary reboot

If process mapping fault page, but memory_failure() abnormal return before
try_to_unmap(), for example, the fault page process mapping is KSM page.
In this case, arm64 cannot use the page fault process to terminate the
synchronous exception loop.

This loop can potentially exceed the platform firmware threshold or even trigger
a kernel hard lockup, leading to a system reboot. However, kernel has the
capability to recover from this error.

Fix it by performing a force kill when memory_failure() abnormal fails or when
other abnormal synchronous errors occur. These errors can include situations
such as invalid PA, unexpected severity, no memory failure config support,
invalid GUID section, OOM, etc. (PATCH 2)

3. Handle memory_failure() in current process context which consuming poison

When synchronous errors occur, memory_failure() assume that current process
context is exactly that consuming poison synchronous error.

For example, kill_accessing_process() holds mmap locking of current->mm, does
pagetable walk to find the error virtual address, and sends SIGBUS to the
current process with error info. However, the mm of kworker is not valid,
resulting in a null-pointer dereference. I have fixed this in[3].

	commit 77677cdbc2aa mm,hwpoison: check mm when killing accessing process

Another example is that collect_procs()/kill_procs() walk the task list, only
collect and send sigbus to task which consuming poison. But memory_failure() is
queued and handled by a dedicated kernel thread on arm64 platform.

Fix it by queuing memory_failure() as a task work which runs in current
execution context to synchronously send SIGBUS before ret_to_user. (PATCH 2)

Lv Ying and XiuQi from Huawei also proposed to address similar problem[2][4].
Acknowledge to discussion with them.

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

[1] Add ARMv8 RAS virtualization support in QEMU https://patchew.org/QEMU/20200512030609.19593-1-gengdongjiu@huawei.com/
[2] https://lore.kernel.org/lkml/20221205115111.131568-3-lvying6@huawei.com/
[3] https://lkml.kernel.org/r/20220914064935.7851-1-xueshuai@linux.alibaba.com
[4] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/

