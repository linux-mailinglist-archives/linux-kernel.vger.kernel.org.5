Return-Path: <linux-kernel+bounces-131694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FC898AD2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1C01F2A884
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC7B5C8FE;
	Thu,  4 Apr 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1ISncIAZ"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F5012B14A;
	Thu,  4 Apr 2024 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243672; cv=fail; b=IJ7928nrZKoJS6QBbH5/SynxHn/Kwrxx/M1IkXsjiWZ2bO8X89ZIDvIB/xXnN2n/ETYzV4Bhf772AZqHeiudhtSgbnU4CSwbkB6C4DTZ56RPnM8aTQ91/pBZ834nLBR51qo3rVnb6ZIWECkEVMUrAm58Xwn/qzTw4o9DysqfbVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243672; c=relaxed/simple;
	bh=R/f1SgWoxON6lTaRMvuJSRdNVKD62ll4NlvgOBoVAIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duYF9dAdbGvkbR0xpW43OaFL7qMjXtRMWoLoMlH7m7mHQ3QZDrzJ4ylPVmY8RIx6G+5SJmaQFd+ScUsPuvnEr4nDnHgiSOblzYaa1eJ4am8wVeY6+1KUIwRQ7InNxUMExbIrF2mQtBrTPU6EiJl+oGJKmyDkmyF4Y1Dv74fHyE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1ISncIAZ; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlmA+8+gQEA0O+p/6s1hkKklwNCaFjZIcF9WlsD4THsa8ss2e7rMSSje1swGNrugZ+rjo8WlmuG+oA/S0sHqvm1+YMVFt0cSp6k7EM/9lQDAhxwd+D2+YWeXQLva9NpJ9tp9F04TuHwJHQExKn918BEUkCtJSYX12C/uF9X74JUILHpV62MaGFBMeCpJD0G9s/IYQQ/LybDar2eDG0cY5b8sZrDrUgdA0Gq1RtFE/1BhsKXDYYOCBJurOXK/ebjB3V7Egtj5z32u02kRCPoBKc4nSPQ5C/OPCyzDCTGr89/lUQo9HCtD9g4IS2A0NmrqFBN2gdUIg+kUcsMCshCAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvwbYhtmemGdjxmXLAN1KW3v8Df3/xLy0FI1JdLG4Jo=;
 b=QZmUvv1iqV91YgBGlLRD4QlToq2ypaYfgAo4l2gk9dOvqENgu8bND2eFtFZclrUJEzi6z6T6Qu0HvWygw6fENLOUUbCrjd7dZXBdKsnXviIRr01nLl13Eh0nTbIJ/6Aq5Yqtx6IiEWE1QjoLq4xm0QIw7eeix2GV9c/XjL4LljuDJMp0YfWKKyvNIbsTXQp6L/LPhhjscWkhgu1sfOaajctkzvj1zlfpxIgDEMbli96kq1FuyOFnREVZBpPIJ6Rs3qfanNXEY81/c8sS2FpSa23Re+sIyZSiXS/wY6joAKWiGKUGgyk5XO1KnRAjlHDgmQVUqzl2b9RfVjmnIq9Azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvwbYhtmemGdjxmXLAN1KW3v8Df3/xLy0FI1JdLG4Jo=;
 b=1ISncIAZLkF+iGeZjAvKWsUWfAIJ9lhQ8L7cCl1ilHe93ybUKN+c6HHq8Hma7v9raODl1qMqIlf0eGxOpgFQrZN4kWL4WXQfcxNPg5MnayEO9cgB3eB6txMWDQ5BVx68yTcL5v6bOk6rG1Qgc7bdUKBQkrHN9jJ7beTOiYYT2SU=
Received: from DM6PR05CA0054.namprd05.prod.outlook.com (2603:10b6:5:335::23)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:27 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::4a) by DM6PR05CA0054.outlook.office365.com
 (2603:10b6:5:335::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:27 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:13 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 11/16] x86/mce: Skip AMD threshold init if no threshold banks found
