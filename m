Return-Path: <linux-kernel+bounces-57770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87E584DD37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8FF2845E3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA96BFBF;
	Thu,  8 Feb 2024 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bhew2gfx"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD91E86C;
	Thu,  8 Feb 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707385623; cv=fail; b=iaz8eAS6/dw8wz2sVkSkKLnf8A4BqijK8IWiuYdhOmeyz6sQIBpb0+hiVYyUa37U5wU0Wd/xT+ifJ/YIXcuhYyX3at7AmlcqhGSJc6Mw5PCml5beKtGB/vcrPPS8nchy6RvifhpcYKR76wh07QkZHV8I1QDZd32Qs7WqvYfjBuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707385623; c=relaxed/simple;
	bh=GpCFVkfG7qS/aJYc0cYeMZY3u2NPOVM6NtCjFuT9gWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hHAOrZ5CE+rPAgUS9y0omLm3+ucb9Ul3rMMxBPQV1krfh2+nvzOSQ3Mahi5vS+OgjhWBpxyijqDcG/B9iYbwjWyMRbvGy7Wtc4zzM9REUceBpTmvOv10pFhuOWVr0bU3fdrpDhGhtEOew1zHrQPk1ARs7HA4fO+xn4SOpFxISO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bhew2gfx; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2hFleOphdtCYzx9ey7Syw+k3Q5Gu4kmycEw1Z6QKXuLH31Flw/nNbVZgcpTgtf//tt1LFJOTPEOjuHCKUj1SASiA5oB+ZzgsCsUOcVqX/bLg51FvqsiBwHIQLEp8YiOBfwtT1nHpBumQbuUxln2JDF6Mx1ef5dvsa0e7iaeO4CTsFP8jnY7rwQyLCK25QuvmDP2lZK8+FKtd5U6qZPhlYPn1TnJLNrqfL3BnQ1AgyJl0ijLh+2Y9YmZiXBW/R94nhgbgudWWh7JNM/s53+rlv05PZXMf5LsebnKfc+aa8fHPtccX0gO3cugJFN+O+RJNs8v7E7RZUIEfk1IPkbGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPAywHZq7s9HoD22qZF09SYDG6zqpHd2cSFmf3cEVcY=;
 b=bHo8iTbU8PjOJETy6M10n2W1egiMRkM37aEUQ6QkK89AGtqYSdPGlHySuHmKzMNXa2SjpQe9osZdXLt2Hu2nbdlANPbIjrwRTOS0cXjApLwcH2Q9/aFYYUKhOs+8+apS35Iu/tC/veCpRNHzWPZ3TTgJn+4xxz4WPLDBo/hgZ0vZFXHpzFViVaty4hxupvoqRO3JjJBDaXJLDMWQT+bXXmB8WG0Stn9AvgV3t15zHImVbfpsee4S8I8Io69Fl612yrPkgdKJt9tuQxJMsju7xmBRkxgrkO6a1o/V0m9XrhotSY/npAKQDqql5Yep2pA2hLRSwSSHq2Xaw9S4T/i8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPAywHZq7s9HoD22qZF09SYDG6zqpHd2cSFmf3cEVcY=;
 b=bhew2gfxNoaZEIlZOBJfgCiRuEwVYIw8girhsNcUZ355nuCUw1AdM8OtNFD/oOpXYGbGMuH/erEr0xuYdNy4TrqkpVsEpNMhHAdZmhZWa0Ry4fPbIkeYbhpQC0GA5VDKBqDN4i9/z5rqahZELcNL7OaCa/pmZc5DRF7lNoltA3s=
Received: from CY5P221CA0076.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::26) by
 IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 09:46:57 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:9:cafe::d4) by CY5P221CA0076.outlook.office365.com
 (2603:10b6:930:9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.41 via Frontend
 Transport; Thu, 8 Feb 2024 09:46:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 09:46:57 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 03:46:56 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 8 Feb
 2024 01:46:56 -0800
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 8 Feb 2024 03:46:53 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <sai.krishna.potthuri@amd.com>,
	<linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH v3] EDAC/versal: Make the bits in error injection configurable
