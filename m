Return-Path: <linux-kernel+bounces-90194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5772F86FBC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1B9B21A19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811518E3A;
	Mon,  4 Mar 2024 08:21:38 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136518C38
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540497; cv=none; b=AgWzolpySEMzmnKFRnJ6CMggmY2iimwAlHt94eEztyhA/DpN+4sWUpkT66eSe1LoL1I4243KLjPbAVC5potVUnyyeeNmpqsJ0yasuTFzI3kBro/hhQdTs5Op8hgDgWugCWepJnzovIcbKEfZtJrD2tMm/ZjLoA2yoYBVfHfdXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540497; c=relaxed/simple;
	bh=oltLHkQ3HHSc6tBzM86Kp7ocP3YRTC16X9cp9zADPmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IkN9OaEB/B0ebZNyIXuiteZh28pPw3QAK0lWd8S2bolaR84y/PaNnK1psi/JG/IZB+7Of6lxKPAkE52lsJPu997OYw1HPVnvvtFBqLFERNIKdRIEnmpWZd7Hrzsw3cNk3qga+YaKgGybS18RaSNQUd/hyPrh9e/9NnC4aEqc1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-70-65e58488cc98
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	yuzhao@google.com,
	ying.huang@intel.com,
	hannes@cmpxchg.org
Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure
Date: Mon,  4 Mar 2024 17:21:18 +0900
Message-Id: <20240304082118.20499-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240304033611.GD13332@system.software.com>
References: <20240304033611.GD13332@system.software.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LhesuzULej5WmqQfdxLYs569ewWaze5Gtx
	edccNot7a/6zWpycNZnF4t2EL6wObB6H37xn9liwqdRj8Z6XTB6bPk1i9zgx4zeLx+dNcgFs
	UVw2Kak5mWWpRfp2CVwZX0/0sRWsM6643LmSvYHxlmoXIyeHhICJxI1/k5hg7MWTTrKD2GwC
	6hI3bvxkBrFFBGQlpv49z9LFyMXBLDCFUWLFvXY2kISwQILE79VrWEFsFgFVibfH+8HivAKm
	EpNmXGCEGCovsXrDAaBBHBycApYSP7rcQMJCAhYS9+a1sILMlBD4yipx8MZjFoh6SYmDK26w
	TGDkXcDIsIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMJSW1f6J3sH46ULwIUYBDkYlHt6Mziep
	QqyJZcWVuYcYJTiYlUR4a34BhXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5N
	LUgtgskycXBKNTD6C69bF2XrMXHHnNzulEKdFAvbL/klkt/WfVt7V+ViZWDOwRfpa5tsmxdO
	qyzR2czZ1GzC0MC+eEO9B2fgXeuzLlJfehj6r954uOnVio31Zjd8YtRlo89uYBdY0rXHxvLS
	cZ9pijF3Y2/++ud1oYF54e3zNQtZ9y8MeeOvPGWlxPnlL1Y+39ShxFKckWioxVxUnAgAkZ2W
	UyECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsXC5WfdrNvR8jTVoOesnMWc9WvYLFZv8rU4
	PPckq8XlXXPYLO6t+c9qcXLWZBaLdxO+sDqwexx+857ZY8GmUo/Fe14yeWz6NInd48SM3ywe
	i198YPL4vEkugD2KyyYlNSezLLVI3y6BK+PriT62gnXGFZc7V7I3MN5S7WLk5JAQMJFYPOkk
	O4jNJqAucePGT2YQW0RAVmLq3/MsXYxcHMwCUxglVtxrZwNJCAskSPxevYYVxGYRUJV4e7wf
	LM4rYCoxacYFRoih8hKrNxwAGsTBwSlgKfGjyw0kLCRgIXFvXgvrBEauBYwMqxhFMvPKchMz
	c0z1irMzKvMyK/SS83M3MQIDY1ntn4k7GL9cdj/EKMDBqMTDO2HNk1Qh1sSy4srcQ4wSHMxK
	Irw1v4BCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb3CUxOEBNITS1KzU1MLUotgskwcnFINjPX7
	6ytzmLLLHqhU9PB+vvt/1pRNb9OXXNm4lnv91ml7XrxcvXBT0IQbzl1yjIkm21a4Raxu4So9
	qPJ7gu75KNnMN5eW1PAf7j/4v1OsUN/BmkfvS6zp1l/is5af18yV8vRtfWx4Szl35euWV5It
	2Z4r0xN0/smcZJBV5JQ5mN41XyZ+//k6biWW4oxEQy3mouJEAMHkLOcIAgAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v5:
	1. Make it retry the kswapd's scan priority loop with
	   cache_trim_mode off *only if* the mode didn't work in the
	   previous loop. (feedbacked by Huang Ying)
	2. Take into account 'break's from the priority loop when making
	   the decision whether to retry. (feedbacked by Huang Ying)
	3. Update the test result in the commit message.

Changes from v4:
	1. Make other scans start with may_cache_trim_mode = 1.

Changes from v3:
	1. Update the test result in the commit message with v4.
	2. Retry the whole priority loop with cache_trim_mode off again,
	   rather than forcing the mode off at the highest priority,
	   when the mode doesn't work. (feedbacked by Johannes Weiner)

