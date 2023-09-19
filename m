Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F7D7A662F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjISOIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjISOIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:08:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D1AF2;
        Tue, 19 Sep 2023 07:08:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1141C433C8;
        Tue, 19 Sep 2023 14:08:35 +0000 (UTC)
Date:   Tue, 19 Sep 2023 10:09:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     yuzhao@google.com, tjmercier@google.com, kaleshsingh@google.com,
        akpm@linux-foundation.org, vbabka@suse.cz, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-mm@kvack.org, jaewon31.kim@gmail.com
Subject: Re: [PATCH] vmscan: add trace events for lru_gen
Message-ID: <20230919095927.5a964094@gandalf.local.home>
In-Reply-To: <20230919025216.1878-1-jaewon31.kim@samsung.com>
References: <CGME20230919025012epcas1p2c2c57a34eea3299ef3bb643f4cbddf0b@epcas1p2.samsung.com>
        <20230919025216.1878-1-jaewon31.kim@samsung.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 11:52:16 +0900
Jaewon Kim <jaewon31.kim@samsung.com> wrote:

>  /*
>   * Now redefine the EM() and EMe() macros to map the enums to the strings
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index d2123dd960d5..e8f9d0452e89 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -327,6 +327,55 @@ TRACE_EVENT(mm_vmscan_lru_isolate,
>  		__print_symbolic(__entry->lru, LRU_NAMES))
>  );
>  
> +TRACE_EVENT(mm_vmscan_lru_gen_scan,
> +	TP_PROTO(int highest_zoneidx,
> +		int order,
> +		unsigned long nr_requested,
> +		unsigned long nr_scanned,
> +		unsigned long nr_skipped,
> +		unsigned long nr_taken,
> +		isolate_mode_t isolate_mode,
> +		int lru),

This is a lot of parameter passing, can you consolidate it?

(see below to where you call this)

> +
> +	TP_ARGS(highest_zoneidx, order, nr_requested, nr_scanned, nr_skipped, nr_taken, isolate_mode, lru),
> +
> +	TP_STRUCT__entry(
> +		__field(int, highest_zoneidx)
> +		__field(int, order)
> +		__field(unsigned long, nr_requested)
> +		__field(unsigned long, nr_scanned)
> +		__field(unsigned long, nr_skipped)
> +		__field(unsigned long, nr_taken)
> +		__field(unsigned int, isolate_mode)
> +		__field(int, lru)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->highest_zoneidx = highest_zoneidx;
> +		__entry->order = order;
> +		__entry->nr_requested = nr_requested;
> +		__entry->nr_scanned = nr_scanned;
> +		__entry->nr_skipped = nr_skipped;
> +		__entry->nr_taken = nr_taken;
> +		__entry->isolate_mode = (__force unsigned int)isolate_mode;
> +		__entry->lru = lru;
> +	),
> +
> +	/*
> +	 * classzone is previous name of the highest_zoneidx.
> +	 * Reason not to change it is the ABI requirement of the tracepoint.
> +	 */
> +	TP_printk("isolate_mode=%d classzone=%d order=%d nr_requested=%lu nr_scanned=%lu nr_skipped=%lu nr_taken=%lu lru=%s",
> +		__entry->isolate_mode,
> +		__entry->highest_zoneidx,
> +		__entry->order,
> +		__entry->nr_requested,
> +		__entry->nr_scanned,
> +		__entry->nr_skipped,
> +		__entry->nr_taken,
> +		__print_symbolic(__entry->lru, LRU_GEN_NAMES))
> +);
> +
>  TRACE_EVENT(mm_vmscan_write_folio,
>  
>  	TP_PROTO(struct folio *folio),
> @@ -437,6 +486,53 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
>  		show_reclaim_flags(__entry->reclaim_flags))
>  );
>  
> +TRACE_EVENT(mm_vmscan_lru_gen_evict,
> +
> +	TP_PROTO(int nid, unsigned long nr_reclaimed,
> +		struct reclaim_stat *stat, int priority, int file),
> +
> +	TP_ARGS(nid, nr_reclaimed, stat, priority, file),
> +
> +	TP_STRUCT__entry(
> +		__field(int, nid)

On 64 bit architectures, this causes a 4 byte hole in the ring buffer
layout. Please keep 32 bit size fields paired with other 32 bit size if
possible. That is, move the above "int nid" down where it doesn't cause a
long field to be 4 bytes away.

> +		__field(unsigned long, nr_reclaimed)
> +		__field(unsigned long, nr_dirty)
> +		__field(unsigned long, nr_writeback)
> +		__field(unsigned long, nr_congested)
> +		__field(unsigned long, nr_immediate)
> +		__field(unsigned int, nr_activate0)
> +		__field(unsigned int, nr_activate1)
> +		__field(unsigned long, nr_ref_keep)
> +		__field(unsigned long, nr_unmap_fail)

		__field(int, nid)

here!

> +		__field(int, priority)
> +		__field(int, reclaim_flags)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->nid = nid;
> +		__entry->nr_reclaimed = nr_reclaimed;
> +		__entry->nr_dirty = stat->nr_dirty;
> +		__entry->nr_writeback = stat->nr_writeback;
> +		__entry->nr_congested = stat->nr_congested;
> +		__entry->nr_immediate = stat->nr_immediate;
> +		__entry->nr_activate0 = stat->nr_activate[0];
> +		__entry->nr_activate1 = stat->nr_activate[1];
> +		__entry->nr_ref_keep = stat->nr_ref_keep;
> +		__entry->nr_unmap_fail = stat->nr_unmap_fail;
> +		__entry->priority = priority;
> +		__entry->reclaim_flags = trace_reclaim_flags(file);
> +	),
> +
> +	TP_printk("nid=%d nr_reclaimed=%ld nr_dirty=%ld nr_writeback=%ld nr_congested=%ld nr_immediate=%ld nr_activate_anon=%d nr_activate_file=%d nr_ref_keep=%ld nr_unmap_fail=%ld priority=%d flags=%s",
> +		__entry->nid, __entry->nr_reclaimed,
> +		__entry->nr_dirty, __entry->nr_writeback,
> +		__entry->nr_congested, __entry->nr_immediate,
> +		__entry->nr_activate0, __entry->nr_activate1,
> +		__entry->nr_ref_keep, __entry->nr_unmap_fail,
> +		__entry->priority,
> +		show_reclaim_flags(__entry->reclaim_flags))
> +);
> +
>  TRACE_EVENT(mm_vmscan_node_reclaim_begin,
>  
>  	TP_PROTO(int nid, int order, gfp_t gfp_flags),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 6f13394b112e..cc10e3fb8fa2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -5005,6 +5005,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  	int sorted = 0;
>  	int scanned = 0;
>  	int isolated = 0;
> +	int skipped = 0;
>  	int remaining = MAX_LRU_BATCH;
>  	struct lru_gen_folio *lrugen = &lruvec->lrugen;
>  	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
> @@ -5018,7 +5019,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  
>  	for (i = MAX_NR_ZONES; i > 0; i--) {
>  		LIST_HEAD(moved);
> -		int skipped = 0;
> +		int skipped_zone = 0;
>  		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
>  		struct list_head *head = &lrugen->folios[gen][type][zone];
>  
> @@ -5040,16 +5041,17 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  				isolated += delta;
>  			} else {
>  				list_move(&folio->lru, &moved);
> -				skipped += delta;
> +				skipped_zone += delta;
>  			}
>  
> -			if (!--remaining || max(isolated, skipped) >= MIN_LRU_BATCH)
> +			if (!--remaining || max(isolated, skipped_zone) >= MIN_LRU_BATCH)
>  				break;
>  		}
>  
> -		if (skipped) {
> +		if (skipped_zone) {
>  			list_splice(&moved, head);
> -			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped);
> +			__count_zid_vm_events(PGSCAN_SKIP, zone, skipped_zone);
> +			skipped += skipped_zone;
>  		}
>  
>  		if (!remaining || isolated >= MIN_LRU_BATCH)
> @@ -5065,6 +5067,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
>  	__count_memcg_events(memcg, PGREFILL, sorted);
>  	__count_vm_events(PGSCAN_ANON + type, isolated);
>  
> +	if (scanned)

