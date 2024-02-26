Return-Path: <linux-kernel+bounces-81809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F59867A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93F641C2A0A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0C12C7E6;
	Mon, 26 Feb 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4Prv1yUv"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436F12BF04;
	Mon, 26 Feb 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961407; cv=fail; b=E/ssLU2EUHbaoBV3iVx1J3p5sISVvuHJ8+akFniwbWqe2zPCTutZW0P/seTfjyCmrSMCBlPAdIkAA2DliyhpXNRM0KYjlqtF88x9crFexb9+Oz3Gk+CIbyPQon5Ce5vvoGXHRPEgahSePwILI6IfXP1xvN6+xFqR7bRTRI6iA1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961407; c=relaxed/simple;
	bh=O2DaZKUVdJdHfqYpsi8cYS07DrBogz2tu9421v2kQuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxFDPz2cGBGm2GmMDMAjTy6/HyfFEFIIYb75JVeB8kt+HO3o3oNvAIFtRLSfhfb4hzCPA6WepDzxvqBS5gM0mb1DU7HXxxLJj7if5A9tigMK5qrSSrMVGj3g3d6xIdHj64PBnoCJ+BtUf33YsLhDc/308I247dvPkGl6Ezbr+bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4Prv1yUv; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqVG6VV000yJPQftdBl419cFKUnm0vMaVLAdmWmOsEX/Erys/NehTUYD8beJ6UawdkzJaR8CWUMoID8MiF5FKrdVQAj3AgEffkeEMUeDqhcjFENS82LRCM5JTYUPWai1f12mnvkVnXLeUNTnk0pjRFB/ajUuzAm5Jw+PuMnUuJZJYrl5TilXmX8PZPaeSowKBnyLfm6QDjBXtLISV2Ko8vjcy+s65lEApAAtno/2iJ4tlCDAEbT3RRFr0DFZDvsBS6MqU7vB5bSRyfwnkAoORrMnCz570O7TvvFX4aSXiN3S3mjcSJPNIFUa7uAgp0CIVPXOPDThf/tKhRJYduAR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly228eJ8AZmumPzBOy+HtVxFu7gzrh1aPSEfBgI1m6s=;
 b=SPlzADJDEAAVwAGY7E8lgOa88fdKqGCAt+ZkM0LEc5ilCBlsubAD07YzxYC1hBj0aFolCuFm8e40auKyZgad4RNKlx9g4zJrcpIWaARcunnsxV+xOjMhFTX71XSGfs3gSbFQTVWRu6ns/BOdJNL8RK/Wz97RcFyXS8mrMLQskrvU3U/a/SX13hnt0dAtOPyCcwI2GPCaYJrBBp6I1sqnqrjldx7ZsCs4ktOfm/bDbSOb8kOYsidDQgEkGcLaQqhWSfnoIcr+ZSxHhhLFhR/I7ebsrFhz0cxFNHT2QQ9AQsaDQppm5acl/wacdSa9Vsf22Y2vCYv1Sv/Is5AmEqpa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly228eJ8AZmumPzBOy+HtVxFu7gzrh1aPSEfBgI1m6s=;
 b=4Prv1yUvG212E4xpTKqA6g51UjgAFjNKpmXJ6hGj79p+IGeadK0/F8T5DzGbRgjd273yewKcX1fpocJgDy+zE/kMjQyhTOL06ALCQZGKjDoqhEhXhGrFFq1bQbThrTNfFz2FssQ4v2XdGfwxdtvpckOPFOW3hjREq3FMSS8Q00s=
Received: from SJ0PR03CA0384.namprd03.prod.outlook.com (2603:10b6:a03:3a1::29)
 by IA1PR12MB7591.namprd12.prod.outlook.com (2603:10b6:208:429::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 15:29:58 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::93) by SJ0PR03CA0384.outlook.office365.com
 (2603:10b6:a03:3a1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 15:29:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.0 via Frontend Transport; Mon, 26 Feb 2024 15:29:55 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 09:29:51 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <sathyapriya.k@amd.com>,
	<naveenkrishna.chatradhi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/3] RAS/AMD/FMPM: Save SPA values
Date: Mon, 26 Feb 2024 09:29:40 -0600
Message-ID: <20240226152941.2615007-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|IA1PR12MB7591:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c589e48-6623-4733-e01e-08dc36dfc8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ipo+RQenvVmLqTZwuh98kRrQHXqCaLUk8OnjdbmPraIDZvZZhyoBS+OKUBVoY88AszUSMX6YY5fkdCdPZd3MYaW0qbQ2YS33gLRXiHYtNfaPjvd1dUTjvIFuQy73YWH2C0jM+mhLqX1paLKWwwueQD/SbB0Em97JVetnehXPEex4YugWondEwB1muJzyM9tlNBQ84Bm6caSVFPMTm51TQ9gTp+CL9CB2ZHhIRQnbclOtCUs6sIiE7qzOC+CzYgNED7Y/ssielv+0OrnVgvubQRNBiMl8JNrylfPu5OhxHHagdrnPzOhkNarQwWlg7f8MovcbV6JINUjigJ5kwwBC2Gryq1Zf2eGQRUJDK8FVXNHLxpw6psCLJZJQf2vY/MBdZ19YB8+1MfK+CCtNPIEAbY0CZhvH9Yi7i2eYE2npkCN1LZ8x2teY+PMAF6MTKC3XaxudnuorFkH/PzQ+qwQ9T0IDDfwB2KA7e0WUd2BHK4hJstW2EfdSbYAVRJ7f6SxgBDpDNkx3lInLvVYlh2X0sa4oGWG2DdDckkpSwQkZM4nJ6iKKoQ9ig4mdbLmP9kgIanjZR6xBawOgwNHTk32jcKBZ+/xmAjrjpDDs8YuzMkLLB3vWBJD0WXHL0giWlb1O+pEoxH0+qPkJPrraAHeWjOpj1JJrrAJRt0DZs7Z1o/6nC6fkkASObphu7v28c7HJSwwSq6TcKEFt/LU0FaQ2wni00evhSikWadGyW+6jEZgyFZ3gRxcyV6Hs83DwCf5V
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:29:55.3246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c589e48-6623-4733-e01e-08dc36dfc8d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7591

