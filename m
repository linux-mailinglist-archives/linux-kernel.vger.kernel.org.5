Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4627884F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbjHYKcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242559AbjHYKb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:31:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685ECE7F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 03:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aN7eN5eIaN+yQbdaOtfaT9CVaxYlCbKKMhMFRsNr0HEEBb+Jf7MIxVpezS/j0OU7JK81DPCDAQsNXMomGCNBN3FrrUgpUdkZsSxN+dJEoaltcKVErwICXglIyjCG6JoT2k3fqVHuD3sA4aGJGwFx+niO2kzO94nYIsOo2HFWdE51zhcsJbsqkZQlPxttmQcDifvKxpbddjzyDGS+c3banvD1I70Ty/8r4zEMSdKdeno5/BpsxacOWPXemcrx/4ZlBmof45bCJ7KTF5f9uEASkjN9OJ6InLgIiVTaGGnNJ0HKZFQeonSPy14spfxs/kcsa7Q6ENotiX9aEcjhicZxUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wceeVQfcetdakbjQHEAWnZkEkV8Nu2st7X9BJ/4mAbo=;
 b=oB21ouyMtZzIPHjulNIjm+vXRVYd5/a397zwNLTcxY7THj1IIY/3sG8/QM22gxivUbzPpHfPazEGYbvw3FJA3/L1myaXAr/tSsaJ0Zy/FsewHs9sSFhUfelbmXz+978JL0gQRyrb2l6AFUJVE4iAdFsNRfVvpApzJpxqr6JS+inkt42MqHi9NSwUHP6YRvgkBA5x7kUFEyMPhK9nLoKJMDdGNLu6vovI3etKjLT27G/ljAD/k2sFOj8afvL3mtMgdR2DDaOjMCXWZLb2aVjRmWgrIN7aOcncCal+FMGgX2zipCHWR421nVmcOQw9aItsT4KZob8kGqxBB4ZwLqUSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wceeVQfcetdakbjQHEAWnZkEkV8Nu2st7X9BJ/4mAbo=;
 b=RR3/CzcXKwAiOWbven+t/Ov8mPcT9yAGMK9Cyg4Ju/FUp2+mZSsYwhG1X5zcE5AVj8U//vI7weHxvVaMsQpRPB6qD02kQF7KbGR5xiHsV1pd2u5PJ++Gqzk/zmqKZ1jNCAbKipa8zpFZkaswEnjAS0Rq50IF7ea+nLIn8F40YdrzSFnIjy19KHKt8/plh3i1gWLnzByLRvZ6gsaR1Po8bx5ZmeL3GcnR9Hve898CoApAoifnGnMMi5xFGPYJxBV6S5i5l/VFDvaQGkFzQQAw5QimIXS+tqmEuy/tRVue7dS7cgcHUICOMkq2Bbtwx8V9wbeY1Ujc9WUOwrvRL0jUXA==
Received: from CYZPR12CA0017.namprd12.prod.outlook.com (2603:10b6:930:8b::14)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 10:31:51 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::1f) by CYZPR12CA0017.outlook.office365.com
 (2603:10b6:930:8b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30 via Frontend
 Transport; Fri, 25 Aug 2023 10:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.81) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Fri, 25 Aug 2023 10:31:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 25 Aug 2023
 03:31:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 25 Aug 2023 03:31:41 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 25 Aug 2023 03:31:41 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <mshavit@google.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v3 2/2] iommu/arm-smmu-v3: Refactor arm_smmu_write_strtab_ent()
