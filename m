Return-Path: <linux-kernel+bounces-106386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD0387EDC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7570281CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0B54BDA;
	Mon, 18 Mar 2024 16:45:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DA54BC1
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780333; cv=none; b=Gi3xmINPVmLTag9QbDDj+kEC5UVcuGZ/l5YV3LsId6fmDR/77RB39s/G901ikgdEocRLAx94YasUmyIXNq0YW8c0FxIOClRg1oNfnG2TyiKLfrUeLGd+ZtBQkpK44rIYuE7lD7gTOh9gjOjxhEcpc+5kLJ+s3jiEIbDZP4GRLbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780333; c=relaxed/simple;
	bh=CNQkh8pEl1Kc9VhW0IsTjWYvyFVNMzpjdm/foQVsSJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6HeuBEIpFfU+oQwUJniOOEruQpD+NauALasBg7hCPX+zLLOlKlrGLCiA4rPYu0A5YnH95hr3wqXh3T0lIGDEAp5I09Es1SphXrA3aphUiNUvm9x+3LrhymBb42xvr1KVxcCw6mpfCs9ljgHYpHxMYfkwgFCMrBTrpnm2lbWjxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47A5F1FB;
	Mon, 18 Mar 2024 09:46:05 -0700 (PDT)
Received: from [10.57.68.51] (unknown [10.57.68.51])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 305C83F67D;
	Mon, 18 Mar 2024 09:45:26 -0700 (PDT)
Message-ID: <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com>
Date: Mon, 18 Mar 2024 16:45:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, "Huang, Ying" <ying.huang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
 linux-mm@kvack.org, chengming.zhou@linux.dev, chrisl@kernel.org,
 david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com,
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wTU3cmzXMCu+yQRMnEiCEUA8rO5=QQUopgG0RMnHYd5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>> I agree phones are not the only platform. But Rome wasn't built in a
>>> day. I can only get
>>> started on a hardware which I can easily reach and have enough hardware/test
>>> resources on it. So we may take the first step which can be applied on
>>> a real product
>>> and improve its performance, and step by step, we broaden it and make it
>>> widely useful to various areas  in which I can't reach :-)
>>
>> We must guarantee the normal swap path runs correctly and has no
>> performance regression when developing SWP_SYNCHRONOUS_IO optimization.
>> So we have to put some effort on the normal path test anyway.
>>
>>> so probably we can have a sysfs "enable" entry with default "n" or
>>> have a maximum
>>> swap-in order as Ryan's suggestion [1] at the beginning,
>>>
>>> "
>>> So in the common case, swap-in will pull in the same size of folio as was
>>> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
>>> it makes sense for 2M THP; As the size increases the chances of actually needing
>>> all of the folio reduces so chances are we are wasting IO. There are similar
>>> arguments for CoW, where we currently copy 1 page per fault - it probably makes
>>> sense to copy the whole folio up to a certain size.
>>> "

I thought about this a bit more. No clear conclusions, but hoped this might help
the discussion around policy:

The decision about the size of the THP is made at first fault, with some help
from user space and in future we might make decisions to split based on
munmap/mremap/etc hints. In an ideal world, the fact that we have had to swap
the THP out at some point in its lifetime should not impact on its size. It's
just being moved around in the system and the reason for our original decision
should still hold.

So from that PoV, it would be good to swap-in to the same size that was
swapped-out. But we only kind-of keep that information around, via the swap
entry contiguity and alignment. With that scheme it is possible that multiple
virtually adjacent but not physically contiguous folios get swapped-out to
adjacent swap slot ranges and then they would be swapped-in to a single, larger
folio. This is not ideal, and I think it would be valuable to try to maintain
the original folio size information with the swap slot. One way to do this would
be to store the original order for which the cluster was allocated in the
cluster. Then we at least know that a given swap slot is either for a folio of
that order or an order-0 folio (due to cluster exhaustion/scanning). Can we
steal a bit from swap_map to determine which case it is? Or are there better
approaches?

Next we (I?) have concerns about wasting IO by swapping-in folios that are too
large (e.g. 2M). I'm not sure if this is a real problem or not - intuitively I'd
say yes but I have no data. But on the other hand, memory is aged and
swapped-out per-folio, so why shouldn't it be swapped-in per folio? If the
original allocation size policy is good (it currently isn't) then a folio should
be sized to cover temporally close memory and if we need to access some of it,
chances are we need all of it.

If we think the IO concern is legitimate then we could define a threshold size
(sysfs?) for when we start swapping-in the folio in chunks. And how big should
those chunks be - one page, or the threshold size itself? Probably the latter?
And perhaps that threshold could also be used by zRAM to decide its upper limit
for compression chunk.

Perhaps we can learn from khugepaged here? I think it has programmable
thresholds for how many swapped-out pages can be swapped-in to aid collapse to a
THP? I guess that exists for the same concerns about increased IO pressure?


If we think we will ever be swapping-in folios in chunks less than their
original size, then we need a separate mechanism to re-foliate them. We have
discussed a khugepaged-like approach for doing this asynchronously in the
background. I know that scares the Android folks, but David has suggested that
this could well be very cheap compared with khugepaged, because it would be
entirely limited to a single pgtable, so we only need the PTL. If we need this
mechanism anyway, perhaps we should develop it and see how it performs if
swap-in remains order-0? Although I guess that would imply not being able to
benefit from compressing THPs for the zRAM case.

I see all this as orthogonal to synchronous vs asynchronous swap devices. I
think the latter just implies that you might want to do some readahead to try to
cover up the latency? If swap is moving towards being folio-orientated, then
readahead also surely needs to be folio-orientated, but I think that should be
the only major difference.

Anyway, just some thoughts!

Thanks,
Ryan


