Return-Path: <linux-kernel+bounces-127805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A346A895132
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E811F2366C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D2D69D27;
	Tue,  2 Apr 2024 10:58:31 +0000 (UTC)
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD61605C6;
	Tue,  2 Apr 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055510; cv=none; b=Xqv1vaVGjEITxf0MXM1WlHV+ZkBY3OLrpXIS+chVKHVnC9jqDrfdmyUJ8CFrZGSnGw8B5KcehCjLtM49jWUpP+o/PJ7Bh9Mm3eh2Q0dMzASoxwIeVGQKG5PVU76zuLKXXHhRf3csAlI8sjUvcWPET+Dlh1VGZDmCoGML5Xfg1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055510; c=relaxed/simple;
	bh=RnffjsKX2UYc8upK6sWTNPvoU/wb++tR7MPvg11VYzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XBkFf6ClP70dOI1k4TjuVLPOSr0+uxmGrKagH9AZu7ClW4qoFrznYveyyU8RhF8gJFLAaLIFgXZLEqjT55D0mNRXTL9J8UhKi/I1ScHoGL/BvJEJ7R1qHHDZBZHsDoufp5WqEYCNhXiBuercNvakDSFCeWWjuWgWwD4+lyLXDhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp79t1712055451tfob8lde
X-QQ-Originating-IP: PvsZUuatj8QZ641yXn+lcd5OMQTi7GdjZdQznKAkR/c=
Received: from localhost ( [112.0.147.175])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 02 Apr 2024 18:57:30 +0800 (CST)
X-QQ-SSF: 01400000000000704000000A0000000
X-QQ-FEAT: 3M0okmaRx3jH2qX8AogQHU2fcWNrGo2m8LilTigAJGetQhSvXHKYfErP0NM75
	LrLgEVYP1YRb8qe3MRdxEekWoo5hH08O0sfTXLO/ew6InuqS9bX8bCQzX9wpBoCEnYIftWx
	0Iiy8irGQWVfNVew8n5ovD3FhludIYtnYSe8TB7KcbcuECYTOVGti7aIQ6SBdScG7kPu24i
	OSuEHuOzvNe2m3J0XBsN5R2ab9casuA2B8Mbb/MJudJNNqMJTBbSebRwrbTKt+d0veZqblc
	mTclwuGYYfoZbHa+LltKPPFuNEaRFC7dns6y+ICp8/kR5nGWn54YsFNkUFUoj/hzJIfGY3O
	G94XtmzoQFTPOJg6AMG9Pw4J8XCAVF1ntPTGe8FI0ZWQm5W0sMj+4gLDbm1WT7EXj9Uwt+Z
	oTMaqai9+7g=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 1383880197546244670
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
Subject: [PATCH 8/9] perf/qcom_l2: Avoid explicit cpumask var allocation from stack
Date: Tue,  2 Apr 2024 18:56:09 +0800
Message-Id: <20240402105610.1695644-9-dawei.li@shingroup.cn>
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
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-1

For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
variable on stack is not recommended since it can cause potential stack
overflow.

Instead, kernel code should always use *cpumask_var API(s) to allocate
cpumask var in config- neutral way, leaving allocation strategy to
CONFIG_CPUMASK_OFFSTACK.

Use *cpumask_var API(s) to address it.

Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
---
 drivers/perf/qcom_l2_pmu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 148df5ae8ef8..8fe0c7557521 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -801,9 +801,9 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 {
-	struct cluster_pmu *cluster;
+	cpumask_var_t cluster_online_cpus;
 	struct l2cache_pmu *l2cache_pmu;
-	cpumask_t cluster_online_cpus;
+	struct cluster_pmu *cluster;
 	unsigned int target;
 
 	l2cache_pmu = hlist_entry_safe(node, struct l2cache_pmu, node);
@@ -815,17 +815,20 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	if (cluster->on_cpu != cpu)
 		return 0;
 
+	if (!alloc_cpumask_var(&cluster_online_cpus, GFP_KERNEL))
+		return 0;
+
 	/* Give up ownership of cluster */
 	cpumask_clear_cpu(cpu, &l2cache_pmu->cpumask);
 	cluster->on_cpu = -1;
 
 	/* Any other CPU for this cluster which is still online */
-	cpumask_and(&cluster_online_cpus, &cluster->cluster_cpus,
+	cpumask_and(cluster_online_cpus, &cluster->cluster_cpus,
 		    cpu_online_mask);
-	target = cpumask_any_but(&cluster_online_cpus, cpu);
+	target = cpumask_any_but(cluster_online_cpus, cpu);
 	if (target >= nr_cpu_ids) {
 		disable_irq(cluster->irq);
-		return 0;
+		goto __free_cpumask;
 	}
 
 	perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
@@ -833,6 +836,8 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 	cpumask_set_cpu(target, &l2cache_pmu->cpumask);
 	WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
 
+__free_cpumask:
+	free_cpumask_var(cluster_online_cpus);
 	return 0;
 }
 
-- 
2.27.0


