Return-Path: <linux-kernel+bounces-132243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81C8991EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F622865D8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF613C3FE;
	Thu,  4 Apr 2024 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="olgq5bH5"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622413BC17
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272308; cv=fail; b=i2tbsoI3vOC7jeifdBDIsjiMH0VPqohoSU+jeg/tXPwzUJsUf5/1O1R/Kb5dZdp1UCwgXLqY86bCNPJM3xVAEEsXZ0fHlZdu1DaJoWLLqBJ+hP5pwLi73nrouggG+iUFUk6ygukRqtKBaqkNMCtzlwCDoHo7JkDjXbFywGq/1SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272308; c=relaxed/simple;
	bh=MRj2zmUHpM6p0uyHC/3LxPtBekYflln1xF+RfYY33nw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bmfd5AZBAyQDTTNgRDeJk02vfwnldeXwI0LPmAAqsGdZEnnaz0e76PLM0mQoSGB4C/4VNyparUaOS2euUJ2VydPuwkVeYleu71qw2JtoY5lR4i+XJtwFD46DEWWLpQQbnjGPf+lXhW0dikZSb02aXEnEapIHKyye+LwdFTigg9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=olgq5bH5; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nk7YTyPwagNLY87Ne0bpZu/1hpXeAvL3sHk21OZx8ugXe3kPEqFsCrZmMK8mPOfyhwRpaIzV5SAwHzGGnUisGk4dVHxvaYqS/zlUWjXB9RJ+u7RMpBCzujl1xJWSvylIkSW+yRplsgHoc9Kgd9AC/5utbrntpGGUrfWeFRSlxkFBfUQA5tC2V8sckBnBhN/LuePER8W5XOsZLJJzrkIPtseOupKUfcgoiW2VQKXysC7v7NijhaWZa0i7ie0kcaD+zT9OcX3IMxLKx89MYXSQalc4vHF/HNartPknSES8OO3+S+Z6TLnqykBKo/CtI+y0HyQC9kIlZgfkXzG0H/5I2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuJLmiJCuKYv3wZ3trwzzFudM6kzyFcz8ixqVB+ZMHw=;
 b=jLlqjGQselHMj+wxLBLzizlJAPvxG8x3Bp06A/QyDTN8/kDN1RzD87gl9RxZM+shmJJR3F16XK9vA6d07XMZ4HSRNjhf9FmTzSLFH2JxBDz5l1RvNyR8tdL8aE00jaySMhm6o+5UmDkWnmnDgFaIluGXLpiW1vZu9Vy+JI1ZpYUXQKLdV5QopHfSSG7q4sHzHvOCLvRGjWO//AMZHC7NNuaby+invnMIG3w8ICxAoylZkSP8Ea2tH1oLBibyr6wGgaSBmsL8pPdqeay0R08QQnUa1W7q5+39BvGBzsP0YTXu2hdHbLvxraDCgtClDJgs0IilhZFLo6lknXxnl1jqaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuJLmiJCuKYv3wZ3trwzzFudM6kzyFcz8ixqVB+ZMHw=;
 b=olgq5bH5P+EsfZI4m4NKOF9a6qOK0rxbVxishCXBn3X7ERv1+mLO+mfvGaGIH5ZHHIa77tTwVSf2nDUQ3PCcsM5TpjELc3jy6F3tz1HbkeE+rPoUDPdfeW+Fo9pYva5P/R93q7dOPoZQr2LqCPNpNjCUiDALvKgWpHyiPm0pL2s=
Received: from MW3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:303:2b::8)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 23:11:43 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0003.outlook.office365.com
 (2603:10b6:303:2b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10 via Frontend
 Transport; Thu, 4 Apr 2024 23:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 23:11:43 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 18:11:41 -0500
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
Subject: [PATCH v3 3/4] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Thu, 4 Apr 2024 23:11:32 +0000
Message-ID: <1027427fafa350a41234f5061c8c48fc77c58326.1712270976.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1712270975.git.ashish.kalra@amd.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com> <cover.1712270975.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5a8799-0c0b-4058-4d26-08dc54fc97d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XmZXZHfXzY9AugVggxEAWz2PF33czLQQUOBnw3Yihz4Dl5XF7PXADSSdI9Ut1Cb7hn9bfswpjXp0Mq/R6godFX3lcRqYU8h5VgVFp/f/7VMexvlIMeKbzE1Dpywcj5y4IYjVJwfqvfLtbeB23RmUyvQ1EjnD+kjTykjQe7QDErodwXVuC1XXqDFh0Psb7jYKR6lei6gUh05Ouxzg/0F/LzVHgk9L3PAMbTVu07evIrR9kM5GZicpgm2CpjfRv3S22aPlo9kJR5Yc8KUQ8iw8+m8X5hidEHUlXZmIII463L61NJo9xWZCdKnDGq9di4ptSlMnObIZze8Zoh4pYsqbJcCGW2cZcTUXpW/onrSzr8Ve88iLxUpHAD9w3F5EHhCkkPiRx/SNjwCS/sfELJN0RThVO2djXYRIqOoRo0EFEjOQ6pkcROlwWD63KP7GtJaju4tkrRfDbjFwjcS9uLQGJYknWCcQyKqv7aYlPrERSf73Jy1MwFjLhAyxhEnIiUS58XRGTDqyS51IyPsIfOscYYfUj0XN3tHp1FJFENNqqQdGs3/CvMlaXWgOwBdnBDM0TsVSRUgm47b9K2LyVwNSllSt+rAKw5RbTls7bPd+knmzws8egIchG+ZE5kF6/Oor+KOIfJp6UlA345XKbxQsqmP3gdLGx31ymPbl8gk4EY3jnaV0HS9IxKKO8cczoKRpqI2oQy3nb3+fNSQRHpFN820c8fJnkBBic2+1eXWHgAw9/LUrnQfXp1aA7Kss8F4x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 23:11:43.3526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5a8799-0c0b-4058-4d26-08dc54fc97d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412

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


