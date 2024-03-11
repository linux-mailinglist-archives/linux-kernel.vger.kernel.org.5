Return-Path: <linux-kernel+bounces-99495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D5187892E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0A82B21728
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5075674D;
	Mon, 11 Mar 2024 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="owxgzEgP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0/uvwRh"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3A755E75
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187134; cv=none; b=YQOVNlm7J/plDuL/7bWJx2LlxcRq3Z3ZwMWnWVbaZMxLcNFIB+G42J/+u1nGfNWAmJ8Qt/cOInGODOhgQnOzlp8jQiGfyUo/zA0a3ONsATHOwjVdsGnc6xhOe5vHtt75bwIdGLQPcN8YM7xy1P4AuwKVVFu3AzV5tHENZQds6RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187134; c=relaxed/simple;
	bh=HNBUTAaMykG6ISWX6c10ERvaCy/S6UH8VZlm6dphoJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qkv1wPvvDsbMQMFmKGzzndHPnXIFYUokacPUhKa6NTm3ignj7Nev3NpsJV3oJEBRNVXLO5tSJZ1cNCAdPq9z5j9YnF3vdd8E4bJeMbaUUpHYYZ32dLuLHN/Xdn+THsxQJI+RnFXWejrH58f5xs2a9DBNLbtGIX7RCeaQLxpzgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com; spf=pass smtp.mailfrom=sent.com; dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b=owxgzEgP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d0/uvwRh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sent.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A6EB411400E2;
	Mon, 11 Mar 2024 15:58:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 11 Mar 2024 15:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1710187131; x=
	1710273531; bh=A/MBFnXXdSSgAn+JMHfZprV2OLIqaCRbl8i6tPL49MY=; b=o
	wxgzEgPviaIEemket13I0jAVdGZHZxIDDtw/tQDKpuGKZMhiLYHwwZJoO/1l2coz
	Oa/A478hyUdh4SiG31PGTNntuctQuzT85RXwY76sBHqWiG+JRk/UPIEoSioNFEY0
	RyQ5LaQsyv9Cv8ebPHUOzQVerfANAJXbdcxKD6OQzmKym0StFPr1PJWw7XulUCiC
	d3mt4qrQiSyJyo7M2oKw0bVn5M7bAg49bd2UUMjhv23tFMGrnfO16NNTf6/NxZqg
	cwvEgqR4kNxgq/Qm0jrGZAfxyaogKkz4azmhzddxaSFj1TJfYnOxA2sAecq4cNmg
	kPABiC1PILMJluCdOoFrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1710187131; x=1710273531; bh=A
	/MBFnXXdSSgAn+JMHfZprV2OLIqaCRbl8i6tPL49MY=; b=d0/uvwRhXJgD9iqcn
	WBcsjvIJvpUjudTVTN5GbDN9kf4Nqa7A+v05yqcaDHtbr+zoq93ruVn/WjvzYCjW
	3jahNJJ63N5q9rVWzuGscUNM6U8KCR4RWKzmJtChIxlV/gsxdCLTkJz1Tz5UspTy
	RfHRmgQ9uJjvqowS+wAJsWpm/waTr9L4EBZRCycIz0QxtiDa+sYHCo4szuW4GA9p
	PoW2RpQ1MsWKLBWoCXT4uX99IKUCT2aeT4VxbLnqIhgtMMaMvTjYvECPl5mvLigm
	RVbLtyHLMTIqjhcmFx5m6bCKUVDUD0ArJub6eQiYCsIYwNeebPRr4ePIwAH71mqf
	H3R9w==
X-ME-Sender: <xms:emLvZSAwYgJdPmY8Y9iMIQ60ddpLThDqpzAVk4W6iLL32QO56tyzAQ>
    <xme:emLvZchZgaA2k6sGtU0WhGZW38IdmBkeJ7Xlpjehg30Lf7a9jGD_Y8yjXOBcilj6j
    6G6DYdwEqmPrZw7og>
X-ME-Received: <xmr:emLvZVlCfbmH9tzt006vQ84SkJfZSsJyZZ3fcbTGsYHpMuvalixDsBQVG6__FyowcCk7iTgV8-cz6mTesYhK1WyNgxyBdBk2AHP4JovN7sZqGlKC6QQ-xfdY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgj
    rghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepteduve
    ehteehheeiteeihfejveejledtgfdvieeuiedutefftdevtdfhteevtdffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpeiiihdrhigrnhesshgvnhhtrdgtohhm
X-ME-Proxy: <xmx:emLvZQyi4CCjiEGhhogErpjlmEU5izdNJ0-QS7Qx9w-sI6y-XvQjyQ>
    <xmx:emLvZXSLj9ilgk0CKvyrKmf2B_fzhLkDGWmcGpPeyJjURNvwiR0DaQ>
    <xmx:emLvZbY0P9Sw3khi-n_vuZRVs3PdDitAQb-GJ9z84U6gd0k_98lWGg>
    <xmx:e2LvZc9d0iTwbxy-yeZiA_7d7PnziGBKOA7lzyQ06RTdTfTDKU4fBQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Mar 2024 15:58:50 -0400 (EDT)
