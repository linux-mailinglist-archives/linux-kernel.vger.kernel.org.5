Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A677ED94B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjKPCY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344483AbjKPCYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:24:21 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B54B127
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a90d6ab944so4518917b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700101458; x=1700706258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CsQgPePmMbwkmYg1tT46kxvFflY+DocB+A/S3VGDzrg=;
        b=SSq1gjJGYKByfSc1ezcEZl5ZLzu+0Gp49FDvhZLXMmMAZiEzYmtiwWHY9lp5sxFhfN
         ED2X1gOJrbfkbLJpx8GZv/6TfkAOaCaxPdiLOWOzdsyL/YMcCovMr1MS6xWLMuUWgjZ0
         fwtN68iG7IfCfdUGyMD04z+JM8GRrdmSiqE5ajmCC68UCqbQU3MmWQ8r3KgmZjzy+MUL
         AWu40HmAP3acYhQ8bRvC3JvcDGnTTyepgs5en4aSS1s9g62t7PbCqtGp+S7CN1UJ41kg
         WapT3sabVpYTmaQOPOmrrt/m+sFQlvKV1Dar6DQ7H+mzaZoF3Q8TWR/PSDYwFW2NlZW0
         /agg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101458; x=1700706258;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CsQgPePmMbwkmYg1tT46kxvFflY+DocB+A/S3VGDzrg=;
        b=S66DvckMf6f7NiBZi+K0ipHmLZgaLIDfrh781AE9DBmRui3hKjkuBlK77/WAPEye4p
         pd2gNgJAhIJQ2aWV2aH1FKoOUXUdWjxwqe6/wOKQ9RzhY0vwK/GGU89T8KaXeCGLgLc9
         FDS78pTLl8no840pDyY1aTX8WPkzA55u9Hn5+4PtnCsOL2xTIVZTUNus/G6WYMXrnEim
         8JeWy9/GmieJH60iLrg/cW5PAn9+ALOB8mTm/MZnjJwGeOyhlV+N1Br/VOCydU1E05dy
         MlQxAGtito49gvDcOTIr2pvxzycTvv5fXq2/+yKsOQZ/KtLS80nBz7ULWTTaqm3ShAVC
         DZEw==
X-Gm-Message-State: AOJu0YzVnmhAwLm5T0ulVAoW+STB2ctgAT34V7yIIgCyWWzKXuqgqCIv
        5MsoMLWQWHN2eVzRAfi3qPNmruX//qzSwD2Q
X-Google-Smtp-Source: AGHT+IFLy40NOoa1rb6dZOa2HGVCBZYSVTkHt6esqpaY9lO76idIWli3bPfPKtfXVxgT/7MwnEla17Q3y28TlYUG
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a0d:d747:0:b0:5a7:a929:5b1d with SMTP
 id z68-20020a0dd747000000b005a7a9295b1dmr375983ywd.4.1700101457790; Wed, 15
 Nov 2023 18:24:17 -0800 (PST)
Date:   Thu, 16 Nov 2023 02:24:07 +0000
In-Reply-To: <20231116022411.2250072-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231116022411.2250072-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231116022411.2250072-3-yosryahmed@google.com>
Subject: [PATCH v3 2/5] mm: memcg: move vmstats structs definition above
 flushing code
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch will make use of those structs in the flushing code,
so move their definitions (and a few other dependencies) a little bit up
to reduce the diff noise in the following patch.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/memcontrol.c | 146 ++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 18931d82f108f..5ae2a8f04be45 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -573,6 +573,79 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGPGIN,
+	PGPGOUT,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
+#endif
+};
+
+#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
+static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+
+static void init_memcg_events(void)
+{
+	int i;
+
+	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
+		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
+}
+
+static inline int memcg_events_index(enum vm_event_item idx)
+{
+	return mem_cgroup_events_index[idx] - 1;
+}
+
+struct memcg_vmstats_percpu {
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_MEMCG_EVENTS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Non-hierarchical (CPU aggregated) page state & events */
+	long			state_local[MEMCG_NR_STAT];
+	unsigned long		events_local[NR_MEMCG_EVENTS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_MEMCG_EVENTS];
+};
+
 /*
  * memcg and lruvec stats flushing
  *
@@ -684,79 +757,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGPGIN,
-	PGPGOUT,
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSCAN_KHUGEPAGED,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGSTEAL_KHUGEPAGED,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-	THP_SWPOUT,
-	THP_SWPOUT_FALLBACK,
-#endif
-};
-
-#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
-
-static void init_memcg_events(void)
-{
-	int i;
-
-	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
-		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-}
-
-static inline int memcg_events_index(enum vm_event_item idx)
-{
-	return mem_cgroup_events_index[idx] - 1;
-}
-
-struct memcg_vmstats_percpu {
-	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_MEMCG_EVENTS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
-};
-
-struct memcg_vmstats {
-	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_NR_STAT];
-	unsigned long		events_local[NR_MEMCG_EVENTS];
-
-	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_MEMCG_EVENTS];
-};
-
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	long x = READ_ONCE(memcg->vmstats->state[idx]);
-- 
2.43.0.rc0.421.g78406f8d94-goog

