Return-Path: <linux-kernel+bounces-45694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 996F984343E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 03:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCFCB25754
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F31FBF1;
	Wed, 31 Jan 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EduG1WCO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599AF9F0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669620; cv=none; b=jCS4c7rhsxKx54Zi7vcZg66NnjwkfM/ntDvl7bv22nEwCP2AhKXzuU7myhXTfIM3wN5QEouXUomt6Ry5rU5AFyyjnNBZxyw1xuFdh5coWXjL4zRSt9axjgoLehgidp7rUqHIIEiGCMQwzYN5ippN+HcDbY3pAqlYtpFZPlNp9ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669620; c=relaxed/simple;
	bh=fkrZop1jEqx5HXBSyzDbQgSqp95ndkCeM35935mkvCw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocRgIMC7w/Qpp3MFMJcZeXUpPKx8apAOt9OW8YZ8wU9GhpeuDmFNs7FQpX/jKWuC/FegvcJEN9e9NNNFXc5C+aoA8P/GCmALCEGaZaxAOXozO5+RsqALAzhDEuA8O60IzM5b+LAho0hNpMZyQAJiI94Wzg9cbwCWJVdVmyDsHfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EduG1WCO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706669619; x=1738205619;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=fkrZop1jEqx5HXBSyzDbQgSqp95ndkCeM35935mkvCw=;
  b=EduG1WCODgogplh6177erkxQbrzwUEB0mFHr9w6a/LlV00R6Fy4KgGJ/
   MYqJ60F/P7zCBhRkyDLLv+GEHkf6rPoV6XbwvF1RfK0ql6/UmTIyG+ho+
   gQGbAw98kVTeonApomtkBOzsgmK5YB02bOYyufhznwwTNVgSt4FMscAEc
   FKdK3XIagXo/wrnHSpXgQaeBjtpiSbS13Ula9bg6bQqEleDsQstX3cQcS
   /4SwfbGUlcBrU+/wbinYXRAbpz0XBP+RfVjQj3Q+/jJXkN7PZHLejvZnv
   R/MSxOSW3nh4cOH0SjWQrSMEXz6/ADe3tQV9JDUbfungihQuZXRZVStGt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16855252"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="16855252"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:53:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961469677"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="961469677"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 18:53:35 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,  Kairui Song
 <kasong@tencent.com>,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org, Yu Zhao
 <yuzhao@google.com>
Subject: Whether is the race for SWP_SYNCHRONOUS_IO possible? (was Re:
 [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem)
In-Reply-To: <20240129175423.1987-7-ryncsn@gmail.com> (Kairui Song's message
	of "Tue, 30 Jan 2024 01:54:21 +0800")
References: <20240129175423.1987-1-ryncsn@gmail.com>
	<20240129175423.1987-7-ryncsn@gmail.com>
Date: Wed, 31 Jan 2024 10:51:38 +0800
Message-ID: <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Minchan,

When I review the patchset from Kairui, I checked the code to skip swap
cache in do_swap_page() for swap device with SWP_SYNCHRONOUS_IO.  Is the
following race possible?  Where a page is swapped out to a swap device
with SWP_SYNCHRONOUS_IO and the swap count is 1.  Then 2 threads of the
process runs on CPU0 and CPU1 as below.  CPU0 is running do_swap_page().

CPU0				CPU1
----				----
swap_cache_get_folio()
check sync io and swap count
alloc folio
swap_readpage()
folio_lock_or_retry()
				swap in the swap entry
				write page
				swap out to same swap entry
pte_offset_map_lock()
check pte_same()
swap_free()   <-- new content lost!
set_pte_at()  <-- stale page!
folio_unlock()
pte_unmap_unlock()


Do I miss anything?

--
Best Regards,
Huang, Ying

