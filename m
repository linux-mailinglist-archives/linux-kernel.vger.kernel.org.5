Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF07F234C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjKUBsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:48:42 -0500
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BDC3;
        Mon, 20 Nov 2023 17:48:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0Vwqn1AR_1700531311;
Received: from 30.240.112.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vwqn1AR_1700531311)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 09:48:33 +0800
Message-ID: <57bd6874-35df-48b0-90d8-45077396b44f@linux.alibaba.com>
Date:   Tue, 21 Nov 2023 09:48:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] ACPI: APEI: handle synchronous errors in task work
 with proper si_code
Content-Language: en-US
To:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
        gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
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
 <20231007072818.58951-1-xueshuai@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231007072818.58951-1-xueshuai@linux.alibaba.com>
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

Hi, ALL,

Gentle ping.

Best Regards,
Shuai

On 2023/10/7 15:28, Shuai Xue wrote:
> Hi, ALL,
> 
> I have rewritten the cover letter with the hope that the maintainer will truly
> understand the necessity of this patch. Both Alibaba and Huawei met the same
> issue in products, and we hope it could be fixed ASAP.
> 
> ## Changes Log
> 
> changes since v8:
> - remove the bug fix tag of patch 2 (per Jarkko Sakkinen)
> - remove the declaration of memory_failure_queue_kick (per Naoya Horiguchi)
> - rewrite the return value comments of memory_failure (per Naoya Horiguchi)
> 
> changes since v7:
> - rebase to Linux v6.6-rc2 (no code changed)
> - rewritten the cover letter to explain the motivation of this patchset
> 
> changes since v6:
> - add more explicty error message suggested by Xiaofei
> - pick up reviewed-by tag from Xiaofei
> - pick up internal reviewed-by tag from Baolin
> 
> changes since v5 by addressing comments from Kefeng:
> - document return value of memory_failure()
> - drop redundant comments in call site of memory_failure() 
> - make ghes_do_proc void and handle abnormal case within it
> - pick up reviewed-by tag from Kefeng Wang 
> 
> changes since v4 by addressing comments from Xiaofei:
> - do a force kill only for abnormal sync errors
> 
> changes since v3 by addressing comments from Xiaofei:
> - do a force kill for abnormal memory failure error such as invalid PA,
> unexpected severity, OOM, etc
> - pcik up tested-by tag from Ma Wupeng
> 
> changes since v2 by addressing comments from Naoya:
> - rename mce_task_work to sync_task_work
> - drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
> - add steps to reproduce this problem in cover letter
> 
> changes since v1:
> - synchronous events by notify type
> - Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/
> 
> 
> ## Cover Letter
> 
> There are two major types of uncorrected recoverable (UCR) errors :
> 
> - Action Required (AR): The error is detected and the processor already
>   consumes the memory. OS requires to take action (for example, offline
>   failure page/kill failure thread) to recover this error.
> 
> - Action Optional (AO): The error is detected out of processor execution
>   context. Some data in the memory are corrupted. But the data have not
>   been consumed. OS is optional to take action to recover this error.
> 
> The main difference between AR and AO errors is that AR errors are synchronous
> events, while AO errors are asynchronous events. Synchronous exceptions, such as
> Machine Check Exception (MCE) on X86 and Synchronous External Abort (SEA) on
> Arm64, are signaled by the hardware when an error is detected and the memory
> access has architecturally been executed.
> 
> Currently, both synchronous and asynchronous errors are queued as AO errors and
> handled by a dedicated kernel thread in a work queue on the ARM64 platform. For
> synchronous errors, memory_failure() is synced using a cancel_work_sync trick to
> ensure that the corrupted page is unmapped and poisoned. Upon returning to
> user-space, the process resumes at the current instruction, triggering a page
> fault. As a result, the kernel sends a SIGBUS signal to the current process due
> to VM_FAULT_HWPOISON.
> 
> However, this trick is not always be effective, this patch set improves the
> recovery process in three specific aspects:
> 
> 1. Handle synchronous exceptions with proper si_code
> 
> ghes_handle_memory_failure() queue both synchronous and asynchronous errors with
> flag=0. Then the kernel will notify the process by sending a SIGBUS signal in
> memory_failure() with wrong si_code: BUS_MCEERR_AO to the actual user-space
> process instead of BUS_MCEERR_AR. The user-space processes rely on the si_code
> to distinguish to handle memory failure.
> 
> For example, hwpoison-aware user-space processes use the si_code:
> BUS_MCEERR_AO for 'action optional' early notifications, and BUS_MCEERR_AR
> for 'action required' synchronous/late notifications. Specifically, when a
> signal with SIGBUS_MCEERR_AR is delivered to QEMU, it will inject a vSEA to
> Guest kernel. In contrast, a signal with SIGBUS_MCEERR_AO will be ignored
> by QEMU.[1]
> 
> Fix it by seting memory failure flags as MF_ACTION_REQUIRED on synchronous events. (PATCH 1)
> 
> 2. Handle memory_failure() abnormal fails to avoid a unnecessary reboot
> 
> If process mapping fault page, but memory_failure() abnormal return before
> try_to_unmap(), for example, the fault page process mapping is KSM page.
> In this case, arm64 cannot use the page fault process to terminate the
> synchronous exception loop.[4]
> 
> This loop can potentially exceed the platform firmware threshold or even trigger
> a kernel hard lockup, leading to a system reboot. However, kernel has the
> capability to recover from this error.
> 
> Fix it by performing a force kill when memory_failure() abnormal fails or when
> other abnormal synchronous errors occur. These errors can include situations
> such as invalid PA, unexpected severity, no memory failure config support,
> invalid GUID section, OOM, etc. (PATCH 2)
> 
> 3. Handle memory_failure() in current process context which consuming poison
> 
> When synchronous errors occur, memory_failure() assume that current process
> context is exactly that consuming poison synchronous error.
> 
> For example, kill_accessing_process() holds mmap locking of current->mm, does
> pagetable walk to find the error virtual address, and sends SIGBUS to the
> current process with error info. However, the mm of kworker is not valid,
> resulting in a null-pointer dereference. I have fixed this in[3].
> 
>     commit 77677cdbc2aa mm,hwpoison: check mm when killing accessing process
> 
> Another example is that collect_procs()/kill_procs() walk the task list, only
> collect and send sigbus to task which consuming poison. But memory_failure() is
> queued and handled by a dedicated kernel thread on arm64 platform.
> 
> Fix it by queuing memory_failure() as a task work which runs in current
> execution context to synchronously send SIGBUS before ret_to_user. (PATCH 2)
> 
> ** In summary, this patch set handles synchronous errors in task work with
> proper si_code so that hwpoison-aware process can recover from errors, and
> fixes (potentially) abnormal cases. **
> 
> Lv Ying and XiuQi from Huawei also proposed to address similar problem[2][4].
> Acknowledge to discussion with them.
> 
> ## Steps to Reproduce This Problem
> 
> To reproduce this problem:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 5 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO error
> and it is not fact.
> 
> After this patch set:
> 
> 	# STEP1: enable early kill mode
> 	#sysctl -w vm.memory_failure_early_kill=1
> 	vm.memory_failure_early_kill = 1
> 
> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 	#einj_mem_uc single
> 	0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
> 	injecting ...
> 	triggering ...
> 	signal 7 code 4 addr 0xffffb0d75000
> 	page not present
> 	Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR error
> as we expected.
> 
> [1] Add ARMv8 RAS virtualization support in QEMU https://patchew.org/QEMU/20200512030609.19593-1-gengdongjiu@huawei.com/
> [2] https://lore.kernel.org/lkml/20221205115111.131568-3-lvying6@huawei.com/
> [3] https://lkml.kernel.org/r/20220914064935.7851-1-xueshuai@linux.alibaba.com
> [4] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
> 
> Shuai Xue (2):
>   ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on
>     synchronous events
>   ACPI: APEI: handle synchronous exceptions in task work
> 
>  arch/x86/kernel/cpu/mce/core.c |   9 +--
>  drivers/acpi/apei/ghes.c       | 113 ++++++++++++++++++++++-----------
>  include/acpi/ghes.h            |   3 -
>  include/linux/mm.h             |   1 -
>  mm/memory-failure.c            |  22 ++-----
>  5 files changed, 82 insertions(+), 66 deletions(-)
> 
