Return-Path: <linux-kernel+bounces-28252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D412082FC43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2982DB2A0F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BD22EFD;
	Tue, 16 Jan 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIPatRbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE022EF8;
	Tue, 16 Jan 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437155; cv=none; b=rnCHkqTYQkYdqfjb5P9/AikTeZqhELfHgjgnY+WN42BOAM7jGAUkUi8RGAgYK9CWynj/PwyZi9AMUMQM9IBYz3vGYIh/3hEmmEXT4H2z9Vgez1KijPvg8vHPUHvgPINOSIp3XR77rNzcIiBjKH0fJdtdgZ9Jf/QGogDh1BT8540=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437155; c=relaxed/simple;
	bh=P+kmQSxhZgr4dg4PgekC+SHUzy7heDMGuWouVasimHk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=n9rKkbfnYaWa+x7Gt8rFup3Jg4fYJIaP61Z8Tbwqi3CbZvBQ833jbdIjQRI9rI2TUG60WEMOQO2DTrAIO5VmN570nkqoe//90PJe1RH5OuUHNqkJkWW00Aum8MjUnKD9wdhFyEBdU/h3nixN4n2ukoa8vuara+uhoUwlEBi8pp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIPatRbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCB2C433C7;
	Tue, 16 Jan 2024 20:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705437155;
	bh=P+kmQSxhZgr4dg4PgekC+SHUzy7heDMGuWouVasimHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZIPatRbIvA6bZ9bUbLXecMGket7gW6LedJSUyIibZq9SJQ8v72WMwLx/qrfujPyXE
	 8mZl1t6y5pFaQALvExfkuK2OZ0MWCox3Ylw8nTnOs2/FBuCbtnJTbzw26ZHfSA8iY2
	 FlvRXjRiyBDw2oSbg+mR4w15TTbwXXfj0XtxhSBpKurR9oLfDb/cHrRyQwEz5PiwA8
	 edIwgrjppDq93BHPlCXU09S3mPVwMEuBf0xW929x5jsdDmkSYWmmhdFfAHJ0mqc8sY
	 jWKLNg8XVG9VwBfxWeA8o2aumUISJUev5ianH5OxIObzJgh1CqTYWOmUmjcTCRLJtm
	 EhV5WTKZTqD8Q==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	linmiaohe@huawei.com,
	lizhijian@cn.fujitsu.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	Hyeongtak Ji <hyeongtak.ji@sk.com>
