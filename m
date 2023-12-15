Return-Path: <linux-kernel+bounces-439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4EF814125
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C23D8B21F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E536163B3;
	Fri, 15 Dec 2023 05:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f6za4w2V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C86568C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702616833; x=1734152833;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3e7AMY7QdzXuWquhHAYkwaACFpgpbv91kPnT7khPuGY=;
  b=f6za4w2VNNkmJ8BYEelRsGbwy07Ahsi1f0Hafpnzj6mgrOwtYanT/iMI
   n+VXAECqvtHIBF9btnnUXZpediaf2A2EcRqoiqMUN6LGiph6ZXTzk2l3t
   mT8f7UpumDj68qmINcHItaD5kZVy7Q7o55zAYC5MsyTjt+923ehdIfYo/
   Zt0SuaSv1LkTELwZ0tuVytSmdZ0L+qa7CFezqViEe4/I9JBUlrazvtP3m
   8aZnELUR80zhoomfaDSYENdCKx0b6mpE251Te425sKcGmXUEY/LAPFjuP
   C87NvMWK3J6C6AKmVWzc77eihETKAs9eMZoEuYqipk6G+/sh8RWBQM/Uy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2398244"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2398244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:07:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803585413"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="803585413"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:07:09 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>,  Minchan Kim <minchan@kernel.org>,
  Yosry Ahmed <yosryahmed@google.com>,  Liu Shixin <liushixin2@huawei.com>,
  Yu Zhao <yuzhao@google.com>,  Sachin Sant <sachinp@linux.ibm.com>,
  Johannes Weiner <hannes@cmpxchg.org>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org,  Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v10] mm: vmscan: try to reclaim swapcache pages if no
 swap space
In-Reply-To: <20231213151341.9ae5fa2bdc266d794a7eed39@linux-foundation.org>
	(Andrew Morton's message of "Wed, 13 Dec 2023 15:13:41 -0800")
References: <ZV3_6UH28KMt0ZDb@tiehlicka>
	<87msv58068.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWDPuR5Ssx07nBHb@tiehlicka>
	<87h6l77wl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWRdG49vlGzSY_Uj@tiehlicka>
	<87r0ka64v9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZWW95JPQ1B0cVPY-@tiehlicka> <ZWZtdQKSSnLC8kZ6@google.com>
	<CAJD7tkZA2DDk259QHLnkwVqCq=v_4gBKSUV0hos8G+B6n6=rAQ@mail.gmail.com>
	<ZWZ0fJP9wq65rXtM@google.com> <ZWcPuYzWYAvOODsH@tiehlicka>
	<20231213151341.9ae5fa2bdc266d794a7eed39@linux-foundation.org>
Date: Fri, 15 Dec 2023 13:05:09 +0800
Message-ID: <878r5wqcmy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Andrew Morton <akpm@linux-foundation.org> writes:

> tl;dr, what's the viewpoint on this patch now?
>
> I have a note here that we're hoping input from Johannes, Vlastimil and
> Mel (please).

Michal has performance concerns.  So, I think that we need to stop
scanning anon LRU if don't find enough page in swap cache at the tail of
the inactive list.

--
Best Regards,
Huang, Ying

