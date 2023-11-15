Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4187EBC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjKODiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbjKODiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:38:02 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A766FF7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:35 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso4047195a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700019455; x=1700624255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=782xl0ixEcaMsR3OW1SEfy7sX5L5c4L0uPuoo+x1uDU=;
        b=hzxXhYCtzc7NPYbisVjdcNMdyUQlerZTIH7pf8OJrf9FrSXK2Phhq1mepNY2iAPAlj
         J+ehnbo23wqh2WUmv5SK+GvkrxiCI2zpKOvfAafgbav0qscQdMM9Pg2r2GLpcZvo+tmI
         Cz5ijif4Zwut4WPSLrMZBd+NlkxL5PpcqnBZmw8U8a+HetFVMNWk/ESSxTnoTtVerwNM
         1C5p03v86E5bFd7Yr5mPBe0H0m0gliI47h0WMOiBn2tjTTjSB0TJgJhkQjX9buFZOU1s
         q3qF/qVPUjaFHmoVxu3qg26bpGl/pTh3fJtQHZ23UQykFkBc+6lNLvRKajVXTTC5o2YJ
         OWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019455; x=1700624255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=782xl0ixEcaMsR3OW1SEfy7sX5L5c4L0uPuoo+x1uDU=;
        b=TlFeBwN0aFnhoxZ5ossmWXNcjzsFXcqHLnxMewTAPpRYdNJkIXao90uPuuDTU769pp
         /PDsGG/wwyDgITusmXsYnxhc03p6vQCMZg/+ue2KO09ww14/EPVtQwKRhS3etKn0O7WD
         LOy/3EMTLmFQxDbCSstiYdNZLLSPvs/7KGnUxVNktIYA/4H/HWs2OsMwJDDLzQtmT2TY
         z7PIm1JKXVDTdcX931SqBFmH1cxiEmnvP22iG7Q6bc05xLkhkqYGVT5himjaDV82+L3+
         85vJmMP05jAKJSvz2hnC/3Ik+OaoKdnR3ZipWHP+pAdcJnKUbjNT2nWsR49eHxUCWhg3
         CYtA==
X-Gm-Message-State: AOJu0YxgIVVKcIfwBHrH26OAqdfUFVQf4PEkymicC+CtlsJ0AssR3NF9
        fAe2K1PZkotcSjLbYZWQU0fzvw==
X-Google-Smtp-Source: AGHT+IHzwmgpedAeYs7JSP8A1zsAz92kv65lWse3717KkOZyjf5mMtzYAcDWqJ35y2JIgt7tnmj3+w==
X-Received: by 2002:a05:6a20:d429:b0:16c:b5ce:50f with SMTP id il41-20020a056a20d42900b0016cb5ce050fmr9230882pzb.32.1700019455159;
        Tue, 14 Nov 2023 19:37:35 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001b9da42cd7dsm6419529plk.279.2023.11.14.19.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:34 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 3/4] sched/eevdf: O(1) fastpath for task selection
Date:   Wed, 15 Nov 2023 11:36:46 +0800
Message-Id: <20231115033647.80785-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231115033647.80785-1-wuyun.abel@bytedance.com>
References: <20231115033647.80785-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the RB-tree is now sorted by deadline, let's first try the
leftmost entity which has the earliest virtual deadline. I've done
some benchmarks to see its effectiveness.

All the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled, on a dual-CPU Intel Xeon(R)
Platinum 8260 with 2 NUMA nodes each of which has 24C/48T.

  hackbench: process/thread + pipe/socket + 1/2/4/8 groups
  netperf:   TCP/UDP + STREAM/RR + 24/48/72/96/192 threads
  tbench:    loopback 24/48/72/96/192 threads
  schbench:  1/2/4/8 mthreads

  direct:    cfs_rq has only one entity
  parity:    RUN_TO_PARITY
  fast:      O(1) fastpath
  slow:	     heap search

    (%)		direct	parity	fast	slow
  hackbench	92.95	2.02	4.91	0.12
  netperf	68.08	6.60	24.18	1.14
  tbench	67.55	11.22	20.61	0.62
  schbench	69.91	2.65	25.73	1.71

The above results indicate that this fastpath really makes task
selection more efficient.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e1d686196528..4197258b76ab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -878,6 +878,7 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
@@ -886,7 +887,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * in this cfs_rq, saving some cycles.
 	 */
 	if (cfs_rq->nr_running == 1)
-		return curr && curr->on_rq ? curr : __node_2_se(node);
+		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
@@ -898,9 +899,14 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
 		return curr;
 
+	/* Pick the leftmost entity if it's eligible */
+	if (se && entity_eligible(cfs_rq, se)) {
+		best = se;
+		goto found;
+	}
+
 	/* Heap search for the EEVD entity */
 	while (node) {
-		struct sched_entity *se = __node_2_se(node);
 		struct rb_node *left = node->rb_left;
 
 		/*
@@ -913,6 +919,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 			continue;
 		}
 
+		se = __node_2_se(node);
+
 		/*
 		 * The left subtree either is empty or has no eligible
 		 * entity, so check the current node since it is the one
@@ -925,7 +933,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 
 		node = node->rb_right;
 	}
-
+found:
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
-- 
2.37.3

