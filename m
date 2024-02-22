Return-Path: <linux-kernel+bounces-76004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DA485F1CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB1781F239CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED58A175B5;
	Thu, 22 Feb 2024 07:08:43 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF91F618
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585723; cv=none; b=EfiO3zt5un29o105J4ny6XD+hn4R6v7tmrfxHsUHx5BLE/Xdrmq5lJKyJOFa7b1Jhgw26cC4QrXdyw7aylqfut4v7k5Ale0HHZcLUZS4IwzYy91EHrJywo5Y+kYGqBsqb119861VoRqmB0tH2cbrubv9M21jErffD9/Jxl0mipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585723; c=relaxed/simple;
	bh=nciQXSJniZVIAdsOgOcV7UZkgpBz2ypX5hACg/XuepU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AQCxrqB5RzsXp9GQkBbGj0+MR1Ud9S7JH23rPoDYmZ5f5MtXOxUDUgJJKExcHNQmjuC0dzbnpzwAwqzEhSSKhFcDYm6bhJ9UUJKRvo+2VRSPOOM/cIwO0q1jYWZJzYAWnGazIp87sojuF1aJZPdOJJ/Mc5bDDxYTvzSr5y7dAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-7a-65d6f2eb9aed
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	yuzhao@google.com,
	ying.huang@intel.com
Subject: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high scan priorities
Date: Thu, 22 Feb 2024 16:08:17 +0900
Message-Id: <20240222070817.70515-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJMWRmVeSWpSXmKPExsXC9ZZnke7rT9dSDZ5eVrSYs34Nm8XlXXPY
	LO6t+c9qcXLWZBaLdxO+sDqweizYVOqxeM9LJo9Nnyaxe5yY8ZvF4/MmuQDWKC6blNSczLLU
	In27BK6Mxw+fMhW0KlW8O5nYwPhKqouRk0NCwETi45oHzDD2jEnX2UBsNgF1iRs3foLFRQRk
	Jab+Pc8CYjML1Eks//cRLC4sECpx58JDsHoWAVWJZ807GUFsXgFTifV7NrBDzJSXWL3hAFA9
	F5B9klXi954/UMskJQ6uuMEygZF7ASPDKkahzLyy3MTMHBO9jMq8zAq95PzcTYzAMFhW+yd6
	B+OnC8GHGAU4GJV4eB8wXksVYk0sK67MPcQowcGsJMLLUn4lVYg3JbGyKrUoP76oNCe1+BCj
	NAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVANj99OpF53X7rTdb3rwiln+l/LoVjnn0xOU
	RMOKZVVrJaPmlWc+Suax5FT6lNqzMoav8aFLT8uMfPkNR7+XXdgSO/ebvZ6Z+ay0WSKr5l62
	4txg4tNyYYuUcdQPsVUb+2/Wrzo9scew6sPXkhMbp57S4BA3u1w2p/HTrSc33BSrPt4JLPU8
	/e2/EktxRqKhFnNRcSIAQgW+v/8BAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJMWRmVeSWpSXmKPExsXC5WfdrPv607VUg++PpSzmrF/DZnF47klW
	i8u75rBZ3Fvzn9Xi5KzJLBbvJnxhdWDzWLCp1GPxnpdMHps+TWL3ODHjN4vH4hcfmDw+b5IL
	YIvisklJzcksSy3St0vgynj88ClTQatSxbuTiQ2Mr6S6GDk5JARMJGZMus4GYrMJqEvcuPGT
	GcQWEZCVmPr3PAuIzSxQJ7H830ewuLBAqMSdCw/B6lkEVCWeNe9kBLF5BUwl1u/ZwA4xU15i
	9YYDzBMYORYwMqxiFMnMK8tNzMwx1SvOzqjMy6zQS87P3cQI9Oqy2j8TdzB+uex+iFGAg1GJ
	h/cB47VUIdbEsuLK3EOMEhzMSiK8LOVXUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJ
	pCeWpGanphakFsFkmTg4pRoYV6pGfGiUVfBN+mjAn56+bbVale4N+0eP6rJ2uB/8a5m08vql
	eQWhC3d9ftPheibamev4388GT7fy2bnYuiz2nvz3d7SxeVrq3tNNUS+1Nt8wfrzlza2sG/Id
	d1+nuZ+WreWflVIdP+upfqHk2a+LM45fvKLncemASojMLlFeBf853vf17mZeVWIpzkg01GIu
	Kk4EAHTWec7mAQAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

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
From 07e0baab368160e50b6ca35d95745168aa60e217 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Thu, 22 Feb 2024 14:50:17 +0900
Subject: [PATCH v2] mm, vmscan: don't turn on cache_trim_mode at high scan priorities

With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
pages.  However, it should be more careful to turn on the mode because
it's going to prevent anon pages from being reclaimed even if there are
a huge number of anon pages that are cold and should be reclaimed.  Even
worse, that can lead kswapd_failures to reach MAX_RECLAIM_RETRIES and
stopping kswapd until direct reclaim eventually works to resume kswapd.
So this is more like a bug fix than a performance improvement.

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
   5) Iterate 1) ~ 4) until kswapd stops.

With this, you could eventually see that promotion/demotion are not
working because kswapd has stopped due to ->kswapd_failures >=
MAX_RECLAIM_RETRIES.

Interesting vmstat delta's differences between before and after are like:

   -nr_inactive_anon 321935
   -nr_active_anon 1780700
   -nr_inactive_file 30425
   -nr_active_file 14961
   -pgpromote_success 356
   -pgpromote_candidate 21953245
   -pgactivate 1844523
   -pgdeactivate 50634
   -pgfault 31100294
   -pgdemote_kswapd 30856
   -pgscan_kswapd 1861981
   -pgscan_anon 1822930
   -pgscan_file 39051
   -pgsteal_anon 386
   -pgsteal_file 30470
   -pageoutrun 30
   -numa_hint_faults 27418279
   -numa_pages_migrated 356

   +nr_inactive_anon 1662306
   +nr_active_anon 440303
   +nr_inactive_file 27669
   +nr_active_file 1654
   +pgpromote_success 1314102
   +pgpromote_candidate 1892525
   +pgactivate 3284457
   +pgdeactivate 1527504
   +pgfault 6847775
   +pgdemote_kswapd 2142047
   +pgscan_kswapd 7496588
   +pgscan_anon 7462488
   +pgscan_file 34100
   +pgsteal_anon 2115661
   +pgsteal_file 26386
   +pageoutrun 378
   +numa_hint_faults 3220891
   +numa_pages_migrated 1314102

   where -: before this patch, +: after this patch

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..6eda59fce5ee 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2266,9 +2266,17 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * If we have plenty of inactive file pages that aren't
 	 * thrashing, try to reclaim those first before touching
 	 * anonymous pages.
+	 *
+	 * However, the condition 'sc->cache_trim_mode == 1' all through
+	 * the scan priorties might lead reclaim failure. If it keeps
+	 * MAX_RECLAIM_RETRIES times, then kswapd would get stopped even
+	 * if there are still plenty anon pages to reclaim, which is not
+	 * desirable. So do not use cache_trim_mode when reclaim is not
+	 * smooth e.i. high scan priority.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (sc->priority > 1 && file >> sc->priority &&
+	    !(sc->may_deactivate & DEACTIVATE_FILE))
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
-- 
2.17.1


