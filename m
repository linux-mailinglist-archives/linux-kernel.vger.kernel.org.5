Return-Path: <linux-kernel+bounces-125155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC08892148
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D023B24E49
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3185656;
	Fri, 29 Mar 2024 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NGM0h5P1"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59469DFE
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728437; cv=none; b=sYcGp+YFVU0Xof2YFsTxRuvqxKV1jJ3mdV6G1/EZTx6CdSrRl8p9KXg/LO/wB2VyPPK9VzRtB5TGVv3xQXXAAERFLzeClnuq8svH/49ynpkYmbAHQQP8QcGN13iIcByNzlg6E+d44A22G9KFGkmY411S/BV7fzOFz7UayPQNqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728437; c=relaxed/simple;
	bh=OQbWZ9DfweLNbNPX89NEj5OVkWKRX2dQ0AHE+K0bUhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hOi3xTHeu4PrTaItlkRWuRaLaf25UPj8EKg6QLbeeXbICHjqz/Q+7VdMmmZ3olcwcvEZSgk2C9a2f5jRFgC3FqhUYHrKA7sLzSkR4dO8arzlbw63sehB/TpL152ejBZrY/xDpH3vMC2uNuS+bcFKKRGkFjTo1eq2TqG9VwtTt5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NGM0h5P1; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+lEoje11YmS5Sn144C7ylsilwvOdrD+4xxUHeCPefBk=; b=NGM0h5P1in14Z+lzyVVP+3nPFz
	DhLlSmmEU0i1ve6+YTjjQRHBWSgxGqicF9BNWMkPpBtOr9sZ97bGG8QllaPaWgivYNgyonWmYLy1O
	dMMmtchgKLZJAZg99jEIC4yd6ALCYvo0ibO5tbbf4Lk2XPAgZlfcBYsdc9+nxJbZGtuHj4IiU8oRy
	pWDdKk9jyDBUdYkSQje4wfMxOyjp9PZAGu+3VApcJ0qc5EXFcDGdjC+4Aisr/rIm50T+VDXwUCDGL
	Mm02TKLzdGNiDM9WftKuykqKApvI5sRo4BIE+Yc2Y43CPRsl1c7+wm25rN3LID9n4Msp82uS5C6eU
	t8vYybcg==;
Received: from [84.65.0.132] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rqEku-00Gh3q-Nz; Fri, 29 Mar 2024 17:07:01 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tursulin@ursulin.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Ziljstra <peterz@infradead.org>,
	kernel-dev@igalia.com
Subject: [PATCH] sched/psi: Optimise psi_group_change a bit
Date: Fri, 29 Mar 2024 16:06:48 +0000
Message-ID: <20240329160648.86999-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tursulin@ursulin.net>

The current code loops over the psi_states only to call a helper which
then resolves back to the action needed for each state using a switch
statement. That is effectively creating a double indirection of a kind
which, given how all the states need to be explicitly listed and handled
anyway, we can simply remove. Both the for loop and the switch statement
that is.

The benefit is both in the code size and CPU time spent in this function.
YMMV but on my Steam Deck, while in a game, the patch makes the CPU usage
go from ~2.4% down to ~1.2%. Text size at the same time went from 0x323 to
0x2c1.

Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org
Cc: kernel-dev@igalia.com
---
 kernel/sched/psi.c | 54 +++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7b4aa5809c0f..55720ecf420e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -218,28 +218,32 @@ void __init psi_init(void)
 	group_init(&psi_system);
 }
 
-static bool test_state(unsigned int *tasks, enum psi_states state, bool oncpu)
+static u32 test_states(unsigned int *tasks, u32 state_mask)
 {
-	switch (state) {
-	case PSI_IO_SOME:
-		return unlikely(tasks[NR_IOWAIT]);
-	case PSI_IO_FULL:
-		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
-	case PSI_MEM_SOME:
-		return unlikely(tasks[NR_MEMSTALL]);
-	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] &&
-			tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING]);
-	case PSI_CPU_SOME:
-		return unlikely(tasks[NR_RUNNING] > oncpu);
-	case PSI_CPU_FULL:
-		return unlikely(tasks[NR_RUNNING] && !oncpu);
-	case PSI_NONIDLE:
-		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
-			tasks[NR_RUNNING];
-	default:
-		return false;
+	const bool oncpu = state_mask & PSI_ONCPU;
+
+	if (tasks[NR_IOWAIT]) {
+		state_mask |= BIT(PSI_IO_SOME);
+		if (!tasks[NR_RUNNING])
+			state_mask |= BIT(PSI_IO_FULL);
 	}
+
+	if (tasks[NR_MEMSTALL]) {
+		state_mask |= BIT(PSI_MEM_SOME);
+		if (tasks[NR_RUNNING] == tasks[NR_MEMSTALL_RUNNING])
+			state_mask |= BIT(PSI_MEM_FULL);
+	}
+
+	if (tasks[NR_RUNNING] > oncpu)
+		state_mask |= BIT(PSI_CPU_SOME);
+
+	if (tasks[NR_RUNNING] && !oncpu)
+		state_mask |= BIT(PSI_CPU_FULL);
+
+	if (tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] || tasks[NR_RUNNING])
+		state_mask |= BIT(PSI_NONIDLE);
+
+	return state_mask;
 }
 
 static void get_recent_times(struct psi_group *group, int cpu,
@@ -770,7 +774,6 @@ static void psi_group_change(struct psi_group *group, int cpu,
 {
 	struct psi_group_cpu *groupc;
 	unsigned int t, m;
-	enum psi_states s;
 	u32 state_mask;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
@@ -841,10 +844,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		return;
 	}
 
-	for (s = 0; s < NR_PSI_STATES; s++) {
-		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
-			state_mask |= (1 << s);
-	}
+	state_mask = test_states(groupc->tasks, state_mask);
 
 	/*
 	 * Since we care about lost potential, a memstall is FULL
@@ -1194,7 +1194,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	/*
 	 * After we disable psi_group->enabled, we don't actually
 	 * stop percpu tasks accounting in each psi_group_cpu,
-	 * instead only stop test_state() loop, record_times()
+	 * instead only stop test_states() loop, record_times()
 	 * and averaging worker, see psi_group_change() for details.
 	 *
 	 * When disable cgroup PSI, this function has nothing to sync
@@ -1202,7 +1202,7 @@ void psi_cgroup_restart(struct psi_group *group)
 	 * would see !psi_group->enabled and only do task accounting.
 	 *
 	 * When re-enable cgroup PSI, this function use psi_group_change()
-	 * to get correct state mask from test_state() loop on tasks[],
+	 * to get correct state mask from test_states() loop on tasks[],
 	 * and restart groupc->state_start from now, use .clear = .set = 0
 	 * here since no task status really changed.
 	 */
-- 
2.44.0


