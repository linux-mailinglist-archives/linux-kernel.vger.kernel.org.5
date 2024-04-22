Return-Path: <linux-kernel+bounces-153473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B868ACE82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C4A1C20D25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34D14F9FE;
	Mon, 22 Apr 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PfUqBSaG"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902B13E8B2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793178; cv=fail; b=J0SGPtWUcpBMujNXMgunf/0vMQ083UaQtrji6P/rM6dMxwAgxB8y3Z7WGGrP19dhU0QD2HvSvodOHXwMjb5V/iTSDJIP35f7GCmgK6KZdmQL36+0oXg18ONAZ0UtZGVH1WJV12gXm301z+d+ZlHr1ItdonFEhIT8NUqFWKFtQL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793178; c=relaxed/simple;
	bh=kKAZOLfp8caG5dFY65Len8gs55qYRI8KIXN5rcdmJ2A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kA71GbD/dVnXAiw2bBnIbLuRrbXeBBp8Oa6vTCV0GrPHY0GSeoDIHuy7POHT2elZjam06BD2ZCqxvmqr0Yra6h8T5IUG/Uza6NSCCWKVojNtS52hR9pNdlBteyq1+mMAxSXlnGzgjgSoQgorRZpccpB5zB3Xgu4osfpKHUpsITM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PfUqBSaG; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6bp3ynTSDI9g9YnKQfweb3e/suz3PxrPRVvzLdJeqAvXOmXhM1Z2pcvdhdLVW5Uh0vxw6MsyK5bcqTBRaAbV4ondFirukyIHfdtcQi2NyblFr8ZGWSlq0NS2eTaG2W/mvY7fsCaYpuSC85fC43761aWCEQuRlXZNeZHPdAfbMUEce4m0ZuUk8EZ2kzMlpbXsxoQjy1KhIauOAkaBKzm+r6kfHBFY6gtSMAsAalVxI1FT3RrLXG5v79OFvwFDRRJ2eQXNSOMr/aKOxrFtEoqmSJ3c4GYbV/bQfDHJep84xckNr0uIQ+uO0GhfegqKRTVAhRjdwNvMIJONdvE6CIKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcxaCs5f3vVcR9tEPJDLgij/FTQs0AzMwKgvEizNBUc=;
 b=EMvXxpyQHQlbwrEQbQ3793VP1y460b3l3wykTca4h8XRIjDEOnVQkHhKAg3XCG+jM2pSpPpoPDU8mKlXp2xBjFEiZIwCVpRJc42lTWr8A4kcy8FafxSntkQWMFtHnpXqqYSB6yBC3hTGFiH8/ANRO8EJbyd7cwgz61sh2CCkJ3sqz2P4N9zvtUutSFEgAmJXs2InwsjIoRBR8LXRvOyYj1xXF9JawhmwAemeSMjUQBHMBC7yCQv8Nfv5+lTR0pI6r86Q+zG2isTi2Urss1hZg1sn7isI6frXK+FHj0r0xHFruU6vTHKaM8QQHPsu1XOxHffJvKs8Tx4y8XMMUekVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcxaCs5f3vVcR9tEPJDLgij/FTQs0AzMwKgvEizNBUc=;
 b=PfUqBSaGvncaa3PRgPdV00QWtQQFyeTkFxzCXH8ztEmqzKHzgkDB5y9pbt/JVJe6SM6ntDhtuEMAuTbDctDPrB7fBWLu0gf4lwB0swanQkmNJ9sU4416K6/yE19CSmCaDbI5LEwa9WCWQv29ecOK3402LaSbCksm3m0K4xmve18=
