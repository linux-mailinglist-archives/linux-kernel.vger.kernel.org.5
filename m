Return-Path: <linux-kernel+bounces-157280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E28B0F4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324C1298E76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D87516D9B7;
	Wed, 24 Apr 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bOGiU8hT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBD16D9AB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974375; cv=fail; b=biFXHS7cuAR4IF2zGsWWGBNGxE6RHDnRHw20XO/aK85BYSWeBzO09WcwaxlWxN0lrrohfgVc7OgdTnQe1VkhWiu91W2MnM2f4F+R3AUaX2YShwp7SRrfTzBVAIzWtfc5ESDxyTwI1XDplK4wauQg8n8yhfxNGH9DLCSrvd960JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974375; c=relaxed/simple;
	bh=EnYkbDXFiKrUE1tEngplsbMPZmqcveY0jPZoTpN7QZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2GWwf4wGB5BovmtaEZ3Y73kc459jlCLK4Ycj/dIhhF8ZxxB5fc2jyGH6nWo3jM/TwEdhqtB1onC2QrqT9JUX0PNkehuwk+ArfUFfoDz/h0bq18GgvX3z8IrcUgBecFGPugWmsfHk1HcKecj/KfmDOc5GXPc+9Nc4BhVhJi4PBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bOGiU8hT; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoO4mohY04F2cf2dPTAQrvkdRsIIduMUyfvTrZBlNDiqU+ISWvh3kz4AiPuMC1/nUQUEeezNZNj1QNjUQmg4XlH1PDlldfW/Z0qUp5BUCvtowk6pn40wYFuPE7qWrNjeiIRZ5kV8s8z55gW8hCpRn5vwTVnh3vRsQmmilyK8WKxtP5vyT4q0xdsLtqPOC2TDlAjCKNLGdbIuEmxOG1HvAU7SPRE9X8AXAFvdGgI4PMr8Eg36CV/W7XKYim6dpPLv0S13WIK8BLtxZH8g8bYPrFk34In4lSB1nMb0k3yiSOS2KTXgmKLBEU4xBPDKol7BmJUAjderbrnERdTVgNF9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjytLRT56OtsSgL9H3V29yrzuL7VwCpbjwgjYJY+6Ts=;
 b=JYflXXj8RxheFLqj2uTzStDTy94MIRHwiJb72e9pHao/s5P6TsPAtKmrSOuxfGsFjak8c64qUo+A2whZQ6hXLoBOvuA+CYcAddK/N5l9vulcf424ReK0MNK6ZwAbRJkTmE0W7dEhpQGd3onARdj77guWw2pa5LrHerH5XFnVpZI9TWC5dVFuohpFWcdlUZRusJ8mnsf8Q4nIoCjrdzrEmaeYpD+GZ98CIVv5IRS7XwXtnR2j3e+Iksk126vqrQBVxZ/Is/jXVjHuLN9K9oBAuxaQ6b2djL0lqTuQZeQdGvZAT6OPbPYO9vH/EvssIu9DpWyYjwc4iY+1yibJxta05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjytLRT56OtsSgL9H3V29yrzuL7VwCpbjwgjYJY+6Ts=;
 b=bOGiU8hTBiXM7uyaLwpV2v3jlRSDSuHDSvqz77OKEuN6ap/ghYTCAc46QHgY8nSQccCedMlz8d5rLQe0u8IcRoMFyHcPA7L/Ro6XKpA6yyyj6lN4/lyhl/vjgb/Yq0lSZWJGl0zzxbgyNrpMfwbZ4R51S/t+O3Eo+0YwTiY3wyo=
Received: from MN2PR20CA0036.namprd20.prod.outlook.com (2603:10b6:208:e8::49)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:59:30 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::c5) by MN2PR20CA0036.outlook.office365.com
 (2603:10b6:208:e8::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:30 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:29 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 09/15] x86/sev: Provide guest VMPL level to userspace
