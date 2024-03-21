Return-Path: <linux-kernel+bounces-109646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E17881BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46EF283736
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35FC153;
	Thu, 21 Mar 2024 04:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ElqubrKF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BC1C05
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995143; cv=none; b=Bh5O2VhIE1HZfbr1rdWOIDi+N9nVVOgvFSjbf8D2ME9ppSeKPjEBG/EopQxKG66lvz8/JKCWRKJe3byqPlbxVd/xJVc5FtwaPN620S45o9Ym0oSAMZkWiSIMvRVE4vAVy55vgMV+jtaXZ5f/Cbs3ASXVezuq/IRAHj7ljZ6a3Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995143; c=relaxed/simple;
	bh=pgYP/R2FGoCOOUJoKEEHA9V67rDZZ4rXwdFtnP3Fp4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i16ZPqIRWLm3CMSyLYy9s5/89i/v+gRPFViqCdF7X94MmKFLjVZFA+VUjXDf8saqYQPIkZmYQ92AYfUH+DqRyIagRQK1O7ET6cITk+aZakXvtUlBLnmJ3IK58+Tn2gINTDAkFbTLm2bgniDLy3b0d/CVnsIz4EgX8d4LSaJJFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ElqubrKF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710995141; x=1742531141;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=pgYP/R2FGoCOOUJoKEEHA9V67rDZZ4rXwdFtnP3Fp4E=;
  b=ElqubrKF+7wxW0yyJi7LC2NA14Ij5QfMYNmZ0D+D8ftuZZtKEzEWQFHc
   U0ZGutE/4DZBm0+zapUM7yIS0D0GJ+Dd5V1tyaMumjjxc+cTiC0btw4pN
   X+j7KP7BT3lHrpp+N7a5sXAjqrGJU/HEjng4C0HhuJsEPsnZH513bnyOq
   oVjzJUMZXNs6rw/olxoaXwHN7BtzcrS45DHtVadMNDNCk1fi62Pn3b7qy
   3Xr9GCh2vaK0L0/JhpAHI1uaL2N9sKsjef4MzgxbhIc5tgSptXZhvoiNe
   1ZFr9LbmgjJ0DbJn4w5sHfnFHLC4KYub1pPcbI1TXUdOlu9EECgujYhvK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5792557"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5792557"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 21:25:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14443549"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 21:25:35 -0700
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
In-Reply-To: <CAGsJ_4wP_Zy9LZxZA-5KG13S3sQOak4LJK7rOhs3M=ETNJppNw@mail.gmail.com>
	(Barry Song's message of "Thu, 21 Mar 2024 07:38:37 +1300")
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
	<87msqts9u1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wP_Zy9LZxZA-5KG13S3sQOak4LJK7rOhs3M=ETNJppNw@mail.gmail.com>
Date: Thu, 21 Mar 2024 12:23:41 +0800
Message-ID: <87a5msrz5e.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Wed, Mar 20, 2024 at 7:22=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >>
>> >> > On 19/03/2024 09:20, Huang, Ying wrote:
>> >> >> Ryan Roberts <ryan.roberts@arm.com> writes:
>> >> >>
>> >> >>>>>> I agree phones are not the only platform. But Rome wasn't buil=
t in a
>> >> >>>>>> day. I can only get
>> >> >>>>>> started on a hardware which I can easily reach and have enough=
 hardware/test
>> >> >>>>>> resources on it. So we may take the first step which can be ap=
plied on
>> >> >>>>>> a real product
>> >> >>>>>> and improve its performance, and step by step, we broaden it a=
nd make it
>> >> >>>>>> widely useful to various areas  in which I can't reach :-)
>> >> >>>>>
>> >> >>>>> We must guarantee the normal swap path runs correctly and has no
>> >> >>>>> performance regression when developing SWP_SYNCHRONOUS_IO optim=
ization.
>> >> >>>>> So we have to put some effort on the normal path test anyway.
>> >> >>>>>
>> >> >>>>>> so probably we can have a sysfs "enable" entry with default "n=
" or
>> >> >>>>>> have a maximum
>> >> >>>>>> swap-in order as Ryan's suggestion [1] at the beginning,
>> >> >>>>>>
>> >> >>>>>> "
>> >> >>>>>> So in the common case, swap-in will pull in the same size of f=
olio as was
>> >> >>>>>> swapped-out. Is that definitely the right policy for all folio=
 sizes? Certainly
>> >> >>>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO).=
 But I'm not sure
