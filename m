Return-Path: <linux-kernel+bounces-30404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87690831E44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27E9282B54
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF272C845;
	Thu, 18 Jan 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY0GKIJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DB12C841;
	Thu, 18 Jan 2024 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598279; cv=none; b=jdIeV25ORWCKf3zp4f6LEEpYhQ6Os5WmaL7yqrtL5pFqE8taRyvNuKoI1xULTaXsomp/n17LYLqKYJXp39m8x+vapJs38Y0Jpkyq83IR3Qn0mLmu38RYTwuH5/6ICIPjKyZHRGtFmd3G1qo4ZD+Sog4P+NxHA75Yhf+jibs41eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598279; c=relaxed/simple;
	bh=3QxSF28AU67pQOjUoBLeJaaRz+4V7zAoBNQxbnwWDt8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=WvSTlYbQ/nSc9uv4CmRdi4odFpM+ojdcYd7QrKxWSIcSx00Wee+Anr+9+H65RkRQ633FAvN9p/gwITAKDJCZCWsvGVNdOzkGpR7YTlnYuXHb3yVfpvYfBaYEFgsU52vFX1t2LekinsHM9MqhtIWHolYcqhitvNlrrO+NJ4H/+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY0GKIJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66706C433C7;
	Thu, 18 Jan 2024 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598278;
	bh=3QxSF28AU67pQOjUoBLeJaaRz+4V7zAoBNQxbnwWDt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YY0GKIJc+pAS737+c4sKDiztl/QoGtBo8pvn+YwjPSonfyxdp0JRYw4bQNAr0joWz
	 CaVmb7jTY4wu9qshPkDLOY+weKEPjX+1DBD9bFW2MdV537bXdXFmTO3Ba4DOODuxuI
	 7pWpez9XB8YlGlN4/ud5X91JMKrygflfa27tvcxRILMMUKFvlWpolaQ3aN3mKmzQYW
	 Gp8csA815jUZcly340n12SsW5f4Lbf/h33nXVW2vBTKUzh0JgLfOYa+JmPfcSA0J+R
	 SFPrW1SXWufOKHqiDMTSLlhk0NrSTLgLDJjLUyCvUAKzvYcUSL/ovQkMkm6+Q0XnhE
	 KPhE25L8zpjvA==
From: SeongJae Park <sj@kernel.org>
To: Hyeongtak Ji <hyeongtak.ji@sk.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	damon@lists.linux.dev,
	dave.jiang@intel.com,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com
Subject: Re: [RFC PATCH 0/4] DAMON based 2-tier memory management for CXL memory
Date: Thu, 18 Jan 2024 09:17:56 -0800
Message-Id: <20240118171756.80356-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240118104017.2098-1-hyeongtak.ji@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 18 Jan 2024 19:40:16 +0900 Hyeongtak Ji <hyeongtak.ji@sk.com> wrote:

