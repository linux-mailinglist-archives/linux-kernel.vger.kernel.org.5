Return-Path: <linux-kernel+bounces-133526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6789A4DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8241F21744
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CC0172BCF;
	Fri,  5 Apr 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SboxYC3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609C171E66;
	Fri,  5 Apr 2024 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345214; cv=none; b=bJXt9sLmzlF6Sqn7A716RehpplMR5LwmuHdBuaE9yjXXBjeGvNdfExlX3Q30mrG5Bwvfqq8Cgouhsf+8594ODlTbhywY+Dg81vnRzptZgMCd/5t3NxculFFe9J4NIk2sJMiZfQThAkNI7maGXZh+DKyNz1Iyuzfd3Hbf9nzY0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345214; c=relaxed/simple;
	bh=gEl5yFCekr+YA46DjuYH6j3x96vUoSzFx76l82eJ5Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFycQlzPKZAYLR1fvSRKoV7CYfmcBgQo2V/ujwNelQWvZieI1u3kJw2GaW2maG4IZVS8a++dcJQYaOkHKjhiT8RAfGGGsfsULRLQ/qRpcaardOuGM7AnkjiIFmUeL8HFktqvC/5r5femne0nnXJ0k7hvxAF7VnZcvXY0rMovJwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SboxYC3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018CAC433F1;
	Fri,  5 Apr 2024 19:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712345213;
	bh=gEl5yFCekr+YA46DjuYH6j3x96vUoSzFx76l82eJ5Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SboxYC3epexJ5wrq/hit1fKAOzsA/xavNfFwChSypo+n1i1004Y7JYSYYqkZCm/N6
	 3Zpg0cJcu2hRy7pCr9dGIWJIxP5/QY8oHuXLxvsrd8UO8pGgXJFPkyGnmPlerV4fs4
	 d8ejZgqzUt51ZnCWzv8gsXATNxuGfl7CnHONNM1LgGZVLNl78AOOEXFKLDl9UQdjwD
	 HpvlkDs+cldef+NQuLiBjjLMC383Rp8BKh4/WXL9AABVDVq5oXQ7FSPc6+cb7LNcT8
	 RWevLdWKZHdwLmRO2j8TOlsviJymqvw/gpCIAh4vYAvD2w4vn8hrUQsnZL0OuMdKnP
	 blVhxW5tJdO1g==
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
Subject: Re: [RFC PATCH v3 6/7] mm/damon/paddr: introduce DAMOS_MIGRATE_HOT action for promotion
Date: Fri,  5 Apr 2024 12:26:50 -0700
Message-Id: <20240405192650.67096-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-7-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  5 Apr 2024 15:08:55 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> From: Hyeongtak Ji <hyeongtak.ji@sk.com>
> 
> This patch introduces DAMOS_MIGRATE_HOT action, which is similar to
> DAMOS_MIGRATE_COLD, but it is targeted to migrate hot pages.

My understanding of our last discussion was that 'HOT/COLD' here is only for
prioritization score function.  If I'm not wrong, this is not for targeting,
but just prioritize migrating hot pages first under the quota.