The system physical address (SPA) of an error is not a stable value. It
will change depending on the location of the memory: parts can be
swapped. And it will change depending on memory topology: NUMA nodes
and/or interleaving can be adjusted.

Therefore, the SPA value is not part of the "FRU Memory Poison" record
format. And it will not be saved to persistent storage.

However, the SPA values can be helpful during debug and for system
admins during run time.

Save the SPA values in a separate structure. Update this when records
are restored and when new errors are saved.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/fmpm.c | 54 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 80dd112b720a..04961d36dd9f 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -111,6 +111,9 @@ struct fru_rec {
  */
 static struct fru_rec **fru_records;
 
+#define INVALID_SPA	~0ULL
+static u64 *sys_addrs;
+
 #define CPER_CREATOR_FMP						\
 	GUID_INIT(0xcd5c2993, 0xf4b2, 0x41b2, 0xb5, 0xd4, 0xf9, 0xc3,	\
 		  0xa0, 0x33, 0x08, 0x75)
@@ -140,6 +143,9 @@ static unsigned int max_nr_fru;
 /* Total length of record including headers and list of descriptor entries. */
 static size_t max_rec_len;
 
+/* Total number of entries for the entire system. */
+static unsigned int sys_nr_entries;
+
 /*
  * Protect the local records cache in fru_records and prevent concurrent
  * writes to storage. This is only needed after init once notifier block
@@ -269,6 +275,40 @@ static bool rec_has_fpd(struct fru_rec *rec, struct cper_fru_poison_desc *fpd)
 	return false;
 }
 
+static void save_spa(struct fru_rec *rec, unsigned int entry,
+		     u64 addr, u64 id, unsigned int cpu)
+{
+	unsigned int i, fru_idx, sys_entry;
+	unsigned long sys_addr;
+	struct atl_err a_err;
+
+	memset(&a_err, 0, sizeof(struct atl_err));
+
+	a_err.addr = addr;
+	a_err.ipid = id;
+	a_err.cpu  = cpu;
+
+	sys_addr = amd_convert_umc_mca_addr_to_sys_addr(&a_err);
+	if (IS_ERR_VALUE(sys_addr)) {
+		pr_debug("Failed to get system address\n");
+		return;
+	}
+
+	for (i = 0; i < sys_nr_entries; i += max_nr_entries) {
+		fru_idx = i / max_nr_entries;
+		if (fru_records[fru_idx] != rec)
+			continue;
+
+		sys_entry = i + entry;
+		if (sys_entry < sys_nr_entries) {
+			sys_addrs[sys_entry] = sys_addr;
+			pr_debug("fru_idx: %u, entry: %u, sys_entry: %u, sys_addr: 0x%016llx\n",
+				 fru_idx, entry, sys_entry, sys_addrs[sys_entry]);
+			break;
+		}
+	}
+}
+
 static void update_fru_record(struct fru_rec *rec, struct mce *m)
 {
 	struct cper_sec_fru_mem_poison *fmp = &rec->fmp;
@@ -301,6 +341,7 @@ static void update_fru_record(struct fru_rec *rec, struct mce *m)
 	entry  = fmp->nr_entries;
 
 save_fpd:
+	save_spa(rec, entry, m->addr, m->ipid, m->extcpu);
 	fpd_dest  = &rec->entries[entry];
 	memcpy(fpd_dest, &fpd, sizeof(struct cper_fru_poison_desc));
 
@@ -385,6 +426,7 @@ static void retire_mem_fmp(struct fru_rec *rec)
 			continue;
 
 		retire_dram_row(fpd->addr, fpd->hw_id, err_cpu);
+		save_spa(rec, i, fpd->addr, fpd->hw_id, err_cpu);
 	}
 }
 
@@ -696,6 +738,8 @@ static int get_system_info(void)
 	if (!max_nr_entries)
 		max_nr_entries = FMPM_DEFAULT_MAX_NR_ENTRIES;
 
+	sys_nr_entries = max_nr_fru * max_nr_entries;
+
 	max_rec_len  = sizeof(struct fru_rec);
 	max_rec_len += sizeof(struct cper_fru_poison_desc) * max_nr_entries;
 
@@ -714,6 +758,7 @@ static void free_records(void)
 		kfree(rec);
 
 	kfree(fru_records);
+	kfree(sys_addrs);
 }
 
 static int allocate_records(void)
@@ -734,6 +779,15 @@ static int allocate_records(void)
 		}
 	}
 
+	sys_addrs = kcalloc(sys_nr_entries, sizeof(u64), GFP_KERNEL);
+	if (!sys_addrs) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	for (i = 0; i < sys_nr_entries; i++)
+		sys_addrs[i] = INVALID_SPA;
+
 	return ret;
 
 out_free:
-- 
2.34.1


