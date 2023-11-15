Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881BD7EBC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjKODhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbjKODhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:37:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49EE4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b5af4662b7so5606358b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700019462; x=1700624262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyoiUQBgcyNRGwstcopIfmNH6aSfBuLyH/TrScFe48c=;
        b=emlavt45PVVibqkVPzPNGY/PJZFuhD3KoG+Kmkuq6kDW2kwo2ZLZ/FVCeMSGpcXoci
         BQT03VLR7rfcEkxCIU5vC+nMd03dTsVIWapX6O0YIPsp3m+wfpRbieHWtvNw+CXhMsOa
         PIsPyNJWJZDesZN36wOqlv4KlWNtaAeuoUNub2d6ik6/pZUFRsMBHpiVxbhVdug0f+3p
         /uCNo8fjYbt5Di2q5e57omXj+pb0/HNsXjFmdp5AsSnEcAoxY2nwTL+2sAQUFaxmtfyv
         OjCLZA1jnkAgch2QU7vHJGo84C3FlysEDI5G/AeQVIo8B3G9E0zQAcWx3J5ecTJDWZG/
         6ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019462; x=1700624262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyoiUQBgcyNRGwstcopIfmNH6aSfBuLyH/TrScFe48c=;
        b=lrahp5K2k9j2wDRWDxumHYDVs2e7HJPKz3msqAozjm2dCjRY8uwX40mPj3XxtvBBFh
         C4BnetI9jgiAaUhQkH3G6O/3iIvSZVQHUx5xEWVxtSYQXcLfsQSFWvY6O0Bd6W645emh
         Ex4GNcrgweO+JgkdzuTByR0nrU4cDH67BKAHxoBpmHBCgHYrLSd8DmhuIVZn/EZDfdrE
         INtXutfxmtwn+GWdp5pUQCHFXCFEiHEnf18rHfM1AJoqylmTsyqgglMkuBMlIuZO7MXg
         bmsZ04gn25ms7p8O2NhtMq43rOyaDz2sZ0Kl0VFf41DK0jNnnyTnoqGQSX9GXtbarka0
         RJOQ==
X-Gm-Message-State: AOJu0Yz3LQNUIS8VW1UXaOmjkrCPVWa0qLThB9hKu8jV3G0KjyahhkhM
        BuoDASFbxC/HpUekdqeH86m2wg==
X-Google-Smtp-Source: AGHT+IGdowEBy5PG8nDrQuAgESQrDHu9sMMCIJU4pu5ygHFwqnrD4l9aaPVWfg69FiGuiyQ61LiQxg==
X-Received: by 2002:a05:6a21:a59b:b0:181:8654:8279 with SMTP id gd27-20020a056a21a59b00b0018186548279mr11160565pzc.47.1700019461963;
        Tue, 14 Nov 2023 19:37:41 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001b9da42cd7dsm6419529plk.279.2023.11.14.19.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:41 -0800 (PST)
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
Subject: [PATCH v2 4/4] sched/stats: Add statistics for pick_eevdf()
Date:   Wed, 15 Nov 2023 11:36:47 +0800
Message-Id: <20231115033647.80785-5-wuyun.abel@bytedance.com>
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

For statistical purpose only, not intended to upstream.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c  | 12 ++++++++++--
 kernel/sched/sched.h |  5 +++++
 kernel/sched/stats.c |  6 ++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4197258b76ab..94d9318ac484 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -881,13 +881,16 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
 	struct sched_entity *best = NULL;
+	struct rq *rq = rq_of(cfs_rq);
 
 	/*
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_running == 1)
+	if (cfs_rq->nr_running == 1) {
+		schedstat_inc(rq->pick_direct);
 		return curr && curr->on_rq ? curr : se;
+	}
 
 	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
 		curr = NULL;
@@ -896,15 +899,20 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * Once selected, run a task until it either becomes non-eligible or
 	 * until it gets a new slice. See the HACK in set_next_entity().
 	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline) {
+		schedstat_inc(rq->pick_parity);
 		return curr;
+	}
 
 	/* Pick the leftmost entity if it's eligible */
 	if (se && entity_eligible(cfs_rq, se)) {
+		schedstat_inc(rq->pick_fast);
 		best = se;
 		goto found;
 	}
 
+	schedstat_inc(rq->pick_slow);
+
 	/* Heap search for the EEVD entity */
 	while (node) {
 		struct rb_node *left = node->rb_left;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 539c7e763f15..85a79990a698 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1105,6 +1105,11 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+
+	unsigned int		pick_direct;
+	unsigned int		pick_parity;
+	unsigned int		pick_fast;
+	unsigned int		pick_slow;
 #endif
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 857f837f52cb..4b862c798989 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -133,12 +133,14 @@ static int show_schedstat(struct seq_file *seq, void *v)
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %u %u %u %u",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq->pick_direct, rq->pick_parity,
+		    rq->pick_fast, rq->pick_slow);
 
 		seq_printf(seq, "\n");
 
-- 
2.37.3

