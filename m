Return-Path: <linux-kernel+bounces-165651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 374668B8F0A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854F1B233B8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275E8130ADD;
	Wed,  1 May 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YISvIA9+"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6024130AD7
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584415; cv=none; b=MsfA+qoSAB6i+HyK42CSBZsaVxgGqwSJi+tVcRoNsIrorDaztiC34magI7UQEruFf3UTUD+RTvcLqk0wWQsMpHCWv45OQgAZVL24Btob5Sr582c2o4HLlaB7E7XRcLyfW1dPPw6jb7zPp377sRVOpmPcvJGCI1f+TYBftToRlms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584415; c=relaxed/simple;
	bh=eP1W92OTQ6cRKMV+qVyniJGTP4MXmCQjFzRqpGKdWoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNDqslJUF9Jsb979Z8gIEUoq72CoPaEvrLF4gwleT8tSQOJUz8MgbFoYLEyYy4rTekuh1R5em/U/O0SqeTdEOyuSsFZemKzGeGgROMmZcWLl+J+pl7R2hqBGm9pZ2hQKINGnHIDCopXe8VPCeEXc3q1uIXJ99nibG+sx7EoXNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YISvIA9+; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCoAbtrV5bh5IqBSP9ezmAWDh3uY8sBNqfpz/AA9bcI=;
	b=YISvIA9+kLtsFEh8MdixEMDSsd8PoXaMrMDODnf1eEjM6JbuLCUks/ImDQ8J8NJ2jIUepy
	HiLDsiFIiMZF5j0TtXoAglBooeB6fZvdFyN7ggcqruY6WnAoev3cXxwgDUVNyvSM4NV8On
	wbeqCV6XdRAOfOrUrhbc9rSs7VW6dGg=
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
Subject: [PATCH v4 8/8] memcg: use proper type for mod_memcg_state
Date: Wed,  1 May 2024 10:26:17 -0700
Message-ID: <20240501172617.678560-9-shakeel.butt@linux.dev>
In-Reply-To: <20240501172617.678560-1-shakeel.butt@linux.dev>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
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
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v3:
- N/A

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
index b4a1b4bb599d..39f8b0df46f6 100644
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


