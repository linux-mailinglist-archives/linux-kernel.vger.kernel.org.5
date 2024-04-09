Return-Path: <linux-kernel+bounces-137612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1189E49C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F33E1C2031B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C05C15885E;
	Tue,  9 Apr 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V+iMMFMH"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665B370
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695383; cv=fail; b=IQjCujCDsH38mzU6Zl5vMLxTG8x4kdNtSCN7q8mBYxHYJZGgtMBYGr8bLZKsrPtenzpj0pmwu/hi1T83BSyX3X9MKJqkT5Vg8SCBOLWWK+vNtN+czD2I2i5yNkwG14N/0XuHfW4JyunAJ0FQ2QFOLKh3DVergPMTst8M7zmGU04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695383; c=relaxed/simple;
	bh=s7xi+MAaqEOFNpdFq8AAk6lKQIv1/eSz9ej2GrECRz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyYuaq4bNZiG1WHznRcmv8jwE/fB/1T6aLiDLYj0O9Pc2565wfIxRELz4b0BQAiL0HtqHKc8lzRUhXlWQ9su6YILidA0mLDAuklZW5vVv1Z7LQXnfeq4+gHdDqLpqTEA5n+67wlsG3BBKDiCHZhp4fCxSRo0MdGS53+9+ra9/jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V+iMMFMH; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iH8sn2UD5YSn3VkN4Edtd6gvtGtB4CH18PBGY7Um7IMCkgSls6R+WqkG7fpCDCH7bfjbjZdygTS4YC1y4bgnZnNC73tG/Ih8rGhTvwDcObWEK822qd0tq8DlwdFh1Iy7Fns3+3s1/k92bzV3s8LDrI3onXwi7DkEkJJzbar4ND5bDm5z2JYKHnlzqbeTw+YQhao/99K+T00IFG/iWvkB2eP//ZPjVta+Gtma/Ukkd9TdIS2gM6+Xd/QXE2+Mhesxl69Qv98961ZwuREg+9UNHZ00Frf7K0M7B2bVyC7BYYSP9rnjSxPGtajLsS0eN33tnuHYTgMybcYvNiy0AilTow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r15uKmCXnrREvOsrj7dFmovgZBHZzRWL4+sDpWihMeg=;
 b=RX800Myj4oy8O46cwhaUih8Y8XEBHhrFf75JVlaDPWGHaQQFdua/WAKs95pAIAgfNRWV/dZjAc+4adMrz6H245j6vyYIQHJ59Dt8R5KDPat/F89kjcb/du5fYQgRzXHIo+m7w6zwYerwUi5HoQ7nkLZ4xKE6zEpNjZ23jKFmsiHJOC5BEXpOwlveaASttA43DXHvBFRD06xjo81HikB1P1gJIS/SN2nv5UM7LA8iLSVnfYyAqWNW31hFjdmxx9oT7dRb5gZZNNznLjhBOOxVOmB6g8zHyXA6jIqYVAuyA+C3kPuZAvZ/dzvjcqEnA1E4Mo3MMsZd3GaAYeryr4tAZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r15uKmCXnrREvOsrj7dFmovgZBHZzRWL4+sDpWihMeg=;
 b=V+iMMFMHjLmJbuTwHdsdZWFNGvBq4UowppqHYAqbWjn+UYarJXrYGl5aQQxaJ0Au6YUFXbwj10Fb+K2ymS3HraC7a/MzwzJhmFCvA/F1LSMKJyN7gBk3Yn4enI6AKJNOPg3P7d0QliZwicy9nx6hnVz4KujcssWF8klYLsleLCE=
Received: from PH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::28)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 9 Apr
 2024 20:42:58 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::d4) by PH0P220CA0014.outlook.office365.com
 (2603:10b6:510:d3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.30 via Frontend
 Transport; Tue, 9 Apr 2024 20:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 20:42:57 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Apr
 2024 15:42:47 -0500
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
Subject: [PATCH v4 2/4] x86/sev: add sev_es_enabled() function.
Date: Tue, 9 Apr 2024 20:42:38 +0000
Message-ID: <906e037ecd7592eba859448606b028a68a5d48f8.1712694667.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2aa275-079a-4393-3053-08dc58d5a3cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DpauWJrx5k+sxZnpb3tZfT7QHi08i7LL3CUUWnmexGjmJ7J7/clWtv2yF+MlPKjyfNNhfNKGrlR1Y6Vn6QHPr0+KYuhiSDX3g5pAbBeBhV//lWf/CafTO1dsuCDRgPEef/greHoofiNQqwu+FhMnaB8NJdsG9XPtIj7E0n8oLBTW7FiRg5QO7y2Oh0nOyx597lJoOWOZXLZZI4GPnnRqkwEKRYCjohFXFZp2NNw+0d4wI5KUN3mcKXL8UeCFyv8Jeq77pytDuyVENFBp03mmTTqCpTVBBCj9j+/b6tPblRFicuvnIbLOq6vvLznLnjFdk7Zeu3SSE7X8Ylwiwye+glwoM3rTs1SBbK3slRvVNMWjuvIh1rEnCzOfvKtHM61w1W5Vtui7pN9EwKjmBvByVPXkKr1sn6ZpUEMLHVB/W0jdAaYaXWEz1te6PjnATRKbNjzoQq/RGJuOyMVflqIAAA9E4OuwiHOatjtd5mTsU3YOIebDplszEXGdV7P/aHFJARatSpcNxlvqw0bPZWMkCucVR3eGfXmG6KUXB0W+gDf5pshBsn6vGJT49jFg1i89DYLW5DP4VMe6G3el1mgZrOTPDmHcvayDGmcE2yYhyCvitWP5/PlsDX+9lALfDD42uSS1B133c4EVStHe56V3GkgKEVGX4uG7ZLFjXd/Hr7okk7Jj2RyrRpKJDSNgqIiRSpfzBkRCnS7txi9d1777ZKKWCbECXHz83p9NcN14ulX45iQWLATMbT0oQxjmVMlq
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 20:42:57.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2aa275-079a-4393-3053-08dc58d5a3cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

From: Ashish Kalra <ashish.kalra@amd.com>

Add sev_es_enabled() function to detect if SEV-ES
support is enabled.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/boot/compressed/sev.c | 5 +++++
 arch/x86/boot/compressed/sev.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index ec71846d28c9..4ae4cc51e6b8 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -134,6 +134,11 @@ bool sev_snp_enabled(void)
 	return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
 }
 
+bool sev_es_enabled(void)
+{
+	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+}
+
 static void __page_state_change(unsigned long paddr, enum psc_op op)
 {
 	u64 val;
diff --git a/arch/x86/boot/compressed/sev.h b/arch/x86/boot/compressed/sev.h
index fc725a981b09..5008c80e66e6 100644
--- a/arch/x86/boot/compressed/sev.h
+++ b/arch/x86/boot/compressed/sev.h
@@ -11,11 +11,13 @@
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 bool sev_snp_enabled(void);
+bool sev_es_enabled(void);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 
 #else
 
 static inline bool sev_snp_enabled(void) { return false; }
+static inline bool sev_es_enabled(void) { return false; }
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 
 #endif
-- 
2.34.1


