Return-Path: <linux-kernel+bounces-157284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5BB8B0F51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE98A1C24297
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656C16C856;
	Wed, 24 Apr 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3OEWoETG"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523E81635AA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974397; cv=fail; b=o2w9WKS3agy3turvd1Uk3DH7eaVb/RRNYM9mpUPXm45oARKmnIM7+3dhD2wL5TOgZTSLQXpJzJwRHvi8KNzl+U4L2+RqAe/Ii8REMW5I1+aHlpToaBJQrMYjSFuPevDdiTTnP3E78FoaOk4b994sELtA/jBISC4OFMjBytaRUII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974397; c=relaxed/simple;
	bh=Sq6lw5mGILMoX/LWK00+p33/9Jd8eRerh3YOoRTzFIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwD1T6+C8cUz2xSHfL067O3K7Ezr3lrg/yeqOyqBnGOjhknQrIuC3wDuuy40wWMd61oR9DzLol39i9/CPVfg3jlmWzXroW6qJ0tKZVFq1rHAoelc26BEFHuEpD4GlROxLgWWrr2ot1RgHJUiXy2R5SPq3K4dUQlDnVEPDAxsOV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3OEWoETG; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKjXEyyQO/v0jFJ0NzPgyyMQ/FVe75KbDt8s3brWnr8r0Qv15f8xCKnr/Ubi8a5jK7LT1FQeaqrkuQg80nWIg5hSReE1wvc3prPRXu+VCEqJbCZ7VylOSSDzaqjRcf/1jTyek2DSMCqX3SRnmECclMxjMUBVlASyzCjSFiuWwI96USd/qTWfrC4vmR04SbB3ARuGkxd517DiPnWTUQh4lsE3NDLmFQveg5UT0YXK2unm7mDy1TC9Her4X53vLiI8/ItdOxTYxzfg9LXAcvVM6wxve63LJrFsJc5UFSY2Yq/9+mULY5M2KWOfDSt5YaqSWkadIwQKH3juLUc2YUGEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zLSYjw0FK+2RjD5YSIL8TRuugJd5EXzQpGHQo0AbJc=;
 b=HXb6Evcxm1ywKWUi/S+8ov03B3eZrmbNZdhE1yCfqX+MIZi+/OurcQcNAyseZMJbBJOg8a+0C0hYUfLMbpHWT7JA4gW52XBbRtKxwxKBamAhk2QxlmFEk1Q5FXvf3N0FCmJa4yYwZ0qmakoVPBYzTpVx7KSBPKWdwRg3y8ZHKuRtdq66bkEm1WJVmFX9gBi7cjqv3foJqeZluKoe/c0SZmwVe5MZntKEyDd14bNkDlUoeyg3iPArniBEHySp/GHHUF2P0dwUjCs7UZ9Rcj4NBx14Irq3uMpU87Tace36RuKi05GDVwz2M1WCxbJmXmUaIjYMsdzUCFmKr/erMHP45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zLSYjw0FK+2RjD5YSIL8TRuugJd5EXzQpGHQo0AbJc=;
 b=3OEWoETGUg6QEFE+m8yZ9yDP1f7hOVoEhim0WzT5CbdxIaASnjgqAHbzocnXXmhW3GEmY0CiFWI7tbeCBFOnZJRVHvnJlQZoskf8vvFqn04aqbeQfpGGEmwcMdPvDx4LoY5qHH7SGQ0fVI/eFoMDT+mQjFC5ya4t3k7P9JCVd+U=
Received: from MN2PR22CA0016.namprd22.prod.outlook.com (2603:10b6:208:238::21)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:59:54 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::38) by MN2PR22CA0016.outlook.office365.com
 (2603:10b6:208:238::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:59:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:59:53 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 10:59:50 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 12/15] fs/configfs: Add a callback to determine attribute visibility
