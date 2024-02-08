Return-Path: <linux-kernel+bounces-57503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FE84D9E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D032B1F23BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEC67C7E;
	Thu,  8 Feb 2024 06:18:50 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF7D67C70
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373129; cv=none; b=DYa6ivFnb19gySzfmFwyyiooe1p28kWyKoN84qgf46wihTgrvp0BpCtYD8JKq9uUpJN6NfXOAfbqdVVvB9gnThJitt+Dz2myZAeePeQBjHx44rSYpIG1KI3fidIWP8pVqFLEOjOKNDcfiTlreevirPdqM3+lbLdlhWoyyCzM3Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373129; c=relaxed/simple;
	bh=jrWzJay/sTsuzrPvK8L2TqysXsAVN52IkjoORxSCyoc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C+u7d8nvzz+xzGqzEmccynIHnwzH4Gev4JRDNGQJzfZZdIoJnu7kTFX+6dR8HWLfMmFtnIsDL32Mw8endgCsQd95GhMU6mDo7xQpdpxYOxwnppGLCpW+iww//oBXudfdWGvsyMtzMw/NakZFPVCSeCVLdP3aw/VnH34cMRpHGHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-2b-65c4723b6356
From: Byungchul Park <byungchul@sk.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel_team@skhynix.com
Subject: [PATCH] mm, vmscan: Don't turn on cache_trim_mode at the highest scan priority
Date: Thu,  8 Feb 2024 15:18:25 +0900
Message-Id: <20240208061825.36640-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJMWRmVeSWpSXmKPExsXC9ZZnka5N0ZFUg1UfJCzmrF/DZnF51xw2
	i3tr/rM6MHts+jSJ3ePEjN8sHp83yQUwR3HZpKTmZJalFunbJXBlHJu8jr3gCkfFod4zTA2M
	vexdjJwcEgImEjOm9MHZ6+eeZwWx2QTUJW7c+MkMYosIyEpM/XueBcRmFgiUWH5oDVhcWCBc
	Ysm9TkYQm0VAVeLB0+Ngc3gFTCWu/v7MCjFTXmL1hgNA9VxA9jpWiQffT7FAJCQlDq64wTKB
	kXsBI8MqRqHMvLLcxMwcE72MyrzMCr3k/NxNjEAfL6v9E72D8dOF4EOMAhyMSjy8J8oPpwqx
	JpYVV+YeYpTgYFYS4TXbcSBViDclsbIqtSg/vqg0J7X4EKM0B4uSOK/Rt/IUIYH0xJLU7NTU
	gtQimCwTB6dUA6ON5jHj7zvaa002/furxs4g9rbkQf+cmC+JpfENlXLTXD/82N36YGJJZ/Oa
	eSsfVh7vivDMCJjEIMn1rWFlX8yPpikngtJt+TTOKMhanz7OUrlH8sUvHe0XaS+5u5dfTD6f
	p5Gmr58Qk+qhZTDT1iBFSPra5kU7765o/al/kX9O9BeZbg1eEyWW4oxEQy3mouJEAIWV+Ert
	AQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJMWRmVeSWpSXmKPExsXC5WfdrGtddCTVYM05OYs569ewWRyee5LV
	4vKuOWwW99b8Z3Vg8dj0aRK7x4kZv1k8Fr/4wOTxeZNcAEsUl01Kak5mWWqRvl0CV8axyevY
	C65wVBzqPcPUwNjL3sXIySEhYCKxfu55VhCbTUBd4saNn8wgtoiArMTUv+dZQGxmgUCJ5YfW
	gMWFBcIlltzrZASxWQRUJR48PQ42h1fAVOLq78+sEDPlJVZvOMA8gZFjASPDKkaRzLyy3MTM
	HFO94uyMyrzMCr3k/NxNjECPLav9M3EH45fL7ocYBTgYlXh4T5QfThViTSwrrsw9xCjBwawk
	wmu240CqEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTUgtQimCwTB6dUA6PF
	05Ip4pI/TQUn5RtKPZt3KYdnUirbYhurZNYkxw+3XvbV5ske+K15iedigu/M6qKUtC+xO4x2
	PpNeVO4lqDyj9/yGZ3qnu8Xfnd1zLvDhqZOVi1ZImWawKV9WEcuUKIgylsm4lb+CLzwk7UVA
	bekXiZsb5xyRjHO9bbH0aPLZZ0/POMQ/jFViKc5INNRiLipOBAC6SBcS1AEAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

With cache_trim_mode on, reclaim logic doesn't bother reclaiming anon
pages. However, it should be more careful to turn on the mode because
it's going to prevent anon pages from reclaimed even if there are huge
ammount of anon pages that are very cold so should be reclaimed. Even
worse, that can lead kswapd_failures to be MAX_RECLAIM_RETRIES and stop
until direct reclaim eventually works to resume kswapd.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index bba207f41b14..25b55fdc0d41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2268,7 +2268,8 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * anonymous pages.
 	 */
 	file = lruvec_page_state(target_lruvec, NR_INACTIVE_FILE);
-	if (file >> sc->priority && !(sc->may_deactivate & DEACTIVATE_FILE))
+	if (sc->priority != 1 && file >> sc->priority &&
+	    !(sc->may_deactivate & DEACTIVATE_FILE))
 		sc->cache_trim_mode = 1;
 	else
 		sc->cache_trim_mode = 0;
-- 
2.17.1


