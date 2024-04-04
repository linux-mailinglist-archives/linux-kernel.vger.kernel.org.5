Return-Path: <linux-kernel+bounces-131688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F54898ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC7A02841D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE4312B177;
	Thu,  4 Apr 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J132Blgc"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858B763F4;
	Thu,  4 Apr 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243669; cv=fail; b=oWeT2Lcs+I6XulX+BW1YraSvXtY6hs4gcx2Aup8w5lHHCHI4Pvmh9C1/z3ZSHwBcqaXPYUt5TbYtXXQwWgla4VVINML45KhYdIiAXEoRXzR3ebTCrcZsRPFhtVAGsCLG4sWUs0ZIT9GTwz4mCXahn20AvmC8ct5XlCrVJv1d3ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243669; c=relaxed/simple;
	bh=wEWls+8xa9onO0OKVRSmlGNbTe9MCg0UjZlfVzUBV+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT2ruU43Oj1zjcn8ZH0IFEvpTOC5GYzFvM2ViFqORJCK5gLvEEYjSHmWSyVNyX+wdQyfybDUcdj7iAyKrbK+SavouUkX42TSJstrYtecv9QhBzdCk/coH2EzP+iRjdJU3xc7a5Tfrva3WLr3njU6TnWADMVN4/uDg9ge9Hk4Dpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J132Blgc; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrVThiSjAO5P7zLraAP6puZEUKPgr9MFtSTOgEoAN8fOCDwq7PWzykpp1LZ/dze3whKZKQkY6f/EYoa9dIkE/4SCSBjB0i9uA5m8USnM8ql5iqA+xqdbfQQcnVpZZhq7sQV22lHXnYwGunzt8/HMguGi6ETEqD6kgjpZkcy1fOIW6gWlcEkdk0sp6EOBpm4CsJ3UqrxrYO/Diewak4r7UpcFXjKNoewXwV3dKugkkTLTQpuh6gFFecL+evCBc1ayAPs6mIs3CdlEeO6DHsuuErMUcVR9AA9FLxOJhFWzilbqLlD3rUz8WNT23wSM+K1GV+4yPNZ9OB55zGlIQ3J+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDXHciCZX0ZxBi2ZkrfANi+WSFR1ozFBISLzPbK4Y8E=;
 b=l7HFIOuFSqPHqnoDFcXRH4C99NbTaMMug/ZgcLLUnIcIeh1pLwOoXhCYtjFgUb9DJ6z2qDU7utbnLSSNqRAk96UNKdZFVjR2xaS/k8Sc2PdyTcoW1YYOBbRyLo6DEXepCztWqUFE9F3PRXn+n96hpzDQ3U84MaOv9bNAFzLC3Xo4yV5K+kx5ckZ+PRAD1FZwwxaWDiDXa/D2lEFT6KvXstRFad6VMySSholJWJ8xP/sQ/vzNpXmEyTlMq5cAiaRUsFdkHYzp+BDkk4I08MdIFwAhlD4IfP3TNmt8ctpBiXOStE+0oJ3ScXTBqAZpKFsBhh2W+I5/FlNGX0LRGwQusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDXHciCZX0ZxBi2ZkrfANi+WSFR1ozFBISLzPbK4Y8E=;
 b=J132BlgcomM7S0d3BBOl8C0OPMkGDB/NyCdd6SAzmwq9882/NaOz2hJQ6l7ui2IiM2FcFAwKfRmL5GpcNvdIBqU20/FEeSa7XnJ0vYa3CZRnb+GR+2bZBwqRuwEngg+5rOCFC2fI5P+/8F0Jx1MN0snd8LIqQZUOFFn3GGnUKGY=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:22 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::f0) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:22 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 04/16] x86/mce/amd: Look up bank type by IPID