Date: Wed, 24 Apr 2024 10:58:08 -0500
Message-ID: <53e67e416fb4da085f32d8a3626c5c6e656554f9.1713974291.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: bf541b24-09c5-4d69-b30f-08dc6477949a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?huLLzXsX3UGeVYPDBD9xdoPQ7zf1imLsgdXYZz6hFO+OupR2t3ZnFiZzl11X?=
 =?us-ascii?Q?6Z0mK9OVi801BOcwYz1hMHWccOoCUxQrY3654tGMxchUfq4kLO2iOBvhl+Lt?=
 =?us-ascii?Q?PBWskuYB4aLIqmSWg3Mt3HM7DPmMvD+/fy14TiMuWwiQRIRstayrNTmTOjra?=
 =?us-ascii?Q?Acp6AurhcJ1Y9ndF9+5rR28ePkYSx/IKC+gKASySZajFSUDLbcbUT5TQryeP?=
 =?us-ascii?Q?Tw4sxIdxiUM2Sg3EiT3CXp5q2ZbOitMni+p77SB7nNdvJ0/KqNEoYPoTXzY+?=
 =?us-ascii?Q?ZI+uKfZ3Rf2QosUivGTMiabLpOWiYt1RoflWHo5fSAzXO9j4YXToWp8Z/k76?=
 =?us-ascii?Q?pGJLZkIxIbAy7F3UKpX3MZUr1hofGxPUmeKVyBxhTBNxuC7pm39pGUwc7xo0?=
 =?us-ascii?Q?nrjeVBMhl9lijqjVy567nL5Lm3L2HVsJXuslx5vgrZKPImL5CKn9HQq0fPKe?=
 =?us-ascii?Q?oiLVOvNen756RCercT0eJ62XdSugxJquFsa2WJbrH70j2NF272xO+6hRfDhM?=
 =?us-ascii?Q?RShldBAwzx/7UmLhwN/7Nr/xvFQ9gk7JYv7iHCnHTd8DcFhpTZdGHisSE+Wd?=
 =?us-ascii?Q?3Mnk94oYmfEqx/82vmyn9eN03jE2KRcAblIC8pm5zUsmahZjj+Tgri+OJVte?=
 =?us-ascii?Q?NIeunrhr8YRbxd45qScTPr0TGry+MSHSY75j0EFBNb4Qv9EibEsCt4iBwJII?=
 =?us-ascii?Q?Zl2Scic1FqKCRMBZa1vWu4rDllRjOY4dzLT+JwyZOXmswI+4v90sd6dUb/Yi?=
 =?us-ascii?Q?GdylzQ/xl/EoF3kEYNea1q+XIWnTZQWoTYyuUEmuCotX+NWHOLxDvbNJ5/lS?=
 =?us-ascii?Q?GC3UTd2FLWzJdjN0aw00o/8VRzDWeOj2BpgK3/cgjLoRxjCadFZDLowHdINy?=
 =?us-ascii?Q?uHcMf2+8cYY3ZO+pq4nT3tcruryCbb3bgLzNFSxor0n7G07bjUVUgrU4/7kT?=
 =?us-ascii?Q?PChMLsZEZvli75WwofH2MswkZaMIdj8/AVJGwsNDgAktPDZeejJZdJAaWhVL?=
 =?us-ascii?Q?vEGJpW23VMogiR/wY6qzyvzAtryV2fsZpUddswy9vjdX5A219zI5q4MyTbXT?=
 =?us-ascii?Q?Ty1wnJDvVWOFamf83JFOyRSnntnIeLglF2L2oxRjdS5U+wm5vn3K7wFQEzkc?=
 =?us-ascii?Q?glkdezt2UqhkKKeZyfgsU3UsMwFblFHI2bSoGfaPoxRWzx2uADtasiFojDEE?=
 =?us-ascii?Q?SDUSqEp2AjhhHUjPTPpmpwV7CJM36u1jwRb6MFixiRBIgC3su8IjdfBbL6nU?=
 =?us-ascii?Q?5tQSbPWBNyfI/ThilKy3YBCjsEbnizanlp3gY0T20QkeY07ojO6mVAw1vKIF?=
 =?us-ascii?Q?YtG5AI2HFZijnoUTN3SDY6HxcM+XxNTt3R4GjLfGzhCU6v4MQQScznzIXa4y?=
 =?us-ascii?Q?HHAtO4eXKCFoR8y3oG/AU/BvwjDv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:59:53.6351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf541b24-09c5-4d69-b30f-08dc6477949a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

In order to support dynamic decisions as to whether an attribute should be
created, add a callback that returns a bool to indicate whether the
attribute should be displayed. If no callback is registered, the attribute
is displayed by default.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 fs/configfs/dir.c        | 20 ++++++++++++++++++++
 include/linux/configfs.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 18677cd4e62f..463e66258507 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -580,6 +580,7 @@ static void detach_attrs(struct config_item * item)
 static int populate_attrs(struct config_item *item)
 {
 	const struct config_item_type *t = item->ci_type;
+	struct configfs_group_operations *ops;
 	struct configfs_attribute *attr;
 	struct configfs_bin_attribute *bin_attr;
 	int error = 0;
@@ -587,14 +588,33 @@ static int populate_attrs(struct config_item *item)
 
 	if (!t)
 		return -EINVAL;
+
+	ops = t->ct_group_ops;
+	if (!ops) {
+		struct config_group *g = item->ci_group;
+
+		/*
+		 * No item specific group operations, check if the item's group
+		 * has group operations.
+		 */
+		if (g && g->cg_item.ci_type)
+			ops = g->cg_item.ci_type->ct_group_ops;
+	}
+
 	if (t->ct_attrs) {
 		for (i = 0; (attr = t->ct_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
+				continue;
+
 			if ((error = configfs_create_file(item, attr)))
 				break;
 		}
 	}
 	if (t->ct_bin_attrs) {
 		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
+			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
+				continue;
+
 			error = configfs_create_bin_file(item, bin_attr);
 			if (error)
 				break;
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..c771e9d0d0b9 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -216,6 +216,9 @@ struct configfs_group_operations {
 	struct config_group *(*make_group)(struct config_group *group, const char *name);
 	void (*disconnect_notify)(struct config_group *group, struct config_item *item);
 	void (*drop_item)(struct config_group *group, struct config_item *item);
+	bool (*is_visible)(struct config_item *item, struct configfs_attribute *attr, int n);
+	bool (*is_bin_visible)(struct config_item *item, struct configfs_bin_attribute *attr,
+			       int n);
 };
 
 struct configfs_subsystem {
-- 
2.43.2


