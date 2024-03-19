Return-Path: <linux-kernel+bounces-107506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AE87FD71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C51283CBD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACF57F498;
	Tue, 19 Mar 2024 12:19:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649747EF12
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850777; cv=none; b=TT770nwdYS+k7NsL032PUhHXJDpq2sLjGZUX/1u2hAOcWrS5EYEaqvpp9h1PvJiewhCtVwUL/OzPIQpgD0/AW9DnljsLP0d7DP/z2m1W5Txw7r5fJ2gac7Kf2r52i+exVbvFZrL7peqFgDMmZow6rbrKiowGGuiDr2rQvd+3i5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850777; c=relaxed/simple;
	bh=DyGGXrUet0vBAbSHBnXo+2pHg9u7kUJ0fPXbx921ogw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwVKmcX6N6i1qI4LObXqCBqKYmkfHtpB/MgZe/Cd3OUzSOhkgIA9VMitaxDA0AaL0C+rPwcPSAZo9xDrMTVp6uhGJ/A48n+nqMQh7gnM7BER6taTwm6U6/2prSuGGxo+vTghYC35OQCgQh6hrZbsBOx4DGDegdWAxaL4piZrHHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62F1D106F;
	Tue, 19 Mar 2024 05:20:08 -0700 (PDT)
Received: from [10.1.30.191] (XHFQ2J9959.cambridge.arm.com [10.1.30.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C45F3F67D;
	Tue, 19 Mar 2024 05:19:29 -0700 (PDT)
Message-ID: <f918354d-12ee-4349-9356-fc02d2457a26@arm.com>
Date: Tue, 19 Mar 2024 12:19:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev,
 chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com,
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
 <87jzlyvar3.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87jzlyvar3.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 09:20, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
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
>>
>> So from that PoV, it would be good to swap-in to the same size that was
>> swapped-out.
> 
> Sorry, I don't agree with this.  It's better to swap-in and swap-out in
> smallest size if the page is only accessed seldom to avoid to waste
> memory.

If we want to optimize only for memory consumption, I'm sure there are many
things we would do differently. We need to find a balance between memory and
performance. The benefits of folios are well documented and the kernel is
heading in the direction of managing memory in variable-sized blocks. So I don't
think it's as simple as saying we should always swap-in the smallest possible
amount of memory.

You also said we should swap *out* in smallest size possible. Have I
misunderstood you? I thought the case for swapping-out a whole folio without
splitting was well established and non-controversial?

> 
>> But we only kind-of keep that information around, via the swap
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
> [snip]
> 
> --
> Best Regards,
> Huang, Ying


