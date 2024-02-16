Return-Path: <linux-kernel+bounces-68313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097C857896
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A3EB22ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B72B1B81C;
	Fri, 16 Feb 2024 09:12:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D517BD6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708074723; cv=none; b=J/42BKfAT6lzZWw6WcaWa70SmMtQTSry7z26QdrFb3WU9zoWLwBYWAOnerXR/14ZbnTmnTsHhRau0VuIcLdBlyx2Pen6FegX+fsszKzd0dP7nFRw0hNLtnIdgZ5Tuc+bVR1a1r4ZtowKd92W2BfQwZk3ERXG87rNqoqDK1E4yoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708074723; c=relaxed/simple;
	bh=Ryp7q8VfnYfLCvqepfziSt+wAlGU+XTSlKDD0RP5Vxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcaMqJRRfUaJ494cBi4Yv8Of8CmGtaMJl1E442i/g7l4IONteX+a9v6RQBh1t2xlKTOYwsyMBSx3hynC5y2GHbSlV7VYZnZXFxp0qh4p7gbVJr6eR20copBBStRS2bcY5P/s1RxgGzq36ve6TT7OONznEjok+i0zwaYXZcH/4m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-b0-65cf26d1d245
Date: Fri, 16 Feb 2024 18:11:40 +0900
From: Byungchul Park <byungchul@sk.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH] sched/numa, mm: do not promote folios to nodes not set
 N_MEMORY
Message-ID: <20240216091139.GA75176@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <Zc0tFdGAzD9sCzZN@localhost.localdomain>
 <20240216070754.GB32626@system.software.com>
 <Zc8UPuzii_5gTsrJ@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc8UPuzii_5gTsrJ@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhesuzSPei2vlUg2nHxS3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFmcmVZkcbz3AJPFvo4HTBYd
	R74xW2w9+p3dgc9jzbw1jB4t+26xeyzYVOqxeYWWx6ZPk9g97lzbw+ZxYsZvFo/3+66yeWw+
	Xe3xeZNcAFcUl01Kak5mWWqRvl0CV0bD+4nMBT+4Kn43PGZuYLzO0cXIySEhYCKx9NJndhj7
	SGcjM4jNIqAqMf9YP1icTUBd4saNn2BxEQE1iWmvGoHiXBzMAqeYJCZ8vgDkcHAIC4RJ/H2j
	AFLDK2AhceT/KlaQGiGBXYwS19YsYINICEqcnPmEBcRmFtCSuPHvJRNIL7OAtMTyfxwgJqeA
	qcTfNTUgFaICyhIHth1nAhkjIdDMLrFi3yOoOyUlDq64wTKBUWAWkqmzkEydhTB1ASPzKkah
	zLyy3MTMHBO9jMq8zAq95PzcTYzAWFpW+yd6B+OnC8GHGAU4GJV4eA/8OZsqxJpYVlyZe4hR
	goNZSYR3Uu+ZVCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTByc
	Ug2MXfLJpscN8pi3X5Hv/LVDbdfpyc+9lgZtnnz8crIlS/gz3t15ka+90tdlsCS0NFzLPTCt
	r1Wis7Ly9tsgxnMLpBu1Vf8f97vp2fL+j4GOvueSbL+nXx93lEws8f24ofrKt/CNtxd/t5mc
	tbK8U3X356l6eyV2n5NLaZqf0Cy+4ODtTuVjerdmKLEUZyQaajEXFScCAKiRbaKhAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXC5WfdrHtR7XyqwaxmXos569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjgzrcjieO8BJot9
	HQ+YLDqOfGO22Hr0O7sDv8eaeWsYPVr23WL3WLCp1GPzCi2PTZ8msXvcubaHzePEjN8sHu/3
	XWXzWPziA5PH5tPVHp83yQVwR3HZpKTmZJalFunbJXBlNLyfyFzwg6vid8Nj5gbG6xxdjJwc
	EgImEkc6G5lBbBYBVYn5x/rZQWw2AXWJGzd+gsVFBNQkpr1qBIpzcTALnGKSmPD5ApDDwSEs
	ECbx940CSA2vgIXEkf+rWEFqhAR2MUpcW7OADSIhKHFy5hMWEJtZQEvixr+XTCC9zALSEsv/
	cYCYnAKmEn/X1IBUiAooSxzYdpxpAiPvLCTNs5A0z0JoXsDIvIpRJDOvLDcxM8dUrzg7ozIv
	s0IvOT93EyMwMpbV/pm4g/HLZfdDjAIcjEo8vAf+nE0VYk0sK67MPcQowcGsJMI7qfdMqhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVANj1u0VNy7b+G5f
	z8ZiJDNR6WTjjUPOByr+/nk1L2NXeWzGdceUG+ZN8luc/+64LBV3Wf6R2EWrv4WJ9Y+mJJWv
	Off/ztQGw/qrhcc4birmZj7wj05JnmE7bdUl51MvZrNLiPfuq31Qwt+Rqbzxl+e9mX9uXY/7
	8fOSRty05VOtUuK4Nz3bncz/S4mlOCPRUIu5qDgRAArQxHCIAgAA
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 08:52:30AM +0100, Oscar Salvador wrote:
> On Fri, Feb 16, 2024 at 04:07:54PM +0900, Byungchul Park wrote:
> > For normal numa nodes, node_data[] is initialized at alloc_node_data(),
> > but it's not for memoryless node. However, the node *gets onlined* at
> > init_cpu_to_node().
> > 
> > Let's look at back free_area_init(). free_area_init_node() will be called
> > with node_data[] not set yet, because it's already *onlined*. So
> > ->zone_pgdat cannot be initialized properly in the path you mentioned.
> 
> I am might be missing something., so bear with me.
> 
> free_area_init() gets called before init_cpu_to_node() does.
> free_area_init_node() gets called on every possible node.
> 
> free_area_init_node then() does
> 
>  pg_data_t *pgdat = NODE_DATA(nid);,
> 
> and then we call free_area_init_core().
> 
> free_area_init_core() does
> 
>  free_area_init_core() does
>   zone_init_internals()
> 
> which ends up doing zone->zone_pgdat = NODE_DATA(nid);
> 
> If node_data[] was not set at all, we would already blow up when doing
> the first
> 
>   for_each_node()
>     pgdat = NODE_DATA(nid);
>     free_area_init_node(nid);
> 
> back in free_area_init().

It seems that I got it wrong about the reason. Let me check it again and
share the reason.

Just in case, this patch is still definitely necessary tho.

	Byungchul

