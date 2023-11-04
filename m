Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407607E0E7C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 10:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjKDJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 05:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjKDJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 05:01:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19138D49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 02:01:31 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-35932aa21a3so10896155ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699088490; x=1699693290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MVPJsWV3f+k/RL9aQbNoaCN8uXNtV/OjWdYtUy2jRE=;
        b=EYvYdA7ZGzALl+2dzwE84HeIMU9qq9RAKR9X5ByeRAq0sFHgniY3A+atfFMoD98LuN
         dBtk7NYGIKsF86eAvbmIU0vEDUnTXV4/VTpca/x/ArFrDtN7ruEwz41xkySe0cddgSxb
         Rxo9t8sg1auOKErnXiDBb32HcAOPfBAL1Qw9EQDNHw52hopv+grmLMoxZaGb18LzctGy
         OU7y3ayUBWK5lCq0eRwIdkxhbCoLekd7FrAURYcsk0qWmDkrfMt6WkyQDZKqDcBt/JeB
         fnGzLyZzztpphknmJfe7iQCBNSaMny5tNRjqKumCCLLd1wQoHgB/ONA00oqVRkghBKP2
         wkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699088490; x=1699693290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MVPJsWV3f+k/RL9aQbNoaCN8uXNtV/OjWdYtUy2jRE=;
        b=qn1ktKGLVta1sgvQAPKYF2LaFAVjS9C7tQc41gbQWPW4bbLMljDLG67hZ6BKf9eSR5
         zodyAduWzjFAJy1/+s+lvFo9QDOOQsa8gHJwevBxMyqDJw6RHHM/3Ra/8FW8DXqFxJvi
         1KpkoTWV6OtLGiAKjT1x8JoI4YvfxhqPY1bnk2jR+mXbtWMFqtcCZrUHeCjlI04ZhE/i
         KIQXYSvmrDH98JIl0YiqzYBj7rftn20gj+Xa3FbkmT0Xguu0MHmySclintQVg6on6qkn
         LY6+VUgSUTJ9O2VnFVZ5OaYYdMV7mhUoKzm9Y6+KWFCcRq+gGsZi+P0/oF2jhdPHYTbY
         sLwg==
X-Gm-Message-State: AOJu0Yzr1rZmv3li5A1UBTWw/Q11O39zDNuWhaso2bOWoIoggtZJHzck
        wBQ7/EieywXGwOd3Wrt2l/8=
X-Google-Smtp-Source: AGHT+IG5eS5wshML9vrFwELFLsEU74P0HZjZd8Yq7TO+I50k85qbEMTzQTM581pWoHTrRYzoSpit8g==
X-Received: by 2002:a05:6e02:1526:b0:357:f72d:ad1d with SMTP id i6-20020a056e02152600b00357f72dad1dmr28652356ilu.30.1699088490196;
        Sat, 04 Nov 2023 02:01:30 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b0068842ebfd10sm2667596pfg.160.2023.11.04.02.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 02:01:29 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH v4 1/1] sched/fair: Track current se's EEVDF parameters
Date:   Sat,  4 Nov 2023 17:00:54 +0800
Message-Id: <20231104090054.124945-2-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104090054.124945-1-s921975628@gmail.com>
References: <20231104090054.124945-1-s921975628@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After dequeuing the current-picked scheduling entity with
`__dequeue_entity`, its contribution to the EEVDF parameters
cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
Because these should in fact be considered for the EEVDF algorithm,
we took curr as the special case and inserted back the contributions
when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.

Functions like `entity_eligible` which is called inside a loop may
therefore recalculate these statistics repeatly and require more effort.
Instead, we could just avoid to remove these statistics from
cfs_rq->avg_vruntime and cfs_rq->avg_load directly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 876798824..b67c6d7d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -655,17 +655,9 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
  */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
-	struct sched_entity *curr = cfs_rq->curr;
 	s64 avg = cfs_rq->avg_vruntime;
 	long load = cfs_rq->avg_load;
 
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
-
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
-
 	if (load) {
 		/* sign flips effective floor / ceil */
 		if (avg < 0)
@@ -722,17 +714,9 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
  */
 int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct sched_entity *curr = cfs_rq->curr;
 	s64 avg = cfs_rq->avg_vruntime;
 	long load = cfs_rq->avg_load;
 
-	if (curr && curr->on_rq) {
-		unsigned long weight = scale_load_down(curr->load.weight);
-
-		avg += entity_key(cfs_rq, curr) * weight;
-		load += weight;
-	}
-
 	return avg >= entity_key(cfs_rq, se) * load;
 }
 
@@ -815,7 +799,6 @@ RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	avg_vruntime_add(cfs_rq, se);
 	se->min_deadline = se->deadline;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_deadline_cb);
@@ -825,7 +808,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_deadline_cb);
-	avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
@@ -1137,6 +1119,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
+	u64 delta_fair;
 
 	if (unlikely(!curr))
 		return;
@@ -1158,7 +1141,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	delta_fair = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += delta_fair;
+	cfs_rq->avg_vruntime += delta_fair * scale_load_down(curr->load.weight);
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
@@ -3675,8 +3660,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
-		else
-			avg_vruntime_sub(cfs_rq, se);
+		avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3712,8 +3696,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (cfs_rq->curr != se)
-			avg_vruntime_add(cfs_rq, se);
+		avg_vruntime_add(cfs_rq, se);
 	}
 }
 
@@ -5023,7 +5006,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * EEVDF: placement strategy #1 / #2
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
-		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
 		lag = se->vlag;
@@ -5081,8 +5063,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
 		load = cfs_rq->avg_load;
-		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
 
 		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
@@ -5158,8 +5138,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
+	avg_vruntime_add(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
+
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5230,6 +5212,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
+	avg_vruntime_sub(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
-- 
2.34.1

