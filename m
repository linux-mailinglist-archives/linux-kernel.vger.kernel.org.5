Return-Path: <linux-kernel+bounces-93247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE7C872CD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 03:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165F928AB89
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 02:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C1FD52E;
	Wed,  6 Mar 2024 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UjDBfmY0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8017F5;
	Wed,  6 Mar 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709692880; cv=none; b=fp7npuZBso7474uaNpJI4y6dECu9WvVHKDZpsz6HRpBT3fva0VqHRxVKLL+9Z6Iqzf1Xc3fVRqxKiEk29flrV1XV0YwzmmRWmDGWH8VgzN6A+a8Lijt+5pbuvb7vYeQxSAoeJHrmLG9tBmiN+CIL+eY0bLDmhtuLhr5jCAVFZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709692880; c=relaxed/simple;
	bh=foxpAO3zNvBtAsxiTI5xgxbfm6Fwoz5RnfFjuTvze4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xmb5bZ3LUWLc8Pa5fj58w4uplbUwb9CZzjMD7HICob8Fjf8XJ3bJQg1A6oNDglziCpEMG4MKRhmlgMNMmhvsp9KubW8nLd08TTuvpT3IEucEMUS1agAdCwdVkS7AjWddVXt4RhDdB3H03mMPtIoO8rmcYGJYoXxydyp5fCzY8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UjDBfmY0; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709692876; x=1741228876;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=foxpAO3zNvBtAsxiTI5xgxbfm6Fwoz5RnfFjuTvze4g=;
  b=UjDBfmY0CXKDs0f90jt0UHSnKepwNLLrzFuq4uVQMyvQDiSOuUgUPr43
   5LKPAilHJlPNavls26o3I+Z+jYH9d4EAay303QgPiO+Y+5q4CFDZ851wp
   zmBdIn1IhFsA6uUmItIBxgw6NrQ8h2tkHUZeJHfJK68akijfcSU7OusHk
   l2BAXNxb9mc7/2M8I75q/r+QY8TTFRfeqaqFvNYbTdfIJ7TOcAwec3/DP
   8s2K9Pp9MRKeNi7j3hPXWe5rZ4tDrW7j0VnBrafw6gSJeYAVk4R2hpVyG
   vYZL8vm2Ds8gvxl9d18s/FHihwy0hl6aQCQLv8xE+O16jXkqnHMeZxENh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4397680"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4397680"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:41:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="14156593"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 18:41:12 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  stable@vger.kernel.org
Subject: Re: [PATCH v1] mm: swap: Fix race between free_swap_and_cache() and
 swapoff()
In-Reply-To: <017414bc-78cd-4aa1-9edf-6ce947b9e4e4@redhat.com> (David
	Hildenbrand's message of "Tue, 5 Mar 2024 23:05:11 +0100")
References: <20240305151349.3781428-1-ryan.roberts@arm.com>
	<cb738797-77d9-4e20-a54c-f70385cdbd95@redhat.com>
	<8989df79-84f5-488c-bd74-c11d2241eff1@arm.com>
	<017414bc-78cd-4aa1-9edf-6ce947b9e4e4@redhat.com>
Date: Wed, 06 Mar 2024 10:39:18 +0800
Message-ID: <87a5nc84o9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> On 05.03.24 17:33, Ryan Roberts wrote:
>> On 05/03/2024 15:50, David Hildenbrand wrote:
>>> On 05.03.24 16:13, Ryan Roberts wrote:
>>>> There was previously a theoretical window where swapoff() could run and
>>>> teardown a swap_info_struct while a call to free_swap_and_cache() was
>>>> running in another thread. This could cause, amongst other bad
>>>> possibilities, swap_page_trans_huge_swapped() (called by
>>>> free_swap_and_cache()) to access the freed memory for swap_map.
>>>>
>>>> This is a theoretical problem and I haven't been able to provoke it from
>>>> a test case. But there has been agreement based on code review that this
>>>> is possible (see link below).
>>>>
>>>> Fix it by using get_swap_device()/put_swap_device(), which will stall
>>>> swapoff(). There was an extra check in _swap_info_get() to confirm that
>>>> the swap entry was valid. This wasn't present in get_swap_device() so
>>>> I've added it. I couldn't find any existing get_swap_device() call sites
>>>> where this extra check would cause any false alarms.
>>>>
>>>> Details of how to provoke one possible issue (thanks to David Hilenbrand
>>>> for deriving this):
>>>
>>> Almost
>>>
>>> "s/Hilenbrand/Hildenbrand/" :)
>> 
>> Ahh sorry... I even explicitly checked it against your name on emails... fat
>> fingers...
>
> No need to be sorry. Even your average German person would get it wrong,
> because there are other (more common) variants :)
>
> [...]
>
>>>>
>>>
>>> LGTM
>>>
>>> Are you planning on sending a doc extension for get_swap_device()?
>> 
>> I saw your comment:
>> 
>> We should likely update the documentation of get_swap_device(), that after
>> decrementing the refcount, the SI might become stale and should not be touched
>> without a prior get_swap_device().
>> 
>> But when I went to make the changes, I saw the documentation already said:
>> 
>> ...we need to enclose all swap related functions with get_swap_device() and
>> put_swap_device()... Notice that swapoff ... can still happen before the
>> percpu_ref_tryget_live() in get_swap_device() or after the percpu_ref_put() in
>> put_swap_device()... The caller must be prepared for that.
>> 
>> I thought that already covered it? I'm sure as usual, I've misunderstood your
>> point. Happy to respin if you have something in mind?
>
> No need to respin, we could clarify on top, if we decide it makes sense.
>
> I was thinking about something like this, making it clearer that the PTL
> discussion above does not express the corner case we discovered:
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2b3a2d85e350b..646a436581eee 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1232,6 +1232,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
>    * with get_swap_device() and put_swap_device(), unless the swap
>    * functions call get/put_swap_device() by themselves.
>    *
> + * Note that when only holding the PTL, swapoff might succeed immediately
> + * after freeing a swap entry. Therefore, immediately after
> + * __swap_entry_free(), the swap info might become stale and should not
> + * be touched without a prior get_swap_device().
> + *
>    * Check whether swap entry is valid in the swap device.  If so,
>    * return pointer to swap_info_struct, and keep the swap entry valid
>    * via preventing the swap device from being swapoff, until

LGTM.  Thanks!

--
Best Regards,
Huang, Ying

