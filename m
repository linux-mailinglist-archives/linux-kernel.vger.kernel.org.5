Return-Path: <linux-kernel+bounces-81807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87804867A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93B81C234BB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DFA12A17C;
	Mon, 26 Feb 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wjJ3N85A"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8977212BEBF;
	Mon, 26 Feb 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961404; cv=fail; b=RlT9EWp7Yr60MEKsrGxS7OF/hrxQWfJsRg0T/STaMX8i5x87oF4GxwCYjjBQCdWVn1sack0WIPpfESl8Twb6u7UNsk8GY2PstKeq88Gz5nnAkhWum2rQYoClyVqKyaKRB3IZYzT2aXHcrepGidkeahKA2KUaAxuVOYNUe9MflDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961404; c=relaxed/simple;
	bh=xDWTUmdpAiHy2sZsA1K0WHKMrI+o24ngea9zbEnq068=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anWIjn+aqgW/qS6GOAcdxcvDAEK/Wdmke3tFJ1SrhhXSIFHOWr1UAxGWIFhcIB9ou2HL0rtseVQU9N2dcFxRl0d3aRu2e8hhjSm046ExkpmRv2i5+d8smE0+W2kyJV9j47ltHcW/O1o/+ESzX7FesFXIWeQmmlgs7yXs2mRvSLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wjJ3N85A; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7CxNm8v93FNS1IDy/Nq9VNOLwxnu757D0WA42xrjbz6+0lld4leITLYcrYmdxYlzoodt18fzUKyYX2ZMAKilGIMcQHQXQDxD27vBY4XNHdEIkFpAXido/LCBx8wEx2lk80naI5p8cH1yki913aur93mIYaVLcdZTpfgBmPwq0+NjGqMKhyOAjT/PLsxCH9OXvGycjotBCubhdgyKXAfBP/rpA7if6y/R2WdHlZofBQp2lzIuzAa3+D1XAjW9dIufb+shzjka0Msp0jconfX9l+7cCdwv1ay5ibNG4NnCRgAKDOWVgD4327Ea8Q9OiVoNKqhHfm3zzvelxXb8OsobA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8M1xkrsufNk3J5PFoOjspbxct9V8YK0UnuCnaptKX48=;
 b=Sz4WC3uc8bDT5vNZa3JomxCQ4KlzAAiDtjysnUHwUm2Hk5EigsjOxpgHTPKpwGNJUqAEGXgeiEbdwByOQPygSY6OqY9uhFH9NhyWlketLmrJ28zLhwifpXP+XCmxmmy0nZ5XgMae1Ct8qB/J0U8IgWen3EsuEzxrIpZcriclywJhwUiMDUHBVV2smd6U5Ts+asBHogChr4DbJ3MpzBrFCTlAMfC7bs7XbDnqyO6lyFEU7hjhmoECcQ3UMbfb/ibgsxVYoMpOuV4uD+yjwfu7IBn5yq4CSi7cu1p8v9UvshsBPx0dsyiw7Dgx/GUVkblgh7vpCm20QCrcanSRPcObUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8M1xkrsufNk3J5PFoOjspbxct9V8YK0UnuCnaptKX48=;
 b=wjJ3N85AWDf096id52VZOUk0s/AUOXQLdUWrezg2a6VTESq5MJj+m7GzAOXHWxBv1cRTOsOuwJyWPD9401kz9paccd4PutHqkdbIKb/fywTbwyXpZZL+w5BcrGM0UichAoY8vU4BonG8W70Wug4uqlNDV4dwFmASDWXaNWypdtY=
Received: from SJ0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:a03:3a1::27)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:30:00 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::f9) by SJ0PR03CA0382.outlook.office365.com
 (2603:10b6:a03:3a1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Mon, 26 Feb 2024 15:29:59 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:29:52 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/3] RAS/AMD/FMPM: Add debugfs interface to print record entries
