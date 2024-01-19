Return-Path: <linux-kernel+bounces-31471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EF5832ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CC65B22053
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059C45675D;
	Fri, 19 Jan 2024 18:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IzIKzzyp"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981D356744;
	Fri, 19 Jan 2024 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688559; cv=fail; b=l58LBqMQstgtXQG5a+ELx9DjOTF7AKIakFer+nkeM74QDi4jxKoO2MrCSMRqdnIquKmgfpF5Ns2BiQyriagbCdzLgDCLdr+X18kQtNzxWk4KLEBYf7M29JpLhIDAUITBA4T1FxAWUFXjaVkuLgtL97c5iN9ViolO0Wvs2Lh8e7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688559; c=relaxed/simple;
	bh=7rvOcpLB4kP5FyD+tonomTBphhpcWCh9kHoG1HSVbL0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr/BNw1m9sdiy+tbfO3OkAkXlesIfPEkMJ4z2knbc+o11ZUhNrIAFntVmw4W3KLM34FWMtM5btw1GfSEI8ebZmSLGaKtxl1mLyKVleQDbeVL9HJPsgnM8d55e/7Cr+YwV36RQo8aV1Wid9rFRZ+rIgwcIYt0VWjL/wP1mp6HfPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IzIKzzyp; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZl37H267VD+MUR32LfEz/dnMSuVVBUgMVdCWGbMwf1YhIHo51VHYTo+0zdIX0C6fZDrFvIH8N8h2axnzaJpzGQuPBeVSm235opBko12wnQlPCfrXaqEj19WSZW0qbkjtPEFh+YWbhKh/BUv8yWSiAquqmElL1z9RNmFJ8C5WaIeArzZWQJOVLM05KM1tR2OcrHwY2V9fDL34olGos/WyBlIFFW2IlhUpcGZT0bVcrf2MzlMmfV1ZW/mS4WuGNC2zbslhJ8NmU46NpoukS+S5cR08h+JXlrS19HmEE+MxePRjKHv5DQNR3Em3C/96nNYH2B19G33VmB1Mt1sySHIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIgdjS2Aj7Xp8oiK6uwtOZtAOyvHGjPxl1ePzib3KOw=;
 b=eOPfZuiuIIl/yiloV6meGmXgMMST/EK+03FLxWY8XSeJUhlGeAugXPGvzXjnBQ9pa0VTThx/2OuJopkociNg8yXmyP4o4/aLB/WFMqowmjQKktUVzhUIc6aMFO/h5uOSEwtUMPiK/S40H0Ef61jCkf3QAZ702a65exDVRdjw2lJC2kgzJN+uIWbvxjYaMeb7IB9fl0A8pMG/dvT7deE4lRIVGOZ2UqcN43UkOAjF37FKQElFRNOjF0ApJ0KaEfbdXDVv9oCABqGQ1zX8S3DWqWmD2LcIT8Z1DLkzuXqVkzwiCVABkMg2hkddRKuuUbY8uFExekVLrxM1NF8pUAoefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIgdjS2Aj7Xp8oiK6uwtOZtAOyvHGjPxl1ePzib3KOw=;
 b=IzIKzzyp7kxO7mMzsc3n2FquzqGA7UWq3a5xPDU6fglie1F2f67IcwAZx8aNU09IGiVwQjCJ/yU3bL9FIYzf0Qqxf3/n3hPscF9NME4HwP9SxxztMzMMvjK2AEDJcJCLhN88lnsN6wOU3foaUd7wuclSyqO9rBc7Gv/8Rc8j4vU=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 19 Jan
 2024 18:22:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::2c) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:22:34 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:22:32 -0600
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>
Subject: [PATCH v2 01/17] x86/cpufeatures: Add word 21 for scattered CPUID features
Date: Fri, 19 Jan 2024 12:22:03 -0600
Message-ID: <dc073faf7569ee7ed5b512512e323888ca1a6d46.1705688539.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: be15154e-ee21-46de-93d7-08dc191b9b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RePiNAVr+q96qCqmVt6S+puJeuf663oSRO0et1HEQOg/6E/Ztn/VBKuG9Xdr+hVmyBXWXBQXQEN2314uU4IlAQUoyR7nqvtyVmcT4S5G8iJmT+dE3aCToAkCizdTcBg55W0lp8iCSkZrLb8TZT2KO6NW+YQRTh4r5VLkjcBnOqcFbddhyP+AEe/nHp1J4DnKiTVLLGoO3DYlMpSbeStqqiRSzg7tL9VijJ0aAWyzmgz4liEmNeeQxyxmHXT+wwYO3wAVUjBw6k+JSLXF4xHCNEQXl8+eMdvL9S+2jMCqT0M1CV7jvt7XhjK7o5qhSLrhgR6M9duIve8umjm4rLf3qm1chboTRPhCxKFcOSEk22Uq22esqM2KI7rv7Cs84z/6KyyDa/BMseqajoFypN78zcQc8HNWfR9/NdiejRz5fB2PtutEySz94X5K9RXQH2B3PEz0FKX77+t9tBV3VdWss6ztpR3YIlHnf+monIxQQoz4Me9h2nAImKwwCHoNYjjjzXZiCt3koWjs3DPpi/kEQwEjcLwiWJlwKUHEa4PCTQLeTJlYIxRE1oR82qgAaU821RKxOQbg3c43KZIX8q+7ebFRi+LtVtmpCtxolYxGfiVSCWYMXFy/nHLjfjYTLz6s+Z6pt684IaYqshI0t5Y4tzcfebt6U4jCyGPbj6oOt7BF5HBaRomwv8n+dYwRaYS4Nt2KGegc59hQFCcm46dZUMEn6AvtOUZk6QR9MTU01XkDFZjT41TDlrncZ4lVLguUqyiLTYPQdHqtgiIART81Qw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(2616005)(47076005)(83380400001)(426003)(8936002)(16526019)(5660300002)(7416002)(4326008)(336012)(70586007)(7696005)(316002)(478600001)(44832011)(6666004)(36860700001)(41300700001)(2906002)(82740400003)(70206006)(7406005)(110136005)(54906003)(26005)(36756003)(8676002)(356005)(81166007)(86362001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:22:34.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be15154e-ee21-46de-93d7-08dc191b9b7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

The word 11 which was reserved for various scattered CPUID feature
bits ran out of bits. Add a word 21 for scattered feature bits.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v2: This is new patch in v2. Added because feature word 11 is full now.
---
 arch/x86/include/asm/cpufeature.h        | 6 ++++--
 arch/x86/include/asm/cpufeatures.h       | 6 +++++-
 arch/x86/include/asm/disabled-features.h | 3 ++-
 arch/x86/include/asm/required-features.h | 3 ++-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a26bebbdff87..de394d8f6d16 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -91,8 +91,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -116,8 +117,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 29cb275a219d..26bd99a35eae 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -458,6 +458,10 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Extended auxiliary flags: For features scattered in various CPUID levels, word 21
+ */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 36d0c1e05e60..784335a74f95 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -143,6 +143,7 @@
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	0
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..e9187ddd3d1f 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
-- 
2.34.1


