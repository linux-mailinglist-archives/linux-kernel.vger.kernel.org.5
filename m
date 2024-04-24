Return-Path: <linux-kernel+bounces-157270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D08B0F3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA981F24B56
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956F716192C;
	Wed, 24 Apr 2024 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hY4JBgVW"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD316130D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974318; cv=fail; b=ghsvat8GLkpUtm/Jz34A47SZbOYnmq+5VHclwPliYT8EDLEmFrLa4607pxBV5XzkS8HY1WM1RAyQl5sUwKOar5n3BUDx7BVI+JQ+0A+fVEJTC/+ooPuzqwA2pOXvQD8gk3x0km0xK8SQL+J2rz/MZkvTtQNYFA3O845gEvxBUqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974318; c=relaxed/simple;
	bh=IoPkAJCI+2qNOgE4ZNvBFMwjvGyVKF04WO2eSNkc3xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6/eicrp2kWYPXnHCdZmAMnXFr9X5KrIh0y1Z3me7e6ctu+zXi7r97TBt1sQCumK5ka83UzABqBXHLuBW0Gv+NZ+RSWCSIj8B4RmuPLDRKeNGd3tb68dy2siYHYwELgNzevYGtzoCre/CMSNYo79X+GfLkU7WE++jr2XUv7v0/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hY4JBgVW; arc=fail smtp.client-ip=40.107.96.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogv5Sm7TBIo1DZaOKiEnUDt+m7imYr18/4qYcHLI2E4vSi/39+8+MsrABjD0wtuX9Jpz5YwpR+vEQ4oqxrOK7uXdt5bX8HWnghZfEVprqm6Kw5HQEizTGJ34VfH/53RAL1qEGBMsXMql9m9jXzEiVVaBQtd2gYtNYaGa9QLFCsOX/9eJ8kY9uwRdirlrDQ884GETJeIAMCLLhc2tCWgIhjwIHmYtmM0JM13PhImUhPAAFfqezQVfAMN6VGPLQ0W7TtetYB4RgLNMTd8yarrutllu7s6SDfH6QI0m2mgriDdFlHHFZ+JHd2oBYD8tujy1WjO98KH++91y3+sTUUTPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fvoIpw98EGryWgKZZYrMRJWz18TwCVHQc7OK/87QBM=;
 b=nP4MOd4va4kyQft+EyLoJMXS9qwQf15vBFs2Pp+wHkkxMNKqSBfA0DeQW7X6cq4t8oT2o9J56/R0rnXaaXmqHZ+EnuxPRPNE9Xz482/m8O4ZpDVglHRFfWrkqulR06O/iLGsC6wcFs5yZRKDndhjzb+EGYCzS5xhwM2ePP49KqBgBcR2KIu4BPXsUDUOQunAya7oKzCgW+Omdkd6+LISmblh3BukypNwANgrYq4hzT+VNMZq4ZFWe+tKjGpP+tRKEuu9mxRq0Ib9AdDTXn4qVnem9ZvE05ZpF6Oa2CWoMxnxwj39BTYoRPqaVlEcWL+OQBuwLAGNIH0zwlOavRQiew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fvoIpw98EGryWgKZZYrMRJWz18TwCVHQc7OK/87QBM=;
 b=hY4JBgVWQ16yKsutxpLix2aTc/R+6xn27ZOoGZLzdQjVEEsTdXQGI6vDKkEKEBJi1Gl6nbhD4YWLWpJDaLxTWwxk4OFEPh/b3E9RymlFxrN5pbV3L19fYYnSgRsuw7ZNoU+4GNbggFKp6IlU3iqPKqne4Jrxyk57sXIA1XU/ro4=
Received: from PH7PR17CA0002.namprd17.prod.outlook.com (2603:10b6:510:324::22)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 15:58:33 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:324:cafe::f1) by PH7PR17CA0002.outlook.office365.com
 (2603:10b6:510:324::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:58:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:58:33 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:58:32 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 01/15] x86/sev: Shorten snp_secrets_page_layout to snp_secrets_page
