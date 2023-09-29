Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB07B3950
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjI2SB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjI2SBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 14:01:25 -0400
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148321AE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 11:01:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696010477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i5Ua/wdmvBo/wu1nXQ0Cl5cuox9DFv/B5F3hb3WMJFo=;
        b=iy2KaghVwmRlwfpu6b7+AOhBWIOkmf5hD6kyAjLMK5XlcnnjDizfH24Jr/mHe5sgea67k7
        4WiyJ8S09oEuEbj4kODKMMxIn9KtFUE1gjaYCUzSTGsq7ELsKoT6yLcMwvrxUsNOMZ4P39
        APJaRZfIVaJdT9iKHDsVsLui/4J0bOY=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 1/5] mm: kmem: optimize get_obj_cgroup_from_current()
Date:   Fri, 29 Sep 2023 11:00:51 -0700
Message-ID: <20230929180056.1122002-2-roman.gushchin@linux.dev>
In-Reply-To: <20230929180056.1122002-1-roman.gushchin@linux.dev>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manually inline memcg_kmem_bypass() and active_memcg() to speed up
get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
and active_memcg() readings.

Also add a likely() macro to __get_obj_cgroup_from_memcg():
obj_cgroup_tryget() should succeed at almost all times except a very
unlikely race with the memcg deletion path.

Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9741d62d0424..16ac2a5838fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1068,19 +1068,6 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_mm);
 
-static __always_inline bool memcg_kmem_bypass(void)
-{
-	/* Allow remote memcg charging from any context. */
-	if (unlikely(active_memcg()))
-		return false;
-
-	/* Memcg to charge can't be determined. */
-	if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
-		return true;
-
-	return false;
-}
-
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -3007,7 +2994,7 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 
 	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
 		objcg = rcu_dereference(memcg->objcg);
-		if (objcg && obj_cgroup_tryget(objcg))
+		if (likely(objcg && obj_cgroup_tryget(objcg)))
 			break;
 		objcg = NULL;
 	}
@@ -3016,16 +3003,23 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 
 __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
-	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
-	if (memcg_kmem_bypass())
-		return NULL;
+	if (in_task()) {
+		memcg = current->active_memcg;
+
+		/* Memcg to charge can't be determined. */
+		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
+			return NULL;
+	} else {
+		memcg = this_cpu_read(int_active_memcg);
+		if (likely(!memcg))
+			return NULL;
+	}
 
 	rcu_read_lock();
-	if (unlikely(active_memcg()))
-		memcg = active_memcg();
-	else
+	if (!memcg)
 		memcg = mem_cgroup_from_task(current);
 	objcg = __get_obj_cgroup_from_memcg(memcg);
 	rcu_read_unlock();
-- 
2.42.0

