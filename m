Return-Path: <linux-kernel+bounces-91660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1F8714C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1006D1F21606
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AC3398B;
	Tue,  5 Mar 2024 04:33:19 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D863D396
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 04:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613198; cv=none; b=pqQhI1k1m0hPnsDHJ4Y0BS79ZPsEpHxFq7qmAyW/rplAeLOXOz3pGEBNZ5jkm0h8vW+h/O3rNp21DCWrF+J1ef/IGkZo9d6kFcnbx9ezXPEfUqeLOco42xA96q1YwRKyOiUxpmSDXOIDlNAdpZB2YAmJXEqFgsfgBApcLH0jwjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613198; c=relaxed/simple;
	bh=Xnln4gaJc2HHGBgV41T/1P8zj4jlnNOUD2a0Zx7i+2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOOWm25llxAi10PA4L16WgTYjP5ujCjyuMtLjBfVSHP4FFS5JwcojDIXIWji5//TWJxRfiM4KvTI9xr8gL2OLvOP8UWdWgGcczsCxlc+b/OBBVy+fzKQ8FV/XXMwN6wRBbxFZsyHzGpFiBdMoYXObVBtyRQoJIXXxwJJo1sGxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-57-65e6a086aa89
Date: Tue, 5 Mar 2024 13:33:05 +0900
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kernel_team@skhynix.com, yuzhao@google.com, ying.huang@intel.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH v6] mm, vmscan: retry kswapd's priority loop with
 cache_trim_mode off on failure
Message-ID: <20240305043305.GB21107@system.software.com>
References: <20240304033611.GD13332@system.software.com>
 <20240304082118.20499-1-byungchul@sk.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304082118.20499-1-byungchul@sk.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsXC9ZZnkW7bgmepBovnGlvMWb+GzWL1Jl+L
	y7vmsFncW/Of1eLkrMksFu8mfGF1YPM4/OY9s8eCTaUei/e8ZPLY9GkSu8eJGb9ZPD5vkgtg
	i+KySUnNySxLLdK3S+DKuPD2N1vBHsuKq/N3MDcw/tHsYuTkkBAwkVje/5a9i5EDzH72RBAk
	zCKgInFr3SdGEJtNQF3ixo2fzCC2iICsxNS/51m6GLk4mAX6GCWuvN4LViQskCbx6thnZpA5
	vAIWEnNWZoOEhQRSJLrfvwQr4RUQlDg58wkLiM0soCVx499LJpByZgFpieX/OEDCnAJmEgd2
	HwMrERVQljiw7TgTyCoJgQ1sEo/mbGeHOFlS4uCKGywTGAVmIRk7C8nYWQhjFzAyr2IUyswr
	y03MzDHRy6jMy6zQS87P3cQIDOpltX+idzB+uhB8iFGAg1GJh/fEvqepQqyJZcWVuYcYJTiY
	lUR4a349SRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOa/StPEVIID2xJDU7NbUgtQgmy8TBKdXA
	KH1hxa5+uyOnpcMKP82K2nJhR5XR+ZPGEY0bRR9ZaLlNSpHmFJpSvbY2JrV70YJdm6uijs5T
	ZHmUPT/Sr/04s9GVrzOW7Pu4+nkD59J5OfZdevecfWsfOVp2PMruXfWz963RhhsvXT3MGnd0
	db5e7magJX2kKTR/ocI6P9EZ82fKdN085fCBQYmlOCPRUIu5qDgRAClreJdmAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsXC5WfdrNu24FmqwcTfqhZz1q9hs1i9ydfi
	8NyTrBaXd81hs7i35j+rxclZk1ks3k34wurA7nH4zXtmjwWbSj0W73nJ5LHp0yR2jxMzfrN4
	LH7xgcnj8ya5APYoLpuU1JzMstQifbsErowLb3+zFeyxrLg6fwdzA+MfzS5GDg4JAROJZ08E
	uxg5OVgEVCRurfvECGKzCahL3LjxkxnEFhGQlZj69zxLFyMXB7NAH6PEldd7wYqEBdIkXh37
	zAwyh1fAQmLOymyQsJBAikT3+5dgJbwCghInZz5hAbGZBbQkbvx7yQRSziwgLbH8HwdImFPA
	TOLA7mNgJaICyhIHth1nmsDIOwtJ9ywk3bMQuhcwMq9iFMnMK8tNzMwx1SvOzqjMy6zQS87P
	3cQIDNFltX8m7mD8ctn9EKMAB6MSD++Fo09ThVgTy4orcw8xSnAwK4nw1vx6kirEm5JYWZVa
	lB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBKdXAOC205KfBHG0H/o83vz6Z
	XSh/cDvj6fVbpytxVbOlRL0z6fhlJX79b/Zlw1dXXwe1HdYo/LKV7Z6rzW3+La+6/1X/9rYo
	8n98udNAbJkrX79O2ZRnXwT/XWtV/H2WSzX4t1CEfzkzzylPn30n7qy+sCJV5l5t0OJajhea
	GvKSrx43ellVGtxsVmIpzkg01GIuKk4EAFMnwrBNAgAA
X-CFilter-Loop: Reflected

