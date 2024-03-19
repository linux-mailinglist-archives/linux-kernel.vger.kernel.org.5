Return-Path: <linux-kernel+bounces-107294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEFF87FA9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34BC1C21AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA617CF06;
	Tue, 19 Mar 2024 09:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NbixY2jU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B364CF6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710840138; cv=none; b=BzsbVv4SYTvocqxkbGDSSzD4nPx6Rjj6WQ9fZhNqKMuZh+KBHwlBs23pgbNnvm23GBI7Sjud1tdfrghWj0Ax4Ns9hRthedRxEC8o8/awjITPk3xuFiGRu0Oob7JjOG5siRCaxnSXJ3odC0JrvfIKT0pPLYus1S9LT5Zt6P19ZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710840138; c=relaxed/simple;
	bh=nzDazVKu3j3v0kvdOi+3UhNFcbOGNhHcgvkXfnLHLj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+4nUg59H2aonE7R+C/K1EI56CIYbtYK71E/qFBvxi0IWNHmsNdBYERfpD4PjPVOePr7m7FBNt9s2bFDargemASf+FjFuCNYx/butJCvTMsfyCIO4IRn6qoEqQK4NPubiqPmU4cxwUi7MRE0wA68uxwNqKVtzgA2otzlxyihYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NbixY2jU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710840137; x=1742376137;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=nzDazVKu3j3v0kvdOi+3UhNFcbOGNhHcgvkXfnLHLj8=;
  b=NbixY2jUyRCZDiuFEtu7mxBZCcDFNaCNoAcnrogYsNMDTWokDb9F/mQ3
   AKayqHSBSqSOVxXbGkpfcUNvIWLIHYTqNSSbnLwNXhiwLcaybcF73U+IU
   03K4q7BsoG386qy1vN0TmfqbLSAGojx0MelhDsi2Y8SeUns12qex5sORW
   pzPJU4CbwumoWuzDVcC8aEOgSQYAuudCVkbYgmuZtw8QJMotbXP8So3yl
   9HfS4LcERTAXnJilhdrs3E0dR/u+MMu2ZvWexQW8XbfWGTXYv3n0ys8Pm
   Uhq6Pr/k0SmaP7Z3XTsoMUPo2jo7lBYzPtlXYXRCCVLoRmmWuAmFGqnPA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="17141654"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="17141654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="13645375"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 02:22:09 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Barry Song <21cnbao@gmail.com>,  Matthew Wilcox <willy@infradead.org>,
  <akpm@linux-foundation.org>,  <linux-mm@kvack.org>,
  <chengming.zhou@linux.dev>,  <chrisl@kernel.org>,  <david@redhat.com>,
  <hannes@cmpxchg.org>,  <kasong@tencent.com>,
  <linux-arm-kernel@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <mhocko@suse.com>,  <nphamcs@gmail.com>,  <shy828301@gmail.com>,
  <steven.price@arm.com>,  <surenb@google.com>,
  <wangkefeng.wang@huawei.com>,  <xiang@kernel.org>,
  <yosryahmed@google.com>,  <yuzhao@google.com>,  "Chuanhua Han"
 <hanchuanhua@oppo.com>,  Barry Song <v-songbaohua@oppo.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
In-Reply-To: <9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com> (Ryan Roberts's
	message of "Mon, 18 Mar 2024 16:45:24 +0000")
References: <20240304081348.197341-1-21cnbao@gmail.com>
	<20240304081348.197341-6-21cnbao@gmail.com>
	<87wmq3yji6.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4x+t_X4Tn15=QPbH58e1S1FwOoM3t37T+cUE8-iKoENLw@mail.gmail.com>
	<87sf0rx3d6.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4xna1xKz7J=MWDR3h543UvnS9v0-+ggVc5fFzpFOzfpyA@mail.gmail.com>
	<87jzm0wblq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wTU3cmzXMCu+yQRMnEiCEUA8rO5=QQUopgG0RMnHYd5g@mail.gmail.com>
	<9ec62266-26f1-46b6-8bb7-9917d04ed04e@arm.com>
Date: Tue, 19 Mar 2024 17:20:16 +0800
Message-ID: <87jzlyvar3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

>>>> I agree phones are not the only platform. But Rome wasn't built in a
>>>> day. I can only get
>>>> started on a hardware which I can easily reach and have enough hardware/test
>>>> resources on it. So we may take the first step which can be applied on
>>>> a real product
>>>> and improve its performance, and step by step, we broaden it and make it
>>>> widely useful to various areas  in which I can't reach :-)
>>>
>>> We must guarantee the normal swap path runs correctly and has no
>>> performance regression when developing SWP_SYNCHRONOUS_IO optimization.
>>> So we have to put some effort on the normal path test anyway.
>>>
>>>> so probably we can have a sysfs "enable" entry with default "n" or
>>>> have a maximum
>>>> swap-in order as Ryan's suggestion [1] at the beginning,
>>>>
>>>> "
>>>> So in the common case, swap-in will pull in the same size of folio as was
>>>> swapped-out. Is that definitely the right policy for all folio sizes? Certainly
>>>> it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'm not sure
>>>> it makes sense for 2M THP; As the size increases the chances of actually needing
>>>> all of the folio reduces so chances are we are wasting IO. There are similar
>>>> arguments for CoW, where we currently copy 1 page per fault - it probably makes
>>>> sense to copy the whole folio up to a certain size.
>>>> "
>
> I thought about this a bit more. No clear conclusions, but hoped this might help
> the discussion around policy:
>
> The decision about the size of the THP is made at first fault, with some help
> from user space and in future we might make decisions to split based on
> munmap/mremap/etc hints. In an ideal world, the fact that we have had to swap
> the THP out at some point in its lifetime should not impact on its size. It's
> just being moved around in the system and the reason for our original decision
> should still hold.
>
> So from that PoV, it would be good to swap-in to the same size that was
> swapped-out.

Sorry, I don't agree with this.  It's better to swap-in and swap-out in
smallest size if the page is only accessed seldom to avoid to waste
memory.

> But we only kind-of keep that information around, via the swap
> entry contiguity and alignment. With that scheme it is possible that multiple
> virtually adjacent but not physically contiguous folios get swapped-out to
> adjacent swap slot ranges and then they would be swapped-in to a single, larger
> folio. This is not ideal, and I think it would be valuable to try to maintain
> the original folio size information with the swap slot. One way to do this would
> be to store the original order for which the cluster was allocated in the
> cluster. Then we at least know that a given swap slot is either for a folio of
> that order or an order-0 folio (due to cluster exhaustion/scanning). Can we
> steal a bit from swap_map to determine which case it is? Or are there better
> approaches?

[snip]

--
Best Regards,
Huang, Ying

