Return-Path: <linux-kernel+bounces-157283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188D8B0F50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 613EA1C25566
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1527016DEC5;
	Wed, 24 Apr 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ByGv1uvO"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC80C1635AA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974388; cv=fail; b=WA2rPz563hGXGm+nJv+kNHiBdqHesUeM6AYAVN4UU9I+d7gmAmLT/nvv7Ywd2CObufU3G2oEXai13gF9DvGna+sKU6+hmhN6vJPBJrQjQqVVdiOGmxaBO4c2jrkcrRZyfXkaSpMviJ5SxuXs8OHtB4pCPH8BvGgXGeA06VWaaB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974388; c=relaxed/simple;
	bh=aQzJxzu3JRsRJBqn4CP9lcLBDKf2NUkFj2gkoWxADW4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmfcVZD2TVQSQdN0FyzXrqPOyw7qRc5+JtpvIpPpFUEJMiWYIrtB+FN0ytHJJnHa+P9UNIa159LVcO9/qcivE55PWqV7XdDf+eRgcjtxxa9ZLDRYpN3a3ItLJKFwop2KjpSlQKKyNMHBUFyLyLFm3q1soNfbt6372h9d4FCDj1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ByGv1uvO; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFnKQV18g/RoTLwLkH94LxVcQQCnimR+pMi9rnj/CSRPLuzHEqo+C3LTpOnPqnsWeEVGNEfeIljckZcswy0YgSW0cdSSqNFo40P5TQ8wGHnB57h+wVq7CT0cKVCNd0OzSyj0eBtMT1grVfTTGZaZ9VVHS9oHmhzHc9l/g8aDDPLHGnyVyLrR3pOsv7SRu68TqjUDdbjjBK3tU6AdtQ1HISrTBV6P7JHtUAyxpiEIkvapKudcC7dW4bnYwGIurezmknNn3BVaVN/pDAnCFz+vdqJfKw1w1AORwCuLv51h6Y6SwTua4h5ezVk/frFVi6s7RYC9//mNfA075OqekxtoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wscLJsvbE4NqlGls8/En2OLJd4BFLUy66OVcbTqEIVg=;
 b=HDhhY2/I8SUkFVdRaCWGODrbXYtRbekrWiicSy/0AFYnDikSZw+HglSJ/9x7mvonyRmSYMEZA1KMmmpFyH4VHbFSKSqN88tvZROnw/2K/z802gTiRGNqfbruuJS8GS7VdemJKHVl4rIwwAANtJXl+xGrN2TSb4ZMzBEjGxGuLBrSx49m75YLiUjrBSgmgAIFOTf1nGooeiHIqivh5Xlq8ctPkuGM0BLHGy2jlOvu1A2SRMjmBl6o027Ym5B6ZIY9BSdmEEtElRiX7648SQZ48e2TeLbs7vR62j02jp7ct3zQtptfrppKhViV8U/n2rbsqhmCkQzISWn5R0NeQdwKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wscLJsvbE4NqlGls8/En2OLJd4BFLUy66OVcbTqEIVg=;
 b=ByGv1uvO5tvBOQh0sBWh/oWf/sK1W3PDK4zzdk4P9FKyNCGnB6dqBCCcXiqJQLKakYhl7zbdRoz1l7ncSd3EtZ3YcHqO+ku91XpZWZSi2LzjXecJq2wgiZovxQZyxEY/JptyJeqhq60+nJjTdisq4AdRBErUZLa4WJ2T3ocdhf4=
Received: from MN2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:208:e8::30)
 by SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:44 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::60) by MN2PR20CA0017.outlook.office365.com
 (2603:10b6:208:e8::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:44 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:43 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v4 11/15] configfs-tsm: Allow the privlevel_floor attribute to be updated
Date: Wed, 24 Apr 2024 10:58:07 -0500
Message-ID: <731690ebf2434c553a08bb06e5bc6cd8fe48a4bc.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 25999511-9fe5-45dc-c3c8-08dc64778f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cE4xpYK1cWDDu12HEuVJW5Opb/Fla7lTkICno9RYG55WGkoyW14iMpnH6g2I?=
 =?us-ascii?Q?/QVzJW7lcVSVzRwz9TJqIgPh+BhfRZDrVyiic43bC7UJOWDj7BwK1IulPsls?=
 =?us-ascii?Q?yl+SQEDXH4TbkxuV69ccjhipWET35+W2QBhJOS/bLy10UuaTT7k+nWcOq/i9?=
 =?us-ascii?Q?mfTk62NFZSOeQSvWIPLiAvu4iggRS2EJqgC/5Bx66X3RNmI9+KtHBvcDTyiU?=
 =?us-ascii?Q?jbQcK1rGe0YqyG2E+gZZuvQxICkq2PjfB8qFi8XyHeATR5d3zxWFeJzyXXOw?=
 =?us-ascii?Q?JDwOcKe/fKwMMdP7hl5VjegYElkctmnjQ5mE3/9niYjegmbAw9p2cnJ38D6K?=
 =?us-ascii?Q?z/C3brMamkDTew+q25vsMdgW1+CmabWNk94RYj7N6wD2Jqa69BMdihJMOBjV?=
 =?us-ascii?Q?QPaku/yWlcSYFYbgOh1PUVmC0AcvpDRw9egIJCxJ6ZLYj3zlFy5tQpzNOuwy?=
 =?us-ascii?Q?WWVk4PXhTtsE1m6t8xJAEOlmGcgsyQCfVwr5c+4fnpu20LRb1kGMiDNQe7Mw?=
 =?us-ascii?Q?27MDvr3JDPsTNv8JGPbaUse3H0KQI5LL07t4C/XumD0voJI/AU12ehviyCq5?=
 =?us-ascii?Q?hlF/x+UeMK9OZvdl7vE2t12aIzeKbezpRQcdSMzZFEq6wxCQ/Akb06DN1OLW?=
 =?us-ascii?Q?JyxyUTomDdrYuVbwvACeyVU/4IUGXN5nNs2b0pOZmdfxK7c+z25hTayHXMGM?=
 =?us-ascii?Q?X7mu4bWdssOuTpbPVeTTdlmKfkkUsJg1GhdezOg+cs2IKsdGlaWFG88wJyos?=
 =?us-ascii?Q?PriWNH/qCHgIEkXluoTUdeFGitHRRO8KOHD5rLb7YYyyyTzomJjIOiiafF/K?=
 =?us-ascii?Q?YpINSH1OfsTl35qutMHpAUm5E0TIAs2RjtgTwvnyPW7C7s/SMMkK+ExvjSP7?=
 =?us-ascii?Q?9yMHnEHz6yyjqVfRatHHglBvbiHeqmgbAH6YPws6w0WaC98P7/FjxiRu2sKt?=
 =?us-ascii?Q?Z7F4KsiYK7DYKEvF/ttIPgw37Fzo8DANroJflpfUirhahCvK4hgrY9ESPCPh?=
 =?us-ascii?Q?Yeel4S1cx6Zm+vht8EmdRGtc+Q6t39VBFuwIKg8FmUMTqLEuyLUSCoakt/rZ?=
 =?us-ascii?Q?op0YPH1fYzw9GIZhT0w3jGrsKYx5ymluT74oYFFi9utRz2d4U5eNcCOchxl+?=
 =?us-ascii?Q?k6jkEaN+dtzpuXoJrbZgYKSke9B1yn5Y327l6iJPu6yHjqpgqC2MhKWXMx+S?=
 =?us-ascii?Q?Gf94A9bO4WgP3fE4uWU4l36P9tcYXo1OFzx/Aqpw6U9YuxCjoQOt2eYx+zmA?=
 =?us-ascii?Q?4Ceq5+6A4gZSMueEBcDLQr03Kb8LAn2EJiZDov/AZFbaI+11Jw5J3vH5yeuG?=
 =?us-ascii?Q?syNtNDR74rleU7tXjSIh3hf+RbLOwbrtNyDZqQ+il0r4xTAJgNlaPdBBgJOL?=
 =?us-ascii?Q?ymdTKCxbiLuqv27alhanKiZZucMo?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:44.3980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25999511-9fe5-45dc-c3c8-08dc64778f22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163

With the introduction of an SVSM, Linux will be running at a non-zero
VMPL. Any request for an attestation report at a higher privilege VMPL
than what Linux is currently running will result in an error. Allow for
the privlevel_floor attribute to be updated dynamically so that the
attribute may be set dynamically. Set the privlevel_floor attribute to
be the value of the vmpck_id being used.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
 include/linux/tsm.h                     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index e7dd7df86427..2abb51bd034f 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
@@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	/* Set the privlevel_floor attribute based on the vmpck_id */
+	sev_tsm_ops.privlevel_floor = vmpck_id;
+
 	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..50c5769657d8 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -54,7 +54,7 @@ struct tsm_report {
  */
 struct tsm_ops {
 	const char *name;
-	const unsigned int privlevel_floor;
+	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 
-- 
2.43.2