Date: Thu, 4 Apr 2024 10:13:47 -0500
Message-ID: <20240404151359.47970-5-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ade3401-ba07-4fa4-7c27-08dc54b9e861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TUz1TQjqSd77DaoiYZRAAk2NtWaTxxzk7PHHX9NuBZ5tRFaZt435+cua/fh/aRrbgE0cnR/CeQG6FUcD2mXxLXM1NdA7iIFrKt9SSV/FArpoFagkO7XQRAS0Rr4xZi8wneL94I8QfqgCeuG81TsCmAzczY46YqsheTgkA3Z7x2TSoFLEiWHDT1gqKe4fqeHgDrbTZNjWhKtdNzWHlX8K8oiRROaIkA3F9vrcUVdUxufKdwVYsolCX5hC5jdYs0PCqIBF4xq2RMLJx2T6Sqh1ui5JAjULRQpw36JFdkUZNozUZTixTkCUH0h2yMPIFQpYmts8MByqhQYdlzYeznUBrex3fxIh46649SAsrLXkDcj9dqPex0iYSfAm2VvdVZgdsAIjhEySwYwzwYDDaYbYKDoFzt3WW1wQlveV4k1aeRjY7zxtNvqJ18vkP9w3vuSj6rFN2Ywyy4USIJb60c1sFgtsBpXakQrmb8ci2wtksUm0EeA/PAn24OJcTv0QqlmjfaePhJlkNJusz1D+mCFUCgYmBIDU7oFoCxiKq8qcLqF7rSZAvDhrqySAiUVia6Rx0tzuW+PuOnGBgF6J+u2pQMPskSQ3oSUn/JotpFljuWiKZbQJcsEGlM4QerBtFlbJp6ZUJTqTmk+/No6hevEOMM3uUWYVkLn9NkV8KSCZrbeV5xx9tyNjSnzB8SwFfrIUWncc80ydNjGwJw14edPS5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:22.1027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ade3401-ba07-4fa4-7c27-08dc54b9e861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

Scalable MCA systems use values within the MCA_IPID register to describe
a bank's type. Other information is not needed.

Currently, the bank types are cached during boot and this information is
used during boot and run time. The cached values are per-CPU and
per-bank. The boot path needs the cached values, but this should be
removed. The run time path does not need the cached values.

Determine a Scalable MCA bank's type using only the MCA_IPID values.

Keep old code until init path is cleaned up.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-9-yazen.ghannam@amd.com
    
    v1->v2:
    * Include bitops started in dropped patches. (Yazen)
    * Update all users of smca_get_bank_type(). (Yazen)

 arch/x86/include/asm/mce.h              |  4 +-
 arch/x86/kernel/cpu/mce/amd.c           | 99 ++++++++++++++++++++++---
 drivers/edac/amd64_edac.c               |  2 +-
 drivers/edac/mce_amd.c                  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  2 +-
 5 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index de3118305838..adad99bac567 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -59,8 +59,6 @@
  *  - TCC bit is present in MCx_STATUS.
  */
 #define MCI_CONFIG_MCAX		0x1
-#define MCI_IPID_MCATYPE	0xFFFF0000
-#define MCI_IPID_HWID		0xFFF
 
 /*
  * Note that the full MCACOD field of IA32_MCi_STATUS MSR is
@@ -342,7 +340,7 @@ extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
-enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
+enum smca_bank_types smca_get_bank_type(u64 ipid);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index bc78e751dfcc..c76bc158b6b6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -7,6 +7,7 @@
  *
  *  All MC4_MISCi registers are shared between cores on a node.
  */
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/notifier.h>
 #include <linux/kobject.h>
@@ -51,6 +52,10 @@
 #define DEF_INT_TYPE_APIC	0x2
 
 /* Scalable MCA: */
+#define MCI_IPID_MCATYPE	GENMASK_ULL(47, 44)
+#define MCI_IPID_HWID		GENMASK_ULL(43, 32)
+#define MCI_IPID_MCATYPE_OLD	0xFFFF0000
+#define MCI_IPID_HWID_OLD	0xFFF
 
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
@@ -131,7 +136,7 @@ static const char *smca_get_name(enum smca_bank_types t)
 	return smca_names[t];
 }
 
-enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
+static enum smca_bank_types smca_get_bank_type_old(unsigned int cpu, unsigned int bank)
 {
 	struct smca_bank *b;
 
@@ -144,9 +149,8 @@ enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 
 	return b->hwid->bank_type;
 }
-EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
-static const struct smca_hwid smca_hwid_mcatypes[] = {
+static const struct smca_hwid smca_hwid_mcatypes_old[] = {
 	/* { bank_type, hwid_mcatype } */
 
 	/* Reserved type */
@@ -210,6 +214,83 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
+/* Keep sorted first by HWID then by McaType. */
+static const u32 smca_hwid_mcatypes[] = {
+	/* Reserved type */
+	[SMCA_RESERVED]		= HWID_MCATYPE(0x00, 0x0),
+
+	/* System Management Unit MCA type */
+	[SMCA_SMU]		= HWID_MCATYPE(0x01, 0x0),
+	[SMCA_SMU_V2]		= HWID_MCATYPE(0x01, 0x1),
+
+	/* Microprocessor 5 Unit MCA type */
+	[SMCA_MP5]		= HWID_MCATYPE(0x01, 0x2),
+
+	/* MPDMA MCA type */
+	[SMCA_MPDMA]		= HWID_MCATYPE(0x01, 0x3),
+
+	/* Parameter Block MCA type */
+	[SMCA_PB]		= HWID_MCATYPE(0x05, 0x0),
+
+	/* Northbridge IO Unit MCA type */
+	[SMCA_NBIO]		= HWID_MCATYPE(0x18, 0x0),
+
+	/* Data Fabric MCA types */
+	[SMCA_CS]		= HWID_MCATYPE(0x2E, 0x0),
+	[SMCA_PIE]		= HWID_MCATYPE(0x2E, 0x1),
+	[SMCA_CS_V2]		= HWID_MCATYPE(0x2E, 0x2),
+
+	/* PCI Express Unit MCA type */
+	[SMCA_PCIE]		= HWID_MCATYPE(0x46, 0x0),
+	[SMCA_PCIE_V2]		= HWID_MCATYPE(0x46, 0x1),
+
+	[SMCA_XGMI_PCS]		= HWID_MCATYPE(0x50, 0x0),
+	[SMCA_NBIF]		= HWID_MCATYPE(0x6C, 0x0),
+	[SMCA_SHUB]		= HWID_MCATYPE(0x80, 0x0),
+
+	/* Unified Memory Controller MCA type */
+	[SMCA_UMC]		= HWID_MCATYPE(0x96, 0x0),
+	[SMCA_UMC_V2]		= HWID_MCATYPE(0x96, 0x1),
+
+	[SMCA_SATA]		= HWID_MCATYPE(0xA8, 0x0),
+	[SMCA_USB]		= HWID_MCATYPE(0xAA, 0x0),
+
+	/* ZN Core (HWID=0xB0) MCA types */
+	[SMCA_LS]		= HWID_MCATYPE(0xB0, 0x0),
+	[SMCA_IF]		= HWID_MCATYPE(0xB0, 0x1),
+	[SMCA_L2_CACHE]		= HWID_MCATYPE(0xB0, 0x2),
+	[SMCA_DE]		= HWID_MCATYPE(0xB0, 0x3),
+	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
+	[SMCA_EX]		= HWID_MCATYPE(0xB0, 0x5),
+	[SMCA_FP]		= HWID_MCATYPE(0xB0, 0x6),
+	[SMCA_L3_CACHE]		= HWID_MCATYPE(0xB0, 0x7),
+	[SMCA_LS_V2]		= HWID_MCATYPE(0xB0, 0x10),
+
+	/* Platform Security Processor MCA type */
+	[SMCA_PSP]		= HWID_MCATYPE(0xFF, 0x0),
+	[SMCA_PSP_V2]		= HWID_MCATYPE(0xFF, 0x1),
+
+	[SMCA_GMI_PCS]		= HWID_MCATYPE(0x241, 0x0),
+	[SMCA_XGMI_PHY]		= HWID_MCATYPE(0x259, 0x0),
+	[SMCA_WAFL_PHY]		= HWID_MCATYPE(0x267, 0x0),
+	[SMCA_GMI_PHY]		= HWID_MCATYPE(0x269, 0x0),
+};
+
+enum smca_bank_types smca_get_bank_type(u64 ipid)
+{
+	enum smca_bank_types type;
+	u32 hwid_mcatype = HWID_MCATYPE(FIELD_GET(MCI_IPID_HWID, ipid),
+					FIELD_GET(MCI_IPID_MCATYPE, ipid));
+
+	for (type = 0; type < ARRAY_SIZE(smca_hwid_mcatypes); type++) {
+		if (hwid_mcatype == smca_hwid_mcatypes[type])
+			return type;
+	}
+
+	return N_SMCA_BANK_TYPES;
+}
+EXPORT_SYMBOL_GPL(smca_get_bank_type);
+
 /*
  * In SMCA enabled processors, we can have multiple banks for a given IP type.
  * So to define a unique name for each bank, we use a temp c-string to append
@@ -310,11 +391,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		return;
 	}
 
-	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID,
-				    (high & MCI_IPID_MCATYPE) >> 16);
+	hwid_mcatype = HWID_MCATYPE(high & MCI_IPID_HWID_OLD,
+				    (high & MCI_IPID_MCATYPE_OLD) >> 16);
 
-	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
-		s_hwid = &smca_hwid_mcatypes[i];
+	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes_old); i++) {
+		s_hwid = &smca_hwid_mcatypes_old[i];
 
 		if (hwid_mcatype == s_hwid->hwid_mcatype) {
 			this_cpu_ptr(smca_banks)[bank].hwid = s_hwid;
@@ -724,7 +805,7 @@ static bool smca_mce_is_memory_error(struct mce *m)
 	if (XEC(m->status, 0x3f))
 		return false;
 
-	bank_type = smca_get_bank_type(m->extcpu, m->bank);
+	bank_type = smca_get_bank_type(m->ipid);
 
 	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
 }
@@ -1097,7 +1178,7 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 		return th_names[bank];
 	}
 
-	bank_type = smca_get_bank_type(cpu, bank);
+	bank_type = smca_get_bank_type_old(cpu, bank);
 	if (bank_type >= N_SMCA_BANK_TYPES)
 		return NULL;
 
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1f3520d76861..4b3764ea7c59 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1041,7 +1041,7 @@ static int fixup_node_id(int node_id, struct mce *m)
 	/* MCA_IPID[InstanceIdHi] give the AMD Node ID for the bank. */
 	u8 nid = (m->ipid >> 44) & 0xF;
 
-	if (smca_get_bank_type(m->extcpu, m->bank) != SMCA_UMC_V2)
+	if (smca_get_bank_type(m->ipid) != SMCA_UMC_V2)
 		return node_id;
 
 	/* Nodes below the GPU base node are CPU nodes and don't need a fixup. */
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 8130c3dc64da..e02af5da1ec2 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -731,7 +731,7 @@ static const char *smca_get_long_name(enum smca_bank_types t)
 /* Decode errors according to Scalable MCA specification */
 static void decode_smca_error(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
+	enum smca_bank_types bank_type = smca_get_bank_type(m->ipid);
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (bank_type >= N_SMCA_BANK_TYPES)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8ebab6f22e5a..c543600b759b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3546,7 +3546,7 @@ static int amdgpu_bad_page_notifier(struct notifier_block *nb,
 	 * and error occurred in DramECC (Extended error code = 0) then only
 	 * process the error, else bail out.
 	 */
-	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) == SMCA_UMC_V2) &&
+	if (!m || !((smca_get_bank_type(m->ipid) == SMCA_UMC_V2) &&
 		    (XEC(m->status, 0x3f) == 0x0)))
 		return NOTIFY_DONE;
 
-- 
2.34.1


