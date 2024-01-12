Return-Path: <linux-kernel+bounces-24473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636782BD0F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5EF1F21653
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182EA56760;
	Fri, 12 Jan 2024 09:25:58 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E255C21
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp77t1705051457thubohd7
Received: from ubuntu1.. ( [221.226.144.218])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 12 Jan 2024 17:24:15 +0800 (CST)
X-QQ-SSF: 01200000000000B0B000000A0000000
X-QQ-FEAT: q+EIYT+FhZpqW/wXBmXAUKQj18ahmXHRlQvx2IfHRIE+9pSh9V6TQzaQiqNyg
	5mJqhb3B1um1VSkR8rXTPxyEpKyZMpQQQXFaxaAHdjMzC44Y+pscyY0WzKsGuSJV7NtLJzv
	3bXPQEAHkznwjjgvbcovaippnNUtpfup4EfdQ7hqMw6LHmpxF/RUSpaulHkgehQDtvNlhPG
	0cvCAZOm9gsLE014NyxpPCq18v2xNT/ehg2rWZe3h8DQ5bvZ7yMjzG41puNVCh/objBgXtX
	8SJGHEpCbb3ICDq7qr4ICh23hj3438sxErCdfN7ZxHd6vftMVxwZpoLXojYAXzIyNZlJRZP
	O4WywxrAalfX6D9YLiFo2uP2oIitw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 553020647248264284
From: Song Shuai <songshuaishuai@tinylab.org>
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
	Song Shuai <songshuaishuai@tinylab.org>
Subject: [PATCH 1/2] sched/preempt: Remove preceding unnecessary enables in __sched_dynamic_update
Date: Fri, 12 Jan 2024 17:19:15 +0800
Message-Id: <20240112091916.696185-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2

The preempt mode transitions are based on SC's static_call_update()
and SK's static_key_enable/disable() APIs.

Once these static calls and static keys are initialized, APIs can
work well regardless of the states of them (detailly speaking, the
instructions in SC's call site/trampoline or SK's jump_entry::code).

There is no need to enable these points all at the beginning,
updating them directly is enough.

Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
---
 kernel/sched/core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..6931da32f6a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8732,17 +8732,6 @@ static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
 {
-	/*
-	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
-	 * the ZERO state, which is invalid.
-	 */
-	if (!klp_override)
-		preempt_dynamic_enable(cond_resched);
-	preempt_dynamic_enable(might_resched);
-	preempt_dynamic_enable(preempt_schedule);
-	preempt_dynamic_enable(preempt_schedule_notrace);
-	preempt_dynamic_enable(irqentry_exit_cond_resched);
-
 	switch (mode) {
 	case preempt_dynamic_none:
 		if (!klp_override)
-- 
2.39.2


