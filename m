Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313D37AE614
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjIZGiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjIZGiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:38:18 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F760E6;
        Mon, 25 Sep 2023 23:38:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0Vsvr0J9_1695710284;
Received: from 30.240.112.49(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vsvr0J9_1695710284)
          by smtp.aliyun-inc.com;
          Tue, 26 Sep 2023 14:38:07 +0800
Message-ID: <078b410f-e3b2-0355-d993-40ac46b99870@linux.alibaba.com>
Date:   Tue, 26 Sep 2023 14:38:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RESEND PATCH v8 2/2] ACPI: APEI: handle synchronous exceptions
 in task work
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, rafael@kernel.org,
        wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
        mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, james.morse@arm.com,
        gregkh@linuxfoundation.org, will@kernel.org
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
 <20230919022127.69732-3-xueshuai@linux.alibaba.com>
 <CVS371QBH3QK.3354DSBK53OFS@suppilovahvero>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <CVS371QBH3QK.3354DSBK53OFS@suppilovahvero>
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



On 2023/9/25 23:00, Jarkko Sakkinen wrote:
> On Tue Sep 19, 2023 at 5:21 AM EEST, Shuai Xue wrote:
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
> 
> Did 7f17b4a121d0 actually break something that was not broken before?
> 
> If not, this is (afaik) not a bug fix.

Hi, Jarkko,

It did not. It keeps track of whether memory_failure() work was queued,
and makes task_work pending to flush out the queue. But if no work queued for
synchronous error due to abnormal branches, it does not do a force kill to
current process resulting a hard lockup due to exception loop.

It is fine to me to remove the bug fix tag if you insist on removing it.

Best Regards,
Shuai

