Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5186E7EBC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbjKODhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjKODht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:37:49 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C39E9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc53d0030fso3748025ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700019441; x=1700624241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMEAhqnib6Cx5fXTMT63a6eUDp64lMLN0QbaBCMwWy8=;
        b=ltB4FYSDCn3reQo3M0rR/nvY9EeGr5UxJiiohxA9VhLXj7WipdROHSDjNKdzHOZDD9
         BDvvsYVZYPe+5N7t3ke3q5vceVz3BF0H8jukQD22JjJEw/6lXVFDOFasvnCouHzhWYg6
         OpEwegEFIVVYyGktbvVVKzaQGDcZrBPzvwMwmgcdq5jA0RBqrVXlnuPXDOrwCl/gFPHy
         1V4JIv6Wr0+YUyt1k403jCqyc+5+Cp988ieadgrp7rn/SWLq6wfRrx+21SHb/MxB7XU9
         ld+HqvFtC1yQWtOaPsEzGIwMC5d3/q/3WYb4D+wKS6W9AKlP/9E96/f46T4l9R6hf2NV
         iPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019441; x=1700624241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMEAhqnib6Cx5fXTMT63a6eUDp64lMLN0QbaBCMwWy8=;
        b=C1FJD15KZTH9TNdv02Pg+1t+SsX0DbWIRXTpzZJixZ2anACzMIbNuJWcDNlRr5RrGM
         YFhpuYxh3Wsyf1ksmjHoIGzZxfrYKk5zOoIz+aHd+PO94ozoW/8zRirvrg0vOg3NCkfy
         oAhfBOlgOGqqdaMuQNlRMOQ5b1JBiUdH2O5DCcjz3TO2XV+Sx/jJDQvrhE3KcBZorhle
         M5BkcTIqsqNqR7XCM+n0Fu1gMDbNsVukUmIbvHhg2JRnNrCzWof5pEJEe1LeG06SNLkB
         C4OgndC3FvjGENFngawyLT/iHl83FKwot2B9jnEQdLPjBQDCwNGLeSsY5auKOx+apwsK
         akGQ==
X-Gm-Message-State: AOJu0YzK6AO2yJRkDAQ+x2pVHOgRbO5C7yCameSdvTyoFxl7zVLJojnb
        2sqbJdAa+rhjZmGHJdrp+L3Hnw==
X-Google-Smtp-Source: AGHT+IF1o3A8Q26Q6/Ia30dEfyGjFfcZTfMDGF8BZ5bloFwjrGZzNkr09GffOL8JHhYdd0V15HIncw==
X-Received: by 2002:a17:902:c401:b0:1cc:31c4:3426 with SMTP id k1-20020a170902c40100b001cc31c43426mr5883356plk.11.1700019441312;
        Tue, 14 Nov 2023 19:37:21 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001b9da42cd7dsm6419529plk.279.2023.11.14.19.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:20 -0800 (PST)
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
Subject: [PATCH v2 1/4] sched/eevdf: Fix vruntime adjustment on reweight
Date:   Wed, 15 Nov 2023 11:36:44 +0800
Message-Id: <20231115033647.80785-2-wuyun.abel@bytedance.com>
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

vruntime of the (on_rq && !0-lag) entity needs to be adjusted when
it gets re-weighted, and the calculations can be simplified based
on the fact that re-weight won't change the w-average of all the
entities. Please check the proofs in comments.

