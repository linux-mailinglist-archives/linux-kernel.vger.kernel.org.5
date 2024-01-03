Return-Path: <linux-kernel+bounces-15083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B205D822713
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496ED1F22CAC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01CE17748;
	Wed,  3 Jan 2024 02:32:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A67168BA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 02:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VzsDpck_1704249126;
Received: from localhost(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0VzsDpck_1704249126)
          by smtp.aliyun-inc.com;
          Wed, 03 Jan 2024 10:32:32 +0800
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
Subject: [PATCH] sched/eevdf: add helper function entity_deadline_is_valid
Date: Wed,  3 Jan 2024 10:32:05 +0800
Message-Id: <20240103023205.26344-1-liusong@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the helper function "entity_deadline_is_valid", then
corresponding code logic can be inferred from the function
name, improving readability of the code.

Signed-off-by: Liu Song <liusong@linux.alibaba.com>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 533547e3c90a..83ddff74eb91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -563,6 +563,11 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	return (s64)(se->vruntime - cfs_rq->min_vruntime);
 }
 
+static inline bool entity_deadline_is_valid(struct sched_entity *se)
+{
+	return (s64)(se->vruntime - se->deadline) < 0;
+}
+
 #define __node_2_se(node) \
 	rb_entry((node), struct sched_entity, run_node)
 
@@ -977,7 +982,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  */
 static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if ((s64)(se->vruntime - se->deadline) < 0)
+	if (entity_deadline_is_valid(se))
 		return;
 
 	/*
-- 
2.19.1.6.gb485710b


