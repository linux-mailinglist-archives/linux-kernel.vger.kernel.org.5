Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBAC7FF8A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346629AbjK3Rnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjK3Rnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:43:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2F7210FC;
        Thu, 30 Nov 2023 09:43:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E42F1756;
        Thu, 30 Nov 2023 09:44:35 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B012C3F6C4;
        Thu, 30 Nov 2023 09:43:44 -0800 (PST)
Message-ID: <d83545f0-af15-10bc-0f5d-9b531b54b9dd@arm.com>
Date:   Thu, 30 Nov 2023 17:43:38 +0000
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
 <a3cd9b79-4be5-4f77-b32a-51a624a65ec0@linux.alibaba.com>
 <20231130144001.GGZWiewYtvMSJir62f@fat_crate.local>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20231130144001.GGZWiewYtvMSJir62f@fat_crate.local>
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

Hi Boris,

On 30/11/2023 14:40, Borislav Petkov wrote:
> FTR, this is starting to make sense, thanks for explaining.
> 
> Replying only to this one for now:
> 
> On Thu, Nov 30, 2023 at 10:58:53AM +0800, Shuai Xue wrote:
>> To reproduce this problem:
>>
>> 	# STEP1: enable early kill mode
>> 	#sysctl -w vm.memory_failure_early_kill=1
>> 	vm.memory_failure_early_kill = 1
>>
>> 	# STEP2: inject an UCE error and consume it to trigger a synchronous error
> 
> So this is for ARM folks to deal with, BUT:
> 
> A consumed uncorrectable error on x86 means panic. On some hw like on
> AMD, that error doesn't even get seen by the OS but the hw does
> something called syncflood to prevent further error propagation. So
> there's no any action required - the hw does that.
> 
> But I'd like to hear from ARM folks whether consuming an uncorrectable
> error even lets software run. Dunno.

I think we mean different things by 'consume' here.

I'd assume Shuai's test is poisoning a cache-line. When the CPU tries to access that
cache-line it will get an 'external abort' signal back from the memory system. Shuai - is
this what you mean by 'consume' - the CPU received external abort from the poisoned cache
line?

It's then up to the CPU whether it can put the world back in order to take this as
synchronous-external-abort or asynchronous-external-abort, which for arm64 are two
different interrupt/exception types.
The synchronous exceptions can't be masked, but the asynchronous one can.
If by the time the asynchronous-external-abort interrupt/exception has been unmasked, the
CPU has used the poisoned value in some calculation (which is what we usually mean by
consume) which has resulted in a memory access - it will report the error as 'uncontained'
because the error has been silently propagated. APEI should always report those a 'fatal',
and there is little point getting the OS involved at this point. Also in this category are
things like 'tag ram corruption', where you can no longer trust anything about memory.

Everything in this thread is about synchronous errors where this can't happen. The CPU
stops and does takes an interrupt/exception instead.


Thanks,

James
