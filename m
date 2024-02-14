Return-Path: <linux-kernel+bounces-64864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D1D8543F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2C283A76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7C125B1;
	Wed, 14 Feb 2024 08:22:15 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ADC125A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898935; cv=none; b=E1/swvE4axrR3kRi2CiicDZYZsVNFht3ZRIMfcEzD3cmtjrLbkZCgHjmLOk4B8NcUZheOeC/tHpsji8mi4IYpxcOU8YB0rIHihh6wrzFyi5lKdBC9JwE9KeKKbOAt5oyqzyA0APrhu8FARA05akGITcASQ+aAqZLO5PD6tZXJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898935; c=relaxed/simple;
	bh=OSOwBo1YUkCvjrsEBarilZ2Aa5ss4bNmUvwLSaUilR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jN2vbVeur9Qz80pjFByeJUR2hDexOc2Ndo520/6tryL/PdlBJ9JIpqc9xbzmfL8YKzOAkFpThfXbYbEd+87ND7OeyQiG8ku/6V8oF6pTLAR7Rz4/ZroXEkdQYKqW6Igr7P9Gv5j5l1gb3WLir8yD5VZsT9RGjtrsQ8NANykYjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41E8L77H041246;
	Wed, 14 Feb 2024 16:21:07 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TZWNZ0PVCz2K9fjq;
	Wed, 14 Feb 2024 16:20:46 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 14 Feb 2024 16:21:05 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli
	<juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [Resend PATCH 1/1] sched: make cpu_util_cfs formally visible
Date: Wed, 14 Feb 2024 16:20:55 +0800
Message-ID: <20240214082055.277572-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 41E8L77H041246

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
timing value(eg. algorithm's cost which can't disable preemption)
want to know the distribution of how these timing spread approximately
by using utilization account value (nivcsw is not enough
sometimes), OR evaluate how heavily the preemption is. However,
cpu_util_cfs is not formally visible as not in include/sched.h.

eg.
Effective part of A = Total_time * cpu_util_cfs / sched_cpu_util

Task's Timing value A
Timing start
|
|
preempted by RT, DL or IRQ
|\
| This period time is nonvoluntary CPU give up, need to know how long
|/
sched in again
|
|
|
Timing end

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/sched.h  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 77f01ac385f7..56953626526f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2318,6 +2318,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu);
+unsigned long cpu_util_cfs(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04846272409c..46110409e0f3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3027,7 +3027,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
 }
 
 
-extern unsigned long cpu_util_cfs(int cpu);
 extern unsigned long cpu_util_cfs_boost(int cpu);
 
 static inline unsigned long cpu_util_rt(struct rq *rq)
-- 
2.25.1


