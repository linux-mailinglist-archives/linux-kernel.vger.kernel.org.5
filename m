Return-Path: <linux-kernel+bounces-70645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9F859AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27521C208A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105421FB3;
	Mon, 19 Feb 2024 02:10:39 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A44CEDD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308638; cv=none; b=JRf/vBZdvYguzbW7C7AUr0y5PSNagZc5ChIpczXrLTDVT/cjLGryk+UslF9dzaS5L1yUsGJ6GT/c2XrTG/o8IPbgXoSmcKGL1bW8/lacMM4I2zicGx/hiw5dWGdOyg/TDCg7mdX/rX1VTFd7clnY1U2ZChIOYNlRe6AXdoNM2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308638; c=relaxed/simple;
	bh=ESY7KDK5jsdQuinHnP/MzJCYbXZq0VP+8cfLJR91cKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibq8a0z74bKIr5sTV2+pVnsS/RfNm6eOiPOBaFiytpv6oSlaFfNmUW0lg6br0sRezPD6GDFHZ1c7T8CIa+2nDGWJfmhPagoJhb3JlcVH2TeZF03FpyEPVvat/dy4/tLbHIUwnKi93sAxWhcpkMZz8X6ce20fn6XLGlC+GrOxZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-84-65d2b8979e0c
Date: Mon, 19 Feb 2024 11:10:26 +0900
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
Message-ID: <20240219021026.GB65758@system.software.com>
References: <20240216114045.24828-1-byungchul@sk.com>
 <Zc9oXOwGMGGE4bBh@localhost.localdomain>
 <ZdG1yO29WTyRiw8Q@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdG1yO29WTyRiw8Q@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LhesuzSHfGjkupBhseclrMWb+GzeLS46ts
	FtNfNrJYPJ2wldnibv9UFovLu+awWdxb85/VYvK7Z4wWlw4sYLI4M63I4njvASaLfR0PmCw6
	jnxjtth69Du7A5/HmnlrGD1a9t1i91iwqdRj8wotj02fJrF73Lm2h83jxIzfLB7v911l89h8
	utrj8ya5AK4oLpuU1JzMstQifbsEroyLE66xFCwRrXjzZQdLA+NugS5GTg4JAROJp0eXMMPY
	147dZgOxWQRUJa78/8oEYrMJqEvcuPETrEZEQE1i2qtG9i5GLg5mgVNMEhM+XwByODiEBSIl
	Dr0VBKnhFbCQuLhqNdgcIYFuRonD93Ig4oISJ2c+YQGxmQW0JG78e8kE0sosIC2x/B8HSJhT
	wFRi+/I5YCWiAsoSB7YdZwJZJSHQzC7xYVo3I8SdkhIHV9xgmcAoMAvJ2FlIxs5CGLuAkXkV
	o1BmXlluYmaOiV5GZV5mhV5yfu4mRmAsLav9E72D8dOF4EOMAhyMSjy8GSKXUoVYE8uKK3MP
	MUpwMCuJ8Lo3XUgV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvE
	wSnVwOgYJnN0hcLanxc0VlRVtLNU1C15dvHHzN22J9IeOb123dAw865/xcud/3fbLYt7P7Fd
	/cV5wdCzt1muRy9K9j7deHrqKQ6Rz9tfvdwiV8P55b2JlFlCda33j7IPzIEn4xx5uZY+OpIW
	x7norMxKwd5bAp1NC+ZM2Hih6kBDhxlviNK6zFCGiBNKLMUZiYZazEXFiQD4jDXkoQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsXC5WfdrDt9x6VUg48vTS3mrF/DZnHp8VU2
	i+kvG1ksnk7Yymxxt38qi8XhuSdZLS7vmsNmcW/Nf1aLye+eMVpcOrCAyeLMtCKL470HmCz2
	dTxgsug48o3ZYuvR7+wO/B5r5q1h9GjZd4vdY8GmUo/NK7Q8Nn2axO5x59oeNo8TM36zeLzf
	d5XNY/GLD0wem09Xe3zeJBfAHcVlk5Kak1mWWqRvl8CVcXHCNZaCJaIVb77sYGlg3C3QxcjJ
	ISFgInHt2G02EJtFQFXiyv+vTCA2m4C6xI0bP5lBbBEBNYlprxrZuxi5OJgFTjFJTPh8Acjh
	4BAWiJQ49FYQpIZXwELi4qrVYHOEBLoZJQ7fy4GIC0qcnPmEBcRmFtCSuPHvJRNIK7OAtMTy
	fxwgYU4BU4nty+eAlYgKKEsc2HacaQIj7ywk3bOQdM9C6F7AyLyKUSQzryw3MTPHVK84O6My
	L7NCLzk/dxMjMDKW1f6ZuIPxy2X3Q4wCHIxKPLwZIpdShVgTy4orcw8xSnAwK4nwujddSBXi
	TUmsrEotyo8vKs1JLT7EKM3BoiTO6xWemiAkkJ5YkpqdmlqQWgSTZeLglGpgPLp7l8M5mfXp
	IfGRM3ac5/ojM5G9oDZHwO+ohfgEjZmev07L/F3i4CQkmanYnx30ri5w+u/NOSIMIXuDRQsO
	/N3DcmzhuuVFZ/k2vp26rEr99SuNE132K1uPbWwUvr4hSpHP4WjUtq1CDbn7L1m1a5qryQXe
	Vzi9XeUWf0pPb7uzX9/csy86lFiKMxINtZiLihMB7TxPFIgCAAA=
