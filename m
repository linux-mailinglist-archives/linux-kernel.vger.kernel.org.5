Return-Path: <linux-kernel+bounces-118110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B288B69C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D32B4452B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BA87FBC4;
	Mon, 25 Mar 2024 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nyTlTE3d"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ADC82D64
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405694; cv=fail; b=mzJa+iiZmcuCf9Ag6M4ZF1VkkD+GzAcvIsyo4UxA8lEeIRUyLGLcCJzeiS2N4ATFzX2w4e/Jki1/WkVJTuRUh89RLXzNdAH4KgRNzuLVCUxYGUVsVRa4Br3IxL9W3x0uixyj5z1SA+fT6758lEOS4JaTKtXfcfrIW1lUfkv4LGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405694; c=relaxed/simple;
	bh=ysluWvnWCwEP/hdYBTFjSr3RcG8VRQR7xXXsrrnHylo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq4s/u1VgqWd3vysDmhpUK14bJlwl8cZQya0UluHlDGMhaJrkRoZ4jekp8+l7/j42fty5ZOkjoleHGPb2hrQaA+LbxdrlGsiKK9AHH7oRX1jMMoLrO1xDqLMzB4oDXRwY6IIIb+5hk2ALPZM2eHc6gkfu/fCXZN0t2fj/w6yTm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nyTlTE3d; arc=fail smtp.client-ip=40.107.102.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfISG2H9E0im2QdyonCWeWrQynYEqNSNOsruSzsot0uP9XkJXQr6aXnC5r/LZ+ZVw4bxAZLbGjiTFzQG/5fuj3E9rBUuR1rpAO14LGEd0rdh0VV6cNFoe9pXEXxDrgLEA2gFJzkga2S0fqH+hF6RzFAO1h75WUX29REAJlgOvYCNAct4tscE0zcLK+KSuVrcOpx1/FEvkXhf36aXKAFCtiEyuhXrXLkcXMG6KiZ38ReAO/MIebbaa0AZaDfXDRIanSmTdtca1M5VxINkY8oQt8Md0W6xqhYs+9drr8nNG/weaMMrnwvEyQOAKgeFeiNiXXr+N9RnRN9aH4vtB475EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwHDeN04OmRtSSW0Zf1iHFTZa+AKo4apEWL7A8XQfoQ=;
 b=Ns/eTDVCYtXQ143f5An//RLK7jusnZKpSKRXLmeJhq5DS3IeAFWHBKthFLzhgV7MSZnUCfKTG5crNuImrcSSR7sTWbtpxlCIvIHzJkT5Gomvr19QgRFSb5Pr/0HiPAIJbMd2ZRPau3wc2NvebIWr+6asMpx7IYxOBxNOgwV1sCIRawbMF4CezYFvQ/XDWChn2iyC0CksGqhVF7Dwf9uAVAE/CrenpADcRCcfZYYoKEt/vCmUw4uYzDH74GSH36fpBaf1kMnRK8fRKIlWjQHbsXE2wXC4omVgTMPWw89ugNlpRNWG5KFb5TnRKJZpIOW4TNy5Ppf6pK65xjXjF9UT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwHDeN04OmRtSSW0Zf1iHFTZa+AKo4apEWL7A8XQfoQ=;
 b=nyTlTE3dCS4ADJj95T+0025swyVzTcKe2JAGOTFDuO8/YIaWapK9u8ImgwKvoPGxdniXZwLvVaJVIAqMSefv226omljPWIloGqDJv06OGxd3L+rupE89DvHIts59Me8BuaaIQx95rrENSQjZA/DtXWOqMWnJKtdHPxzy+VGLZb8=
Received: from BYAPR06CA0030.namprd06.prod.outlook.com (2603:10b6:a03:d4::43)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:28:10 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::6e) by BYAPR06CA0030.outlook.office365.com
 (2603:10b6:a03:d4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:28:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:28:10 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:28:08 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 12/14] fs/configfs: Add a callback to determine attribute visibility
