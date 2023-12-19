Return-Path: <linux-kernel+bounces-4902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C281839F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4913A286AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDB414281;
	Tue, 19 Dec 2023 08:42:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC301426B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4F31FB;
	Tue, 19 Dec 2023 00:43:02 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A783F738;
	Tue, 19 Dec 2023 00:42:16 -0800 (PST)
Message-ID: <8b6c9485-568c-41e4-8ef9-0ac6c33754ea@arm.com>
Date: Tue, 19 Dec 2023 08:42:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/39] mm/huge_memory: batch rmap operations in
 __split_huge_pmd_locked()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Hugh Dickins <hughd@google.com>, Yin Fengwei <fengwei.yin@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>,
 Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-16-david@redhat.com>
 <c3984854-0e39-475b-822d-773097d86f50@arm.com>
 <652f143e-1547-4ded-892f-1216ce689c9b@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <652f143e-1547-4ded-892f-1216ce689c9b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 17:03, David Hildenbrand wrote:
> On 18.12.23 17:22, Ryan Roberts wrote:
>> On 11/12/2023 15:56, David Hildenbrand wrote:
>>> Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.
>>>
>>> While at it, use more folio operations (but only in the code branch we're
>>> touching), use VM_WARN_ON_FOLIO(), and pass RMAP_EXCLUSIVE instead of
>>> manually setting PageAnonExclusive.
>>>
>>> We should never see non-anon pages on that branch: otherwise, the
>>> existing page_add_anon_rmap() call would have been flawed already.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/huge_memory.c | 23 +++++++++++++++--------
>>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 1f5634b2f374..82ad68fe0d12 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2398,6 +2398,7 @@ static void __split_huge_pmd_locked(struct
>>> vm_area_struct *vma, pmd_t *pmd,
>>>           unsigned long haddr, bool freeze)
>>>   {
>>>       struct mm_struct *mm = vma->vm_mm;
>>> +    struct folio *folio;
>>>       struct page *page;
>>>       pgtable_t pgtable;
>>>       pmd_t old_pmd, _pmd;
>>> @@ -2493,16 +2494,18 @@ static void __split_huge_pmd_locked(struct
>>> vm_area_struct *vma, pmd_t *pmd,
>>>           uffd_wp = pmd_swp_uffd_wp(old_pmd);
>>>       } else {
>>>           page = pmd_page(old_pmd);
>>> +        folio = page_folio(page);
>>>           if (pmd_dirty(old_pmd)) {
>>>               dirty = true;
>>> -            SetPageDirty(page);
>>> +            folio_set_dirty(folio);
>>>           }
>>>           write = pmd_write(old_pmd);
>>>           young = pmd_young(old_pmd);
>>>           soft_dirty = pmd_soft_dirty(old_pmd);
>>>           uffd_wp = pmd_uffd_wp(old_pmd);
>>>   -        VM_BUG_ON_PAGE(!page_count(page), page);
>>> +        VM_WARN_ON_FOLIO(!folio_ref_count(folio), folio);
>>> +        VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
>>
>> Is this warning really correct? file-backed memory can be PMD-mapped with
>> CONFIG_READ_ONLY_THP_FOR_FS, so presumably it can also have the need to be
>> remapped as pte? Although I guess if we did have a file-backed folio, it
>> definitely wouldn't be correct to call page_add_anon_rmap() /
>> folio_add_anon_rmap_ptes()...
> 
> Yes, see the patch description where I spell that out.

Oh god, how did I miss that... sorry!

> 
> PTE-remapping a file-back folio will simply zap the PMD and refault from the
> page cache after creating a page table.


Yep, that makes sense.

> 
> So this is anon-only code.
> 


