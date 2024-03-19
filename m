Return-Path: <linux-kernel+bounces-107275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DADA787FA49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663C52824AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF47C090;
	Tue, 19 Mar 2024 09:06:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F7E54BE2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839162; cv=none; b=tw4yFRVGzRbcus+4EMnO3pP2+dhKfZA0woxhTl19RljPowSoWnhB7hz3kxeKnpYGU2okh2qLiC5gEW+XBrduLjOoBm6MneUc+GMB2WDjLr9jMbc7Yj3Pjp669ey0wif0bBOYdy5RyoafVWk6gFsZ9pOgOXtHi3CXUJ5KAgIGjwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839162; c=relaxed/simple;
	bh=0qICyTh4ipdu6Sfqyor7UU+nte1iUiLGJgIqZ6/xXRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAUmA9fdsLCnfXyAQ6nYVcufLmHriASoZy/m1TrkVRJEATMPBlsxBIomvCTy6E+KrbM7dCzB/lvS8tKdMTfTRjl/rkAA8EPgjtGlJwIZtp4zma/SXhWLOO7fCSdix1HUWuHOqb6mo1uG+kYP8XqkD6bfKxchlPNjlz+nyiGvLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5691E106F;
	Tue, 19 Mar 2024 02:06:32 -0700 (PDT)
