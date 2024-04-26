Return-Path: <linux-kernel+bounces-160386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57F8B3CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FECC1C228DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78285146A6B;
	Fri, 26 Apr 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gs/CBO1j"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FDA2B9AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714149276; cv=fail; b=P7w+LdZFpUQSxwUnQD6TNYMiPRGfUabhd+z9iMZI9nhQ9RNgeK5+NmBFC4lkR5WczAWIBpZZq28wxC8uPaqE39STLfdNgFakD8al4ro7kRjlcaCwJyo9OfEozeZUc1zMH9psW9UA9Pv1cIaAo1HnDgEOOdojtdWcnajEvAyBJAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714149276; c=relaxed/simple;
	bh=oeN3YWhguWxjQNeclQa+IfSOz+Df0i08/eFpNzUjq9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOKQXu+5/ArPmwg4LFZ7NFnOOWoWAzR2J+OPMNgFzFF0i5VaphF7nenfE/IORM9TucQjFac+HDB600+Ik0iyPWUtyXDFn4SuGu4lPCALkTspTpRV08Zjk2F05HiLz41pkn6GBAV8eZtAONe4+8kyCRJkydFSLYV8AbGK1NEZuCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gs/CBO1j; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNUhQtxPFUVxUybsZU9OuX2vSw7W+Gs/P2O7Kau4z3FQ0kv+HPHL21WoYIju1Gfke483A3kOm5WZGGLV2IHR/yelmiN7MNDsOzDJdCytl9tTbgOEGfWnp1VDN0Cq59XDnP+LKVCRt57SJH6Pt3YB/GSJrG+hFD2RiuMFmdQEkYeiXoaMILQ0EQiq2Epn3EBnm1aBs17HcTwgqUUCsaqMg0H2ooXIVM4nzwbsRpSnCAA71xsOJjI9ZykqqUmMDuUEJiwMzIjFMCIgwM8syKE4CYYsPLJFA95Roaf5Owp24qfgOXoRWV2KCnuCiAorfEPpHEZTZbI1An5hk4cQwA5dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=lHfylkTxllkTMN1w0dT0slyNXDu186dQy9SFr4741GE2YY5gbe9Ffd8iSh+wO5oMwUT1Q6fpicniqOVNf7y8nI8ybpAZyFIh8HXjeog9JwPi/C9W4ShGddG7mXlFwvoq5onNFFLF6dHMHOP6Y570i4udqJuF0rpHjqWVstIai8lM1cLeocTNDvBpM7AN4ctGwf5GxZf87r4Q+pMMtbNSUDsPiy+QBD3/jvkJFWIRgNEqTnDkXEErzpiI4xfqXdvLz7Jc2T6bCEb31wrmrzJBdgkjASEj3jSckihMWmgFYlmRD0TtevSt4Bq5FaFa14baVpBGEZ50JNZ6SQ9dZLmidQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8In1wj4zpxqXng+/MvpIStRWhMMfirb2tsJpUKGbnWE=;
 b=Gs/CBO1jAoOIze3tOeDdwPyPnNT3m4Kr7qYniiaJvm6g1QR8IOZ7+o64Cv9V4TMrlDyCKS0BeEMPjVgXBLcMI1eAvYGrhDnF8EP0vQheMfzTMI5ToRqj1evPWMEp2I/PfsccNzHZ/oCURGeN5fJhdVKnzRLtAS0dUBCWpQAc1QA=
Received: from MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20) by
 SA1PR12MB5660.namprd12.prod.outlook.com (2603:10b6:806:238::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 16:34:32 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::1a) by MN2PR01CA0051.outlook.office365.com
 (2603:10b6:208:23f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.29 via Frontend
 Transport; Fri, 26 Apr 2024 16:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 16:34:31 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 11:34:30 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/3] x86/boot/compressed: Skip Video Memory access in Decompressor for SEV-ES/SNP.
