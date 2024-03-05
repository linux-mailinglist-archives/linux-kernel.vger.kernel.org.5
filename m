Return-Path: <linux-kernel+bounces-91971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B76C87193B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAE2B2571B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD450272;
	Tue,  5 Mar 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDnC6MM3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A854DA1F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629954; cv=none; b=omnY+3wgvX9pvnuuuoBMsQUY10M2JuFFzLiQf1g1v+vudyMF+8wvtdgMerUAn/OqtHPw1j4eBJ4zTdzwfbAi20kYWD4ZAzl3TdqWmMbQGc7NRXaQoVM4bNUTz4HicuGCuDAL3LurUoDCsbu7KlpwHim1q4X2U7GqiDUe/QnQiUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629954; c=relaxed/simple;
	bh=/vl/qJEZLoUxWdvNHrOtVCRv+3oHUYGP/ZAyTG3DH9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ipcbLNFncQKCP6JAiv6/oN9VeRprKoWHT1thHSDoI1FNdcqmogmgzd8iZShdveqkVwXW8hfVcS15PV65woAQHB5jZY7Ig73OV9sIS6iS8QqhngmfIHWenv5jaABsDcJsYAokUE9aO3NzSiNYnyMQ0/52ctAS2bauvHd3R9Y6kAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDnC6MM3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709629952; x=1741165952;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/vl/qJEZLoUxWdvNHrOtVCRv+3oHUYGP/ZAyTG3DH9w=;
  b=KDnC6MM3C7XByxIUfjdSSk5GQCHm5ZJXsraBsUgVbZ/YehLj7n/Nn4v4
   vxC+gzvrT9egXFflkeJczx9eUudOWnK4902zuFt+ErGdlO6jmlcfleyD5
   1ddWukrtY4/q8J5N06r2omQLpvBn+b1T8wMIXE2xEiaYnvVG1atHlSMqe
   FiQeguIj+d+c82m5jJNZKBSKjcaYxKQMBCoZMgk9v/tNt2JJ1VqjWIxWf
   ZDOAIjegXVuYVxlpNc2ztuayTt5l3CvfGW9q2PyRdnUmqIQl9JPISrleL
   F/n1lCDDaYb18Q8hAbx5Mug+6A/oLBlDk0g9/NPA0+6L6ABFVKVJzYmyb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14885726"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14885726"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 01:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9723387"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 01:12:27 -0800
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
In-Reply-To: <CAGsJ_4xUdqpWaYDrNV3Fbh=3cWyoDJz3AbWa=mfsKbka+MAVag@mail.gmail.com>
	(Barry Song's message of "Tue, 5 Mar 2024 22:02:18 +1300")
References: <20240304103757.235352-1-21cnbao@gmail.com>
	<706b7129-85f6-4470-9fd9-f955a8e6bd7c@arm.com>
	<37f1e6da-412b-4bb4-88b7-4c49f21f5fe9@redhat.com>
	<CAGsJ_4yJ3yCyN_KgBO8W+jFx8RN6_JhS9OwX3FH6X_gpU7g62w@mail.gmail.com>
	<804524c8-772c-42d0-93a5-90d77f13f304@redhat.com>
	<CAGsJ_4yqUW46xyDtZ4X1wQZ2_0bLM85Euz2BufERa75Rg+gVyw@mail.gmail.com>
	<87r0gp868d.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xUdqpWaYDrNV3Fbh=3cWyoDJz3AbWa=mfsKbka+MAVag@mail.gmail.com>
Date: Tue, 05 Mar 2024 17:10:32 +0800
Message-ID: <87il2182nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Tue, Mar 5, 2024 at 8:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Tue, Mar 5, 2024 at 10:15=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
>> >> > But we did "resolve" those bugs by entirely untouching all PTEs if =
we
>> >> > found some PTEs were skipped in try_to_unmap_one [1].
>> >> >
>> >> > While we find we only get the PTL from 2nd, 3rd but not
>> >> > 1st PTE, we entirely give up on try_to_unmap_one, and leave
>> >> > all PTEs untouched.
>> >> >
>> >> > /* we are not starting from head */
>> >> > if (!IS_ALIGNED((unsigned long)pvmw.pte, CONT_PTES * sizeof(*pvmw.p=
te))) {
>> >> >                     ret =3D false;
>> >> >                     atomic64_inc(&perf_stat.mapped_walk_start_from_=
non_head);
>> >> >                     set_pte_at(mm, address, pvmw.pte, pteval);
>> >> >                     page_vma_mapped_walk_done(&pvmw);
>> >> >                     break;
>> >> > }
>> >> > This will ensure all PTEs still have a unified state such as CONT-P=
TE
>> >> > after try_to_unmap fails.
>> >> > I feel this could have some false postive because when racing
>> >> > with unmap, 1st PTE might really become pte_none. So explicitly
>> >> > holding PTL from 1st PTE seems a better way.
>> >>
>> >> Can we estimate the "cost" of holding the PTL?
>> >>
>> >
>> > This is just moving PTL acquisition one or two PTE earlier in those co=
rner
>> > cases. In normal cases, it doesn't affect when PTL is held.
>>
>> The mTHP may be mapped at the end of page table.  In that case, the PTL
>> will be held longer.  Or am I missing something?
>
> no. this patch doesn't change when we release PTL but change when we
> get PTL.
>
> when the original code iterates nr_pages PTEs in a large folio, it will s=
kip
> invalid PTEs, when it meets a valid one, it will acquire PTL. so if it ge=
ts
> intermediate PTE values some other threads are modifying, it might
> skip PTE0, or sometimes PTE0 and PTE1 according to my test. but
> arriving at PTE2, likely other threads have written a new value, so we
> will begin to hold PTL and iterate till the end of the large folio.

Is there any guarantee that the mTHP will always be mapped at the
beginning of the page table (PTE0)?  IIUC, mTHP can be mapped at PTE496.
If so, with your patch, PTL will be held from PTE0 instead of PTE496 in
some cases.

--
Best Regards,
Huang, Ying

> The proposal is that we directly get PTL from PTE0, thus we don't get
> intermediate values for the head of nr_pages PTEs. this will ensure
> a large folio is either completely unmapped or completely mapped.
> but not partially mapped and partially unmapped.
>
>>
>> --
>> Best Regards,
>> Huang, Ying
>>
>>
>> > In normal cases, page_vma_mapped_walk will find PTE0 is present, thus =
hold
>> > PTL immediately. in corner cases, page_vma_mapped_walk races with brea=
k-
>> > before-make, after skipping one or two PTEs whose states are transferr=
ing,
>> > it will find a present pte then acquire lock.
>> >
>> >> --
>> >> Cheers,
>> >>
>> >> David / dhildenb
>> >
> Thanks
> Barry

