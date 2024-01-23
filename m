Return-Path: <linux-kernel+bounces-35012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E8A838A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D89F1C23E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB475A0ED;
	Tue, 23 Jan 2024 09:41:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC75A0E6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002895; cv=none; b=BkeMB4i+DIaLDELI+p4EsRZ5yu/9pd09o0MIQRiJ2OXcjgECvsvpnR2GRXJ9EGWygnaMUWmJZGP4hZHmwg+Mg5LjUNWO5kFzNaLQjsOS47MKMmlbKkhkTm8k7yjxyjeFTHuTJy26fh08JlufzKXkEmc9eZBQntQKiF+k6eDc7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002895; c=relaxed/simple;
	bh=VPijt7WJ4Q6vpo4Ha3DbzXk8a9d5iHBUi63j2srWCJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEU/HEKgFILAEmzMFINNAhjeN+8B4cYXzdosxjoTWvSWvAEeLcA7JDzbKz3XWiH+/fzaX3ZqPuqKOAeefoPaQIal5c3YCAFv2ziVi+nLh4/Iik/fjKe8mzXlC0z+4vUDAAnLgGwhZQ/hfZPR14vKqTX234Oi8kEbhj+c/Md0Rts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 881A91FB;
	Tue, 23 Jan 2024 01:42:17 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05D3D3F5A1;
	Tue, 23 Jan 2024 01:41:30 -0800 (PST)
Message-ID: <bad7ec4a-1507-4ec4-996a-ea29d07d47a0@arm.com>
Date: Tue, 23 Jan 2024 09:41:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mm: align larger anonymous mappings on THP
 boundaries
Content-Language: en-GB
To: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,
 Yang Shi <yang@os.amperecomputing.com>, riel@surriel.com, cl@linux.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231214223423.1133074-1-yang@os.amperecomputing.com>
 <1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com>
 <Zav3UK7ESNxCMjyP@casper.infradead.org>
 <b75cb59a-734f-43d5-b565-fc9bb8c5ed05@arm.com>
 <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkpT6padaDo8GimCcQReSGybQn_ntzj+wsZbTXe3urtK-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 19:43, Yang Shi wrote:
> On Mon, Jan 22, 2024 at 3:37 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 20/01/2024 16:39, Matthew Wilcox wrote:
>>> On Sat, Jan 20, 2024 at 12:04:27PM +0000, Ryan Roberts wrote:
>>>> However, after this patch, each allocation is in its own VMA, and there is a 2M
>>>> gap between each VMA. This causes 2 problems: 1) mmap becomes MUCH slower
>>>> because there are so many VMAs to check to find a new 1G gap. 2) It fails once
>>>> it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting this limit then
>>>> causes a subsequent calloc() to fail, which causes the test to fail.
>>>>
>>>> Looking at the code, I think the problem is that arm64 selects
>>>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area() allocates
>>>> len+2M then always aligns to the bottom of the discovered gap. That causes the
>>>> 2M hole. As far as I can see, x86 allocates bottom up, so you don't get a hole.
>>>
>>> As a quick hack, perhaps
>>> #ifdef ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>>> take-the-top-half
>>> #else
>>> current-take-bottom-half-code
>>> #endif
>>>
>>> ?
> 
> Thanks for the suggestion. It makes sense to me. Doing the alignment
> needs to take into account this.
> 
>>
>> There is a general problem though that there is a trade-off between abutting
>> VMAs, and aligning them to PMD boundaries. This patch has decided that in
>> general the latter is preferable. The case I'm hitting is special though, in
>> that both requirements could be achieved but currently are not.
>>
>> The below fixes it, but I feel like there should be some bitwise magic that
>> would give the correct answer without the conditional - but my head is gone and
>> I can't see it. Any thoughts?
> 
> Thanks Ryan for the patch. TBH I didn't see a bitwise magic without
> the conditional either.
> 
>>
>> Beyond this, though, there is also a latent bug where the offset provided to
>> mmap() is carried all the way through to the get_unmapped_area()
>> impelementation, even for MAP_ANONYMOUS - I'm pretty sure we should be
>> force-zeroing it for MAP_ANONYMOUS? Certainly before this change, for arches
>> that use the default get_unmapped_area(), any non-zero offset would not have
>> been used. But this change starts using it, which is incorrect. That said, there
>> are some arches that override the default get_unmapped_area() and do use the
>> offset. So I'm not sure if this is a bug or a feature that user space can pass
>> an arbitrary value to the implementation for anon memory??
> 
> Thanks for noticing this. If I read the code correctly, the pgoff used
> by some arches to workaround VIPT caches, and it looks like it is for
> shared mapping only (just checked arm and mips). And I believe
> everybody assumes 0 should be used when doing anonymous mapping. The
> offset should have nothing to do with seeking proper unmapped virtual
> area. But the pgoff does make sense for file THP due to the alignment
> requirements. I think it should be zero'ed for anonymous mappings,
> like:
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2ff79b1d1564..a9ed353ce627 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1830,6 +1830,7 @@ get_unmapped_area(struct file *file, unsigned
> long addr, unsigned long len,
>                 pgoff = 0;
>                 get_area = shmem_get_unmapped_area;
>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +               pgoff = 0;
>                 /* Ensures that larger anonymous mappings are THP aligned. */
>                 get_area = thp_get_unmapped_area;
>         }

I think it would be cleaner to just zero pgoff if file==NULL, then it covers the
shared case, the THP case, and the non-THP case properly. I'll prepare a
separate patch for this.


> 
>>
>> Finally, the second test failure I reported (ksm_tests) is actually caused by a
>> bug in the test code, but provoked by this change. So I'll send out a fix for
>> the test code separately.
>>
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 4f542444a91f..68ac54117c77 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -632,7 +632,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>>  {
>>         loff_t off_end = off + len;
>>         loff_t off_align = round_up(off, size);
>> -       unsigned long len_pad, ret;
>> +       unsigned long len_pad, ret, off_sub;
>>
>>         if (off_end <= off_align || (off_end - off_align) < size)
>>                 return 0;
>> @@ -658,7 +658,13 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>>         if (ret == addr)
>>                 return addr;
>>
>> -       ret += (off - ret) & (size - 1);
>> +       off_sub = (off - ret) & (size - 1);
>> +
>> +       if (current->mm->get_unmapped_area == arch_get_unmapped_area_topdown &&
>> +           !off_sub)
>> +               return ret + size;
>> +
>> +       ret += off_sub;
>>         return ret;
>>  }
> 
> I didn't spot any problem, would you please come up with a formal patch?

Yeah, I'll aim to post today.



