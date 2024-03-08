Return-Path: <linux-kernel+bounces-97471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4745876AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79E99281366
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516FF57332;
	Fri,  8 Mar 2024 18:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AUG3xDAZ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCB5D47A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923042; cv=fail; b=srw3tuDybPUA0xwwZlYeS7MysWvVSI3Q3VkuvmdHnzuFS9gUtwlrd0xakc0isBEWR+UM9/XoaIK4f7+8tRpd5ARoooA/tZrr/Ivs0+To8qWtZ6HSU1aKlyW7+gUcIymOpUkkDaWZnMAPnE2mroFpdpp+gWGfjf/9V506mnESWcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923042; c=relaxed/simple;
	bh=T0sBT2K70G3fossRDQHd8cX6zaEOR0dbDLIeSsY6eQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SX6lxPt2LT8rf8raVeav1Jgy2fqTZBCCDhQ6tRGjvB4x3R1ySkmXxaN9Pw9TUQ0cmIn4ysuDu1VDLe+wYbaueZraO+ZjPDlzE2AnDoGMe6ptNx/Am4ofNW/xaf6PwleNEZ3G6L3tRMMkANRbIGCL5LokBh/KRYRJhgtcVxm5yos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AUG3xDAZ; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILho64SpFJesIDJu2K1hFe0Y/j+MneCBGPFjCbXw2hmqW10khks8kg6n5XP7i0yJdPzGAZR0LZTz8oRY6RYdvFQCDpE0nIL70Iv2v9pv2NO952xYoqZms55QSM3K6AX8g5UxeQcf8RQ9Qw5NY/HJY8NwPoZBIPMds+1yfTy/gK31gvNKPknX4ywe8WoT/KIaux//N7Z/+eCdNfWJplxPOY70RuawTV9F0zlPZwoJmUSA0pvbFzXHGC2yI53tQ3Aj3jXiA8Ofqn97qqA068PrA4rEu+A/6SSO5UAVf2rfmqS6/9alg5gJoG0Qcp7gCOP8VbRUwkhkij5LIJYbPcMybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=239Tm5VZoByxWYfaPNcpwknZ00ofzWk/m10A9j/45h0=;
 b=bMlYbB/acviU13/gBRhu2ZHrxNdQGAgBDwLsFnFwRRceCDyYZE+MIl0ltgi89V0tCsl5FTWHJaAJtnfm5WjBVcKJpKaKIOyoIjvQ6vhiwpM704GErxtW9++o7+mfwFp6jT2VzFlks+4H1ckgXTfBVhEltHWXMIYMiwS/QvfzAUmmL3xWr2jJFZOoEZgsFZswgVKBg6nzM3H/OIz76shRnaX0fpKMY4vhnh+1oQTdGOLOa02FvB6qJdtRJheaRVUHQnbP3ekXPqYst4cM26F2JuCvSKs7La1V7uAWcBT4N0AwUj8q4RAj8czAMXPqcwFy8R2beuWX4iappUJAUS5FZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=239Tm5VZoByxWYfaPNcpwknZ00ofzWk/m10A9j/45h0=;
 b=AUG3xDAZWwjrZpmUd8GZo1C5kfOp4iTwYZn6TELW1yrXpQFjePtME8snfu+szCuB2Fz6XyS7RwmioccjRz7IGZyOO/gup9pSqvESlQhJpl73cm47xvY9gkFo0xPObbO68MM7QOCWX1dgoe03eTKZtCfNcRXMODmAACDGl3DYymk=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by SJ0PR12MB6878.namprd12.prod.outlook.com (2603:10b6:a03:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 18:37:18 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::47) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28 via Frontend
 Transport; Fri, 8 Mar 2024 18:37:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:37:17 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:37:16 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 13/14] x86/sev: Hide SVSM attestation entries if not running under an SVSM
