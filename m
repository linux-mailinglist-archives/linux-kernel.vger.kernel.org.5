Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE07DE594
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjKARpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344705AbjKARpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:45:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BF111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:45:09 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5aa481d53e5so17124a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698860708; x=1699465508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gJLYbQqFz/FdbUB5pvTJ7lgdYLSt1A0vYFl0v5PTNKo=;
        b=BT1wWFxPAPUQvRxX/ZSn0DzUZzndL4szGLMMI229Dbtvca+kMPgOIJ4hKLtrfM/BtW
         m2tVtaY0ulAzqNM5EPCinagmJoRqje2Zu9Q7Mifh3oC2ThgmvCbm1LinPgFxe20hTyV8
         DzU8+8aBATIdRYw7wZreHH4CjhXsh/P48V7zPpHOLvDt6ohnjNnN4WTimDzbsOOWo16N
         rEL1COZGyjlJVNIbgKThbJdcSd+TBSsJf8dsHseJC1QYj5E0VPKb1N2wvGOLcIauDjNu
         EUUWKU7J+iG+10SlL6ktPkfvo2U5R9M5MHewncTfY1gmJlhVodUbnsrHnM+pTLqiIqdb
         U/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698860708; x=1699465508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gJLYbQqFz/FdbUB5pvTJ7lgdYLSt1A0vYFl0v5PTNKo=;
        b=S+/7z6GFinUtf8ipcS+n86Jz6jno4MOE96t2mWdTD88DR9IV35M8mxGHYUpJjOu3bK
         liUy4f0vgGhPoky+/HvE7Re9Kgh4gEarvrFoKxUB+Lvajx+u/oIlrxRce4UKRgfdo6kX
         gSYE2BN/JdqsoV0bXeLpwgbf3UDLi4nibzp+/BlVpyqsgXu/eKtpmSmosn33W9CQPYDz
         w86LvE+zYQPL+KxJPp0Kr128oAtz7WKrO1GB3MQ9CVbY7PGdS9PULwN/ZdKaZgxWZcT4
         GlowJlQx3idMY3nb+Rl5TFBCI96hFzDihhRezhI2IuINzBx7Ou8D6Okqbjj9Q7kMKyJE
         u5ig==
X-Gm-Message-State: AOJu0YyBcCiM+rDvMN+Ve4/poi5zL0Jpi0HHu3ID8Im4g3FsGv2NoFFW
        SLl4CEAm3toBexaN4qSMXoE=
X-Google-Smtp-Source: AGHT+IFDsJ6u5VD5Fmlt6KmflMQ4/xBxmt4AIcUv8DtygG/P4dvRATXSypZFH+E5LuhvU19zIvmXkg==
X-Received: by 2002:a17:903:32cc:b0:1cc:4985:fc04 with SMTP id i12-20020a17090332cc00b001cc4985fc04mr10128180plr.66.1698860708146;
        Wed, 01 Nov 2023 10:45:08 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-207-86.dynamic-ip.hinet.net. [111.255.207.86])
        by smtp.gmail.com with ESMTPSA id ja11-20020a170902efcb00b001b8a00d4f7asm1593949plb.9.2023.11.01.10.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:45:07 -0700 (PDT)
From:   s921975628@gmail.com
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975628@gmail.com
Subject: [PATCH] sched/fair: Track current se's EEVDF parameters
Date:   Thu,  2 Nov 2023 01:44:46 +0800
Message-Id: <20231101174446.90413-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Yiwei Lin <s921975628@gmail.com>

After dequeuing the current-picked scheduling entity with
`__dequeue_entity`, its contribution to the EEVDF parameters
cfs_rq->avg_vruntime and cfs_rq->avg_load are also removed.
Because these should in fact be considered for the EEVDF algorithm,
we took curr as the special case and inserted back the contributions
when requests for cfs_rq->avg_vruntime and cfs_rq->avg_load.

Functions like `entity_eligible` which is called insied a loop may
therefore recalculate these statistics repeatly and require more effort.
Instead, we could just avoid to remove these statistics from
cfs_rq->avg_vruntime and cfs_rq->avg_load directly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 876798824..d507ade09 100644
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
 
@@ -821,11 +805,12 @@ static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 				__entity_less, &min_deadline_cb);
 }
 
-static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool on_rq)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_deadline_cb);
-	avg_vruntime_sub(cfs_rq, se);
+	if (!on_rq)
+		avg_vruntime_sub(cfs_rq, se);
 }
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
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
@@ -5229,7 +5209,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
-		__dequeue_entity(cfs_rq, se);
+		__dequeue_entity(cfs_rq, se, 0);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -5264,7 +5244,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * runqueue.
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
-		__dequeue_entity(cfs_rq, se);
+		__dequeue_entity(cfs_rq, se, 1);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 		/*
 		 * HACK, stash a copy of deadline at the point of pick in vlag,
-- 
2.34.1

