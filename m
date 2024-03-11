Return-Path: <linux-kernel+bounces-98654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE61877D72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5AB1F21F28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B32BAF2;
	Mon, 11 Mar 2024 09:55:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C08B14298
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710150952; cv=none; b=tc3dYq+eN0hX9KmL2tkf/aNjbQ5SDPLItBbkdZDoA4HGNyIBZvvWGPZQNW20/mrU9NfbmN2D72hYNBbR5sHz5J4P0boWLFg8Hyddt1eObG8YP5FHEWJIpgigb0ELWlQKhgpH4qHm5qOFddMMYnEXk4ua24qVxUdMHwvznZ236Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710150952; c=relaxed/simple;
	bh=PVQ0nLXJeQRQT9nyBVKRT/9QcfjaLIzaAdJ3AvAhDxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8yC7SIHMcJ79uI34g34pRY+DMBRMks+BmKSwBEKLcjUhTA5yFiBO+aUfzPDeVlX4hnKqX8/Q/zMvMTYNrXtmlBxEPwVE4Fl1k2ZG3AKkqCMVK/DiRfzpChH7F8OOlCl/bJKUNejjmHAMSQHCcCrBi/TXj8zoTG+Zje3KdVYv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E748FEC;
	Mon, 11 Mar 2024 02:56:26 -0700 (PDT)
Received: from [10.57.68.246] (unknown [10.57.68.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E8603F762;
	Mon, 11 Mar 2024 02:55:46 -0700 (PDT)
Message-ID: <37bc1a30-7613-4404-b123-c351e36fc800@arm.com>
Date: Mon, 11 Mar 2024 09:55:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
 Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org,
 zokeefe@google.com, shy828301@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
 <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com>
 <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com>
 <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com>
 <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com>
 <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com>
 <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
 <60dc7309-cb38-45e3-b2c0-ff0119202a12@arm.com>
 <CAGsJ_4yaJ5weXd8N=zwoo1xa8jvEdZnFOGQ0pjUXB1EUsrRTcA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4yaJ5weXd8N=zwoo1xa8jvEdZnFOGQ0pjUXB1EUsrRTcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[...]

>>>>> we don't want reclamation overhead later. and we want memories immediately
>>>>> available to others.
>>>>
>>>> But by that logic, you also don't want to leave the large folio partially mapped
>>>> all the way until the last subpage is CoWed. Surely you would want to reclaim it
>>>> when you reach partial map status?
>>>
>>> To some extent, I agree. But then we will have two many copies. The last
>>> subpage is small, and a safe place to copy instead.
>>>
>>> We actually had to tune userspace to decrease partial map as too much
>>> partial map both unfolded CONT-PTE and wasted too much memory. if a
>>> vma had too much partial map, we disabled mTHP on this VMA.
>>
>> I actually had a whacky idea around introducing selectable page size ABI
>> per-process that might help here. I know Android is doing work to make the
>> system 16K page compatible. You could run most of the system processes with 16K
>> ABI on top of 4K kernel. Then those processes don't even have the ability to
>> madvise/munmap/mprotect/mremap anything less than 16K alignment so that acts as
>> an anti-fragmentation mechanism while allowing non-16K capable processes to run
>> side-by-side. Just a passing thought...
> 
> Right, this project faces a challenge in supporting legacy
> 4KiB-aligned applications.
> but I don't find it will be an issue to run 16KiB-aligned applications
> on a kernel whose
> page size is 4KiB.

Yes, agreed that a 16K-aligned (or 64K-aligned) app will work without issue on
4K kernel, but it will also use getpagesize() and know what the page size is.
I'm suggesting you could actually run these apps on a 4K kernel but with a 16K
ABI and potentially get close to the native 16K performance out of them. It's
just a thought though - I don't have any data that actually shows this is better
than just running on a 4K kernel with a 4K ABI, and using 16K or 64K mTHP
opportunistically.


