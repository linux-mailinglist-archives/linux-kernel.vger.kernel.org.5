Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160B278F182
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbjHaQ4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbjHaQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:56:22 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E0107
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:19 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68bf27251b7so1190157b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500979; x=1694105779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=1UCvVlVxvkygSVCtxlJldpmxZZ67IB+D3cLFko+rqK7fWxwKANEVqrTdC3bdO2hdQH
         es4uWKrUOUc8aVbcp8xSS1KwmTpi/VUunr1dky9yrxfXXKA6o+7o0xJsILS9R2XpoxhM
         NtXHPvPjAHDx4taXuhGP6vQyl6yU3LrO2RXgzvEySqz5drf9C5xNd72rhbuO2GR/2h4+
         bRoie1iJ0SoIsZZe3GO9LDJ40SPvoP3UnexBDicGWOepvnAHDpVQdYlbRLzDVKvIO5FH
         JItRgGwGgqPMo0Hf60APaYqSN43igGQZHeF793cnsx+gA9w3Do290y6qvYKE1gG1QK8u
         yFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500979; x=1694105779;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnl+F2n1kOs4P011p6EJFvzkt9Ylx9T9gDi6gAnNyhk=;
        b=Ahng+UFTDWme1L+xtTYGWSc+jgjvdgKgwTKQEc0viDpz+wwfIxYPoD1fZ94qIDfOM8
         tFlS9n2RO44b5YbJ0ZoBl4leCOohxIOJ6Mw7e+m4nUpXZk2giTyzOxzeuNYd23MhcMPs
         KBcHPoeuY0vXG9Tu6SSYUes2v2A2bLRxSStku1AFyTlmJqhXqDxhYbVYf7L3nTjRroeQ
         iVVYUOYl5bHiAKXBqw1fuv2dW86qzR3b20lJpPRQXmUFGFI3cQFV3av2yx6+dUcTVQXM
         8k+HZktODIX/a/v+/l/3t+rkfC8ZbtyMg4RVQgtYbqxRGJVtuZ2ln7/1H+OkGPIXdifg
         SJLw==
X-Gm-Message-State: AOJu0YxDtNQn/8FxQ+Vbfn9c/s9ksOHr34kHrGPpa/4MDXcHHFvKDtfF
        4Ugb64Fij+q06/P/oF8Xhe2GNjEuLl/eiWvA
X-Google-Smtp-Source: AGHT+IGQaFV/eoJPD0E5YObQdt63kn1VXtZb+DnEHQpo8u+eLis24QVhJvy1qf6oTqJysoROPjRG5kn0lET0eVSr
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2d87:b0:68b:dbbc:dd00 with
 SMTP id fb7-20020a056a002d8700b0068bdbbcdd00mr86084pfb.0.1693500978729; Thu,
 31 Aug 2023 09:56:18 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:09 +0000
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-3-yosryahmed@google.com>
Subject: [PATCH v4 2/4] mm: memcg: add a helper for non-unified stats flushing
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

