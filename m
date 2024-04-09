Return-Path: <linux-kernel+bounces-137614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E2589E49E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469D128459F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D915886E;
	Tue,  9 Apr 2024 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4nmJrR8M"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003C8158867
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695398; cv=fail; b=dGWIbUAPKZBEP5F+dsDPXuEXABBdCaORSOPHPJCKX3TmWR9kFqTbFX97Z/4UE4Y8o4pm32Qxy7APo0//e+G7Hny3eDPcXDEBc0tGsSFy7XCoFvsg/f6iFYBolWuS+Y4MqUYag7tS19jSTOekGPHblV3p1bNDXgpQJkgf/SgUEo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695398; c=relaxed/simple;
	bh=O9RtIXx4JWgeUwXo+g9ct/Y7xeyzUwrqSaoS0gWnWKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFSUkURifZN/awyfmZdTgCQtoF3duio3eL8hcLVpXyMSlPBEh6pnRUoRvcgdOG1N37CFFPHnVh0EuwY4Qf6lqe+RxGI1DZhTawEFAKvISV0titVgRgzDWS3rMdCbMheQCwqWqKdRl9jOPloxGtJEF+Hv4yJUndoxLEcSNCAanF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4nmJrR8M; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8cVdpGVZW7aRVti+6MrA4r9Jom8D9vKFeHaqM2FDfQcSCCLYwEaXzvigXV4H1X2US6aQCMgYpM1DYUC/bLiPA+Y/nOmOE3yQQCisYgO9y8TaxpM4q5jmIoA93Qhb9GFb3IFMTbfwrnEoT7bvxoHSwh8HUYEOwq4P5qdHOOkZ9dov8cWY2069OWesLgv3kWnIN+KsSNn6fCqMbBnRvjLTMn9cZI3qG323NeKa3rgr8Hgk7bp+cRD3/akhb7frrmt1m4CWEVO37i2tExIixWRnO5avA2LyINNk6Tssc5KZ0gO97Jq6yuolJxoVZaiCvt0FVd0Ql8TKuwfu7SgyiLncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S81AvixGk/DHDK2qX0wGIvQi+fsTzSVjzbN639fuGkE=;
 b=gPixjwE7bV00yqf/M7ZhBNzxJA+a0PU2UijiV4j59c6gWyVFER3KQzmB1Bo6SBR9ZJekbHCnlFx2EhiIjfQJdjIGtQXgIyGElzfGXikW3Ptg/WBwHd6Ncdp8BdKOz856/KVBOwvsYWm7F9amDaYjCoXzitAbDeRgAILcKYhVn0rqlBGTJDG8CD0sxoleQqDuwpQoIiB2tU+r1TmEZ9XfjmpRc8/XsPiBrVY9FK699tOZVXqtxSJxCOg5bTAXMkXYHjwPp3E95iIka1FKZLDf4GjPmLughSNJDfwJMPHVYQnIRdmzgHM6nHMHVzyjGKNfizKbODorm3qphd7riq4rWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S81AvixGk/DHDK2qX0wGIvQi+fsTzSVjzbN639fuGkE=;
 b=4nmJrR8MVrqsYTPH6fptCPNzD3CcW3MFt+vV6Hua06LiUG3RtD4ya406omKUxpXvImQSDcbj6HsQnX/N9OI7n6zf2phry+ZqNoz4Z5xb96dbp3kLw4dtKcVnGLT5tFg+rX+RsxtmoOaaknTtcFp+aRdZs4zMhSijuHl3Z+U1/cs=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 20:43:11 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::18) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 20:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:43:10 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:43:07 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <peterz@infradead.org>, <adrian.hunter@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <jun.nakajima@intel.com>,
	<rick.p.edgecombe@intel.com>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <kai.huang@intel.com>,
	<bhe@redhat.com>, <kirill.shutemov@linux.intel.com>, <bdas@redhat.com>,
	<vkuznets@redhat.com>, <dionnaglaze@google.com>, <anisinha@redhat.com>,
	<jroedel@suse.de>, <ardb@kernel.org>, <kexec@lists.infradead.org>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Tue, 9 Apr 2024 20:42:58 +0000
Message-ID: <7ed29de1c5107ffa4ce939f3750e942b12fd26ee.1712694667.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712694667.git.ashish.kalra@amd.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com> <cover.1712694667.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db6e070-132b-4b55-1d02-08dc58d5ab3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iq2VuSG6PrSfuKTzX39Ihk2+Y8r2sWf2VIukQMVXZHJiTrhOY6LCbSICOliXBbyDg4w0vNuS068CBbB4wU0aOZLe4NrIuNRmmiJ2d5uqxBP7qTcoANq0MlytGf6fdQh5FbUrKJ54qIiYCbo3ea0nliaFGvm/3hl1pfeD0LXdgrM7KH15NzJMGHKAF5TJy5MZhSHYwJREKfCtLyJU2UnX4kvJdpJ+ZHCuXJFu6b7ln3F807TNjhzN8v8g/GbxH1ysLrWMk6qRkgbQjaBg355zCujV7w9cihXZk7fcnuZfiHiRsi/LSqjOXuSA5uDMB3lGuDgJVBx2Bxbyp1wg1Q1IOkMveonyIMPp/fIK3CIkxvYqY7C7qat/qovSholRRL18pC+lb3/ZWP3xvnZ62slUs9IvAIXCbs+XPf+8tT5JO8nFJqr/KuwNj/K7SNfswsSzpMWZUH+S5IVYHWMOGsUnf9KNFde2js/u+rbBeUy/PP09hl0R1nJXlvaFztecxdC4zPHpB83+YBQX89RqK5Bd9S64pxfaAeQOnDdSYoDYFHcla7e1CRPBJdtLMmYyGHpfPI//4YyHkUjc9EPBBPb7ioUyTnLxIoCZaIDZRFCDA249DsWa3i/2N7NpaAkL2RIVihOt6I4mlzdRyhxfnlBNUh0/jB5kzNGSBonk8Us4uRcnCB20qSMp8zXbOUIwMHGcSE2S9eM1ZR93NHfQm3kWt8fBEj22Qzhm/UXwxPRInDG4LqbPiCt8td++tNLTkF2T
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:43:10.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db6e070-132b-4b55-1d02-08dc58d5ab3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

From: Ashish Kalra <ashish.kalra@amd.com>

Accessing guest video memory/RAM during kernel decompressor
causes guest termination as boot stage2 #VC handler for
SEV-ES/SNP systems does not support MMIO handling.

This issue is observed with SEV-ES/SNP guest kexec as
kexec -c adds screen_info to the boot parameters
passed to the kexec kernel, which causes console output to
be dumped to both video and serial.

As the decompressor output gets cleared really fast, it is
preferable to get the console output only on serial, hence,
skip accessing video RAM during decompressor stage to
prevent guest termination.

Serial console output during decompressor stage works as
boot stage2 #VC handler already supports handling port I/O.

Suggested-by: Thomas Lendacy <thomas.lendacky@amd.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/misc.c | 6 ++++--
 arch/x86/boot/compressed/misc.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..47b4db200e1f 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!sev_es_enabled()) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index b353a7be380c..3c12ca987554 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -37,6 +37,7 @@
 #include <asm/desc_defs.h>
 
 #include "tdx.h"
+#include "sev.h"
 
 #define BOOT_CTYPE_H
 #include <linux/acpi.h>
-- 
2.34.1