>> >> >>>>>> it makes sense for 2M THP; As the size increases the chances o=
f actually needing
>> >> >>>>>> all of the folio reduces so chances are we are wasting IO. The=
re are similar
>> >> >>>>>> arguments for CoW, where we currently copy 1 page per fault - =
it probably makes
>> >> >>>>>> sense to copy the whole folio up to a certain size.
>> >> >>>>>> "
>> >> >>>
>> >> >>> I thought about this a bit more. No clear conclusions, but hoped =
this might help
>> >> >>> the discussion around policy:
>> >> >>>
>> >> >>> The decision about the size of the THP is made at first fault, wi=
th some help
>> >> >>> from user space and in future we might make decisions to split ba=
sed on
>> >> >>> munmap/mremap/etc hints. In an ideal world, the fact that we have=
 had to swap
>> >> >>> the THP out at some point in its lifetime should not impact on it=
s size. It's
>> >> >>> just being moved around in the system and the reason for our orig=
inal decision
>> >> >>> should still hold.
>> >> >>>
>> >> >>> So from that PoV, it would be good to swap-in to the same size th=
at was
>> >> >>> swapped-out.
>> >> >>
>> >> >> Sorry, I don't agree with this.  It's better to swap-in and swap-o=
ut in
>> >> >> smallest size if the page is only accessed seldom to avoid to waste
>> >> >> memory.
>> >> >
>> >> > If we want to optimize only for memory consumption, I'm sure there =
are many
>> >> > things we would do differently. We need to find a balance between m=
emory and
>> >> > performance. The benefits of folios are well documented and the ker=
nel is
>> >> > heading in the direction of managing memory in variable-sized block=
s. So I don't
>> >> > think it's as simple as saying we should always swap-in the smalles=
t possible
>> >> > amount of memory.
>> >>
>> >> It's conditional, that is,
>> >>
>> >> "if the page is only accessed seldom"
>> >>
>> >> Then, the page swapped-in will be swapped-out soon and adjacent pages=
 in
>> >> the same large folio will not be accessed during this period.
>> >>
>> >> So, I suggest to create an algorithm to decide swap-in order based on
>> >> swap-readahead information automatically.  It can detect the situation
>> >> above via reduced swap readahead window size.  And, if the page is
>> >> accessed for quite long time, and the adjacent pages in the same large
>> >> folio are accessed too, swap-readahead window will increase and large
>> >> swap-in order will be used.
>> >
>> > The original size of do_anonymous_page() should be honored, considerin=
g it
>> > embodies a decision influenced by not only sysfs settings and per-vma
>> > HUGEPAGE hints but also architectural characteristics, for example
>> > CONT-PTE.
>> >
>> > The model you're proposing may offer memory-saving benefits or reduce =
I/O,
>> > but it entirely disassociates the size of the swap in from the size pr=
ior to the
>> > swap out.
>>
>> Readahead isn't the only factor to determine folio order.  For example,
>> we must respect "never" policy to allocate order-0 folio always.
>> There's no requirements to use swap-out order in swap-in too.  Memory
>> allocation has different performance character of storage reading.
>
> Still quite unclear.
>
> If users have only enabled 64KiB (4-ORDER) large folios in sysfs, and the
> readahead algorithm requires 16KiB, what should be set as the large folio=
 size?
> Setting it to 16KiB doesn't align with users' requirements, while
> setting it to 64KiB
> would be wasteful according to your criteria.

IIUC, enabling 64KB means you can use 64KB mTHP if appropriate, doesn't
mean that you must use 64KB mTHP.  If so, we should use 16KB mTHP in
that situation.

>> > Moreover, there's no guarantee that the large folio generated by
>> > the readahead window is contiguous in the swap and can be added to the
>> > swap cache, as we are currently dealing with folio->swap instead of
>> > subpage->swap.
>>
>> Yes.  We can optimize only when all conditions are satisfied.  Just like
>> other optimization.
>>
>> > Incidentally, do_anonymous_page() serves as the initial location for a=
llocating
>> > large folios. Given that memory conservation is a significant consider=
ation in
>> > do_swap_page(), wouldn't it be even more crucial in do_anonymous_page(=
)?
>>
>> Yes.  We should consider that too.  IIUC, that is why mTHP support is
>> off by default for now.  After we find a way to solve the memory usage
>> issue.  We may make default "on".
>
> It's challenging to establish a universal solution because various systems
> exhibit diverse hardware characteristics, and VMAs may require different
> alignments. The current sysfs and per-vma hints allow users the opportuni=
ty
> o customize settings according to their specific requirements.

