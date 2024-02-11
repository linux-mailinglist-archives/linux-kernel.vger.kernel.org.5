Return-Path: <linux-kernel+bounces-60647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D07850805
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 08:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD841F22544
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A252A45958;
	Sun, 11 Feb 2024 07:50:55 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BF945942
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707637855; cv=none; b=VFJB9fnLzSsis3rfIpAfchW8ZbA3jV5jSKQJ056tLLnisFEpL5G3uENuAVAGHNZRdCAV1tlWnNYEKpKlf6pGiSikzKhw5biu5ZBT6S4aPf2U/WmnPjui7l0e68jTZLL9s8IbH81Nl+ocM2isRT6D2aa/N8PA/6WKX51sy7LdXEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707637855; c=relaxed/simple;
	bh=jDbS45Hfpl4NJbCyiYaybSk/6ny2dT75/VCYQby8FF8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u4JpI+d70V5lKpYOM3QWB4raYgcRX/k0o25apo1R47A6shsOAqNjebtbk1zuEZMv99GBARaEtmWO4QeLAFVAK933khu1JOmYmXYsW5pBpFo057US2BozfuMeJR1toS0FasgmZdbVnARBJ+Q7kPCSBdRbpFKKLJmyEMrpw+0/clM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41B7nvqI061257;
	Sun, 11 Feb 2024 15:49:57 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TXfr62ZHJz2K4cJ4;
	Sun, 11 Feb 2024 15:49:42 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Sun, 11 Feb 2024 15:49:55 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli
	<juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] sched: make cpu_util_cfs visible
Date: Sun, 11 Feb 2024 15:49:50 +0800
Message-ID: <20240211074950.247836-1-zhaoyang.huang@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41B7nvqI061257

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

As RT, DL, IRQ time could be deemed as lost time of CFS's task, some
timing value want to know the distribution of how these spread
approximately by using utilization account value (nivcsw is not enough
sometimes), wheras, cpu_util_cfs is not visible out side of
kernel/sched, This commit would like to make it be visible.

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


