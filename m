Return-Path: <linux-kernel+bounces-118111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A588B416
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C5B1C6036F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1305A757F4;
	Mon, 25 Mar 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O5/A8pDd"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647B1272AF
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405701; cv=fail; b=jwwI/oe13KtPl+VwuPZhzAHofp3rn/DwkmzuoHFSHE8taKE/UCQJZ2KyQwmQEs+ioQ/67xfmNX8Fty4J/dX9FsXhR5Vf3kjuaNHJJr9rZrOxxwGbIc5i2kFqQXlAmqFIfi6sqkO1Fqahfg0WGrFJJG+FcQz35kE4mMxV3bsLdcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405701; c=relaxed/simple;
	bh=DDZd0WN5F6BECdbQNJZVbfNtxMnskqrpkK+ff+OnkE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vdm0uHmjrpsfjxc4yZslv+IOUkTBIy3xoRP6tYipepcmwbAzoXBlPIr551gNMJXM+LdD1ZykrL6YXrs0WRK2/7JScaHrvFPVEuslGfJJ9Yn+qNQM08tY4k3XBPdKLxqJz4EWkkTz+TdFM3QZjFKC4JEW8rPpEXaUBYdojQ2qSjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O5/A8pDd; arc=fail smtp.client-ip=40.107.223.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOUvWvzoUi3eCFVVdTn6cnCbYx8EOkXeCKPWuxJHUmARt3TsaB+YPmk4Ly9lBSiE4s++Rmmnhn6Lu6nwGlb+dYG87N2dWANj7GJPDpXIizIheccoLIB2NhAfmUoYIiLhREHkgzVxSr6DvmkhSVzOQI8Y3FS7leRqImcjA7XG4TyG6dXkaMdlkItoJ+z0BqCX9MdfxQkP5osliKtLuegick/mw03jAwGtgusExIw1Lq9f9pUcR5+MeCsDYHTZWYPfibW1QbkbkVmfK2qfarR8zxQMCyDGL6o0u2xQbQ3lzumNP6/nHyFGq7wsVc60EsnfPLSj07Xx0lPn+vKK9Tlojw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bapwT55uQTS6AuYgBCA0ykncqA3KdfOyh2/IbGaBgKM=;
 b=AEsFuHFv8JiStf67GoZ3oVZ3YEZEn1zyBcyz969li3qhWectoNXXh3fajft2hBU8qz5nHT2HED067opuH/Nh0kbMzmvZudt9FScaMktWmU/0zQ/m/ZRBGkHHAxmuZZgDtdghMRoQ/2xwKL54BSVUP30UEZbc/2xma+5rIqLOVdif8DdjAn6j2opCTsbbDA4cetB17YLp2eTS0BlPzZrR+Uif4OCGWOCEGT6yA3ScFrY6ivYA8vK+XPd7S99iCCAQ7K0eagunCd/ZFplWI4a5uvwh0iSa5mHuqgZcOQamdYzG2yywvBgRqPvqz8rK2ahuUij2p6J7s/6QLRRKJL2jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bapwT55uQTS6AuYgBCA0ykncqA3KdfOyh2/IbGaBgKM=;
 b=O5/A8pDdjWkap3RtZfnWjsyboqNK3ntvfEfsGasHPSS8Sj4MuVyLfJLJdGEcgLdKe3lMwhm/Pd/LO4/+832MD88MEa/g9HQKuT/CxEL2VNJkQY7YFCe025p28kKpcOw04iE2iMkq+1sDwOFekBaNodTFA3qfA4prT6tmlQP2i4Q=
Received: from SJ0PR05CA0023.namprd05.prod.outlook.com (2603:10b6:a03:33b::28)
 by CY8PR12MB7124.namprd12.prod.outlook.com (2603:10b6:930:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:28:17 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::55) by SJ0PR05CA0023.outlook.office365.com
 (2603:10b6:a03:33b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 22:28:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:28:17 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:28:16 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 13/14] x86/sev: Hide SVSM attestation entries if not running under an SVSM
