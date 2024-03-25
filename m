Return-Path: <linux-kernel+bounces-116647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 477C588A1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3C81F3BA18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C191ACB6C;
	Mon, 25 Mar 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gWPekkyQ"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC1D17CF65;
	Mon, 25 Mar 2024 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351942; cv=fail; b=dZuhGiH8Y+wzebJAyPVNwrQFrhh0Pi+5nUOwf04p+vTC4Wx7B6rLQ0maCSK/94Z7eYJngY9sx3zBvSWtOpaPXsCcHNGtPaNCvPVFK6GIXeT7qZhpnxi40eXdIQNrvObzJLYwiCiYqq0aC/ngPtK7me60jsnVz9eL0eu7V1iO1MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351942; c=relaxed/simple;
	bh=vsuAU3YIOSuTdMUJjF22U+OVJK8F1G4s2YAHG2oYVWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i163cyyYaSfF47cuQx2A6BgkNocvWrRbkhGIT3JPsL9fT9Yo9+MFemEcrutRw7+jV00Oucd3WpKuqZN/jcwzm/qRfOz789dnD6jIBfLrU5f0M5Gw6FZlPafHCunPyl1OOvOqHH7qUvfIZSReqfjE41E/QMTsm91Oq+PNSACU3kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gWPekkyQ; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFm84/qnfVunfYyn4xdIZEX2dKJIzCT6P1jDlhE//b11GAKDtkUkUvCE3F/h9DwCQ2WFO0PbKVdqRN/Fsr3ukhELVgDOG3+OdVROsUE7q1WijOpthPXTWeBVBZDGky0BWO2JaUIF2cgCLyKpAC0+91gEUWPkho1/pgS1YJPC9LGSD04jiCQJqymvx1t7+OafquQ067ngmED8fc5C9C1HZ+7kvVEQaBY4mKGb+DgYt66noHCZUYy/OtbKswlkQz4ar2uLzGaT6v/yRZUWvts+URbfMlOaMToFXqKKOfAdHqxQanGQ+kRgVQfwve2+PnEgXdK+GJ4ut2m65t4sUduygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KYy+WLYWS3AH8Aw0sJehhccm014jm6+J8Ws5SrZMiU=;
 b=IabG0BDpuZP4IwiM0lCffJsZcAx0T/pD2mPK46NloIhrIXSKQW2W9u3ZKkWsKK1OXbK2Nux0qFbKhtxEKdTF9z06FgmHQ1Nd86W3dZOpuEH0dYwvxU4YfLQFRoRjB0QI42qZzoqXVGst6r7gPx1nJ11Lh6iaHv5w9OUsCjh8rIVYGtYvLvobfPFBI6eWDKKjHTIQkmI1Aq5fV3xl87Yi47REJtbabO1BpmxksCb2JCYy6pKfI1M/OLZ8VO5MGI/hf5e0OP2VnT1NGoo+diwSRfMLRhe56NkUcgbHlMaJ2YqERiI8YG4QDyMzJfouu5urHAm9opHearxVABG3xYIDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KYy+WLYWS3AH8Aw0sJehhccm014jm6+J8Ws5SrZMiU=;
 b=gWPekkyQwZnYIa3tTBIb9RJvkXfVHc8FnlbHFbLyofFAzN1ExW/PcNh3Q0t+fsCr4YggLargqNkPHppvRHgKhb3+hKytY4XblOV546H6tuiqgIQNKSaFzcQ/n2trgR6w4XOkzMS/OJdnllyMt8kX71X4eeJ6xPYGs26aaUGwYDI=
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:32:17 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::fe) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Mon, 25 Mar 2024 07:32:16 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:32:11 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v5 1/2] x86/cpufeatures: Add new word for scattered features
Date: Mon, 25 Mar 2024 13:01:44 +0530
Message-ID: <8380d2a0da469a1f0ad75b8954a79fb689599ff6.1711091584.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711091584.git.sandipan.das@amd.com>
References: <cover.1711091584.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 43959a83-5e38-4710-af36-08dc4c9db282
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oejzuOZFldKjZox0cJVCL4PZzn3LRyncBxgzSv4bXLPLSMsGVQ8OVvfimJEB50RdERg0723ufHu9KN6f7kgiEpQgJIKLCmL5t/+4+Whziai8fC/g9p1NmDydwjAQbI7A0aX3vW5YkWv5Vc7CU9tXSEoYCWyaw/NbmVEX9wuPkO69pYEfZ0TE2Je86pYZbeSE6e+KS/fe3ESFTAaaTl9CvPF9BOdB7HYHbEOMS3A1W6QJF77Oh6D60QYxNIiCg+/LfJajG3hFsdMYkimyzxmMBxXqV8F9vbLYUPrqEZ7HWRRgJWu4Nhdqz8be0K90w5XeGblc1V/s4fWwQhIox/IIFvqJAvUdcP6Ps811Jer2+BmG9zY0V/O9oYaaBbd+/B6M1Yw0uU+00UdxSZkReKv6rRyoQ78x1rxJHN0xWGFb2J3NZCxQr1RFGlRPa0zYKQsGXhlFYzKu99L0zAf8TIH/d0IwNBEHx0u/EtJfEGPT/cg9lH4HpOnGTpQMx5noV+yQT1lJG5+YG8ZSpnbAfpEtF1hIzITtZ0XW9e3FwOBSuKXAnMXbClLjEOE0pe/25qfMvqhRxJWtGY8iTh+3FAbFzLw6lhTL6yweytFR41uVCse94rYiso6z2o4qwc5lWMpvse3e7C/221EMVfw+UNYIOBZRpBymH84j0MbDmn0Wu0HHHcTzwLE4/K/nn4zEqc8po1noL+FoyhhfuNnachXrINNap+fRlRZdAhU8ASO/gLQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:32:16.7784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43959a83-5e38-4710-af36-08dc4c9db282
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

Add a new word for scattered features because all free bits among the
existing Linux-defined auxiliary flags have been exhausted.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpufeature.h        | 6 ++++--
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/include/asm/disabled-features.h | 3 ++-
 arch/x86/include/asm/required-features.h | 3 ++-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a1273698fc43..42157ddcc09d 100644
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
index f0337f7bcf16..4d850a780f7e 100644
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
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index da4054fbf533..c492bdc97b05 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -155,6 +155,7 @@
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
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