Date:   Fri, 25 Aug 2023 03:31:24 -0700
Message-ID: <c1926ab1f06de64b4d30f1708b586a4ba95a4fdb.1692959239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1692959239.git.nicolinc@nvidia.com>
References: <cover.1692959239.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c503336-8e55-4c57-47ff-08dba5567e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYQBZfTGe/ZTM35TZXQ1c0CK1NtVomaQeq2DWLtj/c7iAmRQuY2kwT+Fe0OlrIpaV+1PRsb6qC97ZIg1YCa93zDJiMHWEJ0exI7tZYvciDsfixPAEHZNtZYgbxVx51Uqt/qvjquKfP8ddQiqyYhmGA/id1pHFLpdmgZk5te3jmNvIZQv9MTvmjjQlMlYUim5u+grrhlDSuFlDRQLFClsDEXXMegJl80tAkzHWTyOfQBv6fpfNwhjYrBjasi2PeuDE7DdXSlSmELmXXcGeBUF83icCajX6ydLzoIuETdctLB78sA66l0MtRDY8r2Nc6HgQ2O2OpZnli3f8h/qcyHc0BY8OXHE9g4U+gN4uuHjp2Kz2pYqdC5/UDX5JQJ2wbO9ESLa4LGEIpIbBMcmBjLb7ODxqPYfSR5KmWtvtQhoFcunUNF4M+pBdAHEOYgL3zOEdPkzh4Vw89c11F3CvTWavtmK3yWW/zQJRzSFumvQlyoOnN4lSU4TlbtoP4lAevAEdpCwMZO/3CAWAHozDNnBBGd5Bh/xo8EdhsWt8+zXTzItG1mEMbKbWtVnK8bItqRmNQRZBhS6QRKBgCbmo3/rRr7cR98CZurs5GQblhgwbj6s8J14uVRcBRiaiGsoq9I1tIa/4QCaXMFsRb9U7ydMDO0oWfBaOKzcu0oui5vk98qkJfJL0lkza2SE6tuhlAfniHcNoTGHEQ65e9TWNx7HhAIzdBr70AEAo56LLt4ED0nDtn6TPZd2pPdTFhG65Zj2zv3AqmaQPCLxWWzjpJZ7Sg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(336012)(426003)(2906002)(47076005)(36756003)(36860700001)(83380400001)(6666004)(40480700001)(8676002)(4326008)(478600001)(26005)(41300700001)(8936002)(2616005)(82740400003)(7636003)(5660300002)(6636002)(356005)(316002)(110136005)(70206006)(70586007)(54906003)(7696005)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 10:31:51.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c503336-8e55-4c57-47ff-08dba5567e89
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A stream table entry generally can be configured for the following cases:
Case #1: STE Stage-1 Translate Only
  The master has a CD table and attached to an S1 or BYPASS domain.