Date: Mon, 26 Feb 2024 09:29:41 -0600
Message-ID: <20240226152941.2615007-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226152941.2615007-1-yazen.ghannam@amd.com>
References: <20240226152941.2615007-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3dfcb1-292f-47cb-afe8-08dc36dfcb4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aD/BUaOGMVQ6WQ6jHKEDHAz6qD3HQwmQknrR+k1Vi8Z5OeQDmusxUhUbPeXkxjxiKNBlugfvVySiEyzwPV+HQcSD+miCgq5n/Is4/1WN+T3Z/NxFfzgN19JCiXJxbAS6TlLLfLADGj8UO4Xlgx4JYQa03WbLPh4nB1mPgr8bR8DYCmCIPH6hlKSGchlognZTBIlcBXF7MG1Qn4kdW0lsClVR7VBxDkllXZS6449lnzqRYtGjr8O7nj61Gh/RPCy3ZGpSVELXPbaqu5KfY7sDZ5mF3YeoTeH9sJDrZlw8QDoUDpd+zcdDLBjaN7kUI+lwgGvw19N1MuShqIfiBbAO7MiqSsBmC3/I8GpFgi28lu7BivoxLxCbM7vWk3P1mQwdrc1raZfFcV/qdfkamkGCQGgg36YwmMWcxauJ30caS5UkIXYq7AYh/C8HaksnsV5F8o2uoSMc4c+edk+5jJkhF/t9E3My1mFI2SyAFEs3YJBMMFlynwdehXOL5fyvJQC5RmR6hM0/c5tJz7zior3+171U51CKCdjA/J2D7VdfJOanqlOY5zaiphTniAoDqVlYqFyh+WTKbSxVCTJpMGHhmiwhRTJsUc9sSvmyI0WteHLJaM0WP95qgXtqYD6w6G96AObxdb/UxLbU/TfsbuiL4VM6CHoNLZCFXA7AJopIQbSe6ZWqSqnlJ7noQXpYmtvnIa17byiG2Bt7w630oqxs0plv44K1f7lGaa1mmsjkDOMHB708Bp0GYRPkqihMF3ZL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:29:59.4653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3dfcb1-292f-47cb-afe8-08dc36dfcb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526

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
 drivers/ras/amd/fmpm.c | 129 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 04961d36dd9f..967af84b7fe9 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -54,6 +54,8 @@
 #include <asm/cpu_device_id.h>
 #include <asm/mce.h>
 
+#include "../debugfs.h"
+
 #define INVALID_CPU			UINT_MAX
 
 /* Validation Bits */
@@ -114,6 +116,9 @@ static struct fru_rec **fru_records;
 #define INVALID_SPA	~0ULL
 static u64 *sys_addrs;
 
+static struct dentry *fmpm_dfs_dir;
+static struct dentry *fmpm_dfs_entries;
+
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
 		  0xa0, 0x33, 0x08, 0x75)
@@ -150,6 +155,11 @@ static unsigned int sys_nr_entries;
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
 
@@ -799,6 +809,122 @@ static int allocate_records(void)
 	return ret;
 }
 
+static void *fmpm_start(struct seq_file *f, loff_t *pos)
+{
+	if (*pos >= (sys_nr_entries + 1))
+		return NULL;
+	return pos;
+}
+
+static void *fmpm_next(struct seq_file *f, void *data, loff_t *pos)
+{
+	if (++(*pos) >= (sys_nr_entries + 1))
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
+	unsigned int fru_idx, entry, sys_entry, line;
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
+	sys_entry = line - 1;
+	fru_idx	  = sys_entry / max_nr_entries;
+	entry	  = sys_entry % max_nr_entries;
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
+	if (sys_addrs[sys_entry] == INVALID_SPA)
+		seq_printf(f, "%-*s", LONG_WIDTH, "*");
+	else
+		seq_printf(f, "0x%016llx%-*s", sys_addrs[sys_entry], U64_PAD, "");
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
+	if (!ras_debugfs_dir)
+		return;
+
+	fmpm_dfs_dir = debugfs_create_dir(KBUILD_MODNAME, ras_debugfs_dir);
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
@@ -840,6 +966,8 @@ static int __init fru_mem_poison_init(void)
 	if (ret)
 		goto out_free;
 
+	setup_debugfs();
+
 	retire_mem_records();
 
 	mce_register_decode_chain(&fru_mem_poison_nb);
@@ -856,6 +984,7 @@ static int __init fru_mem_poison_init(void)
 static void __exit fru_mem_poison_exit(void)
 {
 	mce_unregister_decode_chain(&fru_mem_poison_nb);
+	debugfs_remove(fmpm_dfs_dir);
 	free_records();
 }
 
-- 
2.34.1


