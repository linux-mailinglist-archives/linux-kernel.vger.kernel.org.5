Return-Path: <linux-kernel+bounces-37387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3A83AF2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081801C23897
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FB86AD3;
	Wed, 24 Jan 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apydmotH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9186AC6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115928; cv=none; b=LBjxQe5InB4ggCyCDnIhOng2V+9mV3DlT/pLLeXT4HM3Ojaq6U5Wa5h7Y2TQqeQTa5vlPTkfhJ6Z3JGW+KKAApcJfPVtCR5rus5L22/AsXKS/K3i2mSTPcjGdmfRbDQbXPPe2IYtd8gALjWTWE3dOaWDCZ9JiIbVM6J9u+T455k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115928; c=relaxed/simple;
	bh=j4R9xWxhSKcn6+gqDWFiRkuawBSZ7hDhyExkS5TrEj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/aPUQGaZlSsIZk/sf1oPPzGCoDpiq2cApEJW5fjxfXSbTCUo8P8qgIWVYhljOfPNW7Q4RORf6FVRWHR+BFq1fBKL26VgaieaTPDjm2bhO/ECA4v+8C0M77nKC8j0iXmiA0/0VRp9fy8ybBOLGiYgRLz041nxqMREeSEmSrYjj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apydmotH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABACC43399;
	Wed, 24 Jan 2024 17:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115928;
	bh=j4R9xWxhSKcn6+gqDWFiRkuawBSZ7hDhyExkS5TrEj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apydmotH4lzn6QzExX3lySa/jAZFJcG0Q6HLcUJenVqEfGEBvTTaQEWeVuJhQXXtQ
	 keVRazCDXwRioMOrhz6Tc469cP/ptxVQ/9EkxPD9LIz9AxKtCnISCzOpWg8tW1Qo54
	 q9bBS2UbpAQw2JGomGCHIAkujRiVXlzE7CH02WlvP93Sm5COZ2scJdGEm/SoxBBoGO
	 us2HpGruBkN7RmAgBB0vKiNsT5aO5kfMjC2WKNE/frpmH9jUPoYs5AwVpZw/jY7IB7
	 JASAbXqxph4xOG9DSkVQ2Dskxksq40FWyqvZMWFnjzNkH8+TUQyP8eRXbgDifbAggL
	 FAFsABhS7LqDg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 08/15] tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
Date: Wed, 24 Jan 2024 18:04:52 +0100
Message-ID: <20240124170459.24850-9-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124170459.24850-1-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tick hrtimer is cancelled right before hrtimers are migrated. This
is done from the hrtimer subsystem even though it shouldn't know about
its actual users.

Move instead the tick hrtimer cancellation to the relevant CPU hotplug
state that aims at centralizing high level tick shutdown operations so
that the related flow is easy to follow.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c     | 2 --
 kernel/time/tick-common.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 355b5a957f7f..3b456ec7d4fb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2224,8 +2224,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	struct hrtimer_cpu_base *old_base, *new_base;
 	int i, ncpu = cpumask_first(cpu_active_mask);
 
-	tick_cancel_sched_timer(dying_cpu);
-
 	old_base = this_cpu_ptr(&hrtimer_bases);
 	new_base = &per_cpu(hrtimer_bases, ncpu);
 
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index a89ef450fda7..b4af8c743b73 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -410,6 +410,8 @@ int tick_cpu_dying(unsigned int dying_cpu)
 	if (tick_do_timer_cpu == dying_cpu)
 		tick_do_timer_cpu = cpumask_first(cpu_online_mask);
 
+	tick_cancel_sched_timer(dying_cpu);
+
 	return 0;
 }
 
-- 
2.43.0


