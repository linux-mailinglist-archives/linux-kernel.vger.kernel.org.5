Return-Path: <linux-kernel+bounces-109931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5F8857E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B67B1F21758
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CE6604B3;
	Thu, 21 Mar 2024 11:13:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F95FEE6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711019601; cv=none; b=cT9FY+RbnixRcTg2p4WjS6I8Z59rKK3RRlnIeeLANN/t7f88bBQZcs6VPcp3FM6FV3Wm0t3jZ+bL46Ri0UL+/YUFqavoRuLr5IiNomaetc6NhgwfQ/L0tii0wwQ1wQ4k7ZzN77H2JNB6b7GSXlkgE7gx11f4GEyLx3Sl24TUIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711019601; c=relaxed/simple;
	bh=pNTklDBXDe8Os16YSePjFhD4gQn1XMycQjVaHu/GdHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZLqwj8bV7fQOpUfp1yH4WkZ1WNqaDMJ4ie+3m8r1HWRpR3mh0qK3xJBcNHFHmh8NSOmtZTfBkVeIpDuPBx+aqORI7ud7KGp5luGx2ap/AOMO8YvoWAtpqXCkO2NSAPJTX8MYrCvVT7jRkHnMmm8jgEdm3zYZ9CMcxzg+amnAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262891007;
	Thu, 21 Mar 2024 04:13:52 -0700 (PDT)