Date: Fri, 26 Apr 2024 16:34:20 +0000
Message-ID: <4cefecb927ef13cdd2288760037becc398a16f44.1714148366.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714148366.git.ashish.kalra@amd.com>
References: <cover.1712694667.git.ashish.kalra@amd.com> <cover.1714148366.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SA1PR12MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 48843df4-754d-42ef-c08a-08dc660ec03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|7416005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbB3b47Rt209F3O1yzx62+gwz7zpaD0a2fN1OPKadp/IMKBF3xUlXRYuzedo?=
 =?us-ascii?Q?pHh2at2h5HkRZb7/xNq57Ot3YzeEOSkzTPKYntCqhdBTmcrgFoal2aN6Smmx?=
 =?us-ascii?Q?AXw2eT3wgRB0L6UO07SJy4VfwkmJKCETEWoIa4C+ooDK2FpYiKh8Wuo5Js8D?=
 =?us-ascii?Q?fLjgFF3/ykn0LaIuxtqCunQKwLBl1T1E3Cq/JT8/nhsQEZneJwfDGjbZbJZB?=
 =?us-ascii?Q?p9Fsm1f/s67YRgyJJSfg6VX0FtAxnA8y2Po5Row7yAx8DqFruNu60duWYg+r?=
 =?us-ascii?Q?wvJ06a38DHyq+y1mhF2z+nCho9orUaPsmu3zvt3fNq2BB03YOTiqdqVWvA8f?=
 =?us-ascii?Q?d0bf92XbpmMuJZPj0ExxoArWiZvhMfUL+8SVaCaijSEQ2fVLa2RZxaeo6eDR?=
 =?us-ascii?Q?W7vOtRY6Pka2gf743tU8JleenRGcLOdkITHd0sah31zJKt/Coz73CyyAIefS?=
 =?us-ascii?Q?/1xGi/anSkr1wHQaLn5pOs3auyXjNEtJi7ZOD3YkoE2xUqJ41YZyUAf8uVHU?=
 =?us-ascii?Q?A419YqNo4FLTrVfBJZi4RQvw+fDzTdcFJOXpO26DFicP1XzycpL+ReGKR14O?=
 =?us-ascii?Q?kJicwnFD/9svd599QI5wHlPJABD3hPpt+6aHv91s0GpolJ8D6/IS9djuMiVw?=
 =?us-ascii?Q?BI7OmQTwc3TJEvmDjjlmMiiO6ooSxK9jQYU9lGAZaSas7G7WxhLyGkxdlkxY?=
 =?us-ascii?Q?hzClHLkIhFJZoyUymgA1s3buoV4TccEJXfKzRWBlRC9Jgi3AIS4xKa8rvGQ8?=
 =?us-ascii?Q?+YpBPtw3J2mkTTk7F2X6xEP5UjrupHpKEv2k995VhQJTeqfUk0cBSL5eSUU+?=
 =?us-ascii?Q?2PM0zPcSJpJzoUanx0v4EGTcuqR5Jc3oGH8hIvfr94eov013apPDJu7bEC44?=
 =?us-ascii?Q?Mk74sHKxmpt+JLAd9cyXRjINcG0cJAxxYGSdApjswyQJlhE9IejznyE/6oTy?=
 =?us-ascii?Q?72zIey8AvyAFsHXRKJWhDqaowL5GcAgoUYUVI+rsyQ8vbYyCuFwxr8zRrCk3?=
 =?us-ascii?Q?fTkY2uudsnwf4msYm6Fkmi/oOoKYPOzAEl+v9+iFymlStO2rX3FlyPet2Sze?=
 =?us-ascii?Q?h/h+RhuCftNbBgBQIwkBUSsuM+L9iJkm9POaMuyoZAaFy6v4VpNN6a/NsHck?=
 =?us-ascii?Q?XW7qG1nQMxN+PP14vynBI1VMBm2hPV74jIttD4Xbl5Pw2Q0QjCWGbHrz2K4e?=
 =?us-ascii?Q?dHCCiV1YMEyJgZqtRO7q53qWBY9HF7Yw2VNIYhq8+AEOG4wxrBZKvzA5LgdE?=
 =?us-ascii?Q?LUv940d1V/mbqFL/ifFrk4RNEh/QoYzvTxpfiB2Z1bI9PcDIF1cQ0763s4GQ?=
 =?us-ascii?Q?ONPAEDRY7bEaqlXJfr5/56gKnQnx21yWYF7iNbRTzBYTwpLA3N6D61qnU5Kr?=
 =?us-ascii?Q?eLI/5udAUA2Nfnl3m/zCJffeXB7l?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 16:34:31.9743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48843df4-754d-42ef-c08a-08dc660ec03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5660

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
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index b70e4a21c15f..3b9f96b3dbcc 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -427,8 +427,10 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
 		vidport = 0x3d4;
 	}
 
-	lines = boot_params_ptr->screen_info.orig_video_lines;
-	cols = boot_params_ptr->screen_info.orig_video_cols;
+	if (!(sev_status & MSR_AMD64_SEV_ES_ENABLED)) {
+		lines = boot_params_ptr->screen_info.orig_video_lines;
+		cols = boot_params_ptr->screen_info.orig_video_cols;
+	}
 
 	init_default_io_ops();
 
-- 
2.34.1


