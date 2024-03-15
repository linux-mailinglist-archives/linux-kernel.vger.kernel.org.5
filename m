Return-Path: <linux-kernel+bounces-104378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5374087CD03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17F7D28391D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E651C287;
	Fri, 15 Mar 2024 12:07:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5391862B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710504424; cv=none; b=ZDV0lxGICxFd1V6GG7LEbmAuO8GQR/1Btv7g3FUjRcONLoxhyHDej6AjJD9ypUTf3kLzCZoBw5YKUQeM7SBvosMaYsAN9xmV+gxQjaXwCbjxi3w4qawAxEFIwegIX3n/ZVaNLUrEIBBfBHltHJuOthQa9JceGLE0DG43Sv3NBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710504424; c=relaxed/simple;
	bh=fDvkF6jTJliuGLyCOJH9oxGu1/dL9N3lMa65J0e/pOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlDdar57lBpok6o41rtakIx9XVSPyIwOZh3TjyQlu6dv666jfzqLvLFKKd5R6s5buBzsGukvuLQ3PyZA+tYEKpXcPpmgGC4leBnlOt6nAcsxTdLHDHFsseVbA6O82q2BQ4AZwDeBwd7o6/s+1TYJ7foCgTGX5+FawmvHdiY6O/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D65C15;
	Fri, 15 Mar 2024 05:07:32 -0700 (PDT)
Received: from [10.57.69.160] (unknown [10.57.69.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83D3F3F73F;
	Fri, 15 Mar 2024 05:06:53 -0700 (PDT)
Message-ID: <4fea8887-b3a1-4b32-8484-c3eeb74cf2e0@arm.com>
Date: Fri, 15 Mar 2024 12:06:51 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/03/2024 10:01, Barry Song wrote:
> On Fri, Mar 15, 2024 at 10:17 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>>> On Fri, Mar 15, 2024 at 9:43 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>
>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>
>>>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>>>
>>>>> On an embedded system like Android, more than half of anon memory is
>>>>> actually in swap devices such as zRAM. For example, while an app is
>>>>> switched to background, its most memory might be swapped-out.
>>>>>
>>>>> Now we have mTHP features, unfortunately, if we don't support large folios
>>>>> swap-in, once those large folios are swapped-out, we immediately lose the
>>>>> performance gain we can get through large folios and hardware optimization
>>>>> such as CONT-PTE.
>>>>>
>>>>> This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
>>>>> to those contiguous swaps which were likely swapped out from mTHP as a
>>>>> whole.
>>>>>
>>>>> Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
>>>>> case. It doesn't support swapin_readahead as large folios yet since this
>>>>> kind of shared memory is much less than memory mapped by single process.
>>>>
>>>> In contrast, I still think that it's better to start with normal swap-in
>>>> path, then expand to SWAP_SYCHRONOUS case.
>>>
>>> I'd rather try the reverse direction as non-sync anon memory is only around
>>> 3% in a phone as my observation.
>>
>> Phone is not the only platform that Linux is running on.
> 
> I suppose it's generally true that forked shared anonymous pages only
> constitute a
> small portion of all anonymous pages. The majority of anonymous pages are within
> a single process.
> 
> I agree phones are not the only platform. But Rome wasn't built in a
> day. I can only get
> started on a hardware which I can easily reach and have enough hardware/test
> resources on it. So we may take the first step which can be applied on
> a real product
> and improve its performance, and step by step, we broaden it and make it
> widely useful to various areas  in which I can't reach :-)
> 
> so probably we can have a sysfs "enable" entry with default "n" or
> have a maximum
> swap-in order as Ryan's suggestion [1] at the beginning,

I wasn't neccessarily suggesting that we should hard-code an upper limit. I was
just pointing out that we likely need some policy somewhere because the right
thing very likely depends on the folio size and workload. And there is likely
similar policy needed for CoW.

We already have per-thp-size directories in sysfs, so there is a natural place
to add new controls as you suggest - that would fit well. Of course if we can
avoid exposing yet more controls that would be preferable.

> 
> "
> So in the common case, swap-in will pull in the same size of folio as was
> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
> it makes sense for 2M THP; As the size increases the chances of actually needing
> all of the folio reduces so chances are we are wasting IO. There are similar
> arguments for CoW, where we currently copy 1 page per fault - it probably makes
> sense to copy the whole folio up to a certain size.
> "
> 


