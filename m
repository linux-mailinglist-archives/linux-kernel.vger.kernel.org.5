Return-Path: <linux-kernel+bounces-47352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA2844CC3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8DB1F22382
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FD65677B;
	Wed, 31 Jan 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWjScDyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70334F1E0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742704; cv=none; b=fJ0QkHEcoUJZ6x1gIjTeKOkliDhqDbi5twqiTYO3O6UuLlCaBDcMy7o4/bTbyLiMwvsWDhm8vPtRyHJUcwHAl8P4GmmJam2kpM8bGuTt6Sk0phxM1CDotVFv+nRHhvg+X0z8uKV4hCy9F0TI6nPaUY0tw+Hpn3mBjQt7ke2x7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742704; c=relaxed/simple;
	bh=gpKFxD2je2tWWE8lEBMTW3z9BiZKvLJ/r4INUAW0y0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fg6wflQ9XOcdEjMxeyqfPm1mc0MhIovhnVEkKFj6brDfqiZpLi/ryd1sOh8NdBrnKm0CMEz3mjuFNq1ViEU3DM4qgZr4/czETQWfaE1JgN6n/9FFiN+HUmTrClWklibCzf+yzJYfwrbNraaiw3a9nYdfw2mFXI5VRCe5NL2yie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWjScDyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B57C433F1;
	Wed, 31 Jan 2024 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706742704;
	bh=gpKFxD2je2tWWE8lEBMTW3z9BiZKvLJ/r4INUAW0y0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWjScDyyCyJYL8k/VWsDJeqGTPrU6Q0ILhUZ+4te5yiJ/JzBrk0rDkMmdvyiOs10F
	 OMMPgOtmXWKz0CevqJZgruEl/nveIdYeiaDJ+xj1jOoBMA5W8i6eUpbrEb2XnoTQNd
	 nsEilF9i79TxkT4Kk9okYcjaKXHkiSh/r3aSBpm2/DmzVVwY9ZiQq4DsantDtFGvFE
	 XVppD2DLIStIt0tGqbTFkOyhoAYlQ3ck1tMxjhXCc7//QDwjrqFEhweWbNr77UvbOV
	 xXzG53fNWZ5npmxYnuwC7QNJzN2sU7uXxjmwjKvtrormdv2HiOLu5gRtY1fqF9C/ka
	 VwuyUtAJFlMww==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 08/15] tick: Move tick cancellation up to CPUHP_AP_TICK_DYING
Date: Thu,  1 Feb 2024 00:11:13 +0100
Message-ID: <20240131231120.12006-9-frederic@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131231120.12006-1-frederic@kernel.org>
References: <20240131231120.12006-1-frederic@kernel.org>
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


