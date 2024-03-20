Return-Path: <linux-kernel+bounces-108488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB44880B26
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157E12830CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8B182CC;
	Wed, 20 Mar 2024 06:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JxsirPes"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA21125AC
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915760; cv=none; b=R4GcUxFaxy2SDcXNRQazO2IfdKAWwLhiv8Pl//8KPajC8aBaipOnnJzbosLybAJ5QL7cF16qaJ8eM7p4nM48X8c9hoCcEtmNItAPFe3W5TjW6fo+AZYYT22f1Np9SXvyND+dFG9V3AWDX+blW73FF0fel2A11ZLigkdgQNZ5MPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915760; c=relaxed/simple;
	bh=Msp9rhYQvlhniWjJV1v6egjJ+xLAn/vC+dotpDHA6EE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u4mIBNLBJz1gLwd14BI73h1/3uyEDc0YYAOzq4lJuez6UxEEIaZprQZM/TMDo3zkeb1Zl7WDqW2HrLftY4jkdKxxL2BY+A4CfompFRF0NiXFGvL1X30K1WqOet5jZ9k838XuyUEd2MwqUaXNon1g2OssNH6TDydkRP1zTe63J5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JxsirPes; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710915759; x=1742451759;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Msp9rhYQvlhniWjJV1v6egjJ+xLAn/vC+dotpDHA6EE=;
  b=JxsirPes5Om43Wddi6iucUjlhbST9RPAVALh+Xbd8XRAiOMWf8hJYWRk
   6muUPagegXhg99nfBxcR26so3zSS9PBBL9LhomRfGWPvDn78Tg9Pxu1Im
   vbaYkNal0UXXZIx4Z3dfffXe8zAG/HpUDK6RLtx4kO6sHXCjhXDYlkoIx
   h4aSOcu3bxv9SmXagzWpC2PUZOVaUb8TI3QfhfUNC1O1UgkWBWMLrZDFo
   pVhpm4cuGdaVQWlyzRPBSriE+zxGaOUSsokGRmjKrM/VS6llqOS5cH++N
   QE+V0zOIztsu1/6YNzWn+/ijrI04wVbuTfMYluYwwsK9VpXcQBImpZ6eX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5943015"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5943015"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="18778671"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 23:22:32 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Matthew Wilcox
 <willy@infradead.org>,  akpm@linux-foundation.org,  linux-mm@kvack.org,
  chengming.zhou@linux.dev,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  kasong@tencent.com,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  mhocko@suse.com,  nphamcs@gmail.com,  shy828301@gmail.com,
  steven.price@arm.com,  surenb@google.com,  wangkefeng.wang@huawei.com,
  xiang@kernel.org,  yosryahmed@google.com,  yuzhao@google.com,  Chuanhua
 Han <hanchuanhua@oppo.com>,  Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
In-Reply-To: <CAGsJ_4zuEFnLwM_h7DF1BN2eN3P4S0Sw=omxo90ucKpPT4ampA@mail.gmail.com>
	(Barry Song's message of "Wed, 20 Mar 2024 15:47:50 +1300")
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
	<f918354d-12ee-4349-9356-fc02d2457a26@arm.com>
	<87zfutsl25.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4zuEFnLwM_h7DF1BN2eN3P4S0Sw=omxo90ucKpPT4ampA@mail.gmail.com>
Date: Wed, 20 Mar 2024 14:20:38 +0800
Message-ID: <87msqts9u1.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>> > On 19/03/2024 09:20, Huang, Ying wrote:
>> >> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>
>> >>>>>> I agree phones are not the only platform. But Rome wasn't built i=
n a
>> >>>>>> day. I can only get
>> >>>>>> started on a hardware which I can easily reach and have enough ha=
rdware/test
>> >>>>>> resources on it. So we may take the first step which can be appli=
ed on
>> >>>>>> a real product
>> >>>>>> and improve its performance, and step by step, we broaden it and =
make it
>> >>>>>> widely useful to various areas  in which I can't reach :-)
>> >>>>>
>> >>>>> We must guarantee the normal swap path runs correctly and has no
>> >>>>> performance regression when developing SWP_SYNCHRONOUS_IO optimiza=
tion.
>> >>>>> So we have to put some effort on the normal path test anyway.
>> >>>>>
>> >>>>>> so probably we can have a sysfs "enable" entry with default "n" or
>> >>>>>> have a maximum
>> >>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
>> >>>>>>
>> >>>>>> "
>> >>>>>> So in the common case, swap-in will pull in the same size of foli=
o as was
>> >>>>>> swapped-out. Is that definitely the right policy for all folio si=
zes? Certainly
>> >>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). Bu=
t I'm not sure
>> >>>>>> it makes sense for 2M THP; As the size increases the chances of a=
ctually needing
>> >>>>>> all of the folio reduces so chances are we are wasting IO. There =
are similar
>> >>>>>> arguments for CoW, where we currently copy 1 page per fault - it =
probably makes
>> >>>>>> sense to copy the whole folio up to a certain size.
>> >>>>>> "
>> >>>
>> >>> I thought about this a bit more. No clear conclusions, but hoped thi=
s might help
>> >>> the discussion around policy:
>> >>>
>> >>> The decision about the size of the THP is made at first fault, with =
some help
>> >>> from user space and in future we might make decisions to split based=
 on