Subject: Re: [RFC PATCH 4/4] mm/damon: introduce DAMOS_PROMOTE action for promotion
Date: Tue, 16 Jan 2024 12:32:30 -0800
Message-Id: <20240116203231.52894-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115045253.1775-5-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 13:52:52 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> From: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> This patch introduces DAMOS_PROMOTE action for paddr mode.
> 
> It includes renaming alloc_demote_folio to alloc_migrate_folio to use it
> for promotion as well.
> 
> The execution sequence of DAMOS_DEMOTE and DAMOS_PROMOTE look as
> follows for comparison.
> 
>   DAMOS_DEMOTE action
>     damo_pa_apply_scheme
>     -> damon_pa_reclaim
>     -> demote_pages
>     -> do_demote_folio_list
>     -> __demote_folio_list
>     -> demote_folio_list
> 
>   DAMOS_PROMOTE action
>     damo_pa_apply_scheme
>     -> damon_pa_promote
>     -> promote_pages
>     -> do_promote_folio_list
>     -> __promote_folio_list
>     -> promote_folio_list
> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  include/linux/damon.h          |   2 +
>  include/linux/migrate_mode.h   |   1 +
>  include/linux/vm_event_item.h  |   1 +
>  include/trace/events/migrate.h |   3 +-
>  mm/damon/paddr.c               |  29 ++++++++
>  mm/damon/sysfs-schemes.c       |   1 +
>  mm/internal.h                  |   1 +
>  mm/vmscan.c                    | 129 ++++++++++++++++++++++++++++++++-
>  mm/vmstat.c                    |   1 +
>  9 files changed, 165 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 4c0a0fef09c5..477060bb6718 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -107,6 +107,7 @@ struct damon_target {
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
>   * @DAMOS_STAT:		Do nothing but count the stat.
>   * @DAMOS_DEMOTE:	Do demotion for the current region.
> + * @DAMOS_PROMOTE:	Do promotion if possible, otherwise do nothing.

Like LRU_PRIO is defined before LRU_DEPRIO, what about defining PROMOTE before
DEMOTE?

>   * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
>   *
>   * The support of each action is up to running &struct damon_operations.
> @@ -125,6 +126,7 @@ enum damos_action {
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>  	DAMOS_DEMOTE,
> +	DAMOS_PROMOTE,
>  	NR_DAMOS_ACTIONS,
>  };
>  
> diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
> index f37cc03f9369..63f75eb9abf3 100644
> --- a/include/linux/migrate_mode.h
> +++ b/include/linux/migrate_mode.h
> @@ -29,6 +29,7 @@ enum migrate_reason {
>  	MR_CONTIG_RANGE,
>  	MR_LONGTERM_PIN,
>  	MR_DEMOTION,
> +	MR_PROMOTION,
>  	MR_TYPES
>  };
>  
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 8abfa1240040..63cf920afeaa 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -44,6 +44,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		PGDEMOTE_KSWAPD,
>  		PGDEMOTE_DIRECT,
>  		PGDEMOTE_KHUGEPAGED,
> +		PGPROMOTE,
>  		PGSCAN_KSWAPD,
>  		PGSCAN_DIRECT,
>  		PGSCAN_KHUGEPAGED,
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 0190ef725b43..f0dd569c1e62 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -22,7 +22,8 @@
>  	EM( MR_NUMA_MISPLACED,	"numa_misplaced")		\
>  	EM( MR_CONTIG_RANGE,	"contig_range")			\
>  	EM( MR_LONGTERM_PIN,	"longterm_pin")			\
> -	EMe(MR_DEMOTION,	"demotion")
> +	EM( MR_DEMOTION,	"demotion")			\
> +	EMe(MR_PROMOTION,	"promotion")
>  
>  /*
>   * First define the enums in the above macros to be exported to userspace
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index d3e3f077cd00..360ce69d5898 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -257,6 +257,32 @@ static unsigned long damon_pa_reclaim(struct damon_region *r, struct damos *s, b
>  	return applied * PAGE_SIZE;
>  }
>  
> +static unsigned long damon_pa_promote(struct damon_region *r, struct damos *s)
> +{
> +	unsigned long addr, applied;
> +	LIST_HEAD(folio_list);
> +
> +	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
> +		struct folio *folio = damon_get_folio(PHYS_PFN(addr));
> +
> +		if (!folio)
> +			continue;
> +
> +		if (damos_pa_filter_out(s, folio))
> +			goto put_folio;
> +
> +		if (!folio_isolate_lru(folio))
> +			goto put_folio;
> +
> +		list_add(&folio->lru, &folio_list);
> +put_folio:
> +		folio_put(folio);
> +	}
> +	applied = promote_pages(&folio_list);
> +	cond_resched();
> +	return applied * PAGE_SIZE;
> +}
> +
>  static inline unsigned long damon_pa_mark_accessed_or_deactivate(
>  		struct damon_region *r, struct damos *s, bool mark_accessed)
>  {
> @@ -309,6 +335,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  		break;
>  	case DAMOS_DEMOTE:
>  		return damon_pa_reclaim(r, scheme, true);
> +	case DAMOS_PROMOTE:
> +		return damon_pa_promote(r, scheme);
>  	default:
>  		/* DAMOS actions that not yet supported by 'paddr'. */
>  		break;
> @@ -326,6 +354,7 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
>  	case DAMOS_DEMOTE:
>  		return damon_cold_score(context, r, scheme);
>  	case DAMOS_LRU_PRIO:
> +	case DAMOS_PROMOTE:
>  		return damon_hot_score(context, r, scheme);

As mentioned on the previous patch, I'd prefer keeping the order of operations
and having dedicated branches for each operation.

>  	default:
>  		break;
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index ac7cd3f17b12..1b84d0af7e1f 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1188,6 +1188,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
>  	"lru_deprio",
>  	"stat",
>  	"demote",
> +	"promote",
>  };
>  
>  static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
> diff --git a/mm/internal.h b/mm/internal.h
> index 2380397ec2f3..f159455e63d4 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -870,6 +870,7 @@ unsigned long reclaim_pages(struct list_head *folio_list);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *folio_list);
>  unsigned long demote_pages(struct list_head *folio_list);
> +unsigned long promote_pages(struct list_head *folio_list);
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
>  #define ALLOC_WMARK_MIN		WMARK_MIN
>  #define ALLOC_WMARK_LOW		WMARK_LOW
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eaa3dd6b7562..f03be320f9ad 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -910,7 +910,7 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>  }
>  
> -static struct folio *alloc_demote_folio(struct folio *src,
> +static struct folio *alloc_migrate_folio(struct folio *src,
>  		unsigned long private)

As also mentioned on the previous patch, I'm unsure if vmscan.c is the right
place for general migration.

>  {
>  	struct folio *dst;
> @@ -973,7 +973,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	node_get_allowed_targets(pgdat, &allowed_mask);
>  
>  	/* Demotion ignores all cpuset and mempolicy settings */
> -	migrate_pages(demote_folios, alloc_demote_folio, NULL,
> +	migrate_pages(demote_folios, alloc_migrate_folio, NULL,
>  		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>  		      &nr_succeeded);
>  
> @@ -982,6 +982,48 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	return nr_succeeded;
>  }
>  
> +/*
> + * Take folios on @promote_folios and attempt to promote them to another node.
> + * Folios which are not promoted are left on @promote_folios.
> + */
> +static unsigned int promote_folio_list(struct list_head *promote_folios,
> +				     struct pglist_data *pgdat)
> +{
> +	int target_nid = next_promotion_node(pgdat->node_id);
> +	unsigned int nr_succeeded;
> +	nodemask_t allowed_mask = NODE_MASK_NONE;
> +
> +	struct migration_target_control mtc = {
> +		/*
> +		 * Allocate from 'node', or fail quickly and quietly.
> +		 * When this happens, 'page' will likely be stayed
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid = target_nid,
> +		.nmask = &allowed_mask
> +	};
> +
> +	if (pgdat->node_id == target_nid)
> +		return 0;
> +
> +	if (list_empty(promote_folios))
> +		return 0;
> +
> +	if (target_nid == NUMA_NO_NODE)
> +		return 0;
> +
> +	/* Promotion ignores all cpuset and mempolicy settings */
> +	migrate_pages(promote_folios, alloc_migrate_folio, NULL,
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_PROMOTION,
> +		      &nr_succeeded);
> +
> +	__count_vm_events(PGPROMOTE, nr_succeeded);
> +
> +	return nr_succeeded;
> +}
> +
>  static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
>  {
>  	if (gfp_mask & __GFP_FS)
> @@ -1058,6 +1100,65 @@ static unsigned int __demote_folio_list(struct list_head *folio_list,
>  	return nr_demoted;
>  }
>  
> +/*
> + * __promote_folio_list() returns the number of promoted pages
> + */
> +static unsigned int __promote_folio_list(struct list_head *folio_list,
> +		struct pglist_data *pgdat, struct scan_control *sc)
> +{
> +	LIST_HEAD(ret_folios);
> +	LIST_HEAD(promote_folios);
> +	unsigned int nr_promoted = 0;
> +
> +	cond_resched();
> +
> +	while (!list_empty(folio_list)) {
> +		struct folio *folio;
> +		enum folio_references references;
> +
> +		cond_resched();
> +
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +
> +		if (!folio_trylock(folio))
> +			goto keep;
> +
> +		VM_BUG_ON_FOLIO(folio_test_active(folio), folio);
> +
> +		references = folio_check_references(folio, sc);
> +		if (references == FOLIOREF_KEEP ||
> +		    references == FOLIOREF_RECLAIM ||
> +		    references == FOLIOREF_RECLAIM_CLEAN)
> +			goto keep_locked;
> +
> +		/* Relocate its contents to another node. */
> +		list_add(&folio->lru, &promote_folios);
> +		folio_unlock(folio);
> +		continue;
> +keep_locked:
> +		folio_unlock(folio);
> +keep:
> +		list_add(&folio->lru, &ret_folios);
> +		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
> +	}
> +	/* 'folio_list' is always empty here */
> +
> +	/* Migrate folios selected for promotion */
> +	nr_promoted += promote_folio_list(&promote_folios, pgdat);

Again as mentioned on the previous patch, I was thinking promote_folios_list()
may call __promote_folio_list().  Making the __ prefix usage consistent with
other functions might be better, in my opinion.

> +	/* Folios that could not be promoted are still in @promote_folios */
> +	if (!list_empty(&promote_folios)) {
> +		/* Folios which weren't promoted go back on @folio_list */
> +		list_splice_init(&promote_folios, folio_list);
> +	}
> +
> +	try_to_unmap_flush();
> +
> +	list_splice(&ret_folios, folio_list);
> +
> +	return nr_promoted;
> +}
> +
>  /*
>   * shrink_folio_list() returns the number of reclaimed pages
>   */
> @@ -2186,6 +2287,25 @@ static unsigned int do_demote_folio_list(struct list_head *folio_list,
>  	return nr_demoted;
>  }
>  
> +static unsigned int do_promote_folio_list(struct list_head *folio_list,
> +				      struct pglist_data *pgdat)
> +{
> +	unsigned int nr_promoted;
> +	struct folio *folio;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +
> +	nr_promoted = __promote_folio_list(folio_list, pgdat, &sc);
> +	while (!list_empty(folio_list)) {
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		folio_putback_lru(folio);
> +	}
> +
> +	return nr_promoted;
> +}
> +
>  static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
>  		unsigned int (*handler)(struct list_head *, struct pglist_data *))
>  {
> @@ -2230,6 +2350,11 @@ unsigned long demote_pages(struct list_head *folio_list)
>  	return reclaim_or_migrate_folios(folio_list, do_demote_folio_list);
>  }
>  
> +unsigned long promote_pages(struct list_head *folio_list)
> +{
> +	return reclaim_or_migrate_folios(folio_list, do_promote_folio_list);
> +}
> +
>  static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
>  				 struct lruvec *lruvec, struct scan_control *sc)
>  {
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 359460deb377..c703abdb8137 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1282,6 +1282,7 @@ const char * const vmstat_text[] = {
>  	"pgdemote_kswapd",
>  	"pgdemote_direct",
>  	"pgdemote_khugepaged",
> +	"pgpromote",
>  	"pgscan_kswapd",
>  	"pgscan_direct",
>  	"pgscan_khugepaged",
> -- 
> 2.34.1

