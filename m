Return-Path: <linux-kernel+bounces-28250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7BC82FC22
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58671C277D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2603C225DB;
	Tue, 16 Jan 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk0o2h8q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F66224F1;
	Tue, 16 Jan 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705437141; cv=none; b=pNULw5yoJ6wOovdau7EfYCe8bLqEm5w5TJdybBt3TOJIr0nSDSMXoqnFUNWMlw0kF6sKohsdyODN9NruTB3cdaqkGWp3mSJ04hu4xQRiR2TujQYT8PJDG7X3YngRUVxH/T1nPuENv4xyrPV140VOehUBcX6A9Wvb1IbcVHnropQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705437141; c=relaxed/simple;
	bh=fbSbHCGZdIqKrTtsYQ+HM4Cx+vYRvPv2uj2nz5S32Xc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ilTcUIgB6fdVv5HAPkAiefgD8hu0FfU3EvFgAgqGbrrSDLu0kz5uU3KE23hSg7M7a2k5QsxfYz3X8FFJ5VUDUYLHube9ZR1w6HUGLg+QVpDliidY9TDvxy7m6La9fJUcMmeROVRSyMdNMNmKgpEdoikrxN+Ci3UOmSUFKMdsfxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk0o2h8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAD6C433F1;
	Tue, 16 Jan 2024 20:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705437140;
	bh=fbSbHCGZdIqKrTtsYQ+HM4Cx+vYRvPv2uj2nz5S32Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tk0o2h8qaHH9VmXQHLkFPxFE8v8yHhLECDu19LRURxf2oRckYCQ57Y9aGpE0Tt/qq
	 1Wxr8Vy+omPnundiZZ4QBCP71vl9UhdDETMGknqkWI6alkPyEQt08dVcSMaPFBRpal
	 3dAaFuiAjLqqRNZfdKPmkW/NFDSiUKAmDcn4sri3Z1SIaPH8Q8f4xDazE3d7pcD0lk
	 hOSzingWn4cHVf5Qg+cbhAdfgOcizvE5j/a19iDEi5Gd8biA/40s4d2y9s/GOjYrZV
	 dFglH3W3oG7eL7349bri7DoCoYBJkSuQhPfpq/fwKBJAVw17l7pQeAa3UXDzJqzU2/
	 R/coIsTvru/SA==
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
	ziy@nvidia.com
Subject: Re: [RFC PATCH 2/4] mm/damon: introduce DAMOS_DEMOTE action for demotion
Date: Tue, 16 Jan 2024 12:32:17 -0800
Message-Id: <20240116203217.52860-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115045253.1775-3-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 13:52:50 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This patch introduces DAMOS_DEMOTE action, which is similar to
> DAMOS_PAGEOUT, but demote folios instead of swapping them out.
> 
> Since there are some common routines with pageout, many functions have
> similar logics between pageout and demote.
> 
> The execution sequence of DAMOS_PAGEOUT and DAMOS_DEMOTE look as follows.
> 
>   DAMOS_PAGEOUT action
>     damo_pa_apply_scheme

Nit.  s/damo/damon/

>     -> damon_pa_reclaim
>     -> reclaim_pages
>     -> reclaim_folio_list
>     -> shrink_folio_list
> 
>   DAMOS_DEMOTE action
>     damo_pa_apply_scheme

Ditto.

>     -> damon_pa_reclaim
>     -> demote_pages
>     -> do_demote_folio_list
>     -> __demote_folio_list
>     -> demote_folio_list

I think implementation of 'demote_pages()' might better to be separated.

I'm also feeling the naming a bit strange, since I was usually thinking '__'
prefix is for functions that will internally used.  That is, I'd assume
__demote_folio_list() is called from demote_folio_list(), but this function is
doing in an opposite way.

