Return-Path: <linux-kernel+bounces-164258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE628B7B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0024F1F21AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688B17A939;
	Tue, 30 Apr 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FikIoDMP"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB86179658
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490714; cv=fail; b=sbVPl2uqlHQhj5Ryhylw41ZwRZ0jNTxbtPdSeloPE4hCBq9bu0fkDsIJhfDW+UT1sRZWFGbi1wGCGBpDPZpIy/jfo2yy7PWiLWzTImVGxB/lxTOU76rzukNdJO75ngOpTxrZRmblKvE0eIcmt2gGtcD5bCfysxPOTd8+3YIl87U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490714; c=relaxed/simple;
	bh=0bubdy+MVU2CNC8VagX9qz1NBjG61bwTDFHtFFafWgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBUJJ5XOjLCGUD1a1miipjyu4E42f26AYkFFsfxtkYIf2zX5dKPe/KmPwp+zvyIEn5sVxUe3/hH2Rnu/BI6GfQPUAIoZWIcyYuMSUWOgV4yJcQabmSNATdgNkJbAzBP1GPMxMgNUynP7jy7N7jEDdDFeS4DSyLOT4pAScS80dso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FikIoDMP; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bowMARiP5EdToy0hOzUd5vmo6QMaDVmDSaqF8EzdBsjYNreEM+7rWSzWlzL9RBvNuXxy/Hd8kjwKWj9tzw3QFnsEZvSWKvXywsUX20cHpMnYWHR7coCiKHiXFA2VKQxWKlmLxZDUGpcGLI7g94S03WVsUXRngvNUrG6CiKptx6kH9lNK7G1yis/EKuFX62+WqIvBrWArrpMmAZZXq1PrtkAzKWyF7A9CZKJetzx1p8RMCjgoSGmpVThh394yKYYqHn5KFh4weHFyHezV9JWfFFAYOvLQfaZN2nOk5f/K04vNx/slkgzQTaMOSvCUfdxU4M9s3HGF43jHT14bvOlFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm4UelSvyXTzPHBOHHntRN19L15qryX6MH7sY+V/Oh8=;
 b=VKa1XaLv+Ob1+P29mKFzHUJ2LFYACm7TcH5CVRpcOntULWlP5oDde80AmUfvroz6uZyMFQ9JrJu28Oevpp3ZGMfLJnrqnI8eu76q+P1Nl4H4NAPYt7WcnCKRIIqj4dLvzKMyntZ4HqD22B8XvJfHuScORj3/W4+vhMg6sCnoiOGuBq9AnHwJOdS7qgUsGn/ssqsaHxEptdCY0rnvJMcArSxH8/i+o1mNSPg8pgkYcIUYob/GJA+OpdecnIPLonFwtMvd+qrTObJQWwr/i4Z+I+u55l7s83ufjNrtPzaeFn+XuyVH/bzE5JRFE24LadGJ6KuWDAc96YSTiOuvX4lF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm4UelSvyXTzPHBOHHntRN19L15qryX6MH7sY+V/Oh8=;
 b=FikIoDMPzAdCSWZnXt5hf9jzmVYqAgQ/mMSjF41kDrMblNfNFor2pt7XkAz3ht8hUsL2+x79W0/IpPJDBgj2Swe4xqC18omYb6j9+qr4wAlaAFFrgCzyH2W3y3gAPOW/xrcLJFc33axXVjangCaGbsXiIfI2PyvPKk3mlIpoYec=
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 15:25:08 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::cf) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 15:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 15:25:08 +0000
Received: from purico-e93dhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 10:25:00 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <thomas.lendacky@amd.com>, <vasant.hegde@amd.com>, <michael.roth@amd.com>,
	<jon.grimm@amd.com>, <rientjes@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 9/9] iommu/amd: Set default domain to IDENTITY_DOMAIN when running in SEV guest
