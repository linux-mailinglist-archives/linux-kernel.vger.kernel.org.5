Return-Path: <linux-kernel+bounces-154526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557C8ADD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163F8281CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FAA208BC;
	Tue, 23 Apr 2024 05:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kg8z/ycj"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE64208A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713849758; cv=none; b=PAv8z6ripWSotpaR1X8RYLEhLWWDcupxAIm/Jpw/GTxe7a9s8o/654/qYOgWWpvIzjMXEdD+EDCKvwEeHog+1iFcRsogq6fVzHHb6xhrO4NmwETH+JiikBucwcBZbpk8qnnYu9TY18Z0CwkWGtgocuY4ixuGQJnfo9PxmlFEkJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713849758; c=relaxed/simple;
	bh=9+XuYwg1r6PRnCEmtK+CYEcGE0jqRe3sapQcSZS+jlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDhW7XcgKeE9SOLf0sgc8tqUeEVNjfCE7lkHmsCaTLLgsfcJBglV/IiGK+z7bab79pd8FculE/cHlRwnKW5WXx860ARDG8dlEhgx9fvPk55aIzfiUDhqLPhWtFoFb0wUI66deRZz3mwbVJrjAgBDdXmyVmqEAnah3bgkyfh/X38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kg8z/ycj; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713849755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvtrhcgh7fYw/hL4J7A9xLofIUItI4MUTx9KgzBK7Qg=;
	b=Kg8z/ycj3MaZtANqRXeXZ1V1ivb5UyCYaTC6fzquwAx9gFlUEGBEKvzgDhNh7mEcTNL/k3
	WRxxJuWwU3W+VgCJtRWkcSRsf/BEniqbK3VdB4qrShdr0rH/A2X69hcvnsLCoYAK8V9K8T
	zT2Y0SQoTIKTxVMMBKi3pnG3FszC4P0=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] memcg: use proper type for mod_memcg_state
Date: Mon, 22 Apr 2024 22:22:27 -0700
Message-ID: <20240423052227.804788-1-shakeel.butt@linux.dev>
In-Reply-To: <20240423051826.791934-1-shakeel.butt@linux.dev>
References: <20240423051826.791934-1-shakeel.butt@linux.dev>
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
 include/linux/memcontrol.h | 13 +++++++------
 mm/memcontrol.c            |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d68db7a0e829..1b4a6201c78c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -991,7 +991,8 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 void folio_memcg_lock(struct folio *folio);
 void folio_memcg_unlock(struct folio *folio);
 
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val);
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item  idx,
+		       int val);
 
 /* try to stablize folio_memcg() for all the pages in a memcg */
 static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
@@ -1012,7 +1013,7 @@ static inline void mem_cgroup_unlock_pages(void)
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   int idx, int val)
+				   enum memcg_stat_item idx, int val)
 {
 	unsigned long flags;
 
@@ -1022,7 +1023,7 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
 }
 
 static inline void mod_memcg_page_state(struct page *page,
-					int idx, int val)
+					enum memcg_stat_item idx, int val)
 {
 	struct mem_cgroup *memcg;
 
@@ -1541,19 +1542,19 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
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
index bb1bbf417a46..4e991e913393 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -816,7 +816,8 @@ static int memcg_state_val_in_pages(int idx, int val)
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
+void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+		       int val)
 {
 	if (mem_cgroup_disabled())
 		return;
-- 
2.43.0


