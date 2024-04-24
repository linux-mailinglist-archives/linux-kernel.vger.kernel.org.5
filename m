Return-Path: <linux-kernel+bounces-157285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7658B0F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420BDB308B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1916D301;
	Wed, 24 Apr 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="te6UTktb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BCC16E867
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974403; cv=fail; b=u1AyMPxRXV1ZVKcsb3z0eORyEFbZb9NWknSSp5OkXhfZ6ntFfQxKc4UAJ/yi5bsK3efG5NdhMxxhLlGMiuQ39tLKh5e5cXytLl3fq1C4m+aUtoEcMw74rwnjkq+Fa3PoKJyWD6ntlEmmDyuHARjkA6kUY7PPCSq1MiyHWCGs/VM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974403; c=relaxed/simple;
	bh=wy7aDX8tf+ati0+pYqgMQR3JQYi0YlzmJAMDfkd4X+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li4+hQW21VrGvaZjkUeh3T3MhmCuTdNIpD92CrX7GPbB21FlAy21AiEZpwVC5Sow+Zn9O638q9NrH7c4a6w6J/N9BFfPBV3SAgBZq5UZwz8XZ+K5Ewiob3AKsVaNuaIA5ZYuU1vgjyYtoTlCG2bAk7fKWWIddjz8YlpcGfUZupE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=te6UTktb; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvSS4RTCCO58GeIXH+Yj5bj9wrUOVOz/GGGeowI5Bv0ihx/I+rUVhRJyQrMkRLY2DTJk513M3Off3wfD+1ggosfhea9dQnNM//gShF/qlm22kb4XeZASgxM4DvQE5YMFo4i4buRpOuC5haf7vimfISU65EumtCacDSf3R6Ads0FhVhcU+DDlevvWtrHTBgGDlvg5dSW3Y6eVmRS6vTH+iUWTCXNsXV7L8z5JCbXy/yiS39naWLSEt2JnV8aCRNQ6B0pAJ/gn/j4t5WIhF414IAUDFUP2i1U4JA01wXJ3ugH+oWSe++PT+J/MiG8KJ3G8Rq0fdPRgBUwOsqwbl7bCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SyjicdSOWwOB3m96d4X3yFbAiePR7eUGLRD/l6zmEk=;
 b=ar1Ka7Z3WpgaUH78IeqJ72REPTTqK+5qlsAClEFYrRiY1Q56dKrL78I0HAPq5KA2NO4J4Hgq1/IFOvERWiGxC9D2+AvJc40QjhnrGCcgbqKmW3hnTfLrhl1pTYpu42S/Q6AWLZ0TxgzkJgoVKnrXN9JkrOkjEmZjH/+BVoluhv9EhafHlGDBYPOE1z1XBDO1EGOq/WjytMv+54suuatBcsCczuyAjkisQWRuiGl6CY8WVm6mZ+5l/1+EbJISn8G8MfR5jQ/kFmadNbbDQsT7loosF+xjSouUJ8ad9E4SBoCKZ3ZU7cBxuKwC2hAneZqjXuytBftknxtAgSyRNL68xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SyjicdSOWwOB3m96d4X3yFbAiePR7eUGLRD/l6zmEk=;
 b=te6UTktbRyhTvyETNLy1OCzIT2uJ76/X3NFXfOEY2c0puf7XcqcSoymutWcyMlwc/jCjuiHRi9k3I3hmyTZgPdf+A4ZdwC70imCjVzn4TzvNFStmfqoLdm3EitQ7osjUMr/0F/Hhad/5wfoMZAS70fduC3g9Ah3VM6o/v48FSxk=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:58 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::8f) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:58 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:57 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 13/15] x86/sev: Take advantage of configfs visibility support in TSM
