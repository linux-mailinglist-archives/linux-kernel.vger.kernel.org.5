Return-Path: <linux-kernel+bounces-44686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E664A8425F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A20B52931A0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2473178;
	Tue, 30 Jan 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNrtEUQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319F6F073
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620473; cv=none; b=Oy4j3Pew2Bwjnpup0swu8dedAJlez0JPp1L2cJchAtnuX2QzSyuP2ooK2YMwoJiCTSC9lrKwEwToUsh/sQWxd0mOTHdSiR9K3iQP+1viC0tlfGF6cHRRqspHbf1mosFKxBVQ0/M6aGm/I6gQSmWw6hjC2DE6HDGm6EgWuNx91qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620473; c=relaxed/simple;
	bh=g+mDwC9FPU+XmcCzxUJ4hYXHnkp5fd/Hyf0d6FKB8Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSeTKEbyZrCtN+I66Hozh+RPKDxwz47m1/AU4hHvzIbhqLq1P0qSOpc0gpw9sThFAbCgiZVAs56+24yUytE81xIK++ogyFAaVMHa/R/bw+GR8we5Vpa01816pYQign2clzl87dKbZYVEtSbtsM2yUP1avZIYxoqcZ2XfkIxi35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNrtEUQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF9BC43394;
	Tue, 30 Jan 2024 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706620473;
	bh=g+mDwC9FPU+XmcCzxUJ4hYXHnkp5fd/Hyf0d6FKB8Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YNrtEUQHPV4xlePXQ6bNoPbZUy0QY/ygNg91OYFhS3FGt7U8wGld+bVHMvTz9l3LE
	 doiIaK5zw+jr/I8PRnw4XKDB9aVDgs/U2UcYq7aY2WwTrblQyXf1bbL0NTRWDEq35n
	 gdp2a8c0Fjd/8W7n+KYY9LLuYKQLcGRcrd/jCCzPTohOsmUxT1EJS8hyEEpfueRpzR
	 BLDAx6QffUjuSONcVLGKjW4hbeQFiWuBhLlrkAmD72bkqAu4Gin9FPcN0bD4IPNJqg
	 l7vpgDKDOEUfJ/Q88D+Ym1r9C/WJr06Wx2fui6ugjuhMfnqRsvG4U+BRdQQYRYyqug
	 HFuO6TF4MSF2w==
From: alexs@kernel.org
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	ricardo.neri-calderon@linux.intel.com,
	sshegde@linux.ibm.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH v2 6/6 RFT] sched/fair: change sched asym checking condition
Date: Tue, 30 Jan 2024 21:17:08 +0800
Message-ID: <20240130131708.429425-6-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130131708.429425-1-alexs@kernel.org>
References: <20240130131708.429425-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Asym only used on SMT sd, or core sd with ITMT and core idled.
!sched_smt_active isn't necessary.

Signed-off-by: Alex Shi <alexs@kernel.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: linux-kernel@vger.kernel.org
To: Valentin Schneider <vschneid@redhat.com>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
To: Ben Segall <bsegall@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6680cb39c787..0b7530b93429 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9744,8 +9744,8 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 	if (!(sd->flags & SD_ASYM_PACKING))
 		return false;
 
-	return (!sched_smt_active()) ||
-		(sd->flags & SD_SHARE_CPUCAPACITY) || is_core_idle(cpu);
+	return (sd->flags & SD_SHARE_CPUCAPACITY) ||
+		(is_core_idle(cpu) && test_bit(cpu_core_flags(), (void *)&sd->flags));
 }
 
 static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
-- 
2.43.0


