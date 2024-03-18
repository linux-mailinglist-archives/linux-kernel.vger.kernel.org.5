Return-Path: <linux-kernel+bounces-105638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C787E1E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1A41C213BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6C41DDF4;
	Mon, 18 Mar 2024 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsA83tlM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914A1D530
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710726845; cv=none; b=I/3DnTyl1JOoEGwgFhHPXq1EurfX4rILRCsPw/XYgK4M7xqUTQ3qCcTuo4wr/+pYlkEUURhxJ5sEcYtLWN8PA6f7FqvZHZKyFOierE2OH/LqojoMHIvJTysXKGhL/XSWXXVYIdLBg4I+xovKkuXAPip4jLrHDVkE00slgGS0Dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710726845; c=relaxed/simple;
	bh=DCE39TGVpS0txfwp5jV8UNIpvR25WyxcPS+4+/R4rSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Avsiffh/ZcKCp+vWhZgfUGIzHwJ25eTPeOttInT/dKvhfXowChiGI2qPVcWM6wwt+4M9UjuQVEZnmD/DLPCmjttMZu7CXl/iDZs4OfLaJrxz9Pj4/2qw1Rpx30j2iPxHQMRD0fW3lERGpRUU3pcZBmAauN2zsga5lMrRp6Su/pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsA83tlM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710726842; x=1742262842;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DCE39TGVpS0txfwp5jV8UNIpvR25WyxcPS+4+/R4rSU=;
  b=IsA83tlMlRjym9UleK458AHhXbNwcJ5yQjc2O9ntKBwa8yZRk/0srMnk
   /RVDNU0gMNMbtPPsM96Rv6m8G7w1yYo6FR9hBpH+3S58xzReGVGXLkV60
   p/b/WJmXzmlJ95bt3TRCQTVQznsmTZ2H3j11VrNdrzf2nmuuAhC6nQYg4
   TmFussoML1sFm7IhKV/7ipOzQ4BsGp1BCUh4F3+6rGvgYWK563kyrTV/h
   GhdoF+jPXpTfmX0+sW+KU9daI/gUOHVpImsIVeE9FebQG5g+Yjot9zYCI
   14nCvh0CGJyITkYUpz6zsFtyUynGOIdk6dvGTLG7cxTtLao73d3lh+ktr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5377733"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="5377733"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="13383128"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:53:56 -0700
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
In-Reply-To: <CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
	(Barry Song's message of "Fri, 15 Mar 2024 23:01:46 +1300")
References: <20240304081348.197341-1-21cnbao@gmail.com>
	<20240304081348.197341-6-21cnbao@gmail.com>
	<87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
	<87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
Date: Mon, 18 Mar 2024 09:52:01 +0800
Message-ID: <87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Fri, Mar 15, 2024 at 10:17=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Fri, Mar 15, 2024 at 9:43=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > From: Chuanhua Han <hanchuanhua@oppo.com>
>> >> >
>> >> > On an embedded system like Android, more than half of anon memory is
>> >> > actually in swap devices such as zRAM. For example, while an app is
>> >> > switched to background, its most memory might be swapped-out.
>> >> >
>> >> > Now we have mTHP features, unfortunately, if we don't support large=
 folios
>> >> > swap-in, once those large folios are swapped-out, we immediately lo=
se the
>> >> > performance gain we can get through large folios and hardware optim=
ization
>> >> > such as CONT-PTE.
>> >> >
>> >> > This patch brings up mTHP swap-in support. Right now, we limit mTHP=
 swap-in
>> >> > to those contiguous swaps which were likely swapped out from mTHP a=
s a
>> >> > whole.
>> >> >
>> >> > Meanwhile, the current implementation only covers the SWAP_SYCHRONO=
US
>> >> > case. It doesn't support swapin_readahead as large folios yet since=
 this
>> >> > kind of shared memory is much less than memory mapped by single pro=
cess.
>> >>
>> >> In contrast, I still think that it's better to start with normal swap=
-in
>> >> path, then expand to SWAP_SYCHRONOUS case.
>> >
>> > I'd rather try the reverse direction as non-sync anon memory is only a=
round
>> > 3% in a phone as my observation.
>>
>> Phone is not the only platform that Linux is running on.
>
> I suppose it's generally true that forked shared anonymous pages only
> constitute a
> small portion of all anonymous pages. The majority of anonymous pages are=
 within
> a single process.

Yes.  But IIUC, SWP_SYNCHRONOUS_IO is quite limited, they are set only
for memory backed swap devices.

> I agree phones are not the only platform. But Rome wasn't built in a
> day. I can only get
> started on a hardware which I can easily reach and have enough hardware/t=
est
> resources on it. So we may take the first step which can be applied on
> a real product
> and improve its performance, and step by step, we broaden it and make it
> widely useful to various areas  in which I can't reach :-)

We must guarantee the normal swap path runs correctly and has no
performance regression when developing SWP_SYNCHRONOUS_IO optimization.
So we have to put some effort on the normal path test anyway.

> so probably we can have a sysfs "enable" entry with default "n" or
> have a maximum
> swap-in order as Ryan's suggestion [1] at the beginning,
>
> "
> So in the common case, swap-in will pull in the same size of folio as was
> swapped-out. Is that definitely the right policy for all folio sizes? Cer=
tainly
> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm no=
t sure
> it makes sense for 2M THP; As the size increases the chances of actually =
needing
> all of the folio reduces so chances are we are wasting IO. There are simi=
lar
> arguments for CoW, where we currently copy 1 page per fault - it probably=
 makes
> sense to copy the whole folio up to a certain size.
> "
>
>>
>> >>
>> >> In normal swap-in path, we can take advantage of swap readahead
>> >> information to determine the swapped-in large folio order.  That is, =
if
>> >> the return value of swapin_nr_pages() > 1, then we can try to allocate
>> >> and swapin a large folio.
>> >
>> > I am not quite sure we still need to depend on this. in do_anon_page,
>> > we have broken the assumption and allocated a large folio directly.
>>
>> I don't think that we have a sophisticated policy to allocate large
>> folio.  Large folio could waste memory for some workloads, so I think
>> that it's a good idea to allocate large folio always.
>
> i agree, but we still have the below check just like do_anon_page() has i=
t,
>
>         orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, false, tr=
ue, true,
>                                           BIT(PMD_ORDER) - 1);
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
>
> in do_anon_page, we don't worry about the waste so much, the same
> logic also applies to do_swap_page().