> 
> __demote_folio_list() is a minimized version of shrink_folio_list(), but
> it's minified only for demotion.
> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  include/linux/damon.h    |  2 +
>  mm/damon/paddr.c         | 17 +++++---
>  mm/damon/sysfs-schemes.c |  1 +
>  mm/internal.h            |  1 +
>  mm/vmscan.c              | 84 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 99 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index e00ddf1ed39c..4c0a0fef09c5 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -106,6 +106,7 @@ struct damon_target {
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
>   * @DAMOS_STAT:		Do nothing but count the stat.
> + * @DAMOS_DEMOTE:	Do demotion for the current region.

I'd prefer defining DEMOTE before STAT, like we introduced LRU_PRIO/DEPRIO
after STAT but defined there.  It would help keeping the two different groups
of operations separated (STAT is different from other actions since it is not
for makeing real changes but only get statistics and monitoring results
querying).

>   * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
>   *
>   * The support of each action is up to running &struct damon_operations.
> @@ -123,6 +124,7 @@ enum damos_action {
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
> +	DAMOS_DEMOTE,

Ditto.

>  	NR_DAMOS_ACTIONS,
>  };
>  
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 081e2a325778..d3e3f077cd00 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -224,7 +224,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  	return false;
>  }
>  
> -static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
> +static unsigned long damon_pa_reclaim(struct damon_region *r, struct damos *s, bool is_demote)

I understand that reclamation could include both pageout and demotion, but not
sure if that is making its purpose clearer or more ambiguous.  What about
renaming to '..._demote_or_pageout()', like
'damon_pa_mark_accessed_or_deactivate()'?  Also, 'is_demote' could be simply
'demote'.

I think having a separate function, say, damon_pa_demote() is also ok, if it
makes code easier to read and not intorduce too much duplicated lines of code.

Also, I'd prefer keeping the 80 columns limit[1] by breaking this line.

[1] https://docs.kernel.org/process/coding-style.html?highlight=coding+style#breaking-long-lines-and-strings

>  {
>  	unsigned long addr, applied;
>  	LIST_HEAD(folio_list);
> @@ -242,14 +242,17 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
>  		folio_test_clear_young(folio);
>  		if (!folio_isolate_lru(folio))
>  			goto put_folio;
> -		if (folio_test_unevictable(folio))
> +		if (folio_test_unevictable(folio) && !is_demote)
>  			folio_putback_lru(folio);
>  		else
>  			list_add(&folio->lru, &folio_list);
>  put_folio:
>  		folio_put(folio);
>  	}
> -	applied = reclaim_pages(&folio_list);
> +	if (is_demote)
> +		applied = demote_pages(&folio_list);
> +	else
> +		applied = reclaim_pages(&folio_list);
>  	cond_resched();
>  	return applied * PAGE_SIZE;
>  }
> @@ -297,13 +300,15 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> -		return damon_pa_pageout(r, scheme);
> +		return damon_pa_reclaim(r, scheme, false);
>  	case DAMOS_LRU_PRIO:
>  		return damon_pa_mark_accessed(r, scheme);
>  	case DAMOS_LRU_DEPRIO:
>  		return damon_pa_deactivate_pages(r, scheme);
>  	case DAMOS_STAT:
>  		break;
> +	case DAMOS_DEMOTE:
> +		return damon_pa_reclaim(r, scheme, true);

I'd like to keep the order of the branches aligned with that of 'enum
damos_action'.

