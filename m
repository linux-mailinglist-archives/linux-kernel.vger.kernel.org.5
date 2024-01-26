Return-Path: <linux-kernel+bounces-40285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833C983DD9C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38FA6285888
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A01CFB2;
	Fri, 26 Jan 2024 15:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="RMa3qJcY"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEE14291
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283399; cv=none; b=sNXA5RWVyZDqnh1M5aacOvkF9iRaLWQkEDrOtvANBEzysAcDwXvt3sCy7sMvgp/ILi8VBHJzb2fi0NxG5tQhacrLACo3wfvR1ZxptBz6+caP4RSBF61M5yU2FekOPM4aGG6ENPjsHtoZyMWXTNm010XYlk3doilIDy9W0qNwKdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283399; c=relaxed/simple;
	bh=0y6Kdl6gERZbliqvotqbu3Jd+kehmkbJb5zBel8YvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heUajdEiA3zVTUvhqc19CojCoFT6i0w6faw0Heu0nL2A0GriaVqGS1VyoBIALapI+QPy5+ONqF8lcREFKD51CAsXF4Aq65DwhlH1ETBZ0uffhbFwKw2h4vVxY7+isqcGFKiqIPzvud+1SzxQ8uC/HtqsZTxdcUj/Hf2tEjc97HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=RMa3qJcY; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68009cb4669so4190446d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 07:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706283396; x=1706888196; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=40HIjsRE90WPdigsHQYMpGWAzm17UAtEILxbsGCcnt4=;
        b=RMa3qJcY4MBQxdlRe5JnlW7xg/XjkTh38AGL5bhe/QK8kyUy853rNWULD4KnbWkP62
         dMXuXx64ApYnvuw8O4VYscAK3HIHu1PvCel5WgABtMbtSIlr3/UoLR+SLaZK7smGJvh3
         zjIsIIeVYw8///hNqfvx9ZUBvlLanqc1fAOqJFEBsSAPElwqZyHlmYe5PJ2jBUxjiPEy
         ZT/F9Nhu67MRl/rOXr+EbGjXi/Aqo4COQrmkmTnF7GfXinTVxi6qbZx5JGxdh/xlQttc
         ZfHYcglbULRz/05yPJmTjujlZgNR459AyY7erKN6MojCx1dq4q7ie/dVl5ohWH8l4FXR
         qWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283396; x=1706888196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40HIjsRE90WPdigsHQYMpGWAzm17UAtEILxbsGCcnt4=;
        b=TzvrWbQVS+XUPXdFmQ6d/9FLI73/8kxYoFwKs6Fzvv1wUvnfkGz42lIjsa4Mc1eGsA
         GSAxhAJtyH2obWLLQ4dbTRnmlJSKeARg05f08yLe2lwtky6A/uf2fJZGHQgaHkryccAC
         mVQrI1ETIPHeyHyRFH1dAqX+P4mnvnUgrpCczVl1BJBaF2YrV4GqfOFiKQlC4wIeJxGP
         zWVURVtCjsqvFI/nO/xuJfz6LWGrn1UPCLvbtzhj10yDF3uGsutfgYqkaKha9l3wT+On
         Hnankj87T83VZmwEpM8GI9bmUbfLB5Cx6AvHqv8X+wL2HX4Lx14CqhFBWDI6vrPVJRoZ
         YEUw==
X-Gm-Message-State: AOJu0Yy7wZblKL13cJMcetpdX3nxT9iVzigmnikjgXFa4Z9WkOeBKp7e
	BOM7gASNoSmsivWNulRxZCwGKX84oxJ+V3KF+VMUt4C67dzHuAEp548ktkpVBJ0=
X-Google-Smtp-Source: AGHT+IE4l7qby0RiD2Bq+7xwdlqH0jPzUiOjKPdkjQnUm36zYubYHz3g3qI6S6OKcci/vdm7fr3J4w==
X-Received: by 2002:ad4:5ba5:0:b0:686:ac69:d0fa with SMTP id 5-20020ad45ba5000000b00686ac69d0famr8133qvq.126.1706283395970;
        Fri, 26 Jan 2024 07:36:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:271e])
        by smtp.gmail.com with ESMTPSA id on6-20020a056214448600b006819a4354basm601263qvb.37.2024.01.26.07.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:36:35 -0800 (PST)
Date: Fri, 26 Jan 2024 10:36:34 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: memcg: optimize parent iteration in
 memcg_rstat_updated()
Message-ID: <20240126153634.GH1567330@cmpxchg.org>
References: <20240124100023.660032-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124100023.660032-1-yosryahmed@google.com>

On Wed, Jan 24, 2024 at 10:00:22AM +0000, Yosry Ahmed wrote:
> In memcg_rstat_updated(), we iterate the memcg being updated and its
> parents to update memcg->vmstats_percpu->stats_updates in the fast path
> (i.e. no atomic updates). According to my math, this is 3 memory loads
> (and potentially 3 cache misses) per memcg:
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
> - Load the address of the parent memcg.
> 
> Avoid most of the cache misses by caching a pointer from each struct
> memcg_vmstats_percpu to its parent on the corresponding CPU. In this
> case, for the first memcg we have 2 memory loads (same as above):
> - Load the address of memcg->vmstats_percpu.
> - Load vmstats_percpu->stats_updates (based on some percpu calculation).
> 
> Then for each additional memcg, we need a single load to get the
> parent's stats_updates directly. This reduces the number of loads from
> O(3N) to O(2+N) -- where N is the number of memcgs we need to iterate.
> 
> Additionally, stash a pointer to memcg->vmstats in each struct
> memcg_vmstats_percpu such that we can access the atomic counter that all
> CPUs fold into, memcg->vmstats->stats_updates.
> memcg_should_flush_stats() is changed to memcg_vmstats_needs_flush() to
> accept a struct memcg_vmstats pointer accordingly.
> 
> In struct memcg_vmstats_percpu, make sure both pointers together with
> stats_updates live on the same cacheline. Finally, update
> mem_cgroup_alloc() to take in a parent pointer and initialize the new
> cache pointers on each CPU. The percpu loop in mem_cgroup_alloc() may
> look concerning, but there are multiple similar loops in the cgroup
> creation path (e.g. cgroup_rstat_init()), most of which are hidden
> within alloc_percpu().
> 
> According to Oliver's testing [1], this fixes multiple 30-38%
> regressions in vm-scalability, will-it-scale-tlb_flush2, and
> will-it-scale-fallocate1. This comes at a cost of 2 more pointers per
> CPU (<2KB on a machine with 128 CPUs).
> 
> [1] https://lore.kernel.org/lkml/ZbDJsfsZt2ITyo61@xsang-OptiPlex-9020/
> 
> Fixes: 8d59d2214c23 ("mm: memcg: make stats flushing threshold per-memcg")
> Tested-by: kernel test robot <oliver.sang@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202401221624.cb53a8ca-oliver.sang@intel.com
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Nice!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

