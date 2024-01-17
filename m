Return-Path: <linux-kernel+bounces-28676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5A8301B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF01F266FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF721E89D;
	Wed, 17 Jan 2024 08:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW3q9q3g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C891E896
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481771; cv=none; b=YF4LAzmCvA8ZcNHMG52drTD9AT/V4jlugn5j3PPSv8/BuGIhJJAfIMOVgtjag0UJp9Qxlb1dH/sPcYZiy/q29l0znThlNG6ZmzPFc7LhWkaICSiG2htjXhqnQkJqvbq8Hw02uZOQZje+99ZVLFi0Z9JViaSLQThU6gG338TX+LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481771; c=relaxed/simple;
	bh=KrafdORBylWfUZyJJ7GTGl+pw7Wfz9BmDb03nqcDl7U=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=gSTEsXpa0FXSOkVnJVmsptvsOFW+uDsDS7AhVSPuGRN0MmKklwU5tDky9duq+lW0c5O3VF0zDx6atdE80e7BaJo6zexBxoCFCPe2dh5quemvcEUD1zulCnoQXARFScRZEvIY45iNpln+lUbe9Q1bbb4GYI3dBJqk4C4bopIxt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW3q9q3g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A774C433A6;
	Wed, 17 Jan 2024 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481770;
	bh=KrafdORBylWfUZyJJ7GTGl+pw7Wfz9BmDb03nqcDl7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW3q9q3g3FVDOfQNzQyNTbYXWYxPM4BmMJwsrIRyGMLhqJX81cvqJA8rzuao26L1r
	 WWOJN1kdq8QpuIwZwSV6F+9ouxFdYmIV7ETzuKWJb0XEfyW9yfHd8+R7/F+Huo2Pb8
	 qvZMrJr+YGJqDXJTIzHPtcuk+2HM1wIeq/6SUhvqyVJ/8osFSJlaQdI98Sv6p7vvgT
	 RvuXjP/YsimmZlUFglqCQqWzyNPc+/xpxSbBhNz4lkeTEtZCS+IXaS7uu9dtfxZ6iS
	 TVLMT2HwyAPkvTKmpuifYrims9L2gy7ffAAKQLqaqKJ58B4VMIJ7PTCHoazTyKPvtR
	 c7j/SMzXvyYsA==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 5/5] sched/fair: narrow the sched_use_asym_prio checking scenario
Date: Wed, 17 Jan 2024 16:57:15 +0800
Message-ID: <20240117085715.2614671-5-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117085715.2614671-1-alexs@kernel.org>
References: <20240117085715.2614671-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Current function doesn't match it's comments, in fact, core_idle
checking is only meaningful with non-SMT.
So make the function right.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 96163ab69ae0..0a321f639c79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9741,8 +9741,8 @@ group_type group_classify(unsigned int imbalance_pct,
  */
 static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 {
-	return (!sched_smt_active()) ||
-		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
+	return	(sd->flags & SD_SHARE_CPUCAPACITY) ||
+		(!sched_smt_active() && is_core_idle(cpu));
 }
 
 static inline bool _sched_asym(struct sched_domain *sd,
-- 
2.43.0


