Return-Path: <linux-kernel+bounces-89994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 423FA86F8BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 803A5B2123C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 03:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3D2CA4;
	Mon,  4 Mar 2024 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Myqptbhw"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2617C9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709521256; cv=none; b=pcXpAbRqi5D2IMk2zZaGBqRoldlQS6vTCh8rvosHOkz+54cv2EG+ZHMaR7a0ArtDsAEhuke2J1ai7oWXyQmscpySYttyXLef3jyYiGZCN+N5qd06HMFK3C8+mAxPkbvwZtJnQieKq9LkD3VTxSQclyACwoh38Ii/H6n86ruq0wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709521256; c=relaxed/simple;
	bh=nw9L+W2RdaeA/JiFU5L3vP+VcASNnK3QbAN7wrUFDFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e96P08fQlqNRrAr9zjl9l1jBaLpHKFHRme0dmhjFt+yFHOakS5X1dnB/oy3jPFRhOzY2V7KTL5ylRxZLXuS8oGSG7A/FF6OON+ohZ2qQVFSB3SqqfB7VzNw2o5jwA3cF5hvauhr5aeKGcXTWzcFeGxhc2gb2BBCSOtz9cO86Mp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Myqptbhw; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709521251; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OAEj4XYKb6Z7iXVcveEaFUEGuCaJ8azk2/tiA7nFnrA=;
	b=MyqptbhwDSgqNFwQg+dfz2ORR+xFL8mW4MSbmcPLxGILWPfp38hCZEkkVjOf0c4ECOQYbr9awrQiQNUYM7nz4s82gHNdmKOjzNDPd3Aqqqiqq9WrOKOutK+XjlNIkasaain0TgkMXudi3fFGwaZnfsl/ZlbruKmjlvROTSGur88=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W1i0XYp_1709521250;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W1i0XYp_1709521250)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 11:00:50 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 2/2] sched/eevdf: Fix miscalculation in reweight_entity() when se is not curr
Date: Mon,  4 Mar 2024 11:00:42 +0800
Message-Id: <20240304030042.2690-3-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
References: <20240304030042.2690-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reweight_eevdf() only keeps V unchanged inside itself. When se !=
cfs_rq->curr, it would be dequeued from rb tree first. So that V is
changed and the result is wrong. Pass the original V to reweight_eevdf()
to fix this issue.

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/fair.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5551ce2af73e..091a1a750638 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3676,11 +3676,10 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
-static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
+static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
 			   unsigned long weight)
 {
 	unsigned long old_weight = se->load.weight;
-	u64 avruntime = avg_vruntime(cfs_rq);
 	s64 vlag, vslice;
 
 	/*
@@ -3787,10 +3786,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
+	u64 avruntime;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
+		avruntime = avg_vruntime(cfs_rq);
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
@@ -3804,7 +3805,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		 */
 		se->vlag = div_s64(se->vlag * se->load.weight, weight);
 	} else {
-		reweight_eevdf(cfs_rq, se, weight);
+		reweight_eevdf(se, avruntime, weight);
 	}
 
 	update_load_set(&se->load, weight);
-- 
2.39.3


