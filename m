Return-Path: <linux-kernel+bounces-25752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2C82D54F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4A1C213B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1C6BE6C;
	Mon, 15 Jan 2024 08:50:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FB9C8D2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B472F4;
	Mon, 15 Jan 2024 00:51:10 -0800 (PST)
Received: from [10.57.76.47] (unknown [10.57.76.47])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B77D3F6C4;
	Mon, 15 Jan 2024 00:50:20 -0800 (PST)
Message-ID: <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
Date: Mon, 15 Jan 2024 08:50:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Yin Fengwei <fengwei.yin@intel.com>,
 Yu Zhao <yuzhao@google.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Yang Shi
 <shy828301@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 Zi Yan <ziy@nvidia.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Itaru Kitayama <itaru.kitayama@gmail.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 John Hubbard <jhubbard@nvidia.com>, David Rientjes <rientjes@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com> <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com> <ZaRKMwKJIBmh8-lD@krava>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZaRKMwKJIBmh8-lD@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/01/2024 20:55, Jiri Olsa wrote:
> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
>> On 13.01.24 23:42, Jiri Olsa wrote:
>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
>>>> In preparation for supporting anonymous multi-size THP, improve
>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>>> passed to it. In this case, all contained pages are accounted using the
>>>> order-0 folio (or base page) scheme.
>>>>
>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 2a1e45e6419f..846fc79f3ca9 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>>>    * This means the inc-and-test can be bypassed.
>>>>    * The folio does not have to be locked.
>>>>    *
>>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>>    * is new, it's assumed to be mapped exclusively by a single process.
>>>>    */
>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>   		unsigned long address)
>>>>   {
>>>> -	int nr;
>>>> +	int nr = folio_nr_pages(folio);
>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>
>>> hi,
>>> I'm hitting this bug (console output below) with adding uprobe
>>> on simple program like:
>>>
>>>    $ cat up.c
>>>    int main(void)
>>>    {
>>>       return 0;
>>>    }
>>>
>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>
>>>    $ ./up
>>>
>>> it's on top of current linus tree master:
>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>
>>> before this patch it seems to work, I can send my .config if needed

Thanks for the bug report!

>>
>> bpf only inserts a small folio, so no magic there.
>>
>> It was:
>> 	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>> And now it is
>> 	VM_BUG_ON_VMA(address < vma->vm_start || address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>
>> I think this change is sane. As long as the address is aligned to full pages
>> (which it better should be)
>>
>> Staring at uprobe_write_opcode, likely vaddr isn't aligned ...
>>
>> Likely (hopefully) that is not an issue for __folio_set_anon(), because linear_page_index()
>> will mask these bits off.
>>
>>
>> Would the following change fix it for you?

And thanks for fixing my mess so quickly, David.

FWIW, I agree with your diagnosis. One small suggestion below.

> 
> great, that fixes it for me, you can add my
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
>>
>> From c640a8363e47bc96965a35115a040b5f876c4320 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Sun, 14 Jan 2024 18:32:57 +0100
>> Subject: [PATCH] tmp
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  kernel/events/uprobes.c | 2 +-
>>  mm/rmap.c               | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 485bb0389b488..929e98c629652 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -537,7 +537,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>  		}
>>  	}
>> -	ret = __replace_page(vma, vaddr, old_page, new_page);
>> +	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
>>  	if (new_page)
>>  		put_page(new_page);
>>  put_old:
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index f5d43edad529a..a903db4df6b97 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1408,6 +1408,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>  {
>>  	int nr = folio_nr_pages(folio);
>> +	VM_WARN_ON_FOLIO(!IS_ALIGNED(address, PAGE_SIZE), folio);

nit: Is it worth also adding this to __folio_add_anon_rmap() so that
folio_add_anon_rmap_ptes() and folio_add_anon_rmap_pmd() also benefit?

Regardless:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

>>  	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>>  	VM_BUG_ON_VMA(address < vma->vm_start ||
>>  			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>> -- 
>> 2.43.0
>>
>>
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
>>


