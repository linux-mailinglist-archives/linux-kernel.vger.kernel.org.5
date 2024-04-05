Return-Path: <linux-kernel+bounces-133426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2D589A382
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EE5281E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1633017166F;
	Fri,  5 Apr 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMUYFlk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC571CFBC
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338389; cv=none; b=hgHVdmJFPrRJE7jg/K2NPEknXU5wmzbQoXVbwiBpilOmvAQHA33O/sXJ9YXCidlHYqDTL52Tukwvy96waEpZOncxs/ZjSpka0QEFA0DGyFaTsswUJaLlcfdGRIXD2LfmTsM+IHa5qNw9zwxzAwvhemWpsLUjYo1WtilrNzwIgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338389; c=relaxed/simple;
	bh=Sw94HTzOtmMY+TFVC6IZuLqXE+LH2LZl0+TfstCUCW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJr/Q9GgClrxxf6f03EsCeLu5Poq/LoVDqghzUEB2fWBhUIaV+BWWc8a4ScrtuU8B3DjJueZiWcv7MkkP6lMWaOrgQug0cO1TTVVs1YSzyFAyLDB3eXfoyRO4PWS8yeVXq8UKxOlUZ/hO1iR8Q/VMu3GHBuFTeHV3Rh2GA+Z/vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMUYFlk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98008C433C7;
	Fri,  5 Apr 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338388;
	bh=Sw94HTzOtmMY+TFVC6IZuLqXE+LH2LZl0+TfstCUCW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hMUYFlk5OwSfGVgl7biDNqdtdgTG+oKBSqTqsjTiqPfI567nkrVa8hblslsgHHMyh
	 xGYe85tCN4zJEwwOTxnc1FinHJy7LtNecOhJ3i6FgtfH4+G/hYdl5e+QuZGpTZ3wbx
	 dO0AtNVG7SC6C8GO4M7+kRIza6ihxOI9CI+CYiiKkTE/0L0aO0CCO0pv8rJgXdUrxA
	 Nkz8eW7dmo+7rPclOgzyKoU00WW7cZ7z5zuTpyb2jd0qzciVcAbi1z95A90uRhEoD1
	 eJHDrp6ou9VS7YaFVbW5Vt/H2+1proeqJk3zhI+aEd3yb32Y+qgBO4HXVGCvdVQTBE
	 A6oQq9sMXKQrw==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V6 4/6] sched/core: Fix priority checking for DL server picks
Date: Fri,  5 Apr 2024 19:32:52 +0200
Message-ID: <5c199284e572a65e71f445be3c26d2711834d910.1712337227.git.bristot@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712337227.git.bristot@kernel.org>
References: <cover.1712337227.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

In core scheduling, a DL server pick (which is CFS task) should be
given higher priority than tasks in other classes.

Not doing so causes CFS starvation. A kselftest is added later to
demonstrate this.  A CFS task that is competing with RT tasks can
be completely starved without this and the DL server's boosting
completely ignored.

Fix these problems.

Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04e2270487b7..4881e797ae07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -162,6 +162,9 @@ static inline int __task_prio(const struct task_struct *p)
 	if (p->sched_class == &stop_sched_class) /* trumps deadline */
 		return -2;
 
+	if (p->dl_server)
+		return -1; /* deadline */
+
 	if (rt_prio(p->prio)) /* includes deadline */
 		return p->prio; /* [-1, 99] */
 
@@ -191,8 +194,24 @@ static inline bool prio_less(const struct task_struct *a,
 	if (-pb < -pa)
 		return false;
 
-	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
-		return !dl_time_before(a->dl.deadline, b->dl.deadline);
+	if (pa == -1) { /* dl_prio() doesn't work because of stop_class above */
+		const struct sched_dl_entity *a_dl, *b_dl;
+
+		a_dl = &a->dl;
+		/*
+		 * Since,'a' and 'b' can be CFS tasks served by DL server,
+		 * __task_prio() can return -1 (for DL) even for those. In that
+		 * case, get to the dl_server's DL entity.
+		 */
+		if (a->dl_server)
+			a_dl = a->dl_server;
+
+		b_dl = &b->dl;
+		if (b->dl_server)
+			b_dl = b->dl_server;
+
+		return !dl_time_before(a_dl->deadline, b_dl->deadline);
+	}
 
 	if (pa == MAX_RT_PRIO + MAX_NICE)	/* fair */
 		return cfs_prio_less(a, b, in_fi);
-- 
2.44.0


