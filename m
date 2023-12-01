Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715218001C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjLAC6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAC6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:58:46 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBB1717;
        Thu, 30 Nov 2023 18:58:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxTrXdf_1701399524;
Received: from 30.240.114.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxTrXdf_1701399524)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 10:58:47 +0800
Message-ID: <8cefd789-36da-4208-9511-f826a4508612@linux.alibaba.com>
Date:   Fri, 1 Dec 2023 10:58:42 +0800
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
 <a3cd9b79-4be5-4f77-b32a-51a624a65ec0@linux.alibaba.com>
 <20231130144001.GGZWiewYtvMSJir62f@fat_crate.local>
 <d83545f0-af15-10bc-0f5d-9b531b54b9dd@arm.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <d83545f0-af15-10bc-0f5d-9b531b54b9dd@arm.com>
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



On 2023/12/1 01:43, James Morse wrote:
> Hi Boris,
> 
> On 30/11/2023 14:40, Borislav Petkov wrote:
>> FTR, this is starting to make sense, thanks for explaining.
>>
>> Replying only to this one for now:
>>
>> On Thu, Nov 30, 2023 at 10:58:53AM +0800, Shuai Xue wrote:
>>> To reproduce this problem:
>>>
>>> 	# STEP1: enable early kill mode
>>> 	#sysctl -w vm.memory_failure_early_kill=1
>>> 	vm.memory_failure_early_kill = 1
>>>
>>> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
>>
>> So this is for ARM folks to deal with, BUT:
>>
>> A consumed uncorrectable error on x86 means panic. On some hw like on
>> AMD, that error doesn't even get seen by the OS but the hw does
>> something called syncflood to prevent further error propagation. So
>> there's no any action required - the hw does that.

The "consume" is at the application point of view, e.g. a memory read. If
poison is enable, then a SRAR error will be detected and a MCE raised
at the point of the consumption in the execution flow.

A generic Intel x86 hw behaves like below:

1. UE Error Inject at a known Physical Address. (by einj_mem_uc through EINJ interface)
2. Core Issue a Memory Read to the same Physical Address (by a singe memory read)
3. iMC Detects the error.
4. HA logs UCA error and signals CMCI if enabled
5. HA Forward data with poison indication bit set.
6. CBo detects the Poison data. Does not log any error.
7. MLC detects the Poison data.
8. DCU detects the Poison data, logs SRAR error and trigger MCERR if recoverable
9. OS/VMM takes corresponding recovery action based on affected state.

In our example:
-  step 2 is triggered by a singe memory read.
-  step 8: UCR errors detected on data load, MCACOD 134H, triggering MCERR
-  step 9: the kernel is excepted to send sigbus with si_code BUS_MCEERR_AR (code 4)

I also run the same test  in AMD EPYC platform, e.g. Milan, Genoa, which
behaves the same as Intel Xeon platform, e.g. Icelake, SPR.

The ARMv8.2 RAS extension support similar data poison mechanism, a
Synchronous External Abort on arm64 (analogy Machine Check Exception on
x86) will be trigger in setp 8. See James comments for details.  But the
kernel sends sigbus with si_code BUS_MCEERR_AO (code 5) , tested on
Alibaba Yitian710 and Huawei Kunepng 920.


>>
>> But I'd like to hear from ARM folks whether consuming an uncorrectable
>> error even lets software run. Dunno.
> 
> I think we mean different things by 'consume' here.
> 
> I'd assume Shuai's test is poisoning a cache-line. When the CPU tries to access that
> cache-line it will get an 'external abort' signal back from the memory system. Shuai - is
> this what you mean by 'consume' - the CPU received external abort from the poisoned cache
> line?
> 

Yes, exactly. Thank you for point it out. We are talking about synchronous errors.

> It's then up to the CPU whether it can put the world back in order to take this as
> synchronous-external-abort or asynchronous-external-abort, which for arm64 are two
> different interrupt/exception types.
> The synchronous exceptions can't be masked, but the asynchronous one can.
> If by the time the asynchronous-external-abort interrupt/exception has been unmasked, the
> CPU has used the poisoned value in some calculation (which is what we usually mean by
> consume) which has resulted in a memory access - it will report the error as 'uncontained'
> because the error has been silently propagated. APEI should always report those a 'fatal',
> and there is little point getting the OS involved at this point. Also in this category are
> things like 'tag ram corruption', where you can no longer trust anything about memory.
> 
> Everything in this thread is about synchronous errors where this can't happen. The CPU
> stops and does takes an interrupt/exception instead.
> 
> 

Thank you for explaining.

Best Regards,
Shuai
