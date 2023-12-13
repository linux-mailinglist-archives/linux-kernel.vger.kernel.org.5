Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA599811BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379344AbjLMSFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235091AbjLMSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:05:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4CC8F3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:05:15 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C35C15;
        Wed, 13 Dec 2023 10:06:01 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CACCA3F762;
        Wed, 13 Dec 2023 10:05:12 -0800 (PST)
Message-ID: <384a9be4-8123-3b3a-3be7-c549c8126fc8@arm.com>
Date:   Wed, 13 Dec 2023 18:05:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 09/24] x86/resctrl: Use __set_bit()/__clear_bit()
 instead of open coding
Content-Language: en-GB
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-10-james.morse@arm.com>
 <7b6ae291-b1df-4a4a-a415-da1eaeed6775@intel.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <7b6ae291-b1df-4a4a-a415-da1eaeed6775@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 09/11/2023 17:44, Reinette Chatre wrote:
> On 10/25/2023 11:03 AM, James Morse wrote:
>> The resctrl CLOSID allocator uses a single 32bit word to track which
>> CLOSID are free. The setting and clearing of bits is open coded.
>>
>> A subsequent patch adds closid_allocated(), which adds more open
> 
> (Note use of "A subsequent patch ")

Yup, I've dropped this paragraph.


>> coded bitmaps operations. These will eventually need changing to use
>> the bitops helpers so that a CLOSID bitmap of the correct size can be
>> allocated dynamically.
>>
>> Convert the existing open coded bit manipulations of closid_free_map
>> to use __set_bit() and friends. These don't need to be atomic as this
>> list is protected by the mutex.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 9864cb49d58c..f6051a3e7262 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -131,7 +131,7 @@ static void closid_init(void)
>>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>>  
>>  	/* CLOSID 0 is always reserved for the default group */
> 
> Seems appropriate for the comment to be updated to the new define also.

Sure,

> With that addressed you can add:
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

James
