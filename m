Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150578DF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbjH3TRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbjH3K4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:56:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883121BF;
        Wed, 30 Aug 2023 03:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyIaXJp9HQm1ecSAzEUaP0rPuv/yZ1pxuj0wABRiOn02MV1R2e2rZwU992r+f8sfTHlezfgPjAIu4w+NZVX9LXNloKY+cZh9OhBEBHbEkgI6GIwVLQ2d87Q07ddPLV/eavs5m3EcvoLjBnj9b01eqFaVTeWZ+upXnGGfaudpIM201SGWY6O7HWm8WK60ceszR+Qpa9vQn1oTg4WjwlBbFYpdn4hnrTcOqK3XM3UNvjZPFltkyD5lvy205XdCSD32AZiYyetomGcWmXlcfF0XnNNMWTLgRI5IB88B8k5xcNZoxejEA4c1INEqmppW/Tcw6V/OPom1yYfYoFiI8kGp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUIbdy92v8vG2Z4k7TDlgrmoXmoF0XkkY8b+Zq1XgO0=;
 b=TFYL8kcZfU5RmY/yeBi1ZUawlR+XMf//fMaWY/4rPrJ7+4AG4LC/cLjA6byEl0fnGWTu4uo9V5G0FgtPxkbGttHzTMeuzQcbJ7rPkyoCgvQWyz5g85L5Bud1NIazAmtW6KF7vXYouQ+LkEXD1RsMROvXJ8u9X77KZ0nJl4uN3BZF5dwfMiBqbDVHMyr9eoozpx4WYCtssqQooans+5dJhTXXTpxTR2Va3vd2ilv79FW0YeirwPXUSHgm1yD0N1PMpg3jKD01uk17puYisWEOJGUBv4meejfnLEjwLY9CtHvgqAPkWIEftfGJm8rwpqlyIz0KtikS3lzbSNTn/6D17g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUIbdy92v8vG2Z4k7TDlgrmoXmoF0XkkY8b+Zq1XgO0=;
 b=cpv2eplOe41yLuSl/MNWeMKqRosNYOEi0TW8qZRkL4RV/PAKvpl2yHeVQoDREhhlT81fcCf0cMjK26KwWakaOKqxuYwAcXPixwLKS3J+ZW4t5ojqoXGcZmfZntQSTnFcczhIUtYpE3jCZ4q2U+W7Rd1cz3OKGAvvcRT8SbrjTWg7UjOkRIwwhqsLyc+SYVO6HP420B3h+uuboR/vNRHaUB8jAyFBljrAv0BHY3Sk6K9XBYd2632OmX8n9ugDT8PPLw2BcxTUmeo+1Z1PujjR45QALIDQzgi+0+OwRr3D4iZPCcKziG/ztjRJEYmQ5UQwhGZAq+D/4bFa9s4cVgfelw==
Received: from BY3PR10CA0024.namprd10.prod.outlook.com (2603:10b6:a03:255::29)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Wed, 30 Aug
 2023 10:56:42 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::83) by BY3PR10CA0024.outlook.office365.com
 (2603:10b6:a03:255::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Wed, 30 Aug 2023 10:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16 via Frontend Transport; Wed, 30 Aug 2023 10:56:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 30 Aug 2023
 03:56:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 30 Aug
 2023 03:56:25 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 30 Aug
 2023 03:56:24 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Borislav Petkov <bp@alien8.de>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] EDAC/bluefield_edac: Use ARM SMC for EMI access