Date: Tue, 30 Apr 2024 15:24:30 +0000
Message-ID: <20240430152430.4245-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
References: <20240430152430.4245-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e2d0e1-7794-4a88-9621-08dc6929b825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MEJ1Q20drMNdL9jNLJGnjjiBw3BVaVBC4nUT4r3yrsbMu62Pdso6xR5BUpXe?=
 =?us-ascii?Q?es5V7jCfVLaCacpC4qEq+F3/PDjH8OujMIqiNMV+cJWM4367nnQPzLuAZNL1?=
 =?us-ascii?Q?OHDW7F7RR7aHnQaFL1TLc72BItf41pnLZiEWlA1bRKtFGC206LvOf1s8YAuH?=
 =?us-ascii?Q?4s+lXvG82RxH70NSIDPrOspd4UKT+YL7cG3+0c0MdSU68X25evQHIZWCXiAS?=
 =?us-ascii?Q?i8yK9FU7LofaOoEcWGUxb+gE1RqQqCchIp8lrgHsot8LLq4yBbBPwlZ2R6zP?=
 =?us-ascii?Q?TnzYniefvPUBhInTSPItiOGTpQOAAaSTaqGa0hCOdXSiyqas5HlFs2X6rRQa?=
 =?us-ascii?Q?Zg0dAg2FAKZj6mzta+LI44s7+i0oqxttS1nnao5ko530bTDoN8Sm69hCOiza?=
 =?us-ascii?Q?iON+KjtxE9qHfXK5v+jiy+0+DxrWL+8vEMAuXp7CQT3DbaH2z9I7WTiZwEVH?=
 =?us-ascii?Q?gchdnx1jSQF5lH1MCuVssT9ca+6oPYFLDN9BNHQ1OoBaNhldc4AiGr5dbfXO?=
 =?us-ascii?Q?nVM34ZFI+zSf4ejZBiM1AEOCQumlu7kH5m2+pyLLJ11Yb50fwlJjc62xdqXz?=
 =?us-ascii?Q?5v3E4plLUeGuWP28QajP7EMjQsRElkg4oW8liLQPjeCwIo45ZF3U4YWZofsL?=
 =?us-ascii?Q?k/+LmWtjJLci5bJMQfYYK6khsLcMUD8hS17YPbrzd9uRgrDDP3opMHpe9tWL?=
 =?us-ascii?Q?Yn9qgTBmUL80eRkpNnjokiE4Pl3Wg7AHVUcX6ZcckO94zVFpSE2oURDEihCn?=
 =?us-ascii?Q?Wszn8UhgYM0PeJOyFdmTZp8sRQX9AyOMq6MNLQ9v6rsO7jtPTluOLmYkVQCH?=
 =?us-ascii?Q?UTjbifwPCIj0nFmOaMSgtFb0A2Acb/B7dbT4k2r8zzr5KU82iIf6+/AGJLBL?=
 =?us-ascii?Q?jhOzYgcPWRViEw6YkpcVw9MtmO8AXzfvJFACpZjcFxqlI8zRR6Kd5LDoj6eM?=
 =?us-ascii?Q?Nge/A9+LbmPPnWAK7ScCbuJWkyBze7e1FRuQAw9v//22LsMcJpPBf1rRPyht?=
 =?us-ascii?Q?PA7xPidUeuJ1YSYCyaNRBDdA7kKIJ5oiNh0WBT6xqwy+2l+hVTNgy5bGSuPn?=
 =?us-ascii?Q?Wuivsz/YOSMQBRGMQShXLmvJlgpcsTZ4rpdaCZ406JCcZgSuRVCMGu3ZSXBc?=
 =?us-ascii?Q?sopwfhswnWwNYt/iAXHhsUhv8APAb9GI5W1i0PTNzSRKETDT2ugUIcHGFF8R?=
 =?us-ascii?Q?tAaJmjWnmlQtuLsyyWzUOYhBSKpfJlFcfDKvaDl3agW4UizaOY9mZ1HmXbfL?=
 =?us-ascii?Q?m6RkIlInqfYh4Uvoqaw/3ZT889nw8dQA9CWJtNMlml1c/XYOaHIDNzyE9xwi?=
 =?us-ascii?Q?iLv/sgTt1yNUk73SL6JJQX798WcaIfOAH2cpq/JXhTNyU1rKzQP0B0xCgGeg?=
 =?us-ascii?Q?ZdsU0VOraHS7K4NtR0ETcjrpzaOS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 15:25:08.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e2d0e1-7794-4a88-9621-08dc6929b825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

Since SEV guest depends on the unencrypted swiotlb bounce buffer
to support DMA, the guest AMD IOMMU driver must be force to setup to
pass-through mode.

Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c  | 15 +++++++++++++++
 drivers/iommu/amd/iommu.c |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b3ff89952c7f..1dccf030f674 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3179,6 +3179,20 @@ static bool __init detect_ivrs(void)
 	return true;
 }
 
+static void iommu_sev_guest_enable(void)
+{
+	/*
+	 * Force IOMMU default domain to pass-through for
+	 * SEV guest since we cannot support DMA-remapping.
+	 * Note: This check must be done after IOMMU_ENABLED state.
+	 */
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return;
+
+	pr_info("Force pass-through for SEV guest\n");
+	iommu_set_default_passthrough(false);
+}
+
 static void iommu_snp_enable(void)
 {
 #ifdef CONFIG_KVM_AMD_SEV
@@ -3247,6 +3261,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ENABLED:
 		register_syscore_ops(&amd_iommu_syscore_ops);
+		iommu_sev_guest_enable();
 		iommu_snp_enable();
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f98a10b7925b..c985d23c8528 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2876,6 +2876,12 @@ static int amd_iommu_def_domain_type(struct device *dev)
 		return IOMMU_DOMAIN_IDENTITY;
 	}
 
+	/*
+	 * Force identity map for SEV guest.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		return IOMMU_DOMAIN_IDENTITY;
+
 	return 0;
 }
 
-- 
2.34.1