Date: Wed, 24 Apr 2024 10:58:09 -0500
Message-ID: <e3143c1f3d0b26fcd8884c6f75644b634a7138e8.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|PH7PR12MB5593:EE_
X-MS-Office365-Filtering-Correlation-Id: 62561f00-9790-4df0-3127-08dc647797a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmYVGDJbeL+nBd4kgJ46Ph74HDYEMQP5lOPR3NTjSFLWMbF6Ok/o2Fktrabn?=
 =?us-ascii?Q?JJJTm7P8MfopRSUDuE1PMEfgiUKjB8E5lm+jZptwlRo1jzwW+Ma1nJ8EyvLe?=
 =?us-ascii?Q?EtzjDSbkc+q8Kc3o9EPkiNY2NMCATyZrWw8HI8hFSR+WrMlHFo4Oxq6/GfOI?=
 =?us-ascii?Q?bRcMCPckU+pLgZ/J0XyINRcFDe5DTjsKpTL/m/Lp9Zzf8HvxSJ5PSxiblC54?=
 =?us-ascii?Q?Cn41ad+8hc9O0X0BCCdPVGtj1Xr3sOil3lZbOA7lQxxbEZqj96SipMxPypzM?=
 =?us-ascii?Q?Sh4cYHvYDzTZtU3TNHu9FLBEC2fSciK4cjV+VnapMDxPfKVjvRKx1varty2R?=
 =?us-ascii?Q?xhXPf5qHC8oGdIXvrGK90P1v+X9TxliegURq6/DJkHueXFspoUKbVjWCep3K?=
 =?us-ascii?Q?IHxAHqrbSwNLkatqEBOunnHoja52jInMmuYD2VDi7VGWLP3FaFdFWKPJ8MAK?=
 =?us-ascii?Q?0eQhrf4hyxjiJTZT4yjdvPPM9WFOV8HAni3Y1s1svLbxcn7jFTlCvTrtIhF/?=
 =?us-ascii?Q?h+sNu5FOwsq9iuOwgXjeGNSBm7jYS0KU0iIPJLD6o7b3RkYOGYnEhC7enOIQ?=
 =?us-ascii?Q?Y7REY+Ki6AG4pnhPg08h3ETbyrX5vksYiBNCleBZ1NGMFL8l5QW3c/1TGL1F?=
 =?us-ascii?Q?f2OMSEV3nyWJGa5jORVT4DkEhlOp3h+z+klb568ZOksWHnsXcGJCvj6dqYff?=
 =?us-ascii?Q?tLGwKNNU2y1ZgY2mzlq2H2NQN3wJz6kbIKsQycbGjpXuInSCH4KAxKepEP8t?=
 =?us-ascii?Q?tuhcqxw9WHA0o1lLIsngo38FYM0attBXZrzmYZgXvg1xOoPViPaPxED1rgn1?=
 =?us-ascii?Q?jNt9+F2KdOBGb7/UVQJ5S57nvUXnxL2lfqg8HXBr0Il8v+1OlxR/Sp4NAeQQ?=
 =?us-ascii?Q?lwrQ2CZnIVqsA3vObnBbnF0NjKPMdwotd2qZvQ//qZ3g5V1BSUahTIS9zL4h?=
 =?us-ascii?Q?9DiBtPzXHPGjYoRWZ6MxRq+eY9UD1HIrODZJMD/twxrUpOQkRHce3u+WYudK?=
 =?us-ascii?Q?9Dmor53JK3vkT7tNsqveOfjThbezjSFQwWNs7NSrnweLCRTTQgukDd+XNVot?=
 =?us-ascii?Q?2tvRuFjulz1EAXt2lfu/QriSYAUi4IZPYErS//CGr9IyCKzCQJ0zj0Gi4M9t?=
 =?us-ascii?Q?G0gZYc0yI3jAcAo7HsTErAOsJkgYoa9MYZNfbQRyEq4CP0cx1yoZiZqFSR8M?=
 =?us-ascii?Q?6OCMj7fML3YxX2jvv38W5FtPcfLXHyeq5uFQCQsGGhEw7GP118AKDtDz1UEp?=
 =?us-ascii?Q?pOUdMpCpkQFySlx054+JQn7BB7aipaMQx8ToKS9Z+qWglrLamdhfmf7+7xAj?=
 =?us-ascii?Q?BdFrOWn2r/2Bao3flHpEmOL9ANXBaKhjF8H6vD2MNhNGqhR/+xJPPqJcPpqz?=
 =?us-ascii?Q?/Tq8yYc2wpo4t5oQa21Zen/S+SiZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:58.7042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62561f00-9790-4df0-3127-08dc647797a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

The TSM attestation report support provides multiple configfs attribute
types (both for standard and binary attributes) to allow for additional
attributes to be displayed for SNP as compared to TDX. With the ability
to hide attributes via configfs, consoldate the multiple attribute groups
into a single standard attribute group and a single binary attribute
group. Modify the TDX support to hide the attributes that were previously
"hidden" as a result of registering the selective attribute groups.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c |  3 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 29 ++++++++-
 drivers/virt/coco/tsm.c                 | 82 ++++++++++++-------------
 include/linux/tsm.h                     | 41 ++++++++++---
 4 files changed, 102 insertions(+), 53 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 2abb51bd034f..ec3d894cfe31 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/sockptr.h>
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
+#include <linux/configfs.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
@@ -975,7 +976,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	/* Set the privlevel_floor attribute based on the vmpck_id */
 	sev_tsm_ops.privlevel_floor = vmpck_id;
 