Date:   Wed, 30 Aug 2023 06:56:14 -0400
Message-ID: <7a67e5fd25664f4c2277283e15b438e826b3c163.1693392576.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 3124586a-1291-4534-2f18-08dba947cb6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5kRI92z7SH/gVTpgxbrnWveb2d3UaFHPRCBZB1Rydla0Tnt8k3ZganoD158J9ulap2Aqx1Hd0CxkCYkDfYZRKfldzF6mNR4jFaeCtwaxbCmXoGO69QdaFVKM63vVdMKxP90Gz+utz0AGuYERTNizr4xpnuxh4Pcg2O8wSHIfKfOeGEbeel6W6o92YMjkWUJ93UUevL7sff4YHq3ZtqpGW9IeTwYmc6gnFcO2XbupwzEXWn10mlnc9czGB3Vy/zsQm75ptS50gehH6sYvgBCb62jesYYmNVyXPXm2SAxClxOqhUNYhbFjouxZDM93kt6qOTt5ouVXvJhC5mectNsSCSdwKdqhASohDY0FDBf6EAKOSGa+hUvvDq1rTQ1oQybyxTPXN+Hlsyxf5IEQ6towTFVUIF+oJUN3gE3o/sgQHga6dgKlASOwl7b1u2n7OFjCP5rScUT8NoAO+H5T6Opk1Ptc8+Q6NUV5P0TLAyJEvfS0KxL1g1jkkBerHQ2IxqX6Z+hyK3rWtSELoXA3WRPoESTwJlhK57V1T3eEaxmC7A1ffpIlGXkPLw8b6OjNIPBrkH7V08btQ3zVPmk13DHvW+D53SXb4wRkV0eLaNjUGH9kWNrDDtJlTFZqUPfRMpr1Bq6aYO5kk8MgFKafGKjpaoOTAikuQSLdT4KKVK2m5/AbVCDIYrsMeYQ8gcJCK/m4bec/4XeQytngkzMv34fnFkZtOruF5YxWuarwSmvmAcsSztDZ7sMfEv8x+tIXDjO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(376002)(39860400002)(1800799009)(186009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(356005)(82740400003)(7636003)(8936002)(6666004)(110136005)(70206006)(478600001)(70586007)(7696005)(54906003)(316002)(41300700001)(40460700003)(8676002)(5660300002)(36756003)(83380400001)(2906002)(2616005)(47076005)(86362001)(36860700001)(40480700001)(26005)(336012)(426003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 10:56:42.2222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3124586a-1291-4534-2f18-08dba947cb6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add secure read/write calls (arm_smccc_smc) to bluefield_edac.
The ACPI table entry decides whether SMC is need for accessing
the registers in the External Memory Interface block. If not,
the registers may be mapped and accessed directly.

v0 -> v1
Updated commit message

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 176 ++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..cb9e42ef64d1 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -47,13 +47,25 @@
 #define MLXBF_EDAC_MAX_DIMM_PER_MC	2
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
+#define MLXBF_WRITE_REG_32		(0x82000009)
+#define MLXBF_READ_REG_32		(0x8200000A)
+#define MLXBF_WRITE_REG_64		(0x8200000B)
+#define MLXBF_READ_REG_64		(0x8200000C)
+#define MLXBF_SIP_SVC_UID		(0x8200ff01)
+#define MLXBF_SIP_SVC_VERSION		(0x8200ff03)
+
+#define MLXBF_SMCCC_ACCESS_VIOLATION	(-4)
+
+#define MLXBF_SVC_REQ_MAJOR		0
+#define MLXBF_SVC_REQ_MINOR		3
+
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +73,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -72,9 +84,12 @@
 #define MLXBF_DIMM_INFO__PACKAGE_X GENMASK_ULL(31, 24)
 
 struct bluefield_edac_priv {
+	struct device *dev;
 	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
 	void __iomem *emi_base;
 	int dimm_per_mc;
+	bool svc_sreg_support;
+	u32 sreg_tbl_edac;
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -86,6 +101,71 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
 	return res.a0;
 }
 
+static int secure_readl(void __iomem *addr, uint32_t *result, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		*result = (uint32_t)res.a1;
+		return 0;
+	}
+}
+
+static int secure_writel(void __iomem *addr, uint32_t data, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
+		      0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		return 0;
+	}
+}
+
+static int edac_readl(void __iomem *addr, uint32_t *result,
+		      bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_readl(addr, result, sreg_tbl);
+	else
+		*result = readl(addr);
+
+	return err;
+}
+
+static int edac_writel(void __iomem *addr, uint32_t data,
+		       bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_writel(addr, data, sreg_tbl);
+	else
+		writel(data, addr);
+
+	return err;
+}
+
 /*
  * Gather the ECC information from the External Memory Interface registers
  * and report it to the edac handler.
@@ -99,7 +179,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
-	int ecc_dimm;
+	int ecc_dimm, err;
 
 	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
 				   HW_EVENT_ERR_UNCORRECTED;
@@ -109,14 +189,22 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * registers with information about the last ECC error occurrence.
 	 */
 	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
