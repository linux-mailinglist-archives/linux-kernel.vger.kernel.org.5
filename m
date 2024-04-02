Return-Path: <linux-kernel+bounces-127806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22242895135
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52DAD1C23365
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8819E76F17;
	Tue,  2 Apr 2024 10:58:43 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC268604C8;
	Tue,  2 Apr 2024 10:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055523; cv=none; b=TBvxU81eDVdZIXryMNAHjDggpdaMGcQ6BKglnDK6meunoy2oCC2Pt0T6IxW37XuR6ysktmw96naV9SnNiQZr8wpUVTAQTbWetyo6x3026Or8R9eBlrcFmYiHoj8GYCmjISU/xPP+QBZ8S+MxPPImFl8xcOjcBGInFJeIudWk1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055523; c=relaxed/simple;
	bh=EpGppEMctUZVg/y6NfsAZO5VgivZhhbrlYGn+JnuFRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kQyiMngLJpRzusDY3dUCQerRdsDG5E1FwIK3IFmsPQyQJDJLwLVOfYQr6QYUEZ5xvyHqfvitkR3Z9+JUGWuNy0SAdVVF+oGQTn2tn7ZepQSOzenA6hBJ3wS2n5lQlJ3lu2VYSdPipPTUfOd1oXCcwnTDogaq5kM62sHLOcgOZqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz11t1712055445thvlyu
X-QQ-Originating-IP: Gi/zIc7rVg0nbwrff8zyxNmy8QhoIujNcA126m1YLzA=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:57:24 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: oH0qrucfWSzFqe9iiuJWrQbXT3+hF7FViMjye7PQ7tMx+WAd07wFqawEYOHIi
	JvhzhYFM7DxB7np8RUejiLG05a1eqBYpBHd2E2yQsRV0tKruLW9G+7AR74nQNIbc96P/YN9
	F9DqLnSpgWlaOLEVgJUPjMb/W5IRv3rYY168IsP3Xck+kvAn9NiSO4Z8XiGMKnX8EeCxu41
	+Zdbyx8c2vTJpJGgXaVSTjwmb5pM1S+CtX1+7WvKF4EjkZCZVdRbOf37dVFQzW1/9nssHyr
	UgSJQv9QtSAdHJXwD8VDFbDEgNTOTjNb5dFvAfVa6NQuTfo9364Kl7/V2j/rNOZGAALKA2D
	QpRhoIp/1NPwQd3JFXQQLFMY92yRULneQGggzXRo6c6Ufk7pDWaa/6xAELE8iDiUo+Vnb2g
	rs8K4IhG/a0l6aSuJSkLWg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17509807497334739871
From: Dawei Li <dawei.li@shingroup.cn>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Dawei Li <dawei.li@shingroup.cn>
Subject: [PATCH 7/9] perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:08 +0800
Message-Id: <20240402105610.1695644-8-dawei.li@shingroup.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240402105610.1695644-1-dawei.li@shingroup.cn>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..06891d23b21c 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -504,7 +504,7 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct hisi_pmu *hisi_pmu = hlist_entry_safe(node, struct hisi_pmu,
 						     node);
-	cpumask_t pmu_online_cpus;
+	cpumask_var_t pmu_online_cpus;
 	unsigned int target;
 
 	if (!cpumask_test_and_clear_cpu(cpu, &hisi_pmu->associated_cpus))
@@ -514,21 +514,26 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (hisi_pmu->on_cpu != cpu)
 		return 0;
 
+	if (!alloc_cpumask_var(&pmu_online_cpus, GFP_KERNEL))
+		return 0;
+
 	/* Give up ownership of the PMU */
 	hisi_pmu->on_cpu = -1;
 
 	/* Choose a new CPU to migrate ownership of the PMU to */
-	cpumask_and(&pmu_online_cpus, &hisi_pmu->associated_cpus,
+	cpumask_and(pmu_online_cpus, &hisi_pmu->associated_cpus,
 		    cpu_online_mask);
-	target = cpumask_any_but(&pmu_online_cpus, cpu);
+	target = cpumask_any_but(pmu_online_cpus, cpu);
 	if (target >= nr_cpu_ids)
-		return 0;
+		goto __free_cpumask;
 
 	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
 	/* Use this CPU for event counting */
 	hisi_pmu->on_cpu = target;
 	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
 
+__free_cpumask:
+	free_cpumask_var(pmu_online_cpus);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hisi_uncore_pmu_offline_cpu);
-- 
2.27.0


