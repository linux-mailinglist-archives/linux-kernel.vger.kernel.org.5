Return-Path: <linux-kernel+bounces-97470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0E4876AD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9257E281730
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147875BAE6;
	Fri,  8 Mar 2024 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JGKwY3LV"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5F5B666
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923036; cv=fail; b=ddrq07kV9je5qHPYLUM04Kj13BR1TiMl7UYZNVMeKtoALj9anmhCIiNRTU2cALRthMO+9L6LWKolk57NL3YiwiWiwgheXNjS00B60fl8VwUhraswC4mRyqLLOc5MJcv7QrqhfjqG+1/M33XXYaISgYqn+2CSid93Xxyy5eAxWB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923036; c=relaxed/simple;
	bh=zDpmafLeA6l7+jyUDQOvxjTfKnaLs5Jfkt9kgIPJ8Cs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk21zmTUbpG5VrG+MFRga8+elphKpzMIzqEsvvmXbVfSrD446JP3oE5dHOx4JvgXW4ODtIOYDR5MGdqm+pZnD+28d+stTNEqa240xTiF6pzg4uiAsfa5GfeVNRsjqBnm7gFLPyBJyKvMhLJRc0ci8mkbpbnjhnQUfuWgpS9HqQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JGKwY3LV; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+B3/rUb03kFII19rAzsG7RqygKvURVJb6L8ITa1htwCyEkEhjDXyh8cLuay2YOuc1K2gE7WaJOa1eC0wEEs2Jw+8sxLvD8AXRiCKO35ssu7pPBJqsUTxiIt++1Kgvu1ofjTNrYpdlmOKjUSgIYSi1tYgHnjJCnpf2R0ysu5xmx7j7LUn4jE+t+frg5qs0cMHaTj0DhyfXf06GiKpra01pTj62yFB7UeEp/2Gen5WerkFLrky7l07DbjVmxRlcjSFGhru/G18ZVIH+81DtLwqjgFPaJvowLmTePlb306nQSyygKmpO+9vhxiQCCYH1jvvMOz0TIksvmYdNBWdKZ/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkUAlRSdDuhKwARqIe/C79iDnZnCm247QfCYPxzLWTw=;
 b=fEP0VqwCxz/PDAEZN5S73dFuLuSslv+ZgXjG7OtbjAijwXhmSABwkFQT2ugZBcnHTQlT2DOk+Wrg5sYRN78oBFTqxI0Ag6V28D3q94isnEMEQjnUP5V6nmPp97CvL8mA6Zgq8wTydF8102AlPLRE7H6vCGDC2q/da6NbVaCxnQnCYSOBtMlEJr2rhQ/B2H18666qejX1xQ6NEEFuG4ARoDVTM75VVXWvRIIx3N+90tEn0z2gseIOleA4rMKnqEIyryJpAR8H3IS4XDSQhSfZOffz8fcofdA/8nOI4zqkiZ6xFlaSmYFXDRB9mTGMH+7IpAjY2T5T7FtcI56JZT+jXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkUAlRSdDuhKwARqIe/C79iDnZnCm247QfCYPxzLWTw=;
 b=JGKwY3LVeJER5ZGKnY2G5l35wj/3uMFYELQek8TjANI0eJIHIyjQF2j3tQ/M8O7Xj2O2cECla6CdI3l/fr3WU1sc5/QxGjDsRGNq36PKsopUXc6q9dXEi2VjV5NgawRdEVaV2DmpyBfoySCM1/IkIesexBlHLftGRL1OGqzQ4ok=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 18:37:10 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a9) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Fri, 8 Mar 2024 18:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:37:10 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:37:09 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/14] fs/configfs: Add a callback to determine attribute visibility
Date: Fri, 8 Mar 2024 12:35:27 -0600
Message-ID: <b851e5f74398141bda2f5e6e1f0308cd13b39aa1.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 64282d1a-0e35-470d-acda-08dc3f9ec414
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mQZZi5CvkpKJ5AzjN1eL6AeJ4oNvNCNSFoKMaKJLgypMTtLIsVdk7+S1HfYaX2tMl/WH0uqC+vNV3qjU4/JCoZyIqgfo0oBMlQswVNX80jpi41o7yOLsr3fQqYk6j4cYMaSuByIwJQbw6Y2NAHOuiHmFVc6YhaxzumAW9/HZ4ZIFhvGXPtsMcs69/IAxSUOd6qmuolCtDy3MdJwSltfk+s0ZOGpOtKcRiVMTTKbsZFzZgG7e8CcTgI/9bOjqKOyaO+C4xHTQKSEN8oZSczDv9M3iobWCQf9/LdfIHGkO13vjr+bZmO5rjkesWKgZOcMnxMMyrfB1y88lWykWu/osCI+hkBRwkuAlXWi4Tz+ezPFI7FRzIzcVR7HzAYQiOqgylB8m43sUwSCxXdBhHs+fqO3OwCx6SALwbiVntE3ipqGJ8Q8kY3EPlobtXlOzXaUdW7e+DaCRfd/NLNgd4uU43J7QNLssg9jZRV5kya2CtklMRBnmNf3+LXz/E/79jwb4MvGQAvDw3VnImw7FUa1xcCiNXX7MfLro9UvRjrkBYwBrqR7q4mA3dzxSeWOypxXbwrRRv1LzbFNpPJVjK+eppfD5v6vugKUjnfgr2DxLbZ0OYLLF7Tw0Pd80vOFL5SplsJ/y8avV+yH1jXfnJpIjyBYNzS4W3HVDYsgtZink7T1EdfejlcDRBVwnv+K3TAWcULLmH61AXAbO7Ao5riLg9QYRho9dXkt/oY5ogX+fqjNa9XsA1rkDpk7nQBZ19g9o
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:37:10.6527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64282d1a-0e35-470d-acda-08dc3f9ec414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113