Date: Thu, 4 Apr 2024 10:13:54 -0500
Message-ID: <20240404151359.47970-12-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 220b2836-acc7-426a-6f62-08dc54b9eb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5SFrr5eUIaUj+qQFHA1NfxzReztEcKtx5GcJ0NTso4kZzf58EnUovlCWSOBuhkQ99Y0NtlXVELleb7hmYLnti6jBkEZPI1VP0qwFFG4OHaOOeKnOblBQRTN/+NRUMZKakCeuYSW2Nct4aWWwIViSFgSUunPg8UX1b1BBjuxo/Nn8V4LXAuP2JmE4kBQdbSRZtqcOG84VXvplAcVNsrYc3AT2RvKd0PW1VqvdvhXvmaSiFDak5BQL3u3OTka8ii/zSgxwh4voneWb2yiDfLGA/MSeAQUV7CqTSYd7VrHm+HFA226d1vvR0v8fw/q3FrzdYbJC6BiAXufEjV/gVE14uAz43vUfX2bj9E6SR2R0y5AOM+Yv3OHCudiGfW3qZHmGjdYe2vFtgokO15LBVyoF++VLQ3rXgPeIoyLFqPVXqAZURzKf/m3NiEs7Jo5mjAbMsNTVdfYZr3kI3YGUVrwxluu3QjH92mLfIPSitHYcYDg+k34wpoRqAGaXp/J63sSOkWYz0B/YGbSqUblmbdwRBOBbQlQpgro1A5AUNIYhOhHpK2K+oO637gZWS35UkAeyHWt3m3MJAjbIcKAVn7y+9myc+M80gILbS1/66NLz07QS/6hcoR1f033+9QdnSEhjDgtPf8AA/YgVl+ZTB4jrqrrRqIZXRoWsug27sR5ucLW1FUhxz/Xr2nbWNsMdiwCO7BFyudYPag41bwUkxbD16w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:27.1392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220b2836-acc7-426a-6f62-08dc54b9eb58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

AMD systems optionally support MCA Thresholding. This feature is
discovered by checking capability bits in the MCA_MISC* registers.

Currently, MCA Thresholding is set up in two passes. The first is during
CPU init where available banks are detected, and the "bank_map" variable
is updated. The second is during sysfs/device init when the thresholding
data structures are allocated and hardware is fully configured.

During device init, the "threshold_banks" array is allocated even if no
available banks were discovered. Furthermore, the thresholding reset
flow checks if the top-level "threshold_banks" array is non-NULL, but it
doesn't check if individual "threshold_bank" structures are non-NULL.
This is avoided because the hardware interrupt is not enabled in this
case. But this issue becomes present if enabling the interrupt when the
thresholding data structures are not initialized.

Check "bank_map" to determine if the thresholding structures should be
allocated and initialized. Also, remove "mce_flags.amd_threshold" which
is redundant when checking "bank_map".

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-16-yazen.ghannam@amd.com
    
    v1->v2:
    * Update mce_vendor_flags reserved bits. (Yazen)

 arch/x86/kernel/cpu/mce/amd.c      | 2 +-
 arch/x86/kernel/cpu/mce/core.c     | 1 -
 arch/x86/kernel/cpu/mce/internal.h | 5 +----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 40912c5e35d1..08ee647cb6ce 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1455,7 +1455,7 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err;
 
-	if (!mce_flags.amd_threshold)
+	if (!this_cpu_read(bank_map))
 		return 0;
 
 	bp = this_cpu_read(threshold_banks);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 308766868f39..17cf5a9df3cd 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2024,7 +2024,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 96b108175ca2..9802f7c6cc93 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -214,9 +214,6 @@ struct mce_vendor_flags {
 	/* Zen IFU quirk */
 	zen_ifu_quirk		: 1,
 
-	/* AMD-style error thresholding banks present. */
-	amd_threshold		: 1,
-
 	/* Pentium, family 5-style MCA */
 	p5			: 1,
 
@@ -229,7 +226,7 @@ struct mce_vendor_flags {
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 55;
+	__reserved_0		: 56;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.34.1