As I said, "readahead" may help us from application/user specific
configuration in most cases.  It can be a starting point of "using mTHP
automatically when it helps and not cause many issues".

>>
>> Readahead gives us an opportunity to play with the policy.
>
> I feel somehow the rules of the game have changed with an upper
> limit for swap-in size. for example, if the upper limit is 4 order,
> it limits folio size to 64KiB which is still a proper size for ARM64
> whose base page can be 64KiB.
>
> on the other hand, while swapping out large folios, we will always
> compress them as a whole(zsmalloc/zram patch will come in a
> couple of days), if we choose to decompress a subpage instead of
> a large folio in do_swap_page(), we might need to decompress
> nr_pages times. for example,
>
> For large folios 16*4KiB, they are saved as a large object in zsmalloc(wi=
th
> the coming patch), if we swap in a small folio, we decompress the large
> object; next time, we will still need to decompress a large object. so
> it is more sensible to swap in a large folio if we find those
> swap entries are contiguous and were allocated by a large folio swap-out.

I understand that there are some special requirements for ZRAM.  But I
don't think it's a good idea to force the general code to fit the
requirements of a specific swap device too much.  This is one of the
reasons that I think that we should start with normal swap devices, then
try to optimize for some specific devices.

>>
>> > On the other hand, compressing/decompressing large folios as a
>> > whole rather than doing it one by one can save a large percent of
>> > CPUs and provide a much lower compression ratio.  With a hardware
>> > accelerator, this is even faster.
>>
>> I am not against to support large folio for compressing/decompressing.
>>
>> I just suggest to do that later, after we play with normal swap-in.
>> SWAP_SYCHRONOUS related swap-in code is an optimization based on normal
>> swap.  So, it seems natural to support large folio swap-in for normal
>> swap-in firstly.
>
> I feel like SWAP_SYCHRONOUS is a simpler case and even more "normal"
> than the swapcache path since it is the majority.

I don't think so.  Most PC and server systems uses !SWAP_SYCHRONOUS
swap devices.

> and on the other hand, a lot
> of modification is required for the swapcache path. in OPPO's code[1], we=
 did
> bring-up both paths, but the swapcache path is much much more complicated
> than the SYNC path and hasn't really noticeable improvement.
>
> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8650/tree/onep=
lus/sm8650_u_14.0.0_oneplus12

That's great.  Please cleanup the code and post it to mailing list.  Why
doesn't it help?  IIUC, it can optimize TLB at least.

>>
>> > So I'd rather more aggressively get large folios swap-in involved
>> > than depending on readahead.
>>
>> We can take advantage of readahead algorithm in SWAP_SYCHRONOUS
>> optimization too.  The sub-pages that is not accessed by page fault can
>> be treated as readahead.  I think that is a better policy than
>> allocating large folio always.
>
> Considering the zsmalloc optimization, it would be a better choice to
> always allocate
> large folios if we find those swap entries are for a swapped-out large fo=
lio. as
> decompressing just once, we get all subpages.
> Some hardware accelerators are even able to decompress a large folio with
> multi-hardware threads, for example, 16 hardware threads can compress
> each subpage of a large folio at the same time, it is just as fast as
> decompressing
> one subpage.
>
> for platforms without the above optimizations, a proper upper limit
> will help them
> disable the large folios swap-in or decrease the impact. For example,
> if the upper
> limit is 0-order, we are just removing this patchset. if the upper
> limit is 2 orders, we
> are just like BASE_PAGE size is 16KiB.
>
>>
>> >>
>> >> To do that, we need to track whether the sub-pages are accessed.  I
>> >> guess we need that information for large file folio readahead too.
>> >>
>> >> Hi, Matthew,
>> >>
>> >> Can you help us on tracking whether the sub-pages of a readahead large
>> >> folio has been accessed?
>> >>
>> >> > Right now, we are re-faulting large folios which are still in swapc=
ache as a
>> >> > whole, this can effectively decrease extra loops and early-exitings=
 which we
>> >> > have increased in arch_swap_restore() while supporting MTE restore =
for folios
>> >> > rather than page. On the other hand, it can also decrease do_swap_p=
age as
>> >> > PTEs used to be set one by one even we hit a large folio in swapcac=
he.
>> >> >
>> >>

--
Best Regards,
Huang, Ying

