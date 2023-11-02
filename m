Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0287DF4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 15:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376774AbjKBOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 10:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjKBOVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 10:21:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A958312D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 07:21:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280137f1a1bso915837a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698934889; x=1699539689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kwYSiEXhkVnBa+rpkoFWCCiRvP7M3ASE9OIkajZy5c=;
        b=K7qCM+x//qu8J/mwI6/+796KDRsnG1sIcBu54Pe9ArRzeX/mDb5SdIuVTT/iM5h/Xo
         Qrr6bRdeyVphrdxX+rs/o+T/dBUhbZwKNEsVFmSppa4Qeu1VyRJmnjUvKO4SLTOL+Dle
         ZTJziiSHWurrCBBtCl3BjetvBKxutl9kgP+jxtoWmoh7oIpIdHP3EWq7mR7xxmaU+fxP
         yPVQ3XtPX6z1IkDuLlSU8WJsqeZ6IDikLL5nyExt5adeamYuIIjHU4C8SC1AJUxNK+gV
         UHJm3vq2DkRtTyrN+WIuwWtNs5tUdyJu8psC6EHBYNEn2FsdM84SO2mxF+eAfbMI+9I5
         u/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698934889; x=1699539689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kwYSiEXhkVnBa+rpkoFWCCiRvP7M3ASE9OIkajZy5c=;
        b=rzJk5BDmOhSeh15GOdKV8jW0/tWFT9TdQI3KC2LZW+TGKuPAONlLyczh4joQosfDXF
         vxpEKeshvJsUfpW4Pw8oGDEE5Oe+oA7I20T6kqr/4kgYuMe02c9t7VE+zG0JcyMVq1Dw
         X4NfJhQKdPDt0J9D4nAfHX+wSVktp9cFS051jhfsz3xkv/JxHXAiydkScUhnBFdS97Ow
         xkh3689N0nBVQXjwCcBo63noPgnCRMvoPf/7v+CCihIt6tBg4RzWwU9lYg9zHtDvEqYV
         do/y/1m0mYEJMM7Xx6t3StqJZnv8NhaOlV9eZihY+fJEEQROX98Z1NcLwAANM4lytA2S
         GSmA==
X-Gm-Message-State: AOJu0YwTQhfCqiYj58C9ItEpoRzgFr2ugMEl/abjuRlgsGTdqQRWZH3A
        Cmy2JfJveje1wNHqznbUyYo=
X-Google-Smtp-Source: AGHT+IHs6KYBgicGGPVZwhFDCqwiVZiWc1OxBekAKbYFIuVf6o+czsZCtl8Wa/b1+31462vvjSMcLQ==
X-Received: by 2002:a17:90a:f298:b0:280:2856:5eef with SMTP id fs24-20020a17090af29800b0028028565eefmr10811821pjb.22.1698934888170;
        Thu, 02 Nov 2023 07:21:28 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id p24-20020a637f58000000b005b83bc255fbsm1546789pgn.71.2023.11.02.07.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 07:21:27 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975628@gmail.com
Subject: [PATCH v2 1/1] sched/fair: Track current se's EEVDF parameters
Date:   Thu,  2 Nov 2023 22:20:22 +0800
Message-Id: <20231102142022.19302-2-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102142022.19302-1-s921975628@gmail.com>
References: <20231102142022.19302-1-s921975628@gmail.com>
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

Functions like `entity_eligible` which is called insied a loop may
therefore recalculate these statistics repeatly and require more effort.
Instead, we could just avoid to remove these statistics from
cfs_rq->avg_vruntime and cfs_rq->avg_load directly.

Signed-off-by: Yiwei Lin <s921975628@gmail.com>
---
 kernel/sched/fair.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 876798824..a10a73603 100644
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
@@ -1137,6 +1122,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	u64 now = rq_clock_task(rq_of(cfs_rq));
 	u64 delta_exec;
+	u64 delta_fair;
 
 	if (unlikely(!curr))
 		return;
@@ -1158,7 +1144,9 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
-	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	delta_fair = calc_delta_fair(delta_exec, curr);
+	curr->vruntime += delta_fair;
+	cfs_rq->avg_vruntime += delta_fair * scale_load_down(curr->load.weight);
 	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
@@ -3675,8 +3663,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		/* commit outstanding execution time */
 		if (cfs_rq->curr == se)
 			update_curr(cfs_rq);
-		else
-			avg_vruntime_sub(cfs_rq, se);
+		avg_vruntime_sub(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
@@ -3712,8 +3699,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
-		if (cfs_rq->curr != se)
-			avg_vruntime_add(cfs_rq, se);
+		avg_vruntime_add(cfs_rq, se);
 	}
 }
 
@@ -5023,7 +5009,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * EEVDF: placement strategy #1 / #2
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
-		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
 		lag = se->vlag;
@@ -5081,8 +5066,6 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
 		load = cfs_rq->avg_load;
-		if (curr && curr->on_rq)
-			load += scale_load_down(curr->load.weight);
 
 		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
@@ -5229,7 +5212,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_entity_lag(cfs_rq, se);
 	if (se != cfs_rq->curr)
-		__dequeue_entity(cfs_rq, se);
+		__dequeue_entity(cfs_rq, se, 0);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -5264,7 +5247,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
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

