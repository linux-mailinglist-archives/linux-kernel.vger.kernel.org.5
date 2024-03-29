Return-Path: <linux-kernel+bounces-123945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2E5891013
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BBE1F2410B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C492914A8F;
	Fri, 29 Mar 2024 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tb1T1+3R"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AB12E48;
	Fri, 29 Mar 2024 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674517; cv=fail; b=tlbdQG9BnFoasBy3JjpSn9Atf6V/5gbCY6w7CHKdPteOZsRtylg9zOYyTSvfXyBD2Epk5ZWmPEfFDwAWhk5rlT0ERC2dBNk6s9ZzCQzY9plGShWuhrnKriK1y8Nfg4rHDuWfhu0zoeYxY/r9hro/EW1D0TekM4d2hxoQTrkthP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674517; c=relaxed/simple;
	bh=uNLT273ei5F5WXEcFnGe38XMPHSWtJMP3hSUH+lYJso=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMZS3WfwQfGVwDO92hJE9b2yBCGy+QfTn0sc1T0IShYYbuGcO+c5nvpwhtK1naYTy3SfRpV4VOw4kroZBIw8lrOUbwW40IQN7RAYLZcZJYZGweL3xvJSEmR1H48UCJfYVWLUe0/3sIkKie7+7s1NMPTmEJjsRt2kxLZfdDhTFL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tb1T1+3R; arc=fail smtp.client-ip=40.107.237.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQmp1NeQlJhVloZHAknHEf6CJwfZ9Qe6PyfRG5DFMzdHS9QoTiIF6aKIweH7r7JJ/Q47WnSL5IuuYuKzwjsT/7XPlbLS7mZ2bQ7wjybWtFoFQKKcAGIhqWOKyif4yE0agSvGhhpXU+UYwQkou4gcEUwNLk5e3RFvUyivSGXl1PWIYcUTfNGxeiFpJacsYqsPSJ6lekFih8y0ILEqpV106w2PxUtGtbqwfA6en7i6d4TxOygsL0jmv24EJ7DpSIKBKmqetW8Mq7bcfR1m2rnwZBpWSOMB6DnslCvEX5sP28Fg1TOk/U7WI4UUr6tMKe6SwigKCiqTWyVl2/FBxPLVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9XA8c5++shykdTd+fjFtLyX3ZiXJu97t/f8LD8+RRA=;
 b=gJH6SXG2NYmDrHwuqV7ZR5ikQfHzHqDLYWIpZCU+FsylruSE5Crd8765bYu3VJich08G91+0Y6URABABUjfB722tQjvpIPCMKHi6oO5KQoc8uIVi7yM1OWdmH1HUudQ6zJRknVLRlLBR147cPfWc5EhCSAq0XmLjfNJn4MR2qdht51cNVVvfSyDrX0ZF5CPOna9sKf7VnSJUFUoVvL1G4o8PTKWPsu60yYkQgd3P+JG6DjdcZx5AN7DsWs1IKgkPVf0U7CG+7s3L8pSsjDe9Y2lE7R2fyyDvl9feM9+TWhRF9SsCWdiSioJaGubOt6OtCqHjO4wffCjP3oKFp20Q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9XA8c5++shykdTd+fjFtLyX3ZiXJu97t/f8LD8+RRA=;
 b=tb1T1+3RXpgcwxQh5KzDGk7OiK37/A+sJmgMtycbOfCfYsh5REbKmoRg95l/xZlNan7pxgGGQlmArgfKdo/lD5VY0f12rsSG5r2UnV9M6M5Ndp0CeVlhEZQIPJkKZ/vqtrJmC4O7WDPzgav/KwPp4y+s3BEglNzxJoQw5wV6mBY=
