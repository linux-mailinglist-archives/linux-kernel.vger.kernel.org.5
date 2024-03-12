Return-Path: <linux-kernel+bounces-100688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61B4879BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454791F2333C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A31420BE;
	Tue, 12 Mar 2024 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6fSaf9A"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DCF53BE;
	Tue, 12 Mar 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269295; cv=fail; b=ZE0Rrahc6LgL7I9AselQsQdxvQ+Eh0sSxf5mGP/op3ULnfJqtvWmA+ksK62+Z6a7BYoqydQierYHtSiKJKPzJhWQnWZUhF72Q8HoLaUzDW692zWrUkaiQBCjwT4YErbTWnqUEj2GRyRnZruhQ0glZaO8/GUtzcuf+I5YzD3Dc7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269295; c=relaxed/simple;
	bh=E0gFdJbkwHxJueY0jL/lyasnBUNnQs4hX2Q2YyqPCNQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jJPy+2HX3awiaOyOyHcQIOlgVXoWDXh/rhK+xfJEpeaqqZ23fTAAqTVdbqwgdrAVYk3HAJ4dJFW6hfnkI3sHL/+luR/aBWAzkE+uvNCi97VjQYkRLvdr6DTMO2VpCS13T8Ug+WyFnJ0tTecmbCiuwAM3JHYZu0Rz5D5gEefkYfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6fSaf9A; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blOkG4qID/cL7V2dBnnI2yImkrMGMqNcjz+W7MsTtfkyyLTsCFYYJB+XvULHLE4Sf6AsA+Z1jQOU/kg/T26ZFrf0Jq6Sz+5Wgi4mSM4xAOTywYAYCeXfGliMsnvYPjBcoueQ710wpJ8ho61sYEqWuZv7gJ5DSIIxouzrrXcbS0Vm407kSd/Kjp5XEse1t1EPTgEB8XSwrYrzdMDAQKy1/BZLGjTV5odoc4iIYkfjfpLSxTsnqXxJV9sZVhWBHjvmsIl0wI9FvyrruwAuWFYkdBR1IEvNOb1K3Q43B/nVOEGQuQdMth6reV/EwYZFFPLiXWM2sX5kK7EM+M7hqHA5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bbJ66jgaqrM3B7DxB7IPh3mgOWUDhaMW3WcR/w6MNs=;
 b=al3ZYjJ3zqpsh5as0CQR+WLTI2wEYLsepCKaxRI8hP9z6Fapf6YmaLCa8vE3bWyxS4MRFOssmuFIxVNOdaCriBIEz815zk7il9ZteIZRbg2eplg2Htopf9xTvAXTCnz2//5q7Qo1zK+4tkUQobmfOCQNXjm83wC8ILyQS1UHZphxCjW1Wccd7bc963yZ+9W5YOgrySn+gKYHxdRlRU5wduqVh8rXpB9Q8cTqihgNe4VCdv/c9TAYkt/Xza19Re1J4u2gFWcUO0gLSSX2L0MKyj45mh13TmVv7S6TU2uLnJoAK+2JZp9GJG3BBYsacrbZO6Tf0Gs7wFfXEROVjH5i7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bbJ66jgaqrM3B7DxB7IPh3mgOWUDhaMW3WcR/w6MNs=;
 b=g6fSaf9ApRPmaE+/yaiwuAspNbr8hboZgsDvEuiy5Kc+PHp265h54IOiTj4WMtPINY2GjMDnnk8uGPq7Kek7gnBfLta36fZK25USx94U1hcchNszr3XBjmyN4JAKDkmHZFbEkkh1gtU/WE3fXsZoWQdlR6P7Yr0B5NE9nTncJwY=
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 18:48:08 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:88:cafe::7e) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Tue, 12 Mar 2024 18:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 18:48:08 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 13:48:07 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <bp@alien8.de>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Date: Tue, 12 Mar 2024 18:47:57 +0000
Message-ID: <20240312184757.52699-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: 76f8609f-e4b3-4a2e-66d0-08dc42c4f5a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLDnZQTGvWtwbbQlhE//0KsHBRXqI1pEnTADE/NjBG22NhMNrqYzogpoiabSvTE3Yon7adS6bv4Z8v5oeqJAnP9xWIfTQfI0WJ5nGt9AO58/Bq2iSnXgsv96UaYTG2XTpGsQjsk8LuX8yWYkYWPJfa9tt1iTRhKtH2jtOh93vCkRbh5im/hYUcm94F+T0nxLd1DvBdxN96+Xl7S7MVVCLI7tWwE6mtnCtNVnwfEA94rewRZGaPqPLADPDez8i77vLd+8nqestGo2DmDFG5Tw4M9ETl4TXLRCXaR0N6JYXPfQjVbrYT/Zi2szhkR7mrVi4OtV2i4zWY3OActATDbSMrn7hvXz5D2VHq1mj9fBgH+JaUXvua6TvrK3LvnIe2U76XsNPsy/ZjasErj4pQLWF8cxO/xwLDsjdubwDl4ZBPnneGU+jk/6w435+Pf99qmMmkS4kOdLHvVajS2MdPovY460JEeKgINdJcCjIrlIk1nKjwo5wT5eYcRQ5tcse3UhboP4mLw2sLVOm7alJXuQ6PGKoYdK0PQbkBtblS7SlAGnssc0IpbyhTABlxglexeBxNFjnPPmNSvmuuXirot2qATpglBJijCnwx/1ehMdIt7Y/iZZxO5ow4UArBuq9qwhzAo3GPPCsahaP6RF9He1wYV4CcSmdsGuz6zgVV8RCN0RVTjUFUxeIsIS0vQwSg3gAGdYhDJD/2hxdy9k37o+2sm/6+B9/X3YRbVtmEcd9oKPCFECgbZb6iwlT0yfcF/K
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 18:48:08.0526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f8609f-e4b3-4a2e-66d0-08dc42c4f5a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160

From: Ashish Kalra <ashish.kalra@amd.com>

RMP table start and end physical range may not be aligned to 2MB in
the e820 tables causing fatal RMP page faults during kexec boot when
new page allocations are done in the same 2MB page as the RMP table.
Check if RMP table start and end physical range in e820_table is not
aligned to 2MB and in that case use e820__range_update() to map this
range to reserved.

Override e820__memory_setup_default() to check and apply these RMP table
fixups in e820_table before e820_table is used to setup
e280_table_firmware and e820_table_kexec.

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index cffe1157a90a..e0d7584df28f 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
 static struct rmpentry *rmptable __ro_after_init;
 static u64 rmptable_max_pfn __ro_after_init;
 
+static char *__init snp_rmptable_e820_fixup(void);
+
 static LIST_HEAD(snp_leaked_pages_list);
 static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
 
@@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
 	pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
 		probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
 
+	/*
+	 * Override e820__memory_setup_default() to do any RMP table fixups
+	 * for kexec if required.
+	 */
+	x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
+
 	return true;
 }
 
+/*
+ * Override e820__memory_setup_default() to do any RMP table fixups
+ * in e820_table before e820_table_firmware and e820_table_kexec
+ * are setup.
+ */
+static char *__init snp_rmptable_e820_fixup(void)
+{
+	/* Populate e820_table from BIOS-supplied e820 map */
+	char *p =  e820__memory_setup_default();
+	u64 pa;
+
+	/*
+	 * RMP table start & end physical range may not be aligned to 2MB in the
+	 * e820 tables causing fatal RMP page faults during kexec boot when new
+	 * page allocations are done in the same 2MB page as the RMP table.
+	 * Check if RMP table start & end physical range in e820_table is not aligned
+	 * to 2MB and in that case use e820__range_update() to map this range to reserved,
+	 * e820__range_update() nicely handles partial range update and also
+	 * merges any consecutive ranges of the same type.
+	 * Need to override e820__memory_setup_default() to check and apply
+	 * fixups in e820_table before e820_table is used to setup
+	 * e280_table_firmware and e820_table_kexec.
+	 */
+	pa = probed_rmp_base;
+	if (!IS_ALIGNED(pa, PMD_SIZE)) {
+		pa = ALIGN_DOWN(pa, PMD_SIZE);
+		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		}
+	}
+
+	pa = probed_rmp_base + probed_rmp_size;
+	if (!IS_ALIGNED(pa, PMD_SIZE)) {
+		pa = ALIGN_DOWN(pa, PMD_SIZE);
+		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		}
+	}
+
+	return p;
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
-- 
2.34.1


