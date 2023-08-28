Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8706A78A404
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 03:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjH1BmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 21:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjH1BmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 21:42:07 -0400
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A3113;
        Sun, 27 Aug 2023 18:42:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VqdpLPU_1693186918;
Received: from 30.240.112.203(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VqdpLPU_1693186918)
          by smtp.aliyun-inc.com;
          Mon, 28 Aug 2023 09:42:00 +0800
Message-ID: <54114b64-4726-da46-8ffa-16749ec0887a@linux.alibaba.com>
Date:   Mon, 28 Aug 2023 09:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] HWPOISON: add a pr_err message when forcibly send a
 sigbus
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org
References: <20230819102212.21103-1-xueshuai@linux.alibaba.com>
 <20230821105025.GB19469@willie-the-truck>
 <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <44c4d801-3e21-426b-2cf0-a7884d2bf5ff@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/22 09:15, Shuai Xue wrote:
> 
> 
> On 2023/8/21 18:50, Will Deacon wrote:
>> On Sat, Aug 19, 2023 at 06:22:12PM +0800, Shuai Xue wrote:
>>> When a process tries to access a page that is already offline
>>
>> How does this happen?
> 
> Case 1:
> 
> When a process consume poison, it will trigger a Synchronous External Abort.
> The memory-failure.c on arm64 platform does not work as expected, it does NOT
> send sigbus to the process consumed poison because GHES handle all notification
> as Action Option event. Process will not be collected to be killed unless explicitly
> set early kill in mm/memory-failure.c:collect_procs(). Even worse, QEMU relies on
> SIGBUS and its code to perform vSEA injection into the Guest Kernel.
> 
> The memory-failure.c only offlines the page which unmaps the page from process.
> and the process will start from the last PC so that a page fault occurs. Then
> a sigbus will send to process in do_page_fault() with BUS_MCEERR_AR.
> 
> By the way, I have sent a patch set to solve the memory failure workflow in GHES[1]
> collect some reviewed-tags, but there has been no response since the last version
> sent 4 months ago. Could you please help to review it? Thank you.
> 
> https://lore.kernel.org/all/20230606074238.97166-1-xueshuai@linux.alibaba.com/
> 
> Case 2:
> 
> When a poison page shared by many processes, the memory-failure.c unmap the poison page
> from all processes and only send sigbus to the process which accessing the poison page.
> The poison page may be accessed by other processes later and it triggers a page fault,
> then a sigbus will send to process in do_page_fault() with BUS_MCEERR_AR.
> 
> 
>>
>>> the kernel will send a sigbus signal with the BUS_MCEERR_AR code. This
>>> signal is typically handled by a registered sigbus handler in the
>>> process. However, if the process does not have a registered sigbus
>>> handler, it is important for end users to be informed about what
>>> happened.
>>>
>>> To address this, add an error message similar to those implemented on
>>> the x86, powerpc, and parisc platforms.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> ---
>>>  arch/arm64/mm/fault.c  | 2 ++
>>>  arch/parisc/mm/fault.c | 5 ++---
>>>  arch/x86/mm/fault.c    | 3 +--
>>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>>> index 3fe516b32577..38e2186882bd 100644
>>> --- a/arch/arm64/mm/fault.c
>>> +++ b/arch/arm64/mm/fault.c
>>> @@ -679,6 +679,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>>  	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
>>>  		unsigned int lsb;
>>>  
>>> +		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
>>> +		       current->comm, current->pid, far);
>>>  		lsb = PAGE_SHIFT;
>>>  		if (fault & VM_FAULT_HWPOISON_LARGE)
>>>  			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>>
>> Hmm, I'm not convinced by this. We have 'show_unhandled_signals' already,
>> and there's plenty of code in memory-failure.c for handling poisoned pages
>> reported by e.g. GHES. I don't think dumping extra messages in dmesg from
>> the arch code really adds anything.
> 
> I see the show_unhandled_signals() will dump the stack but it rely on
> /proc/sys/debug/exception-trace be set.
> 
> The memory failure is the top issue in our production cloud and also other hyperscalers.
> We have received complaints from our operations engineers and end users that processes
> are being inexplicably killed :(. Could you please consider add a message?
> 
> Thank you.
> 
> Best Regards,
> Shuai

I apologize that the two cases mentioned above failed to convince you. Let me provide an example of
an online outage ticket to help you better understand the challenges I faced in a production environment.
The only log collected from console is pasted bellow:

[2023-06-22 21:55:31.352444][5975153.869131] Memory failure: 0x7740c0: recovery action for dirty page: Recovered
[2023-06-22 21:55:31.352446][5975153.878190] EDAC MC0: 1 UE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:31.778747][5975154.296056] EDAC MC0: 2 CE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:32.204051][5975154.721742] EDAC MC0: 1 CE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:32.759710][5975155.280550] EDAC MC0: 1 CE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:32.817890][5975155.337168] EDAC MC0: 1 CE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:33.786742][5975156.304515] EDAC MC0: 1 CE memory read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxx xxx)
[2023-06-22 21:55:33.843280][5975156.361284] EDAC MC0: 3 CE memorERROR: C00000002:V030xxxx I0 D6476950-xxxx 7731xxxx
[2023-06-22 21:55:34.218603]y read error on CPU_SrcID#0_MC#0_Chan#1_DIMM#0 (xxxx)
[2023-06-22 21:55:34.269969]ERROR: C00000002:V030xxx I0 D6476950-xxxx 7731xxxx
[2023-06-24 00:40:54.482177]ERROR: C00000002:V030xxx I0 A8CEC941-xxxx 7731xxxx

(For security reasons, I have concealed some information.)

Typically, a temporary virtual team consisting of operations, firmware, and OS engineers will analyze this log.

It is really hard to infer exactly what is going on and where the problem occurred. Does the kernel send a SIGBUS
to handle the memory failure as expected? I am not able to provide a conclusion that is 100% certain but a pr_err
message would help.

Thank you.

Best Regards
Shuai.
