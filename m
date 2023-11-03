Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F437E0863
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344425AbjKCSpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjKCSpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:45:09 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8582ED52
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:45:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cc0e78ec92so18933225ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 11:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699037106; x=1699641906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3Mf+oFY09NkG6xUy6xt5Qy6lJ5v/2Q5CqiQiWQ5e6A=;
        b=H+xIVoa15rSBXfWskuZe/k3aM2bpccX4mfH+YqLxALWODJfDZG6omf16x4mLKzuKjO
         +i80vISeF4Y9ZWpASxgGliGBSDzVgfxUD/D+WgmgVUE3mAF1ly8g8L2OZ1LQGy5O+vwZ
         lg9RIX5M1yumTpufmUNnfVT50yo7tujvvoNg4bu5a75E225tZITsozmZtMpRhyxH58Va
         Ta1J+7kZKxDGc7I39It3uMMSWPAdPPpNCJrFWBg9KfcoDTF4PzWRWxHDvo/uAcRWYv87
         8UmdYo07jOyV5XThAEhDPszlKI4EjZB7QyXs7vOQftorETxBYm9/tF+ZCTj1dNlaFRhp
         cIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699037106; x=1699641906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3Mf+oFY09NkG6xUy6xt5Qy6lJ5v/2Q5CqiQiWQ5e6A=;
        b=ueBFxvu0FOHKVuZt7WKlMzmz5/YuKEy5f/MS6/QqKghwUiGRYBjuAPd4t2YQIdAL7q
         4U82CGW/oOuOyArf+fAjrK5Ac+SRiE3up3+ZMNjF+Z+sEU2DMaZWhqNEX6JvmI6CYgmp
         5oK7UKY9AKaLr/2DpTiMSmVdvrNIiygT2EUVddX7ntcA26Vqs4DduhNbqFYZbzndVxHe
         WLjsSIV2Ljh2L1z67s5L08hkgOQJop2GJ3f/op70UXw+1FZmrtQI0DdUXLsy1Wnd/5TX
         6gZlp7uBmE4qG7QFenHWrvboZeKq1bvByooPGHpL783SUo3Kw9GSw1RJ0DUyKiC1+rZH
         aRww==
X-Gm-Message-State: AOJu0YygkxsldZqbQdphDucmSoTTwjg/knoy/BkJULHul+Qq4EG6yRpt
        M8JDVRU21cfTmjYtg9k3eVvS5dC10FktYTKW
X-Google-Smtp-Source: AGHT+IH3nW9+H8Q7qk5ItitEsgKtDvWmlgoq/sv9/8RJyvK7qjr7mZGNYUID1EDSm03JZoLjLDUn6w==
X-Received: by 2002:a17:902:ea01:b0:1cc:47a6:12b8 with SMTP id s1-20020a170902ea0100b001cc47a612b8mr18309830plg.46.1699037105915;
        Fri, 03 Nov 2023 11:45:05 -0700 (PDT)
Received: from rin-ROG-STRIX-G10CES-G10CES.. (111-255-201-13.dynamic-ip.hinet.net. [111.255.201.13])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902e31400b001c613b4aa33sm1678257plc.287.2023.11.03.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 11:45:05 -0700 (PDT)
From:   Yiwei Lin <s921975628@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        wuyun.abel@bytedance.com, linux-kernel@vger.kernel.org,
        s921975628@gmail.com
Subject: [PATCH v3 1/1] sched/fair: Track current se's EEVDF parameters
Date:   Sat,  4 Nov 2023 02:44:32 +0800
Message-Id: <20231103184432.9247-2-s921975628@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103184432.9247-1-s921975628@gmail.com>
References: <20231103184432.9247-1-s921975628@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
 kernel/sched/fair.c | 40 ++++++++++++----------------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 876798824..cb915fe42 100644
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
-	if (!curr)
+	if (!curr) {
+		avg_vruntime_add(cfs_rq, se);
 		__enqueue_entity(cfs_rq, se);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -5228,8 +5210,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	clear_buddies(cfs_rq, se);
 
 	update_entity_lag(cfs_rq, se);
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		avg_vruntime_sub(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
-- 
2.34.1

