Return-Path: <linux-kernel+bounces-70643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29691859A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661441C2098B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F32119;
	Mon, 19 Feb 2024 02:09:15 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3804111E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308554; cv=none; b=HPGPHUagm/rJOsJ+50bxMvcM5jHs2DEpQRAx1C4pomrwYjGRP8xf7ExsET+kTepPhNvw3T8zvgIwEnASZ538QwvWnOEjiT4wI0K0+StvgjrYp7/xtUp7DeWC8xqTW8+CAdVKKv6l//xEnUZmIFsoNZwsOGwf2BDukU70XTxw3O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308554; c=relaxed/simple;
	bh=VucQDZvXBlsqG5aAZy4X/qs2OO3VqrPK8ZAKjKSlJXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FL8He1nV+t+VBora5vXKMMhdEnRkF5N7KoTlg8aa2PTYmpcIRYJvQ4HwEwh6ChreiYEZpQxyj4VOpCBA1oY7Q5JbfZ/DZLUu0lkbZ5UeXZ/oJcKsxOPBfUy/GljWcspckX8CWDVy+miSJiY3cMPh3l1DKl+FdM74JT3JX0PcnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-7b-65d2b83c33aa
Date: Mon, 19 Feb 2024 11:08:54 +0900
From: Byungchul Park <byungchul@sk.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, akpm@linux-foundation.org
Subject: Re: [PATCH v3] sched/numa, mm: do not promote folios to nodes not
 set N_MEMORY
Message-ID: <20240219020854.GA65758@system.software.com>
References: <20240216114045.24828-1-byungchul@sk.com>
 <Zc9oXOwGMGGE4bBh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc9oXOwGMGGE4bBh@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LhesuzUNdmx6VUg+s/JCzmrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XlXXPYLO6t+c9qMfndM0aLSwcWMFmcmVZkcbz3AJPFvo4HTBYd
	R74xW2w9+p3dgc9jzbw1jB4t+26xeyzYVOqxeYWWx6ZPk9g97lzbw+ZxYsZvFo/3+66yeWw+
	Xe3xeZNcAFcUl01Kak5mWWqRvl0CV8b67l+sBQsEKnp+T2BsYLzH08XIySEhYCLR27ubCcZe
	v3AyI4jNIqAqsffGFzCbTUBd4saNn8wgtoiAmsS0V43sXYxcHMwCp5gkJny+AORwcAgLREoc
	eisIUsMrYCEx7+xHVpCwkECCxJ/L7hBhQYmTM5+wgNjMAloSN/69ZAIpYRaQllj+jwMkzClg
	KrHoynp2EFtUQFniwLbjTCCbJASa2SXazq9jhThTUuLgihssExgFZiEZOwvJ2FkIYxcwMq9i
	FMrMK8tNzMwx0cuozMus0EvOz93ECIykZbV/oncwfroQfIhRgINRiYc3Q+RSqhBrYllxZe4h
	RgkOZiURXvemC6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeY2+lacICaQnlqRmp6YWpBbBZJk4
	OKUaGAXlZpiKJsrd31C0T8PnABNj9dXmrzxy2ZJFWkySBt0JbO0u2lr1e5ctkVZZ8mTR7ba+
	mBt/Nv30e18X/+KE5doHugt19tWyxBpbGvAJL1+y/DN3VIrV1A/s86+u3qX04aqxY/7jkjyB
	E2WWe6ar7rh/8n2F0KopS3hma7PmxWg8OF7W/syVS4mlOCPRUIu5qDgRADv7PY6gAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsXC5WfdrGuz41KqwY33XBZz1q9hs7j0+Cqb
	xfSXjSwWTydsZba42z+VxeLw3JOsFpd3zWGzuLfmP6vF5HfPGC0uHVjAZHFmWpHF8d4DTBb7
	Oh4wWXQc+cZssfXod3YHfo8189YwerTsu8XusWBTqcfmFVoemz5NYve4c20Pm8eJGb9ZPN7v
	u8rmsfjFByaPzaerPT5vkgvgjuKySUnNySxLLdK3S+DKWN/9i7VggUBFz+8JjA2M93i6GDk5
	JARMJNYvnMwIYrMIqErsvfEFzGYTUJe4ceMnM4gtIqAmMe1VI3sXIxcHs8ApJokJny8AORwc
	wgKREofeCoLU8ApYSMw7+5EVJCwkkCDx57I7RFhQ4uTMJywgNrOAlsSNfy+ZQEqYBaQllv/j
	AAlzCphKLLqynh3EFhVQljiw7TjTBEbeWUi6ZyHpnoXQvYCReRWjSGZeWW5iZo6pXnF2RmVe
	ZoVecn7uJkZgXCyr/TNxB+OXy+6HGAU4GJV4eDNELqUKsSaWFVfmHmKU4GBWEuF1b7qQKsSb
	klhZlVqUH19UmpNafIhRmoNFSZzXKzw1QUggPbEkNTs1tSC1CCbLxMEp1cB42j9ia21Gqnjs
	0aYOM88AtWLeRd5Ff7V+Xr37K0SHc6nj3WMzLtou43MseXr1rebecP4/7S2STukGO3c41+5k
	b7qxYdv2rEP8p28YTsnJ1DBevERrx9WtlcnFT5X6K4VtqjM1+hT+TjMs/qGj+eOms27OfJXJ
	F3/bntZW2d/jrxNz4f7BTH0lluKMREMt5qLiRACSVU0DhwIAAA==
X-CFilter-Loop: Reflected

On Fri, Feb 16, 2024 at 02:51:24PM +0100, Oscar Salvador wrote:
> On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
> > From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> > From: Byungchul Park <byungchul@sk.com>
> > Date: Fri, 16 Feb 2024 20:18:10 +0900
> > Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> 
> "do not try to promote folios to memoryless nodes"

Thank you. I will.

> because AFAICS we are just trying.
> Even if should_numa_migrate_memory() returns true, I assume that we will
> fail somewhere down the chain e.g: migrate_pages() when we see that this
> node does not any memory, right?

Yes.

> > A numa node might not have its local memory but CPUs. Promoting a folio
> > to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> > from getting promoted.
> 
> If you talk about memoryless nodes everybody gets it better IMHO.
> "Memoryless nodes do not have any memory to migrate to, so stop trying it."

Much better.

> > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > ---
> >  kernel/sched/fair.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index d7a3c63a2171..7ed9ef3c0134 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> >  	int dst_nid = cpu_to_node(dst_cpu);
> >  	int last_cpupid, this_cpupid;
> >  
> > +	/*
> > +	 * A node of dst_nid might not have its local memory. Promoting
> > +	 * a folio to the node is meaningless.
> > +	 */
> > +	if (!node_state(dst_nid, N_MEMORY))
> > +		return false;
> 
> "Cannot migrate to memoryless nodes"
> 
> seems shorter and more clear.

Agree.

	Byungchul

> So, what happens when we return true here? will we fail at
> migrate_pages() I guess? That is quite down the road so I guess
> this check can save us some time.
> 
> 
> -- 
> Oscar Salvador
> SUSE Labs