Date: Mon, 25 Mar 2024 17:26:32 -0500
Message-ID: <67893f352bc54de61160bfe251cba0bdf0431f37.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|CY8PR12MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: f3511009-b646-439d-d103-08dc4d1ade42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xdW6WWI/WE9jPCWIKhZF/R7upZgon5L7F/OSnVZJ05n6EmtIAKOjC6AEi5ST79Z71NXngStNuHoONHbgXXvU0W6YEemccCra2mTqIIlDIv4XBgecPZ62WbbZZEIF+S+6rBaTh/VhEdka/9R85xlFOprzhxv76mFzPcEg9EN5m3U2enV3f4IDrRhY+o6eGGXDr++MaZAbBWedpzQOioKqNlIl6HpRP5fB/qRfTlX+6JtY2AunnLUZisnddQfUCCIuZeWp6QO46e3mB9lfhsOL4acE8//Mw28WMBJ+Fdrj0YiqacP+PotACbY0ZSZIGRvzVux9iGTxycrpJn8rP38QhGrlw2qHxV9MmfFT2gvI15FqfgKZ6rFgh+tO5aJ4XnDLUuRvbSETMUKy/fB3xq621vE0E76mP8g+sWvY49r6+T4HR2Fqc1WQW3EGKvFcetrrtbhm5jYG2CE8huJZybUgEVqUhGdUmpBfB1+Qz6Wpv4BHkhOWr3z+05CnhQ4Q+3zhmC9wtLjM3SOOHSG6p7HFVRIhpef3Oko3upYLTGt+X+xHhGFTAE9Dm9Ocny7LqC0i7fLKMq5gnb/YuOmZNecAfzx8+YEnnHiL3JnTuww0amyU/tG1qSSQbrkPEkD1yroSXvsTrzNpyZAkAutKWsSmAlBsxATNTR8MM5Ug5/fGM2SHOme0zRUPPIhmv8qSs6qraMC1ra8PHnJiFZ0JCkkLgPwJI6WmbnuXQ/gkdq5NoufI7Hqz0JNsvUwv44ZsszCa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:28:17.1927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3511009-b646-439d-d103-08dc4d1ade42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7124

Config-fs provides support to hide individual attribute entries. Using
this support, base the display of the SVSM related entries on the presence
of an SVSM.

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/coco/core.c        |  4 ++++
 drivers/virt/coco/tsm.c     | 14 ++++++++++----
 include/linux/cc_platform.h |  8 ++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

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
index 46f230bf13ac..d30471874e87 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -64,6 +64,12 @@ static struct tsm_report_state *to_state(struct tsm_report *report)
 	return container_of(report, struct tsm_report_state, report);
 }
 
+static bool provider_visibility(const struct config_item *item,
+				const struct configfs_attribute *attr)
+{
+	return cc_platform_has(CC_ATTR_GUEST_SVSM_PRESENT);
+}
+
 static int try_advance_write_generation(struct tsm_report *report)
 {
 	struct tsm_report_state *state = to_state(report);
@@ -144,7 +150,7 @@ static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, service_provider);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_provider, provider_visibility);
 
 static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
 					     const char *buf, size_t len)
@@ -165,7 +171,7 @@ static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_guid, provider_visibility);
 
 static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
 							 const char *buf, size_t len)
@@ -186,7 +192,7 @@ static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg
 
 	return len;
 }
-CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+CONFIGFS_ATTR_VISIBLE_WO(tsm_report_, service_manifest_version, provider_visibility);
 
 static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 				       const void *buf, size_t count)
@@ -333,7 +339,7 @@ static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
 
 	return tsm_report_read(report, buf, count, TSM_MANIFEST);
 }
-CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+CONFIGFS_BIN_ATTR_VISIBLE_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX, provider_visibility);
 
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