But adjusting vruntime can also cause position change in RB-tree
hence require re-queue to fix up which might be costly. This might
be avoided by deferring adjustment to the time the entity actually
leaves tree (dequeue/pick), but that will negatively affect task
selection and probably not good enough either.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 151 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 128 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2048138ce54b..025d90925bf6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3666,41 +3666,140 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
+static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
+			   unsigned long weight)
+{
+	unsigned long old_weight = se->load.weight;
+	u64 avruntime = avg_vruntime(cfs_rq);
+	s64 vlag, vslice;
+
+	/*
+	 * VRUNTIME
+	 * ========
+	 *
+	 * COROLLARY #1: The virtual runtime of the entity needs to be
+	 * adjusted if re-weight at !0-lag point.
+	 *
+	 * Proof: For contradiction assume this is not true, so we can
+	 * re-weight without changing vruntime at !0-lag point.
+	 *
+	 *             Weight	VRuntime   Avg-VRuntime
+	 *     before    w          v            V
+	 *      after    w'         v'           V'
+	 *
+	 * Since lag needs to be preserved through re-weight:
+	 *
+	 *	lag = (V - v)*w = (V'- v')*w', where v = v'
+	 *	==>	V' = (V - v)*w/w' + v		(1)
+	 *
+	 * Let W be the total weight of the entities before reweight,
+	 * since V' is the new weighted average of entities:
+	 *
+	 *	V' = (WV + w'v - wv) / (W + w' - w)	(2)
+	 *
+	 * by using (1) & (2) we obtain:
+	 *
+	 *	(WV + w'v - wv) / (W + w' - w) = (V - v)*w/w' + v
+	 *	==> (WV-Wv+Wv+w'v-wv)/(W+w'-w) = (V - v)*w/w' + v
+	 *	==> (WV - Wv)/(W + w' - w) + v = (V - v)*w/w' + v
+	 *	==>	(V - v)*W/(W + w' - w) = (V - v)*w/w' (3)
+	 *
+	 * Since we are doing at !0-lag point which means V != v, we
+	 * can simplify (3):
+	 *
+	 *	==>	W / (W + w' - w) = w / w'
+	 *	==>	Ww' = Ww + ww' - ww
+	 *	==>	W * (w' - w) = w * (w' - w)
+	 *	==>	W = w	(re-weight indicates w' != w)
+	 *
+	 * So the cfs_rq contains only one entity, hence vruntime of
+	 * the entity @v should always equal to the cfs_rq's weighted
+	 * average vruntime @V, which means we will always re-weight
+	 * at 0-lag point, thus breach assumption. Proof completed.
+	 *
+	 *
+	 * COROLLARY #2: Re-weight does NOT affect weighted average
+	 * vruntime of all the entities.
+	 *
+	 * Proof: According to corollary #1, Eq. (1) should be:
+	 *
+	 *	(V - v)*w = (V' - v')*w'
+	 *	==>    v' = V' - (V - v)*w/w'		(4)
+	 *
+	 * According to the weighted average formula, we have:
+	 *
+	 *	V' = (WV - wv + w'v') / (W - w + w')
+	 *	   = (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
+	 *	   = (WV - wv + w'V' - Vw + wv) / (W - w + w')
+	 *	   = (WV + w'V' - Vw) / (W - w + w')
+	 *
+	 *	==>  V'*(W - w + w') = WV + w'V' - Vw
+	 *	==>	V' * (W - w) = (W - w) * V	(5)
+	 *
+	 * If the entity is the only one in the cfs_rq, then reweight
+	 * always occurs at 0-lag point, so V won't change. Or else
+	 * there are other entities, hence W != w, then Eq. (5) turns
+	 * into V' = V. So V won't change in either case, proof done.
+	 *
+	 *
+	 * So according to corollary #1 & #2, the effect of re-weight
+	 * on vruntime should be:
+	 *
+	 *	v' = V' - (V - v) * w / w'		(4)
+	 *	   = V  - (V - v) * w / w'
+	 *	   = V  - vl * w / w'
+	 *	   = V  - vl'
+	 */
+	if (avruntime != se->vruntime) {
+		vlag = (s64)(avruntime - se->vruntime);
+		vlag = div_s64(vlag * old_weight, weight);
+		se->vruntime = avruntime - vlag;
+	}
+
+	/*
+	 * DEADLINE
+	 * ========
+	 *
+	 * When the weight changes, the virtual time slope changes and
+	 * we should adjust the relative virtual deadline accordingly.
+	 *
+	 *	d' = v' + (d - v)*w/w'
+	 *	   = V' - (V - v)*w/w' + (d - v)*w/w'
+	 *	   = V  - (V - v)*w/w' + (d - v)*w/w'
+	 *	   = V  + (d - V)*w/w'
+	 */
+	vslice = (s64)(se->deadline - avruntime);
+	vslice = div_s64(vslice * old_weight, weight);
+	se->deadline = avruntime + vslice;
+}
+
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
-	unsigned long old_weight = se->load.weight;
+	bool curr = cfs_rq->curr == se;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
-		if (cfs_rq->curr == se)
+		if (curr)
 			update_curr(cfs_rq);
 		else
-			avg_vruntime_sub(cfs_rq, se);
+			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	update_load_set(&se->load, weight);
-
 	if (!se->on_rq) {
 		/*
 		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
 		 * we need to scale se->vlag when w_i changes.
 		 */
-		se->vlag = div_s64(se->vlag * old_weight, weight);
+		se->vlag = div_s64(se->vlag * se->load.weight, weight);
 	} else {
-		s64 deadline = se->deadline - se->vruntime;
-		/*
-		 * When the weight changes, the virtual time slope changes and
-		 * we should adjust the relative virtual deadline accordingly.
-		 */
-		deadline = div_s64(deadline * old_weight, weight);
-		se->deadline = se->vruntime + deadline;
-		if (se != cfs_rq->curr)
-			min_deadline_cb_propagate(&se->run_node, NULL);
+		reweight_eevdf(cfs_rq, se, weight);
 	}
 
+	update_load_set(&se->load, weight);
+
 #ifdef CONFIG_SMP
 	do {
 		u32 divider = get_pelt_divider(&se->avg);
@@ -3712,8 +3811,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (cfs_rq->curr != se)
-			avg_vruntime_add(cfs_rq, se);
+		if (!curr) {
+			/*
+			 * The entity's vruntime has been adjusted, so let's check
+			 * whether the rq-wide min_vruntime needs updated too. Since
+			 * the calculations above require stable min_vruntime rather
+			 * than up-to-date one, we do the update at the end of the
+			 * reweight process.
+			 */
+			__enqueue_entity(cfs_rq, se);
+			update_min_vruntime(cfs_rq);
+		}
 	}
 }
 
@@ -3857,14 +3965,11 @@ static void update_cfs_group(struct sched_entity *se)
 
 #ifndef CONFIG_SMP
 	shares = READ_ONCE(gcfs_rq->tg->shares);
-
-	if (likely(se->load.weight == shares))
-		return;
 #else
-	shares   = calc_group_shares(gcfs_rq);
+	shares = calc_group_shares(gcfs_rq);
 #endif
-
-	reweight_entity(cfs_rq_of(se), se, shares);
+	if (unlikely(se->load.weight != shares))
+		reweight_entity(cfs_rq_of(se), se, shares);
 }
 
 #else /* CONFIG_FAIR_GROUP_SCHED */
-- 
2.37.3

