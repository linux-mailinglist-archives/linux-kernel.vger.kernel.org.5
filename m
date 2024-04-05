Return-Path: <linux-kernel+bounces-133523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC889A4D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87541F21BF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE265171E5C;
	Fri,  5 Apr 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR+VcNdg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0DA17333B;
	Fri,  5 Apr 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345074; cv=none; b=hIcMUmF/eBHP0G1N0ULG3b2IpB/0J/F8zqkxYo7KoD/Zmo0A00mdm494+fBlMKzUzQcwFqI/JFhOzfhy3v7RehrlTwF2IkDkYWuD53uOsTyFQ7kcSFjqxQxa8oV0a5U1S4wwZNLNEVz+QCExPN8/BpeNNyEiw0cmOXIgOizNTj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345074; c=relaxed/simple;
	bh=7Mbohb2PnIjKDOURjZWTah5t3XbklnbosNUeRIFGz4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M8qnoLBeEqLoUztWkTbATHgxM+/4mc6pq7iq52Zy+avxSa5fSgNRHe660F7veZSNF7gnrBnl4iJA/eLDOQjhdy77Bl0EH7tJbHKAO/Dwd1VRBODwW6kGZagNxnifnEzg9y7f59tnckbNTgeQuLiQ0X3enUTgWZvbTOOkVYjlQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR+VcNdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CFEC43394;
	Fri,  5 Apr 2024 19:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712345074;
	bh=7Mbohb2PnIjKDOURjZWTah5t3XbklnbosNUeRIFGz4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NR+VcNdgAf6+Az65Dpo83Pzxrcf/6sgCq/1MDhK9Ams23qy3mhgWhQFiVZx5Er77D
	 PVxu2BpmzMmuBfZqJdv+13uP3y/rVk40xQpK4Z8pReX+xzUEwZcZb+B1+cMqQh7HYi
	 fnzWgw2qZbDFTvkBtVgHVnpUws9c+qtZVPhwtu7wKxLvMGeetWM7LbbFzJQeD9pTL8
	 ex/5sDj8STqau0eefSQ5hwwHInRc3KN0wO1gye29r4yWElh11RI/NYASsOUw3RkHI3
	 +6lRcYC4sC7+NT/LN3ZvheIRSSTpwGfDPnoWyyaouAP3i/Tr9Uz6amIFjZtjiMzE9o
	 4tR0YQQh9bKgg==
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
Subject: Re: [RFC PATCH v3 5/7] mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion
Date: Fri,  5 Apr 2024 12:24:30 -0700
Message-Id: <20240405192430.67046-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-6-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:54 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> This patch introduces DAMOS_MIGRATE_COLD action, which is similar to
> DAMOS_PAGEOUT, but migrate folios to the given 'target_nid' in the sysfs
> instead of swapping them out.
> 
> The 'target_nid' sysfs knob is created by this patch to inform the
> migration target node ID.

Isn't it created by the previous patch?

> 
> Here is one of the example usage of this 'migrate_cold' action.
> 
>   $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
>   $ cat contexts/<N>/schemes/<N>/action
>   migrate_cold
>   $ echo 2 > contexts/<N>/schemes/<N>/target_nid
>   $ echo commit > state
>   $ numactl -p 0 ./hot_cold 500M 600M &
>   $ numastat -c -p hot_cold
> 
>   Per-node process memory usage (in MBs)
>   PID             Node 0 Node 1 Node 2 Total
>   --------------  ------ ------ ------ -----
>   701 (hot_cold)     501      0    601  1101
> 
> Since there are some common routines with pageout, many functions have
> similar logics between pageout and migrate cold.
> 
> damon_pa_migrate_folio_list() is a minimized version of
> shrink_folio_list(), but it's minified only for demotion.

MIGRATE_COLD is not only for demotion, right?  I think the last two words are
better to be removed for reducing unnecessary confuses.