X-CFilter-Loop: Reflected

On Sun, Feb 18, 2024 at 08:46:16AM +0100, Oscar Salvador wrote:
> On Fri, Feb 16, 2024 at 02:51:24PM +0100, Oscar Salvador wrote:
> > On Fri, Feb 16, 2024 at 08:40:45PM +0900, Byungchul Park wrote:
> > > From 150af2f78e19217a1d03e47e3ee5279684590fb4 Mon Sep 17 00:00:00 2001
> > > From: Byungchul Park <byungchul@sk.com>
> > > Date: Fri, 16 Feb 2024 20:18:10 +0900
> > > Subject: [PATCH v3] sched/numa, mm: do not promote folios to nodes not set N_MEMORY
> > 
> > "do not try to promote folios to memoryless nodes"
> 
> Thinking some more, promote might be misleading, just something like
> "do not try to migrate memory to memoryless nodes".

Thank you. I will.

> As this is not a bug fix but an optimization, as we will fail anyways
> in migrate_misplaced_folio() when migrate_balanced_pgdat() notices that
> we do not have any memory on that code.
> 
> With the other comments addressed:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thank you for reviewing.

	Byungchul

> > because AFAICS we are just trying.
> > Even if should_numa_migrate_memory() returns true, I assume that we will
> > fail somewhere down the chain e.g: migrate_pages() when we see that this
> > node does not any memory, right?
> > 
> > > A numa node might not have its local memory but CPUs. Promoting a folio
> > > to the node's local memory is nonsense. So avoid nodes not set N_MEMORY
> > > from getting promoted.
> > 
> > If you talk about memoryless nodes everybody gets it better IMHO.
> > "Memoryless nodes do not have any memory to migrate to, so stop trying it."
> > 
> > 
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > ---
> > >  kernel/sched/fair.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index d7a3c63a2171..7ed9ef3c0134 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1828,6 +1828,13 @@ bool should_numa_migrate_memory(struct task_struct *p, struct folio *folio,
> > >  	int dst_nid = cpu_to_node(dst_cpu);
> > >  	int last_cpupid, this_cpupid;
> > >  
> > > +	/*
> > > +	 * A node of dst_nid might not have its local memory. Promoting
> > > +	 * a folio to the node is meaningless.
> > > +	 */
> > > +	if (!node_state(dst_nid, N_MEMORY))
> > > +		return false;
> > 
> > "Cannot migrate to memoryless nodes"
> > 
> > seems shorter and more clear.
> > 
> > So, what happens when we return true here? will we fail at
> > migrate_pages() I guess? That is quite down the road so I guess
> > this check can save us some time.
> > 
> > 
> > -- 
> > Oscar Salvador
> > SUSE Labs
> > 
> 
> -- 
> Oscar Salvador
> SUSE Labs

