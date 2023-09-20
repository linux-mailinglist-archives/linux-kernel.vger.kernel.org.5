Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33E37A8E06
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjITUxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjITUxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:53:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5910D6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQAyatx1nn5wKtVaQjVpH4Ze3ayaO8g9odhrsJbpG0iL48dNiLA5XTBRAOiZbVOBIyoGPcFeUpOX/Oz0HbDFPz5jyG//5BsYA3rNOsGiSjIOfxSuJsYedOtxoiqpgNLi5pk+g8/Nj+/j4W19vF6j1v/T/lI0Jae8WAQhi1dM17aikwcuK1nWHER+/uBylDlOLGfsOjV8UNgYr5qTXbgmyolzVoN05yqZWkhMQ99LQhT8p6fRnrzplToeu+obxSSrpABjcX0rSOPZvTfiOm1UIkIjSe0Hgt1ZbAxSFkavXVf5OcuYRxKsJFEAQaAYzX88l4LiAoxVMLz8268FoEgjCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFaAcDjctwqwrFVOslvM2YFenZWEZNsraaC6TwrQOuQ=;
 b=Xg5EQiGuqmkTDgebX3Dz0V3MeIDLEkgQXnCbQ7NtPk6MOdY5Bki0Ew6klpG8OC7CutGUbARBntkDSgYQz8yIRuYv5Eju1UbeaW6w4TR56W7FRN8jgI26gAe9GA/nTgNijyB1Kxw+fGtjBLaJNiSwPHc0N8ahwyYZBhxZLuTZZ88VaAUCE8mEF5VePPHe+g1dDmymfGRQ5fPY+IEgZ3U8YPmKecj0LihsnKAEbhn4V6L0jF77itr+xUaqYQhv2cJxkIauJaSOfEIz6PilmSuBKrwnXYHgDmXhvETSbhirK8HtxIn1X9ADf1YxfzHz7i2VJaav6lOYMUo10UQoqjV5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFaAcDjctwqwrFVOslvM2YFenZWEZNsraaC6TwrQOuQ=;
 b=NbQ5h4xYzTZJkcHWKZ9FLonVX7/0xMD3OA2YXrk1BDVl3L0y97Hepfma+7Vm+hkmoMJrNxd6Dt17xUPkJXxE+s3/YiO7iVrkxP2qlabyEr+Pk6kNF1xlDU7sfWou7V1mVP3vcvm+MPo+anpmeLc3tp1ykuepFGv9UkmZh1k8wXs/xMxlsqCUz0mlO5cInT//7ed2qjAk4dTIZyiDi++DrodsxyR/wMM0IN4+tG7B8J+Zljl1BlnWKGE+YIjvNE8trSeBKQro7mcKsq7P2Hklie/h5CNbu/6xcgSeNCdXPS4+Kj8PyX/O+zMKF0KFMSOcxca7KKRxE3m0cI0JoIuI3Q==
Received: from BLAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:208:32b::25)
 by DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 20:52:54 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::b6) by BLAPR03CA0020.outlook.office365.com
 (2603:10b6:208:32b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Wed, 20 Sep 2023 20:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 20:52:54 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 20 Sep
 2023 13:52:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 20 Sep 2023 13:52:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 20 Sep 2023 13:52:39 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <jean-philippe@linaro.org>,
        <mshavit@google.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
Subject: [PATCH v4 2/2] iommu/arm-smmu-v3: Refactor arm_smmu_write_strtab_ent()
Date:   Wed, 20 Sep 2023 13:52:04 -0700
Message-ID: <6e1fdea8ab43ea28e7e3c79eb6605dea71548c53.1695242337.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695242337.git.nicolinc@nvidia.com>
References: <cover.1695242337.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bc509b-8aec-47d8-49b0-08dbba1b900b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZImtlT5SwrbmDxMp95PhmKvQo3hi+jBI5kKFEe7FQsZPKOjWe34piYNAM3mowcg7pe40IjZTxE3DOwsbPVXByOW4m6bIoFGGgx3Q7Cj1MtMMC8fwcmZpgakgTvQw8rdNcMr8WS/KbLCbLccUelFOCtzxzEW3FMs1scaexaKgwXVc+WSUSdajnvI1NB+gYuocxy2Pd/IdptpCYOV5dh0La5KGwzcj0Gu1Myr2uK+xQKWEyw55lVAPhEtOC7d/sCuDvz39uyiEiZU6+XSv3XXriFYKceDiM9fbxxRkq76QaT7K1CJCy7S338ExFYrV9kYRkL0PBURySXQhomFnYHK0WQSjZN1u0uNyYvVh/C0b9lBo7xPXIw6fjEK/SDEUtmeobEHz/fJKlE39IhY9dYZiiimoM/Fe7tyIin2uqeScFs38EBXVn6jqgaxJlTzNEfe9rgkv/ll1M9xh9wEJ7xxckvbt8Cgc1yR8KgEmfyG1ld4PLgGrFkaQ4yJV81RzJoX+6asZ/Nn43Kx9o5RMpkpr/aajieTnksKk9edFJRphMlknOCuMitHnY71WO30Vz9o/u2ItP/osOpE5TS3xGCoim2WrAI7UV+HwAPYL5asl0n18Zid401r2XzjxawoHKkre6CkMUEIGdgnjAvypDn03SE0+gmd8fvRrws1pBO0KatdylVEzW91eVM+/fUfgfGZbzcfAj2HYMuAK551gfKBVbOHE0LjLF1zFdh1wJ3pyItmzXBV5Vv9UzE2Xdwt0oO8OdzeERWOiojAeHZD/FXaoEg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(5660300002)(7696005)(86362001)(478600001)(54906003)(70586007)(41300700001)(316002)(70206006)(110136005)(6666004)(6636002)(2616005)(8936002)(356005)(26005)(82740400003)(36860700001)(336012)(36756003)(426003)(47076005)(8676002)(83380400001)(40460700003)(4326008)(2906002)(7636003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 20:52:54.4724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bc509b-8aec-47d8-49b0-08dbba1b900b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5748
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
to simply support that with very limited changes in the furture.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 197 +++++++++++---------
 1 file changed, 110 insertions(+), 87 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dbe11997b4b9..ea0724975d63 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1248,6 +1248,91 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
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
@@ -1267,12 +1352,11 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
@@ -1280,27 +1364,8 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
@@ -1315,74 +1380,32 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
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
-		return;
-	}
-
-	if (cd_table) {
-		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
-			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
+	ste[0] = STRTAB_STE_0_V;
 
+	if (master->cd_table.cdtab && master->domain) {
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
-	}
-
-	if (s2_cfg) {
+		arm_smmu_ste_stage1_translate(master, ste);
+	} else if (master->domain &&
+		   master->domain->stage == ARM_SMMU_DOMAIN_S2) {
 		BUG_ON(ste_live);
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
+		arm_smmu_ste_stage2_translate(master, ste);
+	} else if (!master->domain && disable_bypass) { /* Master is detached */
+		arm_smmu_ste_abort(ste);
+	} else {
+		arm_smmu_ste_bypass(ste);
 	}
 
-	if (master->ats_enabled)
-		dst[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_EATS,
-						 STRTAB_STE_1_EATS_TRANS));
+	for (i = 1; i < 4; i++) {
+		if (dst[i] == cpu_to_le64(ste[i]))
+			continue;
+		dst[i] = cpu_to_le64(ste[i]);
+		ste_sync_all = true;
+	}
 
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