-	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
+	ret = tsm_register(&sev_tsm_ops, snp_dev);
 	if (ret)
 		goto e_free_cert_data;
 
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..964af57f345c 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/tsm.h>
 #include <linux/sizes.h>
+#include <linux/configfs.h>
 
 #include <uapi/linux/tdx-guest.h>
 
@@ -249,6 +250,30 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 	return ret;
 }
 
+static bool tdx_report_attr_visible(struct config_item *item,
+				    struct configfs_attribute *attr, int n)
+{
+	switch (n) {
+	case TSM_REPORT_GENERATION:
+	case TSM_REPORT_PROVIDER:
+		return true;
+	}
+
+	return false;
+}
+
+static bool tdx_report_bin_attr_visible(struct config_item *item,
+					struct configfs_bin_attribute *attr, int n)
+{
+	switch (n) {
+	case TSM_REPORT_INBLOB:
+	case TSM_REPORT_OUTBLOB:
+		return true;
+	}
+
+	return false;
+}
+
 static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
 {
@@ -281,6 +306,8 @@ MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
 static const struct tsm_ops tdx_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = tdx_report_new,
+	.report_attr_visible = tdx_report_attr_visible,
+	.report_bin_attr_visible = tdx_report_bin_attr_visible,
 };
 
 static int __init tdx_guest_init(void)
@@ -301,7 +328,7 @@ static int __init tdx_guest_init(void)
 		goto free_misc;
 	}
 
-	ret = tsm_register(&tdx_tsm_ops, NULL, NULL);
+	ret = tsm_register(&tdx_tsm_ops, NULL);
 	if (ret)
 		goto free_quote;
 
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..dedb4f582630 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -14,7 +14,6 @@
 
 static struct tsm_provider {
 	const struct tsm_ops *ops;
-	const struct config_item_type *type;
 	void *data;
 } provider;
 static DECLARE_RWSEM(tsm_rwsem);
@@ -252,34 +251,18 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
-#define TSM_DEFAULT_ATTRS() \
-	&tsm_report_attr_generation, \
-	&tsm_report_attr_provider
-
 static struct configfs_attribute *tsm_report_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
+	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
+	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
+	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
+	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
 	NULL,
 };
 
-static struct configfs_attribute *tsm_report_extra_attrs[] = {
-	TSM_DEFAULT_ATTRS(),
-	&tsm_report_attr_privlevel,
-	&tsm_report_attr_privlevel_floor,
-	NULL,
-};
-
-#define TSM_DEFAULT_BIN_ATTRS() \
-	&tsm_report_attr_inblob, \
-	&tsm_report_attr_outblob
-
 static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	NULL,
-};
-
-static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
-	TSM_DEFAULT_BIN_ATTRS(),
-	&tsm_report_attr_auxblob,
+	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
+	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
+	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
 	NULL,
 };
 
@@ -297,21 +280,12 @@ static struct configfs_item_operations tsm_report_item_ops = {
 	.release = tsm_report_item_release,
 };
 
-const struct config_item_type tsm_report_default_type = {
+static const struct config_item_type tsm_report_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_bin_attrs = tsm_report_bin_attrs,
 	.ct_attrs = tsm_report_attrs,
 	.ct_item_ops = &tsm_report_item_ops,
 };
-EXPORT_SYMBOL_GPL(tsm_report_default_type);
-
-const struct config_item_type tsm_report_extra_type = {
-	.ct_owner = THIS_MODULE,
-	.ct_bin_attrs = tsm_report_bin_extra_attrs,
-	.ct_attrs = tsm_report_extra_attrs,
-	.ct_item_ops = &tsm_report_item_ops,
-};
-EXPORT_SYMBOL_GPL(tsm_report_extra_type);
 
 static struct config_item *tsm_report_make_item(struct config_group *group,
 						const char *name)
@@ -326,12 +300,40 @@ static struct config_item *tsm_report_make_item(struct config_group *group,
 	if (!state)
 		return ERR_PTR(-ENOMEM);
 
-	config_item_init_type_name(&state->cfg, name, provider.type);
+	config_item_init_type_name(&state->cfg, name, &tsm_report_type);
 	return &state->cfg;
 }
 