-	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
+	err = edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
+			  ecc_latch_select, priv->svc_sreg_support,
+			  priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC latch select write failed.\n");
 
 	/*
 	 * Verify that the ECC reported info in the registers is of the
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
+	err = edac_readl(priv->emi_base + MLXBF_SYNDROM, &dram_syndrom,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
 	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
@@ -127,13 +215,24 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 		return;
 	}
 
-	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
+	err = edac_readl(priv->emi_base + MLXBF_ADD_INFO, &dram_additional_info,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM additional info read failed.\n");
+
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
-	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
-	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_0, &edea0,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 0 read failed.\n");
+
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_1, &edea1,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 1 read failed.\n");
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -147,6 +246,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+	int err;
 
 	/*
 	 * The memory controller might not be initialized by the firmware
@@ -155,7 +255,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	if (mci->edac_cap == EDAC_FLAG_NONE)
 		return;
 
-	ecc_count = readl(priv->emi_base + MLXBF_ECC_CNT);
+	err = edac_readl(priv->emi_base + MLXBF_ECC_CNT, &ecc_count,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC count read failed.\n");
+
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
 
@@ -172,15 +276,19 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	}
 
 	/* Write to clear reported errors. */
-	if (ecc_count)
-		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
+	if (ecc_count) {
+		err = edac_writel(priv->emi_base + MLXBF_ECC_ERR, ecc_error,
+				  priv->svc_sreg_support, priv->sreg_tbl_edac);
+		if (err)
+			dev_err(priv->dev, "ECC Error write failed.\n");
+	}
 }
 
 /* Initialize the DIMMs information for the given memory controller. */
 static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
-	int mem_ctrl_idx = mci->mc_idx;
+	u64 mem_ctrl_idx = mci->mc_idx;
 	struct dimm_info *dimm;
 	u64 smc_info, smc_arg;
 	int is_empty = 1, i;
@@ -189,7 +297,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
@@ -244,6 +352,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct bluefield_edac_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
+	struct arm_smccc_res res;
 	struct mem_ctl_info *mci;
 	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
@@ -280,12 +389,40 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 
+	/*
+	 * ACPI indicates whether we use SMCs to access registers or not.
+	 * If sreg_tbl_perf is not present, just assume we're not using SMCs.
+	 */
+	if (device_property_read_u32(dev,
+				     "sec_reg_block", &priv->sreg_tbl_edac)) {
+		priv->svc_sreg_support = false;
+	} else {
+		/*
+		 * Check service version to see if we actually do support the
+		 * needed SMCs. If we have the calls we need, mark support for
+		 * them in the pmc struct.
+		 */
+		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0 == MLXBF_SVC_REQ_MAJOR &&
+		    res.a1 >= MLXBF_SVC_REQ_MINOR) {
+			priv->svc_sreg_support = true;
+		} else {
+			dev_err(dev, "Required SMCs are not supported.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	priv->dimm_per_mc = dimm_count;
-	priv->emi_base = devm_ioremap_resource(dev, emi_res);
-	if (IS_ERR(priv->emi_base)) {
-		dev_err(dev, "failed to map EMI IO resource\n");
-		ret = PTR_ERR(priv->emi_base);
-		goto err;
+	if (!priv->svc_sreg_support) {
+		priv->emi_base = devm_ioremap_resource(dev, emi_res);
+		if (IS_ERR(priv->emi_base)) {
+			dev_err(dev, "failed to map EMI IO resource\n");
+			ret = PTR_ERR(priv->emi_base);
+			goto err;
+		}
+	} else {
+		priv->emi_base = (void __iomem *)emi_res->start;
 	}
 
 	mci->pdev = dev;
@@ -320,7 +457,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static int bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1

