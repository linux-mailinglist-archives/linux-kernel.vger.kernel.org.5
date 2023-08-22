Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BA1783C1A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjHVIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjHVIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:47:38 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94793E45
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 01:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy0uIhFEiyWVL8FtGfH1+T/1b5ELQ3WLPjjykDPamCP04oMMJKQdeSbf9lwv289NYi0qfV5WvPuYqwRwfCvXpdG3d3cFGwANER77BjIZOK5N8N0j1dnbqihJcjUSmFuozsL8DRaj4I3esrQJ8Y8sz4WijOv1VH7qF1cQrFum50qMcP9NaC6bCA7PNyCoTq/sqxDY6n6J3RG9+7aknrMFtIyVs6mi3tIK/SSDPzC7Dy+HQvQQKSG9/54keBxX0+9gJJ8bMBZqr63xP8CPIhUKaQlS6GuEd/RUqHVnYvddPtYzEVmMkgZU7zltIW/5WP76Wr1uF9E5ROVrSToVjH5z0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBT4ZsDhU4UK0CWceL4+KblEiHJflSJKZAmSIR8AOps=;
 b=Ne9ualEglkcgiLDIGZGbc1Iidmm6ZsPlvWn+kgUnNMOpm+12ztoH5i4W5tuigy/szscgRyMSAyEhX+SQRl5wd9RyW4zX9ipCP6VVuU5MbhfPFIZEN0CQaJRPWUlhJ6ngR2Hwa9jLH1h8Hs+eH+8Bqm+VbjIKf5SZYV0ZJEKJLAI7EMM+p4x/+xZqjl0KH3bkn/poGUZ5g9rOlBv9gjPUV+UtjAaRxZbfjzoip7kuNxXdkM9mMLfATHCF9UofcJ/LgrlVGqamjR/FE/Jvwb6uAcQav8YloxWWm2KeF/WbS2lWuad2F5UBS612qNO3IolfEqq0L/HBPGA+GmhHTcd1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBT4ZsDhU4UK0CWceL4+KblEiHJflSJKZAmSIR8AOps=;
 b=H0TgMWZFGyjotTSQMVYPcqy16900K9ywafqYUzVpYePZg8HxoT+oUqlrOuEv4HGTQi1q2NBgSjbqCm6LL5r7Ouyzth+XHGA2uNgVzQWOb7tBt7/l91qv/c3TQowz/qVwTxp/Dx5z82TZD70cx1g15HM53dl/VMBDLFvXJFXHmh2Y5izNm0eZUrK/ZSgIiw/HPoe0f/56TObIyMSfyaSyySITmjiQjFBwWpUuZHrsh7jwMkjP6Fv9SbK37YxFVsbtZKDu00AcA796WMDUAgjYzAKzfaiqW5KjeiwyPsBdu9tpteayBc1nmbDsOq7u/uhew9H/FntjNIru08F8AT7Q7w==
Received: from CY8PR10CA0040.namprd10.prod.outlook.com (2603:10b6:930:4b::16)
 by IA0PR12MB7580.namprd12.prod.outlook.com (2603:10b6:208:43b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 08:46:15 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::28) by CY8PR10CA0040.outlook.office365.com
 (2603:10b6:930:4b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 08:46:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 08:46:15 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 01:46:05 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 01:46:04 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 01:46:04 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <apopple@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH 2/3] iommu/arm-smmu-v3: Add an arm_smmu_tlb_inv_domain helper
Date:   Tue, 22 Aug 2023 01:45:52 -0700
Message-ID: <854e2b3f2d4f1b76f916fcfc288b34526d4d4162.1692693557.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692693557.git.nicolinc@nvidia.com>
References: <cover.1692693557.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|IA0PR12MB7580:EE_
X-MS-Office365-Filtering-Correlation-Id: 636e6c5b-866d-4a3d-3055-08dba2ec3ed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DK36KIL1VDsTw4rF2ebdcvpHKHNyTrGOT8fkGAG93zVBB6R5WvMJbJPMiBdJxr4u1lxVmhiglU4N+46YEugLD7yeKMhGJwT9eUf4dNhnsjMBJU8j9r7U5KxRTmqhQw3c9Z6CaiXRrTer9S59/moBJtDKf97uRUKrwVXIS7PqrlENVyJiFsWs1KJOsNVttrt3A+WPO0FsyDXgWWUmNxKJktrTfJnToq/q+TS+VwQI2Xwq6rL1QvClpF2GZOeKss1O4QF2+aL8FJSg2FEXfefcQ/SAi2Ejd9p5ZzBASMyuWgG6ddLDx9fgClKaAL5yjYLEb6w5rOpBXsCmKvJGz9BKymMBgxFgtdPLMhUpRA5hmU9Mql7/rMbX6XAoNmnmAldv4smMEe/mafiY6C8lP3dKxxqHhR4gwe6zf+9S9eNUZhKV+1k3fD80NqUilcuJdLxxtjz6+dIYXMN4OUa8oAUEKJaldTqtScTE7PIhWLFMO/huze+amyA7O18QJZpJGkb0BbglfClYkHlGxg8vCb3X88dEtybW82rfizjP3uttJ+C4iJQ9Jt9A2h3IZU9AI8/yG3DNSHo1gZchBAz78pROQlhm/19s7oRfhYL5Oczljfs5xJUZsAaGJkq5TpUjhhBGqxbtBv2JyNFP5+qeRatUhS7ntBqvk8/hmshVPXZABLl6GybBycaph1Pg++E141DzkwWG6BXTHGJyyA+/c09j0M5tO+7H7K4fF7TOtbwHZefJaKGoC4o/wi05tHiJnoO5
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799009)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(54906003)(6636002)(70206006)(70586007)(316002)(110136005)(8676002)(8936002)(2616005)(4326008)(7636003)(40460700003)(36756003)(41300700001)(82740400003)(356005)(478600001)(6666004)(40480700001)(83380400001)(2906002)(86362001)(7696005)(47076005)(36860700001)(336012)(426003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 08:46:15.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 636e6c5b-866d-4a3d-3055-08dba2ec3ed4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the part of per-asid or per-vmid invalidation command issuing into a
new helper function, which will be used in the following change.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..d6c647e1eb01 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1854,12 +1854,24 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
+static void arm_smmu_tlb_inv_domain(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cmdq_ent cmd;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
+	} else {
+		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
+		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	}
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -1868,13 +1880,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		arm_smmu_tlb_inv_asid(smmu, smmu_domain->s1_cfg.cd.asid);
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-	}
+	arm_smmu_tlb_inv_domain(smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
 }
 
-- 
2.41.0