Received: from [10.1.33.177] (XHFQ2J9959.cambridge.arm.com [10.1.33.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2255B3F64C;
	Thu, 21 Mar 2024 04:13:13 -0700 (PDT)
Message-ID: <15b09fcf-a55b-4092-a82a-f8d235994baa@arm.com>
Date: Thu, 21 Mar 2024 11:13:12 +0000
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
 <d678a127-f401-4bc2-94b5-723ce4e44270@arm.com>
 <CAGsJ_4x5UMM9XFJWBERZssBtJosEKZrP5SxygKJ+fq=BG0Hh0g@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x5UMM9XFJWBERZssBtJosEKZrP5SxygKJ+fq=BG0Hh0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/03/2024 09:22, Barry Song wrote:
> On Tue, Mar 19, 2024 at 10:05 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 19/03/2024 06:27, Barry Song wrote:
>>> On Tue, Mar 19, 2024 at 5:45 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>>>>> I agree phones are not the only platform. But Rome wasn't built in a
>>>>>>> day. I can only get
>>>>>>> started on a hardware which I can easily reach and have enough hardware/test
>>>>>>> resources on it. So we may take the first step which can be applied on
>>>>>>> a real product
>>>>>>> and improve its performance, and step by step, we broaden it and make it
>>>>>>> widely useful to various areas  in which I can't reach :-)
>>>>>>
>>>>>> We must guarantee the normal swap path runs correctly and has no
>>>>>> performance regression when developing SWP_SYNCHRONOUS_IO optimization.
>>>>>> So we have to put some effort on the normal path test anyway.
>>>>>>
>>>>>>> so probably we can have a sysfs "enable" entry with default "n" or
>>>>>>> have a maximum
>>>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
>>>>>>>
>>>>>>> "
>>>>>>> So in the common case, swap-in will pull in the same size of folio as was
>>>>>>> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
>>>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
>>>>>>> it makes sense for 2M THP; As the size increases the chances of actually needing
>>>>>>> all of the folio reduces so chances are we are wasting IO. There are similar
>>>>>>> arguments for CoW, where we currently copy 1 page per fault - it probably makes
>>>>>>> sense to copy the whole folio up to a certain size.
>>>>>>> "
>>>>
>>>> I thought about this a bit more. No clear conclusions, but hoped this might help
>>>> the discussion around policy:
>>>>
>>>> The decision about the size of the THP is made at first fault, with some help
>>>> from user space and in future we might make decisions to split based on
>>>> munmap/mremap/etc hints. In an ideal world, the fact that we have had to swap
>>>> the THP out at some point in its lifetime should not impact on its size. It's
>>>> just being moved around in the system and the reason for our original decision
>>>> should still hold.
>>>
>>> Indeed, this is an ideal framework for smartphones and likely for
>>> widely embedded
>>> Linux systems utilizing zRAM. We set the mTHP size to 64KiB to
>>> leverage CONT-PTE,
>>> given that more than half of the memory on phones may frequently swap out and
>>> swap in (for instance, when opening and switching between apps). The
>>> ideal approach
>>> would involve adhering to the decision made in do_anonymous_page().
>>>
>>>>
>>>> So from that PoV, it would be good to swap-in to the same size that was
>>>> swapped-out. But we only kind-of keep that information around, via the swap
>>>> entry contiguity and alignment. With that scheme it is possible that multiple
>>>> virtually adjacent but not physically contiguous folios get swapped-out to
>>>> adjacent swap slot ranges and then they would be swapped-in to a single, larger
>>>> folio. This is not ideal, and I think it would be valuable to try to maintain
>>>> the original folio size information with the swap slot. One way to do this would
>>>> be to store the original order for which the cluster was allocated in the
>>>> cluster. Then we at least know that a given swap slot is either for a folio of
>>>> that order or an order-0 folio (due to cluster exhaustion/scanning). Can we
>>>> steal a bit from swap_map to determine which case it is? Or are there better
>>>> approaches?
>>>
>>> In the case of non-SWP_SYNCHRONOUS_IO, users will invariably invoke
>>> swap_readahead()
>>> even when __swap_count(entry) equals 1.  This leads to two scenarios:
>>> swap_vma_readahead
>>> and swap_cluster_readahead.
>>>
>>> In swap_vma_readahead, when blk_queue_nonrot, physical contiguity
>>> doesn't appear to be a
>>> critical concern. However, for swap_cluster_readahead, the focus
>>> shifts towards the potential
>>> impact of physical discontiguity.
>>
>> When you talk about "physical [dis]contiguity" I think you are talking about
>> contiguity of the swap entries in the swap device? Both paths currently allocate
>> order-0 folios to swap into, so neither have a concept of physical contiguity in
>> memory at the moment.
>>
>> As I understand it, roughly the aim is to readahead by cluster for rotating
>> disks to reduce seek time, and readahead by virtual address for non-rotating
>> devices since there is no seek time cost. Correct?
> 
> From the  code comment, I agree with this.
> 
>  * It's a main entry function for swap readahead. By the configuration,
>  * it will read ahead blocks by cluster-based(ie, physical disk based)
>  * or vma-based(ie, virtual address based on faulty address) readahead.
> 
>>
>> Note that today, swap-out on supports (2M) THP if the swap device is
>> non-rotating. If it is rotating, the THP is first split. My swap-out series
>> maintains this policy for mTHP. So I think we only really care about
>> swap_vma_readahead() here; we want to teach it to figure out the order of the
>> swap entries and swap them into folios of the same order (with a fallback to
>> order-0 if allocation fails).
> 
> I agree we don't need to care about devices which rotate.
> 
>>
>>>
>>> struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>>                                 struct vm_fault *vmf)
>>> {
>>>         struct mempolicy *mpol;
>>>         pgoff_t ilx;
>>>         struct folio *folio;
>>>
>>>         mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>>>         folio = swap_use_vma_readahead() ?
>>>                 swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
>>>                 swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
>>>         mpol_cond_put(mpol);
>>>
>>>         if (!folio)
>>>                 return NULL;
>>>         return folio_file_page(folio, swp_offset(entry));
>>> }
>>>
>>> In Android and embedded systems, SWP_SYNCHRONOUS_IO is consistently utilized,
>>> rendering physical contiguity less of a concern. Moreover, instances where
>>> swap_readahead() is accessed are rare, typically occurring only in scenarios
>>> involving forked but non-CoWed memory.
>>
>> Yes understood. What I'm hearing is that for Android at least, stealing a bit
>> from swap_map to remember if a swap entry is the order marked in the cluster or
>> order-0 won't be noticed because almost all entries have swap count == 1. From
>> memory, I think swap_map is 8 bits, and 2 bits are currently stolen, leaving 6
>> bits (count = 64) before having to move to the swap map continuation stuff. Does
>> anyone know what workloads provoke this overflow? What are the consequences of
>> reducing that count to 32?
> 
> I'm not entirely clear on why you need bits to record this
> information. Could you
> provide more details?

For norot media, the swap device is carved up into "clusters", each the same
size as the pmd-size. Empty clusters are kept on a free list. Each CPU maintains
a "current cluster" that it fills sequentially with order-0 entries. To swap out
a THP, a whole cluster is allocated from the free list and used. (My swap-out
series expands this so that each CPU maintains a current cluster per-order to
fill sequentially with swap entries of that order). Once a cluster has been
filled, the CPU allocates a new current cluster. If no clusters are available,
only order-0 swap out will succeed, and in that case it will scan through the
entire swap device looking for a free slot. Once swapped-out, there is no
maintained information to tell you, for a given swap slot, what the originating
folio size was. We always swap-in in order-0 units, so it doesn't matter.

A side effect of this is that a page from what was a PMD-sized THP could be
swapped back in, meaning there is a free order-0 swap slot in that cluster. That
could then be allocated by the scanner, so the cluster now holds part of what
was a THP and an order-0 page. With my swap-out series, that mixing of orders
within a cluster becomes even more likely; (e.g.) we could have a current
cluster (2M) for order-4 (64K) and have swapped-out 2 folios, using up the first
128K). Then we try to swap out an order-0 and have to fall back to the scanner
because swap is fragmented. The scanner then puts the order-0 in the swap entry
after the second order-4 folio; the cluster now has a mix of order-4 and order-0
folios.