From: Zi Yan <zi.yan@sent.com>
To: linux-mm@kvack.org
Cc: Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>,
	Huang Ying <ying.huang@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/migrate: put dest folio on deferred split list if source was there.
Date: Mon, 11 Mar 2024 15:58:48 -0400
Message-ID: <20240311195848.135067-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.43.0
Reply-To: Zi Yan <ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Zi Yan <ziy@nvidia.com>

Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")
did not check if a THP is on deferred split list before migration, thus,
the destination THP is never put on deferred split list even if the source
THP might be. The opportunity of reclaiming free pages in a partially
mapped THP during deferred list scanning is lost, but no other harmful
consequence is present[1]. Checking source folio deferred split list
status before page unmapped and add destination folio to the list if
source was after migration.

[1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C817C@nvidia.com/

From v1:
1. Used dst to get correct deferred split list after migration
   (per Ryan Roberts).

Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 22 ----------------------
 mm/internal.h    | 23 +++++++++++++++++++++++
 mm/migrate.c     | 26 +++++++++++++++++++++++++-
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9859aa4f7553..c6d4d0cdf4b3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 	return pmd;
 }
 
-#ifdef CONFIG_MEMCG
-static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
-{
-	struct mem_cgroup *memcg = folio_memcg(folio);
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	if (memcg)
-		return &memcg->deferred_split_queue;
-	else
-		return &pgdat->deferred_split_queue;
-}
-#else
-static inline
-struct deferred_split *get_deferred_split_queue(struct folio *folio)
-{
-	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
-
-	return &pgdat->deferred_split_queue;
-}
-#endif
-
 void folio_prep_large_rmappable(struct folio *folio)
 {
 	if (!folio || !folio_test_large(folio))
diff --git a/mm/internal.h b/mm/internal.h
index d1c69119b24f..8fa36e84463a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_area_struct *vma,
 				   unsigned long addr, pmd_t *pmd,
 				   unsigned int flags);
 
+#ifdef CONFIG_MEMCG
+static inline
+struct deferred_split *get_deferred_split_queue(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+
+	if (memcg)
+		return &memcg->deferred_split_queue;
+	else
+		return &pgdat->deferred_split_queue;
+}
+#else
+static inline
+struct deferred_split *get_deferred_split_queue(struct folio *folio)
+{
+	struct pglist_data *pgdat = NODE_DATA(folio_nid(folio));
+
+	return &pgdat->deferred_split_queue;
+}
+#endif
+
+
 /*
  * mm/mmap.c
  */
diff --git a/mm/migrate.c b/mm/migrate.c
index 73a052a382f1..591e65658535 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -20,6 +20,7 @@
 #include <linux/pagemap.h>
 #include <linux/buffer_head.h>
 #include <linux/mm_inline.h>
+#include <linux/mmzone.h>
 #include <linux/nsproxy.h>
 #include <linux/ksm.h>
 #include <linux/rmap.h>
@@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst, struct folio *src,
 enum {
 	PAGE_WAS_MAPPED = BIT(0),
 	PAGE_WAS_MLOCKED = BIT(1),
-	PAGE_OLD_STATES = PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
+	PAGE_WAS_ON_DEFERRED_LIST = BIT(2),
+	PAGE_OLD_STATES = PAGE_WAS_MAPPED |
+			  PAGE_WAS_MLOCKED |
+			  PAGE_WAS_ON_DEFERRED_LIST,
 };
 
 static void __migrate_folio_record(struct folio *dst,
@@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
+	if (folio_test_large_rmappable(src) &&
+		!list_empty(&src->_deferred_list)) {
+		struct deferred_split *ds_queue = get_deferred_split_queue(src);
+
+		spin_lock(&ds_queue->split_queue_lock);
+		ds_queue->split_queue_len--;
+		list_del_init(&src->_deferred_list);
+		spin_unlock(&ds_queue->split_queue_lock);
+		old_page_state |= PAGE_WAS_ON_DEFERRED_LIST;
+	}
+
 	if (folio_test_mlocked(src))
 		old_page_state |= PAGE_WAS_MLOCKED;
 
@@ -1307,6 +1322,15 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 	if (old_page_state & PAGE_WAS_MAPPED)
 		remove_migration_ptes(src, dst, false);
 
+	if (old_page_state & PAGE_WAS_ON_DEFERRED_LIST) {
+		struct deferred_split *ds_queue = get_deferred_split_queue(dst);
+
+		spin_lock(&ds_queue->split_queue_lock);
+		ds_queue->split_queue_len++;
+		list_add(&dst->_deferred_list, &ds_queue->split_queue);
+		spin_unlock(&ds_queue->split_queue_lock);
+	}
+
 out_unlock_both:
 	folio_unlock(dst);
 	set_page_owner_migrate_reason(&dst->page, reason);
-- 
2.43.0


