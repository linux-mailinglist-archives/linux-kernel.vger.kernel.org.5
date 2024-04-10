Return-Path: <linux-kernel+bounces-137810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD089E7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E57FB21A88
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781AD1C2D;
	Wed, 10 Apr 2024 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HlIgxZYv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D45522E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713696; cv=none; b=aPY+T/k1Frh+ewk1PeZR3dH4FIPl+UrFTJiD3W9ikeBifEWgxlufSxl0ryTtiJWdbFJN8wq0JtnggKaGpd0Y4MpA6nF7MrU6SCFTL+3c3RBn6lmpDu+FK4fzS21JI7w58lxDQ6UMZXsAq8Hz4bFVhhjZynzbvialFVsSHsK0bqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713696; c=relaxed/simple;
	bh=NcKvOkrCzR342U93keVujN6cdA/17UZMHK43RsPTVsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffzw51MTcDqNW665wvpUXwJmw/gRyopZ5t4dvccoQSHrFwLg/oWmlI9JT4EzOctIZO7HptHVOO7DAIhz7P3qMLP0GIp231zW5UhVvfKZJmbF0Mgg32S82lXZQUOboWhOKe/2LOA3g5hZt6iELMn6kVy/s89+8riKzAO15zyF+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HlIgxZYv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712713695; x=1744249695;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=NcKvOkrCzR342U93keVujN6cdA/17UZMHK43RsPTVsY=;
  b=HlIgxZYvXi2i4Vb5GYZrnB0ky+LozNowwJBBsue58PxcvCtUmqv57nR2
   0XlFL/wQyxOIpXxZ559UwWdbcboJ6ulptaNyLE05wLfV8P6+w+dLUqPXd
   NUDwgHcArwgpaf+Jw3UeZ9qGsAGJWlkPdF7DmpfwXuVYuD/C4ZHF8cjB7
   p+el9lDsQzNEbDChM4NG6ON2eJbps9D2lgUwRsjlokjRAm8lOKzHnVYv0
   wxi3jNOng6lhM4JuKkf2djdufqkLyn4f9k/u5gL3sEXYwOLn1DKxTuABa
   Lq9PI0cxTaGj9w4on1nbX2mkaFfbUHhvwabnqtSISQI37ocO304P44SUT
   g==;
X-CSE-ConnectionGUID: j/8AGrDYRLS5ZQHs+THlFA==
X-CSE-MsgGUID: cq5v/Ww0S6WwtmtV3VDtHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8235325"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8235325"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:48:15 -0700
X-CSE-ConnectionGUID: M1tPkJiaQKOyDTqRm15LIA==
X-CSE-MsgGUID: 2XzmfPgPR7C2Qhk1Wl87ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="24903108"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:48:11 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Zhaoyu Liu <liuzhaoyu.zackary@bytedance.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  ryncsn@gmail.com,  songmuchun@bytedance.com,
  david@redhat.com,  chrisl@kernel.org,  guo.ziliang@zte.com.cn,
  yosryahmed@google.com,  linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: swap: prejudgement swap_has_cache to avoid page
 allocation
In-Reply-To: <CAKEwX=MBts2mGgTE__VP-ZVMrMFTzQnbTAkMPTJs3KNRQ2QDjg@mail.gmail.com>
	(Nhat Pham's message of "Tue, 9 Apr 2024 10:52:40 -0700")
References: <20240408121439.GA252652@bytedance>
	<20240408132704.f966adc8d3928df4d3b8c0a9@linux-foundation.org>
	<87edbf8hta.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<20240409145740.GA543696@bytedance>
	<CAKEwX=MBts2mGgTE__VP-ZVMrMFTzQnbTAkMPTJs3KNRQ2QDjg@mail.gmail.com>
Date: Wed, 10 Apr 2024 09:46:18 +0800
Message-ID: <8734ru6lcl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nhat Pham <nphamcs@gmail.com> writes:

> On Tue, Apr 9, 2024 at 7:57=E2=80=AFAM Zhaoyu Liu
> <liuzhaoyu.zackary@bytedance.com> wrote:
>>
>> On Tue, Apr 09, 2024 at 09:07:29AM +0800, Huang, Ying wrote:
>> > Andrew Morton <akpm@linux-foundation.org> writes:
>> >
>> > > On Mon, 8 Apr 2024 20:14:39 +0800 Zhaoyu Liu <liuzhaoyu.zackary@byte=
dance.com> wrote:
>> > >
>> > >> Based on qemu arm64 - latest kernel + 100M memory + 1024M swapfile.
>> > >> Create 1G anon mmap and set it to shared, and has two processes
>> > >> randomly access the shared memory. When they are racing on swap cac=
he,
>> > >> on average, each "alloc_pages_mpol + swapcache_prepare + folio_put"
>> > >> took about 1475 us.
>> > >
>> > > And what effect does this patch have upon the measured time?  ANd up=
on
>> > > overall runtime?
>> >
>> > And the patch will cause increased lock contention, please test with
>> > more processes and perhaps HDD swap device too.
>>
>> Hi Ying,
>>
>> Thank you for your suggestion.
>> It may indeed cause some lock contention, as mentioned by Kairui before.
>>
>> If so, is it recommended?
>> ---
>>   unsigned char swap_map, mapcount, hascache;
>>   ...
>>   /* Return raw data of the si->swap_map[offset] */
>>   swap_map =3D __swap_map(si, entry);
>>   mapcount =3D swap_map & ~SWAP_HAS_CACHE;
>>   if (!mapcount && swap_slot_cache_enabled)
>>   ...
>>   hascache =3D swap_map & SWAP_HAS_CACHE;
>>   /* Could judge that it's being added to swap cache with high probabili=
ty */
>>   if (mapcount && hascache)
>>     goto skip_alloc;
>>   ...
>> ---
>> In doing so, there is no additional use of locks.
>>
>
> Hmm so is this a lockless check now? Ummmm... Could someone with more
> expertise in the Linux kernel memory model double check that this is
> even a valid state we're observing here? Looks like we're performing
> an unguarded, unsynchronized, non-atomic read with the possibility of
> concurrent write - is there a chance we might see partial/invalid
> results?
>
> Could you also test with zswap enabled (and perhaps with zswap
> shrinker enabled)?

READ_ONCE() will save us from partial/invalid results.

--
Best Regards,
Huang, Ying

