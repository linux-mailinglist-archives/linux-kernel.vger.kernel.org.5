Return-Path: <linux-kernel+bounces-120005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31988D003
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D1032368E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F43C13DB87;
	Tue, 26 Mar 2024 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lEAB+IBp"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2413D632;
	Tue, 26 Mar 2024 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488437; cv=fail; b=h1hCTdDur5L1RZ9YxoO1RXnFMoE31bN+6hxykDLpubg7oafTmlBHBFfgtZd13pg5mSy/nJykwPLasiioE8nJ9G+FzqcTpCu39zGUmgTljFwVHUBFhd5WYsxE7F3zra/T0D7RvNvPjz+NuFo/SUBrSCwCiCaS2333uRuaZeXgDm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488437; c=relaxed/simple;
	bh=uWEN28y8cxM+7Tcx8QgD9+QUIs2CmTCNLSfyQiDHvZ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXUHvIjlYpr++BeF83i4OmkSzKQPKe/tVkPiPMEyBgZ6TZIRC2MeTXOLSgFKOopgBbVGq8acCv5MZMye5d7IN05/HHFPFOrkOB9EVxmcHpYOfIjr2Mu0t1k/cwRFYlyg3VdFKJOQyn7ZkbptW8DZr5gFy2p8/4zWGAkadNHsMXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lEAB+IBp; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBKSv4tM0umGwUKYbidNVVfA5aKOK9gk5XtaDq0Q51CMuEBySb8svCOICV4AhJyYg3L1i2BxOxBrmbC0ZAJ78zN0mob990+m/JiV9xdR4a9XRlCVGK+zi7ddr0AcoNOp2nhg8So4ZdZznXYK+knph3mM6y8CFz4FCrdfvM/aeyYKZnhOXbyIn6LtZYIELd+KXEb6uCJyjRPuFBTXnaGUsO+fQf5Igte2C2vY4Iv/56crv8qrmmND0n+eIMudEbOtN1CE6bwnAj7zHWQC5aIjRxjZjPX5qi9XtAJZ6qGIuSr2Wc0YZRuJqA1tkRajmprdySQVvNRFZ8DfTxJX0tVEOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ns7AoyqkgI3sgzvCx+xSUTBQed0dAEKftJstVRghqtc=;
 b=idW6SFW3QwwdFp69+GntSMetFFaU7oFz6iB1vy8cScz4OOLKLbQXGtd+WvxQ5B3khj/e15OE2Rg441Wuo9a1AHaV8aHNJpbXS6wDVmS0fSqKrtNJK3f2ZIrGsm8evObhTNV2tAZ3JD/ntMSwl+GHUuE/TAJdBIi2FA8l0psKuTpufzJskM8zGG774Qc/Do8vtViBuDWerKo1EWL60ak5xZInyueEqKde8HQF/CtZrAxORYzFA+TNQAGWDNGpLgOVNAjvz8hDrhxP9Npi04p834WE4lNnTTbPrebH/hIx/ERubmGVtilppuSltdWgt1XL+h01zpd5aJdb9EDKAG/YuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ns7AoyqkgI3sgzvCx+xSUTBQed0dAEKftJstVRghqtc=;
 b=lEAB+IBpJfNuBojV+1ec+FCe+NNY37IbeLH/TSJGsdfXsYquQt9uUnXwavYs23U3ORj4VOzgTAAxVXbrznPFfOHNG/guAawQVlSbpAGE6c7ha9Ic1fVvQA1HA3neMWmDoFIrT0CV3JGIPrsgA14ImBNYjReVOgSM4HukyIYdiLk=
