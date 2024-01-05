Return-Path: <linux-kernel+bounces-17742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9228251DA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E04283ED5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15D25116;
	Fri,  5 Jan 2024 10:25:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AE9250E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7519DC15;
	Fri,  5 Jan 2024 02:26:29 -0800 (PST)
Received: from [10.57.76.44] (unknown [10.57.76.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D652A3F64C;
	Fri,  5 Jan 2024 02:25:41 -0800 (PST)
Message-ID: <63eda2bc-6791-454d-b43e-20d73c7e9843@arm.com>
Date: Fri, 5 Jan 2024 10:25:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] WARNING in __folio_rmap_sanity_checks
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>, Yin Fengwei
 <fengwei.yin@intel.com>,
 syzbot <syzbot+50ef73537bbc393a25bb@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <000000000000014174060e09316e@google.com>
 <c4e2e700-2d26-492f-8eb2-eb3ab14bc07a@redhat.com>
 <3feecbd6-b3bd-440c-a4f9-2a7dba3ff8f1@intel.com>
 <36ace74a-1de7-4224-8bc1-7f487764f6e2@redhat.com>
 <8bc02927-a0f0-490a-a014-0e100d30ffe4@intel.com>
 <1eb61435-c89c-4ca1-b1b6-aa00b3478cd2@arm.com>
 <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <556f8a4f-c739-41e0-85ec-643a0b32a2ce@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05/01/2024 08:56, David Hildenbrand wrote:
>>>>>> If I am not wrong, that triggers:
>>>>>>
>>>>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
>>>>>>             !folio_test_large_rmappable(folio), folio);
>>>>>>
>>>>>> So we are trying to rmap a large folio that did not go through
>>>>>> folio_prep_large_rmappable().
>>
>> Would someone mind explaining the rules to me for this? As far as I can see,
>> folio_prep_large_rmappable() just inits the _deferred_list and sets a flag so we
>> remember to deinit the list on destruction. Why can't we just init that list for
>> all folios order-2 or greater? Then everything is rmappable?
> 
> I think we much rather want to look into moving all mapcount-related stuff into
> folio_prep_large_rmappable(). It doesn't make any sense to initialize that for
> any compound pages, especially the ones that will never get mapped to user space.
> 
>>
>>>>>>
>>>>>> net/packet/af_packet.c calls vm_insert_page() on some pages/folios stoed
>>>>>> in the "struct packet_ring_buffer". No idea where that comes from, but I
>>>>>> suspect it's simply some compound allocation.
>>>>> Looks like:
>>>>>     alloc_pg_vec
>>>>>       alloc_one_pg_vec_page
>>>>>            gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
>>>>>                              __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
>>>>>
>>>>>            buffer = (char *) __get_free_pages(gfp_flags, order);
>>>>> So you are right here... :).
>>>>
>>>> Hm, but I wonder if this something that's supposed to work or is this one of
>>>> the cases where we should actually use a VM_PFN mapping?
>>>>
>>>> It's not a pagecache(file/shmem) page after all.
>>>>
>>>> We could relax that check and document why we expect something that is not
>>>> marked rmappable. But it fells wrong. I suspect this should be a VM_PFNMAP
>>>> instead (like recent udmabuf changes).
>>>
>>> VM_PFNMAP looks correct.
>>
>> And why is making the folio rmappable and mapping it the normal way not the
>> right solution here? Because the folio could be order-1? Or something more
>> profound?
>>
> 
> Think about it: we are adding/removing a page from rmap handling that can
> *never* be looked up using the rmap because there is no rmap for these pages,
> and folio->index is just completely unexpressive. VM_MIXEDMAP doesn't have any
> linearity constraints.

I guess I was assuming treating it the same way as anon folios. But I guess that
would be VeryBad (TM) because these aren't anon pages and we don't want to swap,
etc? OK got it.

> 
> Logically, it doesn't make any sense to involve rmap code although it currently
> might work. validate_page_before_insert() blocks off most pages where the
> order-0 mapcount would be used for other purposes and everything would blow up.
> 
> Looking at vm_insert_page(), this interface is only for pages the caller
> allocated. Maybe we should just not do any rmap accounting when
> mapping/unmapping these pages: not involve any rmap code, including mapcounts?
> 
> vm_normal_page() works on these mappings, so we'd also have to skip rmap code
> when unmapping these pages etc. Maybe that's the whole reason we have the rmap
> handling here: to not special-case the unmap path.

Right. I guess it depends what vm_insert_page() is spec'ed to expect; is the bug
in the implementation or is the caller providing the wrong type of folio? I
guess there will be many callers providing non-rmappable folios (inc out of tree?).

> 
> Alternatively, we can:
> 
> (1) Require the caller to make sure large folios are rmappable. We
>     already require allocations to be compound. Should be easy to add.

I'm not sure this is practical given vm_insert_page() is exported?

> (2) Allow non-rmappable folios in rmap code just for mapcount tracking.
>     Confusing but possible.
> 
>>>
>>> I do have another question: why do we just check the large folio
>>> rmappable? Does that mean order0 folio is always rmappable?
>>>
> 
> We didn't really have a check for that I believe. We simply reject all pages in
> vm_insert_page() that are problematic because the pagecount is overloaded.
> 
>>> I ask this because vm_insert_pages() is called in net/ipv4/tcp.c
>>> and drivers call vm_insert_page. I suppose they all need be VM_PFNMAP.
> 
> Right, similar problem.
> 


