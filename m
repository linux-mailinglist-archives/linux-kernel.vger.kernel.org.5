Return-Path: <linux-kernel+bounces-49403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA63846A0C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900C41C29DDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4AD17C67;
	Fri,  2 Feb 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AJ71sJ5J"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8992117C6A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860816; cv=none; b=o1b1IhwKsv23gY1sShzWn56GyoU2pOuQf5SctIWYrYybWiPogTjLummPyhC3vaK2x2XH8fUdRr3APhSpuDfJ90Axcx+WVPYQ+lnoOfTbQorvmPgXpfzD4Hl0JQ6oFLg/o6TVObop9QdJDO6nBsp+ieZfRwwELLpqPcB30W+Xehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860816; c=relaxed/simple;
	bh=qAV6GtNsepGCPpFh+XTiXiUUx7nFRuxFN5rMv9Jj/Zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SrSBWxE5CFDGxaGf1jrZrjiHDGoKUSTzfjhR/J8pAO6ELEoluibGUG/Kd/ml/SL0kBoZh5UNYrpxRQ1+w1DrBoXFUi8FxEh7xkIcW0ZhC/r/WrDGdMqHtPDFS6QcY305fvwZUsG4kbQ7A+XBiw+uzb46TPFetJJzdfI8as6AJy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AJ71sJ5J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.212] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3ED96206FCE8;
	Fri,  2 Feb 2024 00:00:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3ED96206FCE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706860814;
	bh=RqUi2YKVIPIVpKZeVHQdI0tcMqtjf4bjUPs1EOgyNYg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AJ71sJ5JN8uXSZuReh5V+cL3ujgCSEmUULo9BvKyylvOPfpDY7gUr8dOMVw/+yFFP
	 7dEH4H48l9TKMi6RZlmFMwMyOvGkAUvoNH9Zsfl3Leu42vXL9TAoucT7uSh/sxJSTT
	 sjX6s8rCPdRc6UWJqWO4TObjk4q/Y7vvckDv60PU=
Message-ID: <3313c886-e964-48c3-8277-b47cb1955de9@linux.microsoft.com>
Date: Fri, 2 Feb 2024 09:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 5/5] x86: CVMs: Ensure that memory conversions happen at
 2M alignment
Content-Language: en-US
To: Vishal Annapurve <vannapurve@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, pbonzini@redhat.com, rientjes@google.com,
 seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com,
 jxgao@google.com, sagis@google.com, oupton@google.com, peterx@redhat.com,
 vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
 michael.roth@amd.com, kirill@shutemov.name, thomas.lendacky@amd.com,
 dave.hansen@linux.intel.com, linux-coco@lists.linux.dev,
 chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com,
 andrew.jones@linux.dev, corbet@lwn.net, hch@lst.de,
 m.szyprowski@samsung.com, rostedt@goodmis.org, iommu@lists.linux.dev
References: <20240112055251.36101-1-vannapurve@google.com>
 <20240112055251.36101-6-vannapurve@google.com>
 <6709a57c-48a0-4ddd-b64e-a1e34ae2b763@intel.com>
 <CAGtprH_ANUVU+Dh1KOq0vpT7BGbCEvD2ab9B=sxjzHYsKxFGeA@mail.gmail.com>
 <1d9d3372-825a-417a-8811-ffa501c83936@linux.microsoft.com>
 <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <CAGtprH8r0kYYqGoumsVeZq42cX8CN3cchkuRYhQULqtb-1nKww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/02/2024 06:08, Vishal Annapurve wrote:
> On Thu, Feb 1, 2024 at 5:32 PM Jeremi Piotrowski
> <jpiotrowski@linux.microsoft.com> wrote:
>>
>> On 01/02/2024 04:46, Vishal Annapurve wrote:
>>> On Wed, Jan 31, 2024 at 10:03 PM Dave Hansen <dave.hansen@intel.com> wrote:
>>>>
>>>> On 1/11/24 21:52, Vishal Annapurve wrote:
>>>>> @@ -2133,8 +2133,10 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
>>>>>       int ret;
>>>>>
>>>>>       /* Should not be working on unaligned addresses */
>>>>> -     if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
>>>>> -             addr &= PAGE_MASK;
>>>>> +     if (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address: %#lx\n", addr)
>>>>> +             || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
>>>>> +                     "misaligned numpages: %#lx\n", numpages))
>>>>> +             return -EINVAL;
>>>>
>>>> This series is talking about swiotlb and DMA, then this applies a
>>>> restriction to what I *thought* was a much more generic function:
>>>> __set_memory_enc_pgtable().  What prevents this function from getting
>>>> used on 4k mappings?
>>>>
>>>>
>>>
>>> The end goal here is to limit the conversion granularity to hugepage
>>> sizes. SWIOTLB allocations are the major source of unaligned
>>> allocations(and so the conversions) that need to be fixed before
>>> achieving this goal.
>>>
>>> This change will ensure that conversion fails for unaligned ranges, as
>>> I don't foresee the need for 4K aligned conversions apart from DMA
>>> allocations.
>>
>> Hi Vishal,
>>
>> This assumption is wrong. set_memory_decrypted is called from various
>> parts of the kernel: kexec, sev-guest, kvmclock, hyperv code. These conversions
>> are for non-DMA allocations that need to be done at 4KB granularity
>> because the data structures in question are page sized.
>>
>> Thanks,
>> Jeremi
> 
> Thanks Jeremi for pointing out these usecases.
> 
> My brief analysis for these call sites:
> 1) machine_kexec_64.c, realmode/init.c, kvm/mmu/mmu.c - shared memory
> allocation/conversion happens when host side memory encryption
> (CC_ATTR_HOST_MEM_ENCRYPT) is enabled.
> 2) kernel/kvmclock.c -  Shared memory allocation can be made to align
> 2M even if the memory needed is lesser.
> 3) drivers/virt/coco/sev-guest/sev-guest.c,
> drivers/virt/coco/tdx-guest/tdx-guest.c - Shared memory allocation can
> be made to align 2M even if the memory needed is lesser.
> 
> I admit I haven't analyzed hyperv code in context of these changes,
> but will take a better look to see if the calls for memory conversion
> here can fit the category of "Shared memory allocation can be made to
> align 2M even if the memory needed is lesser".
> 
> Agree that this patch should be modified to look something like
> (subject to more changes on the call sites)

No, this patch is still built on the wrong assumptions. You're trying
to alter a generic function in the guest for the constraints of a very
specific hypervisor + host userspace + memory backend combination.
That's not right.

Is the numpages check supposed to ensure that the guest *only* toggles
visibility in chunks of 2MB? Then you're exposing more memory to the host
than the guest intends.

If you must - focus on getting swiotlb conversions to happen at the desired
granularity but don't try to force every single conversion to be >4K.

Thanks,
Jeremi


> 
> =============
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index e9b448d1b1b7..8c608d6913c4 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2132,10 +2132,15 @@ static int __set_memory_enc_pgtable(unsigned
> long addr, int numpages, bool enc)
>         struct cpa_data cpa;
>         int ret;
> 
>         /* Should not be working on unaligned addresses */
>         if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
>                 addr &= PAGE_MASK;
> 
> +       if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
> +               (WARN_ONCE(addr & ~HPAGE_MASK, "misaligned address:
> %#lx\n", addr)
> +                       || WARN_ONCE((numpages << PAGE_SHIFT) & ~HPAGE_MASK,
> +                               "misaligned numpages: %#lx\n", numpages)))
> +               return -EINVAL;
> +
>         memset(&cpa, 0, sizeof(cpa));
>         cpa.vaddr = &addr;
>         cpa.numpages = numpages;


