Return-Path: <linux-kernel+bounces-91854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A587177B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3556F1C22496
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB147F7F1;
	Tue,  5 Mar 2024 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjfO6vuE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AE7F7EE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625323; cv=none; b=Fp/ipTTS4EvHzUR1r4tN/qtX9hsJOFfyH33FYUKtbAO/3xEZxEgDSQQeC/InQRvCVC9gWFKVyJ6UMAMGMTVCM2OuvMWZ3jW3H1QRdI22a4hZaWblD9hHwyM7YPK71xvOmn2JzTSf5QJdOK1VF+gz9TzOGcxtjes93YIpBI69/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625323; c=relaxed/simple;
	bh=LkYVT4dDvTXDJ25e9h5t11zwb/QpgogamAOI+sx2zz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYFqTDeC5SPnSjxMoQJ2ys7+ID2VOWpyTotCBKSX3/C9a0NCzl/inQMF9B/LzB24fS1WUehohOGrFPGG526kb2KofyNCh7OSKhMc77Mw2W3Q3/6T1llpYLnfrFNvkKOI4r9/U/lnpHPGqXvJSFGijQyqdN09h9awhFDjxCvi9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjfO6vuE; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709625322; x=1741161322;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=LkYVT4dDvTXDJ25e9h5t11zwb/QpgogamAOI+sx2zz4=;
  b=TjfO6vuEWFQq1X60ffkZjqrwO8HOYF475heCjpZvvUnclseYBK+4tbda
   cNJ4z/Y0KZTlgSNiKxRSsCmL9K/kdlszZdae9coVWE0kU6qdKzeVieXzw
   vfRXuSLUSc4fgCkjJvM5qxNuCXAxcMg/HbThJ1I0la2D0yuy8g0MYvPED
   pPHeIyadejD5x/egj/N3n5uXSe1nipTuhOkbxD7hFic18pgWR1kNi09Sm
   0yT4l7UnHJddfp2Q3yMqjywi372GlNVero95urya5noiMmehQRTXZzfge
   xCdLgL9jKnoffNkcLlamovFDMAyPe82Xb2Ij2P6dgoPh0FTr2YYzJuOGL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="26618723"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="26618723"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40272704"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 23:55:17 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: David Hildenbrand <david@redhat.com>,  Ryan Roberts
 <ryan.roberts@arm.com>,  akpm@linux-foundation.org,  linux-mm@kvack.org,
  chrisl@kernel.org,  yuzhao@google.com,  hanchuanhua@oppo.com,
  linux-kernel@vger.kernel.org,  willy@infradead.org,  xiang@kernel.org,
  mhocko@suse.com,  shy828301@gmail.com,  wangkefeng.wang@huawei.com,
  Barry Song <v-songbaohua@oppo.com>,  Hugh Dickins <hughd@google.com>
Subject: Re: [RFC PATCH] mm: hold PTL from the first PTE while reclaiming a
 large folio
In-Reply-To: <CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
	(Barry Song's message of "Tue, 5 Mar 2024 11:29:31 +1300")
References: <20240304103757.235352-1-21cnbao@gmail.com>
	<706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
	<37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
	<CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
	<804524c8-772c-42d0-93a5-90d77f13f304@redhat.com>
	<CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
Date: Tue, 05 Mar 2024 15:53:22 +0800
Message-ID: <87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@redhat.c=
om> wrote:
>> > But we did "resolve" those bugs by entirely untouching all PTEs if we
>> > found some PTEs were skipped in try_to_unmap_one [1].
>> >
>> > While we find we only get the PTL from 2nd, 3rd but not
>> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
>> > all PTEs untouched.
>> >
>> > /* we are not starting from head */
>> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.pte)=
)) {
>> >                     ret =3D false;
>> >                     atomic64_inc(&perf_stat.mapped_walk_start_from_non=
_head);
>> >                     set_pte_at(mm, address, pvmw.pte, pteval);
>> >                     page_vma_mapped_walk_done(&pvmw);
>> >                     break;
>> > }
>> > This will ensure all PTEs still have a unified state such as CONT-PTE
>> > after try_to_unmap fails.
>> > I feel this could have some false postive because when racing
>> > with unmap, 1st PTE might really become pte_none. So explicitly
>> > holding PTL from 1st PTE seems a better way.
>>
>> Can we estimate the "cost" of holding the PTL?
>>
>
> This is just moving PTL acquisition one or two PTE earlier in those corner
> cases. In normal cases, it doesn't affect when PTL is held.

The mTHP may be mapped at the end of page table.  In that case, the PTL
will be held longer.  Or am I missing something?

--
Best Regards,
Huang, Ying


> In normal cases, page_vma_mapped_walk will find PTE0 is present, thus hold
> PTL immediately. in corner cases, page_vma_mapped_walk races with break-
> before-make, after skipping one or two PTEs whose states are transferring,
> it will find a present pte then acquire lock.
>
>> --
>> Cheers,
>>
>> David / dhildenb
>
> Thanks
> Barry

