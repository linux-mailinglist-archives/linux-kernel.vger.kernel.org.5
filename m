Return-Path: <linux-kernel+bounces-36953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC2683A972
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7217C1C21674
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C46310E;
	Wed, 24 Jan 2024 12:17:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5D262A1E;
	Wed, 24 Jan 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098650; cv=none; b=MOHXhtdbQ5PK71wDRc19EQB2GQWIMlGq/iQNM0dM1OMdZxDALMeHc+p1kixsq8c9BmDKsGLeDBtJ9y+sZVe//y6TTAqMYgJejs9F5WKtsDQIelAtZAbKuROTa0UgxQfJSKhVOxI9qZ1J2NEuv1MbJfeyEXXL9Ta4Ro2g521phJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098650; c=relaxed/simple;
	bh=qsXWo+HrmIFDIhLLli/+May0uzYFgdFB7nfDG1YuS9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjHVFs8/B6ZX8QdpkMvsPWW2TJlFLJx/mH6mJFFjIbZrL/bUT7iEP+3ZJAHOnMLymgknxcrsQuayjHfYtlAE18gokWehuLBNLSo1sdQkG4jisDPDuwOiZkOSBUoh1HDmgkhDGkPnBYu9adan6/QLlvw1QLKTfuRB/FQeAuWQ++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2E681FB;
	Wed, 24 Jan 2024 04:18:12 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 715B63F5A1;
	Wed, 24 Jan 2024 04:17:24 -0800 (PST)
Message-ID: <edfade67-269e-4a49-8db6-40617131e283@arm.com>
Date: Wed, 24 Jan 2024 12:17:23 +0000
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
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
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
 Barry Song <v-songbaohua@oppo.com>, linux-s390@vger.kernel.org
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com> <ZaMR2EWN-HvlCfUl@krava>
 <41dc7dff-1ea8-4894-a487-88d46ec2b2d8@redhat.com> <ZaRKMwKJIBmh8-lD@krava>
 <1188e67e-5c04-4bb5-b242-78d92c3fc85c@arm.com>
 <yt9d1qa7x9qv.fsf@linux.ibm.com> <ZbDyLzoIm0GdQzZA@krava>
 <6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com> <ZbD9YdCmZ3_uTj_k@krava>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZbD9YdCmZ3_uTj_k@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 12:06, Jiri Olsa wrote:
> On Wed, Jan 24, 2024 at 12:02:53PM +0000, Ryan Roberts wrote:
>> On 24/01/2024 11:19, Jiri Olsa wrote:
>>> On Wed, Jan 24, 2024 at 12:15:52PM +0100, Sven Schnelle wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> On 14/01/2024 20:55, Jiri Olsa wrote:
>>>>>> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
>>>>>>> On 13.01.24 23:42, Jiri Olsa wrote:
>>>>>>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
>>>>>>>>> In preparation for supporting anonymous multi-size THP, improve
>>>>>>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>>>>>>>> passed to it. In this case, all contained pages are accounted using the
>>>>>>>>> order-0 folio (or base page) scheme.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>>>> ---
>>>>>>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>>>>>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>>>> index 2a1e45e6419f..846fc79f3ca9 100644
>>>>>>>>> --- a/mm/rmap.c
>>>>>>>>> +++ b/mm/rmap.c
>>>>>>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>>>>    * This means the inc-and-test can be bypassed.
>>>>>>>>>    * The folio does not have to be locked.
>>>>>>>>>    *
>>>>>>>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>>>>>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>>>>>>>    * is new, it's assumed to be mapped exclusively by a single process.
>>>>>>>>>    */
>>>>>>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>>>   		unsigned long address)
>>>>>>>>>   {
>>>>>>>>> -	int nr;
>>>>>>>>> +	int nr = folio_nr_pages(folio);
>>>>>>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>>>>>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>>>>>>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>>>>>>
>>>>>>>> hi,
>>>>>>>> I'm hitting this bug (console output below) with adding uprobe
>>>>>>>> on simple program like:
>>>>>>>>
>>>>>>>>    $ cat up.c
>>>>>>>>    int main(void)
>>>>>>>>    {
>>>>>>>>       return 0;
>>>>>>>>    }
>>>>>>>>
>>>>>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>>>>>>
>>>>>>>>    $ ./up
>>>>>>>>
>>>>>>>> it's on top of current linus tree master:
>>>>>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>>>>>>
>>>>>>>> before this patch it seems to work, I can send my .config if needed
>>>>>
>>>>> Thanks for the bug report!
>>>>
>>>> I just hit the same bug in our CI, but can't find the fix in -next. Is
>>>> this in the queue somewhere?
>>>
>>> we hit it as well, but I can see the fix in linux-next/master
>>>
>>>   4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages
>>
>> Yes that's the one. Just to confirm: you are still hitting the VM_BUG_ON despite
>> having this change in your kernel? Could you please send over the full bug log?
> 
> ah sorry.. I meant the change fixes the problem for us, it just did not
> yet propagate through the merge cycle into bpf trees.. but I can see it
> in linux-next tree, so it's probably just matter of time

OK great! How about you, Sven? Do you have this change in your kernel? Hopefully
it should fix your problem.

> 
> jirka


