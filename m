Return-Path: <linux-kernel+bounces-86165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4F86C0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DE31F2227F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6DF3C49A;
	Thu, 29 Feb 2024 06:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nHcUIb2u"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F92E415;
	Thu, 29 Feb 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187777; cv=fail; b=J2YbikFk5OvJFvxi/aPrCkG3G8xf+ZE3/3Ysy9bUQWhOX0NoNYuHSnqQAOgOuUsVOV1lP1OQUmPCIeFlpI1Bgn7VYpryigxPEmzYvr5UC+GN6E6inuIRaw6a3pybh7weHYSbdWmEApxfgp+am6SMAC1VLUJxn/9M/SWiwK10oGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187777; c=relaxed/simple;
	bh=RVbikJl+sHQ/i0PajLBdOzeS7lLhV7wty90TnUqhRgI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e6E4+HqMzTCI2kyq1rOSLCSfxpp9Z+cEKQYb+K5lRfjG8sLoQiLKuHojicpchZe3lRYDIVkeLkQdKUeZTKPAJdHoxnAKMYRiqwWU9lWl7FrrFgQJC2CESI2MZdGC1Ao5HycdyF3Y0mbpQRAPmaaxEKXUFjpyRQmTv1g4D0IZPy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nHcUIb2u; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIXLLxtau59TL2TlE7dZUjfhv8LKHB9BdSZCmDKT5rqv9Xeci3Mt6nocLvfhXFnIOvdILu4uY5OLrbfzjJlob6hB/Va/+3p/VMMeIz7gI3M/NEMJ7wJww7KerPuPpIOFQpl4vNZnV93xgZF5GuDP3k/3T0Ec3iKESk+67UwI9ajBoi84lteylY2q1Fh/KOohHxcyxw07p/XIq9Q1JwxXS8gXND3QQ7EUkSuBYazVLhvJXwVLXNK8ciQtCpwvPr3+gi4JolEea47yuoJX75QO2C/7ZvxQA2C+ZAey4Gr79GPzskjuEqBHi8Bg2jAnLeK93Pj+VxOQegqzX4sY6yXTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GREByrcmPJ1umQ89Kz0166OzFwUmSCBN0U7GUNxqByk=;
 b=ZfiRCzPukp0veq+zxAbl5oX7iSgQ0WKQaTeldUs+RjFEWfouW8/mrWVItriOt326UoWKPBeYkekXbPiiag0C+XaVIq+jotSaBdnLl1KLQCtfMaf2dHl3qIreUM+8fmpUnm0C0CMnP/JXMEkXuLLgF4OSdU7kMTk8Vi7ugBas2F9//OC/S87QXyOpXYF1ZtnLsyCEiVuADmhMAgEDnvthweNxXkORUiJla0NdXSZpRP+D+mdcMM7S3BlSyGm5BPEQUHaVqIEX/wacQ/hjl1Mp2QbATZ7LRIgljL+LfBZUGyIwN+DLbaUOuXGsFgjeSfTL0lTbKIJlWJYfiziDdo+8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GREByrcmPJ1umQ89Kz0166OzFwUmSCBN0U7GUNxqByk=;
 b=nHcUIb2uD3yD0ZnrIUoTA5q78vbffIJLg6zMa9oSn8pPslOlumEYOYd9oRzaU3NVVhmF4nvFpSF3XTYUqxgstnplUlGbYSf123tmGKENxSn8xgD3r9Y/50YCRX69VO3w4tqNyoTkv9jBEZZL5LM9G4JyF3Z/ALt7ZYf+ZNVU6Fg=
Received: from CY5PR19CA0053.namprd19.prod.outlook.com (2603:10b6:930:1a::30)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 06:22:52 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::2c) by CY5PR19CA0053.outlook.office365.com
 (2603:10b6:930:1a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 06:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 06:22:51 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 00:22:50 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-acpi@vger.kernel.org>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4] ACPI: APEI: Skip initialization of GHES_ASSIST structures for Machine Check Architecture
Date: Thu, 29 Feb 2024 00:22:45 -0600
Message-ID: <20240229062245.2723548-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: c3408d4c-8fa1-44d6-b320-08dc38eedb9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SlixrivOAus2KmaN7rhtT8331x5EykIh8KdfukyD4AOOgfiiOQTRynEfeea5ZztfRDxtG87Xs/gYGm3R4WZPgWrRfJtckJSwp8AJgc+JxGRQiTUg6bYHQcRM3vuV6y0JTT2h/oAwy8gQLsUy8xURgRYVbLv8rV9N0di6ymkrU3DS4Ue59EGzKSn2JA3JBGmyJsoUYnHcAskdvEhH3IwfoqzpAfSsur+swbBLSNEC00TXUGLdi1tXMXomsjLmpx8bpbSHV/0QCcFWi4CZ54ZtfX8Vk+x4OZtIHGqAkf8dhmlsmxpQzWphwZA9rhQs7AkywImXh47YSApIuoIzhOwNokTfFIXD1ErtjOqDNTOgoI4CgCZ+YCEYDED7fdiqHjWKhdTef/uAMZlQEgxZ254KnQFxHRIA0CXTUQ3aOL1rnTqWk3r0I0g0/F0uA82fdZYL5MioJYTV+SQkNi4hXfTT5EvxGP35vtJsEIRHmLIlNrykvgGzcenB8sYkZSyrj5bSAOzzqzGC9n7wmBTKVmZYvIQiG53mthIG6ObUzt01cfbSVBjYb5gpQpneLsaFcyWF2Xjm6QmnApOCSd6UfnAyRQ+T75TssOK78chtXPH8HbimTU4lTmLP7ZoKTbltz4XMLqMV0QCnWB5qAF6fh4e581gRhqmkSGLtIjtT+nf1cLI2k4OjGjcXZq6v2ri5U66Q9RAYIi8iHbGaDDDsI6ZoXSsInQYDAQ+mwcBr/YBYNjqf94PVs0dI0VCrHKpS17Oe
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 06:22:51.6550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3408d4c-8fa1-44d6-b320-08dc38eedb9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202