Date: Fri, 8 Mar 2024 12:35:28 -0600
Message-ID: <fabdf811d27a2539d1d016f75d95910b9bca24c4.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SJ0PR12MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: b486f07a-fd34-4735-3ba2-08dc3f9ec866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ox9E2urUE35VXBxZ2VK0881JOLCa4Tqtmq6SzhS5QWZoBr744A2k8knlV2K7rD+SoSALh578NzB1x3IQYVWyJWQ7XYVjN5xR/V4c0q2tWtufShwzH9TxpTXPv62Nvs1mcKpZmkWh0MAe2ouN8tup82ZoomvdMoj5kTsT5etU5/tf/zVGBCTrz8JgEyrk3SFs4I1ygixr2yevqKRnYhzCUAvN6pJq1yJDczixmMBGMuWvuCovVZQuHclpxP37ZNrYFIIASaYP5l1vIMe5Gzf4sQFvcfi66XQM6FnF7dHFG7VFWGkNouF1P3Z0D+u0y0uQrZwgk1yu3vLh7/NkT+nB+5wi+dd/C8cXyyf3Yo1SiUsUAZ+eQLjikyvlmMaYJUx+hY53HQWb9DrGl1XfOilWvp2P5pI1KhhlOzdMMxKoyi3CyQ9mMepSElzL2p7mte6e5Rb1R4OEG2oMdWAD2yrBD0vJM/HUo22dxYWPelzPHektQn+u9Du36d+GNmTj1qgktNcwGJZF1iTgKLvH0+WKbZIxzBENcTQJrrEskLnrZjt7s3Lw3jDzdoqsSbrHbplRjM9qn62esvocRkIfxq4jk8MtyAeQV7U0VtDKAC5Jj7CGgoeW3q1vIlQjPwsFhOzZyK5mFr+7uI3YH9INxHplbcgiAfR2+KewYpdGbQUKgTe0bshnieB0t0sKb9SpW1DhVrOYmVI2xSz17jTdLY9mvWYVekXSsiZsb34Jzx8oYF9/eKKIWv3C8rYE9PyZn5vW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(7416005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:37:17.8824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b486f07a-fd34-4735-3ba2-08dc3f9ec866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6878

Config-fs provides support to hide individual attribute entries. Using
this support, base the display of the SVSM related entries on the presence
of an SVSM.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/coco/core.c        |  4 ++++
 drivers/virt/coco/tsm.c     | 13 +++++++++----
 include/linux/cc_platform.h |  8 ++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d07be9d05cd0..efa0f648f754 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -12,6 +12,7 @@
 
 #include <asm/coco.h>
 #include <asm/processor.h>
+#include <asm/sev.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
 u64 cc_mask __ro_after_init;
@@ -78,6 +79,9 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_GUEST_STATE_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
 
+	case CC_ATTR_GUEST_SVSM_PRESENT:
+		return snp_get_vmpl();
+
 	/*
 	 * With SEV, the rep string I/O instructions need to be unrolled
 	 * but SEV-ES supports them through the #VC handler.
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 07b4c95ce704..2efa6e578477 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -64,6 +64,11 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
 	return container_of(report, struct tsm_report_state, report);
 }
 
+static umode_t svsm_visibility(const struct config_item *item, const struct configfs_attribute *attr)
+{
+	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT) ? attr->ca_mode : 0;
+}
+
 static int try_advance_write_generation(struct tsm_report *report)
 {
 	struct tsm_report_state *state = to_state(report);
@@ -139,7 +144,7 @@ static ssize_t tsm_report_svsm_store(struct config_item *cfg,
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, svsm);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, svsm, svsm_visibility);
 
 static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
 					     const char *buf, size_t len)
@@ -168,7 +173,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, svsm_visibility);
 
 static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
 							 const char *buf, size_t len)
@@ -189,7 +194,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, svsm_visibility);
 
 static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 				       const void *buf, size_t count)
@@ -336,7 +341,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_MANIFEST);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, svsm_visibility);
 
 #define TSM_DEFAULT_ATTRS() \
 	&tsm_report_attr_generation, \
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..f1b4266c1484 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -90,6 +90,14 @@ enum cc_attr {
 	 * Examples include TDX Guest.
 	 */
 	CC_ATTR_HOTPLUG_DISABLED,
+
+	/**
+	 * @CC_ATTR_GUEST_SVSM_PRESENT: Guest is running under an SVSM
+	 *
+	 * The platform/OS is running as a guest/virtual machine and is
+	 * running under a Secure VM Service Module (SVSM).
+	 */
+	CC_ATTR_GUEST_SVSM_PRESENT,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.43.2


