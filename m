Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C497FE072
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 20:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjK2TrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjK2TrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 14:47:05 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38715E6;
        Wed, 29 Nov 2023 11:47:11 -0800 (PST)
Received: from [192.168.4.26] (unknown [47.186.13.91])
        by linux.microsoft.com (Postfix) with ESMTPSA id 170A820B74C0;
        Wed, 29 Nov 2023 11:47:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 170A820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701287230;
        bh=/AE04joHGbexNg6/1EM+o2YovtZhSbAJbfvFr6KppsI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m2zcYwwKjEICCbmm6pNwRqAhVUCXZ16/8j+Rm7KklfOt+2Ayb4zeushfGcTbZxznq
         3hN7N2zKM0A0/gQ44k2UL+nPl6XrqJsEKFGafJpDqPaapCdFHry5gFf1f4pq+6pJ/l
         apo4cqq0Sd+X0a18QxRWb+mfxOTM3r6ttMVsuAlE=
Message-ID: <e430efa3-6a7a-44c8-a1d2-9943c76f748e@linux.microsoft.com>
Date:   Wed, 29 Nov 2023 13:47:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/19] heki: x86: Protect guest kernel memory using
 the KVM hypervisor
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Alexander Graf <graf@amazon.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Forrest Yuan Yu <yuanyu@google.com>,
        James Gowans <jgowans@amazon.com>,
        James Morris <jamorris@linux.microsoft.com>,
        John Andersen <john.s.andersen@intel.com>,
        Marian Rotariu <marian.c.rotariu@gmail.com>,
        =?UTF-8?Q?Mihai_Don=C8=9Bu?= <mdontu@bitdefender.com>,
        =?UTF-8?B?TmljdciZb3IgQ8OuyJt1?= <nicu.citu@icloud.com>,
        Thara Gopinath <tgopinath@microsoft.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zahra Tarkhani <ztarkhani@microsoft.com>,
        =?UTF-8?Q?=C8=98tefan_=C8=98icleru?= <ssicleru@bitdefender.com>,
        dev@lists.cloudhypervisor.org, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, qemu-devel@nongnu.org,
        virtualization@lists.linux-foundation.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
References: <20231113022326.24388-1-mic@digikod.net>
 <20231113022326.24388-19-mic@digikod.net>
 <20231113085403.GC16138@noisy.programming.kicks-ass.net>
 <b1dc0963-ab99-4a79-af19-ef5ed981fa60@linux.microsoft.com>
 <20231127200308.GY3818@noisy.programming.kicks-ass.net>
Content-Language: en-US
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
In-Reply-To: <20231127200308.GY3818@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/23 14:03, Peter Zijlstra wrote:
> On Mon, Nov 27, 2023 at 11:05:23AM -0600, Madhavan T. Venkataraman wrote:
>> Apologies for the late reply. I was on vacation. Please see my response below:
>>
>> On 11/13/23 02:54, Peter Zijlstra wrote:
>>> On Sun, Nov 12, 2023 at 09:23:25PM -0500, Mickaël Salaün wrote:
>>>> From: Madhavan T. Venkataraman <madvenka@linux.microsoft.com>
>>>>
>>>> Implement a hypervisor function, kvm_protect_memory() that calls the
>>>> KVM_HC_PROTECT_MEMORY hypercall to request the KVM hypervisor to
>>>> set specified permissions on a list of guest pages.
>>>>
>>>> Using the protect_memory() function, set proper EPT permissions for all
>>>> guest pages.
>>>>
>>>> Use the MEM_ATTR_IMMUTABLE property to protect the kernel static
>>>> sections and the boot-time read-only sections. This enables to make sure
>>>> a compromised guest will not be able to change its main physical memory
>>>> page permissions. However, this also disable any feature that may change
>>>> the kernel's text section (e.g., ftrace, Kprobes), but they can still be
>>>> used on kernel modules.
>>>>
>>>> Module loading/unloading, and eBPF JIT is allowed without restrictions
>>>> for now, but we'll need a way to authenticate these code changes to
>>>> really improve the guests' security. We plan to use module signatures,
>>>> but there is no solution yet to authenticate eBPF programs.
>>>>
>>>> Being able to use ftrace and Kprobes in a secure way is a challenge not
>>>> solved yet. We're looking for ideas to make this work.
>>>>
>>>> Likewise, the JUMP_LABEL feature cannot work because the kernel's text
>>>> section is read-only.
>>>
>>> What is the actual problem? As is the kernel text map is already RO and
>>> never changed.
>>
>> For the JUMP_LABEL optimization, the text needs to be patched at some point.
>> That patching requires a writable mapping of the text page at the time of
>> patching.
>>
>> In this Heki feature, we currently lock down the kernel text at the end of
>> kernel boot just before kicking off the init process. The lockdown is
>> implemented by setting the permissions of a text page to R_X in the extended
>> page table and not allowing write permissions in the EPT after that. So, jump label
>> patching during kernel boot is not a problem. But doing it after kernel
>> boot is a problem.
> 
> But you see, that's exactly what the kernel already does with the normal
> permissions. They get set to RX after init and are never changed.
> 
> See the previous patch, we establish a read-write alias and write there.
> 
> You seem to lack basic understanding of how the kernel works in this
> regard, which makes me very nervous about you touching any of this.
> 
> I must also say I really dislike your extra/random permssion calls all
> over the place. They don't really get us anything afaict. Why can't you
> plumb into the existing set_memory_*() family?

I have responded to your comments on your other email. Please read my
response there.

Thanks.

Madhavan
