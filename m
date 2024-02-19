Return-Path: <linux-kernel+bounces-70741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5A859BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DAD1F22570
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD191F951;
	Mon, 19 Feb 2024 05:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGjIUaQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED11E514;
	Mon, 19 Feb 2024 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708321466; cv=none; b=C2gceuAbftg5mppAumG42lZSJEk3RCBz3LlvmwTji1pcaRYjtUmotWnRIRRZXvfMHeNjfjQjZvOdE91258vtemmVbeNPdB9Fr2hDH2VSMB6UQ5bayoTsx8h8D3WyH2Zi/N4r6cXTnYJO6bU9Slx9+KUM8Q90MfDsOl5l8d58gnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708321466; c=relaxed/simple;
	bh=A1WpzfYCZjFPQC654yh/PRs0p5i5tAcZYGFQ3TvRRw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R8ou1jKQH35+yoFw6Qms929gUoOJHIkAI47dWcp2Tm9A0z4eGJZwLlSE7I1La8Mdf+K5KddSQZEZ55rJpCQlGPAYvLAMLzlodEoE6GBaVAaR0UeceQGe1Y0VIsVIicympM2Gv7IJAocBJQxEvgB0eXOPyH3+EVFm7TgtX/iwuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGjIUaQ/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708321465; x=1739857465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=A1WpzfYCZjFPQC654yh/PRs0p5i5tAcZYGFQ3TvRRw4=;
  b=YGjIUaQ/lZMP1nPkv4wnRrTwkjZ2szi0+WRoM/KXbMMb2tBEcT202Do9
   oeMaw8MBXSkpOxpLAXHWaJtzaZhTVAbkelYPrnh6mi7n2kzVY6T471uTM
   tLdlalQU5F4hJKDyBM9wYDoSHgXeTVLZtGqRfIyPkadRdQTjs8pl9DG0k
   NwAIQKPPiE6vWphh0QjxCMueq1HeBgd8QKLNw/64PjNyTTkkXVWURNoDu
   KdQFxIjRLrcwpIEGSGiIZhcMVbn+g7airgqUbOiqIk48zmfD7yY9ScHGB
   qgqESP4rNtbDmLsX1lQwZBE0+kGBdQqWAZGqj6ZXS/maPOCuQmrtIeDtk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19913339"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19913339"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 21:44:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="826951277"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="826951277"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 21:44:19 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,  Chris Li <chrisl@kernel.org>,  Barry
 Song <21cnbao@gmail.com>,  linux-mm@kvack.org,  Andrew Morton
 <akpm@linux-foundation.org>,  Yu Zhao <yuzhao@google.com>,  Barry Song
 <v-songbaohua@oppo.com>,  SeongJae Park <sj@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  stable@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
In-Reply-To: <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
	(Kairui Song's message of "Fri, 9 Feb 2024 03:01:20 +0800")
References: <20240206182559.32264-1-ryncsn@gmail.com>
	<CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
	<CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
	<CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
	<CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
	<CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
	<CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
	<ZcPMi6DX5PN4WwHr@google.com>
	<CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
	<87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
Date: Mon, 19 Feb 2024 13:42:23 +0800
Message-ID: <877cj1row0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> On Thu, Feb 8, 2024 at 2:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.org=
> wrote:
>> >>
>> >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
>>
>> [snip]
>>
>> >> >
>> >> > So I think the thing is, it's getting complex because this patch
>> >> > wanted to make it simple and just reuse the swap cache flags.
>> >>
>> >> I agree that a simple fix would be the important at this point.
>> >>
>> >> Considering your description, here's my understanding of the other id=
ea:
>> >> Other method, such as increasing the swap count, haven't proven effec=
tive
>> >> in your tests. The approach risk forcing racers to rely on the swap c=
ache
>> >> again and the potential performance loss in race scenario.
>> >>
>> >> While I understand that simplicity is important, and performance loss
>> >> in this case may be infrequent, I believe swap_count approach could b=
e a
>> >> suitable solution. What do you think?
>> >
>> > Hi Minchan
>> >
>> > Yes, my main concern was about simplicity and performance.
>> >
>> > Increasing swap_count here will also race with another process from
>> > releasing swap_count to 0 (swapcache was able to sync callers in other
>> > call paths but we skipped swapcache here).
>>
>> What is the consequence of the race condition?
>
> Hi Ying,
>
> It will increase the swap count of an already freed entry, this race
> with multiple swap free/alloc logic that checks if count =3D=3D
> SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
> all result in random corruption of the swap map. This happens a lot
> during stress testing.

You are right!  Thanks for explanation.

--
Best Regards,
Huang, Ying

>>
>> > So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
>> > have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
>> > __swap_duplicate can be modified to support this, it's similar to
>> > existing logics for SWAP_HAS_CACHE.
>> >
>> > And swap freeing path will do more things, swapcache clean up needs to
>> > be handled even in the bypassing path since the racer may add it to
>> > swapcache.
>> >
>> > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
>> > overhead, so I used that way in this patch, the only issue is
>> > potentially repeated page faults now.
>> >
>> > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
>> > at naming it) special value, so any racer can just spin on it to avoid
>> > all the problems, how do you think about this?
>>
>> Let's try some simpler method firstly.
>
> Another simpler idea is, add a schedule() or
> schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
> path before goto out (just like __read_swap_cache_async). I think this
> should ensure in almost all cases, PTE is ready after it returns, also
> yields more CPU.

