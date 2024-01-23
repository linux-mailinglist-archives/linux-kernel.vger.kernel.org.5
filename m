Return-Path: <linux-kernel+bounces-35843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5138839738
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C331F2AB30
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7874881213;
	Tue, 23 Jan 2024 18:06:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820E97FBC4;
	Tue, 23 Jan 2024 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033183; cv=none; b=fIrFz7+2Tck8NUEvrBy/FKYe+joHmDtNXXn041BnLXXJ7mZYs8LmYhBb8FlWFfzcJKUTMeO+z50DvNGqoQB5/j5Xy0Pyo7JqRCBIhLSn5W8RHwVsfiAWD23nMkFsIHdGU6gvOqmO6g4A32UZE9yaqSbVli+MnHAvwvrmTk5PEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033183; c=relaxed/simple;
	bh=mpukHrJGQfkSvb2i5G7GCeHO/07bhGWWUAkmqYst/Z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfn2ouovJOKYZxL8jlBO9M65zagNQqEghoe0rGyEp3pfviYMGK80zykzfSBRq0aQldnjF6pzxTcMzNWKJlUtAnc3D5ncpoYdeYR39OBrm22lh1VN6tXFSTRavcn1jX06il1/SgHJUOy9N6XowyPMT9YncAucfRnWrXwRgrxkYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8BCD1FB;
	Tue, 23 Jan 2024 10:07:04 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8441B3F7F4;
	Tue, 23 Jan 2024 10:06:18 -0800 (PST)
Message-ID: <47364d76-4eb9-42fe-bbbf-dec483cda2af@arm.com>
Date: Tue, 23 Jan 2024 18:06:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: thp_get_unmapped_area must honour topdown
 preference
Content-Language: en-GB
To: Yang Shi <shy828301@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rik van Riel
 <riel@surriel.com>, Matthew Wilcox <willy@infradead.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240123171420.3970220-1-ryan.roberts@arm.com>
 <CAHbLzkpXNDJy+p96maDeYa7rrqHUG+Go6epdqeUog-0xabiGiw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkpXNDJy+p96maDeYa7rrqHUG+Go6epdqeUog-0xabiGiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/01/2024 17:52, Yang Shi wrote:
> On Tue, Jan 23, 2024 at 9:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> The addition of commit efa7df3e3bb5 ("mm: align larger anonymous
>> mappings on THP boundaries") caused the "virtual_address_range" mm
>> selftest to start failing on arm64. Let's fix that regression.
>>
>> There were 2 visible problems when running the test; 1) it takes much
>> longer to execute, and 2) the test fails. Both are related:
>>
>> The (first part of the) test allocates as many 1GB anonymous blocks as
>> it can in the low 256TB of address space, passing NULL as the addr hint
>> to mmap. Before the faulty patch, all allocations were abutted and
>> contained in a single, merged VMA. However, after this patch, each
>> allocation is in its own VMA, and there is a 2M gap between each VMA.
>> This causes the 2 problems in the test: 1) mmap becomes MUCH slower
>> because there are so many VMAs to check to find a new 1G gap. 2) mmap
>> fails once it hits the VMA limit (/proc/sys/vm/max_map_count). Hitting
>> this limit then causes a subsequent calloc() to fail, which causes the
>> test to fail.
>>
>> The problem is that arm64 (unlike x86) selects
>> ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT. But __thp_get_unmapped_area()
>> allocates len+2M then always aligns to the bottom of the discovered gap.
>> That causes the 2M hole.
>>
>> Fix this by detecting cases where we can still achive the alignment goal
>> when moved to the top of the allocated area, if configured to prefer
>> top-down allocation.
>>
>> While we are at it, fix thp_get_unmapped_area's use of pgoff, which
>> should always be zero for anonymous mappings. Prior to the faulty
>> change, while it was possible for user space to pass in pgoff!=0, the
>> old mm->get_unmapped_area() handler would not use it.
>> thp_get_unmapped_area() does use it, so let's explicitly zero it before
>> calling the handler. This should also be the correct behavior for arches
>> that define their own get_unmapped_area() handler.
>>
>> Fixes: efa7df3e3bb5 ("mm: align larger anonymous mappings on THP boundaries")
>> Closes: https://lore.kernel.org/linux-mm/1e8f5ac7-54ce-433a-ae53-81522b2320e1@arm.com/
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> 
> Thanks for debugging this. Looks good to me. Reviewed-by: Yang Shi
> <shy828301@gmail.com>

Thanks!

> 
>> ---
>>
>> Applies on top of v6.8-rc1. Would be good to get this into the next -rc.
> 
> This may have a conflict with my fix (" mm: huge_memory: don't force
> huge page alignment on 32 bit") which is on mm-unstable now.

It applies cleanly to mm-unstable. You change modifies the top part of
__thp_get_unmapped_area() and mine modifies the bottom :)

> 
>>
>> Thanks,
>> Ryan
>>
>>  mm/huge_memory.c | 10 ++++++++--
>>  mm/mmap.c        |  6 ++++--
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 94ef5c02b459..8c66f88e71e9 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -809,7 +809,7 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
>>  {
>>         loff_t off_end = off + len;
>>         loff_t off_align = round_up(off, size);
>> -       unsigned long len_pad, ret;
>> +       unsigned long len_pad, ret, off_sub;
>>
>>         if (off_end <= off_align || (off_end - off_align) < size)
>>                 return 0;
>> @@ -835,7 +835,13 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
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
>>
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index b78e83d351d2..d89770eaab6b 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1825,15 +1825,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>>                 /*
>>                  * mmap_region() will call shmem_zero_setup() to create a file,
>>                  * so use shmem's get_unmapped_area in case it can be huge.
>> -                * do_mmap() will clear pgoff, so match alignment.
>>                  */
>> -               pgoff = 0;
>>                 get_area = shmem_get_unmapped_area;
>>         } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>>                 /* Ensures that larger anonymous mappings are THP aligned. */
>>                 get_area = thp_get_unmapped_area;
>>         }
>>
>> +       /* Always treat pgoff as zero for anonymous memory. */
>> +       if (!file)
>> +               pgoff = 0;
>> +
>>         addr = get_area(file, addr, len, pgoff, flags);
>>         if (IS_ERR_VALUE(addr))
>>                 return addr;
>> --
>> 2.25.1
>>