Date: Thu, 8 Feb 2024 15:16:53 +0530
Message-ID: <20240208094653.11704-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd3dea5-b887-4089-e0d7-08dc288ae3d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YTpcXTiwjxHtJOXr/qPByCfsrZuAaxwb4/DYtov2ylWlcxFwIPvqzEDNDkS5e4J5ZHNTskG3YQKUX32nx4If8UV2xk+7fT7d7eAfn6sdL5XVeJcZfnvnEb/wRGFA+9Tu/3L4MStfdsj/4C4j9xxwwOUdOo7vEMbzlVzjCZIO/bGxw1M0yPItXHU6mk1c0kNr9Q8kzBVtollhdZElNscjxOj6TB+axuoGxtsG9uIGy8stv3bnScZV7eooBaHuHZb/NEetechnur/mL2hOj7DhQMdfPlaPdwZmhycphb/b+xe4gBE2E3T89uecUCaQnf1HllcpqzIE8xUbpuk1Giwbv8Bu9ae7tSKo2iL/fyn9f21QstO8D4Mph3JmDV8+GcjMaRzmVULTuf6U857jaScNQPI1Wx4+sIaXZyUV5388AkAGGcAWspG1L/q3YWpm24Pvdnxd3p3vT6mjjQ92Ae+/ZrRJf34v/4GxTm4hCQSizCYyp/0zwC8AQnjUb7ds/zRFjAAjNgG8yvTbF7DirIgoYFGgLCTnbBUSm9MhDRurkddod3YIAAsGOTBTfT88cbzLOJdBeZ1Qm2Z0Fptyqm6rgA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(82310400011)(64100799003)(1800799012)(186009)(40470700004)(46966006)(36840700001)(41300700001)(478600001)(26005)(426003)(966005)(36756003)(86362001)(1076003)(356005)(83380400001)(82740400003)(336012)(2616005)(4326008)(54906003)(2906002)(8676002)(70206006)(316002)(5660300002)(81166007)(8936002)(70586007)(30864003)(44832011)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 09:46:57.1978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd3dea5-b887-4089-e0d7-08dc288ae3d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041

Currently the error injection for correctable and uncorrectable errors
bits are hardcoded. To make it configurable add separate sysfs
entries to set the bit positions for injecting CE and UE errors.
It injects single bit error for CE and two bits errors for UE.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v3:
- Fix the error handling
- Remove an unused variable also make xddr_inject_data_ce_store
void as it was always returning 0.
- Write ecc_flip registers are written to only once in
xddr_inject_data_ce_store.
- Use #define  PCSR_LOCK_VAL for lock value.
- Add description of error injection algorithm
- Remove the defines for the hardcoded bit position ECC_UEPOISON_MASK
and ECC_CEPOISON_MASK.

Changes in v2:
- Update the description to use first person
- Reorder the fops.
- Add null check for edac_debugfs_create_file

 drivers/edac/versal_edac.c | 189 ++++++++++++++++++++++++++++++-------
 1 file changed, 157 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 62caf454b567..e044ca3904f4 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -42,8 +42,11 @@
 
 #define ECCW0_FLIP_CTRL				0x109C
 #define ECCW0_FLIP0_OFFSET			0x10A0
+#define ECCW0_FLIP0_BITS			31
+#define ECCW0_FLIP1_OFFSET			0x10A4
 #define ECCW1_FLIP_CTRL				0x10AC
 #define ECCW1_FLIP0_OFFSET			0x10B0
+#define ECCW1_FLIP1_OFFSET			0x10B4
 #define ECCR0_CERR_STAT_OFFSET			0x10BC
 #define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
 #define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
