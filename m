Return-Path: <linux-kernel+bounces-82016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA45867DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3715F1C2A315
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268012DDBB;
	Mon, 26 Feb 2024 17:04:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7736B12C55E;
	Mon, 26 Feb 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967071; cv=none; b=HRk8yplHpxg0b1UsF9A5GRPoKOOWJ8IAuVj9OGaxG8Ugk0g7EH+FHkkyQQN7yZ0jkxwcJVl6qDaD/nelD2Chij9EkudeAAdTatBNLACSLOsyVh0Kduu/GOZsk4ikiUxsceIuanM+4nRXbnFE4pOGL/caK2eO07YDGwS15KL1yRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967071; c=relaxed/simple;
	bh=RKIx+oQQY1jqQNQfa40US/jQ3+vApFBCzgxBshqFQus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu3cOe2l3agysoF9Zv898TdTnPr4nxX7em4BQMQooWGR6G57PeGRnZe5IGMiA0g8OuT0pSUYapkJfahYC2rZu0ns4EKlJ9SqOvTkaaBVyDa1z8NMWwydGxCimgre31uPEF10bN5WLzyhc0uOLqisxYOAQqlrrhJ21P8ExedYUBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2875AC433F1;
	Mon, 26 Feb 2024 17:04:30 +0000 (UTC)
Date: Mon, 26 Feb 2024 12:06:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Richard Chang <richardycc@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, liumartin@google.com, surenb@google.com,
 minchan@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: add alloc_contig_migrate_range allocation
 statistics
Message-ID: <20240226120629.0c371252@gandalf.local.home>
In-Reply-To: <20240226100045.2083962-1-richardycc@google.com>
References: <20240226100045.2083962-1-richardycc@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Feb 2024 10:00:15 +0000
Richard Chang <richardycc@google.com> wrote:

> alloc_contig_migrate_range has every information to be able to
> understand big contiguous allocation latency. For example, how many
> pages are migrated, how many times they were needed to unmap from
> page tables.
> 
> This patch adds the trace event to collect the allocation statistics.
> In the field, it was quite useful to understand CMA allocation
> latency.
> 
> Signed-off-by: Richard Chang <richardycc@google.com>
> ---
>  include/trace/events/kmem.h | 39 +++++++++++++++++++++++++++++++++++++
>  mm/internal.h               |  3 ++-
>  mm/page_alloc.c             | 30 +++++++++++++++++++++++-----
>  mm/page_isolation.c         |  2 +-
>  4 files changed, 67 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 58688768ef0f..964704d76f9f 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -304,6 +304,45 @@ TRACE_EVENT(mm_page_alloc_extfrag,
>  		__entry->change_ownership)
>  );
>  
> +TRACE_EVENT(mm_alloc_contig_migrate_range_info,
> +
> +	TP_PROTO(unsigned long start,
> +		 unsigned long end,
> +		 int migratetype,
> +		 unsigned long nr_migrated,
> +		 unsigned long nr_reclaimed,
> +		 unsigned long nr_mapped),
> +
> +	TP_ARGS(start, end, migratetype,
> +		nr_migrated, nr_reclaimed, nr_mapped),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, start)
> +		__field(unsigned long, end)
> +		__field(int, migratetype)


Please move the int to the end of the longs, as it will cause a 4 byte hole
in 64 bit machines otherwise.


