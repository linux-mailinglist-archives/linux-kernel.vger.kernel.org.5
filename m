Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB67B5BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjJBT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBT7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:59:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A662F93;
        Mon,  2 Oct 2023 12:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFKvBtzEwKDO519QF04Fo3p6ExNt/iehZ6Y1HzDMnv5v+sSdZy7590LgDzKGhH7Hsvsz7KKEl0KW/negwJ1NWBqd5GmNnuQSRmh7coaj5SF7HxUOtVvdhMzhwFIMxPFVSUHhjwzVbTd7HUA4Onv0iVXgd1KbA4nPy0ysr8vRn0LchUJpcWb3hVK0VB1RZykE2BwlczAQH7oAmAYWe01BD56+LNBRbBVr9lubm/I4tIJwAgogg5rv5OfbbzepouKqCmmlj03Tkp0/u/CAVsKV04I/S+MP6rjVWRovw5v8bk85bIssM8vOuf9I6qHUo1EAPvWwtu18/vfmF2u9upDoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5yFwW4bJBzc9wiGkvNlR6JmJ9T+ygeNqKtVaj1/fXw=;
 b=Yr36U87p6iGfvcgnE/HbOKLc4/lYBBTpIWjw4Z9T0rOzwpjwpGYK5iwZ7qchvDIAOP9oVIcIa0UKG3d120Tq0tJa+8qo0NlLKnUBJ5tGlCazmtUbme4zb4ruC7+45ny4zXKSKL7Ze9zKkBgzLftX8ADv3AQy9HckAtXx26OUpVB4B7qZV1J/DKAmH3zulbhkbf0B6maaBi9TZhLIp022yY4OGdDrs4mxCIx3K1emzGhpau/J3qQ31As5i5zmBA/aoxPFEgK0g+Jv4GLNpdSK5B8lGkDiaT8MEa+ktX6ZsdP+gLO1HpA89htnJDf4n4DRCSqB1ucBz1W41BA8kaUDYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5yFwW4bJBzc9wiGkvNlR6JmJ9T+ygeNqKtVaj1/fXw=;
 b=FkkcKiBtGbG9XAF4Oq3hRtohQeFQNaiUqzb3uom3/vgpdZ+fYXZehDUvoOmHGWE566XFrLEEpcd4oKAIzRQfG8vFH5yZAOCNfjIF+SfWCdNsM+ngQfFrncyf2DGYRLhEAO1UhT0fr12A52D0+VUSUtgrV6B/+zbV5GTlFIbV9UM=
Received: from BYAPR21CA0003.namprd21.prod.outlook.com (2603:10b6:a03:114::13)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Mon, 2 Oct
 2023 19:59:42 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::73) by BYAPR21CA0003.outlook.office365.com
 (2603:10b6:a03:114::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.2 via Frontend
 Transport; Mon, 2 Oct 2023 19:59:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 19:59:41 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 2 Oct 2023 14:59:40 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [PATCH v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures for Machine Check Architecture
Date:   Mon, 2 Oct 2023 14:59:32 -0500
Message-ID: <20231002195932.2501674-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcc1670-909c-4394-e39c-08dbc3821dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/nMTBaXrbxBYYQojIFXJSqTKr6rqVhPhN4NhQS33YkHv1/FLCnkUDW1XDMvv3MaIPGxcsra3iD2SpJDzvyIsk8lp1VnNedhLvMZi69VhbQSBnWlso9D81PXCF6LLkY5yOiLBUspHbdSJYkYTPMudUSkUTtg/p1uXIZ0FpcZIk29iWUtJ70VR6X4bywUdFZaczRtKpoN46pvDLiDz3ibZ69EHrwVS1Xorq+Wj9GQ94UVplaKXUaQ2mJJqSfLf36FhEPwgUdfJAog47fXMhqsqzVIr0PZ1OJhEUXhlvt1LxAShBOglAkvV1Qsuiasa6hMDAXv5Za1akUfFwAUWi7aZ0zpCxJbKVqkLdndtCZwQUeJfNg8Xcb0ui0VIFU5+0HvXp3ZODpcQ5VQlujXX6nHWtUBv9zrVd+A0bGLMvNleCKfE0uz2r6XcCHJWcC7RS1hGEJRKiWEkQEaBsi6ECxUFjj369aP2iYjXCVvi2KPW4U4GzrCARiyB4kTJfeRAeFAbidxsQICO1bOSRi9CezCXWmls58a5PlvrXtakrxOxMtYelqhKdGT57U8nNvmdRYGl7mlnAp/IlOYDphzmb3mTcOKOiAcU+D+lumKiUP5fT3tsIK8vfU7TNVRXLfluMeZyk2DURFQ1mr2vmo1cKpVVmZxksecA5t8JoeOFYPJjl+XpksiQ8fDY7iD2lcgFQc+V9zCzirALoI1ufYv96P/VqN53pUP7bmYB/xTU9vcKmz3OOrurEPoZ3Rd6mJNfqeJzNLMGQLkr2VgEjn9sG1gBVcElo11zx/hEt6HgDgrKTY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(2906002)(44832011)(4326008)(5660300002)(26005)(8936002)(8676002)(1076003)(36756003)(41300700001)(2616005)(40480700001)(316002)(70206006)(54906003)(40460700003)(110136005)(336012)(356005)(70586007)(83380400001)(478600001)(6666004)(16526019)(426003)(47076005)(7696005)(82740400003)(86362001)(81166007)(36860700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:59:41.4364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc1670-909c-4394-e39c-08dbc3821dc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
Changes in v2:
1.	Since is_ghes_assist_struct() returns if any of the conditions is hit
if-else-if chain is redundant. Replace it with just if statements.
2.	Fix formatting errors.
3.	Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/acpi/apei/hest.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..99db7621adb7 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -37,6 +37,20 @@ EXPORT_SYMBOL_GPL(hest_disable);
 
 static struct acpi_table_hest *__read_mostly hest_tab;
 
+/*
+ * Since GHES_ASSIST is not supported, skip initialization
+ * of GHES_ASSIST structures for MCA.
+ * During HEST parsing, detected MCA error sources are cached.
+ * Flags and Source Id fields from these cached values are
+ * then referred to determine if the encountered GHES_ASSIST
+ * structure should be initialized.
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
-- 
2.34.1