IIUC, Linux kernel is trying to provide a reasonable default behavior in
all situations.  We are trying to optimize default behavior in the first
place, only introduce customization if we fail to do that.  I don't
think that it's a good idea to introduce too much customization if we
haven't tried to optimize the default behavior.

>>
>> > A large folio, by its nature, represents a high-quality resource that =
has the
>> > potential to leverage hardware characteristics for the benefit of the
>> > entire system.
>>
>> But not at the cost of memory wastage.
>>
>> > Conversely, I don't believe that a randomly determined size dictated b=
y the
>> > readahead window possesses the same advantageous qualities.
>>
>> There's a readahead algorithm which is not pure random.
>>
>> > SWP_SYNCHRONOUS_IO devices are not reliant on readahead whatsoever,
>> > their needs should also be respected.
>>
>> I understand that there are special requirements for SWP_SYNCHRONOUS_IO
>> devices.  I just suggest to work on general code before specific
>> optimization.
>
> I disagree with your definition of "special" and "general". According
> to your logic,
> non-SWP_SYNCHRONOUS_IO devices could also be classified as "special".

SWP_SYNCHRONOUS_IO devices also use general code path.  They just use
some special optimization in some special situation (__swap_count(entry)
=3D=3D 1).  Optimization in general path benefits everyone.

> Furthermore, the number of systems running SWP_SYNCHRONOUS_IO is
> significantly greater than those running non-SWP_SYNCHRONOUS_IO,
> contradicting your assertion.
>
> SWP_SYNCHRONOUS_IO devices have a minor chance of being involved
> in readahead.

Then it loses an opportunity to determine the appropriate folio order.
We can consider how to balance between the overhead and benefit of
readahead.  IIUC, compared with original SWP_SYNCHRONOUS_IO swap-in,
mTHP is a kind of readahead too.

BTW, because we have added more and more swap cache related operations
(swapcache_prepare(), clear_shadow_from_swap_cache(), swapcache_clear(),
etc.) in SWP_SYNCHRONOUS_IO code path, I suspect whether the benefit of
SWP_SYNCHRONOUS_IO is still large enough.  We may need to re-evaluate
it.

> However, in OPPO's code, which hasn't been sent in the
> LKML yet, we use the exact same size as do_anonymous_page for readahead.
> Without a clear description of how you want the new readahead
> algorithm to balance memory waste and users' hints from sysfs and
> per-vma flags, it appears to be an ambiguous area to address.
>
> Please provide a clear description of how you would like the new readahead
> algorithm to function. I believe this clarity will facilitate others
> in attempting to
> implement it.

For example, if __swapin_nr_pages() > 4, we can try to allocate an
order-2 mTHP if other conditions are satisfied.

>>
>> >> > You also said we should swap *out* in smallest size possible. Have I
>> >> > misunderstood you? I thought the case for swapping-out a whole foli=
o without
>> >> > splitting was well established and non-controversial?
>> >>
>> >> That is conditional too.
>> >>
>> >> >>
>> >> >>> But we only kind-of keep that information around, via the swap
>> >> >>> entry contiguity and alignment. With that scheme it is possible t=
hat multiple
>> >> >>> virtually adjacent but not physically contiguous folios get swapp=
ed-out to
>> >> >>> adjacent swap slot ranges and then they would be swapped-in to a =
single, larger
>> >> >>> folio. This is not ideal, and I think it would be valuable to try=
 to maintain
>> >> >>> the original folio size information with the swap slot. One way t=
o do this would
>> >> >>> be to store the original order for which the cluster was allocate=
d in the
>> >> >>> cluster. Then we at least know that a given swap slot is either f=
or a folio of
>> >> >>> that order or an order-0 folio (due to cluster exhaustion/scannin=
g). Can we
>> >> >>> steal a bit from swap_map to determine which case it is? Or are t=
here better
>> >> >>> approaches?
>> >> >>
>> >> >> [snip]
>>

--
Best Regards,
Huang, Ying