> +		__field(unsigned long, nr_migrated)
> +		__field(unsigned long, nr_reclaimed)
> +		__field(unsigned long, nr_mapped)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->start = start;
> +		__entry->end = end;
> +		__entry->migratetype = migratetype;
> +		__entry->nr_migrated = nr_migrated;
> +		__entry->nr_reclaimed = nr_reclaimed;
> +		__entry->nr_mapped = nr_mapped;
> +	),
> +
> +	TP_printk("start=0x%lx end=0x%lx migratetype=%d nr_migrated=%lu nr_reclaimed=%lu nr_mapped=%lu",
> +		  __entry->start,
> +		  __entry->end,
> +		  __entry->migratetype,
> +		  __entry->nr_migrated,
> +		  __entry->nr_reclaimed,
> +		  __entry->nr_mapped)
> +);
> +
>  /*
>   * Required for uniquely and securely identifying mm in rss_stat tracepoint.
>   */
> diff --git a/mm/internal.h b/mm/internal.h
> index f309a010d50f..e114c647e278 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -537,7 +537,8 @@ isolate_migratepages_range(struct compact_control *cc,
>  			   unsigned long low_pfn, unsigned long end_pfn);
>  
>  int __alloc_contig_migrate_range(struct compact_control *cc,
> -					unsigned long start, unsigned long end);
> +					unsigned long start, unsigned long end,
> +					int migratetype);
>  
>  /* Free whole pageblock and set its migration type to MIGRATE_CMA. */
>  void init_cma_reserved_pageblock(struct page *page);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 150d4f23b010..f840bc785afa 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6219,9 +6219,14 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
>  	}
>  }
>  
> -/* [start, end) must belong to a single zone. */
> +/*
> + * [start, end) must belong to a single zone.
> + * @migratetype: using migratetype to filter the type of migration in
> + *		trace_mm_alloc_contig_migrate_range_info.
> + */
>  int __alloc_contig_migrate_range(struct compact_control *cc,
> -					unsigned long start, unsigned long end)
> +					unsigned long start, unsigned long end,
> +					int migratetype)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
>  	unsigned int nr_reclaimed;
> @@ -6232,6 +6237,10 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
>  		.nid = zone_to_nid(cc->zone),
>  		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
>  	};
> +	struct page *page;
> +	unsigned long total_mapped = 0;
> +	unsigned long total_migrated = 0;
> +	unsigned long total_reclaimed = 0;
>  
>  	lru_cache_disable();
>  
> @@ -6257,9 +6266,16 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
>  							&cc->migratepages);
>  		cc->nr_migratepages -= nr_reclaimed;
>  
> +		total_reclaimed += nr_reclaimed;
> +		list_for_each_entry(page, &cc->migratepages, lru)
> +			total_mapped += page_mapcount(page);

You're doing this calculation regardless of if tracing is enabled or not
and it's only used for tracing? Please add:

		if (trace_mm_alloc_contig_migrate_range_info_enabled()) {
			total_reclaimed += nr_reclaimed;
			list_for_each_entry(page, &cc->migratepages, lru)
				total_mapped += page_mapcount(page);
		}

-- Steve

> +
>  		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
>  			NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE, NULL);
>  
> +		if (!ret)

May want the above to be:

		if (trace_mm_alloc_config_migrate_range_info_enabled() && !ret)

too.

-- Steve

> +			total_migrated += cc->nr_migratepages;
> +
>  		/*
>  		 * On -ENOMEM, migrate_pages() bails out right away. It is pointless
>  		 * to retry again over this error, so do the same here.
> @@ -6273,9 +6289,13 @@ int __alloc_contig_migrate_range(struct compact_control *cc,
>  		if (!(cc->gfp_mask & __GFP_NOWARN) && ret == -EBUSY)
>  			alloc_contig_dump_pages(&cc->migratepages);
>  		putback_movable_pages(&cc->migratepages);
> -		return ret;
>  	}
> -	return 0;
> +
> +	trace_mm_alloc_contig_migrate_range_info(start, end, migratetype,
> +						 total_migrated,
> +						 total_reclaimed,
> +						 total_mapped);
> +	return (ret < 0) ? ret : 0;
>  }
>  
>  /**
> @@ -6355,7 +6375,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
>  	 * allocated.  So, if we fall through be sure to clear ret so that
>  	 * -EBUSY is not accidentally used or returned to caller.
>  	 */
> -	ret = __alloc_contig_migrate_range(&cc, start, end);
> +	ret = __alloc_contig_migrate_range(&cc, start, end, migratetype);
>  	if (ret && ret != -EBUSY)
>  		goto done;
>  	ret = 0;
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index cd0ea3668253..a5c8fa4c2a75 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -434,7 +434,7 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  				}
>  
>  				ret = __alloc_contig_migrate_range(&cc, head_pfn,
> -							head_pfn + nr_pages);
> +							head_pfn + nr_pages, page_mt);
>  
>  				/*
>  				 * restore the page's migratetype so that it can


