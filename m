Return-Path: <linux-kernel+bounces-88562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8986E373
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527671F228A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6517C3987B;
	Fri,  1 Mar 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="by6/6/8V"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835C3A8E8;
	Fri,  1 Mar 2024 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303892; cv=fail; b=ejdrpeOeHbbhTJfNhcQumzF/uANI7oF64JtsLZshoYHztmp0WL3Ip6SpTHQT8kHu3jIAh0w63pq4SHWQ7rqjrV2yo7SJBpr1ZDbZLBfO67GUl5zvegmwj3y1fTnxcoKGwv610k3HZ12gntDNXaVe2Y4RxlfG4K4+v5X0a8hC+8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303892; c=relaxed/simple;
	bh=mkew6BgxINgrP+SrOug7QFgSoXrMDkXyQzPM/4XRYvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mCgpKt9Zcdf13HW4dgzhvvQugRhTQdUu8yLAWgmByM5GPa6Fg8RbAhbXl7/ouKuJh0l3kjy8e51/RMoLBcTLiFAfrzdLoM5Hm0UTneuZ7XmI6HHd9I94aHOiwo2q3kQE9bV8VXdQ/JIFE/zb7pQlChy+yTCQ/JQ8eIASHOIZWdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=by6/6/8V; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRFzbZOhSOpaNJqFpKdqeICvpjkrOLasM95+JNnly5eqvUkAHtNHGLzrPXCJ0t8U+tbIb+33tbbS5amCq9x2BdAtEUt42KA598EdF1F7kZUH/ZMxkhCU/HRiN80XRxuFk9muVny/G2cC9/Q0Q2eDvCWEtsSzwdSD3e2wjd8c2j5G3kdEvAMw73ckDEwZcKNAHGJPK+e0UPT6NNLIJ3W3dzpZYjUYFal7cjskupJyn8p/ldjvaQWV76gcaK398333h1/tNLZKf/79T6KLzqtm6lYIzMGc0lyYzHcn3Fgd0DOusQ9fH7cBdajUFVCHnCn/rbUz7W88edYbu5E4BmtVDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQDlZU/CCXiCX74FYVwpVtLyq9aqakrmIEie4cQYDj0=;
 b=FIYwyfC0iejtie6s5aM/hM1MaUlbDvdz/FoydnMVfbVMi70FxeBADWB4e/0jpdIXahpdwhMuOObLW7M6MGsunrUnUGVxMdABP9XPpDYTzIkjg7OE7+VutOdaN/GmnFEAw5XiWInV2qddX3Vik3GvIvkqIh92tvIPd+OvhTxTTM+zLKoTvAP5ClE5fdzDUF35OyyZOb4hc05BVjNPQHBeZbiPtRqFbk2Ce+MVe4VwTlnRhUb1up1MZIEWayBL7ns3LAYLHpwrk/Qvhk09HG2IWVTj8vXMioGFmJRTVpLRIbBKprtEb8bfkDUeFUNHPwIH3/7s4YuD+ttTWKO/dCw9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQDlZU/CCXiCX74FYVwpVtLyq9aqakrmIEie4cQYDj0=;
 b=by6/6/8VxgbmYrRzlEWIkso1Txrv7ngke7iaYH1n5HFzTZIdiBLYkSF+z6ISrxDpMVt/iBFsvazB9gje8vwotI4LzaGTRvwUoQIIUvVTg1KF1NfcL9WoPhFAOE5MnOMdw1HGilu5rqIKthiLQzNLWT+fOvgnjr9+uB0M1v0DKwE=
Received: from SN1PR12CA0058.namprd12.prod.outlook.com (2603:10b6:802:20::29)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 14:38:05 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::c7) by SN1PR12CA0058.outlook.office365.com
 (2603:10b6:802:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Fri, 1 Mar 2024 14:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 1 Mar 2024 14:38:04 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 08:37:59 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 2/3] RAS/AMD/FMPM: Save SPA values
Date: Fri, 1 Mar 2024 08:37:47 -0600
Message-ID: <20240301143748.854090-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 993f285e-dbe7-4e7d-abb0-08dc39fd3476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1hHDxRehyIU/ZawTVBEUnUuXLy9byyToZElLVlSXYUzYnMFYSvqaixoCLH6FabI7Y3VnHyoInWp/DPwkm8mBRO66C0y3gkw+GWlHlp6oJp6VKfx+e/+fB/5FZLCQ8y0UUovEJS2l9T4cdXd7W27DMqQ1GQY6lxCNXlVdFV7zB2o3pDwMQuf1EWUSKsE8+znAysicR87cH+2SBICdz9ufsGTcDmX6yvHn58Mesit2JtpFB0B8+S9GK+C2y/2MmFlfFmWCCD4fqDXfxRmEFOJODMywZyXpiPUZBHU3AoazVVKygPS0P+yK85U8WQIMhsecD+mCT5dh2hCcPxP7sAimFI9WsomV6/OQs8Io4C9RK1ETrjJZ924okyIenwPGthUqfG7zCZLSCwrArUIfMyX60ofsSjtpkaggsFhkidmq8v2fRzhi4AHdCGpyzT0n/xbFHugs+ARmJq/z0F8K+kvtj9I5/OEHMd/VjRO3W9ttSU1hVTL6xjheEhh6hsYcUNRd/tHooRuohMJkvOqinDpVPuLPAEoLN1OmIc0Z+2h3pl1evQBjNWhyy4FyoOpQDiGQmeTi50CaCg9phT0k5OXf0Gz8+EPI6kGpZRIE5Fxr+KaSrtGPpMKGSi7VGe2tj3oBtmRfZaPGAF0fTLMR04IRcPk9E9QzugsgyxPpBUnMvBP5cQFCo7YuJpbMfH1mZBHgwg/8dQpyynIiqeQ2YFSXEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 14:38:04.8844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993f285e-dbe7-4e7d-abb0-08dc39fd3476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

