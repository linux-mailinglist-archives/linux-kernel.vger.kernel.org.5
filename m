Return-Path: <linux-kernel+bounces-91727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A608715B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C650C281E26
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205727B3F8;
	Tue,  5 Mar 2024 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqJINWF8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE47FC1C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709619232; cv=none; b=XZFvTWWJbIFRDgrmpDx5XgJzzBfUjZ4H/OoCDJerlbO7C4Mzr5BdYGjDGtCeqF+P4mRbK+wdEdfrSAR+1JJxijYJyJDJMX7Fy1UQiTo9giif9wzcRWk2g+mQBggR1G+J4CUPpjey8FnCIRGlI845K3qyotmJ45Nk9VB5FdReieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709619232; c=relaxed/simple;
	bh=YXc6r/AjHc5ySBX/Z2X/V41Ub9VIAH/0s5UqiMZ1mgQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=prrThz8ZB5+jhx3Nnm1Vqipx3JIJPDVTfEsOkc+IRPf5b5y0UH/GgSu7k3zczFbPdUyqJ1IDZkhpyd4mMVlLmI+BCA6pqgwfbgdaaphUFOXYMKVU41y+ZXPH8YhBCdp8B4crbjs56w+KlFdLz8whGZGtMXgHaxPDxowVfNiRUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqJINWF8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709619230; x=1741155230;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=YXc6r/AjHc5ySBX/Z2X/V41Ub9VIAH/0s5UqiMZ1mgQ=;
  b=MqJINWF8HrB8ttKT058JSTzVi2OE0ql3mWlkzCuT1JWMykgNkjFQpHWz
   pABQNpJQBaZWN3tAUMlaCFb4UfgvwjWt4sQ5jBi79gS49YYDB7V6lL4R+
   /eKobgUqSimPRf+lM54M1h9AsvbhM/XPHOEiYcjIMHUf7X+X3Y7aCsRGh
   hJSWfvw4ihmaXhDmSXQs2pVOcQ50/8USwsPjq0bmdM7i+53n9CaSm03rx
   2pOtzvHuKU+zGAfBl8JzYx1aQ4B7abcGiph8UF1JichgfocWWQw15mVwm
   18cwSxn3xNZpTD0+LUxiAErhp/oiSc/A/IB6hL8+Dn7QfzYRDBaDe4fTa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15554400"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="15554400"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:13:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9112034"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 22:13:46 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Matthew Wilcox <willy@infradead.org>,  Gao
 Xiang <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Hugh Dickins <hughd@google.com>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>
Subject: Re: [PATCH v3 1/4] mm: swap: Remove CLUSTER_FLAG_HUGE from
 swap_cluster_info:flags
In-Reply-To: <3ae2da13-c33a-402f-9091-2c7328aea66a@arm.com> (Ryan Roberts's
	message of "Mon, 4 Mar 2024 22:34:56 +0000")
References: <20231025144546.577640-1-ryan.roberts@arm.com>
	<20231025144546.577640-2-ryan.roberts@arm.com>
	<d108bd79-086b-4564-838b-d41afa055137@redhat.com>
	<6541e29b-f25a-48b8-a553-fd8febe85e5a@redhat.com>
	<ee760679-7e3c-4a35-ad53-ca98b598ead5@arm.com>
	<ba9101ae-a618-4afc-9515-a61f25376390@arm.com>
	<2934125a-f2e2-417c-a9f9-3cb1e074a44f@redhat.com>
	<049818ca-e656-44e4-b336-934992c16028@arm.com>
	<d2fbfdd0-ad61-4fe2-a976-4dac7427bfc9@redhat.com>
	<b642c7ff-c452-4066-ac12-dbf05e215cb9@arm.com>
	<949b6c22-d737-4060-9ca1-a69d8e986d90@redhat.com>
	<9ed743a7-0c5d-49d9-b8b2-d58364df1f5f@arm.com>
	<65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com>
	<6cfc022a-0c7a-4fe6-aaa4-3d28aeacc982@arm.com>
	<3d47ae7d-297a-441e-941c-5b2e34ba8759@redhat.com>
	<3ae2da13-c33a-402f-9091-2c7328aea66a@arm.com>
Date: Tue, 05 Mar 2024 14:11:52 +0800
Message-ID: <87plw99phz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ryan Roberts <ryan.roberts@arm.com> writes:

> + Hugh
>
> On 04/03/2024 22:02, David Hildenbrand wrote:
>> On 04.03.24 22:55, Ryan Roberts wrote:
>>> On 04/03/2024 20:50, David Hildenbrand wrote:
>>>>>>>
>>>>>>> This is the existing free_swap_and_cache(). I think _swap_info_get(=
) would
>>>>>>> break
>>>>>>> if this could race with swapoff(), and __swap_entry_free() looks up=
 the
