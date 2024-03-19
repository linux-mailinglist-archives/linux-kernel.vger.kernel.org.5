Return-Path: <linux-kernel+bounces-107473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7687FCF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA09281E50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305907FBBC;
	Tue, 19 Mar 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W6+nC5U+"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1837F7DF;
	Tue, 19 Mar 2024 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848020; cv=fail; b=MQKPNGKtXDB9N9uar/IZKrvMu0LP/OtJaq6+98TQnlt7gztv2oxVAHXynWjXN0jlAS+kmXuKSjllwqAAben+tNUAzSBqWge0LqjC0dttBHV4xZGeG95hVZkmO2D7FFAvjNCo66vNHg8kUeMiHdIaSq+rv/M9NZAIhYZYlYCJ/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848020; c=relaxed/simple;
	bh=DeHO9SdCsbnavh0nfXCvqsLRFNY5Ay0bocBPYkIMBF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3DQzw/Vq+5zagwAaIA3+gp+qS6Fv6yL/oofJ/0BkIeCB4iYLqitj4OvrxpO5LC+TuVY9Jbfmst0rQ9ombbCg40bLoYbGMJZb2zk2L4DN4qpbFk+W5NTYQ4K23zOUmQN8iHuWUdY9bvpUmKf+RzCfL3ttA8Ut1GvT9E72FkfOL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W6+nC5U+; arc=fail smtp.client-ip=40.107.95.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkAhnjk+ENjFdsc3TlhTBfjattda0Uw5cve1xm5X0Fm4OoYKLFTPr/nWiTxYiPJ30+CGYGXRhv/k5oc/lSZ2Dxeqa0DXYkKomdQaFQVpW3P+InmOBBDNdFL3DhSppROyi4UxMFzuCuLw/BN8x1DpnN3MgatcqY18CIgRdOnGGoBP8CUWpyAWDHkzvBrUZiuLHP24xzJq3AMzstYAeklseufOKCxvZrChxV1lPjBQWb1ptlrcn8BWZ9gS9nqx/GX3g6yTFq5pmoOBcZBwdBxbwOKxvAeoFHQl9XGd513MLLUfoCZpEvnVpY3zMyGsS1aEP7ceHJo9ET3W+l3GLl7RUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTF/HzIgr0bisGILVrbHQOh0UlydRgUyeafyM+P0L+4=;
 b=f7uAt6yEpE0PtpkTiJ9i45XKfaiI4V8VeBGYZhhg+I3aQklnnMxo/dzTxwy924dnzAigOl5vU86l9gpihg484mTM5P9y4yK5t2MWSq7MMc7wcJM1LfqpRXQUeUr6pvmYlnBfCwD22wlEK4yvB3NwqXiDW3XTLN16GXxQBziMFVvOXrg3/60gcBXGcX6ZU6HkkwFNj6IvdAEqbSTQqCXsn7wzg8wlD/ScJyLX93h4rjaUSkab06GOxa63WLyWaHyGj/bJF+7XKNzibIJb3mW7/TKBrmrSdVi1CgAs0wl5WXxDRR5YDB0o0Pkj3DKtmhSYQXBGC2a3Jxl+V0hU6acOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTF/HzIgr0bisGILVrbHQOh0UlydRgUyeafyM+P0L+4=;
 b=W6+nC5U+qf06BaZnq91KKhil0Cr5nX31RLFFCTz7GvbMS2uU6zKYvS9jV0nTE2jBt1tvScx+mJ+F5sMQPz9JodtsyO1mRrfzQWz5HHIR0BbeU8ip7vPZSsTylQmTJVWhqkygv0xSWGm3tzwDYXGqdjYTtmtyCZrngcsAJXMMaic=
Received: from MW4PR03CA0091.namprd03.prod.outlook.com (2603:10b6:303:b7::6)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 11:33:34 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::f4) by MW4PR03CA0091.outlook.office365.com
 (2603:10b6:303:b7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Tue, 19 Mar 2024 11:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 11:33:34 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 06:33:33 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <naveenkrishna.chatradhi@amd.com>,
	<muralidhara.mk@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/2] RAS/AMD/FMPM: Safely handle saved records of various sizes
