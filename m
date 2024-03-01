Return-Path: <linux-kernel+bounces-88561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1D186E370
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D30E1C225A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEAC3FB95;
	Fri,  1 Mar 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZj4Ph1w"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2102209F;
	Fri,  1 Mar 2024 14:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303889; cv=fail; b=CYQEXtgI8mGYa2iVCM6HLClmVsGefb9wupN9K3kavUsw1DHtqKPk97t/DdFbl2LN7Fy/W8cQW8GVRxMXzJVxu+l0IdvPFglQ0nmJXqqkrjdrTr6BMphlbtb6AZaqE7BAWQidoJurZwM3BmQyiCEAhPc9Tc1F1KDMlpsVYdtyUwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303889; c=relaxed/simple;
	bh=jawXv2OGl20dD+3vtBqQub2qeJPQXmWeI81g9vZupOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szyWlUX128fKnX6NiCIhufpxxh9jAnipeqFJLOXUGeD36iOs71yXyF/l0PKrtZCCdkrkJqENXQLcoLK5tM5gZhuLHKJx9pr/OQ+w1c5rngkDMoerqYcND3UurHinecYls7o6q/aeQFz2zWj/98noJEMk/B8DbkEF9iOC1oclGC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZj4Ph1w; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iffV8Wb3chfUfffhW1Zmj1U+eYP5SnqRcqjESsxN21b50G7aASRBOV2XENfMvITQmCygCjrp1O+OQRT9XdbzuUuEKOiust9hZNYWmahhFQYTRE0YzYyIHxhNRJlRVsyc2trtz+gG1WzA5Zfc3cGrvYJqtr5H4eEcOtpalzAnYDyDcrnOVLN3Jl3hmtLn/vopsH3zL3xs83IBmU/fRyYhrm9CFrdVLkGKQdqal2TVuDrGxXHlZ1g5GAe6NvLyCsiGkD+FHJsukiVYo9tBQMYvZNJQ3rTB4Rq5Tl7kSgfMqvULX5lrVJsiLNUoZWKAW2+1EOqSO3/7cydkqq3p+cpwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5MjkK1O1gP6wxjQjLWTe3gtWuOp2U7TuEzh0A2PE0Hs=;
 b=Y+PbF9wQthWPzUTiiQyHiB0wdXvGvyNV08SE2cd86wayv80C0LNT7RA85SYcPF9QzNfqfHStgXI7O8Hc9+aV97fTbt+PInS5tUjppNBC/kByr4a1Jx1p3HtK/Vs2Q7mSwVPAnRXHgAV806AOrZjQQ5IYuv5QrJzzKo5zXLU9Lqr4T7L16nxE9tGT3FxNFtby3Pue9V3F1yac9jmInUCSmhIRi+BsJTkTtCLK4gHE4+8MzBB5dStSwptqkcB+TzA8YYeihqUr90znaU1710meUX33lEC+BA61cfilnzZlGLHR4n2kpMszYPGLylOnUClbmyPu8yIi1QcwH9tIShW1fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5MjkK1O1gP6wxjQjLWTe3gtWuOp2U7TuEzh0A2PE0Hs=;
 b=iZj4Ph1wAJjcQcOmeOV6wtWbVTASX0/YS/ZZPtW3uVME3YEP0YHu8KysJqJO9rO+lgSLeBH7KMDO8tCo7axvvGLQPzX+MutEsYItC4qrC1evEUauw4dTn2KJR2n9vGDDDKi9nDkXXy0bG1JgX8Xo3qClOv8nHrkOiWFruqf6vnk=
Received: from SN1PR12CA0049.namprd12.prod.outlook.com (2603:10b6:802:20::20)
 by CY5PR12MB6551.namprd12.prod.outlook.com (2603:10b6:930:41::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 14:38:05 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::58) by SN1PR12CA0049.outlook.office365.com
 (2603:10b6:802:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 14:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 14:38:05 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 08:37:59 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 3/3] RAS/AMD/FMPM: Add debugfs interface to print record entries
