Return-Path: <linux-kernel+bounces-36944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A8C83A938
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91810280EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7360ED1;
	Wed, 24 Jan 2024 12:03:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216ED60EC8;
	Wed, 24 Jan 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097782; cv=none; b=AsG9X5UCj6fZF4niCqfklo6kUSkxeDjYlbf6S+C7rcEcf09WwcJHi6IeuVXr6tojucYGomAqBmV0j9iStEDb+GsCCDAfYWFFNg6FuJH2bXK+XbrctqTr+CE/OtWoyoOz5fOKEGAl/Xq2r4ARexTn8WHMxY5fGs3679u6ASmsD9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097782; c=relaxed/simple;
	bh=tiky66ki9aV3U3ti/CcZ+dvsrdc58p6yGSmHtnu/Do4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9bgmriWilETBMnF9xpST4Q56guEpxABW0aIgToszKV5Xulb4RpnvBLgjVMmX+IpW/wHfuf+5Bp/tbPsaUtyQe1Cb7G1ffjWYotvQqGmJs70WO86+5jhucKGGGi6liwrPevd2TxkCcofxwHSnlBMNb5oNUK6h9FVuacLTF02vHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C231FB;
	Wed, 24 Jan 2024 04:03:44 -0800 (PST)
Received: from [10.57.77.165] (unknown [10.57.77.165])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C88E3F5A1;
	Wed, 24 Jan 2024 04:02:55 -0800 (PST)
Message-ID: <6caaced7-a9d7-4fe4-823a-11b96be83e46@arm.com>
Date: Wed, 24 Jan 2024 12:02:53 +0000
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
To: Jiri Olsa <olsajiri@gmail.com>, Sven Schnelle <svens@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZbDyLzoIm0GdQzZA@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/01/2024 11:19, Jiri Olsa wrote:
> On Wed, Jan 24, 2024 at 12:15:52PM +0100, Sven Schnelle wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> On 14/01/2024 20:55, Jiri Olsa wrote:
>>>> On Sun, Jan 14, 2024 at 06:33:56PM +0100, David Hildenbrand wrote:
>>>>> On 13.01.24 23:42, Jiri Olsa wrote:
>>>>>> On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
>>>>>>> In preparation for supporting anonymous multi-size THP, improve
>>>>>>> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
>>>>>>> passed to it. In this case, all contained pages are accounted using the
>>>>>>> order-0 folio (or base page) scheme.
>>>>>>>
>>>>>>> Reviewed-by: Yu Zhao <yuzhao@google.com>
>>>>>>> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
>>>>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>>>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>>> ---
>>>>>>>   mm/rmap.c | 28 ++++++++++++++++++++--------
>>>>>>>   1 file changed, 20 insertions(+), 8 deletions(-)
>>>>>>>
>>>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>>>> index 2a1e45e6419f..846fc79f3ca9 100644
>>>>>>> --- a/mm/rmap.c
>>>>>>> +++ b/mm/rmap.c
>>>>>>> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>>    * This means the inc-and-test can be bypassed.
>>>>>>>    * The folio does not have to be locked.
>>>>>>>    *
>>>>>>> - * If the folio is large, it is accounted as a THP.  As the folio
>>>>>>> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>>>>>>>    * is new, it's assumed to be mapped exclusively by a single process.
>>>>>>>    */
>>>>>>>   void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>>>>   		unsigned long address)
>>>>>>>   {
>>>>>>> -	int nr;
>>>>>>> +	int nr = folio_nr_pages(folio);
>>>>>>> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
>>>>>>> +	VM_BUG_ON_VMA(address < vma->vm_start ||
>>>>>>> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
>>>>>>
>>>>>> hi,
>>>>>> I'm hitting this bug (console output below) with adding uprobe
>>>>>> on simple program like:
>>>>>>
>>>>>>    $ cat up.c
>>>>>>    int main(void)
>>>>>>    {
>>>>>>       return 0;
>>>>>>    }
>>>>>>
>>>>>>    # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'
>>>>>>
>>>>>>    $ ./up
>>>>>>
>>>>>> it's on top of current linus tree master:
>>>>>>    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat
>>>>>>
>>>>>> before this patch it seems to work, I can send my .config if needed
>>>
>>> Thanks for the bug report!
>>
>> I just hit the same bug in our CI, but can't find the fix in -next. Is
>> this in the queue somewhere?
> 
> we hit it as well, but I can see the fix in linux-next/master
> 
>   4c137bc28064 uprobes: use pagesize-aligned virtual address when replacing pages

Yes that's the one. Just to confirm: you are still hitting the VM_BUG_ON despite
having this change in your kernel? Could you please send over the full bug log?

> 
> jirka


