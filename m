Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ECA78E040
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbjH3TM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbjH3Rxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:53:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1D61A3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:53:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58ee4df08fbso604477b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418025; x=1694022825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=ljKhC4jQiCQih/yDtiANEQ8hA1+7EAuiWsX1AFes+wXRzeapdN1Y7tnWGlixQuScOw
         oVS9+aWcP5dG+c1Se2LA2oY+Vl/MvUcTn083xybTe9zmU5NoZoE/DVJPTU6cUtuzV7BU
         nv9Lk2fwBDF3A4R3t0kcW6nX0VW++kTS7zSoWQL/G1O46qoGUH82FLEwfZER6CuVRYG/
         nNso5F6bKRKjwP5Tb5vQJeK4m6OxKt6vsOZZB+xnPcTUkUyUnZY2hwNfnm+r+EQJ27Qv
         1W5yU6Dx6Onwp9PGdcTZ3A9v14Ew9LqUcjWZuTcc1wiyPAF3PMNxFcy+jdM9ogzZqmGS
         VFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418025; x=1694022825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=gJuKVwvQ1SFfPs2p4fD5WC8v7P5uBC+M8VorlwMDop6GHBBlBBhNZ0G8jYos09bbJG
         SvWhQtvudZWLkKebyMdO4zkQSzpH+lITwzv2goJQkzRXKQel6UHKo2Av+EPOFfwYS0GC
         HMJD/Q0Uof8+LLk7uIjVoeq33+4qfEre+9YfsJme/K8jjDSvjWJY+SdCit0r0BzpyKZ7
         viVHLQkb7ILYbohTQYCJk60Bb59pj5yay067xNsdi8gd20uW97FKvoHcWPMvW6Y8ORBw
         5DsTGv3AL1YKMrBxoJgBayyAN7mh1NaU+OFtORAP+0fA38Ed4zjvTDYAqym/p7yPtajb
         frsg==
X-Gm-Message-State: AOJu0Yxl9KQ3Y2NsviJlES99kv0oNPWUaFegFrew4RR79xVs3v4/wgit
        eBGFbLn3q02Lrnf2k5zAPxBm8GnbrxEyZNy3
X-Google-Smtp-Source: AGHT+IHjIqmfPjmTzc3deZ3rYH8rl5Cq8a3bjQb9PwMna3dMgbfSrozthOyv79aDKkmUzbdghxJcDIanu7pcbRLb
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:34c3:0:b0:d0e:e780:81b3 with SMTP
 id b186-20020a2534c3000000b00d0ee78081b3mr78518yba.2.1693418025151; Wed, 30
 Aug 2023 10:53:45 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:53:33 +0000
In-Reply-To: <20230830175335.1536008-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230830175335.1536008-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830175335.1536008-3-yosryahmed@google.com>
Subject: [PATCH v3 2/4] mm: memcg: add a helper for non-unified stats flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some contexts flush memcg stats outside of unified flushing, directly
using cgroup_rstat_flush(). Add a helper for non-unified flushing, a
counterpart for do_unified_stats_flush(), and use it in those contexts,
as well as in do_unified_stats_flush() itself.

This abstracts the rstat API and makes it easy to introduce
modifications to either unified or non-unified flushing functions
without changing callers.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d0ec828a1c4..8c046feeaae7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -639,6 +639,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
+/*
+ * do_stats_flush - do a flush of the memory cgroup statistics
+ * @memcg: memory cgroup to flush
+ *
+ * Only flushes the subtree of @memcg, does not skip under any conditions.
+ */
+static void do_stats_flush(struct mem_cgroup *memcg)
+{
+	cgroup_rstat_flush(memcg->css.cgroup);
+}
+
 /*
  * do_unified_stats_flush - do a unified flush of memory cgroup statistics
  *
@@ -656,7 +667,7 @@ static void do_unified_stats_flush(void)
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	do_stats_flush(root_mem_cgroup);
 
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_unified_flush_ongoing, 0);
@@ -7790,7 +7801,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		do_stats_flush(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7855,8 +7866,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
-	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	do_stats_flush(memcg);
+	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