Date: Fri, 1 Mar 2024 08:37:48 -0600
Message-ID: <20240301143748.854090-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301143748.854090-1-yazen.ghannam@amd.com>
References: <20240301143748.854090-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CY5PR12MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: eddf2e3f-145e-417e-4520-08dc39fd34d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	coiHbPDx0T08ZOB0TlQje2sIWto3cORLlkoJMaQE+L6+TKw7HOztdsTHQKp501z+Uwf8HPpINydUmNnP+Scp6NxhxwgUVpg1ggM2Ggnc1zIPMnHRnrX2CyZMR6ELR6LkFYogBc+WO5coFIMY7SlWklulFpwwsMWH7wb8eEsQmG1tujtGMINXx/v0bxZBBDABqPOMmtvkGm0L2SWks9f/opXTrkJCQSxUQQ8/I1CpHT01ptDHqRUC849kaZR90E6fYuTBIM1ivLHkcb2chwIS8bTwzCgKJobBNs/i/xkNeZKevALa+jXFaFhe9nbSbtYkEkh4a/q0sHXkhSI8wHqcf4uYCwuCjDCBkjo94BS01WQvrV/5a/ytzn2shHCeNbs9OAlALPHU3l6OrDeSpm7UbsmGoMyuPZEUV1LKVsDr6gSMluI3CMX2AC+zw6LO7qTC/K/9ctmQ5725O9A4pPUEuWrxbdeNdX/zzlg0Gr4Mb5OyuMknOdhLROIq7a5wafq7vzciRDeThykv5AqW2NRwx+QzKmeKrxYnmz5QpCZ3E4uJzpgMm3lI05sCJV9JnuN1fouwUhwAccC0tc4wEsBAzp5OeTAXnAFG8ZFVZAuaAmxjVK8JltPOuLiqAcblod+ZfgXH1VvElMjZa+V7Y7EYEjoZ2UvDFfzzxdHNG1zFMl6WEsgfhQdjm97NiT29A28on6Srqnx0DdLbxbyYR1yL1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:38:05.4781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddf2e3f-145e-417e-4520-08dc39fd34d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6551

It is helpful to see the saved record entries during run time in
human-readable format. This is useful for testing during module
development. And it can be used by system admins to quickly and easily
see the state of the system.

Provide a sequential file in debugfs to print fields of interest from
the FRU records and their entries.

Don't fail to load the module if the debugfs interface is not available.
This is a convenience feature which does not affect other module
functionality.

The new interface reads the record entries and should hold the mutex.
Expand the mutex code comment to clarify when it should be held.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20240226152941.2615007-4-yazen.ghannam@amd.com

v1->v2:
* Update based on patch 1 and 2 changes.

 drivers/ras/amd/fmpm.c | 131 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index a7bb36eb60cb..d670aa11aef4 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -54,6 +54,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
+#include "../debugfs.h"
+
 #define INVALID_CPU			UINT_MAX
 
 /* Validation Bits */
@@ -116,6 +118,9 @@ static u64 *spa_entries;
 
 #define INVALID_SPA	~0ULL
 
+static struct dentry *fmpm_dfs_dir;
+static struct dentry *fmpm_dfs_entries;
+
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
 		  0xa0, 0x33, 0x08, 0x75)
@@ -152,6 +157,11 @@ static unsigned int spa_nr_entries;
  * Protect the local records cache in fru_records and prevent concurrent
  * writes to storage. This is only needed after init once notifier block
  * registration is done.
+ *
+ * The majority of a record is fixed at module init and will not change
+ * during run time. The entries within a record will be updated as new
+ * errors are reported. The mutex should be held whenever the entries are
+ * accessed during run time.
  */
 static DEFINE_MUTEX(fmpm_update_mutex);
 
@@ -813,6 +823,124 @@ static int allocate_records(void)
 	return ret;
 }
 
