Return-Path: <linux-kernel+bounces-80335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFFC862D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E751F22F0B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184D22EF8;
	Sun, 25 Feb 2024 22:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFu+0/g8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4C522337
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901731; cv=none; b=LCXtasIleyZCiPd/jEdE2iiV2RJKn335wI74zRWvgTKmuGZGxfbq7jZd442QRMuQuQdRDHiONtWC1ekt6myDMAqO2rgb1+eeGRNi+ux9w1hDuHTPAFjZ7DlupNxCQn1Ejy5MV3iQsbRd103jvD149A6XUKByvjSTreItIT8dMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901731; c=relaxed/simple;
	bh=1t2Igcp3/2acM8Dgm/Zgl3S5NWNsliShc0fKBxG7fGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnA4CvcvmkTCskZGgoVvtFPFiblu2LgyeArXieIQHG2KeTj8ka4/1WvqzXJrnHSaSFwgtHjciEAHwk4nO63TrNyYSfjeRUElEG5q6WhE4LdX2OXEPT8/RT/UX6NPPNKxKHXccE0aN4n87mkaLOxEYYiF/hf7rYGq9VUs13ZoiwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFu+0/g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835A4C43399;
	Sun, 25 Feb 2024 22:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708901731;
	bh=1t2Igcp3/2acM8Dgm/Zgl3S5NWNsliShc0fKBxG7fGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lFu+0/g8aFgFX5z8neujR4W+AFrCcIfkYFBKFcQh607ouLhXix5pCMNLTGSFAm8L/
	 2/CvF98St2mtPrEEJebheFT8xJl8ibt7MWlx40OCaOf8x3vh6Fgmb5ahis6kVsJiZ5
	 LeyeSdQVWUUNX9+bFfUezZGK7k8xB+9xXQQ2x+9w+rqq3THSTxKte9BzlJPxiZ8kgo
	 C2Jw6ZSEugfUO8Q3+4TxSlgDy6cARbz8K8rFfjBt/2PBfajZzsUf2Hg3aX9dBZFLpw
	 pQvdKOEpjKS/o/jgnDE4PxmvBXXj7d5tYBs3Wa6dVz2tgyLr8uoJNXDF+vYLOr81wF
	 4YyOxFiuFAdAw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 08/16] tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
Date: Sun, 25 Feb 2024 23:55:00 +0100
Message-ID: <20240225225508.11587-9-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225225508.11587-1-frederic@kernel.org>
References: <20240225225508.11587-1-frederic@kernel.org>
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

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/hrtimer.c     | 2 --
 kernel/time/tick-common.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95f1f351dcd9..3e95474199ac 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2229,8 +2229,6 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping_cpumask(HK_TYPE_TIMER));
 	struct hrtimer_cpu_base *old_base, *new_base;
 
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


