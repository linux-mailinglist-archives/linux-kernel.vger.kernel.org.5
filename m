Return-Path: <linux-kernel+bounces-155700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2796B8AF5C7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A4B22C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3AA13DDD4;
	Tue, 23 Apr 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="svG1WfsP"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A913CA97
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713894256; cv=none; b=tOt1ajjH4wGaK9Y5c7MuqiAlp3Xy6HF0M11bi9u4RPFnjgfeDws/5GHVT0pml1mbVySxoHTWy5Uny3S8DnFUqrV4fGZXs9aS0tFSyl3XMgxpeJiarCt9yZCxu/B0Z3oPpBq9ZDwoLwFQ4gcBmnjxur0Hghi7C+7fnTEjnjEf9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713894256; c=relaxed/simple;
	bh=ozqaaLGrbKl2wKyOSOrW2AyxeiLcZ2F8MuXkZ1yJ2+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JINrNvsD/N/mmyRYBEgusEWSorwvmI3uc4DXePgKT3nrTfJZooi45Zx0c0NjiDhrlBT1hxC3DXAJ2m09CS5OlqRVTDUYzEQmvulGXdyXCpmev2ld9vbqSDdvzWBLqk+aYkNpKrcw35Cbt54SMh90XQV2vNhEfGgLBK/dyU4KXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=svG1WfsP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 23 Apr 2024 10:44:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713894252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0umvTxHpcw152hw4GNh+8AkQo7OLhcip+cLOCx1NbGs=;
	b=svG1WfsPjl+c6V/lE4Win9SUPatCmd83Kj4ieN9i6nN+1YS8YRtaV6beXQbnFEzx4D8w8Q
	jn6qC9uOmtMyTzE3TMd1dwUa0fmck+x2iNyWdEw9X8z3olK3LPuj9KTWJ5Ff4OBeig89k9
	hXBEJohiG4HWeOiGMW+bosjdY6OdRhA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: rearrange node_stat_item to put memcg stats at
 start
Message-ID: <cupqywok4kl3cxotmpnfrlcsxhkaj7lbo6viehvxlltv3qkt7g@nxxplmgbcfyi>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
 <20240423051826.791934-2-shakeel.butt@linux.dev>
 <20240423135844.GA21141@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423135844.GA21141@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 23, 2024 at 09:58:44AM -0400, Johannes Weiner wrote:
> On Mon, Apr 22, 2024 at 10:18:23PM -0700, Shakeel Butt wrote:
> > At the moment the memcg stats are sized based on the size of enum
> > node_stat_item but not all fields in node_stat_item corresponds to memcg
> > stats. So, rearrage the contents of node_stat_item such that all the
> > memcg specific stats are at the top and then the later patches will make
> > sure that the memcg code will not waste space for non-memcg stats.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> This series is a great idea and the savings speak for themselves.
> 
> But rearranging and splitting vmstats along the memcg-nomemcg line
> seems like an undue burden on the non-memcg codebase and interface.
> 
> - It messes with user-visible /proc/vmstat ordering, and sets things
>   up to do so on an ongoing basis as stats are added to memcg.
> 
> - It also separates related stats (like the workingset ones) in
>   /proc/vmstat when memcg only accounts a subset.
> 
> Would it make more sense to have a translation table inside memcg?
> Like we have with memcg1_events.

Thanks for taking a look. I will look into the translation table
approach. The reason I went with this approach was that I am in parallel
looking into rearranging fields of important MM structs and also enums
to improve cache locality. For example, the field NR_SWAPCACHE is always
accessed together with NR_FILE_PAGES, so it makes sense to have them on
same cacheline. So, is the rearrangement of vmstats a big NO or a little
bit here and there is fine unlike what I did with this patch?

thanks,
Shakeel