+static void *fmpm_start(struct seq_file *f, loff_t *pos)
+{
+	if (*pos >= (spa_nr_entries + 1))
+		return NULL;
+	return pos;
+}
+
+static void *fmpm_next(struct seq_file *f, void *data, loff_t *pos)
+{
+	if (++(*pos) >= (spa_nr_entries + 1))
+		return NULL;
+	return pos;
+}
+
+static void fmpm_stop(struct seq_file *f, void *data)
+{
+}
+
+#define SHORT_WIDTH	8
+#define U64_WIDTH	18
+#define TIMESTAMP_WIDTH	19
+#define LONG_WIDTH	24
+#define U64_PAD		(LONG_WIDTH - U64_WIDTH)
+#define TS_PAD		(LONG_WIDTH - TIMESTAMP_WIDTH)
+static int fmpm_show(struct seq_file *f, void *data)
+{
+	unsigned int fru_idx, entry, spa_entry, line;
+	struct cper_fru_poison_desc *fpd;
+	struct fru_rec *rec;
+
+	line = *(loff_t *)data;
+	if (line == 0) {
+		seq_printf(f, "%-*s", SHORT_WIDTH, "fru_idx");
+		seq_printf(f, "%-*s", LONG_WIDTH,  "fru_id");
+		seq_printf(f, "%-*s", SHORT_WIDTH, "entry");
+		seq_printf(f, "%-*s", LONG_WIDTH,  "timestamp");
+		seq_printf(f, "%-*s", LONG_WIDTH,  "hw_id");
+		seq_printf(f, "%-*s", LONG_WIDTH,  "addr");
+		seq_printf(f, "%-*s", LONG_WIDTH,  "spa");
+		goto out_newline;
+	}
+
+	spa_entry = line - 1;
+	fru_idx	  = spa_entry / max_nr_entries;
+	entry	  = spa_entry % max_nr_entries;
+
+	rec = fru_records[fru_idx];
+	if (!rec)
+		goto out;
+
+	seq_printf(f, "%-*u",		SHORT_WIDTH, fru_idx);
+	seq_printf(f, "0x%016llx%-*s",	rec->fmp.fru_id, U64_PAD, "");
+	seq_printf(f, "%-*u",		SHORT_WIDTH, entry);
+
+	mutex_lock(&fmpm_update_mutex);
+
+	if (entry >= rec->fmp.nr_entries) {
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+		goto out_unlock;
+	}
+
+	fpd = &rec->entries[entry];
+
+	seq_printf(f, "%ptT%-*s",	&fpd->timestamp, TS_PAD,  "");
+	seq_printf(f, "0x%016llx%-*s",	fpd->hw_id,	 U64_PAD, "");
+	seq_printf(f, "0x%016llx%-*s",	fpd->addr,	 U64_PAD, "");
+
+	if (spa_entries[spa_entry] == INVALID_SPA)
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+	else
+		seq_printf(f, "0x%016llx%-*s", spa_entries[spa_entry], U64_PAD, "");
+
+out_unlock:
+	mutex_unlock(&fmpm_update_mutex);
+out_newline:
+	seq_putc(f, '\n');
+out:
+	return 0;
+}
+
+static const struct seq_operations fmpm_seq_ops = {
+	.start	= fmpm_start,
+	.next	= fmpm_next,
+	.stop	= fmpm_stop,
+	.show	= fmpm_show,
+};
+
+static int fmpm_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &fmpm_seq_ops);
+}
+
+static const struct file_operations fmpm_fops = {
+	.open		= fmpm_open,
+	.release	= seq_release,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+};
+
+static void setup_debugfs(void)
+{
+	struct dentry *dfs = ras_get_debugfs_root();
+
+	if (!dfs)
+		return;
+
+	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
+	if (!fmpm_dfs_dir)
+		return;
+
+	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
+	if (!fmpm_dfs_entries)
+		debugfs_remove(fmpm_dfs_dir);
+}
+
 static const struct x86_cpu_id fmpm_cpuids[] = {
 	X86_MATCH_VENDOR_FAM(AMD, 0x19, NULL),
 	{ }
@@ -854,6 +982,8 @@ static int __init fru_mem_poison_init(void)
 	if (ret)
 		goto out_free;
 
+	setup_debugfs();
+
 	retire_mem_records();
 
 	mce_register_decode_chain(&fru_mem_poison_nb);
@@ -870,6 +1000,7 @@ static int __init fru_mem_poison_init(void)
 static void __exit fru_mem_poison_exit(void)
 {
 	mce_unregister_decode_chain(&fru_mem_poison_nb);
+	debugfs_remove(fmpm_dfs_dir);
 	free_records();
 }
 
-- 
2.34.1


