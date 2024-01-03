Return-Path: <linux-kernel+bounces-15449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E501E822C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6E1282D03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F3B18E39;
	Wed,  3 Jan 2024 11:29:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53FA18EA1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vzu1kGO_1704281354;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0Vzu1kGO_1704281354)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 19:29:40 +0800
From: Liu Song <liusong@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org,
	liusong@linux.alibaba.com
Subject: [PATCH] sched/eevdf: remove the unused function max_vruntime and simplify the implementation of min_vruntime
Date: Wed,  3 Jan 2024 19:29:14 +0800
Message-Id: <20240103112914.77856-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function max_vruntime is defined but not used, and under EEVDF,
there's no need to focus on max vruntime, so it's highly unlikely that
the function will be used in the future. Even if it were to be used,
max_vruntime simply returns the larger value of two vruntimes, and such
a naming convention could easily cause confusion, leading one to
mistakenly believe that alongside the meaningful concept of min_vruntime
in EEVDF, there might also be a concept of max_vruntime. Therefore, the
function should be removed.

Furthermore, since vruntime is monotonically increasing, the
implementation of the function min_vruntime has been simplified.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..0370e5d0be78 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -530,19 +530,9 @@ void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
  * Scheduling class tree data structure manipulation methods:
  */
 
-static inline u64 max_vruntime(u64 max_vruntime, u64 vruntime)
-{
-	s64 delta = (s64)(vruntime - max_vruntime);
-	if (delta > 0)
-		max_vruntime = vruntime;
-
-	return max_vruntime;
-}
-
 static inline u64 min_vruntime(u64 min_vruntime, u64 vruntime)
 {
-	s64 delta = (s64)(vruntime - min_vruntime);
-	if (delta < 0)
+	if (vruntime < min_vruntime)
 		min_vruntime = vruntime;
 
 	return min_vruntime;
@@ -748,10 +738,8 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	u64 min_vruntime = cfs_rq->min_vruntime;
-	/*
-	 * open coded max_vruntime() to allow updating avg_vruntime
-	 */
 	s64 delta = (s64)(vruntime - min_vruntime);
+
 	if (delta > 0) {
 		avg_vruntime_update(cfs_rq, delta);
 		min_vruntime = vruntime;
-- 
2.19.1.6.gb485710b