BTW, you can make this branch conditional with the trace event logic, so
that it isn't tested when tracing is enabled. That is, remove the
 "if (scanned)" test and use TRACE_EVENT_CONDITION() as I show below.

> +		trace_mm_vmscan_lru_gen_scan(sc->reclaim_idx, sc->order,
> +				MAX_LRU_BATCH, scanned, skipped, isolated,
> +				sc->may_unmap ? 0 : ISOLATE_UNMAPPED, type);

Why not pass the sc in to the trace event, and then do the assigning there?

// use CONDITION to test scanned

TRACE_EVENT_CONDITION(mm_vmscan_lru_gen_scan,

	TP_PROTO(struct scan_control *sc,
		unsigned long nr_requested,
		unsigned long nr_scanned,
		unsigned long nr_skipped,
		unsigned long nr_taken,
		int lru),

	TP_ARGS(...)

	TP_CONDITION(nr_scanned)

	TP_fast_assign(
		__entry->highest_zoneidx = sc->reclaim_idx;
		__entry->order = sc->order;
		__entry->nr_requested = nr_requested;
		__entry->nr_scanned = nr_scanned;
		__entry->nr_skipped = nr_skipped;
		__entry->nr_taken = nr_taken;
		__entry->isolate_mode = (__force unsigned int)(sc->may_unmap ? 0 : ISOLATE_UNMAPPED);
		__entry->lru = lru;
	),

Lots of parameters can be expensive to pass, as it requires more copying.

-- Steve


>  	/*
>  	 * There might not be eligible folios due to reclaim_idx. Check the
>  	 * remaining to prevent livelock if it's not making progress.
> @@ -5194,6 +5200,8 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>  retry:
>  	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
>  	sc->nr_reclaimed += reclaimed;
> +	trace_mm_vmscan_lru_gen_evict(pgdat->node_id, reclaimed, &stat,
> +				      sc->priority, type);
>  
>  	list_for_each_entry_safe_reverse(folio, next, &list, lru) {
>  		if (!folio_evictable(folio)) {

