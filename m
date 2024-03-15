Return-Path: <linux-kernel+bounces-104195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C3087CA89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF6328241D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B30179B2;
	Fri, 15 Mar 2024 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bwnVEY0x"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88A175A6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494255; cv=none; b=SnNFbLBmqLmkFI9Yiw/LeHWgrMJUvRvv5Hv1qEPV4WI0C8axj1UAeA28ELHoQEd7Uy93nA1TRdsZWO1sytWfJ+XhW8R6rV0WBpJ+usTutH7sRzedJ0xBRxUrwuzdqHDKZo7LUWh+oWMOwNEx1pKeHlemeHIFVZl45NGM6DUa9xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494255; c=relaxed/simple;
	bh=0AwaHVEEu5wj0fuHBbfehSKilFQUjqeQnXVwSKnsvRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HEpZzsP9rBx8Ir4msm57AOmFl5G026L6ySE3sRp6d0GcI0qco68R8wOhFoFPYdg9Y52+V+BxdLeUPkZuEyyEe7S0UeEnr7HZ+xVEY0xyWVMuzBo71XI4u2c9oJhb7evQPCjmjOi5wQvuun8qX7nj3ClZssUL0zMmDUdq24cOFOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bwnVEY0x; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710494253; x=1742030253;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=0AwaHVEEu5wj0fuHBbfehSKilFQUjqeQnXVwSKnsvRY=;
  b=bwnVEY0xuSBvS4NTQZETNnyJatS250T+2dbKoPV+XeCrndXZHql0oZTs
   2gb+GkBGDlluQt7xdF0XW42L6spBGSc3vxHIfAIizHaG4i0g9s7jyy5wu
   VEsC6Jfv6ls5y99ehNzWr5dnlSP6B+agRzLbtmEiGsPGuRQ0TRIgVg9i4
   I4gSDQ8q6Uytz7emt3U3ddP4F96rwAMzTjJ9n13n0BqJ3tMC3jRDqwByd
   r4WvMOx67vs9AuHd1eTit3WiQLaVXfRF23HXCGIOIe3x4qyHloHSsHdz4
   bEnkFV2VL93qOt7gvJvU69fOSYvxbVnwebvKWnT8/6HIch4f4/ajy4bz9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15998142"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="15998142"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 02:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12528091"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 02:17:27 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  ryan.roberts@arm.com,  chengming.zhou@linux.dev,
  chrisl@kernel.org,  david@redhat.com,  hannes@cmpxchg.org,
  kasong@tencent.com,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  mhocko@suse.com,  nphamcs@gmail.com,
  shy828301@gmail.com,  steven.price@arm.com,  surenb@google.com,
  wangkefeng.wang@huawei.com,  xiang@kernel.org,  yosryahmed@google.com,
  yuzhao@google.com,  Chuanhua Han <hanchuanhua@oppo.com>,  Barry Song
 <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
In-Reply-To: <CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
	(Barry Song's message of "Fri, 15 Mar 2024 21:54:29 +1300")
References: <20240304081348.197341-1-21cnbao@gmail.com>
	<20240304081348.197341-6-21cnbao@gmail.com>
	<87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
Date: Fri, 15 Mar 2024 17:15:33 +0800
Message-ID: <87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> >
>> > On an embedded system like Android, more than half of anon memory is
>> > actually in swap devices such as zRAM. For example, while an app is
>> > switched to background, its most memory might be swapped-out.
>> >
>> > Now we have mTHP features, unfortunately, if we don't support large fo=
lios
>> > swap-in, once those large folios are swapped-out, we immediately lose =
the
>> > performance gain we can get through large folios and hardware optimiza=
tion
>> > such as CONT-PTE.
>> >
>> > This patch brings up mTHP swap-in support. Right now, we limit mTHP sw=
ap-in
>> > to those contiguous swaps which were likely swapped out from mTHP as a
>> > whole.
>> >
>> > Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
>> > case. It doesn't support swapin_readahead as large folios yet since th=
is
>> > kind of shared memory is much less than memory mapped by single proces=
s.
>>
>> In contrast, I still think that it's better to start with normal swap-in
>> path, then expand to SWAP_SYCHRONOUS case.
>
> I'd rather try the reverse direction as non-sync anon memory is only arou=
nd
> 3% in a phone as my observation.

Phone is not the only platform that Linux is running on.

>>
>> In normal swap-in path, we can take advantage of swap readahead
>> information to determine the swapped-in large folio order.  That is, if
>> the return value of swapin_nr_pages() > 1, then we can try to allocate
>> and swapin a large folio.
>
> I am not quite sure we still need to depend on this. in do_anon_page,
> we have broken the assumption and allocated a large folio directly.

I don't think that we have a sophisticated policy to allocate large
folio.  Large folio could waste memory for some workloads, so I think
that it's a good idea to allocate large folio always.

Readahead gives us an opportunity to play with the policy.

> On the other hand, compressing/decompressing large folios as a
> whole rather than doing it one by one can save a large percent of
> CPUs and provide a much lower compression ratio.  With a hardware
> accelerator, this is even faster.

I am not against to support large folio for compressing/decompressing.

I just suggest to do that later, after we play with normal swap-in.
SWAP_SYCHRONOUS related swap-in code is an optimization based on normal
swap.  So, it seems natural to support large folio swap-in for normal
swap-in firstly.

> So I'd rather more aggressively get large folios swap-in involved
> than depending on readahead.

We can take advantage of readahead algorithm in SWAP_SYCHRONOUS
optimization too.  The sub-pages that is not accessed by page fault can
be treated as readahead.  I think that is a better policy than
allocating large folio always.

>>
>> To do that, we need to track whether the sub-pages are accessed.  I
>> guess we need that information for large file folio readahead too.
>>
>> Hi, Matthew,
>>
>> Can you help us on tracking whether the sub-pages of a readahead large
>> folio has been accessed?
>>
>> > Right now, we are re-faulting large folios which are still in swapcach=
e as a
>> > whole, this can effectively decrease extra loops and early-exitings wh=
ich we
>> > have increased in arch_swap_restore() while supporting MTE restore for=
 folios
>> > rather than page. On the other hand, it can also decrease do_swap_page=
 as
>> > PTEs used to be set one by one even we hit a large folio in swapcache.
>> >
>>
--
Best Regards,
Huang, Ying

