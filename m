Return-Path: <linux-kernel+bounces-68155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA37857693
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01811C228D6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A2179AF;
	Fri, 16 Feb 2024 07:08:11 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8A17741
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708067291; cv=none; b=VfodpTHufmzsyEJcGIT1H2I1T/MAr5C04rzrl12UHuFv1DG5W1aC3c5B6BR9VSlw/i5nLKUUAsOAD7nrPgHOrPujjgU3Rbjl90X446g5R7FwV65dd5zIWru6PZzpcO3Nxj5TRURnbnYKWJQGwBotK5GUFmZuucH07kThixVGeIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708067291; c=relaxed/simple;
	bh=P1JpDgi6JxDyqQ6JKwjy3OrNu+eVb8L1qNX9R+kIjls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjvYIlebSV+OlK4aEu2NE/LdRAG97JDdQHvH4Ol5upCJ+t3SGZLN/gvDdfazSz2ZZebYQ0pLzpatqqmdzYDAON5Cj9l9qDLaL72RYjEcxW886MPgPjuYxsBVW88/EyBiLErZu4jxio43z/FXzAm9mKsGECxEymiQmnXhcUrvaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-87-65cf09cf730f
Date: Fri, 16 Feb 2024 16:07:54 +0900
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
Message-ID: <20240216070754.GB32626@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <Zc0tFdGAzD9sCzZN@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0tFdGAzD9sCzZN@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhesuzSPc85/lUgzULLC3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFmcmVZkcbz3AJPFvo4HTBYd
	R74xW2w9+p3dgc9jzbw1jB4t+26xeyzYVOqxeYWWx6ZPk9g97lzbw+ZxYsZvFo/3+66yeWw+
	Xe3xeZNcAFcUl01Kak5mWWqRvl0CV8aGS6YFG7gqjr2axNTAuImji5GTQ0LARGLqnRvMMPbN
	xefZQGwWAVWJF107WUBsNgF1iRs3foLViAioSUx71cjexcjFwSxwikliwucLQA4Hh7BAmMTf
	NwogNbwCFhKTpk8HCwsJJEjc2iIOERaUODnzCdhIZgEtiRv/XjKBlDALSEss/wd2DaeAqURj
	+2qwC0QFlCUObDvOBLJJQuA/m8Scxy+hzpSUOLjiBssERoFZSMbOQjJ2FsLYBYzMqxiFMvPK
	chMzc0z0MirzMiv0kvNzNzEC42hZ7Z/oHYyfLgQfYhTgYFTi4T3w52yqEGtiWXFl7iFGCQ5m
	JRHeSb1nUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUw
	8rJKLzdm+/zBojCK7cHjtjqd+12c6yUvRmzdK2h4pslu2YIN/o5+7aIPX704XGnL5Tzp2KY/
	Agr9+3fLs6xkvr6iNzAtSudmafitgvS06+VqVmaf+SXO3N7cfDQ8lX+CA4uwmYj38c2Xeb9m
	7z/v17mZL77RjTvSRGt79sawHz0Z/1gLDq1SYinOSDTUYi4qTgQAReA9Qp8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXC5WfdrHue83yqwZqvGhZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLw3JOsFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHFmWpHF8d4DTBb7
	Oh4wWXQc+cZssfXod3YHfo8189YwerTsu8XusWBTqcfmFVoemz5NYve4c20Pm8eJGb9ZPN7v
	u8rmsfjFByaPzaerPT5vkgvgjuKySUnNySxLLdK3S+DK2HDJtGADV8WxV5OYGhg3cXQxcnJI
	CJhI3Fx8ng3EZhFQlXjRtZMFxGYTUJe4ceMnM4gtIqAmMe1VI3sXIxcHs8ApJokJny8AORwc
	wgJhEn/fKIDU8ApYSEyaPh0sLCSQIHFrizhEWFDi5MwnYCOZBbQkbvx7yQRSwiwgLbH8H9gF
	nAKmEo3tq8EuEBVQljiw7TjTBEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVeZoVe
	cn7uJkZgVCyr/TNxB+OXy+6HGAU4GJV4eA/8OZsqxJpYVlyZe4hRgoNZSYR3Uu+ZVCHelMTK
	qtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGnXqbRRfEv2tYs6xE
	5HBjtLHNhhl11n8fTda/3yvSdb/AM25v/THdu5aay54H3hPLbF7jUBsh8efAijCTPRzLTf9l
	Ljih6GD14ITJ9qJ93DbRN/Y+WlNwM6NHabnB0R9bDp79F9Hp9XCmb9m9bPPagoq7Ww0z18Zw
	iKRcObR/1tZgg8Ty0M9HlViKMxINtZiLihMBIvbnWIYCAAA=
X-CFilter-Loop: Reflected

On Wed, Feb 14, 2024 at 10:13:57PM +0100, Oscar Salvador wrote:
> On Wed, Feb 14, 2024 at 12:53:55PM +0900, Byungchul Park wrote:
> > While running qemu with a configuration where some CPUs don't have their
> > local memory and with a kernel numa balancing on, the following oops has
> > been observed. It's because of null pointers of ->zone_pgdat of zones of
> > those nodes that are not initialized at booting time. So should avoid
> > nodes not set N_MEMORY from getting promoted.
> 
> Looking at free_area_init(), we call free_area_init_node() for each node
> found on the system.
> And free_area_init_node()->free_area_init_core() inits all zones
> belonging to the system via zone_init_internals().

For normal numa nodes, node_data[] is initialized at alloc_node_data(),
but it's not for memoryless node. However, the node *gets onlined* at
init_cpu_to_node().

Let's look at back free_area_init(). free_area_init_node() will be called
with node_data[] not set yet, because it's already *onlined*. So
->zone_pgdat cannot be initialized properly in the path you mentioned.

	Byungchul

> Now, I am not saying the check is wrong because we obviously do not want
> migrate memory to a memoryless node, but I am confused as to where
> we are crashing.
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs

