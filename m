Return-Path: <linux-kernel+bounces-122000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D550B88F084
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EC3CB22EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C3315350C;
	Wed, 27 Mar 2024 20:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lBbSzVts"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59854153561;
	Wed, 27 Mar 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572908; cv=fail; b=eRVGvVuzGoFh3swZBUNSut9Vtdhw8RfVEd2i8Sgseba9H+hNqqLs3jrzPqsJ7v3B7faPl8dSquJpzc+xy5Bs3tRjesj4hh8EGUtOP/Jg5jVHj3dptj9pwz7idWhNEN0mMTbD9wGQ2kZxCnX6tZiDLQIFPT8tZbBJm0fDYELw1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572908; c=relaxed/simple;
	bh=8RpQA8foPNE2QriINbarsHK+OkpWVrYtCL5V5xWHTro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmaj1wmnUg9mECtcdhYbkQRKZ8uqU2UurgJCAGwJHfWX0kaQMxUgtXmhuZ9YuBg35DS3tySMioYKz7KP5L8Pgo0bjWL79lbX8isv5qwCktfRRNnRBR1jIgV3mW5a+C8OlzimNBYB8fXv4sQ53+NrMoPwoe1jJjeSqcHWV4/mITQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lBbSzVts; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpVSUf+YJakVTcpcIFyhri+l1nmCd0ohSljePHnGwrLalri3XClmbv2mh1hC/PdyUZtiVdXctkvN77K+jMJg/35cQh9JGwyCFmI44vTzxsS0t5VPweuISpy3DiiDqKcc7pOguAW50fTpHesDmCLSKZRw7FWWp8gqtnKknRdKM7c33vNxBkvKyy40O4unpBCNRacIIjFxlF4iEM7ow8mnBTQiJgRhpiCIVEvNOaRH92wGXCgrWgC98aBr8c6ml0lnUsmuoaBQ8W+ITLoEfFgi/A3TsU9zvOzytpu8ThBH2Q1Fi/l+jAtgcdLwdahE7o8d5UShBgnY5BXzr6G30cQIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUE6ovOYYVdpJAGSJQEV1/fec/DEOPxjPWLfNSfKkdU=;
 b=gtztbzQjwuM0KnGSsmsXJKiqquC18e2A670jwLn8t4rFcN+xQH3SPr7WCANKjAWLoF/s8+oemWIazRqsGvM5zO/bbJIYbZ8Ot6HYwUMJ47qoeZXXohI2Tjyw0/GxKT/uMxC3f9PpS+D0QfgS/uVWYVCycq5F/VLxBEKneZwtD/y7xdxNKlwgNnECtJp1UaF4/TijMrJgpGCFYmTSluXP7DtAo23qOigaZmG88F9NgxFdGSw+LmMgRQiJvG/eYXUcQo0goTOb92VKkorHreZFjxc4bdPr2fmxkxieBfcpYX7BGBZy2r5SlMH9O/eiiQ6otpfi8Ks3B3dUuoWHIYoOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUE6ovOYYVdpJAGSJQEV1/fec/DEOPxjPWLfNSfKkdU=;
 b=lBbSzVtsOwEGFqPBDR+K3rjBvxedxiBzpYlYHYKa/ZEtaG2YBXdiXIGVXZfWvWsr48s5qSaQAorE5dwdLyRvfH9n5oOWwQJCh8Vfow+NBxbBy1JNK6IXM4J9dkON3ojuESLjEGXtNr3FawCLCEX+sprDpwHClDLIV9sSuMrUVCg=
Received: from CH2PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:4e::12)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 20:55:04 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::81) by CH2PR02CA0002.outlook.office365.com
 (2603:10b6:610:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 20:55:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 20:55:03 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:55:02 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v4 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Wed, 27 Mar 2024 15:54:35 -0500
Message-ID: <20240327205435.3667588-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327205435.3667588-1-avadhut.naik@amd.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: 12bd9441-78de-4b24-b799-08dc4ea02d04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zkYQyjwUgaQKeNgLQzo/19CoNCwC9XtmJ5GATrYENc2Uv40eFmZV/N27ArvJOJW1h2PP05bCSGA2ZhCfBSzWWXWnMfjrFsf2X1hZ0J5uZ1sPZh2+obHWvFpUpL+2gw1NopsR66KLpCLL8oLiB/0KiDQhhB1bUyWGEpAG43VS7XU+dP1ITw7HElkqVV6NKwCHPkJ6yCIbMWo0OiK1AiLQG3PzhhTdVEqE4BZh/BiINwvoiV+z770NtzBHYEXANOPkN2s59Q9aXk9oBKyFz8b9+7ZMo0qbkK3L6MGuGmFOldjzqfRr8hXg99VHADkLuyjZ3gKx1JAuxtTulvs6fILJ7vSjHvCOThZJtz3HILW20Sra58eYluipfBS+EONlJdheQ9XTMP+WRFiRQJmSVmccZYOhqLOOKwWJaLnikQeIqyIeWW7LIwVZmbW/MkhpMfyLhZO8prPqRwIcPQN4V7mqCC3cx4nFlzn6hTTk25O8pr4PPOLCYmPRNxYNrJXoctFeSAU2M2kkqsogqtPATC9s/GVRv/IrJrrB+iJNE/jxirdZ+R+W42F0GnnmloIq0JRhQ37p7cItv5EnlFTiCZYKmAwKF6IZ88xbBhe4VA6Z2jcp6YpkGdFdOyIfuvxQ73lOT/yIypygo/p1AiQ0XwpQS3bXHxh2J99PMA9XgLkBVtiQqFbzA7WWqswRvpfmsMjlt8+P3rgCiRxLPXTchTzlG5pCHxG4/sJfP/rOPS7LrpM1/3JbajGCwlLwdsIyNuae
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 20:55:03.6316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bd9441-78de-4b24-b799-08dc4ea02d04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456

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
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 959ba7b775b1..69438550252c 100644
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
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",
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


