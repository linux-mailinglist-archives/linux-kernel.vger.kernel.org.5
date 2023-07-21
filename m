Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226B675BEFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjGUGgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGUGgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:36:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD582718
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:36:20 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L5WnJp017249;
        Thu, 20 Jul 2023 23:35:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=7mnorin6NXNKK95IWr6irgZNfgOv849RtHW6/z7AsoI=;
 b=iX2BPUySrpWWHzWnrPmp/ry8Zf5oCA3FSoTjZSxOhB1mdtLCNGHwjIBAKaxjXFktYd2E
 42lLWRF73ucQNeZ6RX/2o0fdmN8usAqh7Z7HeZCkExIVDlM3UiqC6aLOFeTzII7RYmlp
 qcqjHJCYLzlknO17s1SB2bV9tA2Rb1nDu5HHL8sD8yC1/YDFCHrZiHFshGXPQqViM0Mx
 rN7pvVlOVnZaKGhPXGLlydDDhQ88C59IXiJvCrcDJDbR9InF3VX1cqK5AhEVlWySxaqh
 oL3RxrOS8Fs3095M6X8LnzGlzFsU7cFpJmeYgmvTSfm4jhQ/9yg9m7PXwjFkWb+Az/Vj 3w== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ryh5egm4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 23:35:58 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 20 Jul
 2023 23:35:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 20 Jul 2023 23:35:56 -0700
Received: from odyssey-031.marvell.com (unknown [10.75.48.92])
        by maili.marvell.com (Postfix) with ESMTP id B52713F7068;
        Thu, 20 Jul 2023 23:35:55 -0700 (PDT)
From:   Tanmay Jagdale <tanmay@marvell.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <gcherian@marvell.com>,
        <sgoutham@marvell.com>, <lcherian@marvell.com>,
        <bbhushan2@marvell.com>
Subject: [RESEND PATCH 2/4] iommu/arm-smmu-v3: Ensure that a set of associated commands are inserted in the same ECMDQ
Date:   Fri, 21 Jul 2023 02:35:11 -0400
Message-ID: <20230721063513.33431-3-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230721063513.33431-1-tanmay@marvell.com>
References: <20230721063513.33431-1-tanmay@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 4ftrmbQv65nvJOi9WF3WLoc_DhG0wT1a
X-Proofpoint-ORIG-GUID: 4ftrmbQv65nvJOi9WF3WLoc_DhG0wT1a
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

The SYNC command only ensures that the command that precedes it in the
same ECMDQ must be executed, but cannot synchronize the commands in other
ECMDQs. If an unmap involves multiple commands, some commands are executed
on one core, and the other commands are executed on another core. In this
case, after the SYNC execution is complete, the execution of all preceded
commands can not be ensured.

Prevent the process that performs a set of associated commands insertion
from being migrated to other cores ensures that all commands are inserted
into the same ECMDQ.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 +++++++++++++++++----
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dfb5bf8cbcf9..1b3b37a1972e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -243,6 +243,18 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
 	return 0;
 }
 
+static void arm_smmu_preempt_disable(struct arm_smmu_device *smmu)
+{
+	if (smmu->ecmdq_enabled)
+		preempt_disable();
+}
+
+static void arm_smmu_preempt_enable(struct arm_smmu_device *smmu)
+{
+	if (smmu->ecmdq_enabled)
+		preempt_enable();
+}
+
 /* High-level queue accessors */
 static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 {
@@ -1035,6 +1047,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 
 	cmds.num = 0;
 
+	arm_smmu_preempt_disable(smmu);
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		for (i = 0; i < master->num_streams; i++) {
@@ -1045,6 +1058,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
@@ -1840,31 +1854,38 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_device *smmu = master->smmu;
 
 	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
 
 	cmds.num = 0;
+
+	arm_smmu_preempt_disable(smmu);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
-		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
+
+	return ret;
 }
 
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
-	int i;
+	int i, ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
+	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
 
 	/*
@@ -1888,6 +1909,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	cmds.num = 0;
 
+	arm_smmu_preempt_disable(smmu);
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		if (!master->ats_enabled)
@@ -1895,12 +1917,15 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 		}
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
+
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -1960,6 +1985,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	cmds.num = 0;
 
+	arm_smmu_preempt_disable(smmu);
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -1991,6 +2017,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		iova += inv_range;
 	}
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-- 
2.34.1

