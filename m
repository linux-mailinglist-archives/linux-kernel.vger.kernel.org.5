Return-Path: <linux-kernel+bounces-104172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10A87CA22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCC01C20756
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F45175AD;
	Fri, 15 Mar 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgW5sqCs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A87417579
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492219; cv=none; b=K8gaIKN905YX6vfeRIup4ReTtjmjYpEmxK64N0aDYgE3mQkHdXJHRawtN4y/LUMSjP99AkYt5pKW+B+0wOFifAAgOpnOQV3VG0dW2o5Q0QUTy79W4gRaE/CFWQXuY90UAePlo434rAyK7fvawnzxs7q/hgMPI6XLz4KoFdqqqzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492219; c=relaxed/simple;
	bh=WWHHW90wK8/G15XckvW+3s0nidylONdVyAdhQ9e18Do=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBkGIAmLHzpB4Zhf0O5ui5SPthCRBzuGcCjsaoypb4/9xSOQ5+f8nntjx+ByTcwpfxvyOUoDrITRKXQiq9hGlLNcoFGQ3LbdhGx+ta/7BEUD5EG/hR71ZNOffkNcnywot9YDQCXK8mdXdI9mJe9pjTHGW5CsuIWesRSI/KJlZb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgW5sqCs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710492217; x=1742028217;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=WWHHW90wK8/G15XckvW+3s0nidylONdVyAdhQ9e18Do=;
  b=UgW5sqCsAHL/8nCZ6qWcGRP3XQsqYLV5lWcern9Hu3QuxPpIFaHerbui
   axdfZjVcRvV7uqNsFxApo8u5M7Bma5SxJ7oFRpA/QHeGaK0WuNERIm4kp
   sCdwEV7YhgbLI/3YomeXUuFZ7gRZrWmc05+SOafVCV6N3ysuqzyetyimk
   nRyznCHDPesN6lg/f9J7Sg4Wd+FxH2IheJS9K1+uCqtredajaNbMZWacs
   fic8jBtlEjHAdb7HrQd5RaCJLecYBVIXSj2as7KNT6M90mZXPVG2tFr6a
   9mfahrvnKn51AW+dm6Q0k7Zw2GIvNqniHxoxsmSANnjw32iy6HcQ2Yekr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16499638"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="16499638"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:43:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12519204"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:43:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,  ryan.roberts@arm.com,
  chengming.zhou@linux.dev,  chrisl@kernel.org,  david@redhat.com,
  hannes@cmpxchg.org,  kasong@tencent.com,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  mhocko@suse.com,  nphamcs@gmail.com,  shy828301@gmail.com,
  steven.price@arm.com,  surenb@google.com,  wangkefeng.wang@huawei.com,
  willy@infradead.org,  xiang@kernel.org,  yosryahmed@google.com,
  yuzhao@google.com,  Chuanhua Han <hanchuanhua@oppo.com>,  Barry Song
 <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
In-Reply-To: <20240304081348.197341-6-21cnbao@gmail.com> (Barry Song's message
	of "Mon, 4 Mar 2024 21:13:48 +1300")
References: <20240304081348.197341-1-21cnbao@gmail.com>
	<20240304081348.197341-6-21cnbao@gmail.com>
Date: Fri, 15 Mar 2024 16:41:37 +0800
Message-ID: <87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> On an embedded system like Android, more than half of anon memory is
> actually in swap devices such as zRAM. For example, while an app is
> switched to background, its most memory might be swapped-out.
>
> Now we have mTHP features, unfortunately, if we don't support large folios
> swap-in, once those large folios are swapped-out, we immediately lose the
> performance gain we can get through large folios and hardware optimization
> such as CONT-PTE.
>
> This patch brings up mTHP swap-in support. Right now, we limit mTHP swap-in
> to those contiguous swaps which were likely swapped out from mTHP as a
> whole.
>
> Meanwhile, the current implementation only covers the SWAP_SYCHRONOUS
> case. It doesn't support swapin_readahead as large folios yet since this
> kind of shared memory is much less than memory mapped by single process.

In contrast, I still think that it's better to start with normal swap-in
path, then expand to SWAP_SYCHRONOUS case.

In normal swap-in path, we can take advantage of swap readahead
information to determine the swapped-in large folio order.  That is, if
the return value of swapin_nr_pages() > 1, then we can try to allocate
and swapin a large folio.

To do that, we need to track whether the sub-pages are accessed.  I
guess we need that information for large file folio readahead too.

Hi, Matthew,

Can you help us on tracking whether the sub-pages of a readahead large
folio has been accessed?

> Right now, we are re-faulting large folios which are still in swapcache as a
> whole, this can effectively decrease extra loops and early-exitings which we
> have increased in arch_swap_restore() while supporting MTE restore for folios
> rather than page. On the other hand, it can also decrease do_swap_page as
> PTEs used to be set one by one even we hit a large folio in swapcache.
>

--
Best Regards,
Huang, Ying

