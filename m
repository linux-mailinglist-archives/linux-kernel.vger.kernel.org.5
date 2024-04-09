Return-Path: <linux-kernel+bounces-137579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04FA89E43A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8597C1F22F16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F11158206;
	Tue,  9 Apr 2024 20:13:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F8157E97
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693635; cv=none; b=gWE8dXSOOlpNY8GtmlSR+E30vcnaRomUbJZCWugsc6hialIOEYhKi/DUy5Y24AM2SaIl1e7tPrNVlwK/n8p3fB4a3zYTItxeE2gLrqnGaKrLrY2QMWCzDh2CMKCWv1ccqBmRD882Me03sCMIYD+97nKOknPHXSMxAidx6+RnRLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693635; c=relaxed/simple;
	bh=zRy5uoeqx+ADNZZXm7y5OqVdQZXE5q7MKz9uc5OtpDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzB62PoGVvLmUuXJAYEhRfat41kStUJnPsyQ69sf6kVA/cHvjz4uXBa3GB1s8+2dWXgSetr5In7EWGDxNRaKdGGg8EsZOzzuGCKFjU5wcvC3QskNZORQb9rP+KQG1xy18DXTxAotf6EHMYiSI1ack+5L4r0vyLVilLEaNK3+VWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CCDC139F;
	Tue,  9 Apr 2024 13:14:22 -0700 (PDT)
Received: from e130256.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 832293F64C;
	Tue,  9 Apr 2024 13:13:50 -0700 (PDT)
From: Hongyan Xia <hongyan.xia2@arm.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/fair: Fix wrong flag passed to set_rd_overutilized()
Date: Tue,  9 Apr 2024 21:13:44 +0100
Message-Id: <0afb160788a297f8cda63b70385de5f6bddec11e.1712693356.git.hongyan.xia2@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In update_sd_lb_stats(), sg_overloaded is passed to
set_rd_overutilized(). This seems to be a typo during refactoring, which
breaks many of my local EAS tests because overutilization is mistakenly
triggered.

This fix makes those EAS tests work again.

Signed-off-by: Hongyan Xia <hongyan.xia2@arm.com>

---
Hi Ingo,

Could you double check if this is the correct fix? Thank you.

---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1dd37168da50..bb1ae4ed0d91 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10661,7 +10661,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		set_rd_overloaded(env->dst_rq->rd, sg_overloaded);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		set_rd_overutilized(env->dst_rq->rd, sg_overloaded);
+		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	} else if (sg_overutilized) {
 		set_rd_overutilized(env->dst_rq->rd, sg_overutilized);
 	}
-- 
2.34.1