[Config #1] Set STE.Config to S1_TRANS. And set STE.SHCFG to INCOMING,
	    required by a BYPASS domain and ignored by an S1 domain.
	    Then follow the CD table to set the other fields.

Case #2: STE Stage-2 Translate Only
  The master doesn't have a CD table and attached to an S2 domain.
[Config #2] Set STE.Config to S2_TRANS. Then follow the s2_cfg to set the
            other fields.

Case #3: STE Stage-1 and Stage-2 Translate
  The master allocated a CD table and attached to a NESTED domain that has
  an s2_cfg somewhere for stage-2 fields.
[Config #4] Set STE.Config to S1_TRANS | S2_TRANS. Then follow both the CD
            table and the s2_cfg to set the other fields.

Case #4: STE Bypass
  The master doesn't have a CD table and attached to an INDENTITY domain.
[Config #3] Set STE.Config to BYPASS and set STE.SHCFG to INCOMING.

Case #5: STE Abort
  The master is not attached to any domain, and the "disable_bypass" param
  is set to "true".
[Config #4] Set STE.Config to ABORT

After the recent refactor of moving cd/cd_table ownerships, things in the
arm_smmu_write_strtab_ent() are a bit out of date, e.g. master pointer now
is always available. And it doesn't support a special case of attaching a
BYPASS domain to a multi-ssid master in the case #1.

Add helpers by naming them clearly for the first four STE.Config settings.

The case #5 can be covered by calling Config #2 at the end of Config #1,
though the driver currently doesn't really use it and should be updated to
the ongoing nesting design in the IOMMUFD. Yet, the helpers would be able
to simply support that in the future by adding very limited changes in the
switch-case in arm_smmu_ste_stage2_translate().

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 201 +++++++++++---------
 1 file changed, 112 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index de8bc4c3ad7a..c2ebbc916a2e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1251,6 +1251,91 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
+static void arm_smmu_ste_stage2_translate(struct arm_smmu_master *master,
+					  u64 *ste)
+{
+	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_s2_cfg *s2_cfg;
+
+	switch (smmu_domain->stage) {
+	case ARM_SMMU_DOMAIN_NESTED:
+	case ARM_SMMU_DOMAIN_S2:
+		s2_cfg = &smmu_domain->s2_cfg;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
+
+	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
+		ste[1] |= STRTAB_STE_1_S1STALLD;
+
+	if (master->ats_enabled)
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
+
+	ste[2] |= FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
+		  FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
+#ifdef __BIG_ENDIAN
+		  STRTAB_STE_2_S2ENDI |
+#endif
+		  STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2R;
+
+	ste[3] |= s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK;
+}
+
+static void arm_smmu_ste_stage1_translate(struct arm_smmu_master *master,
+					  u64 *ste)
+{
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	struct arm_smmu_device *smmu = master->smmu;
+	__le64 *cdptr = arm_smmu_get_cd_ptr(master, 0);
+
+	WARN_ON_ONCE(!cdptr);
+
+	ste[0] |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		  FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
+		  FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
+		  FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
+
+	if (FIELD_GET(CTXDESC_CD_0_ASID, le64_to_cpu(cdptr[0])))
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0);
+	else
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_BYPASS);
+
+	ste[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING) |
+		  FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		  FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
+		  FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH);
+
+	if (smmu->features & ARM_SMMU_FEAT_E2H)
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_EL2);
+	else
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_STRW, STRTAB_STE_1_STRW_NSEL1);
+
+	if (smmu->features & ARM_SMMU_FEAT_STALLS && !master->stall_enabled)
+		ste[1] |= STRTAB_STE_1_S1STALLD;
+
+	if (master->ats_enabled)
+		ste[1] |= FIELD_PREP(STRTAB_STE_1_EATS, STRTAB_STE_1_EATS_TRANS);
+
+	if (master->domain->stage == ARM_SMMU_DOMAIN_NESTED)
+		arm_smmu_ste_stage2_translate(master, ste);
+}
+
+static void arm_smmu_ste_abort(u64 *ste)
+{
+	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
+}
+
+static void arm_smmu_ste_bypass(u64 *ste)
+{
+	ste[0] |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
+	ste[1] |= FIELD_PREP(STRTAB_STE_1_SHCFG, STRTAB_STE_1_SHCFG_INCOMING);
+}
+
 static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 				      __le64 *dst)
 {
@@ -1270,12 +1355,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	 * 2. Write everything apart from dword 0, sync, write dword 0, sync
 	 * 3. Update Config, sync
 	 */
-	u64 val = le64_to_cpu(dst[0]);
+	int i;
+	u64 ste[4] = {0};
+	bool ste_sync_all = false;
 	bool ste_live = false;
-	struct arm_smmu_device *smmu = NULL;
-	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
-	struct arm_smmu_s2_cfg *s2_cfg = NULL;
-	struct arm_smmu_domain *smmu_domain = NULL;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
 		.opcode		= CMDQ_OP_PREFETCH_CFG,
 		.prefetch	= {
@@ -1283,27 +1367,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		},
 	};
 
