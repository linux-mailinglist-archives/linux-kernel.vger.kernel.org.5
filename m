Return-Path: <linux-kernel+bounces-163393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DF48B6A33
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4E2280F01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DDB1B5A0;
	Tue, 30 Apr 2024 06:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rotHBScM"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74CA3FBAA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457210; cv=none; b=Ucc4BMZ+OTvXQoWEvVTkShZ3GdDLe3IyHWH65wcxvfUKEf4jkyzFBcSexxDn6luYwrreN7U+t0pYmVTXEVBdpe/t70xbNINoWDexmCFcCvql3ZWHrI/bNRftGHpZHN1gS/WaM67mLdFYUT/fU+D9uvQL67Fv6oxMj2O7wcbRGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457210; c=relaxed/simple;
	bh=M6Cfe210NCjI1yL10FhmrelwHlZmt4J9rn9QcetojBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJClAvN+/C/k+Cl/FulFXzkkIi7/8E+U47hcfx8/vtL6l1djW3MVWbFdZVPTC3zbEFsgitBaJZVTO1fkpu0mOiAGXad5bQdUPcz1dZVHzUXTwc/TNNjcnx5TYDtjpQ5ovfOdtK1tLhLD/ByuTQiOQS0qYtNnxwHhuTL/uh3NnaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rotHBScM; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oQu7rbPfAQy6XdrYuqRfpS3viClFCHuzUf1lmpnIBnw=;
	b=rotHBScM1JlySEyfeor2cpEW+V9EK+9UeCwpDcgSfKbo+f1dWWgvcQN7mi7VyWHyq1/fRf
	IzfXcU8ln7O4xZudZdXn5uue6q1VbcyhdHtiuhipO4lqg7CJmp+yB/63oyYllZKOXFUrxN
	tFEkBtSRbv0k1HFIJIKt5si+4wW9Xvk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] memcg: use proper type for mod_memcg_state
Date: Mon, 29 Apr 2024 23:06:12 -0700
Message-ID: <20240430060612.2171650-9-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-1-shakeel.butt@linux.dev>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats update functions can take arbitrary integer but the
only input which make sense is enum memcg_stat_item and we don't
want these functions to be called with arbitrary integer, so replace
the parameter type with enum memcg_stat_item and compiler will be able
to warn if memcg stat update functions are called with incorrect index
value.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Change since v2:
- Fixed whitespace issue based on TJ's suggestion.

 include/linux/memcontrol.h | 13 +++++++------
 mm/memcontrol.c            |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ab8a6e884375..030d34e9d117 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -974,7 +974,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
 
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		       int val);
 
 /* try to stablize folio_memcg() for all the pages in a memcg */
 static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
@@ -995,7 +996,7 @@ static inline void mem_cgroup_unlock_pages(void)
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   int idx, int val)
+				   enum memcg_stat_item idx, int val)
 {
 	unsigned long flags;
 
@@ -1005,7 +1006,7 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 }
 
 static inline void mod_memcg_page_state(struct page *page,
-					int idx, int val)
+					enum memcg_stat_item idx, int val)
 {
 	struct mem_cgroup *memcg;
 
@@ -1491,19 +1492,19 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 }
 
 static inline void __mod_memcg_state(struct mem_cgroup *memcg,
-				     int idx,
+				     enum memcg_stat_item idx,
 				     int nr)
 {
 }
 
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   int idx,
+				   enum memcg_stat_item idx,
 				   int nr)
 {
 }
 
 static inline void mod_memcg_page_state(struct page *page,
-					int idx, int val)
+					enum memcg_stat_item idx, int val)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 72e36977a96e..f5fc16b918ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -956,7 +956,8 @@ static int memcg_state_val_in_pages(int idx, int val)
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		       int val)
 {
 	int i = memcg_stats_index(idx);
 
-- 
2.43.0