Changes from v2:
	1. Change the condition to stop cache_trim_mode.

	   From - Stop it if it's at high scan priorities, 0 or 1.
	   To   - Stop it if it's at high scan priorities, 0 or 1, and
	          the mode didn't work in the previous turn.

	   (feedbacked by Huang Ying)

	2. Change the test result in the commit message after testing
	   with the new logic.

Changes from v1:
	1. Add a comment describing why this change is necessary in code
	   and rewrite the commit message with how to reproduce and what
	   the result is using vmstat. (feedbacked by Andrew Morton and
	   Yu Zhao)
	2. Change the condition to avoid cache_trim_mode from
	   'sc->priority != 1' to 'sc->priority > 1' to reflect cases
	   where the priority goes to zero all the way. (feedbacked by
	   Yu Zhao)

--->8---
From f811ee583158fd53d0e94d32ce5948fac4b17cfe Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Mon, 4 Mar 2024 15:27:37 +0900
Subject: [PATCH v6] mm, vmscan: retry kswapd's priority loop with cache_trim_mode off on failure

With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
pages.  However, it should be more careful to use the mode because it's
going to prevent anon pages from being reclaimed even if there are a
huge number of anon pages that are cold and should be reclaimed.  Even
worse, that leads kswapd_failures to reach MAX_RECLAIM_RETRIES and
stopping kswapd from functioning until direct reclaim eventually works
to resume kswapd.

So kswapd needs to retry its scan priority loop with cache_trim_mode
off again if the mode doesn't work for reclaim.

The problematic behavior can be reproduced by:

   CONFIG_NUMA_BALANCING enabled
   sysctl_numa_balancing_mode set to NUMA_BALANCING_MEMORY_TIERING
   numa node0 (8GB local memory, 16 CPUs)
   numa node1 (8GB slow tier memory, no CPUs)

   Sequence:

   1) echo 3 > /proc/sys/vm/drop_caches
   2) To emulate the system with full of cold memory in local DRAM, run
      the following dummy program and never touch the region:

         mmap(0, 8 * 1024 * 1024 * 1024, PROT_READ | PROT_WRITE,
              MAP_ANONYMOUS | MAP_PRIVATE | MAP_POPULATE, -1, 0);

   3) Run any memory intensive work e.g. XSBench.
   4) Check if numa balancing is working e.i. promotion/demotion.
   5) Iterate 1) ~ 4) until numa balancing stops.

With this, you could see that promotion/demotion are not working because
kswapd has stopped due to ->kswapd_failures >= MAX_RECLAIM_RETRIES.

Interesting vmstat delta's differences between before and after are like:

   +-----------------------+-------------------------------+
   | interesting vmstat    | before        | after         |
   +-----------------------+-------------------------------+
   | nr_inactive_anon      | 321935        | 1664772       |
   | nr_active_anon        | 1780700       | 437834        |
   | nr_inactive_file      | 30425         | 40882         |
   | nr_active_file        | 14961         | 3012          |
   | pgpromote_success     | 356           | 1293122       |
   | pgpromote_candidate   | 21953245      | 1824148       |
   | pgactivate            | 1844523       | 3311907       |
   | pgdeactivate          | 50634         | 1554069       |
   | pgfault               | 31100294      | 6518806       |
   | pgdemote_kswapd       | 30856         | 2230821       |
   | pgscan_kswapd         | 1861981       | 7667629       |
   | pgscan_anon           | 1822930       | 7610583       |
   | pgscan_file           | 39051         | 57046         |
   | pgsteal_anon          | 386           | 2192033       |
   | pgsteal_file          | 30470         | 38788         |
   | pageoutrun            | 30            | 412           |
   | numa_hint_faults      | 27418279      | 2875955       |
   | numa_pages_migrated   | 356           | 1293122       |
   +-----------------------+-------------------------------+

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..6fe45eca7766 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -108,6 +108,12 @@ struct scan_control {
 	/* Can folios be swapped as part of reclaim? */
 	unsigned int may_swap:1;
 
+	/* Not allow cache_trim_mode to be turned on as part of reclaim? */
+	unsigned int no_cache_trim_mode:1;
+
+	/* Has cache_trim_mode failed at least once? */
+	unsigned int cache_trim_mode_failed:1;
+
 	/* Proactive reclaim invoked by userspace through memory.reclaim */
 	unsigned int proactive:1;
 
@@ -2268,7 +2274,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * anonymous pages.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE) &&
+	    !sc->no_cache_trim_mode)
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
@@ -5967,6 +5974,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 */
 	if (reclaimable)
 		pgdat->kswapd_failures = 0;
+	else if (sc->cache_trim_mode)
+		sc->cache_trim_mode_failed = 1;
 }
 
 /*
@@ -6898,6 +6907,16 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 			sc.priority--;
 	} while (sc.priority >= 1);
 
+	/*
+	 * Restart only if it went through the priority loop all the way,
+	 * but cache_trim_mode didn't work.
+	 */
+	if (!sc.nr_reclaimed && sc.priority < 1 &&
+	    !sc.no_cache_trim_mode && sc.cache_trim_mode_failed) {
+		sc.no_cache_trim_mode = 1;
+		goto restart;
+	}
+
 	if (!sc.nr_reclaimed)
 		pgdat->kswapd_failures++;
 
-- 
2.17.1