If we want to store the original folio size in the swap device, I was suggesting
that one approach would be to store the "primary" order of the cluster in the
cluster info struct. But that is not sufficient on its own, because there can
also be order-0 entries in the same cluster (due to either of the 2 mechanisms I
described above - either a page from a large order entry was freed, meaning all
the other pages in the large swap entry become order-0, or an order-0 was added
to the cluster by the scanner). So to discriminate these 2 possibilities on a
per-swap entry basis (either the swap entry is large and of the order indicated
by the cluster, or it is small), we need a per-swap entry bit.

swap_map is the the per-swap entry state that is currently maintained, and it is
(in the common case) 8 bits. 1 bit is used to remember if the swap entry has a
folio in the swap cache. And another bit is used for something relating to shmem
IIRC). The rest of the bits are used to count references to the swap entry (its
a bit more complicated but you get the idea). I was wondering if we could steal
a bit from the reference count to use for discrimanation between "swap entry is
size indicated by cluster's primary order" and "swap entry is order-0".


> 
>>
>>>
>>> So I think large folios swap-in will at least need three steps
>>>
>>> 1. on SWP_SYNCHRONOUS_IO (Android and embedded Linux), this has a very
>>> clear model and has no complex I/O issue.
>>> 2. on nonrot block device(bdev_nonrot ==  true), it cares less about
>>> I/O contiguity.
>>> 3. on rot block devices which care about  I/O contiguity.
>>
>> I don't think we care about (3); if the device rotates, we will have split the
>> folio at swap-out, so we are only concerned with swapping-in order-0 folios.
>>
>>>
>>> This patchset primarily addresses the systems utilizing
>>> SWP_SYNCHRONOUS_IO(type1),
>>> such as Android and embedded Linux, a straightforward model is established,
>>> with minimal complexity regarding I/O issues.
>>
>> Understood. But your implication is that making swap_vma_readahead() large folio
>> swap-in aware will be complex. I think we can remember the original order in the
>> swap device, then it shouldn't be too difficult - conceptually at least.
> 
> Currently, I can scan PTE entries and determine the number of
> contiguous swap offsets.

That's an approximation; if the folio was mapped into multiple processes and
partially mapped in the one you are swapping in for. But perhaps that is
sufficiently uncommon that it doesn't matter? It certainly removes the need for
storing the precise information in the swap device as I described above. To be
honest, I hadn't considered the PTEs; I was thinking only about the swap slot
contiguity.

> The swap_vma_readahead code to support large folios already exists in
> OPPO's repository.
> I'm confident that it can be cleaned up and submitted to LKML.
> However, the issue lies with
> the readahead policy. We typically prefer using the same 64KiB size as in
> do_anonymous_page(), but clearly, this isn't the preference for Ying :-)

I haven't caught up on all the latest discssion (although I see a bunch of
unread emails in my inbox :) ). But my view at the moment is roughly;

 - continue to calculate readahead as before
 - always swap-in folios in their original size
    - always swap-in the full faulting folio
    - calculate which other folios to readahead by rounding the calculated
      readahead endpoint to the nearest folio boundary.
 - Or if the "round to nearest" policy is shown to be problematic, introduce a
   "max swap-in folio size" tunable and round to that nearest boundary instead.