Received: from [10.57.68.51] (unknown [10.57.68.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A4503F64C;
	Tue, 19 Mar 2024 02:05:52 -0700 (PDT)
Message-ID: <d678a127-f401-4bc2-94b5-723ce4e44270@arm.com>
Date: Tue, 19 Mar 2024 09:05:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox
 <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org,
 chengming.zhou@linux.dev, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, kasong@tencent.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com,
 steven.price@arm.com, surenb@google.com, wangkefeng.wang@huawei.com,
 xiang@kernel.org, yosryahmed@google.com, yuzhao@google.com,
 Chuanhua Han <hanchuanhua@oppo.com>, Barry Song <v-songbaohua@oppo.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
 <20240304081348.197341-6-21cnbao@gmail.com>
 <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
 <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
 <87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wTU3cmzXMCu+yQRMnEiCEUA8rO5=QQUopgG0RMnHYd5g@mail.gmail.com>
 <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com>
 <CAGsJ_4xBiWWEbyaxC6nhjpA5te6Q8irQmFxZDePCRZtcpF0sVQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xBiWWEbyaxC6nhjpA5te6Q8irQmFxZDePCRZtcpF0sVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2024 06:27, Barry Song wrote:
> On Tue, Mar 19, 2024 at 5:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>>>>> I agree phones are not the only platform. But Rome wasn't built in a
>>>>> day. I can only get
>>>>> started on a hardware which I can easily reach and have enough hardware/test
>>>>> resources on it. So we may take the first step which can be applied on
>>>>> a real product
>>>>> and improve its performance, and step by step, we broaden it and make it
>>>>> widely useful to various areas  in which I can't reach :-)
>>>>
>>>> We must guarantee the normal swap path runs correctly and has no
>>>> performance regression when developing SWP_SYNCHRONOUS_IO optimization.
>>>> So we have to put some effort on the normal path test anyway.
>>>>
>>>>> so probably we can have a sysfs "enable" entry with default "n" or
>>>>> have a maximum
>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
>>>>>
>>>>> "
>>>>> So in the common case, swap-in will pull in the same size of folio as was
>>>>> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
>>>>> it makes sense for 2M THP; As the size increases the chances of actually needing
>>>>> all of the folio reduces so chances are we are wasting IO. There are similar
>>>>> arguments for CoW, where we currently copy 1 page per fault - it probably makes
>>>>> sense to copy the whole folio up to a certain size.
>>>>> "
>>
>> I thought about this a bit more. No clear conclusions, but hoped this might help
>> the discussion around policy:
>>
>> The decision about the size of the THP is made at first fault, with some help
>> from user space and in future we might make decisions to split based on
>> munmap/mremap/etc hints. In an ideal world, the fact that we have had to swap
>> the THP out at some point in its lifetime should not impact on its size. It's
>> just being moved around in the system and the reason for our original decision
>> should still hold.
> 
> Indeed, this is an ideal framework for smartphones and likely for
> widely embedded
> Linux systems utilizing zRAM. We set the mTHP size to 64KiB to
> leverage CONT-PTE,
> given that more than half of the memory on phones may frequently swap out and
> swap in (for instance, when opening and switching between apps). The
> ideal approach
> would involve adhering to the decision made in do_anonymous_page().
> 
>>
>> So from that PoV, it would be good to swap-in to the same size that was
>> swapped-out. But we only kind-of keep that information around, via the swap
>> entry contiguity and alignment. With that scheme it is possible that multiple
>> virtually adjacent but not physically contiguous folios get swapped-out to
>> adjacent swap slot ranges and then they would be swapped-in to a single, larger
>> folio. This is not ideal, and I think it would be valuable to try to maintain
>> the original folio size information with the swap slot. One way to do this would
>> be to store the original order for which the cluster was allocated in the
>> cluster. Then we at least know that a given swap slot is either for a folio of
>> that order or an order-0 folio (due to cluster exhaustion/scanning). Can we
>> steal a bit from swap_map to determine which case it is? Or are there better
>> approaches?
> 
> In the case of non-SWP_SYNCHRONOUS_IO, users will invariably invoke
> swap_readahead()
> even when __swap_count(entry) equals 1.  This leads to two scenarios:
> swap_vma_readahead
> and swap_cluster_readahead.
> 
> In swap_vma_readahead, when blk_queue_nonrot, physical contiguity
> doesn't appear to be a
> critical concern. However, for swap_cluster_readahead, the focus
> shifts towards the potential
> impact of physical discontiguity.

When you talk about "physical [dis]contiguity" I think you are talking about
contiguity of the swap entries in the swap device? Both paths currently allocate
order-0 folios to swap into, so neither have a concept of physical contiguity in
memory at the moment.

As I understand it, roughly the aim is to readahead by cluster for rotating
disks to reduce seek time, and readahead by virtual address for non-rotating
devices since there is no seek time cost. Correct?

Note that today, swap-out on supports (2M) THP if the swap device is
non-rotating. If it is rotating, the THP is first split. My swap-out series
maintains this policy for mTHP. So I think we only really care about
swap_vma_readahead() here; we want to teach it to figure out the order of the
swap entries and swap them into folios of the same order (with a fallback to
order-0 if allocation fails).

> 
> struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>                                 struct vm_fault *vmf)
> {
>         struct mempolicy *mpol;
>         pgoff_t ilx;
>         struct folio *folio;
> 
>         mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>         folio = swap_use_vma_readahead() ?
>                 swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
>                 swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
>         mpol_cond_put(mpol);
> 
>         if (!folio)
>                 return NULL;
>         return folio_file_page(folio, swp_offset(entry));
> }
> 
> In Android and embedded systems, SWP_SYNCHRONOUS_IO is consistently utilized,
> rendering physical contiguity less of a concern. Moreover, instances where
> swap_readahead() is accessed are rare, typically occurring only in scenarios
> involving forked but non-CoWed memory.

Yes understood. What I'm hearing is that for Android at least, stealing a bit
from swap_map to remember if a swap entry is the order marked in the cluster or
order-0 won't be noticed because almost all entries have swap count == 1. From
memory, I think swap_map is 8 bits, and 2 bits are currently stolen, leaving 6
bits (count = 64) before having to move to the swap map continuation stuff. Does
anyone know what workloads provoke this overflow? What are the consequences of
reducing that count to 32?

> 
> So I think large folios swap-in will at least need three steps
> 
> 1. on SWP_SYNCHRONOUS_IO (Android and embedded Linux), this has a very
> clear model and has no complex I/O issue.
> 2. on nonrot block device(bdev_nonrot ==  true), it cares less about
> I/O contiguity.
> 3. on rot block devices which care about  I/O contiguity.

I don't think we care about (3); if the device rotates, we will have split the
folio at swap-out, so we are only concerned with swapping-in order-0 folios.

> 
> This patchset primarily addresses the systems utilizing
> SWP_SYNCHRONOUS_IO(type1),
> such as Android and embedded Linux, a straightforward model is established,
> with minimal complexity regarding I/O issues.

Understood. But your implication is that making swap_vma_readahead() large folio
swap-in aware will be complex. I think we can remember the original order in the
swap device, then it shouldn't be too difficult - conceptually at least.

> 
>>
>> Next we (I?) have concerns about wasting IO by swapping-in folios that are too
>> large (e.g. 2M). I'm not sure if this is a real problem or not - intuitively I'd
>> say yes but I have no data. But on the other hand, memory is aged and
>> swapped-out per-folio, so why shouldn't it be swapped-in per folio? If the
>> original allocation size policy is good (it currently isn't) then a folio should
>> be sized to cover temporally close memory and if we need to access some of it,
>> chances are we need all of it.
>>
>> If we think the IO concern is legitimate then we could define a threshold size
>> (sysfs?) for when we start swapping-in the folio in chunks. And how big should
>> those chunks be - one page, or the threshold size itself? Probably the latter?
>> And perhaps that threshold could also be used by zRAM to decide its upper limit
>> for compression chunk.
> 
> 
> Agreed. What about introducing a parameter like
> /sys/kernel/mm/transparent_hugepage/max_swapin_order
> giving users the opportunity to fine-tune it according to their needs. For type1
> users specifically, setting it to any value above 4 would be
> beneficial. If there's
> still a lack of tuning for desktop and server environments (type 2 and type 3),
> the default value could be set to 0.

This sort of thing sounds sensible to me. But I have a history of proposing
crappy sysfs interfaces :) So I'd like to hear from others - I suspect it will
take a fair bit of discussion before we converge. Having data to show that this
threshold is needed would also help (i.e. demonstration that the intuition that
swapping in a 2M folio is often counter-productive to performance).

> 
>>
>> Perhaps we can learn from khugepaged here? I think it has programmable
>> thresholds for how many swapped-out pages can be swapped-in to aid collapse to a
>> THP? I guess that exists for the same concerns about increased IO pressure?
>>
>>
>> If we think we will ever be swapping-in folios in chunks less than their
>> original size, then we need a separate mechanism to re-foliate them. We have
>> discussed a khugepaged-like approach for doing this asynchronously in the
>> background. I know that scares the Android folks, but David has suggested that
>> this could well be very cheap compared with khugepaged, because it would be
>> entirely limited to a single pgtable, so we only need the PTL. If we need this
>> mechanism anyway, perhaps we should develop it and see how it performs if
>> swap-in remains order-0? Although I guess that would imply not being able to
>> benefit from compressing THPs for the zRAM case.
> 
> The effectiveness of collapse operation relies on the stability of
> forming large folios
> to ensure optimal performance. In embedded systems, where more than half of the
> memory may be allocated to zRAM, folios might undergo swapping out before
> collapsing or immediately after the collapse operation. It seems a
> TAO-like optimization
> to decrease fallback and latency is more effective.

Sorry, I'm not sure I've understood what you are saying here.

> 
>>
>> I see all this as orthogonal to synchronous vs asynchronous swap devices. I
>> think the latter just implies that you might want to do some readahead to try to
>> cover up the latency? If swap is moving towards being folio-orientated, then
>> readahead also surely needs to be folio-orientated, but I think that should be
>> the only major difference.
>>
>> Anyway, just some thoughts!
> 
> Thank you very much for your valuable and insightful deliberations.
> 
>>
>> Thanks,
>> Ryan
>>
> 
> Thanks
> Barry


