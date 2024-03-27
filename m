Return-Path: <linux-kernel+bounces-120368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3086988D659
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61D0B1C24A64
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353F1CA87;
	Wed, 27 Mar 2024 06:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bszERoAk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4869B17551
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711520676; cv=none; b=VDRdaf2lIhjxjFS8wQFbFUCCwbMO7CtfQa4+2/+b0jFej780/UrO2VuB3nqSfPWSk3tglpXnAvbDjX+8CGDHpJjiMQFGJ6Lx9Q5iZfD3bPbm7NSb4qa6LxK5omkj859sfSxBCjNhEJBmOHyV24q3xAku7LlixudtPMpOH8wB3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711520676; c=relaxed/simple;
	bh=6BxiztpmQC7WGYYfC/J1njDyZV2TGg42X2X1s7GmlQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQ9x7A1pNFiXBZDzTUFnkyhehb7zVrC54Y2b/gOohgeey9v+SJzkp81XMrWZJEcf/L994kKjmS/dcJx+VKNGN+sxRiyCauVF18OQKQqMGmnJ9lt4iuHw/NV1jt6xjQl1A9Z+XEg6MTQ9/9uvQ/AyjGEsLw3V0f/qUmE7hMWHh1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bszERoAk; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711520674; x=1743056674;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=6BxiztpmQC7WGYYfC/J1njDyZV2TGg42X2X1s7GmlQc=;
  b=bszERoAk4OjTAp6sRjTUdQGAVqXUONGrQO6OkjEbaYM5lBMO9h6TSZES
   GxQJ+PRcG+G1+rdcrFAf9S+RTACsXpltdhO2leb8Key+2BVMScrGUueGf
   ezCUhxwB6eDqcWzrJuT+YRt9nDzPggGsgc5ia/fgMMpwoB5RLhay//Zpi
   epVY/VKkVNvvwC/Q+u2qlITH8HaI1/RyH/2xAcqfmVo2eZijWWdjVYMkY
   SAQPWWCmrZJN8DPrWDw9gWXWPgWFGvJEEbaqw8shkogDzJgKdTbda3ywW
   rJEYbwUTwJAv9+iVfcNQL9OM/6eGI5Mrvw1Apdlbu1VfCen20Bl+24BcU
   w==;
X-CSE-ConnectionGUID: /JjkJp4cTq2j4VV+B+jPqw==
X-CSE-MsgGUID: 3/jxtLw/QXmWpFPKfge6BA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="10404462"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="10404462"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:24:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="16639174"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 23:24:28 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Chris Li
 <chrisl@kernel.org>,  Minchan Kim <minchan@kernel.org>,  Barry Song
 <v-songbaohua@oppo.com>,  Ryan Roberts <ryan.roberts@arm.com>,  Yu Zhao
 <yuzhao@google.com>,  SeongJae Park <sj@kernel.org>,  David Hildenbrand
 <david@redhat.com>,  Yosry Ahmed <yosryahmed@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Nhat Pham
 <nphamcs@gmail.com>,  Chengming Zhou <zhouchengming@bytedance.com>,
  Andrew Morton <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/10] mm/swap: optimize synchronous swapin
In-Reply-To: <20240326185032.72159-11-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 27 Mar 2024 02:50:32 +0800")
References: <20240326185032.72159-1-ryncsn@gmail.com>
	<20240326185032.72159-11-ryncsn@gmail.com>
Date: Wed, 27 Mar 2024 14:22:36 +0800
Message-ID: <87zfukmbwz.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Interestingly the major performance overhead of synchronous is actually
> from the workingset nodes update, that's because synchronous swap in

If it's the major overhead, why not make it the first optimization?

> keeps adding single folios into a xa_node, making the node no longer
> a shadow node and have to be removed from shadow_nodes, then remove
> the folio very shortly and making the node a shadow node again,
> so it has to add back to the shadow_nodes.

The folio is removed only if should_try_to_free_swap() returns true?

> Mark synchronous swapin folio with a special bit in swap entry embedded
> in folio->swap, as we still have some usable bits there. Skip workingset
> node update on insertion of such folio because it will be removed very
> quickly, and will trigger the update ensuring the workingset info is
> eventual consensus.

Is this safe?  Is it possible for the shadow node to be reclaimed after
the folio are added into node and before being removed?

If so, we may consider some other methods.  Make shadow_nodes per-cpu?

> Test result of sequential swapin/out of 30G zero page on ZRAM:
>
>                Before (us)        After (us)
> Swapout:       33853883           33886008
> Swapin:        38336519           32465441 (+15.4%)
> Swapout (THP): 6814619            6899938
> Swapin (THP) : 38383367           33193479 (+13.6%)
>

[snip]

--
Best Regards,
Huang, Ying