> 
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> ---
>  include/linux/damon.h    |   2 +
>  mm/damon/paddr.c         | 146 ++++++++++++++++++++++++++++++++++++++-
>  mm/damon/sysfs-schemes.c |   4 ++
>  3 files changed, 151 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 24ea33a03d5d..df8671e69a70 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -105,6 +105,7 @@ struct damon_target {
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
> + * @DAMOS_MIGRATE_COLD: Migrate for the given cold region.

Whether it will be for cold region or not is depending on the target access
pattern.  What about 'Migrate the regions in coldest regions first manner.'?
Or, simply 'Migrate the regions (prioritize cold)' here, and explain about the
prioritization under quota on the detailed comments part?

Also, let's use tab consistently.

>   * @DAMOS_STAT:		Do nothing but count the stat.
>   * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
>   *
> @@ -122,6 +123,7 @@ enum damos_action {
>  	DAMOS_NOHUGEPAGE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
> +	DAMOS_MIGRATE_COLD,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>  	NR_DAMOS_ACTIONS,
>  };
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 277a1c4d833c..fe217a26f788 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -12,6 +12,9 @@
>  #include <linux/pagemap.h>
>  #include <linux/rmap.h>
>  #include <linux/swap.h>
> +#include <linux/memory-tiers.h>
> +#include <linux/migrate.h>
> +#include <linux/mm_inline.h>
>  
>  #include "../internal.h"
>  #include "ops-common.h"
> @@ -226,8 +229,137 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  
>  enum migration_mode {
>  	MIG_PAGEOUT,
> +	MIG_MIGRATE_COLD,
>  };
>  
> +static unsigned int migrate_folio_list(struct list_head *migrate_folios,
> +				       struct pglist_data *pgdat,
> +				       int target_nid)

To avoid name collisions, I'd prefer having damon_pa_prefix.  I show this patch
is defining damon_pa_migrate_folio_list() below, though.  What about
__damon_pa_migrate_folio_list()?

> +{
> +	unsigned int nr_succeeded;
> +	nodemask_t allowed_mask = NODE_MASK_NONE;
> +

I personally prefer not having empty lines in the middle of variable
declarations/definitions.  Could we remove this empty line?

> +	struct migration_target_control mtc = {
> +		/*
> +		 * Allocate from 'node', or fail quickly and quietly.
> +		 * When this happens, 'page' will likely just be discarded
> +		 * instead of migrated.
> +		 */
> +		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
> +		.nid = target_nid,
> +		.nmask = &allowed_mask
> +	};
> +
> +	if (pgdat->node_id == target_nid || target_nid == NUMA_NO_NODE)
> +		return 0;
> +
> +	if (list_empty(migrate_folios))
> +		return 0;

Can't these checks be done by the caller?

> +
> +	/* Migration ignores all cpuset and mempolicy settings */
> +	migrate_pages(migrate_folios, alloc_migrate_folio, NULL,
> +		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DAMON,
> +		      &nr_succeeded);
> +
> +	return nr_succeeded;
> +}
> +
> +static unsigned int damon_pa_migrate_folio_list(struct list_head *folio_list,
> +						struct pglist_data *pgdat,
> +						enum migration_mode mm,

Again, 'mm' makes my poor brain a bit confused.  What about 'mode'?
And, seems this is not used at all in this function?  Can we just drop this?

> +						int target_nid)
> +{
> +	unsigned int nr_migrated = 0;
> +	struct folio *folio;
> +	LIST_HEAD(ret_folios);
> +	LIST_HEAD(migrate_folios);
> +
> +	cond_resched();

We will do this again at the beginning of the loop.  Do we need this here?

> +
> +	while (!list_empty(folio_list)) {
> +		struct folio *folio;
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

Why?  I think we could want to migrate active pages in some use case, e.g., to
reduce memory bandwidth?

> +
> +		/* Relocate its contents to another node. */
> +		list_add(&folio->lru, &migrate_folios);
> +		folio_unlock(folio);
> +		continue;
> +keep:
> +		list_add(&folio->lru, &ret_folios);
> +		VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);

Can this happen?  I think this could be too much test?  checkpatch.pl also
warns.

> +	}
> +	/* 'folio_list' is always empty here */
> +
> +	/* Migrate folios selected for migration */
> +	nr_migrated += migrate_folio_list(&migrate_folios, pgdat, target_nid);
> +	/* Folios that could not be migrated are still in @migrate_folios */
> +	if (!list_empty(&migrate_folios)) {
> +		/* Folios which weren't migrated go back on @folio_list */
> +		list_splice_init(&migrate_folios, folio_list);
> +	}

Let's not use braces for single statement
(https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces).

> +
> +	try_to_unmap_flush();
> +
> +	list_splice(&ret_folios, folio_list);

Can't we move remaining folios in migrate_folios to ret_folios at once?

> +
> +	while (!list_empty(folio_list)) {
> +		folio = lru_to_folio(folio_list);
> +		list_del(&folio->lru);
> +		folio_putback_lru(folio);
> +	}
> +
> +	return nr_migrated;
> +}
> +
> +static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
> +					    enum migration_mode mm,

