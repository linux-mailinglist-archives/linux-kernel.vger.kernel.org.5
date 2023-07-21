Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5175BF00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGUGhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjGUGgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:36:55 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF053588
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:36:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L2LDL7013218;
        Thu, 20 Jul 2023 23:36:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=y5rYVMqlqcgaO0n1TOniSNX7UmtSDrRMaWOfswavg+g=;
 b=J8HOFnULcDdLqKzHn+S/zOaKGSrzpVlyzjwPbG7cTvqf3DFsPGsCAgtxRn0Fg/d8Hy7O
 k1kkamkZID4kA5/cPM4g4BumrBRsAwYNnnoP1T97HhtjTM6S6bnw48bj/k6Eg+cvt4U/
 0GQKcr3nngjt3R94MiBuoTqXwpbaRSCS/j64JMZw7XDQPGYIQ77g0//qa3ElzIs5CUs5
 YLt26xywfIQL0Vf0b0eZ8mIeav6+YNl9Rpr5iRSqPtZyb+tfpG0Pc3ZmcR4Ued0vgzBn
 ISdabiSj+ZT24LucxwcH/RPrBSWe7f3Wv4HbGCuhKiXi4DWElTkEkfXyb2JK3Bj53C51 6Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh5egm67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 23:36:17 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:36:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:36:15 -0700
Received: from odyssey-031.marvell.com (unknown [10.75.48.92])
        by maili.marvell.com (Postfix) with ESMTP id A35BE3F706D;
        Thu, 20 Jul 2023 23:36:14 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [RESEND PATCH 4/4] iommu/arm-smmu-v3: Add support for less than one ECMDQ per core
Date:   Fri, 21 Jul 2023 02:35:13 -0400
Message-ID: <20230721063513.33431-5-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 67Cu0u_IHwnyHfEkMTTzbXYj73N31Vpa
X-Proofpoint-ORIG-GUID: 67Cu0u_IHwnyHfEkMTTzbXYj73N31Vpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_03,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Due to limited hardware resources, the number of ECMDQs may be less than
the number of cores. If the number of ECMDQs is greater than the number of
numa nodes, ensure that each node has at least one ECMDQ. This is because
ECMDQ queue memory is requested from the NUMA node where it resides, which
may result in better command filling and insertion performance.

The current ECMDQ implementation reuses the command insertion function
arm_smmu_cmdq_issue_cmdlist() of the normal CMDQ. This function already
supports multiple cores concurrent insertion commands.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 101 ++++++++++++++++++--
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dc3ff4796aaf..7a4f3d871635 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3678,14 +3678,15 @@ static void arm_smmu_device_iidr_probe(struct arm_smmu_device *smmu)
 
 static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 {
-	int cpu;
-	struct arm_smmu_ecmdq *ecmdq;
+	int cpu, node, nr_remain, nr_nodes = 0;
+	int *nr_ecmdqs;
+	struct arm_smmu_ecmdq *ecmdq, **ecmdqs;
 
-	if (num_possible_cpus() <= smmu->nr_ecmdq) {
-		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
-		if (!ecmdq)
-			return -ENOMEM;
+	ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+	if (!ecmdq)
+		return -ENOMEM;
 
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
 		for_each_possible_cpu(cpu)
 			*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
 
@@ -3695,7 +3696,79 @@ static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 		return 0;
 	}
 
-	return -ENOSPC;
+	for_each_node(node)
+		if (nr_cpus_node(node))
+			nr_nodes++;
+
+	if (nr_nodes >= smmu->nr_ecmdq) {
+		dev_err(smmu->dev, "%d ECMDQs is less than %d nodes\n", smmu->nr_ecmdq, nr_nodes);
+		return -ENOSPC;
+	}
+
+	nr_ecmdqs = kcalloc(MAX_NUMNODES, sizeof(int), GFP_KERNEL);
+	if (!nr_ecmdqs)
+		return -ENOMEM;
+
+	ecmdqs = kcalloc(smmu->nr_ecmdq, sizeof(*ecmdqs), GFP_KERNEL);
+	if (!ecmdqs) {
+		kfree(nr_ecmdqs);
+		return -ENOMEM;
+	}
+
+	/* [1] Ensure that each node has at least one ECMDQ */
+	nr_remain = smmu->nr_ecmdq - nr_nodes;
+	for_each_node(node) {
+		/*
+		 * Calculate the number of ECMDQs to be allocated to this node.
+		 * NR_ECMDQS_PER_CPU = nr_remain / num_possible_cpus();
+		 * When nr_cpus_node(node) is not zero, less than one ECMDQ
+		 * may be left due to truncation rounding.
+		 */
+		nr_ecmdqs[node] = nr_cpus_node(node) * nr_remain / num_possible_cpus();
+		nr_remain -= nr_ecmdqs[node];
+	}
+
+	/* Divide the remaining ECMDQs */
+	while (nr_remain) {
+		for_each_node(node) {
+			if (!nr_remain)
+				break;
+
+			if (nr_ecmdqs[node] >= nr_cpus_node(node))
+				continue;
+
+			nr_ecmdqs[node]++;
+			nr_remain--;
+		}
+	}
+
+	for_each_node(node) {
+		int i, round, shared = 0;
+
+		if (!nr_cpus_node(node))
+			continue;
+
+		/* An ECMDQ has been reserved for each node at above [1] */
+		nr_ecmdqs[node]++;
+
+		if (nr_ecmdqs[node] < nr_cpus_node(node))
+			shared = 1;
+
+		i = 0;
+		for_each_cpu(cpu, cpumask_of_node(node)) {
+			round = i % nr_ecmdqs[node];
+			if (i++ < nr_ecmdqs[node]) {
+				ecmdqs[round] = per_cpu_ptr(ecmdq, cpu);
+				ecmdqs[round]->cmdq.shared = shared;
+			}
+			*per_cpu_ptr(smmu->ecmdq, cpu) = ecmdqs[round];
+		}
+	}
+
+	kfree(nr_ecmdqs);
+	kfree(ecmdqs);
+
+	return 0;
 }
 
 static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
@@ -3760,10 +3833,20 @@ static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
 		struct arm_smmu_queue *q;
 
 		ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
-		ecmdq->base = cp_base + addr;
-
 		q = &ecmdq->cmdq.q;
 
+		/*
+		 * The boot option "maxcpus=" can limit the number of online
+		 * CPUs. The CPUs that are not selected are not showed in
+		 * cpumask_of_node(node), their 'ecmdq' may be NULL.
+		 *
+		 * (q->ecmdq_prod & ECMDQ_PROD_EN) indicates that the ECMDQ is
+		 * shared by multiple cores and has been initialized.
+		 */
+		if (!ecmdq || (q->ecmdq_prod & ECMDQ_PROD_EN))
+			continue;
+		ecmdq->base = cp_base + addr;
+
 		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
 		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
 				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
-- 
2.34.1