-	if (master) {
-		smmu_domain = master->domain;
-		smmu = master->smmu;
-	}
-
-	if (smmu_domain) {
-		switch (smmu_domain->stage) {
-		case ARM_SMMU_DOMAIN_S1:
-			cd_table = &master->cd_table;
-			break;
-		case ARM_SMMU_DOMAIN_S2:
-		case ARM_SMMU_DOMAIN_NESTED:
-			s2_cfg = &smmu_domain->s2_cfg;
-			break;
-		default:
-			break;
-		}
-	}
-
-	if (val & STRTAB_STE_0_V) {
-		switch (FIELD_GET(STRTAB_STE_0_CFG, val)) {
+	if (le64_to_cpu(dst[0]) & STRTAB_STE_0_V) {
+		switch (FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(dst[0]))) {
 		case STRTAB_STE_0_CFG_BYPASS:
 			break;
 		case STRTAB_STE_0_CFG_S1_TRANS:
@@ -1318,78 +1383,36 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		}
 	}
 
-	/* Nuke the existing STE_0 value, as we're going to rewrite it */
-	val = STRTAB_STE_0_V;
-
-	/* Bypass/fault */
-	if (!smmu_domain || !(cd_table || s2_cfg)) {
-		if (!smmu_domain && disable_bypass)
-			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
-		else
-			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
-
-		dst[0] = cpu_to_le64(val);
-		dst[1] = cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
-						STRTAB_STE_1_SHCFG_INCOMING));
-		dst[2] = 0; /* Nuke the VMID */
-		/*
-		 * The SMMU can perform negative caching, so we must sync
-		 * the STE regardless of whether the old value was live.
-		 */
-		if (smmu)
-			arm_smmu_sync_ste_for_sid(smmu, sid);
-		master->cd_table.installed = false;
-		return;
-	}
-
-	if (cd_table) {
-		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
-			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
+	ste[0] = STRTAB_STE_0_V;
 
+	if (master->cd_table.cdtab && master->domain) {
+		BUG_ON(ste_live);
+		arm_smmu_ste_stage1_translate(master, ste);
+		master->cd_table.installed = true;
+	} else if (master->domain &&
+		   master->domain->stage == ARM_SMMU_DOMAIN_S2) {
 		BUG_ON(ste_live);
-		dst[1] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_1_S1DSS, STRTAB_STE_1_S1DSS_SSID0) |
-			 FIELD_PREP(STRTAB_STE_1_S1CIR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-			 FIELD_PREP(STRTAB_STE_1_S1COR, STRTAB_STE_1_S1C_CACHE_WBRA) |
-			 FIELD_PREP(STRTAB_STE_1_S1CSH, ARM_SMMU_SH_ISH) |
-			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
-
-		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
-		    !master->stall_enabled)
-			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
-
-		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
-			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
-			FIELD_PREP(STRTAB_STE_0_S1CDMAX, cd_table->s1cdmax) |
-			FIELD_PREP(STRTAB_STE_0_S1FMT, cd_table->s1fmt);
-		cd_table->installed = true;
+		arm_smmu_ste_stage2_translate(master, ste);
+		master->cd_table.installed = false;
+	} else if (!master->domain && disable_bypass) { /* Master is detached */
+		arm_smmu_ste_abort(ste);
+		master->cd_table.installed = false;
 	} else {
+		arm_smmu_ste_bypass(ste);
 		master->cd_table.installed = false;
 	}
 
-	if (s2_cfg) {
-		BUG_ON(ste_live);
-		dst[2] = cpu_to_le64(
-			 FIELD_PREP(STRTAB_STE_2_S2VMID, s2_cfg->vmid) |
-			 FIELD_PREP(STRTAB_STE_2_VTCR, s2_cfg->vtcr) |
-#ifdef __BIG_ENDIAN
-			 STRTAB_STE_2_S2ENDI |
-#endif
-			 STRTAB_STE_2_S2PTW | STRTAB_STE_2_S2AA64 |
-			 STRTAB_STE_2_S2R);
-
-		dst[3] = cpu_to_le64(s2_cfg->vttbr & STRTAB_STE_3_S2TTB_MASK);
-
-		val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S2_TRANS);
+	for (i = 1; i < 4; i++) {
+		if (dst[i] == cpu_to_le64(ste[i]))
+			continue;
+		dst[i] = cpu_to_le64(ste[i]);
+		ste_sync_all = true;
 	}
 
-	if (master->ats_enabled)
-		dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
-						 STRTAB_STE_1_EATS_TRANS));
-
-	arm_smmu_sync_ste_for_sid(smmu, sid);
+	if (ste_sync_all)
+		arm_smmu_sync_ste_for_sid(smmu, sid);
 	/* See comment in arm_smmu_write_ctx_desc() */
-	WRITE_ONCE(dst[0], cpu_to_le64(val));
+	WRITE_ONCE(dst[0], cpu_to_le64(ste[0]));
 	arm_smmu_sync_ste_for_sid(smmu, sid);
 
 	/* It's likely that we'll want to use the new STE soon */
-- 
2.42.0

