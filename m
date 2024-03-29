Return-Path: <linux-kernel+bounces-123877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18D3890F25
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233221F21250
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06B86FC3;
	Fri, 29 Mar 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6u1Ne8X"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6911CA0;
	Fri, 29 Mar 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671716; cv=fail; b=gOHRKNfiMMXoYAtFXMvhvR/adFIFxCR2I15GGR1jnTC4t5M3ZKwsabAvto2Osc80jd1cS8i+Y9gCG01tjH0Jed+mZww9+ykTP9llT8v9iAu7A1apjh3fK2dRTnqVpwm22feTSYFFBGbx8Gks87Eo3+1HDnSIKuGXM0QRcHV66qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671716; c=relaxed/simple;
	bh=Gua7hd0PKOqtmndmLeAr4YM/Zql2Sbh/dUvUNuhpz8w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4RK00Iv399x/p6HXh1XgPWGSKkxIpFA/agM3D85LfNpqQy8ZJqwvFRrGq0PpQM6hFE84g9ll7pdol1QH3UNwWiMqG6eo5PpEU2j91mnt6aixL8Gg4Hgk8qaEXxiCLXfiun1DTPPV3PrvgVEh/TL3DBf/bZ2oWZqZEGLLvURiLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6u1Ne8X; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvCG/KH8Db7HDhTguATCEoNnLWt/TGVAT+YG5R3mz0rOR40Qg/u2Jd/fA6n9MGhJycXQo/Eh0qZ37OyIDwsBbV0RVoCzjfw0aVmWDOSUH2As7fHiNt/6iBZ3017w3Ob659+Hh92fGZ2O4ZDJGmxGaKRN7EuU8WvASFWGI8jIto0zdpAklkXdYu8gaqVssqFwDixqn/T0cRJD18fELgvNHbFzlJ1FDEY6aG0vtF/m5FEP0M+MgkuNd8hw88vn/Aoz98z0NlN4IuiSiwa3oqbwf/L5S0TvFuXwWOQgvfGWCkl8JHM3L54Q7dFHjQZhdeCJ9veHYuR0f9o+/p1ik/Zp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/4pchHJNfrh5ln2ekkaxw5d7lPbqrkW/4irDCvtxg=;
 b=ViPjBkYhedRIkBokTz6JurQE9P8zm8xtmrM15zKiIoexIxWoXAV1oHRcVd5svjM6rfwneXaHO/ufmMccr9ns1hkMVfbwzvVZ61HOIWdmmHUvqPuqWFeOZ/KTlPgkTIEnaEYXwJrJjJybFd+XpIvkDuscI7Hxt2KM/UiFJ88B07xUQyYLPHGPsGmXOPKNPMEglBiE3X9D4bgfmsaOThyXqG4jJW0wRfiAUHaromh15XLLVdFwQE4LRyZRkNkDu0GGQSwGKe/YLSTOsdeanDEweuKn8lyZe6lioO/oNOdXZCacHqGmPQa/HmAZjQon56eV92yWlN/4NkBFCV8ykKacpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i/4pchHJNfrh5ln2ekkaxw5d7lPbqrkW/4irDCvtxg=;
 b=P6u1Ne8Xo9YxLDurPeiTXPLvkt0x6wrhjWwZjta9eTOh6I4yBRRhyg7nYxEcJFlpeUqzSEWKY/NRVj+A7qoFrriY1iRTbMRJjNQFt/ve6GubYQDDUfDshPY5JpGfruMR0TeTNTxIXY4z+H+zBGWwWjwHtIKIKguX6ZeJc2tt5zM=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 00:21:50 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::2d) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 00:21:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 00:21:49 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:21:48 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Thu, 28 Mar 2024 19:21:16 -0500
Message-ID: <20240329002116.436824-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329002116.436824-1-avadhut.naik@amd.com>
References: <20240329002116.436824-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7051df-e2be-475c-0068-08dc4f8639f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ydCThkJ7x6fc6NQNVdSoJIqvuxEytzi4KQyhMIQY4ZIJoCHeAh2d3l0+km7NtuJ/NrNwuG5JlkQYWm8WFDFF6KPfxQ43ySL4HBnRsx2xj/JL5rDFwKUgFYAAn4A1fmDl25PjGutKT34MoRQ/Jne4Edh8QsASR1a3bXCzjL7KRKuA1dX3zgD0BAw7bV3BQw9aLsW7a8/M+58SKTUl5qwam0TbDv32j0JlWCZ3ZWSbUWaZySwjKjgG4Js0C2fNlcR6/r2hwmjnoLruN0sqxnISTnaZM1Z9Ly86KFDf0Yhm+jib38YPddoMZJtH8fQOYwFqpUuROq1lQlU+X2FTwk+UjYJPUnhWLNzQdq7UD4xl4JpZevV9TwQn6+Cx0/KeVcsh+EoeTw5GRF940V0GWbSwZq7yNG/lDTH//uGREQD9gxpM6TpkvkYra7aifuR6RXk0eWCd6iFA7hvnQB1bFdvfaCFOMFIDxIOF7+15vquIfYtxYuT7/g/iEHhJLSjf6DhvpTbLp+r1X4TbIVv+osTVmfjdEK5fEoqU7OaCXnnHPNeLtkMsPpzWtqyfzlSorZgKODTmlKVKjFKLfnQl13kJRgm0dnxPPa5a9NmbPDmB8qs3ngZKibyZSHRXK8LNgP/+XQvWq3CMgUOrWmCzoyJ+7sZUa/Bb8nMdlcw2UcpM2RPrsdFD5kM+Flsoimur9xe8HyGxcpbF4bB3dEL5vE+dMU+FF1dOEerTnLyzB4faK1m8tm1iTTOWkG9C2vjkKfjN
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 00:21:49.5268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7051df-e2be-475c-0068-08dc4f8639f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246

Currently, the microcode field (Microcode Revision) of struct mce is not
exported to userspace through the mce_record tracepoint.

Knowing the microcode version on which the MCE was received is critical
information for debugging. If the version is not recorded, later attempts
to acquire the version might result in discrepancies since it can be
changed at runtime.

Export microcode version through the tracepoint to prevent ambiguity over
the active version on the system when the MCE was received.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 2e339ac9d706..c7d0edc778c3 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -42,6 +42,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -63,9 +64,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x, microcode: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -77,7 +79,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


