Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFB7E3728
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbjKGJHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjKGJHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:07:46 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC3512A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:07:16 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1ead2e6fab7so3257947fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699348035; x=1699952835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wm0qUqDRJW4jPSWFEatfvbHk2iFZ3worCcvtvRb4Syc=;
        b=ggeePsRLDImPMyvMBNbcMSTrjWgs4vDT636LlCoPqnWg138joj4OODG3DOaoBh9ZKA
         5g2Ssa016Lj+e/9Qhn4he7DPC6ldXrD7W5yUr6V1nROunxE8tDl/ElfpR27BFXBfm6ob
         OEAh/GBRZwGBsnFwhQMer8vvaZr/9bWTQW1TPykYv6NAy8r7BNXcFhPAQHa0Ne2uM+f7
         H+Qk4vi5GbceBXOmshrHOVYpSsdgC9VE/4uwqoB4o8UH3yc5x56efa2Fwcuhz3Zcsj93
         UZT7+cwbzeunysDUgWJdZtOP7tEVvg6gHe+H1+qmT9d+Cy4XImBJRPqHFlZFKQgsQ0vU
         2gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348035; x=1699952835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wm0qUqDRJW4jPSWFEatfvbHk2iFZ3worCcvtvRb4Syc=;
        b=Llnw3Oh47/P9/BTmCXEDHjwGFQ0OzjGHmQVTd5NtXo722hdV+UWCXL3ajqbUApNnlN
         8bmVKqv/zlVjmZHmgTD0CQd1iKTtcF9XNWkl8suyH3TIt3sLkUEOFdITUhbJ9vKod4hR
         PdRXbZ2jBqXCLW/mPm7NfYhos88YCEjZZd6YW1KvomLoPl9VEF5bIIaXoPYZzFRHOdV7
         jsg4jduHXG6P0zXSFeLEfbI9o8qETuswkEG2LdnSdaffs2LjZEkuLqDb5imQM8v13Qg7
         TRoBUyRFUA1FDDQtIkQKg0tnikqxuCau7lMBzB3S3xwC4jbc0IxnAGRDKaoWo1m2tfCM
         5nzQ==
X-Gm-Message-State: AOJu0YyT0HcEHSmLhqsyRVvWCldIcYC24+HQp0a3EEAtAivh2nzYSyhT
        M04b/gQrsq6Fh8R4LDOQsZk9JA==
X-Google-Smtp-Source: AGHT+IEQDiPX+WRXpJLhh1eW6bazUb5GLMbB7ofg9DnPKP2uzbnfxrecnw02CSCxS7I57pTfNTsWpg==
X-Received: by 2002:a05:6870:12d5:b0:1e9:e268:ab6f with SMTP id 21-20020a05687012d500b001e9e268ab6fmr1980703oam.17.1699348035560;
        Tue, 07 Nov 2023 01:07:15 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k27-20020a63ba1b000000b005ab7b055573sm875154pgf.79.2023.11.07.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:07:15 -0800 (PST)
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
Subject: [PATCH 3/4] sched/eevdf: O(1) fastpath for task selection
Date:   Tue,  7 Nov 2023 17:05:09 +0800
Message-Id: <20231107090510.71322-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231107090510.71322-1-wuyun.abel@bytedance.com>
References: <20231107090510.71322-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
index 459487bf8824..a1fdd0c7a051 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -896,6 +896,7 @@ int sched_update_scaling(void)
 static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
 
@@ -904,7 +905,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * in this cfs_rq, saving some cycles.
 	 */
 	if (cfs_rq->nr_running == 1)
-		return curr && curr->on_rq ? curr : __node_2_se(node);
+		return curr && curr->on_rq ? curr : se;
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
@@ -916,9 +917,14 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
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
@@ -931,6 +937,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 			continue;
 		}
 
+		se = __node_2_se(node);
+
 		/*
 		 * The left subtree either is empty or has no eligible
 		 * entity, so check the current node since it is the one
@@ -943,7 +951,7 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 
 		node = node->rb_right;
 	}
-
+found:
 	if (!best || (curr && entity_before(curr, best)))
 		best = curr;
 
-- 
2.37.3

