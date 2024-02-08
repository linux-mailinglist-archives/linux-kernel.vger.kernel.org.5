Return-Path: <linux-kernel+bounces-57525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069AA84DA38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B202862B6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652BC67E7F;
	Thu,  8 Feb 2024 06:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGo48H2W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837C67E6F;
	Thu,  8 Feb 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707374210; cv=none; b=RBOwUYL99h50QsWAtTNu+WTNi6KtydP3CF4DVqDvzqgQQhU02k3tyA2gjek5LExGEAUmTwocSP2KxGMyXj4AC7YrA4TGlQ8rYUo1PjbIWvV9Yzu3OnSrpNl+ovt2buGz/arBFKGS3KrAUzf1UedHEI76PonhRt3mRK2Ys+Jt6sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707374210; c=relaxed/simple;
	bh=wPxTQLzIgrSJ4B0TUl71M/QYWADF9h5/QqFKKez4h+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NmiyZBJ8MlFw56qxuUlohRjgdw9NIKBgTKD+h/M4hc2HkSdCIA5bqLiHu9UWMWdBiUWiYz8tFLdeuipNaZ1XZByKbFL+IMm/g3m5yug57tnxGCz0JwtnHz9zLzEYEYdHQ2sA/0Av6xfpu/iOhKPbodZnTH3AOiFkiDmIHK2xr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGo48H2W; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707374209; x=1738910209;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=wPxTQLzIgrSJ4B0TUl71M/QYWADF9h5/QqFKKez4h+8=;
  b=SGo48H2Wd/HJolNIfJ14XH+SEVfoJxqL2tAvPUkCzT/t21u8XjxaWQhn
   20dmJMAktpAJsuLVUB0zyp05HLuYdToeRHJE0jI/G2netdlA1TubI2Wrk
   cBz9Mf6hHPVSkVk40h7gSkO8H7aQRqJBUN87fNdlQX2Um+dVRagbTXZsa
   Ps/gAQtEIRLmSXw3/Q+CvCJ36Vhtyz1kblxD9EwlvMYLP+LxjCiGbz79O
   xEcAXi4B6K/zanT2IyHDRaxF4hRgi0LkquxTpYv7axf2kKsqvxpWGLWL6
   wwmOUqyx4QIaKXxCi1oQOCyqp055zhR4Kdk98gupSw2pXFOCgo7NIvGCW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1297934"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1297934"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 22:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1568338"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 22:36:44 -0800
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
In-Reply-To: <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
	(Kairui Song's message of "Thu, 8 Feb 2024 14:04:54 +0800")
References: <20240206182559.32264-1-ryncsn@gmail.com>
	<CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
	<CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
	<CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
	<CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
	<CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
	<CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
	<ZcPMi6DX5PN4WwHr@google.com>
	<CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
Date: Thu, 08 Feb 2024 14:34:48 +0800
Message-ID: <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.org> w=
rote:
>>
>> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:

[snip]

>> >
>> > So I think the thing is, it's getting complex because this patch
>> > wanted to make it simple and just reuse the swap cache flags.
>>
>> I agree that a simple fix would be the important at this point.
>>
>> Considering your description, here's my understanding of the other idea:
>> Other method, such as increasing the swap count, haven't proven effective
>> in your tests. The approach risk forcing racers to rely on the swap cache
>> again and the potential performance loss in race scenario.
>>
>> While I understand that simplicity is important, and performance loss
>> in this case may be infrequent, I believe swap_count approach could be a
>> suitable solution. What do you think?
>
> Hi Minchan
>
> Yes, my main concern was about simplicity and performance.
>
> Increasing swap_count here will also race with another process from
> releasing swap_count to 0 (swapcache was able to sync callers in other
> call paths but we skipped swapcache here).

What is the consequence of the race condition?

> So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
> have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> __swap_duplicate can be modified to support this, it's similar to
> existing logics for SWAP_HAS_CACHE.
>
> And swap freeing path will do more things, swapcache clean up needs to
> be handled even in the bypassing path since the racer may add it to
> swapcache.
>
> Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
> overhead, so I used that way in this patch, the only issue is
> potentially repeated page faults now.
>
> I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
> at naming it) special value, so any racer can just spin on it to avoid
> all the problems, how do you think about this?

Let's try some simpler method firstly.

--
Best Regards,
Huang, Ying

