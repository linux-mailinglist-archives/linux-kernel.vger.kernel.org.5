Return-Path: <linux-kernel+bounces-97466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC87876ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359EC281CD2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105995A0E9;
	Fri,  8 Mar 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xK2aGD7J"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7200F5A78E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923006; cv=fail; b=JXBeUJeeBIcWHP9qTC2/UWfwnMdrRDOP+jcYqE5nHd6igLgsgEVqZA0vsIa1AXlatxFDhuCQtbwjwfILrWEd7qIargIonnHaPTwzJG1+IeTsG0AQwe8bzbKdslv4cb1C7ggt8grBoVosawrxuWFuVTmgYMMG3oZy90olNxEjThM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923006; c=relaxed/simple;
	bh=1aPLgFaC2hJgrjvGt5Axn81Uu+QPk1dtxCEYgf/R1dw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgN70sYwJFo8XT7d9BrRSLd0hsdXbflN3AAWBUbV1sZV6RJNchYMm3wqUq1PFUguAwRVp6pwvEz6OA8ZKkcXPZXaf/infbqNkTguIpwiUEkN25cg4injmUxADtjx9iig+/cLep5izB1kwq75ZbWjFoAsMbXBvSdx8xXNYmw95vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xK2aGD7J; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0u2clySqZTkyBjTm8Ti46X7BXeJlQyYnyIncouYKz7CA0ioV95t4exIkTSXEaguAoa60QcdKAjBRLcPS68uMInkXwC5R/R74/y/yXiAnBfang7pa168hfOPV7KNPNDUkH6hcnPgepob63GARYG4pPpEcsdXFz9qwBEpM3Dj1JXycQsIOSEZDLwR/Vo0nsH7dWWJm4QZ0GlIZZxrQyX+9t72uDVv876yQVc90uw25I1yDTTqYvhvc8eKUjCJ/FHERbFlNIGtRna1xKuPPrwLyKDwfLujOyj2sn1ZExEhP2qwj9RPpeT2J6h43ipyJUKCPfNJJbj5/lY5wFKAUC9Zrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0R12GO3P31KRS8kyZeOT3vc49QckppjxdbrrAeKOCGo=;
 b=Mg3OePjKvxlC2rExWL+Z4qcmp43MxhxJlOv0zI24dMjJLTR1PO8dLFchmU2C4IRvY39FENskxERbTRr5SzadYURMuqoloXsmT83asLV3akQNV9dFOI496hBulMLjpBEqJtDZggrbpK9FxE0l1CbNzM9vY98Q3m+UPvpso3WF6opJO4hjebtLtbp0+Ra8WLRXr8LxeFHuK9zkpD6rrjsIAFV6xHjjN1ZBAmojxM0DsTRnoUicGcr0eqCOAXprpQazCQdD3cWcQ1OCdQa6UmmHSvvJ9Nj8mM0jbnl98PfFN9mz+dEvYq1ksNEnkvDc7I65BfUYernKa7+vln4fDx37aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0R12GO3P31KRS8kyZeOT3vc49QckppjxdbrrAeKOCGo=;
 b=xK2aGD7J+O2dGMPYyxbP3c8IUKTCTy+GWeIexPAK6dZiRna1uPNKHZAvgeb2flTAVxTJldmaHhnffW7Ffd+ebuh0v6YAuFyAYFLknCHQ0m7cnmZh77dCbPUrTAfg4HscOZBYjJdBxQLL+QnZvpzARV7UGhq1QyJcK+HFF5mJRW4=
Received: from BN9PR03CA0476.namprd03.prod.outlook.com (2603:10b6:408:139::31)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 18:36:42 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::3a) by BN9PR03CA0476.outlook.office365.com
 (2603:10b6:408:139::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29 via Frontend
 Transport; Fri, 8 Mar 2024 18:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 8 Mar 2024 18:36:42 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:41 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 08/14] x86/sev: Provide guest VMPL level to userspace
Date: Fri, 8 Mar 2024 12:35:23 -0600
Message-ID: <64d95521f3be31025e75bcd72b20499fb8d93582.1709922929.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709922929.git.thomas.lendacky@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: c543dc49-bdfa-4b37-2936-08dc3f9eb31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2yO73pAwevEhVlv6hEMoEMFX5uU8gWNQP6sO9rcpV95NSaPJy3UGKCD4G3BmUoZ0wKITbF9wQUvP75ZUY8FtdNlFNU9j1YBM6LJ7sxlg/LyvbmmVxuQHeWYsVG2v6dABVX6UYMRlKp12eLy8vefraRbGz+dJehTCf1M7D6Bcl10xD3X5GzZQG1iC51SWKPY5iWEM7pMLIgCiOzAUq2oVk05C86K6PNvspDTC40ox3oqc8itNxnshRo+AHTgqCmpIWzh9v0riCDcLEIqv+fb0Hqt7PcmOoFtXouisfj2zHVGQNnCooSz/QAt2QWyM+hOSZPcp/JtawgEMlf6biv4ruwK0Bx5BGuhyr7nCRDhatSqJR4yUsc3gKQCugJ6zGwTqV9/AYkImMIZSFZTSAr3O1y7snMj91dfShWdmXfeQMrFDLnto1N8Nd5JwmAaD8/lEaEBfEGoKRPcy0OZBywK5JOJju4ETQucKFj7RDMGSVB7XhqwtEAAa6JdAD3jukirvAxcGMIFWg5kWVKYlCY6G7S+FyWRSNJrTsOp9bCJmNdRp0WhO1hVZ0dfWrzbGdK2WpDVKkZ47vflopRIwjCUgD5bqHr1ghZrI/EEi+ndhxHPyEeyah9alVXPlIPJiXfsUmo4VHkgEUlCm065mDkkJTYkZJWCxwCibG30GwJGdEhE10JpteJr+o9Gj7RJLxnlFNkVwu2C1Xri/fnhh6cjKTVu/QGyZdjDykRH3rRlI9ez7ZIVEMkFcPqVufKbmAHJs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:36:42.1648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c543dc49-bdfa-4b37-2936-08dc3f9eb31c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372

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
index b85f1b455eb8..807bd6ea8d85 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2529,3 +2529,40 @@ void __init snp_remap_svsm_ca(void)
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