Date: Tue, 19 Mar 2024 06:33:22 -0500
Message-ID: <20240319113322.280096-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319113322.280096-1-yazen.ghannam@amd.com>
References: <20240319113322.280096-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 47a1490b-bb83-4217-eb82-08dc4808695c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3zXS6yooiyYKfOciHf4xq2d9CX21OtbvsZ3f0e9mcyFEba/56GFEgRY76WRDv9bbtsZy3SmYWN4sIqJKCIxGOo1V7U2KxCv9VWMtcA1DdlacLBouBeoAI/rWEXIcAaLn9Bre4TgkLFPTxPD9dR+DRxaWmau+102Yv+0nH78k1MVfrJZa0Izno7dZDLqJuGmCa5rVfxTPHUqc2fe0L97quj449u7quYjFNveq9rCcdyctGBaYqPXhE2hvO+sVZmgC5NR5JVHeE8qqLQu6t3nO/8+v3QwTudGynxQppuUAHVtpOxnXpXKluNUHnEcCYTBjYHA+P3Zci74Q2a6iZq1mJhaY8ijPLpruYaMR+ZLaXgip/524ghrtHCctvGCwRhBV6Cx1DmwQkQzkI9ZhWE7gDE9Ak8j+Cv5+fkAvJ8SUB4S66tE4zQt0xdQ1+ArveV1pDLfI1zzAY2hj6UC0NRQH+K7UXGyNC9eplLgMDREvnvgI00VlDD1KAbBxpQ7cXBqONZSUmCJX+XvwnTo0t56FQgo1P/xiCLx2B+8O420WwIbJgfFP5XQO2XtegLHCMvna1q08VJtoyvQ3ASHV7QT2NgrTtOnnsgXgsa1kHZYq1iVmv/c5lcw8bYWG73m+fsR0hkGs9kfbbQ9YgH/VkCZcTRvcixX0GTRBbu6QLRo/hZAP9mofrTt8xfW5cYx+vLdGlUss6LHtcl6MHF0zP/aqBKN4z6Dd2iff8DI4gv/JowgSmwuAWi088z4Hfp0WHDTQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 11:33:34.1278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a1490b-bb83-4217-eb82-08dc4808695c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150

Currently, the size of the locally cached FRU record structures is
based on the module parameter "max_nr_entries".

This creates issues when restoring records if a user changes the
parameter.

If the number of entries is reduced, then old, larger records will not
be restored. The opportunity to take action on the saved data is missed.
Also, new records will be created and written to storage, even as the old
records remain in storage, resulting in wasted space.

If the number of entries is increased, then the length of the old,
smaller records will not be adjusted. This causes a checksum failure
which leads to the old record being cleared from storage. Again this
results in another missed opportunity for action on the saved data.

Allocate the temporary record with the maximum possible size based on
the current maximum number of supported entries (255). This allows the
ERST read operation to succeed if max_nr_entries has been increased.

Warn the user if a saved record exceeds the expected size and fail to
load the module. This allows the user to adjust the module parameter
without losing data or the opportunity to restore larger records.

Increase the size of a saved record up to the current max_rec_len. The
checksum will be recalculated, and the updated record will be written to
storage.

Fixes: 6f15e617cc99 ("RAS: Introduce a FRU memory poison manager")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 drivers/ras/amd/fmpm.c | 55 ++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 9d25195b4538..271dfad05d68 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -150,6 +150,8 @@ static unsigned int max_nr_fru;
 /* Total length of record including headers and list of descriptor entries. */
 static size_t max_rec_len;
 
+#define FMPM_MAX_REC_LEN (sizeof(struct fru_rec) + (sizeof(struct cper_fru_poison_desc) * 255))
+
 /* Total number of SPA entries across all FRUs. */
 static unsigned int spa_nr_entries;
 
@@ -475,6 +477,16 @@ static void set_rec_fields(struct fru_rec *rec)
 	struct cper_section_descriptor	*sec_desc = &rec->sec_desc;
 	struct cper_record_header	*hdr	  = &rec->hdr;
 
