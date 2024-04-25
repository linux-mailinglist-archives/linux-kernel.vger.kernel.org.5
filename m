Return-Path: <linux-kernel+bounces-158722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096E8B2427
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3F51F21B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5DA14A4F3;
	Thu, 25 Apr 2024 14:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iFlL/d07"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD1014A0A8
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714055516; cv=none; b=Ck9v7U7mrv6FvlE80PN2npUF8SLtGPauC9HYjg3KVQ7YTbsqDUmZ2RpILblpIO1nw4ceksU9aVLpsWxWMJgyQoiVyimdxfWyVGxPMp5lVo2GK/0vtk+o9dMLDiGrvSlIchiuT8DzYhMbRNiqwKO1Du8euc7+h7UeukdkQB1w8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714055516; c=relaxed/simple;
	bh=i6AbbnVow7RKsK+NcoraEZ71oa6l1Y+UAmeFkO9KWk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bwprnJmCRvyVf2yN9mZuOcpdGBAROhdMfBOUjNiM6hsE5xjnuHHwwVPGeHsvK0nzM6K9r6YKRNQGX4QTiumGDpgoPyRjiDa6Z9CiyuXW3QQiZSKeXXra1JzvwwguDZ0fV+zRxVRNF3Be5sRChrS1gvG3SgdzKJSwbBVuTwxewoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iFlL/d07; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PA4K4g007365;
	Thu, 25 Apr 2024 07:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=jYw/vx1k
	9Nqv/Lp9uCDaV7RJmIlPtnQxIERYqC1PzH0=; b=iFlL/d07xHnLlF6tVzlghQjF
	f73rphVOU1ed0SOutDmxchgprcWpy8g8YBo1UYrNqevJOqjdy9XFF/e7J35YXSz3
	Ji7PgmwOYmS3MmWULKSRcrskG0LWJ6E/T2yMkMhCIIwzdF/eBWpUsYJLmFjhcHs+
	0RaVEGrYPflOV/VN5Gtu9Ei7a0/rAFeZIReB+43sDYfu6pT3bb88DFr9TYjdTC7S
	gSJu5LXVHyjxx7VkQ7V8WicH0P1RSdwGl755foM1iUWnKLlUJw16BWUW/Y1t102X
	HQje/weHBCW8iBgRS+/MOtAyYhN0LpdAc7wWcNMHjPNxEIZWvUjLq+5WFCenGQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xqn3n99b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 07:31:22 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 25 Apr 2024 07:31:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 25 Apr 2024 07:31:10 -0700
Received: from cn10ka.sclab.marvell.com (unknown [10.106.49.40])
	by maili.marvell.com (Postfix) with ESMTP id E7ABA3F704A;
	Thu, 25 Apr 2024 07:31:09 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <nicolinc@nvidia.com>, <mshavit@google.com>,
        <baolu.lu@linux.intel.com>, <thunder.leizhen@huawei.com>,
        <set_pte_at@outlook.com>, <smostafa@google.com>
CC: <sgoutham@marvell.com>, <gcherian@marvell.com>, <jcm@jonmasters.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Tanmay Jagdale <tanmay@marvell.com>
Subject: [PATCH V3 2/2] iommu/arm-smmu-v3: Ensure that a set of associated commands are inserted in the same ECMDQ
Date: Thu, 25 Apr 2024 07:31:07 -0700
Message-ID: <20240425143107.52318-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: olgSPLhUeyvLkQl6fzW8Zrn6MteoYZlz
X-Proofpoint-GUID: olgSPLhUeyvLkQl6fzW8Zrn6MteoYZlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02

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
Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 42 +++++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8e088ca4e8e1..d53b808de03f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -248,6 +248,18 @@ static int queue_remove_raw(struct arm_smmu_queue *q, u64 *ent)
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
@@ -1229,12 +1241,15 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	};
 
 	cmds.num = 0;
+
+	arm_smmu_preempt_disable(smmu);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static int arm_smmu_alloc_cd_leaf_table(struct arm_smmu_device *smmu,
@@ -1979,31 +1994,38 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_device *smmu = master->smmu;
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
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
@@ -2027,6 +2049,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	cmds.num = 0;
 
+	arm_smmu_preempt_disable(smmu);
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
 		if (!master->ats_enabled)
@@ -2034,12 +2057,15 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
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
@@ -2104,6 +2130,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 
 	cmds.num = 0;
 
+	arm_smmu_preempt_disable(smmu);
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 			/*
@@ -2135,6 +2162,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		iova += inv_range;
 	}
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_preempt_enable(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
-- 
2.34.1


