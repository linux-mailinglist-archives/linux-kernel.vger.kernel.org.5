Return-Path: <linux-kernel+bounces-133519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C91F89A4CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24383B23E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FED9172BBC;
	Fri,  5 Apr 2024 19:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU31alp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0CE171E5C;
	Fri,  5 Apr 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712344813; cv=none; b=EsLll5o5AcuHLk/WKezL0boTRrD58VO2zEybVdl5S+91ct7ybU45m4I+QwICAPFG10UPKsJc8ewVZ48861cTvBxmX4eQu6Qb8qaWlAyScexNek/k48gzlqcy9WLHBqB9Dq+tCfTFiU2NhgZ5U6j6t1W/GKi8XMtxFVepJI/ShCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712344813; c=relaxed/simple;
	bh=cVmiwv55exbPqh0GegYGrO5Eff/8w7HZ4re9a7wW9/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OUWuO31rNYeqbSyFGLki+1BaP8qD+IhXdcm/z5o19IG6RlXnd5mHd3Af/nsTs1Ph/j260uqnHkyX5+G7ukIUPpjNbCjNJyo0zJ+q/BUZV6yKFDIyq0ACZFd4fIaESYrL4glAN5ukCmoxk6Im7WKCHfV2XM2b9XJXgvYqpRi7TK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU31alp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715E5C433F1;
	Fri,  5 Apr 2024 19:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712344813;
	bh=cVmiwv55exbPqh0GegYGrO5Eff/8w7HZ4re9a7wW9/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gU31alp4j+80K0uxaCifhSjrPBNRADPRlC5pu1dKcE0Va2za4o+aFzs6wJBlIkFX/
	 zVfU8YfYa91W4yeSwgebn8ylEGGZLy/CKFhPayqs6fqCKL2ZJzBiU6pkXLJrr+N1wC
	 Ab0fP9odklmC6N178SqR/OUp4CpQ8GLRY+eDBaqAte62fUHvnNjNL1kc3FuqHkHTUb
	 bN6DwxMgyG5A+HQeeil2JhKziQIlLwQjYqIDtb+r2z90J1seTS8MRTbOwBqscuGRZa
	 mY3aBg2N/kwO5iF1G2Lg5rlT2SLHBRuzlNPLgmL9TdoC9bGmWc10qgtv+xcZAshwa+
	 DiBR5LBDgVVBg==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v3 2/7] mm: make alloc_demote_folio externally invokable for migration
Date: Fri,  5 Apr 2024 12:20:10 -0700
Message-Id: <20240405192010.66986-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-3-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:51 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> The alloc_demote_folio can be used out of vmscan.c so it'd be better to
> remove static keyword from it.
> 
> This function can also be used for both demotion and promotion so it'd
> be better to rename it from alloc_demote_folio to alloc_migrate_folio.

I'm not sure if renaming is really needed, but has no strong opinion.

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>

I have one more trivial comment below, but finds no blocker for me.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  mm/internal.h |  1 +
>  mm/vmscan.c   | 10 +++++++---
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index f309a010d50f..c96ff9bc82d0 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -866,6 +866,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
>          unsigned long, unsigned long);
>  
>  extern void set_pageblock_order(void);
> +struct folio *alloc_migrate_folio(struct folio *src, unsigned long private);
>  unsigned long reclaim_pages(struct list_head *folio_list);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *folio_list);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4255619a1a31..9e456cac03b4 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -910,8 +910,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>  }
>  
> -static struct folio *alloc_demote_folio(struct folio *src,
> -		unsigned long private)
> +struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
>  {
>  	struct folio *dst;
>  	nodemask_t *allowed_mask;
> @@ -935,6 +934,11 @@ static struct folio *alloc_demote_folio(struct folio *src,
>  	if (dst)
>  		return dst;
>  
> +	/*
> +	 * Allocation failed from the target node so try to allocate from
> +	 * fallback nodes based on allowed_mask.
> +	 * See fallback_alloc() at mm/slab.c.
> +	 */

I think this might better to be a separate cleanup patch, but given its small
size, I have no strong opinion.

>  	mtc->gfp_mask &= ~__GFP_THISNODE;
>  	mtc->nmask = allowed_mask;
>  
> @@ -973,7 +977,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	node_get_allowed_targets(pgdat, &allowed_mask);
>  
>  	/* Demotion ignores all cpuset and mempolicy settings */
> -	migrate_pages(demote_folios, alloc_demote_folio, NULL,
> +	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
>  		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>  		      &nr_succeeded);
>  
> -- 
> 2.34.1


Thanks,
SJ