+	/*
+	 * This is a saved record created with fewer max_nr_entries.
+	 * Update the record lengths and keep everything else as-is.
+	 */
+	if (hdr->record_length && hdr->record_length < max_rec_len) {
+		pr_debug("Growing record 0x%016llx from %u to %zu bytes\n",
+			 hdr->record_id, hdr->record_length, max_rec_len);
+		goto update_lengths;
+	}
+
 	memcpy(hdr->signature, CPER_SIG_RECORD, CPER_SIG_SIZE);
 	hdr->revision			= CPER_RECORD_REV;
 	hdr->signature_end		= CPER_SIG_END;
@@ -489,19 +501,21 @@ static void set_rec_fields(struct fru_rec *rec)
 	hdr->error_severity		= CPER_SEV_RECOVERABLE;
 
 	hdr->validation_bits		= 0;
-	hdr->record_length		= max_rec_len;
 	hdr->creator_id			= CPER_CREATOR_FMP;
 	hdr->notification_type		= CPER_NOTIFY_MCE;
 	hdr->record_id			= cper_next_record_id();
 	hdr->flags			= CPER_HW_ERROR_FLAGS_PREVERR;
 
 	sec_desc->section_offset	= sizeof(struct cper_record_header);
-	sec_desc->section_length	= max_rec_len - sizeof(struct cper_record_header);
 	sec_desc->revision		= CPER_SEC_REV;
 	sec_desc->validation_bits	= 0;
 	sec_desc->flags			= CPER_SEC_PRIMARY;
 	sec_desc->section_type		= CPER_SECTION_TYPE_FMP;
 	sec_desc->section_severity	= CPER_SEV_RECOVERABLE;
+
+update_lengths:
+	hdr->record_length		= max_rec_len;
+	sec_desc->section_length	= max_rec_len - sizeof(struct cper_record_header);
 }
 
 static int save_new_records(void)
@@ -512,16 +526,18 @@ static int save_new_records(void)
 	int ret = 0;
 
 	for_each_fru(i, rec) {
-		if (rec->hdr.record_length)
+		/* No need to update saved records that match the current record size. */
+		if (rec->hdr.record_length == max_rec_len)
 			continue;
 
+		if (!rec->hdr.record_length)
+			set_bit(i, new_records);
+
 		set_rec_fields(rec);
 
 		ret = update_record_on_storage(rec);
 		if (ret)
 			goto out_clear;
-
-		set_bit(i, new_records);
 	}
 
 	return ret;
@@ -641,12 +657,7 @@ static int get_saved_records(void)
 	int ret, pos;
 	ssize_t len;
 
-	/*
-	 * Assume saved records match current max size.
-	 *
-	 * However, this may not be true depending on module parameters.
-	 */
-	old = kmalloc(max_rec_len, GFP_KERNEL);
+	old = kmalloc(FMPM_MAX_REC_LEN, GFP_KERNEL);
 	if (!old) {
 		ret = -ENOMEM;
 		goto out;
@@ -663,24 +674,32 @@ static int get_saved_records(void)
 		 * Make sure to clear temporary buffer between reads to avoid
 		 * leftover data from records of various sizes.
 		 */
-		memset(old, 0, max_rec_len);
+		memset(old, 0, FMPM_MAX_REC_LEN);
 
-		len = erst_read_record(record_id, &old->hdr, max_rec_len,
+		len = erst_read_record(record_id, &old->hdr, FMPM_MAX_REC_LEN,
 				       sizeof(struct fru_rec), &CPER_CREATOR_FMP);
 		if (len < 0)
 			continue;
 
-		if (len > max_rec_len) {
-			pr_debug("Found record larger than max_rec_len\n");
-			continue;
-		}
-
 		new = get_valid_record(old);
 		if (!new) {
 			erst_clear(record_id);
 			continue;
 		}
 
+		if (len > max_rec_len) {
+			unsigned int saved_nr_entries;
+
+			saved_nr_entries  = len - sizeof(struct fru_rec);
+			saved_nr_entries /= sizeof(struct cper_fru_poison_desc);
+
+			pr_warn("Saved record found with %u entries.\n", saved_nr_entries);
+			pr_warn("Please increase max_nr_entries to %u.\n", saved_nr_entries);
+
+			ret = -EINVAL;
+			goto out_end;
+		}
+
 		/* Restore the record */
 		memcpy(new, old, len);
 	}
-- 
2.34.1


