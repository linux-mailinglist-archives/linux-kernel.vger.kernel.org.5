Return-Path: <linux-kernel+bounces-167533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635908BAAFA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED361C2214E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D237A1509B7;
	Fri,  3 May 2024 10:46:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DDE3FB09
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714733192; cv=none; b=aSAFkFjF9aJhkd8YQlxm/5XuF7oCY8CcyJ51+76zmNMS6tqxeHFwQQmLQHL+KSXsjR5QaMel7YIGxsUyXoFWRaBI506JL3vfQv4ZA89QdsAqF0Csc6riCeQMPHTqm9sZu3tgmumXGhSh4o6Mmn0HLGSLRlQys3Zh+MahbneOvJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714733192; c=relaxed/simple;
	bh=Xu+MEc83F0sPC2uSubWXEVi0fScQCsXeIJa+ZhEvoW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnXfCxsvH5N4OIudj3QbGgPes26SOWFiprkLm7xKEKLA0/cDofrR93k22MOYxTxi8C44+2yJopQFbv6NLw9NYxyHx5VgYM+ZdvIZkUyw9eIPPGG4YU92qsYEr4YhdfbWh2sTvqhIoKRRSiKbEFweiqtCv/fQ/sDpC77BAqL1KDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCC8F2F4;
	Fri,  3 May 2024 03:46:53 -0700 (PDT)
Received: from e125579.speedport.ip (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AF1613F793;
	Fri,  3 May 2024 03:46:25 -0700 (PDT)
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Add stats update for cfs_rq->exec_clock in update_curr() again
Date: Fri,  3 May 2024 12:46:05 +0200
Message-Id: <20240503104605.1871571-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5d69eca542ee ("sched: Unify runtime accounting across classes")
removed it and since then:

  echo 1 > /proc/sys/kernel/sched_schedstats
  cat /sys/kernel/debug/sched/debug | grep exec_clock

returns:

  .exec_clock                    : 0.000000

for all cfs_rq's.

Put the schedstat_add() back to be able to watch the cfs_rq runtime
statistic.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9eb63573110c..37bb3cee6fec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1158,6 +1158,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
 	if (unlikely(delta_exec <= 0))
 		return;
+	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_deadline(cfs_rq, curr);
-- 
2.25.1


