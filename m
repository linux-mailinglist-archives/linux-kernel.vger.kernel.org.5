Return-Path: <linux-kernel+bounces-165836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A88B9233
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23771F225B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE141168AF8;
	Wed,  1 May 2024 23:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S0228WRJ"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF0A165FAA
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714605654; cv=none; b=FXP4r8vM/0G/B9BjgNuTZ9foexmPtyvoctcF6tsxbWlqTXUG67g8QtD/IkBbl/iq8JPotIiFQbQuCqxnXk0/N46JREjqfcRCUmd5kjAewufuspO3WvdrTpQMRL+lfxmed4Ojncs4RsJBXxHoQK+1F0bHoURtc3z97ro08niwj58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714605654; c=relaxed/simple;
	bh=KkRajjlS8HkWbirozFoOcw7AxOnIYrAjP74llWm5fr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICIavqeTX1JrcYq/KUH2XhPadYaCwQ5gtV2V6LGm9DKOkPm9Khmbo/10beqIWZn2EhpGHwtdivzyMVkaT7sSn8ux9RQNxNSBnvcdT4OKf7Rdzgd6JHu8Nozo4E+wILaxP7eD3U1/9P8Om5Dkt0wOn1K7GcXblVs10e6YIPx76Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S0228WRJ; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 1 May 2024 16:20:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714605650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xQGvBTiKc/Smn7PsXZR4CxTZ3TuKVJXHLFhqIG/ZgXI=;
	b=S0228WRJ4hUXgrkaTPHAYSlfCkqUGGRa6LGZ27deiYvlP+6Wno6frVJeBzRJVNvaNmh0HU
	VEnYsj1h2SPc4qy3jvzRTuy14Yoz8xcdwamTdF0DMjhLOh/KWXO8QWBfjnXdyFzyNYXZPI
	i2+rsSTGdNDl+Lv0CXM+QTEoimO53ew=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>, kernel-team@meta.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] memcg: reduce memory for the lruvec and memcg
 stats
Message-ID: <ZjLOTXEr6XoXf6_g@P9FQF9L96D>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
 <20240501172617.678560-5-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501172617.678560-5-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, May 01, 2024 at 10:26:13AM -0700, Shakeel Butt wrote:
> At the moment, the amount of memory allocated for stats related structs
> in the mem_cgroup corresponds to the size of enum node_stat_item.
> However not all fields in enum node_stat_item have corresponding memcg
> stats. So, let's use indirection mechanism similar to the one used for
> memcg vmstats management.
> 
> For a given x86_64 config, the size of stats with and without patch is:
> 
> structs size in bytes         w/o     with
> 
> struct lruvec_stats           1128     648
> struct lruvec_stats_percpu     752     432
> struct memcg_vmstats          1832    1352
> struct memcg_vmstats_percpu   1280     960
> 
> The memory savings is further compounded by the fact that these structs
> are allocated for each cpu and for each node. To be precise, for each
> memcg the memory saved would be:
> 
> Memory saved = ((21 * 3 * NR_NODES) + (21 * 2 * NR_NODES * NR_CPUS) +
> 	       (21 * 3) + (21 * 2 * NR_CPUS)) * sizeof(long)
> 
> Where 21 is the number of fields eliminated.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

