Return-Path: <linux-kernel+bounces-68519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E817857B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510CC1C23C34
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BCC7762F;
	Fri, 16 Feb 2024 11:26:51 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA11E499
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 11:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082811; cv=none; b=frIXDZHcMxlOHKsKTRXV4DU8dmVGdlW2M5ANiONvACZY24qFHaTA2SXliK6itE88pi7jRDvCLBWDKWi/oUr+m4d6EdFL9gVGGA1HXC18Nou8+PlZWK7ODKI8srp+1Bh4NhuSQBgSiZ6QVDORFdNw5U2OFj2Tx1DDJuFm78cQkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082811; c=relaxed/simple;
	bh=r60TtNSvLpFek6w6RsdFTH0BMLv/88jRak/JmVGFlRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frszLjfdcUdrobYxpUr5c17d3oEdx3doFLu/eBhxeWNudxoUa9JNbf6CKXqoCQwcKRNRx94eCvydQziQLDl5L4KfXvKtXP1MXPtWU6uU/4axWHjGBGD48OUEBaTikEc6M8mI4Q0o0Sa0X9CKgCwZBTBPXHHZGQHof7ZrKgoZq1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-3c-65cf46719aab
Date: Fri, 16 Feb 2024 20:26:36 +0900
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
Message-ID: <20240216112636.GA4266@system.software.com>
References: <20240214035355.18335-1-byungchul@sk.com>
 <Zc0tFdGAzD9sCzZN@localhost.localdomain>
 <20240216070754.GB32626@system.software.com>
 <Zc8UPuzii_5gTsrJ@localhost.localdomain>
 <20240216091139.GA75176@system.software.com>
 <20240216092305.GC75176@system.software.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216092305.GC75176@system.software.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LhesuzSLfQ7XyqQVOzusWc9WvYLC49vspm
	Mf1lI4vF0wlbmS3u9k9lsbi8aw6bxb01/1ktJr97xmhx6cACJosz04osjvceYLLY1/GAyaLj
	yDdmi61Hv7M78HmsmbeG0aNl3y12jwWbSj02r9Dy2PRpErvHnWt72DxOzPjN4vF+31U2j82n
	qz0+b5IL4IrisklJzcksSy3St0vgyji9Kb3gFF/FjlnXmBsYl3J3MXJySAiYSOxecI0Rxp5w
	7xZzFyMHB4uAqsTZZVYgYTYBdYkbN34yg9giAmoS0141sncxcnEwC5xikpjw+QI7SL2wQJjE
	3zcKIDW8AuYSHWd/MYPUCAnMYJL4sm41G0RCUOLkzCcsIDazgJbEjX8vmUB6mQWkJZb/4wAx
	OQUsJfZs0QapEBVQljiw7TgTyBgJgWZ2iblP5rJAnCkpcXDFDZYJjAKzkEydhWTqLISpCxiZ
	VzEKZeaV5SZm5pjoZVTmZVboJefnbmIExtGy2j/ROxg/XQg+xCjAwajEw3vgz9lUIdbEsuLK
	3EOMEhzMSiK8k3rPpArxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgST
	ZeLglGpgdEg+uvg8187zJ2d2yb5lKQ06vOWUpPI2a+2Zfqt55R25X77o3e5uHm52LvZ0mPwb
	jfSoB/v+y3ywmPYy72pWd2HI160/7xzf+dTgAu+rOgmGvGM7GBn3fIh/weV1db/MttC0BRcS
	XIXm9gZ6PL/r6lq/0C4sadtHFsVr2ze9j5FefOzLX/Y5oUosxRmJhlrMRcWJAMPftn+fAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsXC5WfdrFvodj7VYMpvCYs569ewWVx6fJXN
	YvrLRhaLpxO2Mlvc7Z/KYnF47klWi8u75rBZ3Fvzn9Vi8rtnjBaXDixgsjgzrcjieO8BJot9
	HQ+YLDqOfGO22Hr0O7sDv8eaeWsYPVr23WL3WLCp1GPzCi2PTZ8msXvcubaHzePEjN8sHu/3
	XWXzWPziA5PH5tPVHp83yQVwR3HZpKTmZJalFunbJXBlnN6UXnCKr2LHrGvMDYxLubsYOTkk
	BEwkJty7xdzFyMHBIqAqcXaZFUiYTUBd4saNn8wgtoiAmsS0V43sXYxcHMwCp5gkJny+wA5S
	LywQJvH3jQJIDa+AuUTH2V/MIDVCAjOYJL6sW80GkRCUODnzCQuIzSygJXHj30smkF5mAWmJ
	5f84QExOAUuJPVu0QSpEBZQlDmw7zjSBkXcWkuZZSJpnITQvYGRexSiSmVeWm5iZY6pXnJ1R
	mZdZoZecn7uJERgVy2r/TNzB+OWy+yFGAQ5GJR7eA3/OpgqxJpYVV+YeYpTgYFYS4Z3UeyZV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgbHMxZjp+r4f
	Rq+eu8Yk/zv2MLHa7TKrwIUyTaE9Sn9+d2Wb/eWPzZlmHLK9UEBp2gxec8bPbjdPGagtNmJ3
	CjC/qaLVL9L3svpArFeRRp1Z9RK+IzZH1p/89mL9tmvzdFe0aJ33jbiZomgaqfNNPfX7zCnn
	A+oEvfnNriVYihUXBH+ssPNNUGIpzkg01GIuKk4EABR6UqKGAgAA
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 06:23:05PM +0900, Byungchul Park wrote:
> On Fri, Feb 16, 2024 at 06:11:40PM +0900, Byungchul Park wrote:
> > On Fri, Feb 16, 2024 at 08:52:30AM +0100, Oscar Salvador wrote:
> > > On Fri, Feb 16, 2024 at 04:07:54PM +0900, Byungchul Park wrote:
> > > > For normal numa nodes, node_data[] is initialized at alloc_node_data(),
> > > > but it's not for memoryless node. However, the node *gets onlined* at
> > > > init_cpu_to_node().
> > > > 
> > > > Let's look at back free_area_init(). free_area_init_node() will be called
> > > > with node_data[] not set yet, because it's already *onlined*. So
> > > > ->zone_pgdat cannot be initialized properly in the path you mentioned.
> > > 
> > > I am might be missing something., so bear with me.
> > > 
> > > free_area_init() gets called before init_cpu_to_node() does.
> > > free_area_init_node() gets called on every possible node.
> > > 
> > > free_area_init_node then() does
> > > 
> > >  pg_data_t *pgdat = NODE_DATA(nid);,
> > > 
> > > and then we call free_area_init_core().
> > > 
> > > free_area_init_core() does
> > > 
> > >  free_area_init_core() does
> > >   zone_init_internals()
> > > 
> > > which ends up doing zone->zone_pgdat = NODE_DATA(nid);
> > > 
> > > If node_data[] was not set at all, we would already blow up when doing
> > > the first
> > > 
> > >   for_each_node()
> > >     pgdat = NODE_DATA(nid);
> > >     free_area_init_node(nid);
> > > 
> > > back in free_area_init().
> > 
> > It seems that I got it wrong about the reason. Let me check it again and
> > share the reason.

I analyzed it wrong. Even though the issue was gone with the patch but
it's not the fix. Sorry for making you confused. I submitted the fix with
another patch:

   https://lore.kernel.org/lkml/20240216111502.79759-1-byungchul@sk.com/

	Byungchul