The system physical address (SPA) of an error is not a stable value. It
will change depending on the location of the memory: parts can be
swapped. And it will change depending on memory topology: NUMA nodes
and/or interleaving can be adjusted.

Therefore, the SPA value is not part of the "FRU Memory Poison" record
format. And it will not be saved to persistent storage.

However, the SPA values can be helpful during debug and for system
admins during run time.

Save the SPA values in a separate structure. This is updated when
records are restored and when new errors are saved.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20240226152941.2615007-3-yazen.ghannam@amd.com

v1->v2:
* Changed variable names to remove "sys_" prefix. (Boris)
* Used "spa_" prefix to highlight that these are for SPA values. (Yazen)
* Added warning to "index out-of-bound" condition. (Boris)
* Reworked save_spa() flow to get a valid array position before saving
  SPA value (Yazen).

 drivers/ras/amd/fmpm.c | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 80dd112b720a..a7bb36eb60cb 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -111,6 +111,11 @@ struct fru_rec {
  */
 static struct fru_rec **fru_records;
 
+/* system physical addresses array */
+static u64 *spa_entries;
+
+#define INVALID_SPA	~0ULL
+
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
 		  0xa0, 0x33, 0x08, 0x75)
@@ -140,6 +145,9 @@ static unsigned int max_nr_fru;
 /* Total length of record including headers and list of descriptor entries. */
 static size_t max_rec_len;
 
+/* Total number of SPA entries across all FRUs. */
+static unsigned int spa_nr_entries;
+
 /*
  * Protect the local records cache in fru_records and prevent concurrent
  * writes to storage. This is only needed after init once notifier block
@@ -269,6 +277,52 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 	return false;
 }
 
+static void save_spa(struct fru_rec *rec, unsigned int entry,
+		     u64 addr, u64 id, unsigned int cpu)
+{
+	unsigned int i, fru_idx, spa_entry;
+	struct atl_err a_err;
+	unsigned long spa;
+
+	if (entry >= max_nr_entries) {
+		pr_warn_once("entry out-of-bounds\n");
+		return;
+	}
+
+	for (i = 0; i < spa_nr_entries; i += max_nr_entries) {
+		fru_idx = i / max_nr_entries;
+		if (fru_records[fru_idx] == rec)
+			break;
+	}
+
+	if (i >= spa_nr_entries) {
+		pr_warn_once("record not found");
+		return;
+	}
+
+	spa_entry = i + entry;
+	if (spa_entry >= spa_nr_entries) {
+		pr_warn_once("spa_entries[] index out-of-bounds\n");
+		return;
+	}
+
+	memset(&a_err, 0, sizeof(struct atl_err));
+
+	a_err.addr = addr;
+	a_err.ipid = id;
+	a_err.cpu  = cpu;
+
+	spa = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+	if (IS_ERR_VALUE(spa)) {
+		pr_debug("Failed to get system address\n");
+		return;
+	}
+
+	spa_entries[spa_entry] = spa;
+	pr_debug("fru_idx: %u, entry: %u, spa_entry: %u, spa: 0x%016llx\n",
+		 fru_idx, entry, spa_entry, spa_entries[spa_entry]);
+}
+
 static void update_fru_record(struct fru_rec *rec, struct mce *m)
 {
 	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
@@ -301,6 +355,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	entry  = fmp->nr_entries;
 
 save_fpd:
+	save_spa(rec, entry, m->addr, m->ipid, m->extcpu);
 	fpd_dest  = &rec->entries[entry];
 	memcpy(fpd_dest, &fpd, sizeof(struct cper_fru_poison_desc));
 
@@ -385,6 +440,7 @@ static void retire_mem_fmp(struct fru_rec *rec)
 			continue;
 
 		retire_dram_row(fpd->addr, fpd->hw_id, err_cpu);
+		save_spa(rec, i, fpd->addr, fpd->hw_id, err_cpu);
 	}
 }
 
@@ -696,6 +752,8 @@ static int get_system_info(void)
 	if (!max_nr_entries)
 		max_nr_entries = FMPM_DEFAULT_MAX_NR_ENTRIES;
 
+	spa_nr_entries = max_nr_fru * max_nr_entries;
+
 	max_rec_len  = sizeof(struct fru_rec);
 	max_rec_len += sizeof(struct cper_fru_poison_desc) * max_nr_entries;
 
@@ -714,6 +772,7 @@ static void free_records(void)
 		kfree(rec);
 
 	kfree(fru_records);
+	kfree(spa_entries);
 }
 
 static int allocate_records(void)
@@ -734,6 +793,15 @@ static int allocate_records(void)
 		}
 	}
 
+	spa_entries = kcalloc(spa_nr_entries, sizeof(u64), GFP_KERNEL);
+	if (!spa_entries) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	for (i = 0; i < spa_nr_entries; i++)
+		spa_entries[i] = INVALID_SPA;
+
 	return ret;
 
 out_free:
-- 
2.34.1