+static bool tsm_report_is_visible(struct config_item *item,
+				  struct configfs_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_attr_visible)
+		return true;
+
+	return provider.ops->report_attr_visible(item, attr, n);
+}
+
+static bool tsm_report_is_bin_visible(struct config_item *item,
+				      struct configfs_bin_attribute *attr, int n)
+{
+	guard(rwsem_read)(&tsm_rwsem);
+	if (!provider.ops)
+		return false;
+
+	if (!provider.ops->report_bin_attr_visible)
+		return true;
+
+	return provider.ops->report_bin_attr_visible(item, attr, n);
+}
+
 static struct configfs_group_operations tsm_report_group_ops = {
 	.make_item = tsm_report_make_item,
+	.is_visible = tsm_report_is_visible,
+	.is_bin_visible = tsm_report_is_bin_visible,
 };
 
 static const struct config_item_type tsm_reports_type = {
@@ -353,16 +355,10 @@ static struct configfs_subsystem tsm_configfs = {
 	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
 };
 
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type)
+int tsm_register(const struct tsm_ops *ops, void *priv)
 {
 	const struct tsm_ops *conflict;
 
-	if (!type)
-		type = &tsm_report_default_type;
-	if (!(type == &tsm_report_default_type || type == &tsm_report_extra_type))
-		return -EINVAL;
-
 	guard(rwsem_write)(&tsm_rwsem);
 	conflict = provider.ops;
 	if (conflict) {
@@ -372,7 +368,6 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
 
 	provider.ops = ops;
 	provider.data = priv;
-	provider.type = type;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_register);
@@ -384,7 +379,6 @@ int tsm_unregister(const struct tsm_ops *ops)
 		return -EBUSY;
 	provider.ops = NULL;
 	provider.data = NULL;
-	provider.type = NULL;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tsm_unregister);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 50c5769657d8..fa19291a9854 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -4,6 +4,7 @@
 
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/configfs.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -42,12 +43,40 @@ struct tsm_report {
 	u8 *auxblob;
 };
 
+/**
+ * enum tsm_attr_index - index used to reference report attributes
+ * @TSM_REPORT_GENERATION: index of the report generation number attribute
+ * @TSM_REPORT_PROVIDER: index of the provider name attribute
+ * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
+ * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
+ */
+enum tsm_attr_index {
+	TSM_REPORT_GENERATION,
+	TSM_REPORT_PROVIDER,
+	TSM_REPORT_PRIVLEVEL,
+	TSM_REPORT_PRIVLEVEL_FLOOR,
+};
+
+/**
+ * enum tsm_bin_attr_index - index used to reference binary report attributes
+ * @TSM_REPORT_INBLOB: index of the binary report input attribute
+ * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
+ * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
+ */
+enum tsm_bin_attr_index {
+	TSM_REPORT_INBLOB,
+	TSM_REPORT_OUTBLOB,
+	TSM_REPORT_AUXBLOB,
+};
+
 /**
  * struct tsm_ops - attributes and operations for tsm instances
  * @name: tsm id reflected in /sys/kernel/config/tsm/report/$report/provider
  * @privlevel_floor: convey base privlevel for nested scenarios
  * @report_new: Populate @report with the report blob and auxblob
  * (optional), return 0 on successful population, or -errno otherwise
+ * @report_attr_visible: show or hide a report attribute entry
+ * @report_bin_attr_visible: show or hide a report binary attribute entry
  *
  * Implementation specific ops, only one is expected to be registered at
  * a time i.e. only one of "sev-guest", "tdx-guest", etc.
@@ -56,14 +85,12 @@ struct tsm_ops {
 	const char *name;
 	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
+	bool (*report_attr_visible)(struct config_item *item,
+				    struct configfs_attribute *attr, int n);
+	bool (*report_bin_attr_visible)(struct config_item *item,
+					struct configfs_bin_attribute *attr, int n);
 };
 
-extern const struct config_item_type tsm_report_default_type;
-
-/* publish @privlevel, @privlevel_floor, and @auxblob attributes */
-extern const struct config_item_type tsm_report_extra_type;
-
-int tsm_register(const struct tsm_ops *ops, void *priv,
-		 const struct config_item_type *type);
+int tsm_register(const struct tsm_ops *ops, void *priv);
 int tsm_unregister(const struct tsm_ops *ops);
 #endif /* __TSM_H */
-- 
2.43.2