Received: from DS7PR05CA0004.namprd05.prod.outlook.com (2603:10b6:5:3b9::9) by
 PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 13:39:34 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::b1) by DS7PR05CA0004.outlook.office365.com
 (2603:10b6:5:3b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 13:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 13:39:33 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 08:39:32 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joerg Roedel <jroedel@suse.de>, Adam Dunlap <acdunlap@google.com>, "Peter
 Gonda" <pgonda@google.com>
Subject: [PATCH] x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler
Date: Mon, 22 Apr 2024 08:39:21 -0500
Message-ID: <453d5a7cfb4b9fe818b6fb67f93ae25468bc9e23.1713793161.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: d473e6f3-b9ce-49b0-e237-08dc62d1a54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+54Q2aCj7eoyS40MDwYT5h5RAt9+vFc1/aju5xqcybOIjfr770NGaAL8Yx4e?=
 =?us-ascii?Q?+9li+IWv+ZJOKhBlQJ/vG0UimGbbbsaS1Fzc3StRlVpkh5fb6fzikzjSlDuh?=
 =?us-ascii?Q?uFoxjYYrTJ3XWxe/VjuHwSE98VRjLrcXAo5RdzlsczxRvAX4OaWj9AO5OYQp?=
 =?us-ascii?Q?0EJFEznDGuy3eiujqMo0tIvkHEedpxpq5IBeQtqKjMMI7LUfASMa32SMVcxM?=
 =?us-ascii?Q?SaAyZlNyKMItaqKkHFm10GlSwFaWMQrOI1JZ+ZQXQOgWVlWVFhW3DqWCrOes?=
 =?us-ascii?Q?8aY3WFMiqLhuZc0nVpl4iCcrATbU261nx1eypqqDX4zfgQ5B+icRmFcDm1sI?=
 =?us-ascii?Q?JP4Nh/jfllRmR7aDJbontwGtR8PbFRPNS02ZWs6h6w+kJT7oxwDL651a0qQJ?=
 =?us-ascii?Q?8Qtxl91wCwghtgySuHy+5hzjNXxF0EcyWO9qu5DECPa4n5Y+aTpsk1iGOrEL?=
 =?us-ascii?Q?Qn9kc9X/MQ9LrcR9kz1O1lIFheGBLVyaKho0uwMRYEsgkEDNwaDSvHAkqVzH?=
 =?us-ascii?Q?JyWukoZzKnJGEeCEpTYN+oKu/3dRQyF3nvxuOvBpYyF19Wu6ncvq+/EU3Esi?=
 =?us-ascii?Q?56giISVI4RfCrCcHhEqajgG3SGreGonXP7kZZVnEhWzTd92lt5jDzVgUKVny?=
 =?us-ascii?Q?wGSfwIAWNgOdGlALfBSRpuNfY2PssvYtZbqCK9WJ1BWFICK9ssY5vnal2jm0?=
 =?us-ascii?Q?l7x42KOREuXRH7fdlaPh5XltTyaLz3y1oDoJ+e1+EGdZL8GZrooTVZBezku7?=
 =?us-ascii?Q?7iLYUG/s03M31MYJIO/21chaiQC3kDUhLGJOFOREWgwFxV8RIs6JRrf2xtGU?=
 =?us-ascii?Q?5+ACzsx5mnpUAgy0C1tGJNG9+BjKdBWa/61ZX2d/y+jpStjrLa6Iw5rZ673X?=
 =?us-ascii?Q?Lb6iJDLtzJ1JfAxIqQ6bneL0wyXA66VHTAf+e1FT1xFHpXNrBTjSI0aYcM5X?=
 =?us-ascii?Q?XqTYJi4dgECJtYlKOisZ6kTMr6nnd/ypgHBaKiLIQXe8wKBbSYTZxjN080Ts?=
 =?us-ascii?Q?dIgDUOePF4mzKPn0p3FG5ouMwiTBWV+J9nM08JpCi4rSM6txx5H4hYAiXEzm?=
 =?us-ascii?Q?WShbDOgDrtja0ARgM0FvMGBXWyO+l+x78mOhHMQEjkvOGfVOXl/z8V5IdpB+?=
 =?us-ascii?Q?2TORh2c28Lg1oCCiBJ3SBbh5m0+6lpLuG4+XdZgMYbc0pGvlIvsiomjt/rZA?=
 =?us-ascii?Q?FC12psVzEAFji5xoNC5xMUZs8RTb0FpSyytdkNpOhr5G/u0zr3R1wtYkXQ15?=
 =?us-ascii?Q?Y63lFJW9CFavBP1ce+xql3iJflr47y7sFQwtbbLkt51ZsYYf8rPcAeCz8UME?=
 =?us-ascii?Q?CSOA+HOG1bS7GXhWjJJm8A2dg4FhtkSFIgucon255HkBi1714cPn0s8iGanw?=
 =?us-ascii?Q?zpiDKpk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 13:39:33.8612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d473e6f3-b9ce-49b0-e237-08dc62d1a54d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539

The MWAITX and MONITORX instructions generate the same #VC error code as
the MWAIT and MONITOR instructions, respectively. Update the #VC handler
opcode checking to also support the MWAITX and MONITORX opcodes.

Fixes: e3ef461af35a ("x86/sev: Harden #VC instruction emulation somewhat")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev-shared.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 8b04958da5e7..b4f8fa0f722c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1203,12 +1203,14 @@ static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
 		break;
 
 	case SVM_EXIT_MONITOR:
-		if (opcode == 0x010f && modrm == 0xc8)
+		/* MONITOR and MONITORX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
 			return ES_OK;
 		break;
 
 	case SVM_EXIT_MWAIT:
-		if (opcode == 0x010f && modrm == 0xc9)
+		/* MWAIT and MWAITX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
 			return ES_OK;
 		break;
 
-- 
2.43.2


