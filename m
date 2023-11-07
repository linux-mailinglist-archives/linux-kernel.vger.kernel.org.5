Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F947E3727
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjKGJHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbjKGJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:07:27 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8111D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:07:23 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d31f3e8ca8so3351885a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699348043; x=1699952843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwX48usRaKEA5HaGZtCGAssiXT8r/2oxrc8cbsc3Tm8=;
        b=DTJmubAOblnTL4KaCW3xYJrqiR/klLWdvORaoZA2YuYv3FywAll+jqRC+P23xQoo9g
         Bioir8D6RxQJi8QixMlp2x/Ujo/MPNdYLYawejKbJg7upTD9rNvgay0XV3MgAlUkoyPz
         lK1HtdkIOAQFdHRbT4fGqySBpQsDdZIGvnRaYWPY/ekMKD1I43gCUlaG/DAPVgsaMdbp
         P7g0rp4jrRqyJTHZuS5EaNDzy0l4/LnxSFne0+fe7sjq6+x7HeKD5BuvVC46SEQgqEr0
         1wHNevDNT71bZ44XdBDWbO3Jh+6fV10RCICGjHLxcN3wXs6lz06ToMUPQwzQM2LM9B37
         N/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699348043; x=1699952843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wwX48usRaKEA5HaGZtCGAssiXT8r/2oxrc8cbsc3Tm8=;
        b=C5+QIr+iX6hRNMTSTnJA9SvgIhdeYvFwz3krFK3W2G+TZNuy3FIDlxRrxNB9bJ5LHD
         K8IgPwhyW3trS4sHmeD4CP85vcJ+MCqu6M5QHLg3+DnrgA6Pp4O5M8Eq+nV5WlEux6I0
         64m8d0Fs9858EhTDv1SbptlGCdLn+Sx1Rhx5EN10GfxcuFdTFn8/28ri/TdLRWcmrX+9
         L9Mq9JPkxh2wiCYzLDznUlZD1l56/llduGQlDvGpnLvCp94KCLbFHsD811SWDp//cJom
         bZyTZR5Tf7hMSnli+2vejlcMEf4pKa7sr2c1lah4nkn17qmuskVvz7xMkq4tEjngvMVG
         i5CQ==
X-Gm-Message-State: AOJu0YzOUI+a/LB69kxe1omWb9cJcOnl08JylsTO3hGbKuS/VSbE0Gys
        wj0qJY6O6lJkamSv0Zz6COd7EQ==
X-Google-Smtp-Source: AGHT+IHChR5h3gdArSdp56QWypUzALBaTB/fgCvQe2XApaJGlMDEt25g25XwL9m5U4X4IdYKr49XTQ==
X-Received: by 2002:a05:6830:18fa:b0:6b9:1473:7fa3 with SMTP id d26-20020a05683018fa00b006b914737fa3mr32542977otf.27.1699348042881;
        Tue, 07 Nov 2023 01:07:22 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id k27-20020a63ba1b000000b005ab7b055573sm875154pgf.79.2023.11.07.01.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:07:22 -0800 (PST)
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
Subject: [PATCH 4/4] sched/stats: branch statistics for pick_eevdf
Date:   Tue,  7 Nov 2023 17:05:10 +0800
Message-Id: <20231107090510.71322-5-wuyun.abel@bytedance.com>
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

For trace purpose only, not intended for upstream.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c  | 12 ++++++++++--
 kernel/sched/sched.h |  5 +++++
 kernel/sched/stats.c |  6 ++++--
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a1fdd0c7a051..9b07e9437526 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -899,13 +899,16 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
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
@@ -914,15 +917,20 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
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

