Return-Path: <linux-kernel+bounces-110040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B58885939
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562481C218B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A9E83CB1;
	Thu, 21 Mar 2024 12:39:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B64D51C2A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024760; cv=none; b=STqbwyoKsWQ9iJjZQo3VRGrl9mW8IhA8m4WtyYJtZANCWvNRURSUNVCz2TsjpHOFMP84S9EXNRAAfkGfhfgVEYZmayCC1sGHb6MTIK/vYDWWRwOIGWT84Jl+YKD/aoFA29rVRLHsatxSIIzbq/DX/20YFZPr+bpBiYr7MPle76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024760; c=relaxed/simple;
	bh=CT5MwjdDPcpuxxnsZWTEMN7MikSmaQxaH7LiWRofkz0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hGmdx0BtfTVYIJsXbsmbgMhDNcRcvKHSlwibyG0CC3UIjTulsc9k0G+Hx4x0T9k8KscZgcyMQbncHqgyjfVmyYhuh/lyL/xjC0TF3suHFSOkr+/3KkP1Ye8qLeL2UDVHhMz9KIP0VxfkbiGUt6Ma1eE1PduW3VP0bcJEToh9XIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782461007;
	Thu, 21 Mar 2024 05:39:51 -0700 (PDT)
Received: from e133047.cambridge.arm.com (e133047.arm.com [10.1.27.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F3333F762;
	Thu, 21 Mar 2024 05:39:15 -0700 (PDT)
From: Christian Loehle <christian.loehle@arm.com>
To: linux-kernel@vger.kernel.org
Cc: vincent.guittot@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	dietmar.eggemann@arm.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched/fair: Remove stale FREQUENCY_UTIL mention
Date: Thu, 21 Mar 2024 12:39:09 +0000
Message-Id: <20240321123909.3892773-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

effective_cpu_util() flags were removed, so remove mentioning of the
flag.

commit 9c0b4bb7f6303 ("sched/cpufreq: Rework schedutil governor performance estimation")
reworked effective_cpu_util() removing enum cpu_util_type. Modify the
comment accordingly.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..a674832efbc1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7861,8 +7861,8 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
 		 * Performance domain frequency: utilization clamping
 		 * must be considered since it affects the selection
 		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the
-		 * FREQUENCY_UTIL's utilization can be max OPP.
+		 * NOTE: in case RT tasks are running, by default the min
+		 * utilization can be max OPP.
 		 */
 		eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-- 
2.34.1


