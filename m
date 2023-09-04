Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2617915C8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349434AbjIDKk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjIDKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:40:58 -0400
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CC7CA;
        Mon,  4 Sep 2023 03:40:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VrJ9gP4_1693824049;
Received: from 30.240.117.141(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VrJ9gP4_1693824049)
          by smtp.aliyun-inc.com;
          Mon, 04 Sep 2023 18:40:50 +0800
Message-ID: <2540b570-1c1a-7d1b-59e9-6c32d9947c44@linux.alibaba.com>
Date:   Mon, 4 Sep 2023 18:40:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>, Will Deacon <will@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
 <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
 <20230830221814.GB30121@willie-the-truck>
 <d1c8c0fa-815f-6804-e4e5-89a5259e4bb1@linux.alibaba.com>
 <c9284441-be6e-d2a0-9283-9e90c9d2da41@gmx.de>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <c9284441-be6e-d2a0-9283-9e90c9d2da41@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/31 17:06, Helge Deller wrote:
> On 8/31/23 05:29, Shuai Xue wrote:
>> On 2023/8/31 06:18, Will Deacon wrote:
>>> On Mon, Aug 28, 2023 at 09:41:55AM +0800, Shuai Xue wrote:
>>>> On 2023/8/22 09:15, Shuai Xue wrote:
>>>>> On 2023/8/21 18:50, Will Deacon wrote:
>>>>>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>>>>>> index 3fe516b32577..38e2186882bd 100644
>>>>>>> --- a/arch/arm64/mm/fault.c
>>>>>>> +++ b/arch/arm64/mm/fault.c
>>>>>>> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>>>>>       } else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
>>>>>>>           unsigned int lsb;
>>>>>>>
>>>>>>> +        pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>>>>>>> +               current->comm, current->pid, far);
>>>>>>>           lsb = PAGE_SHIFT;
>>>>>>>           if (fault & VM_FAULT_HWPOISON_LARGE)
>>>>>>>               lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>>>>>>
>>>>>> Hmm, I'm not convinced by this. We have 'show_unhandled_signals' already,
>>>>>> and there's plenty of code in memory-failure.c for handling poisoned pages
>>>>>> reported by e.g. GHES. I don't think dumping extra messages in dmesg from
>>>>>> the arch code really adds anything.
>>>>>
>>>>> I see the show_unhandled_signals() will dump the stack but it rely on
>>>>> /proc/sys/debug/exception-trace be set.
>>>>>
>>>>> The memory failure is the top issue in our production cloud and also other hyperscalers.
>>>>> We have received complaints from our operations engineers and end users that processes
>>>>> are being inexplicably killed :(. Could you please consider add a message?
>>>
>>> I don't have any objection to logging this stuff somehow, I'm just not
>>> convinced that the console is the best place for that information in 2023.
>>> Is there really nothing better?
> 
>> I agree that console might not the better place, but it still plays an important role.
>> IMO the most direct idea for end user to check what happened is to check by viewing
>> the dmesg. In addition, we deployed some log store service collects all cluster dmesg
>> from /var/log/kern.
> 
> Right, pr_err() is not just console.
> It ends up in the syslog, which ends up in a lot of places, e.g. through syslog forwarding.
> Most monitoring tools monitor the syslog as well.
> 
> So, IMHO pr_err() is the right thing.
> 
> Helge
> 

Totally agreed.

Thank you.

Best Regards,
Shuai