@@ -116,9 +119,6 @@
 #define XDDR_BUS_WIDTH_32			1
 #define XDDR_BUS_WIDTH_16			2
 
-#define ECC_CEPOISON_MASK			0x1
-#define ECC_UEPOISON_MASK			0x3
-
 #define XDDR_MAX_ROW_CNT			18
 #define XDDR_MAX_COL_CNT			10
 #define XDDR_MAX_RANK_CNT			2
@@ -133,6 +133,7 @@
  * https://docs.xilinx.com/r/en-US/am012-versal-register-reference/PCSR_LOCK-XRAM_SLCR-Register
  */
 #define PCSR_UNLOCK_VAL				0xF9E8D7C6
+#define PCSR_LOCK_VAL				1
 #define XDDR_ERR_TYPE_CE			0
 #define XDDR_ERR_TYPE_UE			1
 
@@ -142,6 +143,7 @@
 #define XILINX_DRAM_SIZE_12G			3
 #define XILINX_DRAM_SIZE_16G			4
 #define XILINX_DRAM_SIZE_32G			5
+#define NUM_UE_BITPOS				2
 
 /**
  * struct ecc_error_info - ECC error log information.
@@ -479,7 +481,7 @@ static void err_callback(const u32 *payload, void *data)
 	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
 
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
 }
@@ -650,7 +652,7 @@ static void enable_intr(struct edac_priv *priv)
 	writel(XDDR_IRQ_UE_MASK,
 	       priv->ddrmc_baseaddr + XDDR_IRQ1_EN_OFFSET);
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
 static void disable_intr(struct edac_priv *priv)
@@ -663,7 +665,7 @@ static void disable_intr(struct edac_priv *priv)
 	       priv->ddrmc_baseaddr + XDDR_IRQ_DIS_OFFSET);
 
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
 #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
@@ -734,38 +736,58 @@ static void poison_setup(struct edac_priv *priv)
 	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
 }
 
-static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
-					     const char __user *data)
+static void xddr_inject_data_ce_store(struct mem_ctl_info *mci, u8 ce_bitpos)
 {
 	struct edac_priv *priv = mci->pvt_info;
+	u32 ecc0_flip0, ecc1_flip0, ecc0_flip1, ecc1_flip1;
 
-	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
-	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
-
-	if (strncmp(data, "CE", 2) == 0) {
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+	if (ce_bitpos < ECCW0_FLIP0_BITS) {
+		ecc0_flip0 = BIT(ce_bitpos);
+		ecc1_flip0 = BIT(ce_bitpos);
+		ecc0_flip1 = 0;
+		ecc1_flip1 = 0;
 	} else {
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+		ce_bitpos = ce_bitpos - ECCW0_FLIP0_BITS;
+		ecc0_flip1 = BIT(ce_bitpos);
+		ecc1_flip1 = BIT(ce_bitpos);
+		ecc0_flip0 = 0;
+		ecc1_flip0 = 0;
 	}
 
-	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
-
-	return 0;
+	writel(ecc0_flip0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(ecc1_flip0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
+	writel(ecc0_flip1, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(ecc1_flip1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
 }
 
-static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
-					size_t count, loff_t *ppos)
+/*
+ *To get correctable errors injected, following steps are needed
+ *
+ * - Write the correctable error bit position value:
+ *	echo <bit_pos val> > /sys/kernel/debug/edac/<controller instance>/inject_ce
+ *
+ * poison_setup() derives the row , column , bank, group  and rank and writes to the
+ * ADEC registers based on the address given by the user.
+ *
+ * The ADEC12 and ADEC13 are mask registers write 0 to make sure default configuration
+ * is there and no addresses are masked.
+ * The row, column, bank, group and rank registers are written to the match ADEC bit to
+ * generate errors at the particular address. ADEC14 and ADEC15 have the match bits.
+ *
+ * xddr_inject_data_ce_store() updates the ECC FLIP registers with the bits to be
+ * corrupted based on the bit position given by the user.
+ *
+ * Upon doing a read to the address the errors are injected.
+ *
+ */
+static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
 {
 	struct device *dev = file->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	u8 ce_bitpos;
+	int ret;
 
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
@@ -773,17 +795,111 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
 
 	poison_setup(priv);
 
+	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
+	if (!ret) {
+		xddr_inject_data_ce_store(mci, ce_bitpos);
+		ret = count;
+	}
+
 	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	return ret;
+}
+
+static const struct file_operations xddr_inject_ce_fops = {
+	.open = simple_open,
+	.write = inject_data_ce_store,
+	.llseek = generic_file_llseek,
+};
+
+static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 val1)
+{
+	struct edac_priv *priv = mci->pvt_info;
+
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+}
+
+/*
+ * To get the uncorrectable error injected, the following steps are needed:
+ *	echo <bit_pos val> > /sys/kernel/debug/edac/<controller instance>/inject_ue
+ *
+ * poison_setup derives the row , column , bank, group  and rank and writes to the
+ * ADEC registers based on the address given by the user. The ADEC12 and ADEC13 are
+ * mask registers write 0 so that none of the addresses are masked. The row, column,
+ * bank, group and rank registers are written to the match ADEC bit to generate errors
+ * at the particular address. ADEC14 and ADEC15 have the match bits.
+ *
+ * xddr_inject_data_ue_store updates the ECC FLIP registers with the bits to be
+ * corrupted based on the bit position given by the user. For uncorrectable errors
+ * 2 bit errors are injected.
+ *
+ * Upon doing a read to the address the errors are injected.
+ *
+ */
+static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+	char buf[6], *pbuf, *token[2];
+	u32 val0 = 0, val1 = 0;
+	u8 len, ue0, ue1;
+	int i, ret;
+
+	len = min_t(size_t, count, sizeof(buf));
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	pbuf = &buf[0];
+	for (i = 0; i < NUM_UE_BITPOS; i++)
+		token[i] = strsep(&pbuf, ",");
+
+	ret = kstrtou8(token[0], 0, &ue0);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(token[1], 0, &ue1);
+	if (ret)
+		return ret;
+
+	if (ue0 < ECCW0_FLIP0_BITS) {
+		val0 = BIT(ue0);
+	} else {
+		ue0 = ue0 - ECCW0_FLIP0_BITS;
+		val1 = BIT(ue0);
+	}
 
