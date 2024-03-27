Return-Path: <linux-kernel+bounces-120550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDF688D939
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA04D1F2A9B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D846C339A8;
	Wed, 27 Mar 2024 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aI2OutVo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC0E2E85A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528471; cv=none; b=LVeKmRqDmBlOJz2owrXf6RZf/ikHnL0qRkmWs7baxAFpIa5IrnTPwUaUhxl8HqthjAYltBby9BPmP3j8jS7MhblDfyCPK99bp7BrUngZumOBy2vPPmw0Cec/eFTXddfcsHgVxwqHoGBZn+SS3V413LXgFZgvjgkN7EURbKrJpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528471; c=relaxed/simple;
	bh=QPqtm80lxP8jTAq1ty2utofh8Ry7QmP7H954z9MQEOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BagfW0z2Me+w1yC7KKp/PtUA9sW5VQYgHPtQqyacXuUhXwDgifN6qF9MwaMLjUqBZhtaswPwPv/LJyDHXntYJbF4OMHDWgU+C4YaV+dA1sSyoDqXdGl0KI65G44O/hD6QDLYDf4hhenXK0LFbKi2/t0p3oq1m0t41iqbhO/5ixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aI2OutVo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711528469; x=1743064469;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=QPqtm80lxP8jTAq1ty2utofh8Ry7QmP7H954z9MQEOE=;
  b=aI2OutVo9XOtaqbpz8FluJJ2f25+hwofNjLlmGp0m81hB/kXAe8qgFC6
   E4Ls9jtG345PIM7XL3BG8IBPRsaWbkakNhpNLd1W+NS51APRA9qGeIizS
   QLxHz1S5X70slwbQiCvtDRGq64ZUOpp/aG119NBLMEVLAS8UE5AGVueCR
   dUrH2k/Kv0jiXZdZ5A7pklXjqpaysPsCYdPoMwl3ruYheAdx+XMFn4pl9
   Bfd4YlvVtBuMQOgedPN/W/UieMHTJIlplIyZOiegGfXV+IXonMlcVJvSp
   Sq7BMibq3zqfVrCQaY1SLTOGvWFnkjHrRP8Fcv710J/nNY9dMcxOyOMa4
   g==;
X-CSE-ConnectionGUID: 3Udqi/qNT52L5iO1wDLSCA==
X-CSE-MsgGUID: LkPBA6MrRUWAXWDnz+T83w==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10394903"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10394903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:34:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16319884"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 01:34:25 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kairui Song <ryncsn@gmail.com>,  <linux-mm@kvack.org>,  Chris Li
 <chrisl@kernel.org>,  Minchan Kim <minchan@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Yu Zhao <yuzhao@google.com>,  SeongJae Park
 <sj@kernel.org>,  David Hildenbrand <david@redhat.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew
 Wilcox <willy@infradead.org>,  Nhat Pham <nphamcs@gmail.com>,  Chengming
 Zhou <zhouchengming@bytedance.com>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/10] mm/swap: always use swap cache for
 synchronization
In-Reply-To: <58e4f0c2-99d1-42b9-ab70-907cf35ac1a7@arm.com> (Ryan Roberts's
	message of "Wed, 27 Mar 2024 08:27:34 +0000")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<878r24o07p.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7B4Aejv16XK-zm9zPFrtVV1YutYWk5Ywzy8GwfMsTAXgA@mail.gmail.com>
	<58e4f0c2-99d1-42b9-ab70-907cf35ac1a7@arm.com>
Date: Wed, 27 Mar 2024 16:32:31 +0800
Message-ID: <87a5mkm5wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> [...]
>
>>>> Test 1, sequential swapin/out of 30G zero page on ZRAM:
>>>>
>>>>                Before (us)        After (us)
>>>> Swapout:       33619409           33886008
>>>> Swapin:        32393771           32465441 (- 0.2%)
>>>> Swapout (THP): 7817909            6899938  (+11.8%)
>>>> Swapin (THP) : 32452387           33193479 (- 2.2%)
>>>
>>> If my understanding were correct, we don't have swapin (THP) support,
>>> yet.  Right?
>> 
>> Yes, this series doesn't change how swapin/swapout works with THP in
>> general, but now THP swapout will leave shadows with large order, so
>> it needs to be splitted upon swapin, that will slow down later swapin
>> by a little bit but I think that's worth it.
>> 
>> If we can do THP swapin in the future, this split on swapin can be
>> saved to make the performance even better.
>
> I'm confused by this (clearly my understanding of how this works is incorrect).
> Perhaps you can help me understand:
>
> When you talk about "shadows" I assume you are referring to the swap cache? It
> was my understanding that swapping out a THP would always leave the large folio
> in the swap cache, so this is nothing new?
>
> And on swap-in, if the target page is in the swap cache, even if part of a large
> folio, why does it need to be split? I assumed the single page would just be
> mapped? (and if all the other pages subsequently fault, then you end up with a
> fully mapped large folio back in the process)?
>
> Perhaps I'm misunderstanding what "shadows" are?

Perhaps, shadow is used to support workingset protection/detection on
the anonymous LRU list as in the following patchset (merged).

https://lore.kernel.org/all/1595490560-15117-5-git-send-email-iamjoonsoo.kim@lge.com/T/#m962395eb5968c74b0c4c8e41d4b0dcdd3f28b2e6

--
Best Regards,
Huang, Ying