To support GHES_ASSIST on Machine Check Architecture (MCA) error sources,
a set of GHES structures is provided by the system firmware for each MCA
error source. Each of these sets consists of a GHES structure for each MCA
bank on each logical CPU, with all structures of a set sharing a common
Related Source ID, equal to the Source ID of one of the MCA error source
structures.[1] On SOCs with large core counts, this typically equates to
tens of thousands of GHES_ASSIST structures for MCA under
"/sys/bus/platform/drivers/GHES".

Support for GHES_ASSIST however, hasn't been implemented in the kernel. As
such, the information provided through these structures is not consumed by
Linux. Moreover, these GHES_ASSIST structures for MCA, which are supposed
to provide supplemental information in context of an error reported by
hardware, are setup as independent error sources by the kernel during HEST
initialization.

Additionally, if the Type field of the Notification structure, associated
with these GHES_ASSIST structures for MCA, is set to Polled, the kernel
sets up a timer for each individual structure. The duration of the timer
is derived from the Poll Interval field of the Notification structure. On
SOCs with high core counts, this will result in tens of thousands of
timers expiring periodically causing unnecessary preemptions and wastage
of CPU cycles. The problem will particularly intensify if Poll Interval
duration is not sufficiently high.

Since GHES_ASSIST support is not present in kernel, skip initialization
of GHES_ASSIST structures for MCA to eliminate their performance impact.

[1] ACPI specification 6.5, section 18.7

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Changes in v2:
1. Since is_ghes_assist_struct() returns if any of the conditions is hit
if-else-if chain is redundant. Replace it with just if statements.
2. Fix formatting errors.
3. Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Changes in v3:
1. Modify structure (mces) comment, per Tony's recommendation, to better
reflect the structure's usage.

Changes in v4:
1. No changes within the patch. Just sending out to gather more attention.
2. Add Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..20d757687e3d 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 static struct acpi_table_hest *__read_mostly hest_tab;
 
+/*
+ * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
+ * structures for MCA.
+ * During HEST parsing, detected MCA error sources are cached from early
+ * table entries so that the Flags and Source Id fields from these cached
+ * values are then referred to in later table entries to determine if the
+ * encountered GHES_ASSIST structure should be initialized.
+ */
+static struct {
+	struct acpi_hest_ia_corrected *cmc;
+	struct acpi_hest_ia_machine_check *mc;
+	struct acpi_hest_ia_deferred_check *dmc;
+} mces;
+
 static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_CHECK] = -1,	/* need further calculation */
 	[ACPI_HEST_TYPE_IA32_CORRECTED_CHECK] = -1,
@@ -70,22 +84,54 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 		cmc = (struct acpi_hest_ia_corrected *)hest_hdr;
 		len = sizeof(*cmc) + cmc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.cmc = cmc;
 	} else if (hest_type == ACPI_HEST_TYPE_IA32_CHECK) {
 		struct acpi_hest_ia_machine_check *mc;
 		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
 		len = sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.mc = mc;
 	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
 		struct acpi_hest_ia_deferred_check *mc;
 		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
 		len = sizeof(*mc) + mc->num_hardware_banks *
 			sizeof(struct acpi_hest_ia_error_bank);
+		mces.dmc = mc;
 	}
 	BUG_ON(len == -1);
 
 	return len;
 };
 
+/*
+ * GHES and GHESv2 structures share the same format, starting from
+ * Source Id and ending in Error Status Block Length (inclusive).
+ */
+static bool is_ghes_assist_struct(struct acpi_hest_header *hest_hdr)
+{
+	struct acpi_hest_generic *ghes;
+	u16 related_source_id;
+
+	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
+	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+		return false;
+
+	ghes = (struct acpi_hest_generic *)hest_hdr;
+	related_source_id = ghes->related_source_id;
+
+	if (mces.cmc && mces.cmc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.cmc->header.source_id)
+		return true;
+	if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.mc->header.source_id)
+		return true;
+	if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
+	    related_source_id == mces.dmc->header.source_id)
+		return true;
+
+	return false;
+}
+
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
 static int apei_hest_parse(apei_hest_func_t func, void *data)
@@ -114,6 +160,11 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 			return -EINVAL;
 		}
 
+		if (is_ghes_assist_struct(hest_hdr)) {
+			hest_hdr = (void *)hest_hdr + len;
+			continue;
+		}
+
 		rc = func(hest_hdr, data);
 		if (rc)
 			return rc;

base-commit: 07a90c3d91505e44a38e74e1588b304131ad8028
-- 
2.34.1