Date: Wed, 24 Apr 2024 10:57:57 -0500
Message-ID: <bc8d58302c6ab66c3beeab50cce3ec2c6bd72d6c.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: a95481e7-91a6-47de-fc9e-08dc647764d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fcsi80JUm0GQamSUSBr/BS2m5dwj4/pJBKT4b7VkdBF63kOZD4o7QkTjryc5?=
 =?us-ascii?Q?aNMECxOHMJrtcBUUV7q4zBQEtpDIq9Du6k5WXxt4N4Kj300vvFR507Ga+jwo?=
 =?us-ascii?Q?CjqQQS+jUgQlfjgRS8jdLvWKIDwYWSbcDNNEGfW8Eql6ZkZMxXJO5OuwFRM0?=
 =?us-ascii?Q?8hoFa/7+zu3ct1dZXBUZDW+qoJcfTRRXwyMwwQxZGzW+fbymJZysTvblKbRd?=
 =?us-ascii?Q?mU6ZT+GOIoLB1F0XGWPXibXfcc1UjKrV/XniPNn5FKZKS9QngEQGN3y0jugo?=
 =?us-ascii?Q?x5zqTNXjiKkFi8c6u/HyB/jQGLSKz1rnPZbl3MVZN1WmN1AchYXVdE4No3NH?=
 =?us-ascii?Q?RWrX90U8NAt+g4qe5bFnBrSgAwixOJPVh/qDOjTawnGghZQXuXOHfzzgJN87?=
 =?us-ascii?Q?FxoGfM1C9RPORe2elOUMQaRvHjkIOjVks5HWKLJfeD6FJHg4fVRDW7euZ6dq?=
 =?us-ascii?Q?KzxuK5wZINBcWhVEC6TaDY/jBUvGIFSKMXUP2I16R3NVf8IX/ESNVN87l3Ox?=
 =?us-ascii?Q?ltTJkqF3zw/miXi04ImEcO2wxG9jah39DjjULTMkMFiCK6IVWzaQRMGj73dA?=
 =?us-ascii?Q?9jyYS8fQv/tW1JrmO8/AhsPL2KMSrOdgWFi/Wb+U5ElHW1OhsrqFcfuY9Ktz?=
 =?us-ascii?Q?HN9fYe1zzSXFRgHqvSYro3LB8hIZEg5BXw5X9RwLPVUwzh57vTS0BOixL6t+?=
 =?us-ascii?Q?d7sciFyhVkkOnzwh8sXtQBRZO/N2rk3aXs+0Z/h7G58kfqRVfoHpNd9MIHvb?=
 =?us-ascii?Q?wFblGG1bwin8+jMK0z0rUkEURXGvlWEy7nCjB3u8M2NVMRA3uO137drI+uvR?=
 =?us-ascii?Q?rIqGn4WWrWvMaOnSRc63umUC0K/Zi6LvfQhoMrnPb+GK+R1X2kR++5tCizn0?=
 =?us-ascii?Q?REWwKG0I1usyD4aGOlsHdh72KfvTCnYEIWnwxmQE7ZLoPLf7lGSMhLryB09l?=
 =?us-ascii?Q?WYGp+NaDecZ/gZxx7TB8AYgO1F3vppneEOkaA4TC83SM06M551wO8YuYqPw7?=
 =?us-ascii?Q?vN23JCrgs9lQeF63TYqpkdTKBvcie60cWLDZBvB+itWA4kAE5/pv1q6RT7kN?=
 =?us-ascii?Q?SnXZDulYOFxGdu/dM+7UoQMr9f9GNiiQULgr1Q3PnVVl6lv24SaldFLz9znN?=
 =?us-ascii?Q?uDi8sRZk9Qi4bzX5qe0XOeDb0ilxnXcaebxdq87gR6Ukj/nPppuTr+YJ2muo?=
 =?us-ascii?Q?fgGLhf4+a3tbUluMugF8uzFxmsNhVATGFs1IgD9zD8ZH4/IJeCHIDw1J/LtR?=
 =?us-ascii?Q?pC30JdADc9m7XYcdFYanfF+rUsnBbIAIVXyYj3N5A4hWFWCuWGLMohUESjc3?=
 =?us-ascii?Q?AA4zTdc7dFFRQtcBZG7h72R1GzJxBcdDEn9xRFzXTsnO3w/1oU7+nm3SJiD6?=
 =?us-ascii?Q?pTGnZ2hCEqMJ3FFAd5FInzp/LLU7?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:58:33.3990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95481e7-91a6-47de-fc9e-08dc647764d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

Ending a struct name with "layout" is a little redundant, so shorten the
snp_secrets_page_layout name to just snp_secrets_page.

No functional change.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h              | 2 +-
 arch/x86/kernel/sev.c                   | 4 ++--
 drivers/virt/coco/sev-guest/sev-guest.c | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382afee4..48bc397db649 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -140,7 +140,7 @@ struct secrets_os_area {
 #define VMPCK_KEY_LEN		32
 
 /* See the SNP spec version 0.9 for secrets page format */
-struct snp_secrets_page_layout {
+struct snp_secrets_page {
 	u32 version;
 	u32 imien	: 1,
 	    rsvd1	: 31;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 995f94467101..6949fbccec40 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -648,7 +648,7 @@ static u64 __init get_secrets_page(void)
 
 static u64 __init get_snp_jump_table_addr(void)
 {
-	struct snp_secrets_page_layout *layout;
+	struct snp_secrets_page *layout;
 	void __iomem *mem;
 	u64 pa, addr;
 
@@ -662,7 +662,7 @@ static u64 __init get_snp_jump_table_addr(void)
 		return 0;
 	}
 
-	layout = (__force struct snp_secrets_page_layout *)mem;
+	layout = (__force struct snp_secrets_page *)mem;
 
 	addr = layout->os_area.ap_jump_table_pa;
 	iounmap(mem);
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..04a7bd1e4314 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -59,7 +59,7 @@ struct snp_guest_dev {
 	 */
 	struct snp_guest_msg secret_request, secret_response;
 
-	struct snp_secrets_page_layout *layout;
+	struct snp_secrets_page *layout;
 	struct snp_req_data input;
 	union {
 		struct snp_report_req report;
@@ -743,7 +743,7 @@ static const struct file_operations snp_guest_fops = {
 	.unlocked_ioctl = snp_guest_ioctl,
 };
 
-static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+static u8 *get_vmpck(int id, struct snp_secrets_page *layout, u32 **seqno)
 {
 	u8 *key = NULL;
 
@@ -897,8 +897,8 @@ static void unregister_sev_tsm(void *data)
 
 static int __init sev_guest_probe(struct platform_device *pdev)
 {
-	struct snp_secrets_page_layout *layout;
 	struct sev_guest_platform_data *data;
+	struct snp_secrets_page *layout;
 	struct device *dev = &pdev->dev;
 	struct snp_guest_dev *snp_dev;
 	struct miscdevice *misc;
-- 
2.43.2


