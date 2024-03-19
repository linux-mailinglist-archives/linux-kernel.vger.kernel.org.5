Return-Path: <linux-kernel+bounces-107493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269B87FD46
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F53284028
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB07F7DD;
	Tue, 19 Mar 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VoHAIdJ9"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610C7F480;
	Tue, 19 Mar 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849655; cv=fail; b=jxdObHRpwF4Ac93Kf0XintfUb52FUOMTCiprRhrMIngjS1huOWhpONv1SrNhGdXvA0RgqOdt3nRq3OLzaAVP9kKXIcWKn0AiXmjy2TiQsd/OJuBnz83RWHE0LC8eBeFG0uEH2R405J7J3jGIWqnLpbXR1PbeH4Fr4mGPuXPqjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849655; c=relaxed/simple;
	bh=jXOOtK2+vCx6xjiIExgzIAHy/1O++JBXYB0f8C05tM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSWm+71At4X7MxGarfgcnsbpWQaNmFkpBzAn8LdEIiJ1D8cEcSnriaCxyaL8wyGOvzBBsfjk4ot7y42L6TtuLfaRAS3zhmmds2xjbxF+IVpO/Tql2mJdjzG5ulUAZ9AIMBn7G0YU38Hv2UFd33GK3xrcPOMCrRnbRSoY6h6LBVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VoHAIdJ9; arc=fail smtp.client-ip=40.107.244.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQrRa+jyG74MOx4tsxve9kAIVgwAYJAZOPdPos3Ir9e5B0AdJ0NtPDTwPkOEFQm9K9YAqHAQ2sFeDbFrMw/ImBvyrpKTXlYWG6F/wjDmps+cJqX9SNFh/rUOMsYK6V1kpS0X8Ui95YR9J/H423FVO0/HxwJEuJYw84QTh09Wqiys62VczvyhjBgxsZSjPOyCo5E547QsfiN+9UOuAF0iPiU0qRtWy7p6LlgreT8J9OayidrsdoXr0jYZko78hAjCbqEL6A9ioebEZcRRsLYOIjjDKOzgGf+iaDMCMYmG21oHEJ8c0i+wwIf3nMiDvHoWc69uUoOnqSrnH+R4TrcdLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9j2IkI+5IZXKPenT2L9vuY4Na/KtvP6/SeBk0zyXrU=;
 b=UAU0ByhGNV586gjBspHreDOj7Hbnrt3gVR0EZMSPPuLiSPPvWCdFpIsSvxPV27RjRyGg9ERQ0IGt1iaNsrW1Crh4MPZ9ss9dl9YvWXxKz+8qUPvRjH33CXSmfuZTsX7BwjLNaKilFZJfyOVZ/r627pFv+DEn3A538nV5P0HWBabgwuPOgwwgO88/ndbLrsVWtwAQ2xozG2d0feVY0e/FOFrmPT/0H9ieHZTKqZHE7u326ZnLP3+i15UcpKu/Kq55d9arJaCRCZ1SgPpcsgwxu2UirWk9SoIWwb2UzXq25R9BnRZMQ2HO64Cw84GkRyKijA8BJIPdc1MeoglnEu6i+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9j2IkI+5IZXKPenT2L9vuY4Na/KtvP6/SeBk0zyXrU=;
 b=VoHAIdJ9Mjq3JHQ638QJthgQtCeP8Z+pyc6lyIoQSuuYFKo/d/kxK7ykUlkmGuQPsqr5ifr15Bbcfz8nafOFacd4NvblJLrvd9D0YJB/T0wa6GB4a5yTcjl1CyqwTD4dahQI8c5Oyi88wWfNZgr2vLqxTTxyWPKD/OExBq9LtwI=
Received: from CH2PR18CA0050.namprd18.prod.outlook.com (2603:10b6:610:55::30)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 12:00:51 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::2b) by CH2PR18CA0050.outlook.office365.com
 (2603:10b6:610:55::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37 via Frontend
 Transport; Tue, 19 Mar 2024 12:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 12:00:51 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 07:00:47 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/3] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Tue, 19 Mar 2024 13:00:23 +0100
Message-ID: <20240319120026.2246389-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319120026.2246389-1-rrichter@amd.com>
References: <20240319120026.2246389-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e168c4-7a82-47b1-0dbf-08dc480c3948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AHeDJpDiWBzuva+pX4jncPCZsSRga4SDefDWpg88v1NQAlsmIgF1hGWVCopDyghd/g78yxj3M5g3fdujGOBhFyYK47pOh1t9vrOjMg2x+RB4NSO7Ncn7/yRM6BGtheNJJQyvk5etwNJaR3mOqn7w+/FMJE5+WNKOqBX+egTJqu7fXkk4WmNJw34i2sL1itHpbAcGQ8qSlS/MWTP4n3MqdzWr5PSi46BN4+CCBRun9b54k8i0dr4477Z71Ce/6KTJ0RCInWG/qe6fzsuNNpnV/Wac0SMq0fxxbzvNLfbVBTyv+0AFzb2zeASWKpbGZB8u/TyCLWaGDGqT3idMZGIgcCSIuL2iY43rsJ4bbmqkfUEf5KS6Fp3PEqK9JRaxaJKDaWLPROt2y1eSG1EaYWIhEq/8lpEYC6kEp4LT4jYC4afk4URDaFYRaBPUdR441mWrz/JTpkDkLBXDWlfoPoe7+QoXySozTHzHN5WvuYCm+b8ONqqBMfvRAV3Qw74uJ68k5LA0BQ7LE1YruCNfVmaqERYja3NJCej0Lo42Rz3fZizFhHtYs1ko5B8PSyEMpe5r1gAdXA4fI4Gp/mHl6iY9RdBlb+h1X9NDsMYaWJKzes0vdfseuNcvoKyu4/ArR9XF58fOs9avUC9siQODxiLY80TgAiTI56GDg+SjRSJd0slx1Ak87DvqxfViHdmqGUbREkvrlusk2XvfMjR49bd0APWcHf0tRes0iEDxl9p/tbS51oG+WBwKKvc/jBhpHtT0OUfta/l1ljHj9hhRaSSRug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(36860700004)(376005)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 12:00:51.6973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e168c4-7a82-47b1-0dbf-08dc480c3948
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249

For configurations that have the kconfig option NUMA_KEEP_MEMINFO
disabled, the SRAT lookup done with numa_fill_memblks() fails
returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
found for a CFMWS address range. This causes the addition of a
duplicate numa_memblk with a different node id and a subsequent page
fault and kernel crash during boot.

numa_fill_memblks() is implemented and used in the init section only.
The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
be used outside of init. So fix the SRAT lookup by moving
numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
always available in the init section.

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too.

[1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 arch/x86/mm/numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e391c0..ce84ba86e69e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif
-- 
2.39.2