Again, I'd prefer calling this 'mode' or something other than 'mm'.
And, seems 'mm' is not really used in this function.  It is passed to
'damon_pa_migrate_folio_list()' but it deosn't really use it.  Can we drop
this?

> +					    int target_nid)
> +{
> +	int nid;
> +	unsigned int nr_migrated = 0;

Let's make this matches with the return type of this function.

> +	LIST_HEAD(node_folio_list);
> +	unsigned int noreclaim_flag;
> +
> +	if (list_empty(folio_list))
> +		return nr_migrated;
> +
> +	noreclaim_flag = memalloc_noreclaim_save();
> +
> +	nid = folio_nid(lru_to_folio(folio_list));
> +	do {
> +		struct folio *folio = lru_to_folio(folio_list);
> +
> +		if (nid == folio_nid(folio)) {
> +			folio_clear_active(folio);

I think this was necessary for demotion, but now this should be removed since
this function is no more for demotion but for migrating random pages, right?

> +			list_move(&folio->lru, &node_folio_list);
> +			continue;
> +		}
> +
> +		nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> +							   NODE_DATA(nid), mm,
> +							   target_nid);
> +		nid = folio_nid(lru_to_folio(folio_list));
> +	} while (!list_empty(folio_list));
> +
> +	nr_migrated += damon_pa_migrate_folio_list(&node_folio_list,
> +						   NODE_DATA(nid), mm,
> +						   target_nid);
> +
> +	memalloc_noreclaim_restore(noreclaim_flag);
> +
> +	return nr_migrated;
> +}
> +
>  static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  				      enum migration_mode mm)
>  {
> @@ -247,7 +379,11 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  		folio_test_clear_young(folio);
>  		if (!folio_isolate_lru(folio))
>  			goto put_folio;
> -		if (folio_test_unevictable(folio))
> +		/*
> +		 * Since unevictable folios can be demoted or promoted,

Let's use the term 'migrated' instead of 'demoted' or 'promoted'.

> +		 * unevictable test is needed only for pageout.
> +		 */
> +		if (mm == MIG_PAGEOUT && folio_test_unevictable(folio))
>  			folio_putback_lru(folio);
>  		else
>  			list_add(&folio->lru, &folio_list);
> @@ -258,6 +394,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  	case MIG_PAGEOUT:
>  		applied = reclaim_pages(&folio_list);
>  		break;
> +	case MIG_MIGRATE_COLD:
> +		applied = damon_pa_migrate_pages(&folio_list, mm,
> +						 s->target_nid);
> +		break;
>  	default:
>  		/* Unexpected migration mode. */
>  		return 0;
> @@ -314,6 +454,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  		return damon_pa_mark_accessed(r, scheme);
>  	case DAMOS_LRU_DEPRIO:
>  		return damon_pa_deactivate_pages(r, scheme);
> +	case DAMOS_MIGRATE_COLD:
> +		return damon_pa_migrate(r, scheme, MIG_MIGRATE_COLD);
>  	case DAMOS_STAT:
>  		break;
>  	default:
> @@ -334,6 +476,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
>  		return damon_hot_score(context, r, scheme);
>  	case DAMOS_LRU_DEPRIO:
>  		return damon_cold_score(context, r, scheme);
> +	case DAMOS_MIGRATE_COLD:
> +		return damon_cold_score(context, r, scheme);
>  	default:
>  		break;
>  	}
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 1a30ea82c890..18b7d054c748 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1406,6 +1406,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
>  	"nohugepage",
>  	"lru_prio",
>  	"lru_deprio",
> +	"migrate_cold",
>  	"stat",
>  };
>  
> @@ -1659,6 +1660,9 @@ static ssize_t target_nid_store(struct kobject *kobj,
>  			struct damon_sysfs_scheme, kobj);
>  	int err = 0;
>  
> +        if (scheme->action != DAMOS_MIGRATE_COLD)
> +                return -EINVAL;
> +

I think user could set target_nid first, and then action.  So I think this
should not return error?

>  	/* TODO: error handling for target_nid range. */
>  	err = kstrtoint(buf, 0, &scheme->target_nid);
>  
> -- 
> 2.34.1
> 
> 


Thanks,
SJ