On Mon, Mar 04, 2024 at 05:21:18PM +0900, Byungchul Park wrote:
> Changes from v5:
> 	1. Make it retry the kswapd's scan priority loop with
> 	   cache_trim_mode off *only if* the mode didn't work in the
> 	   previous loop. (feedbacked by Huang Ying)
> 	2. Take into account 'break's from the priority loop when making
> 	   the decision whether to retry. (feedbacked by Huang Ying)
> 	3. Update the test result in the commit message.
> 
> Changes from v4:
> 	1. Make other scans start with may_cache_trim_mode = 1.
> 
> Changes from v3:
> 	1. Update the test result in the commit message with v4.
> 	2. Retry the whole priority loop with cache_trim_mode off again,
> 	   rather than forcing the mode off at the highest priority,
> 	   when the mode doesn't work. (feedbacked by Johannes Weiner)
> 
> Changes from v2:
> 	1. Change the condition to stop cache_trim_mode.
> 
> 	   From - Stop it if it's at high scan priorities, 0 or 1.
> 	   To   - Stop it if it's at high scan priorities, 0 or 1, and
> 	          the mode didn't work in the previous turn.
> 
> 	   (feedbacked by Huang Ying)
> 
> 	2. Change the test result in the commit message after testing
> 	   with the new logic.
> 
> Changes from v1:
> 	1. Add a comment describing why this change is necessary in code
> 	   and rewrite the commit message with how to reproduce and what
> 	   the result is using vmstat. (feedbacked by Andrew Morton and
> 	   Yu Zhao)
> 	2. Change the condition to avoid cache_trim_mode from
> 	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
> 	   where the priority goes to zero all the way. (feedbacked by
> 	   Yu Zhao)
> 
> --->8---
> >From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 4 Mar 2024 15:27:37 +0900
> Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
> 
> With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
> pages.  However, it should be more careful to use the mode because it's
> going to prevent anon pages from being reclaimed even if there are a
> huge number of anon pages that are cold and should be reclaimed.  Even
> worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
> stopping kswapd from functioning until direct reclaim eventually works
> to resume kswapd.
> 
> So kswapd needs to retry its scan priority loop with cache_trim_mode
> off again if the mode doesn't work for reclaim.
> 
> The problematic behavior can be reproduced by:
> 
>    CONFIG_NUMA_BALANCING enabled
>    sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
>    numa node0 (8GB local memory, 16 CPUs)
>    numa node1 (8GB slow tier memory, no CPUs)
> 
>    Sequence:
> 
>    1) echo 3 > /proc/sys/vm/drop_caches
>    2) To emulate the system with full of cold memory in local DRAM, run
>       the following dummy program and never touch the region:
> 
>          mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
>               MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);
> 
>    3) Run any memory intensive work e.g. XSBench.
>    4) Check if numa balancing is working e.i. promotion/demotion.
>    5) Iterate 1) ~ 4) until numa balancing stops.
> 
> With this, you could see that promotion/demotion are not working because
> kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.
> 
> Interesting vmstat delta's differences between before and after are like:
> 
>    +-----------------------+-------------------------------+
>    | interesting vmstat    | before        | after         |
>    +-----------------------+-------------------------------+
>    | nr_inactive_anon      | 321935        | 1664772       |
>    | nr_active_anon        | 1780700       | 437834        |
>    | nr_inactive_file      | 30425         | 40882         |
>    | nr_active_file        | 14961         | 3012          |
>    | pgpromote_success     | 356           | 1293122       |
>    | pgpromote_candidate   | 21953245      | 1824148       |
>    | pgactivate            | 1844523       | 3311907       |
>    | pgdeactivate          | 50634         | 1554069       |
>    | pgfault               | 31100294      | 6518806       |
>    | pgdemote_kswapd       | 30856         | 2230821       |
>    | pgscan_kswapd         | 1861981       | 7667629       |
>    | pgscan_anon           | 1822930       | 7610583       |
>    | pgscan_file           | 39051         | 57046         |
>    | pgsteal_anon          | 386           | 2192033       |
>    | pgsteal_file          | 30470         | 38788         |
>    | pageoutrun            | 30            | 412           |
>    | numa_hint_faults      | 27418279      | 2875955       |
>    | numa_pages_migrated   | 356           | 1293122       |
>    +-----------------------+-------------------------------+
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> ---
>  mm/vmscan.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bba207f41b14..6fe45eca7766 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -108,6 +108,12 @@ struct scan_control {
>  	/* Can folios be swapped as part of reclaim? */
>  	unsigned int may_swap:1;
>  
> +	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
> +	unsigned int no_cache_trim_mode:1;
> +
> +	/* Has cache_trim_mode failed at least once? */
> +	unsigned int cache_trim_mode_failed:1;
> +
>  	/* Proactive reclaim invoked by userspace through memory.reclaim */
>  	unsigned int proactive:1;
>  
> @@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
>  	 * anonymous pages.
>  	 */
>  	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
> -	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
> +	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
> +	    !sc->no_cache_trim_mode)
>  		sc->cache_trim_mode = 1;
>  	else
>  		sc->cache_trim_mode = 0;
> @@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	 */
>  	if (reclaimable)
>  		pgdat->kswapd_failures = 0;
> +	else if (sc->cache_trim_mode)
> +		sc->cache_trim_mode_failed = 1;
>  }
>  
>  /*
> @@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  			sc.priority--;
>  	} while (sc.priority >= 1);
>  
> +	/*
> +	 * Restart only if it went through the priority loop all the way,
> +	 * but cache_trim_mode didn't work.
> +	 */
> +	if (!sc.nr_reclaimed && sc.priority < 1 &&
> +	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
> +		sc.no_cache_trim_mode = 1;
> +		goto restart;
> +	}
> +
>  	if (!sc.nr_reclaimed)
>  		pgdat->kswapd_failures++;

Or 's/cache_trim_mode_failed/balancing_cleverness_failed' so that any
balancing cleverness can be surpressed when needed?

Even though I faced an issue by cache_trim_mode and I'm trying to resolve
it this time, but I'm still not sure if kswapd's reclaim is okay with
other cleverness(?) including SCAN_FRACT at its highest priority.

Just grumbling. You can ignore the second paragrph :(

	Byungchul

