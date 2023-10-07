Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A877BC40F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjJGCB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:01:56 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089F5BD;
        Fri,  6 Oct 2023 19:01:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0VtTbrvR_1696644107;
Received: from 30.240.114.194(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VtTbrvR_1696644107)
          by smtp.aliyun-inc.com;
          Sat, 07 Oct 2023 10:01:50 +0800
Message-ID: <645ee424-316b-c093-6113-9abdfb42dab5@linux.alibaba.com>
Date:   Sat, 7 Oct 2023 10:01:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v8 2/2] ACPI: APEI: handle synchronous exceptions
 in task work
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     rafael@kernel.org, wangkefeng.wang@huawei.com,
        tanxiaofei@huawei.com, mawupeng1@huawei.com, tony.luck@intel.com,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com, james.morse@arm.com,
        gregkh@linuxfoundation.org, will@kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
        ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
        baolin.wang@linux.alibaba.com, bp@alien8.de, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, jarkko@kernel.org,
        lenb@kernel.org, hpa@zytor.com, robert.moore@intel.com,
        lvying6@huawei.com, xiexiuqi@huawei.com,
        zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
 <20231003082858.GA750796@ik1-406-35019.vs.sakura.ne.jp>
Content-Language: en-US
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231003082858.GA750796@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/3 16:28, Naoya Horiguchi wrote:
> On Tue, Sep 19, 2023 at 10:21:27AM +0800, Shuai Xue wrote:
>> Hardware errors could be signaled by synchronous interrupt, e.g.  when an
>> error is detected by a background scrubber, or signaled by synchronous
>> exception, e.g. when an uncorrected error is consumed. Both synchronous and
>> asynchronous error are queued and handled by a dedicated kthread in
>> workqueue.
>>
>> commit 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for
>> synchronous errors") keep track of whether memory_failure() work was
>> queued, and make task_work pending to flush out the workqueue so that the
>> work for synchronous error is processed before returning to user-space.
>> The trick ensures that the corrupted page is unmapped and poisoned. And
>> after returning to user-space, the task starts at current instruction which
>> triggering a page fault in which kernel will send SIGBUS to current process
>> due to VM_FAULT_HWPOISON.
>>
>> However, the memory failure recovery for hwpoison-aware mechanisms does not
>> work as expected. For example, hwpoison-aware user-space processes like
>> QEMU register their customized SIGBUS handler and enable early kill mode by
>> seting PF_MCE_EARLY at initialization. Then the kernel will directy notify
>> the process by sending a SIGBUS signal in memory failure with wrong
>> si_code: the actual user-space process accessing the corrupt memory
>> location, but its memory failure work is handled in a kthread context, so
>> it will send SIGBUS with BUS_MCEERR_AO si_code to the actual user-space
>> process instead of BUS_MCEERR_AR in kill_proc().
>>
>> To this end, separate synchronous and asynchronous error handling into
>> different paths like X86 platform does:
>>
>> - valid synchronous errors: queue a task_work to synchronously send SIGBUS
>>   before ret_to_user.
>> - valid asynchronous errors: queue a work into workqueue to asynchronously
>>   handle memory failure.
>> - abnormal branches such as invalid PA, unexpected severity, no memory
>>   failure config support, invalid GUID section, OOM, etc.
>>
>> Then for valid synchronous errors, the current context in memory failure is
>> exactly belongs to the task consuming poison data and it will send SIBBUS
>> with proper si_code.
>>
>> Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>  arch/x86/kernel/cpu/mce/core.c |  9 +---
>>  drivers/acpi/apei/ghes.c       | 84 +++++++++++++++++++++-------------
>>  include/acpi/ghes.h            |  3 --
>>  mm/memory-failure.c            | 17 ++-----
>>  4 files changed, 56 insertions(+), 57 deletions(-)
>>
> ...
> 
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 4d6e43c88489..80e1ea1cc56d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2163,7 +2163,9 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   *
>>   * Return: 0 for successfully handled the memory error,
>>   *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + *         -EHWPOISON for already sent SIGBUS to the current process with
>> + *         the proper error info,
> 
> The meaning of this comment is understood, but the sentence seems to be
> a little too long. Could you sort this out with bullet points (like below)?
> 
>  * Return values:
>  *   0             - success
>  *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event.
>  *   -EHWPOISON    - sent SIGBUS to the current process with the proper
>  *                   error info by kill_accessing_process().
>  *   other negative values - failure
> 

Of course, will do it.


>> + *         other negative error code on failure.
>>   */
>>  int memory_failure(unsigned long pfn, int flags)
>>  {
>> @@ -2445,19 +2447,6 @@ static void memory_failure_work_func(struct work_struct *work)
>>  	}
>>  }
>>  
>> -/*
>> - * Process memory_failure work queued on the specified CPU.
>> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
>> - */
>> -void memory_failure_queue_kick(int cpu)
>> -{
>> -	struct memory_failure_cpu *mf_cpu;
>> -
>> -	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
>> -	cancel_work_sync(&mf_cpu->work);
>> -	memory_failure_work_func(&mf_cpu->work);
>> -}
>> -
> 
> The declaration of memory_failure_queue_kick() still remains in include/linux/mm.h,
> so you can remove it together.

Good catch, will remove it too.

> 
> Thanks,
> Naoya Horiguchi


Thank you for valuable comments.

Best Regards,
Shuai