-	xddr_inject_data_poison_store(mci, data);
+	if (ue1 < ECCW0_FLIP0_BITS) {
+		val0 |= BIT(ue1);
+	} else {
+		ue1 = ue1 - ECCW0_FLIP0_BITS;
+		val1 |= BIT(ue1);
+	}
 
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	poison_setup(priv);
+
+	xddr_inject_data_ue_store(mci, val0, val1);
+
+	/* Lock the PCSR registers */
+	writel(PCSR_LOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 	return count;
 }
 
-static const struct file_operations xddr_inject_enable_fops = {
+static const struct file_operations xddr_inject_ue_fops = {
 	.open = simple_open,
-	.write = inject_data_poison_store,
+	.write = inject_data_ue_store,
 	.llseek = generic_file_llseek,
 };
 
@@ -795,8 +911,17 @@ static void create_debugfs_attributes(struct mem_ctl_info *mci)
 	if (!priv->debugfs)
 		return;
 
-	edac_debugfs_create_file("inject_error", 0200, priv->debugfs,
-				 &mci->dev, &xddr_inject_enable_fops);
+	if (!edac_debugfs_create_file("inject_ce", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ce_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
+
+	if (!edac_debugfs_create_file("inject_ue", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ue_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
 	debugfs_create_x64("address", 0600, priv->debugfs,
 			   &priv->err_inject_addr);
 	mci->debugfs = priv->debugfs;
-- 
2.17.1