Received: from BN9PR03CA0924.namprd03.prod.outlook.com (2603:10b6:408:107::29)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 21:27:12 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::31) by BN9PR03CA0924.outlook.office365.com
 (2603:10b6:408:107::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 21:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 21:27:12 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 16:27:09 -0500
From: John Allen <john.allen@amd.com>
To: <rafael@kernel.org>, <lenb@kernel.org>, <bp@alien8.de>,
	<yazen.ghannam@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, John Allen <john.allen@amd.com>
Subject: [PATCH 2/2] RAS/AMD/ATL: Translate normalized to system physical addresses using PRM
Date: Tue, 26 Mar 2024 21:26:40 +0000
Message-ID: <20240326212640.96920-3-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240326212640.96920-1-john.allen@amd.com>
References: <20240326212640.96920-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e0807f2-28c9-4439-aa8b-08dc4ddb8042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hKR98Wvl+QHNIuTyBLIERfh4gloTK/hIFiZl92cjwsoaaBySBN+C9OGipM8gW6S9RLhOxMstoABl5AuPqYZFDRAqh/zvfotYsXVMgZrAMMb8/vu+04+imNc6F9t9T1J2LyDC4hqA97QxAghhPhPIn8pPClZIkxhjUTuRlMaZY9G75QMlIb9urlPfpT8gq7qm5R229bU6qsCmkRX4N6PoJhQMShECIleWjhyS40Z+zIKXulFStvO3RYQMY3ozIEC2ezxNugsNgand23wLXduGMLvZf4qeWOT52PbXNidmloDtWnsDCE5xHJi/X+pSRMxZvs//EJNfborAAxxjd7fgNAcTKx6ggaFqx0Z6YH9G0iNyZN74UJmxp2NNUiwGrO0f9wxf1nx7Fn+6KNRTEyYm7EWBhve6B5UmzxQa45X2SE++WrZGF9Nx+kq916I8JRtgEfGTCAKVcZjsUDr00U8Pf6KgClsV8npK6/D6BUQX8TO/xeT+i4+oFGhm4v6AeyaXw8dqs2SmigVvSzLNjuvmVnhCzA7y/6HNNfutWXz3sDHLOGbxY8zGZo2HstCNrat2djPFnPz3TUpR+Tl8bim7PB6wJSh8zanK1J492mHDtf/nCgtjmbHD9iK1poWbOWTNCsEdGpvx2NHfKZb4BpBsplSK+qz32a+DQhJjX1COgpvA/NZtYpy6p0EkKj/JQNRxHofE7nr8ighx7axYfKmpChltREALJTtR+4/tMC1BmyEENlfInRFhGaSaROeq4zrK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 21:27:12.2766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e0807f2-28c9-4439-aa8b-08dc4ddb8042
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

Future AMD platforms will provide a UEFI PRM module that implements a
number of address translation PRM handlers. This will provide an
interface for the OS to call platform specific code without requiring
the use of SMM or other heavy firmware operations.

AMD Zen-based systems report memory error addresses through Machine
Check banks representing Unified Memory Controllers (UMCs) in the form
of UMC relative "normalized" addresses. A normalized address must be
converted to a system physical address to be usable by the OS.

Add support for the normalized to system physical address translation
PRM handler in the AMD Address Translation Library and prefer it over
native code if available. The GUID and parameter buffer structure are
specific to the normalized to system physical address handler provided
by the address translation PRM module included in future AMD systems.

The address translation PRM module is documented in chapter 22 of the
publicly available "AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh
ACPI v6.5 Porting Guide":
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/58088-0.75-pub.pdf

Signed-off-by: John Allen <john.allen@amd.com>
---
 drivers/ras/amd/atl/Makefile   |  1 +
 drivers/ras/amd/atl/internal.h |  2 ++
 drivers/ras/amd/atl/prm.c      | 61 ++++++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/umc.c      |  5 +++
 4 files changed, 69 insertions(+)
 create mode 100644 drivers/ras/amd/atl/prm.c

diff --git a/drivers/ras/amd/atl/Makefile b/drivers/ras/amd/atl/Makefile
index 4acd5f05bd9c..8f1afa793e3b 100644
--- a/drivers/ras/amd/atl/Makefile
+++ b/drivers/ras/amd/atl/Makefile
@@ -14,5 +14,6 @@ amd_atl-y		+= denormalize.o
 amd_atl-y		+= map.o
 amd_atl-y		+= system.o
 amd_atl-y		+= umc.o
+amd_atl-y		+= prm.o
 
 obj-$(CONFIG_AMD_ATL)	+= amd_atl.o
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..f739dcada126 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -234,6 +234,8 @@ int dehash_address(struct addr_ctx *ctx);
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
+
 /*
  * Make a gap in @data that is @num_bits long starting at @bit_num.
  * e.g. data		= 11111111'b
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
new file mode 100644
index 000000000000..54a69e660eb5
--- /dev/null
+++ b/drivers/ras/amd/atl/prm.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Address Translation Library
+ *
+ * prm.c : Plumbing code to UEFI Platform Runtime Mechanism (PRM)
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: John Allen <john.allen@amd.com>
+ */
+
+#include "internal.h"
+
+#if defined(CONFIG_ACPI_PRMT)
+
+#include <linux/prmt.h>
+
+struct prm_umc_param_buffer_norm {
+	u64 norm_addr;
+	u8 socket;
+	u64 umc_bank_inst_id;
+	void *output_buffer;
+} __packed;
+
+const guid_t norm_to_sys_prm_handler_guid = GUID_INIT(0xE7180659, 0xA65D,
+						      0x451D, 0x92, 0xCD,
+						      0x2B, 0x56, 0xF1, 0x2B,
+						      0xEB, 0xA6);
+
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
+{
+	struct prm_umc_param_buffer_norm param_buffer;
+	unsigned long ret_addr;
+	int ret;
+
+	param_buffer.norm_addr        = addr;
+	param_buffer.socket           = socket_id;
+	param_buffer.umc_bank_inst_id = umc_bank_inst_id;
+	param_buffer.output_buffer    = &ret_addr;
+
+	ret = acpi_call_prm_handler(norm_to_sys_prm_handler_guid, &param_buffer);
+	if (!ret)
+		return ret_addr;
+
+	if (ret == -ENODEV)
+		pr_info("PRM module/handler not available\n");
+	else
+		pr_info("PRM address translation failed\n");
+
+	return ret;
+}
+
+#else /* ACPI_PRMT */
+
+unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr)
+{
+	return -ENODEV;
+}
+
+#endif
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 59b6169093f7..954cbe6bf465 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -333,9 +333,14 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 	u8 coh_st_inst_id = get_coh_st_inst_id(err);
 	unsigned long addr = get_addr(err->addr);
 	u8 die_id = get_die_id(err);
+	unsigned long ret_addr;
 
 	pr_debug("socket_id=0x%x die_id=0x%x coh_st_inst_id=0x%x addr=0x%016lx",
 		 socket_id, die_id, coh_st_inst_id, addr);
 
+	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
+	if (!IS_ERR_VALUE(ret_addr))
+		return ret_addr;
+
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
 }
-- 
2.34.1


