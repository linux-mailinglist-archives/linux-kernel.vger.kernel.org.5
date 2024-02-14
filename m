Return-Path: <linux-kernel+bounces-64597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3778540B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A5A1C24E4D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14042290C;
	Wed, 14 Feb 2024 00:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jym8a+/N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F96B7F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869284; cv=none; b=VJRkPB66spfeSAdJflwiQJmsY7ITjG0SmD0h0jLGrfN/tqitBIIkTzvwyC7xDXKR5/B6hy1HZVvgqLWrrM4yFFQAZ9a4yuc5Tm0nokaCYvQtihp3FIzYpX1xBLcGdjDA00tsmiSozbVwvYiRXV2ghn2blRzb/3Bpzaf2ysGvyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869284; c=relaxed/simple;
	bh=Onc/Nm5J2ADHvGRgUGidlYL5cNBOfivtq/tSzL+HJ1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TToPjbrh+Y1npba/25doBLGYeK5JnyNQG1K3JiJTZmOw7+PoFeVhhWkfaQEpnI0ocbErrJ6lnBq0g72DCzSXAdierJljdXuPsmXoECirRa3C4BjVNfPklXYP9KIf6mf4U4HzGTbn83dDaAf7N37Q66pOAc6aT8S7zGhe+YX2abo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jym8a+/N; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707869282; x=1739405282;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Onc/Nm5J2ADHvGRgUGidlYL5cNBOfivtq/tSzL+HJ1s=;
  b=Jym8a+/NYjRXbNUjgY0bjdAqHw/wbYrZm0Oh220ja8pvKNpIlS5xE/jD
   1Zc8qXjFWpHT/GZ+Q08sHCcqko8kvE64LFQNeuPEiA0oNLn3DVZevOSQZ
   u0u38TKptpS712EGV5xrOHPa8iwNW0m1PS3H3hUGqJoXd+Jpcz9CpQcrj
   zTQw5FNgzAEj5IBd/Ywz8zMgO3MnwOAo34WeMwEn3Wka29DOdN8hWSNHb
   3wdbPOZ8QTrsT2OWc1zFpJzjgeDd9JPir5BGbSQY3SszGfdOQN/Rq/iMm
   OYF8qv/nriiUIGxzsybXszfday1lXYz6wQz2nhzx0tcZk/Zt4Fb3vitoX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="2261138"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="2261138"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 16:08:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935501057"
X-IronPort-AV: E=Sophos;i="6.06,158,1705392000"; 
   d="scan'208";a="935501057"
Received: from arieldux-mobl.amr.corp.intel.com (HELO [10.209.91.178]) ([10.209.91.178])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 16:08:00 -0800
Message-ID: <c4ae18fb13ab1c63cdd34da9fe7b1e0f1a91c909.camel@linux.intel.com>
Subject: Re: [PATCH v3] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Xu
 <weixugc@google.com>,  Yu Zhao <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>,  Yosry Ahmed
 <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman
 <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, Nhat Pham
 <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, Barry Song
 <v-songbaohua@oppo.com>
Date: Tue, 13 Feb 2024 16:08:00 -0800
In-Reply-To: <20240213-async-free-v3-1-b89c3cc48384@kernel.org>
References: <20240213-async-free-v3-1-b89c3cc48384@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 15:20 -0800, Chris Li wrote:
> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>=20
> Further investigation show that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>=20
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>=20
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>=20
> Add /sys/kernel/mm/swap/swap_slot_async_free to control the
> async free behavior. When enabled, using work queue to async
> free the swap slot when the swap slot cache is full.
>=20
> Testing:
>=20
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>=20
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>=20
> platform	(100-500us)	 	(0-100us)
> A		1.12% -> 0.36%		98.47% -> 99.22%
> B		0.65% -> 0.15%		98.96% -> 99.46%
> C		0.61% -> 0.23%		98.96% -> 99.38%
>=20
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Changes in v3:
> - Address feedback from Tim Chen, direct free path will free all swap slo=
ts.
> - Add /sys/kernel/mm/swap/swap_slot_async_fee to enable async free. Defau=
lt is off.
> - Link to v2: https://lore.kernel.org/r/20240131-async-free-v2-1-525f03e0=
7184@kernel.org
>=20
> Changes in v2:
> - Add description of the impact of time changing suggest by Ying.
> - Remove create_workqueue() and use schedule_work()
> - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b27799=
2cb0@kernel.org
> ---
>  include/linux/swap_slots.h |  2 ++
>  mm/swap_slots.c            | 20 ++++++++++++++++++++
>  mm/swap_state.c            | 23 +++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> index 15adfb8c813a..bb9a401d7cae 100644
> --- a/include/linux/swap_slots.h
> +++ b/include/linux/swap_slots.h
> @@ -19,6 +19,7 @@ struct swap_slots_cache {
>  	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
>  	swp_entry_t	*slots_ret;
>  	int		n_ret;
> +	struct work_struct async_free;
>  };
> =20
>  void disable_swap_slots_cache_lock(void);
> @@ -27,5 +28,6 @@ void enable_swap_slots_cache(void);
>  void free_swap_slot(swp_entry_t entry);
> =20
>  extern bool swap_slot_cache_enabled;
> +extern uint8_t slot_cache_async_free __read_mostly;

Why wouldn't you enable the async_free always?
Otherwise the patch looks fine to me.

Tim

> =20


