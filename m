Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB17C8466
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjJMLat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjJMLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:30:47 -0400
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F21BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:30:42 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 39DBUXrv083164;
        Fri, 13 Oct 2023 19:30:33 +0800 (+08)
        (envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4S6PN53R5wz2KWZZn;
        Fri, 13 Oct 2023 19:26:29 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 13 Oct 2023 19:30:31 +0800
From:   "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@kernel.org>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        <steve.kang@unisoc.com>
Subject: [RFC PATCH 1/1] mm: only use old generation and stable tier for madv_pageout
Date:   Fri, 13 Oct 2023 19:30:28 +0800
Message-ID: <20231013113028.2720996-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.73.40]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 39DBUXrv083164
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Dropping pages of young generation or unstable tier via madvise could
make the system experience heavy page thrashing and IO pressure.
Furthermore, it could lead to failure of tier's PID controller which
affect normal reclaiming. I would like suggest skipping this pages in
madv_pageout.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/swap.h |  1 +
 mm/madvise.c         | 12 ++++++++++++
 mm/vmscan.c          |  3 ++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 493487ed7c38..d09c859ccc45 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -496,6 +496,7 @@ extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
 extern void exit_swap_address_space(unsigned int type);
 extern struct swap_info_struct *get_swap_device(swp_entry_t entry);
 sector_t swap_page_sector(struct page *page);
+extern int get_tier_idx(struct lruvec *lruvec, int type);
 
 static inline void put_swap_device(struct swap_info_struct *si)
 {
diff --git a/mm/madvise.c b/mm/madvise.c
index 4dded5d27e7e..324d76096ca5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -452,6 +452,18 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (!folio || folio_is_zone_device(folio))
 			continue;
 
+		if (lru_gen_enabled() && pageout) {
+			int gen = folio_lru_gen(folio);
+			struct lruvec *lruvec = folio_lruvec(folio);
+			int type = folio_is_file_lru(folio);
+			int refs = folio_lru_refs(folio);
+			int tier = lru_tier_from_refs(refs);
+			int tier_st = get_tier_idx(lruvec, type);
+
+			if (gen > lru_gen_from_seq(lruvec->lrugen.min_seq[type]) + 1
+				|| tier > tier_st)
+				continue;
+		}
 		/*
 		 * Creating a THP page is expensive so split it only if we
 		 * are sure it's worth. Split it if we are only owner.
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..16900a8c13e0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5072,7 +5072,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 	return isolated || !remaining ? scanned : 0;
 }
 
-static int get_tier_idx(struct lruvec *lruvec, int type)
+int get_tier_idx(struct lruvec *lruvec, int type)
 {
 	int tier;
 	struct ctrl_pos sp, pv;
@@ -5091,6 +5091,7 @@ static int get_tier_idx(struct lruvec *lruvec, int type)
 
 	return tier - 1;
 }
+EXPORT_SYMBOL_GPL(get_tier_idx);
 
 static int get_type_to_scan(struct lruvec *lruvec, int swappiness, int *tier_idx)
 {
-- 
2.25.1