In order to support dynamic decisions as to whether an attribute should be
created, add a callback that returns a bool to indicate whether the
attribute should be display. If no callback is registered, the attribute
is displayed by default.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 fs/configfs/file.c       |  13 +++++
 include/linux/configfs.h | 114 +++++++++++++++++++++++++++------------
 2 files changed, 93 insertions(+), 34 deletions(-)

diff --git a/fs/configfs/file.c b/fs/configfs/file.c
index 0ad32150611e..c758bcc11235 100644
--- a/fs/configfs/file.c
+++ b/fs/configfs/file.c
@@ -451,6 +451,12 @@ int configfs_create_file(struct config_item * item, const struct configfs_attrib
 	umode_t mode = (attr->ca_mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
+	if (attr->ca_is_visible) {
+		mode = attr->ca_is_visible(item, attr);
+		if (!mode)
+			return 0;
+	}
+
 	inode_lock_nested(d_inode(dir), I_MUTEX_NORMAL);
 	error = configfs_make_dirent(parent_sd, NULL, (void *) attr, mode,
 				     CONFIGFS_ITEM_ATTR, parent_sd->s_frag);
@@ -470,9 +476,16 @@ int configfs_create_bin_file(struct config_item *item,
 {
 	struct dentry *dir = item->ci_dentry;
 	struct configfs_dirent *parent_sd = dir->d_fsdata;
+	const struct configfs_attribute *attr = &bin_attr->cb_attr;
 	umode_t mode = (bin_attr->cb_attr.ca_mode & S_IALLUGO) | S_IFREG;
 	int error = 0;
 
+	if (attr->ca_is_visible) {
+		mode = attr->ca_is_visible(item, attr);
+		if (!mode)
+			return 0;
+	}
+
 	inode_lock_nested(dir->d_inode, I_MUTEX_NORMAL);
 	error = configfs_make_dirent(parent_sd, NULL, (void *) bin_attr, mode,
 				     CONFIGFS_ITEM_BIN_ATTR, parent_sd->s_frag);
diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2606711adb18..18011f78ffde 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -112,39 +112,64 @@ static inline void configfs_add_default_group(struct config_group *new_group,
 	list_add_tail(&new_group->group_entry, &group->default_groups);
 }
 
+typedef umode_t (*configfs_is_visible_t)(const struct config_item *item,
+					 const struct configfs_attribute *attr);
+
 struct configfs_attribute {
 	const char		*ca_name;
 	struct module 		*ca_owner;
 	umode_t			ca_mode;
+	configfs_is_visible_t	ca_is_visible;
 	ssize_t (*show)(struct config_item *, char *);
 	ssize_t (*store)(struct config_item *, const char *, size_t);
 };
 
-#define CONFIGFS_ATTR(_pfx, _name)			\
+#define __CONFIGFS_ATTR(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IRUGO | S_IWUSR,		\
 	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
 	.show		= _pfx##_name##_show,		\
 	.store		= _pfx##_name##_store,		\
 }
 
-#define CONFIGFS_ATTR_RO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_RO(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IRUGO,			\
 	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
 	.show		= _pfx##_name##_show,		\
 }
 
-#define CONFIGFS_ATTR_WO(_pfx, _name)			\
+#define __CONFIGFS_ATTR_WO(_pfx, _name, _vis)		\
 static struct configfs_attribute _pfx##attr_##_name = {	\
 	.ca_name	= __stringify(_name),		\
 	.ca_mode	= S_IWUSR,			\
 	.ca_owner	= THIS_MODULE,			\
+	.ca_is_visible	= _vis,				\
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
 
@@ -156,43 +181,64 @@ struct configfs_bin_attribute {
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
+		.ca_is_visible	= _vis,					\
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
+		.ca_is_visible	= _vis,					\
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
+		.ca_is_visible	= _vis,					\
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