If we need the tunable, a default of 4K is same as current behaviour. 64K would
likely be a good setting for a system using contpte mappings. And 2M would
provide behaviour descibed above without the tubable.

> 
>>
>>>
>>>>
>>>> Next we (I?) have concerns about wasting IO by swapping-in folios that are too
>>>> large (e.g. 2M). I'm not sure if this is a real problem or not - intuitively I'd
>>>> say yes but I have no data. But on the other hand, memory is aged and
>>>> swapped-out per-folio, so why shouldn't it be swapped-in per folio? If the
>>>> original allocation size policy is good (it currently isn't) then a folio should
>>>> be sized to cover temporally close memory and if we need to access some of it,
>>>> chances are we need all of it.
>>>>
>>>> If we think the IO concern is legitimate then we could define a threshold size
>>>> (sysfs?) for when we start swapping-in the folio in chunks. And how big should
>>>> those chunks be - one page, or the threshold size itself? Probably the latter?
>>>> And perhaps that threshold could also be used by zRAM to decide its upper limit
>>>> for compression chunk.
>>>
>>>
>>> Agreed. What about introducing a parameter like
>>> /sys/kernel/mm/transparent_hugepage/max_swapin_order
>>> giving users the opportunity to fine-tune it according to their needs. For type1
>>> users specifically, setting it to any value above 4 would be
>>> beneficial. If there's
>>> still a lack of tuning for desktop and server environments (type 2 and type 3),
>>> the default value could be set to 0.
>>
>> This sort of thing sounds sensible to me. But I have a history of proposing
>> crappy sysfs interfaces :) So I'd like to hear from others - I suspect it will
>> take a fair bit of discussion before we converge. Having data to show that this
>> threshold is needed would also help (i.e. demonstration that the intuition that
>> swapping in a 2M folio is often counter-productive to performance).
>>
> 
> I understand. The ideal swap-in size is obviously a contentious topic :-)
> However,  for my real use case, simplicity reigns: we consistently adhere
> to a single size - 64KiB.
> 
>>>
>>>>
>>>> Perhaps we can learn from khugepaged here? I think it has programmable
>>>> thresholds for how many swapped-out pages can be swapped-in to aid collapse to a
>>>> THP? I guess that exists for the same concerns about increased IO pressure?
>>>>
>>>>
>>>> If we think we will ever be swapping-in folios in chunks less than their
>>>> original size, then we need a separate mechanism to re-foliate them. We have
>>>> discussed a khugepaged-like approach for doing this asynchronously in the
>>>> background. I know that scares the Android folks, but David has suggested that
>>>> this could well be very cheap compared with khugepaged, because it would be
>>>> entirely limited to a single pgtable, so we only need the PTL. If we need this
>>>> mechanism anyway, perhaps we should develop it and see how it performs if
>>>> swap-in remains order-0? Although I guess that would imply not being able to
>>>> benefit from compressing THPs for the zRAM case.
>>>
>>> The effectiveness of collapse operation relies on the stability of
>>> forming large folios
>>> to ensure optimal performance. In embedded systems, where more than half of the
>>> memory may be allocated to zRAM, folios might undergo swapping out before
>>> collapsing or immediately after the collapse operation. It seems a
>>> TAO-like optimization
>>> to decrease fallback and latency is more effective.
>>
>> Sorry, I'm not sure I've understood what you are saying here.
> 
> I'm not entirely clear on the specifics of the khugepaged-like
> approach. However,a major
> distinction for Android is that its folios may not remain in memory
> for extended periods.
> If we incur the cost of compaction and page migration to form a large
> folio, it might soon
> be swapped out. Therefore, a potentially more efficient approach could
> involve a TAO-like
> pool, where we obtain large folios at a low cost.
> 
>>
>>>
>>>>
>>>> I see all this as orthogonal to synchronous vs asynchronous swap devices. I
>>>> think the latter just implies that you might want to do some readahead to try to
>>>> cover up the latency? If swap is moving towards being folio-orientated, then
>>>> readahead also surely needs to be folio-orientated, but I think that should be
>>>> the only major difference.
>>>>
>>>> Anyway, just some thoughts!
>>>
>>> Thank you very much for your valuable and insightful deliberations.
>>>
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>
> 
> Thanks
> Barry