> Hi SeongJae,
> 
> On Wed, 17 Jan 2024 SeongJae Park <sj@kernel.org> wrote:
> 
> [...]
> >> Let's say there are 3 nodes in the system and the first node0 and node1
> >> are the first tier, and node2 is the second tier.
> >> 
> >>   $ cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
> >>   0-1
> >> 
> >>   $ cat /sys/devices/virtual/memory_tiering/memory_tier22/nodelist
> >>   2
> >> 
> >> Here is the result of partitioning hot/cold memory and I put execution
> >> command at the right side of numastat result.  I initially ran each
> >> hot_cold program with preferred setting so that they initially allocate
> >> memory on one of node0 or node2, but they gradually migrated based on
> >> their access frequencies.
> >> 
> >>   $ numastat -c -p hot_cold
> >>   Per-node process memory usage (in MBs) 
> >>   PID              Node 0 Node 1 Node 2 Total 
> >>   ---------------  ------ ------ ------ ----- 
> >>   754 (hot_cold)     1800      0   2000  3800    <- hot_cold 1800 2000 
> >>   1184 (hot_cold)     300      0    500   800    <- hot_cold 300 500 
> >>   1818 (hot_cold)     801      0   3199  4000    <- hot_cold 800 3200 
> >>   30289 (hot_cold)      4      0      5    10    <- hot_cold 3 5 
> >>   30325 (hot_cold)     31      0     51    81    <- hot_cold 30 50 
> >>   ---------------  ------ ------ ------ ----- 
> >>   Total              2938      0   5756  8695
> >> 
> >> The final node placement result shows that DAMON accurately migrated
> >> pages by their hotness for multiple processes.
> >
> > What was the result when the corner cases handling logics were not applied?
> 
> This is the result of the same test that Honggyu did, but with an insufficient
> corner cases handling logics.
> 
>   $ numastat -c -p hot_cold
> 
>   Per-node process memory usage (in MBs)
>   PID             Node 0 Node 1 Node 2 Total
>   --------------  ------ ------ ------ -----
>   862 (hot_cold)    2256      0   1545  3801   <- hot_cold 1800 2000
>   863 (hot_cold)     403      0    398   801   <- hot_cold 300 500
>   864 (hot_cold)    1520      0   2482  4001   <- hot_cold 800 3200
>   865 (hot_cold)       6      0      3     9   <- hot_cold 3 5
>   866 (hot_cold)      29      0     52    81   <- hot_cold 30 50
>   --------------  ------ ------ ------ -----
>   Total             4215      0   4480  8695
> 
> As time goes by, DAMON keeps trying to split the hot/cold region, but it does
> not seem to be enough.
> 
>   $ numastat -c -p hot_cold
> 
>   Per-node process memory usage (in MBs)
>   PID             Node 0 Node 1 Node 2 Total
>   --------------  ------ ------ ------ -----
>   862 (hot_cold)    2022      0   1780  3801   <- hot_cold 1800 2000
>   863 (hot_cold)     351      0    450   801   <- hot_cold 300 500
>   864 (hot_cold)    1134      0   2868  4001   <- hot_cold 800 3200
>   865 (hot_cold)       7      0      2     9   <- hot_cold 3 5
>   866 (hot_cold)      43      0     39    81   <- hot_cold 30 50
>   --------------  ------ ------ ------ -----
>   Total             3557      0   5138  8695
> 
> >
> > And, what are the corner cases handling logic that seemed essential?  I show
> > the page granularity active/reference check could indeed provide many
> > improvements, but that's only my humble assumption.
> 
> Yes, the page granularity active/reference check is essential.  To make the
> above "insufficient" result, the only thing I did was to promote
> inactive/not_referenced pages.
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f03be320f9ad..c2aefb883c54 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1127,9 +1127,7 @@ static unsigned int __promote_folio_list(struct list_head *folio_list,
>                 VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> 
>                 references = folio_check_references(folio, sc);
> -               if (references == FOLIOREF_KEEP ||
> -                   references == FOLIOREF_RECLAIM ||
> -                   references == FOLIOREF_RECLAIM_CLEAN)
> +               if (references == FOLIOREF_KEEP )
>                         goto keep_locked;
> 
>                 /* Relocate its contents to another node. */

Thank you for sharing the details :)  I think DAMOS filters based approach
could be worthy to try, then.

> 
> >
> > If the corner cases are indeed better to be applied in page granularity, I
> > agree we need some more efforts since DAMON monitoring results are not page
> > granularity aware by the design.  Users could increase min_nr_regions to make
> > it more accurate, and we have plan to support page granularity monitoring,
> > though.  But maybe the overhead could be unacceptable.
> >
> > Ideal solution would be making DAMON more accurate while keeping current level
> > of overhead.  We indeed have TODO items for DAMON accuracy improvement, but
> > this may take some time that might unacceptable for your case.
> >
> > If that's the case, I think the additional corner handling (or, page gran
> > additional access check) could be made as DAMOS filters[1], since DAMOS filters
> > can be applied in page granularity, and designed for this kind of handling of
> > information that DAMON monitoring results cannot provide.  More specifically,
> > we could have filters for promotion-qualifying pages and demotion-qualifying
> > pages.  In this way, I think we can keep the action more flexible while the
> > filters can be applied in creative ways.
> 
> Making corner handling as a new DAMOS filters is a good idea.  I'm just a bit
> concerned if adding new filters might cause users to care more.

I prefer keeping DAMON API and Sysfs interface flexible and easy to extended
even if it increases number of parameters, while providing simplified
high level interfaces for end users aiming to use DAMON for specific use cases,
like DAMON_RECLAIM, DAMON_LRU_SORT, and damo do.  Hence I'm not very concerned.


Thanks,
SJ

> 
> Kind regards,
> Hyeongtak