>>>>>>> cluster
>>>>>>> from an array, which would also be freed by swapoff if racing:
>>>>>>>
>>>>>>> int free_swap_and_cache(swp_entry_t entry)
>>>>>>> {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct swap_info_struct *p;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned char count;
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (non_swap_entry(entry))
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0p =3D _swap_info_get(entry);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (p) {
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 count =3D __=
swap_entry_free(p, entry);
>>>>>>
>>>>>> If count dropped to 0 and
>>>>>>
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (count =
=3D=3D SWAP_HAS_CACHE)
>>>>>>
>>>>>>
>>>>>> count is now SWAP_HAS_CACHE, there is in fact no swap entry anymore.=
 We
>>>>>> removed
>>>>>> it. That one would have to be reclaimed asynchronously.
>>>>>>
>>>>>> The existing code we would call swap_page_trans_huge_swapped() with =
the SI it
>>>>>> obtained via _swap_info_get().
>>>>>>
>>>>>> I also don't see what should be left protecting the SI. It's not loc=
ked
>>>>>> anymore,
>>>>>> the swapcounts are at 0. We don't hold the folio lock.
>>>>>>
>>>>>> try_to_unuse() will stop as soon as si->inuse_pages is at 0. Hm ...
>>>>>
>>>>> But, assuming the caller of free_swap_and_cache() acquires the PTL fi=
rst, I
>>>>> think this all works out ok? While free_swap_and_cache() is running,
>>>>> try_to_unuse() will wait for the PTL. Or if try_to_unuse() runs first=
, then
>>>>> free_swap_and_cache() will never be called because the swap entry wil=
l have
>>>>> been
>>>>> removed from the PTE?
>>>>
>>>> But can't try_to_unuse() run, detect !si->inuse_pages and not even bot=
her about
>>>> scanning any further page tables?
>>>>
>>>> But my head hurts from digging through that code.
>>>
>>> Yep, glad I'm not the only one that gets headaches from swapfile.c.
>>>
>>>>
>>>> Let me try again:
>>>>
>>>> __swap_entry_free() might be the last user and result in "count =3D=3D
>>>> SWAP_HAS_CACHE".
>>>>
>>>> swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages=
=3D=3D0.
>>>>
>>>>
>>>> So the question is: could someone reclaim the folio and turn si->inuse=
_pages=3D=3D0,
>>>> before we completed swap_page_trans_huge_swapped().
>>>>
>>>> Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages a=
re still
>>>> references by swap entries.
>>>>
>>>> Process 1 still references subpage 0 via swap entry.
>>>> Process 2 still references subpage 1 via swap entry.
>>>>
>>>> Process 1 quits. Calls free_swap_and_cache().
>>>> -> count =3D=3D SWAP_HAS_CACHE
>>>> [then, preempted in the hypervisor etc.]
>>>>
>>>> Process 2 quits. Calls free_swap_and_cache().
>>>> -> count =3D=3D SWAP_HAS_CACHE
>>>>
>>>> Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
>>>> __try_to_reclaim_swap().
>>>>
>>>> __try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->=
put_swap_folio()->
>>>> free_swap_slot()->swapcache_free_entries()->swap_entry_free()->swap_ra=
nge_free()->
>>>> ...
>>>> WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>>>
>>>>
>>>> What stops swapoff to succeed after process 2 reclaimed the swap cache=
 but
>>>> before process 1 finished its call to swap_page_trans_huge_swapped()?
>>>
>>> Assuming you are talking about anonymous memory, process 1 has the PTL =
while
>>> it's executing free_swap_and_cache(). try_to_unuse() iterates over ever=
y vma in
>>> every mm, and it swaps-in a page for every PTE that holds a swap entry =
for the
>>> device being swapoff'ed. It takes the PTL while converting the swap ent=
ry to
>>> present PTE - see unuse_pte(). Process 1 must have beaten try_to_unuse(=
) to the
>>> particular pte, because if try_to_unuse() got there first, it would have
>>> converted it from a swap entry to present pte and process 1 would never=
 even
>>> have called free_swap_and_cache(). So try_to_unuse() will eventually wa=
it on the
>>> PTL until process 1 has released it after free_swap_and_cache() complet=
es. Am I
>>> missing something? Because that part feels pretty clear to me.
>>=20
>> Why should try_to_unuse() do *anything* if it already finds
>> si->inuse_pages =3D=3D 0 because we (p1 } p2) just freed the swapentries=
 and process
>> 2 managed to free the last remaining swapcache entry?
>
> Yeah ok. For some reason I thought unuse_mm() was iterating over all mms =
and so
> the `while (READ_ONCE(si->inuse_pages))` was only evaluated after iterati=
ng over
> every mm. Oops.
>
> So yes, I agree with you; I think this is broken. And I'm a bit worried t=
his
> could be a can of worms; By the same logic, I think folio_free_swap(),
> swp_swapcount() and probably others are broken in the same way.

Don't worry too much :-), we have get_swap_device() at least.  We can
insert it anywhere we want because it's quite lightweight.  And, because
swapoff() is so rare, the race is theoretical only.

For this specific case, I had thought that PTL is enough.  But after
looking at this more, I found a race here too.  Until
__swap_entry_free() return, we are OK, nobody can reduce the swap count
because we held the PTL.  But, after that, even if its return value is
SWAP_HAS_CACHE (that is, in swap cache), parallel swap_unuse() or
__try_to_reclaim_swap() may remove the folio from swap cache, so free
the swap entry.  So, swapoff() can proceed to free the data structures
in parallel.

To fix the race, we can add get/put_swap_device() in
free_swap_and_cache().

For other places, we can check whether get/put_swap_device() has been
called in callers, and the swap reference we held has been decreased
(e.g., swap count protected by PTL, SWAP_HAS_CACHE protected by folio
lock).

> I wonder if we are missing something here? I've added Hugh - I see he has=
 a lot
> of commits in this area, perhaps he has some advice?
>
> Thanks,
> Ryan
>
>
>>=20
>> I'm probably missing something important :)
>>=20
>> try_to_unuse() really starts with
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0if (!READ_ONCE(si->inuse_pages))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto success;
>>=20

--
Best Regards,
Huang, Ying

