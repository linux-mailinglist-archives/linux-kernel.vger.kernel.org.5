Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6787E71A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjKISll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbjKISlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:41:40 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B22E83C0B;
        Thu,  9 Nov 2023 10:41:38 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id A143020B74C0;
        Thu,  9 Nov 2023 10:41:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A143020B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699555298;
        bh=p5ZTL0k+lm0q4Pe3ZEkX70IGxjuY2ziLhRZZaLSqBIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nk+jJtf+duWluSudoHgGe9dpvKa26WRVKFIpQ8giPC5o4nAuw6KlP6adPC1SOM5HV
         Ari+O9JHPL+iR38mIeAufUrqefxMXg9B7OeQBoR4FjdPXCdusDvO+LZMFUs92Mbm4Y
         ME+7641Y4DMGfM9Ps7E3tFkGnkF+TZSfsHXdpqEA=
Message-ID: <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
Date:   Thu, 9 Nov 2023 19:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, stefan.bader@canonical.com,
        tim.gardner@canonical.com, roxana.nicolescu@canonical.com,
        cascardo@canonical.com, kys@microsoft.com, haiyangz@microsoft.com,
        wei.liu@kernel.org, kirill.shutemov@linux.intel.com,
        sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
Content-Language: en-US
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2023 17:50, Dave Hansen wrote:
> On 11/9/23 08:35, Jeremi Piotrowski wrote:
>> On 09/11/2023 17:25, Dave Hansen wrote:
>>> On 11/9/23 08:14, Jeremi Piotrowski wrote:
>>> ...
>>>>  	pr_info("Memory Encryption Features active:");
>>>>  
>>>> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>>>> +	if (cc_vendor == CC_VENDOR_INTEL) {
>>>>  		pr_cont(" Intel TDX\n");
>>>>  		return;
>>>>  	}
>>>
>>> Why aren't these guests setting X86_FEATURE_TDX_GUEST?
>>
>> They could if we can confirm that the code gated behind
>> cpu_feature_enabled(X86_FEATURE_TDX_GUEST) is correct when running with TD partitioning.
> 
> Let me elaborate a bit on my question.
> 
> X86_FEATURE_TDX_GUEST is set based on some specific gunk that shows up
> in CPUID in TDX guests.  I *believe* it's in one of the CPUID leaves
> that the VMM has no control over.> 

Right - you're talking about TDX_CPUID_LEAF_ID 0x21.

> So, first, what in practice is keeping tdx_early_init() from running on
> these "TD partitioning" systems?  Because it's either not running, or
> I'm misreading the code horribly.
> 

You're right, it is not running in this case. Not super familiar with TD partitioning,
but as I understand it in TD partitioning Linux runs as a kind of L2 TD guest with the
paravisor acting as the L1 TD VM(M). tdx_early_init() changes kernel behavior with the
assumption that it can talk directly to the TD module or change page visibility in a
certain way, instead of talking to a paravisor. So that CPUID is hidden to prevent this.
Otherwise tdx_early_init() would need to be modified to check "am I running with TD
partitioning and if so - switch to other implementations".

>> It still makes sense to have these prints based on the cc_xxx abstractions.
> 
> I'm not sure I'm following.
> 
> For instance, let's say that someone came up with a nutty reason to do
> MKTME in Linux.  We'd need a host-side contraption that sets
> CC_ATTR_MEM_ENCRYPT and so forth.  It would also, obviously, set
> cc_vendor=CC_VENDOR_INTEL just like host-side SME sets
> cc_vendor=CC_VENDOR_AMD.
> 
> Then we'd have to go back and disentangle all the places where we
> assumed CC_VENDOR_INTEL==TDX.

We're not baking that generalization into any other place, but when printing
coco features here it made sense to me to make the shortcut. I can also post
a v2 that is more accurate:

    if (cc_vendor == CC_VENDOR_INTEL) {
            pr_cont(" Intel");
            if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
                    pr_cont(" TDX\n");
            return;
    }

Dexuan and Michael would like to see callbacks added that allow kernel code
to more accurately report coco features when a paravisor is involved.

> 
> That, combined with this patch's apparent disregard for why
> X86_FEATURE_TDX_GUEST isn't getting set makes me think that the big
> picture was not considered here and this patch represents the quickest
> hack to get the right spew out to dmesg that is desired.

It's not disregard, the way the kernel behaves in this case is correct except
for the error in reporting CPU vendor. Users care about seeing the correct
information in dmesg.

Setting X86_FEATURE_TDX_GUEST might be interesting for a different reason:
so that we also see TDX in /proc/cpuinfo. But then we would want to consider
whether we should add a feature for SNP_GUEST, or else every platform reports
things differently. The cc_platform stuff in the kernel was introduced to avoid
this kind of differentiation.

Jeremi