> 
> It migrates pages inside the given region to the 'target_nid' NUMA node
> in the sysfs.
> 
> Here is one of the example usage of this 'migrate_hot' action.
> 
>   $ cd /sys/kernel/mm/damon/admin/kdamonds/<N>
>   $ cat contexts/<N>/schemes/<N>/action
>   migrate_hot
>   $ echo 0 > contexts/<N>/schemes/<N>/target_nid
>   $ echo commit > state
>   $ numactl -p 2 ./hot_cold 500M 600M &
>   $ numastat -c -p hot_cold
> 
>   Per-node process memory usage (in MBs)
>   PID             Node 0 Node 1 Node 2 Total
>   --------------  ------ ------ ------ -----
>   701 (hot_cold)     501      0    601  1101
> 
> Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
> Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
> ---
>  include/linux/damon.h    |  2 ++
>  mm/damon/paddr.c         | 12 ++++++++++--
>  mm/damon/sysfs-schemes.c |  4 +++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index df8671e69a70..934c95a7c042 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -105,6 +105,7 @@ struct damon_target {
>   * @DAMOS_NOHUGEPAGE:	Call ``madvise()`` for the region with MADV_NOHUGEPAGE.
>   * @DAMOS_LRU_PRIO:	Prioritize the region on its LRU lists.
>   * @DAMOS_LRU_DEPRIO:	Deprioritize the region on its LRU lists.
> + * @DAMOS_MIGRATE_HOT:  Migrate for the given hot region.

As commented on the previous patch, this could be bit re-phrased.
Also, let's use tabs consistently.

>   * @DAMOS_MIGRATE_COLD: Migrate for the given cold region.
>   * @DAMOS_STAT:		Do nothing but count the stat.
>   * @NR_DAMOS_ACTIONS:	Total number of DAMOS actions
> @@ -123,6 +124,7 @@ enum damos_action {
>  	DAMOS_NOHUGEPAGE,
>  	DAMOS_LRU_PRIO,
>  	DAMOS_LRU_DEPRIO,
> +	DAMOS_MIGRATE_HOT,
>  	DAMOS_MIGRATE_COLD,
>  	DAMOS_STAT,		/* Do nothing but only record the stat */
>  	NR_DAMOS_ACTIONS,
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index fe217a26f788..fd9d35b5cc83 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -229,6 +229,7 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
>  
>  enum migration_mode {
>  	MIG_PAGEOUT,
> +	MIG_MIGRATE_HOT,
>  	MIG_MIGRATE_COLD,
>  };

It looks like we don't need MIG_MIGRATE_HOT and MIG_MIGRATE_COLD in real, but
just one, say, MIG_MIGRATE, since the code can know if it should use what
prioritization score function with DAMOS action?

Also, as I commented on the previous one, I'd prefer having DAMOS_ prefix.

>  
> @@ -375,8 +376,10 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  		if (damos_pa_filter_out(s, folio))
>  			goto put_folio;
>  
> -		folio_clear_referenced(folio);
> -		folio_test_clear_young(folio);
> +		if (mm != MIG_MIGRATE_HOT) {
> +			folio_clear_referenced(folio);
> +			folio_test_clear_young(folio);
> +		}

We agreed to this check via 'young' page type DAMOS filter, and let this
doesn't care about it, right?  If I'm not wrong, I think this should be
removed?

>  		if (!folio_isolate_lru(folio))
>  			goto put_folio;
>  		/*
> @@ -394,6 +397,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r, struct damos *s,
>  	case MIG_PAGEOUT:
>  		applied = reclaim_pages(&folio_list);
>  		break;
> +	case MIG_MIGRATE_HOT:
>  	case MIG_MIGRATE_COLD:
>  		applied = damon_pa_migrate_pages(&folio_list, mm,
>  						 s->target_nid);
> @@ -454,6 +458,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
>  		return damon_pa_mark_accessed(r, scheme);
>  	case DAMOS_LRU_DEPRIO:
>  		return damon_pa_deactivate_pages(r, scheme);
> +	case DAMOS_MIGRATE_HOT:
> +		return damon_pa_migrate(r, scheme, MIG_MIGRATE_HOT);
>  	case DAMOS_MIGRATE_COLD:
>  		return damon_pa_migrate(r, scheme, MIG_MIGRATE_COLD);
>  	case DAMOS_STAT:
> @@ -476,6 +482,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
>  		return damon_hot_score(context, r, scheme);
>  	case DAMOS_LRU_DEPRIO:
>  		return damon_cold_score(context, r, scheme);
> +	case DAMOS_MIGRATE_HOT:
> +		return damon_hot_score(context, r, scheme);
>  	case DAMOS_MIGRATE_COLD:
>  		return damon_cold_score(context, r, scheme);
>  	default:
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 18b7d054c748..1d2f62aa79ca 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -1406,6 +1406,7 @@ static const char * const damon_sysfs_damos_action_strs[] = {
>  	"nohugepage",
>  	"lru_prio",
>  	"lru_deprio",
> +	"migrate_hot",
>  	"migrate_cold",
>  	"stat",
>  };
> @@ -1660,7 +1661,8 @@ static ssize_t target_nid_store(struct kobject *kobj,
>  			struct damon_sysfs_scheme, kobj);
>  	int err = 0;
>  
> -        if (scheme->action != DAMOS_MIGRATE_COLD)
> +        if (scheme->action != DAMOS_MIGRATE_HOT &&
> +            scheme->action != DAMOS_MIGRATE_COLD)
>                  return -EINVAL;
>  
>  	/* TODO: error handling for target_nid range. */
> -- 
> 2.34.1
> 
> 


Thanks,
SJ

