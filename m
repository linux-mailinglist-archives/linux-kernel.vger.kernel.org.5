Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C187F88A7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 07:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjKYGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 01:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYGoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 01:44:54 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDC7C1;
        Fri, 24 Nov 2023 22:44:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0Vx3Rwaa_1700894693;
Received: from 30.240.112.178(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vx3Rwaa_1700894693)
          by smtp.aliyun-inc.com;
          Sat, 25 Nov 2023 14:44:57 +0800
Message-ID: <9e92e600-86a4-4456-9de4-b597854b107c@linux.alibaba.com>
Date:   Sat, 25 Nov 2023 14:44:52 +0800
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
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231123150710.GEZV9qnkWMBWrggGc1@fat_crate.local>
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



On 2023/11/23 23:07, Borislav Petkov wrote:

Hi, Borislav,

Thank you for your reply and advice.


> On Sat, Oct 07, 2023 at 03:28:16PM +0800, Shuai Xue wrote:
>> However, this trick is not always be effective
> 
> So far so good.
> 
> What's missing here is why "this trick" is not always effective.

> 
> Basically to explain what exactly the problem is.

I think the main point is that this trick for AR error is not effective,
because:

- an AR error consumed by current process is deferred to handle in a
  dedicated kernel thread, but memory_failure() assumes that it runs in the
  current context
- another page fault is not unnecessary, we can send sigbus to current
  process in the first Synchronous External Abort SEA on arm64 (analogy
  Machine Check Exception on x86)

> 
>> For example, hwpoison-aware user-space processes use the si_code:
>> BUS_MCEERR_AO for 'action optional' early notifications, and BUS_MCEERR_AR
>> for 'action required' synchronous/late notifications. Specifically, when a
>> signal with SIGBUS_MCEERR_AR is delivered to QEMU, it will inject a vSEA to
>> Guest kernel. In contrast, a signal with SIGBUS_MCEERR_AO will be ignored
>> by QEMU.[1]
>>
>> Fix it by seting memory failure flags as MF_ACTION_REQUIRED on synchronous events. (PATCH 1)
> 
> So you're fixing qemu by "fixing" the kernel?
> 
> This doesn't make any sense.

I just give an example that the user space process *really* relys on the
si_code of signal to handle hardware errors

> 
> Make errors which are ACPI_HEST_NOTIFY_SEA type return
> MF_ACTION_REQUIRED so that it *happens* to fix your use case.
> 
> Sounds like a lot of nonsense to me.
> 
> What is the issue here you're trying to solve?

The SIGBUS si_codes defined in include/uapi/asm-generic/siginfo.h says:

    /* hardware memory error consumed on a machine check: action required */
    #define BUS_MCEERR_AR	4
    /* hardware memory error detected in process but not consumed: action optional*/
    #define BUS_MCEERR_AO	5

When a synchronous error is consumed by Guest, the kernel should send a
signal with BUS_MCEERR_AR instead of BUS_MCEERR_AO.

> 
>> 2. Handle memory_failure() abnormal fails to avoid a unnecessary reboot
>>
>> If process mapping fault page, but memory_failure() abnormal return before
>> try_to_unmap(), for example, the fault page process mapping is KSM page.
>> In this case, arm64 cannot use the page fault process to terminate the
>> synchronous exception loop.[4]
>>
>> This loop can potentially exceed the platform firmware threshold or even trigger
>> a kernel hard lockup, leading to a system reboot. However, kernel has the
>> capability to recover from this error.
>>
>> Fix it by performing a force kill when memory_failure() abnormal fails or when
>> other abnormal synchronous errors occur.
> 
> Just like that?
> 
> Without giving the process the opportunity to even save its other data?

Exactly.

> 
> So this all is still very confusing, patches definitely need splitting
> and this whole thing needs restraint.
> 
> You go and do this: you split *each* issue you're addressing into
> a separate patch and explain it like this:
> 
> ---
> 1. Prepare the context for the explanation briefly.
> 
> 2. Explain the problem at hand.
> 
> 3. "It happens because of <...>"
> 
> 4. "Fix it by doing X"
> 
> 5. "(Potentially do Y)."
> ---
> 
> and each patch explains *exactly* *one* issue, what happens, why it
> happens and just the fix for it and *why* it is needed.
> 
> Otherwise, this is unreviewable.

Thank you for your valuable suggestion, I will split the patches and
resubmit a new patch set.

> 
> Thx.
> 

Best Regards,
Shuai