Date: Mon, 25 Mar 2024 17:26:31 -0500
Message-ID: <e881a70fda1da98882241fc46fd57c3063fde55f.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711405593.git.thomas.lendacky@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: 19df8a6f-55a2-4d29-703a-08dc4d1ad9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9CyS04CyhtmhH/ETH94xDPgickoaBuv41gX9HFLmk2HxcBkNIxCbzJ8N8Gfez23ED0lGFy+1mXa5bdNg6t2Yqp4LLHKOa7Q4nBcVFDn75PAYs1an/958tS6VdXKCzpjpeO3JKRsjSPlsHQb53AskQBd9nbFbz6xPnsE0kvxp0jvWXyqwIDKHupja/EiPUff8Pn1OlcIVp3f7We4WFFBpzeOxTygclDFOm0nO7AAEDQRdS2VtxBA5+2soYiMqzOsGzPcYldyalsgNWY3cb0FwP/hVnojCHNHAMpM1RPqDACHqulPYegVms5TN5Blt58XkUdyvVkuaOTf3i4AcQpxcz4SySQ/L+YBOBBpECqB9NmujbebDnTWNhKlLHEKefmWVkliP3njg9sTd7EIBc1E7+3B9o+pUwRBOhw7byS025iNS8vGfU2MjZHQxD5jxbq5SPNKOBF5UgICAeZi0lxhCpmsswCzahh83sa+GWi81/yLuLwe4rqhSw+BRbS1erX/UrGmGkNABKoQZ6qEqsWTNhUomt+s5d+UQ+vMuCQ/LMoTG9ym/i03n/pvXWY15fP0J3LukWCkgcAx+aA3R+PNMjkH9o9rGskRVxoehfRyrPATR8hTkbzfhIZzoASs+4t0gLKoT/LPu1zhFQi0sd0OJXRKiqPZIwJmpNqf7zxLtaBdU5DQhzEuVlNj44+H1c7kN9MMW/6h5oNN7AKvHguJXAhSJVfUN4zvEfNLK0tHCBrQqAA2BJXff/QZhLrJsLNoK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:28:10.0140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19df8a6f-55a2-4d29-703a-08dc4d1ad9fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914

In order to support dynamic decisions as to whether an attribute should be
created, add a callback that returns a bool to indicate whether the
attribute should be display. If no callback is registered, the attribute
is displayed by default.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 fs/configfs/file.c       |   7 +++
 include/linux/configfs.h | 111 +++++++++++++++++++++++++++------------
 2 files changed, 84 insertions(+), 34 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 0ad32150611e..a976c183756c 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -451,6 +451,9 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
 	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
+	if (attr->is_visible && !attr->is_visible(item, attr))
+		return 0;
+
 	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
 	error = configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
 				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
@@ -470,9 +473,13 @@ int configfs_create_bin_file(struct config_item *item,
 {
 	struct dentry *dir = item->ci_dentry;
 	struct configfs_dirent *parent_sd = dir->d_fsdata;
+	const struct configfs_attribute *attr = &bin_attr->cb_attr;
 	umode_t mode = (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
+	if (attr->is_visible && !attr->is_visible(item, attr))
+		return 0;
+
 	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
 	error = configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
 				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..c836d7bc7c9e 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -116,35 +116,57 @@ struct configfs_attribute {
 	const char		*ca_name;
 	struct module 		*ca_owner;
 	umode_t			ca_mode;
+	bool (*is_visible)(const struct config_item *, const struct configfs_attribute *);
 	ssize_t (*show)(struct config_item *, char *);
 	ssize_t (*store)(struct config_item *, const char *, size_t);
 };
 
-#define CONFIGFS_ATTR(_pfx, _name)			\
+#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IRUGO | S_IWUSR,		\
 	.ca_owner	= THIS_MODULE,			\
+	.is_visible	= _vis,				\
 	.show		= _pfx##_name##_show,		\
 	.store		= _pfx##_name##_store,		\
 }
 
-#define CONFIGFS_ATTR_RO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_RO(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IRUGO,			\
 	.ca_owner	= THIS_MODULE,			\
+	.is_visible	= _vis,				\
 	.show		= _pfx##_name##_show,		\
 }
 
-#define CONFIGFS_ATTR_WO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_WO(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IWUSR,			\
 	.ca_owner	= THIS_MODULE,			\
+	.is_visible	= _vis,				\
 	.store		= _pfx##_name##_store,		\
 }
 