>> >>> munmap/mremap/etc hints. In an ideal world, the fact that we have ha=
d to swap
>> >>> the THP out at some point in its lifetime should not impact on its s=
ize. It's
>> >>> just being moved around in the system and the reason for our origina=
l decision
>> >>> should still hold.
>> >>>
>> >>> So from that PoV, it would be good to swap-in to the same size that =
was
>> >>> swapped-out.
>> >>
>> >> Sorry, I don't agree with this.  It's better to swap-in and swap-out =
in
>> >> smallest size if the page is only accessed seldom to avoid to waste
>> >> memory.
>> >
>> > If we want to optimize only for memory consumption, I'm sure there are=
 many
>> > things we would do differently. We need to find a balance between memo=
ry and
>> > performance. The benefits of folios are well documented and the kernel=
 is
>> > heading in the direction of managing memory in variable-sized blocks. =
So I don't
>> > think it's as simple as saying we should always swap-in the smallest p=
ossible
>> > amount of memory.
>>
>> It's conditional, that is,
>>
>> "if the page is only accessed seldom"
>>
>> Then, the page swapped-in will be swapped-out soon and adjacent pages in
>> the same large folio will not be accessed during this period.
>>
>> So, I suggest to create an algorithm to decide swap-in order based on
>> swap-readahead information automatically.  It can detect the situation
>> above via reduced swap readahead window size.  And, if the page is
>> accessed for quite long time, and the adjacent pages in the same large
>> folio are accessed too, swap-readahead window will increase and large
>> swap-in order will be used.
>
> The original size of do_anonymous_page() should be honored, considering it
> embodies a decision influenced by not only sysfs settings and per-vma
> HUGEPAGE hints but also architectural characteristics, for example
> CONT-PTE.
>
> The model you're proposing may offer memory-saving benefits or reduce I/O,
> but it entirely disassociates the size of the swap in from the size prior=
 to the
> swap out.

Readahead isn't the only factor to determine folio order.  For example,
we must respect "never" policy to allocate order-0 folio always.
There's no requirements to use swap-out order in swap-in too.  Memory
allocation has different performance character of storage reading.

> Moreover, there's no guarantee that the large folio generated by
> the readahead window is contiguous in the swap and can be added to the
> swap cache, as we are currently dealing with folio->swap instead of
> subpage->swap.

Yes.  We can optimize only when all conditions are satisfied.  Just like
other optimization.

> Incidentally, do_anonymous_page() serves as the initial location for allo=
cating
> large folios. Given that memory conservation is a significant considerati=
on in
> do_swap_page(), wouldn't it be even more crucial in do_anonymous_page()?

Yes.  We should consider that too.  IIUC, that is why mTHP support is
off by default for now.  After we find a way to solve the memory usage
issue.  We may make default "on".

> A large folio, by its nature, represents a high-quality resource that has=
 the
> potential to leverage hardware characteristics for the benefit of the
> entire system.

But not at the cost of memory wastage.

> Conversely, I don't believe that a randomly determined size dictated by t=
he
> readahead window possesses the same advantageous qualities.

There's a readahead algorithm which is not pure random.

> SWP_SYNCHRONOUS_IO devices are not reliant on readahead whatsoever,
> their needs should also be respected.

I understand that there are special requirements for SWP_SYNCHRONOUS_IO
devices.  I just suggest to work on general code before specific
optimization.

>> > You also said we should swap *out* in smallest size possible. Have I
>> > misunderstood you? I thought the case for swapping-out a whole folio w=
ithout
>> > splitting was well established and non-controversial?
>>
>> That is conditional too.
>>
>> >>
>> >>> But we only kind-of keep that information around, via the swap
>> >>> entry contiguity and alignment. With that scheme it is possible that=
 multiple
>> >>> virtually adjacent but not physically contiguous folios get swapped-=
out to
>> >>> adjacent swap slot ranges and then they would be swapped-in to a sin=
gle, larger
>> >>> folio. This is not ideal, and I think it would be valuable to try to=
 maintain
>> >>> the original folio size information with the swap slot. One way to d=
o this would
>> >>> be to store the original order for which the cluster was allocated i=
n the
>> >>> cluster. Then we at least know that a given swap slot is either for =
a folio of
>> >>> that order or an order-0 folio (due to cluster exhaustion/scanning).=
 Can we
>> >>> steal a bit from swap_map to determine which case it is? Or are ther=
e better
>> >>> approaches?
>> >>
>> >> [snip]

--
Best Regards,
Huang, Ying