>  	default:
>  		/* DAMOS actions that not yet supported by 'paddr'. */
>  		break;
> @@ -317,11 +322,11 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
>  {
>  	switch (scheme->action) {
>  	case DAMOS_PAGEOUT:
> +	case DAMOS_LRU_DEPRIO:
> +	case DAMOS_DEMOTE:
>  		return damon_cold_score(context, r, scheme);
>  	case DAMOS_LRU_PRIO:
>  		return damon_hot_score(context, r, scheme);
> -	case DAMOS_LRU_DEPRIO:
> -		return damon_cold_score(context, r, scheme);

I'd slightly prefer having yet another dedicated 'case' branch for
DAMOS_DEMOTE, to keep the order same to that of 'enum damos_action', and the
old style.

>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index fe0fe2562000..ac7cd3f17b12 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1187,6 +1187,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
>  	"lru_prio",
>  	"lru_deprio",
>  	"stat",
> +	"demote",

If we define DEMOTE before STAT on enum damos_action, this would also need to
be updated.

>  };
>  
>  static struct damon_sysfs_scheme *damon_sysfs_scheme_alloc(
> diff --git a/mm/internal.h b/mm/internal.h
> index b61034bd50f5..2380397ec2f3 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -869,6 +869,7 @@ extern void set_pageblock_order(void);
>  unsigned long reclaim_pages(struct list_head *folio_list);
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *folio_list);
> +unsigned long demote_pages(struct list_head *folio_list);
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
>  #define ALLOC_WMARK_MIN		WMARK_MIN
>  #define ALLOC_WMARK_LOW		WMARK_LOW
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 7ca2396ccc3b..eaa3dd6b7562 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -998,6 +998,66 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
>  	return !data_race(folio_swap_flags(folio) & SWP_FS_OPS);
>  }
>  
> +/*
> + * __demote_folio_list() returns the number of demoted pages
> + */
> +static unsigned int __demote_folio_list(struct list_head *folio_list,
> +		struct pglist_data *pgdat, struct scan_control *sc)
> +{
> +	LIST_HEAD(ret_folios);
> +	LIST_HEAD(demote_folios);
> +	unsigned int nr_demoted = 0;
> +
> +	if (next_demotion_node(pgdat->node_id) == NUMA_NO_NODE)
> +		return 0;
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
> +		if (references == FOLIOREF_KEEP)
> +			goto keep_locked;
> +
> +		/* Relocate its contents to another node. */
> +		list_add(&folio->lru, &demote_folios);
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
> +	/* Migrate folios selected for demotion */
> +	nr_demoted += demote_folio_list(&demote_folios, pgdat);

As mentioned above, I was assuming demote_folio_list() would call
__demote_folio_list().  I think the name of this function might better to be
changed.

> +	/* Folios that could not be demoted are still in @demote_folios */
> +	if (!list_empty(&demote_folios)) {
> +		/* Folios which weren't demoted go back on @folio_list */
> +		list_splice_init(&demote_folios, folio_list);
> +	}
> +
> +	try_to_unmap_flush();
> +
> +	list_splice(&ret_folios, folio_list);
> +
> +	return nr_demoted;
> +}
> +
>  /*
>   * shrink_folio_list() returns the number of reclaimed pages
>   */
> @@ -2107,6 +2167,25 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
>  	return nr_reclaimed;
>  }
>  
> +static unsigned int do_demote_folio_list(struct list_head *folio_list,
> +				      struct pglist_data *pgdat)
> +{
> +	unsigned int nr_demoted;
> +	struct folio *folio;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +	};
> +
> +	nr_demoted = __demote_folio_list(folio_list, pgdat, &sc);
> +	while (!list_empty(folio_list)) {
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		folio_putback_lru(folio);
> +	}
> +
> +	return nr_demoted;
> +}
> +
>  static unsigned long reclaim_or_migrate_folios(struct list_head *folio_list,
>  		unsigned int (*handler)(struct list_head *, struct pglist_data *))
>  {
> @@ -2146,6 +2225,11 @@ unsigned long reclaim_pages(struct list_head *folio_list)
>  	return reclaim_or_migrate_folios(folio_list, reclaim_folio_list);
>  }
>  
> +unsigned long demote_pages(struct list_head *folio_list)
> +{
> +	return reclaim_or_migrate_folios(folio_list, do_demote_folio_list);
> +}
> +

If DAMON is the only user of this function and we have no plan for adding more
user of this function, I think implementing this in mm/damon/ might make sense.

>  static unsigned long shrink_list(enum lru_list lru, unsigned long nr_to_scan,
>  				 struct lruvec *lruvec, struct scan_control *sc)
>  {
> -- 
> 2.34.1

