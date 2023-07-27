Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F52764920
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjG0HoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjG0Hnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:43:37 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF98965B9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:19 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56c42bb70abso471106eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443437; x=1691048237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3P4jk/DjTpvx9PdAJj920ScGLlcJW6HGkHJHTkHl6A=;
        b=S7FhqPdC6B45lRXe055P5PaVB94tznGk9FrHIpoUyTL61ml7EZmcmoma4G1m8PTLNX
         qNy+xG/t8mZ8BQRoO2wrIto0n1SbVsyupw1IUQDbWg0ss/fGxYr2YQrHj2LrK0eZM3mB
         sijyrWeRuFgWJUOYkTfB86DrJRKy+rO0LluT1ezkA07OZB9v+0ToMXPEJMqFGmU0CxQG
         QgVQPZXhXjWdhJP+Fmn1qGbZuOKCLTw+7cj5vCjF2x7/ezfUNsHM6sP0vFj38UxZ0anZ
         j695g+6unGfMklS8VYfNLUkSH5FMlfOF7hSnLmjmbwri1KBrbOCAgTOH+vNyhE6URK9S
         DZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443437; x=1691048237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3P4jk/DjTpvx9PdAJj920ScGLlcJW6HGkHJHTkHl6A=;
        b=QyKqZUTDbzdbKt2Q41hlDw/TFfI+3M52CvjZZRZSnUygmBH9/oITMkDpsEJnO+O4zz
         G89/QyNV4Kbfunsk8z3KM1lIkwSpL9/M19oVi8D3gr4q49VKlm9XeZqMs4g+13xMc3cP
         UnMV57uCuUrUF6sBIs4p84sKbjNX33yyjtQApOESDzTtwIeHcaFn7rOH/h4Om8TOLdbM
         Q1Lv7LsLrMJkWtstCvvuZYkS1LBoM+7rSkqCg0F9kWco4T1HepBlcjOi6myEfLAcW0BZ
         jN1ZbxBS4kkXWS4tqG+BKq+PqZRh1qV7svptUM0U0V/LhwwC2KM0xlGtUnQ0zbVD8Z9I
         KHrQ==
X-Gm-Message-State: ABy/qLYiF1aAIEYZPAgP+7XluQZbsKHcjd/bGrIIg/mEcZVi1oKn3Q3Q
        NDfn9zv4QAEZdKQHNIgiNf0dfQ==
X-Google-Smtp-Source: APBJJlFrA6OYIMUCXYDHSgYayAl8YdYfMGMS0d7a5pDMpWYTJUyDMEysjTkvW4PpsPS4YlTUh2iBZg==
X-Received: by 2002:a05:6358:5915:b0:135:4003:7851 with SMTP id g21-20020a056358591500b0013540037851mr2343798rwf.19.1690443437625;
        Thu, 27 Jul 2023 00:37:17 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:17 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 2/5] mm: Select victim memcg using bpf prog
Date:   Thu, 27 Jul 2023 15:36:29 +0800
Message-Id: <20230727073632.44983-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch use BPF prog to bypass the default select_bad_process method
and select a victim memcg when gobal oom is invoked. Specifically, we
iterate root_mem_cgroup's children and select a next iteration root
through __bpf_run_oom_policy(). Repeat until we finally find a leaf
memcg in the last layer. Then we use oom_evaluate_task() to find a
victim task in the selected memcg. If there are no suitable process
to be killed in the memcg, we go back to the default method.

Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/memcontrol.h |  6 +++++
 mm/memcontrol.c            | 50 ++++++++++++++++++++++++++++++++++++++
 mm/oom_kill.c              | 17 +++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..7fedc2521c8b 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1155,6 +1155,7 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+struct mem_cgroup *select_victim_memcg(void);
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1588,6 +1589,11 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+
+static inline struct mem_cgroup *select_victim_memcg(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..c6b42635f1af 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -64,6 +64,7 @@
 #include <linux/psi.h>
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
+#include <linux/bpf_oom.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -2638,6 +2639,55 @@ void mem_cgroup_handle_over_high(void)
 	css_put(&memcg->css);
 }
 
+struct mem_cgroup *select_victim_memcg(void)
+{
+	struct cgroup_subsys_state *pos, *parent, *victim;
+	struct mem_cgroup *victim_memcg;
+
+	parent = &root_mem_cgroup->css;
+	victim_memcg = NULL;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return NULL;
+
+	rcu_read_lock();
+	while (parent) {
+		struct cgroup_subsys_state *chosen = NULL;
+		struct mem_cgroup *pos_mem, *chosen_mem;
+		u64 chosen_id, pos_id;
+		int cmp_ret;
+
+		victim = parent;
+
+		list_for_each_entry_rcu(pos, &parent->children, sibling) {
+			pos_id = cgroup_id(pos->cgroup);
+			if (!chosen)
+				goto chose;
+
+			cmp_ret = __bpf_run_oom_policy(chosen_id, pos_id);
+			if (cmp_ret == BPF_OOM_CMP_GREATER)
+				continue;
+			if (cmp_ret == BPF_OOM_CMP_EQUAL) {
+				pos_mem = mem_cgroup_from_css(pos);
+				chosen_mem = mem_cgroup_from_css(chosen);
+				if (page_counter_read(&pos_mem->memory) <=
+					page_counter_read(&chosen_mem->memory))
+					continue;
+			}
+chose:
+			chosen = pos;
+			chosen_id = pos_id;
+		}
+		parent = chosen;
+	}
+
+	if (victim && css_tryget(victim))
+		victim_memcg = mem_cgroup_from_css(victim);
+	rcu_read_unlock();
+
+	return victim_memcg;
+}
+
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			unsigned int nr_pages)
 {
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 01af8adaa16c..b88c8c7d4ee4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -361,6 +361,19 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	return 1;
 }
 
+static bool bpf_select_bad_process(struct oom_control *oc)
+{
+	struct mem_cgroup *victim_memcg;
+
+	victim_memcg = select_victim_memcg();
+	if (victim_memcg) {
+		mem_cgroup_scan_tasks(victim_memcg, oom_evaluate_task, oc);
+		css_put(&victim_memcg->css);
+	}
+
+	return !!oc->chosen;
+}
+
 /*
  * Simple selection loop. We choose the process with the highest number of
  * 'points'. In case scan was aborted, oc->chosen is set to -1.
@@ -372,6 +385,9 @@ static void select_bad_process(struct oom_control *oc)
 	if (is_memcg_oom(oc))
 		mem_cgroup_scan_tasks(oc->memcg, oom_evaluate_task, oc);
 	else {
+		if (bpf_oom_policy_enabled() && bpf_select_bad_process(oc))
+			return;
+
 		struct task_struct *p;
 
 		rcu_read_lock();
@@ -1426,3 +1442,4 @@ bool bpf_oom_policy_enabled(void)
 	rcu_read_unlock();
 	return !empty;
 }
+
-- 
2.20.1