+#define CONFIGFS_ATTR(_pfx, _name)			\
+	__CONFIGFS_ATTR(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_RO(_pfx, _name)			\
+	__CONFIGFS_ATTR_RO(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_WO(_pfx, _name)			\
+	__CONFIGFS_ATTR_WO(_pfx, _name, NULL)
+
+#define CONFIGFS_ATTR_VISIBLE(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR(_pfx, _name, _vis)
+
+#define CONFIGFS_ATTR_VISIBLE_RO(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR_RO(_pfx, _name, _vis)
+
+#define CONFIGFS_ATTR_VISIBLE_WO(_pfx, _name, _vis)	\
+	__CONFIGFS_ATTR_WO(_pfx, _name, _vis)
+
 struct file;
 struct vm_area_struct;
 
@@ -156,43 +178,64 @@ struct configfs_bin_attribute {
 	ssize_t (*write)(struct config_item *, const void *, size_t);
 };
 
-#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)		\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO | S_IWUSR,		\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
-	.write		= _pfx##_name##_write,			\
+#define __CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, _vis)		\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO | S_IWUSR,			\
+		.ca_owner	= THIS_MODULE,				\
+		.is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
+	.write		= _pfx##_name##_write,				\
 }
 
-#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IRUGO,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.read		= _pfx##_name##_read,			\
+#define __CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, _vis)	\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IRUGO,				\
+		.ca_owner	= THIS_MODULE,				\
+		.is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.read		= _pfx##_name##_read,				\
 }
 
-#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)	\
-static struct configfs_bin_attribute _pfx##attr_##_name = {	\
-	.cb_attr = {						\
-		.ca_name	= __stringify(_name),		\
-		.ca_mode	= S_IWUSR,			\
-		.ca_owner	= THIS_MODULE,			\
-	},							\
-	.cb_private	= _priv,				\
-	.cb_max_size	= _maxsz,				\
-	.write		= _pfx##_name##_write,			\
+#define __CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, _vis)	\
+static struct configfs_bin_attribute _pfx##attr_##_name = {		\
+	.cb_attr = {							\
+		.ca_name	= __stringify(_name),			\
+		.ca_mode	= S_IWUSR,				\
+		.ca_owner	= THIS_MODULE,				\
+		.is_visible	= _vis,					\
+	},								\
+	.cb_private	= _priv,					\
+	.cb_max_size	= _maxsz,					\
+	.write		= _pfx##_name##_write,				\
 }
 
+#define CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz)			\
+	__CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz)		\
+	__CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz)		\
+	__CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, NULL)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE(_pfx, _name, _priv, _maxs, _vis)	\
+	__CONFIGFS_BIN_ATTR(_pfx, _name, _priv, _maxsz, _vis)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE_RO(_pfx, _name, _priv, _maxsz, _vis)	\
+	__CONFIGFS_BIN_ATTR_RO(_pfx, _name, _priv, _maxsz, _vis)
+
+#define CONFIGFS_BIN_ATTR_VISIBLE_WO(_pfx, _name, _priv, _maxsz, _vis)	\
+	__CONFIGFS_BIN_ATTR_WO(_pfx, _name, _priv, _maxsz, _vis)
+
 /*
  * If allow_link() exists, the item can symlink(2) out to other
  * items.  If the item is a group, it may support mkdir(2).
-- 
2.43.2


