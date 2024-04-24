Return-Path: <linux-kernel+bounces-157627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BF98B13C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBFE28831F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBB613B582;
	Wed, 24 Apr 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ul/oMFKP"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD6139CEE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713988218; cv=none; b=GsBUj05dKUYmBqdwTLvLFNjKgHDOXHbdTUjBp8xhKO4/JJtNbt9MObNdeE2b1g67EbEmQvVpqfhSDeZBevU/qXWnqKY09h55Ips7iBhmlSJE7iIV3ZjhT1Fz37Df5iY7EILaableeobxdJKAonQ0Rb3muobPCqC+eO/9MuVQk2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713988218; c=relaxed/simple;
	bh=ty3ip0sNPfKUE4Qqy3CsV/iJ4rBvAvrZqSfPSwTYlRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdJT5C/2Q/kk/+EoI4XAh7U2PjJ0Vwjuqyu2ASwSK/PD6Mvh4rUMvrx/zm9DzpFxgBeSxkUCe/voN5sEeUhE8X80m9gJSLflt9vydWo2PoW+nJ+hjWmIwfu7TQ8NAMceFGlDxpjMhEAzQBdjirp/piDhjAlT2aFuct69sRpjPAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ul/oMFKP; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Apr 2024 12:50:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713988213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk4Hjf7MO1vgoycrQr13hwP52DhwjBNF8O6idPkuyDo=;
	b=Ul/oMFKP3dKHsGVy/pJ1kPeMNR7LtzOTJ2czKmpnMyMG72gr6xDzmIAzTSaYAyofYcQXAX
	Bo1J72cDI101j1Z57LZ9MfLIN5KasMGqH9Ueaav5Ib+QH6C9DYq4GHiMcd9Kf4csLE6Fja
	NU9Kyf9zCpqkm3UrQtUYh90eO8Yq0Cc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Breno Leitao <leitao@debian.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, leit@meta.com, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: Fix data-race KCSAN bug in rstats
Message-ID: <dd6awhn7caxnctqluenr5gwll5yiea667awbxkqe4etjd5qdqj@6wndcuobiodg>
References: <20240424125940.2410718-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424125940.2410718-1-leitao@debian.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 24, 2024 at 05:59:39AM -0700, Breno Leitao wrote:
> A data-race issue in memcg rstat occurs when two distinct code paths
> access the same 4-byte region concurrently. KCSAN detection triggers the
> following BUG as a result.
> 
> 	BUG: KCSAN: data-race in __count_memcg_events / mem_cgroup_css_rstat_flush
> 
> 	write to 0xffffe8ffff98e300 of 4 bytes by task 5274 on cpu 17:
> 	mem_cgroup_css_rstat_flush (mm/memcontrol.c:5850)
> 	cgroup_rstat_flush_locked (kernel/cgroup/rstat.c:243 (discriminator 7))
> 	cgroup_rstat_flush (./include/linux/spinlock.h:401 kernel/cgroup/rstat.c:278)
> 	mem_cgroup_flush_stats.part.0 (mm/memcontrol.c:767)
> 	memory_numa_stat_show (mm/memcontrol.c:6911)
> <snip>
> 
> 	read to 0xffffe8ffff98e300 of 4 bytes by task 410848 on cpu 27:
> 	__count_memcg_events (mm/memcontrol.c:725 mm/memcontrol.c:962)
> 	count_memcg_event_mm.part.0 (./include/linux/memcontrol.h:1097 ./include/linux/memcontrol.h:1120)
> 	handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622)
> <snip>
> 
> 	value changed: 0x00000029 -> 0x00000000
> 
> The race occurs because two code paths access the same "stats_updates"
> location. Although "stats_updates" is a per-CPU variable, it is remotely
> accessed by another CPU at
> cgroup_rstat_flush_locked()->mem_cgroup_css_rstat_flush(), leading to
> the data race mentioned.
> 
> Considering that memcg_rstat_updated() is in the hot code path, adding
> a lock to protect it may not be desirable, especially since this
> variable pertains solely to statistics.
> 
> Therefore, annotating accesses to stats_updates with READ/WRITE_ONCE()
> can prevent KCSAN splats and potential partial reads/writes.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

