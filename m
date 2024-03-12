Return-Path: <linux-kernel+bounces-99953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37590878FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693571C21720
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B0577F12;
	Tue, 12 Mar 2024 08:35:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7396996B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710232511; cv=none; b=lOEqYuqJ7Pn9OKIW+HTGSzCCrzZJigiACyMlbiyAlaaugVSAo5suE6sB5Yc9r9fwsWCSFNrwNyVSrZZydxlvrPcseAi3f61eJMOJJMvNTlbld2HdoZGX2z8tfACZf4qRx8r0YS3LAlHUI83UgBvi5wfDTcCpztoI3fRm5lkr9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710232511; c=relaxed/simple;
	bh=3m++agGg9LMrEIrVry1NTk+nR2ElsK5com/aXDFqL/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYau273dTftIMl0x0GmwGa57sXo9IZBNWK3iUJD8475rl1G8WcFnMnBR9V2BdLchy7YxewbwwydI4ZF0hvepjm9SParUpN1vv6VCOMHWPK8g/9vwXiUcgX9DDOA5fUHFrlQaCSeM4qrVuONPj/NxChLgufyjIFN8Kc6FG4e+tOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 461561570;
	Tue, 12 Mar 2024 01:35:45 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6FF2C3F73F;
	Tue, 12 Mar 2024 01:35:06 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	vanshikonda@os.amperecomputing.com
Cc: sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	vincent.guittot@linaro.org,
	sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	lihuisong@huawei.com
Subject: [PATCH v3 1/3] arch_topology: init capacity_freq_ref to 0
Date: Tue, 12 Mar 2024 08:34:29 +0000
Message-Id: <20240312083431.3239989-2-beata.michalska@arm.com>
In-Reply-To: <20240312083431.3239989-1-beata.michalska@arm.com>
References: <20240312083431.3239989-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionela Voinescu <ionela.voinescu@arm.com>

It's useful to have capacity_freq_ref initialized to 0 for users of
arch_scale_freq_ref() to detect when capacity_freq_ref was not
yet set.

The only scenario affected by this change in the init value is when a
cpufreq driver is never loaded. As a result, the only setter of a
cpu scale factor remains the call of topology_normalize_cpu_scale()
from parse_dt_topology(). There we cannot use the value 0 of
capacity_freq_ref so we have to compensate for its uninitialized state.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 drivers/base/arch_topology.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a0cfc1..7d4c92cd2bad 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -27,7 +27,7 @@
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
-DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 1;
+DEFINE_PER_CPU(unsigned long, capacity_freq_ref) = 0;
 EXPORT_PER_CPU_SYMBOL_GPL(capacity_freq_ref);
 
 static bool supports_scale_freq_counters(const struct cpumask *cpus)
@@ -292,13 +292,15 @@ void topology_normalize_cpu_scale(void)
 
 	capacity_scale = 1;
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
+		capacity = raw_capacity[cpu] *
+			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
 		capacity_scale = max(capacity, capacity_scale);
 	}
 
 	pr_debug("cpu_capacity: capacity_scale=%llu\n", capacity_scale);
 	for_each_possible_cpu(cpu) {
-		capacity = raw_capacity[cpu] * per_cpu(capacity_freq_ref, cpu);
+		capacity = raw_capacity[cpu] *
+			   (per_cpu(capacity_freq_ref, cpu) ?: 1);
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 			capacity_scale);
 		topology_set_cpu_scale(cpu, capacity);
-- 
2.25.1


