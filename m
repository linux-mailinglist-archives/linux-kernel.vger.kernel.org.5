Return-Path: <linux-kernel+bounces-132876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0DB899B85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762D21F2285A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D9416C42E;
	Fri,  5 Apr 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gfB72H7y"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B0118659
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315043; cv=none; b=Nlad49YLIoIawM4jKY+96tmACB3Hke65Kti18FDbbdTZxzYlB1hMpzEjULpraaCseL9mt+Jpa9HPsN7B+bSBMvX61Cu41qvBDb03Qojtu+9dmqECwVTBRkQDmZ+cvX9WKfWRecJp2BnmxoMb4l9AslKtFmpHRUbiCllVNcNyPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315043; c=relaxed/simple;
	bh=AusR2py2b2TRuwPprHkpWBQD3DFbwMOr/saRKPYpEiQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FVygdPacAbvpIejU2483UwJ6Vpvl1nEZPYtVlD2cTm/1rylwnAMKV/lrr4qfmj2mMcjn5h5NVQyoowjjwol5fng710hM4enSWiisBStp+hLTkFTnERmXigoh8Vx8AVugdbePcbNc5BdLmmoOnENKNF2F+69j/G2fKaZWDVPV7HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gfB72H7y; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=GEYq0WT0f8wEWJeuTVZAcjZJLXV5clrhaBXbfYQp8uw=; b=gfB72H7ykeootaDRaWjBdjocmP
	BZd6PpKqIyEykIwaocya3PKqkSBbmaws/YGW9ffEle3nj/fKtkfO06Y6pZK/ZlxHRMrh9y7FWVRp+
	ByXke3aQhkOJBj5pHwdt4/lCmE94lhO5OvtKZmdWuoPFuqE1e+8lMUmvhdGoyT85tz+s6ffJSyLkl
	ZbeC+piJCm2EEvHPdjprc53C4AuQnvj5lHDEJ8Yd2w2FwQQryczPQlw8VG4DnuHRsiGm0Rf3Xh0RA
	TvEptNvAKQpiwaEQKexp32xd6fEOvtjQUrJ/q2h8w5pGcN5Z3XWJuWlFuH3Gs0/3+bCHC+czpkqpk
	0Y1J9jcA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMG-00000005Z8i-3hPY;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 821EB301BD7; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110009.919925084@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:27:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 02/10] sched/eevdf: Remove min_vruntime_copy
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since commit e8f331bcc270 ("sched/smp: Use lag to simplify
cross-runqueue placement") the min_vruntime_copy is no longer used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c  |    5 ++---
 kernel/sched/sched.h |    4 ----
 2 files changed, 2 insertions(+), 7 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -780,8 +780,7 @@ static void update_min_vruntime(struct c
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	u64_u32_store(cfs_rq->min_vruntime,
-		      __update_min_vruntime(cfs_rq, vruntime));
+	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
 }
 
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
@@ -12876,7 +12875,7 @@ static void set_next_task_fair(struct rq
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
-	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
+	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,10 +599,6 @@ struct cfs_rq {
 	u64			min_vruntime_fi;
 #endif
 
-#ifndef CONFIG_64BIT
-	u64			min_vruntime_copy;
-#endif
-
 	struct rb_root_cached	tasks_timeline;
 
 	/*



