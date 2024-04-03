Return-Path: <linux-kernel+bounces-129683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEDA896E60
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E07D2842B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834D01474D2;
	Wed,  3 Apr 2024 11:40:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A936B143870
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712144455; cv=none; b=gMzCS0y4/u4LpMtuSyMW1uryBqGJLZXKMFIPLeBn7glo85L63jRjorgaqf5UBbxT15X5915QqAS1uRf8bg9pU5wgCrOsrqW6reVBJBlWr5ShCESylB6JfW1uvfuAV1dVtSigCLi3PjriXOsmNajXssKSft+Tznv24Bf6O6rZiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712144455; c=relaxed/simple;
	bh=t+bHvhKWP5INTGwjx3NA6MZxcRYZobW1o9V8V94OCsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaCqIszj/GB/eRYGoqBpLNgqE27hK6vLpPXyvNmmgSqIwL4sNEk+E8hgJns71LESheARqPRpmznESFVet3tvirrSmhcGsCcUY4SYJclMTXv6L8n+wuddtSwI14nUiiLvyckH/ivTTzjJi/Bz4VE/dxgHJEHDjnoyc87mLKg7ZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C921655;
	Wed,  3 Apr 2024 04:41:24 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 557243F64C;
	Wed,  3 Apr 2024 04:40:51 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Gao Xiang <xiang@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Yang Shi <shy828301@gmail.com>,
	Michal Hocko <mhocko@suse.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH v6 5/6] mm: vmscan: Avoid split during shrink_folio_list()
Date: Wed,  3 Apr 2024 12:40:31 +0100
Message-Id: <20240403114032.1162100-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240403114032.1162100-1-ryan.roberts@arm.com>
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that swap supports storing all mTHP sizes, avoid splitting large
folios before swap-out. This benefits performance of the swap-out path
by eliding split_folio_to_list(), which is expensive, and also sets us
up for swapping in large folios in a future series.

If the folio is partially mapped, we continue to split it since we want
to avoid the extra IO overhead and storage of writing out pages
uneccessarily.

THP_SWPOUT and THP_SWPOUT_FALLBACK counters should continue to count
events only for PMD-mappable folios to avoid user confusion. THP_SWPOUT
already has the appropriate guard. Add a guard for THP_SWPOUT_FALLBACK.
It may be appropriate to add per-size counters in future.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 mm/vmscan.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 00adaf1cb2c3..ffc4553c8615 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1223,11 +1223,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					if (!can_split_folio(folio, NULL))
 						goto activate_locked;
 					/*
-					 * Split folios without a PMD map right
-					 * away. Chances are some or all of the
-					 * tail pages can be freed without IO.
+					 * Split partially mapped folios right
+					 * away. We can free the unmapped pages
+					 * without IO.
 					 */
-					if (!folio_entire_mapcount(folio) &&
+					if (data_race(!list_empty(
+						&folio->_deferred_list)) &&
 					    split_folio_to_list(folio,
 								folio_list))
 						goto activate_locked;
@@ -1240,8 +1241,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 								folio_list))
 						goto activate_locked;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-					count_memcg_folio_events(folio, THP_SWPOUT_FALLBACK, 1);
-					count_vm_event(THP_SWPOUT_FALLBACK);
+					if (nr_pages >= HPAGE_PMD_NR) {
+						count_memcg_folio_events(folio,
+							THP_SWPOUT_FALLBACK, 1);
+						count_vm_event(
+							THP_SWPOUT_FALLBACK);
+					}
 #endif
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
-- 
2.25.1