Date: Wed, 24 Apr 2024 10:58:05 -0500
Message-ID: <435f78e07c76e25d2d857138724098bc2a729b0a.1713974291.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1713974291.git.thomas.lendacky@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 485ef792-bb82-4a31-8952-08dc6477868c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|7416005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyBQEqLLA69SXXtLENTJbD2o4SNzLk3LKeOS51sNlkSjtT9aC48/AYWJLAWR?=
 =?us-ascii?Q?LTgKMHyKYHW7V8w1gQXIF9792D8+DUu5tSTH6buFLGxUnEwkdMKFEJEkMZH1?=
 =?us-ascii?Q?+B0eoEMBgx1Ka77e8aKRstKfGNA4+uO6ogai6ZfMa8Nlq+sO/HWafI43oUIN?=
 =?us-ascii?Q?WbM5oon86PsOCsBDWzo19IRZAs2B17ol1jzShDKAcOAET4qEBLhkwHrN3XO+?=
 =?us-ascii?Q?/Mht94CTDJDFOui8LHDXJEiNmnJHg2zMmGfld8ghWuMOOFNRFrF8IL0EdVKT?=
 =?us-ascii?Q?pRG/0umtRcQwOWDi9n9y32cntkW3Y+86ZpI5/WLRnW0aQ+bagZ3Eme5Pwez0?=
 =?us-ascii?Q?MjeAlQdlfLO/l68EB0c4mvQKE0Hfkg0DBIOonEioz0XLk1437qHEuiuVMlt+?=
 =?us-ascii?Q?ySMsFHOZpAxf6zJHs396mtAZE9BssBXnT/ZHUnwYvjg4XDQHf8PMSazow0/j?=
 =?us-ascii?Q?SLBsff8ZL8P4tSh6IuX/fn09kqxNbjSghQKjbMwPh/EtCR0aUcU4FazJeiGn?=
 =?us-ascii?Q?eVDoZThHTT+kMHNd3ZSUwBPJtjLH6N7t69CyZ7y3PCOAp8e8t9FWUiZlPZ9J?=
 =?us-ascii?Q?eybL5iGfwJNVv8mYlXaVk/rLeJbBBXeAfW09nR+QmG9nlM2ZrAVRCyGTiSjw?=
 =?us-ascii?Q?JnaOwhWzZO7gPnlgF48w2uuTIvjWBPEq7WU6wOZyEwVExJbbczEKNQ6ftvWD?=
 =?us-ascii?Q?9jAfvfeOwq3R8MIiWod6jSjJmwbM1MC6D+/T29Bgu0UtKio20bY/Ts2qZ1LT?=
 =?us-ascii?Q?i/pDxYqICR+VsXn5M1EQG+9Si+2XmirCRJsgvcu5IDqZ9nBxA8Fn0zhd0Pju?=
 =?us-ascii?Q?agngThnb3xaKnzfuleHlJbRUA2Pk6FyRAEI1tKSQ+KIF3glhjL9LLxBmwJLw?=
 =?us-ascii?Q?Ncsa0DUxigzz9xFuzCY8Sv29v8OyTEjAuWsi+spvl5tDqX2qCxMBdxswMG6v?=
 =?us-ascii?Q?MDe+b45VB8Jamim7s26BP7B5WxmabDHo1H4L2SY/ZIbNZZiavgtjJyvtJ20I?=
 =?us-ascii?Q?PEjkHVSU7c8q9laGVamLwpHLHbG7HQc5D8cTdTsR7fWaDXnv9qdNm36QBlXF?=
 =?us-ascii?Q?fNUVnwkAxmw/uprqj7WLlsTd/bFYT1C/ySHRilKDVU4T86r+CuZtKmRInCiV?=
 =?us-ascii?Q?4/kkPWYOCgg81qDnaGgy5SYSxWYnouXxpxbHmIFrM/BUuPfabiNViSi73/TJ?=
 =?us-ascii?Q?4xrOdlJEVhXVLs1+dDXm/ceq9gQZQ0CMJhiRlZLvNH2QFO3ObuRy89/O6WE6?=
 =?us-ascii?Q?S+Tls7BNbROaJ9Vhmy8/zemsEzc9VO+dRiGSxoxyxewQzWN8rMNskp6UDql0?=
 =?us-ascii?Q?DKR2jNWEcMxDKWi7hsDGEDP1o/I6aRaxC1Z8OxzuMnQ3c3hC+ocr/X5EdU7Q?=
 =?us-ascii?Q?1IpO+nrAHHTgFHZQQg2T4ihYuKW2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:30.0542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 485ef792-bb82-4a31-8952-08dc6477868c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

Requesting an attestation report from userspace involves providing the
VMPL level for the report. Currently any value from 0-3 is valid because
Linux enforces running at VMPL0.

When an SVSM is present, though, Linux will not be running at VMPL0 and
only VMPL values starting at the VMPL level Linux is running at to 3 are
valid. In order to allow userspace to determine the minimum VMPL value
that can be supplied to an attestation report, create a sysfs entry that
can be used to retrieve the current VMPL level of Linux.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/kernel/sev.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 69a756781d90..8edf7362136b 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2507,3 +2507,40 @@ void __init snp_remap_svsm_ca(void)
 	/* Update the CAA to a proper kernel address */
 	boot_svsm_caa = &boot_svsm_ca_page;
 }
+
+static ssize_t vmpl_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", vmpl);
+}
+
+static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+
+static struct attribute *vmpl_attrs[] = {
+	&vmpl_attr.attr,
+	NULL
+};
+
+static struct attribute_group sev_attr_group = {
+	.attrs = vmpl_attrs,
+};
+
+static int __init sev_sysfs_init(void)
+{
+	struct kobject *sev_kobj;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	sev_kobj = kobject_create_and_add("sev", kernel_kobj);
+	if (!sev_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
+	if (ret)
+		kobject_put(sev_kobj);
+
+	return ret;
+}
+arch_initcall(sev_sysfs_init);
-- 
2.43.2