Received: from PH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:510:5::10)
 by PH8PR12MB8605.namprd12.prod.outlook.com (2603:10b6:510:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:08:32 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::f2) by PH0PR07CA0005.outlook.office365.com
 (2603:10b6:510:5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 01:08:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:08:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:08:01 -0500
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
	<eranian@google.com>, <james.morse@arm.com>
Subject: [RFC PATCH v3 08/17] x86/resctrl: Initialize assignable counters bitmap
Date: Thu, 28 Mar 2024 20:06:41 -0500
Message-ID: <d9fe6638d901791dfdec26caed034179c636e17b.1711674410.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
References: <cover.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|PH8PR12MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dce4207-a587-45b7-477c-08dc4f8cc0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wwaVqX/l/uzzFmfIqp6KHS/QNtzEfKTyuhhBnmjsbFB4usKWke3PA3wQ/04DwHCr6jIrbo3hduDsjypf0km7BFkQ4h7rzF2TlV6cZBPADNqbHuWeYpTKGh1yyWs/JfpGNHvCvsmggxgNgKZKFSK6jHxguybJiVG8q1Mfx3VhbRz6OZ9sTA2t55pU+GJsXzcBDJYWgEx/jV3mbU2p8bsOXDAK69Fcdi2qxj6Z1q9X542g5mrm9aMarnZIMUArzMilGR+V7bZAzWP0l1vmBFXANtjdQ14sMUzwbzF63RZXvIJS+8byY1qFxTWQIpp2m/mwebnZcCTEpgRG3Eadze7xUTxZHmhyoEkzNJlE7diZ7yJ4Ab1WhtQVZR5o7HAXWWbke8ohGDaXyB8Jgnd00Avwz/KjMWqDkCCLZ1nkZZ9t7avAOA3jW3+WD4pdytEcGq1IemTHFYykDm+i+s7UQynBZ/HUnYy6k91PsWpbHvgpSVwy0VTvZHgwHC3PnesizKfG9ag6WDQ7QROnGwd7d59JHl+8U0yMsJqDT2fjrdpENtPpa3yOObX6BA/JVVORKY8rDl01CmSkiYO6wMT5cjB2kM4RvSSv/Rub2axgpraMwDTinV0igbzyMqv633gfWn261nvyOuvZvBAMTxN2t2Sma6b8YEFfSH72BIPkUFTaqDi75sGkicx9WnJFzdFgeU1XlSSGMBIxMokRuqz3k2wtqs2uGu3GNTJL1EKOsPX+Ox5EjkaFMLlV7cPHACkVHvt8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:08:32.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dce4207-a587-45b7-477c-08dc4f8cc0b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8605

AMD Hardware provides a set of counters when the ABMC feature is supported.
These counters are used for assigning events to the resctrl group.

Introduce the bitmap assign_cntrs_free_map to allocate and free the
counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v3: Changed the bitmap name to assign_cntrs_free_map. Removed abmc
    from the name.

v2: Changed the bitmap name to assignable_counter_free_map from
    abmc_counter_free_map.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f49073c86884..2c7583e7b541 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -186,6 +186,22 @@ bool closid_allocated(unsigned int closid)
 	return !test_bit(closid, &closid_free_map);
 }
 
+static u64 assign_cntrs_free_map;
+static u32 assign_cntrs_free_map_len;
+
+static void assign_cntrs_init(void)
+{
+	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	if (r->mbm_assign_cntrs > 64) {
+		r->mbm_assign_cntrs = 64;
+		WARN(1, "Cannot support more than 64 Assignable counters\n");
+	}
+
+	assign_cntrs_free_map = BIT_MASK(r->mbm_assign_cntrs) - 1;
+	assign_cntrs_free_map_len = r->mbm_assign_cntrs;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2459,6 +2475,9 @@ static int resctrl_abmc_setup(enum resctrl_res_level l, bool enable)
 	struct rdt_resource *r = &rdt_resources_all[l].r_resctrl;
 	struct rdt_domain *d;
 
+	/* Reset the counters bitmap */
+	assign_cntrs_init();
+
 	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
 	list_for_each_entry(d, &r->domains, list) {
 		on_each_cpu_mask(&d->cpu_mask, resctrl_abmc_msrwrite, &enable, 1);
-- 
2.34.1


