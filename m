Return-Path: <linux-kernel+bounces-122469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469188F810
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E59295369
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8485B4F5FD;
	Thu, 28 Mar 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=horizon.ai header.i=@horizon.ai header.b="G8Kpg/4n"
Received: from mailgw01.horizon.ai (mailgw01.horizon.ai [43.224.64.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF094AEF2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.224.64.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608223; cv=none; b=tN115jMG3fmsfXylx6NM2fxX1fijd7+M+Ff2TyhB4tN7n0+hNGwaRRZXFNF1tOFvNd5nWMz288DMjvCjgT8nC1wW5wn8amTbmJ3jN2MwKm28w6wcWg4RkubweESzZKcBLCw5riBn5+iGK/XECVbg9bqPoPdponp58AGGLfKhewE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608223; c=relaxed/simple;
	bh=Q933E6UQgLmkO+V6LO1/GExEDMIxCwRCLY646gT5ReE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TqjFAD2GoNEyjXCR6VOrSH3flbucCZeP+5Et7mcLH0Y5Jrph1dOPKL/v5yDNWFSpV0u9QtOhrBAtZZ3DLee2zu3m7mAp7AbxO6KVWFZ0/V91pO/EGuPIdHt77rQoBnyviuH5/F0eaeW2nC2DbknGz/+tVaslkaXwJAlMCKq+A64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.ai; spf=pass smtp.mailfrom=horizon.cc; dkim=pass (1024-bit key) header.d=horizon.ai header.i=@horizon.ai header.b=G8Kpg/4n; arc=none smtp.client-ip=43.224.64.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=horizon.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=horizon.cc
DKIM-Signature: v=1; a=rsa-sha256; d=horizon.ai; s=bj; c=relaxed/simple;
	q=dns/txt; i=@horizon.ai; t=1711607293; x=2575520893;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q933E6UQgLmkO+V6LO1/GExEDMIxCwRCLY646gT5ReE=;
	b=G8Kpg/4nqPGxSsijvJZ4ld0BW/9apTNE/n7vjLR9Cx2NdjOHpCVmlDl6c97x2jpp
	0BmwvSvEJnvPHCUSj8ftQfxh8qhP3xCdj2W2XxXuu6aOzGvEpECRscwHGL913z9r
	ZyAelLmdMuQIpgdkQ4wCQnLEd3tF8SoSY9f3CNqFjS8=;
X-AuditID: 0a090144-6dc8770000005d78-ef-66050dfdca39
Received: from mailgw01.horizon.ai ( [10.9.15.111])
	by mailgw01.horizon.ai (Anti-spam for msg) with SMTP id A8.C3.23928.DFD05066; Thu, 28 Mar 2024 14:28:13 +0800 (HKT)
Received: from ubuntu2204.hobot.cc (10.9.0.13) by exchange002.hobot.cc
 (10.9.15.111) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.27; Thu, 28 Mar 2024
 14:28:13 +0800
From: mingyang.cui <mingyang.cui@horizon.ai>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@android.com>,
	<stable@vger.kernel.org>, <tkjos@google.com>, <pjt@google.com>,
	<quentin.perret@arm.com>, <Patrick.Bellasi@arm.com>, <Chris.Redpath@arm.com>,
	<Morten.Rasmussen@arm.com>, <joaodias@google.com>, mingyang.cui
	<mingyang.cui@horizon.ai>
Subject: [PATCH] sched/fair: Fix forked task check in vruntime_normalized
Date: Thu, 28 Mar 2024 14:27:57 +0800
Message-ID: <20240328062757.29803-1-mingyang.cui@horizon.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exchange002.hobot.cc (10.9.15.111) To exchange002.hobot.cc
 (10.9.15.111)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCxcmfr/uXlzXNYFmrocWlx1fZLO72T2Wx
	2LFdxOLyrjlsFpPfPWO0uHRgAZPF8d4DTBb7Oh4wWSzY+IjRouPIN2YHLo9tu7exerTsu8Xu
	sXmFlseda3vYPN7vu8rmsfl0tcfnTXIB7FFcNimpOZllqUX6dglcGY3HJrEW3BGuODCzm6WB
	sUOgi5GTQ0LARGLl1IeMXYxcHEICKxklHrUdh3LuM0psun6NBaSKTUBHYs/fv6wgCRGBu4wS
	z9asYgNJMAusY5Lomp8LYgsLeEo82b4ALM4ioCrxvHUrK4jNK2Ajsfj1a3aIdfIS+w+eZYaI
	C0qcnPmEBWKOvETz1tnMELaExMEXL4BsDqArVCQ+LjSFaJWV+HzzOBuEHSvR0zmBaQKjwCwk
	k2YhmTQLyaQFjMyrGIVzEzNz0ssNDPUy8osyq/Lz9BIzNzGC44HRZQfjtwUf9Q4xMnEwHmKU
	4GBWEuHdeZQlTYg3JbGyKrUoP76oNCe1+BCjNAeLkjivhtOdVCGB9MSS1OzU1ILUIpgsEwen
	VANT212N8x+/SOj4XHNfUHzjPbt1kEtmqNiNgz/eP+7/tiSn5uX7ubMXVsqqrmxP/CHIZM19
	lqu/csuFT5axCRvsV/i+k0kTCBRuSXpzedmPCXMMOZfGfp1021B+9Z7nDUf3H/Zi4G2bq7HV
	+6hZup+6lq2ls+yXBiGz/aHliqLCnxefEV+17ZEyh+Jt+awkvVe6mdlvGeNP1a9zuXJ8dfH2
	7m9mTz5c17/e/lUrJa+5MLx7XTDjJ5dr28JU77FHN5/ptK4Qvha07/76qmbPah+TRxs9RF/q
	n35dvvXJN7Epl3zN5d63bfpyyYfL46FZS3+P+MNDL/31pr1UlVkULZ0m/iljshOHZtmpY0bF
	AguVWIozEg21mIuKEwHptQHy9gIAAA==

When rt_mutex_setprio changes a task's scheduling class to RT,
sometimes the task's vruntime is not updated correctly upon
return to the fair class.
Specifically, the following is being observed:
- task has just been created and running for a short time
- task sleep while still in the fair class
- task is boosted to RT via rt_mutex_setprio, which changes
  the task to RT and calls check_class_changed.
- check_class_changed leads to detach_task_cfs_rq, at which point
  the vruntime_normalized check sees that the task's sum_exec_runtime
  is zero, which results in skipping the subtraction of the
  rq's min_vruntime from the task's vruntime
- later, when the prio is deboosted and the task is moved back
  to the fair class, the fair rq's min_vruntime is added to
  the task's vruntime, even though it wasn't subtracted earlier.

Since the task's vruntime is about double that of other tasks in cfs_rq,
the task to be unable to run for a long time when there are continuous
runnable tasks in cfs_rq.

The immediate result is inflation of the task's vruntime, giving
it lower priority (starving it if there's enough available work).
The longer-term effect is inflation of all vruntimes because the
task's vruntime becomes the rq's min_vruntime when the higher
priority tasks go idle. That leads to a vicious cycle, where
the vruntime inflation repeatedly doubled.

The root cause of the problem is that the vruntime_normalized made a
misjudgment. Since the sum_exec_runtime of some tasks that were just
created and run for a short time is zero, the vruntime_normalized
mistakenly thinks that they are tasks that have just been forked.
Therefore, sum_exec_runtime is not subtracted from the vruntime of the
task.

So, we fix this bug by adding a check condition for newly forked task.

Signed-off-by: mingyang.cui <mingyang.cui@horizon.ai>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 73a89fbd81be..3d0c14f3731f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11112,7 +11112,7 @@ static inline bool vruntime_normalized(struct task_struct *p)
 	 * - A task which has been woken up by try_to_wake_up() and
 	 *   waiting for actually being woken up by sched_ttwu_pending().
 	 */
-	if (!se->sum_exec_runtime ||
+	if (!se->sum_exec_runtime && p->state == TASK_NEW ||
 	    (p->state == TASK_WAKING && p->sched_remote_wakeup))
 		return true;
 
-- 
2.34.1


