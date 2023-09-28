Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1917B256F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjI1SmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjI1SmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:42:23 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1B99;
        Thu, 28 Sep 2023 11:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1R5CBeVDXWWENTRj+iM6L6nd4cHMPlSL3TfjTxgyyLNP7HXvuxPqlzrNRNkYEhYcUIG33sZgUly4JL/w/xW199EVyXaYxF/7H9lEQfCA//yrc0HW9rpvXtAsFC2QSKT+VQ10qZm/z2nWVzfMWuUMoAtjuwM+OCvjD60xs6F5lXd4pM1qpJgq1Mg0pH1YEcdHjFKUrWSsM+KIJ5nW6PWST8eNfBei5jpo3IoGq9Duq4a/qF9X+iMtO78d2qy7RS0hpfDULr+bjfbg3YFw132YlEt3WAGJCev6Bol53SwCze7MUmboOW9bB92ll1BdUeKio4iImd3ZOqrlwhZ8yy9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol5nssC5+fw/6Cf/UJWgTRVcQM1JdycOEWFjR/DYgkI=;
 b=H9AIQdxgDlz2r057U46n5GueeeE2QWawZs+TFZ+Tth1xGyLz523Pr5i3sdeDIwN6UVrNppRDA2Z4BoFKKTigM7PiqS0xSd2ZX3EcQDhreepjp17KnZIdFEeiDPaWKvxj2qs58vThQEaM8aDpi9EQm8+6FYuB06AYn/GD13lrm+kWIJvSLplalJ9yTay1/B6J9UAiT9Rv9j9RHWhoqq8kLSDzJyFDpZf3tPk5AklOS3BlmKJeTSWsooTCG0L6jcJwMoUcifPC6ZGLaFKWn/CUhgRykSMO9G0UAGj3/V2oz35xAP1dQyc69FbRMOkcEQJgYlh2NY7yam3WqIly8ZQDkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol5nssC5+fw/6Cf/UJWgTRVcQM1JdycOEWFjR/DYgkI=;
 b=YSuFalLfBUPfRhOkIAnFHchlsVjdrPCVWfhDo7ZmDQQpwNrgD1xP6FKSvZSpQ3bcFoRyFJiCIlM8ODmgBR0w8yPIlRAkDVMvRzCjLbHBCgr7wuur0m+MRCTEhats5cWaNDPew1lELzvgVd0pLkUkpoTtpRB5xTxKolwBzen5b/o=
Received: from DM6PR13CA0046.namprd13.prod.outlook.com (2603:10b6:5:134::23)
 by DS0PR12MB8041.namprd12.prod.outlook.com (2603:10b6:8:147::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Thu, 28 Sep
 2023 18:42:17 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::1b) by DM6PR13CA0046.outlook.office365.com
 (2603:10b6:5:134::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.13 via Frontend
 Transport; Thu, 28 Sep 2023 18:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 28 Sep 2023 18:42:17 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 28 Sep 2023 13:42:16 -0500
From:   Avadhut Naik <avadhut.naik@amd.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
        <avadnaik@amd.com>
Subject: [PATCH] ACPI: APEI: Skip initialization of GHES_ASSIST structures for Machine Check Architecture
Date:   Thu, 28 Sep 2023 13:42:04 -0500
Message-ID: <20230928184204.1511111-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|DS0PR12MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: 654f99ff-6bd2-495a-4a1b-08dbc052a3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hVLltK7GZzRbxgpUaUt3HQGheIX/2pLqnjlJxtVU0n6NPKJmdA5+hL1NkiV8ZvfqFexY3PDPGL9d9s7KIUYVZMIpacFbXsdljpFZmemgiVJgzduw+7c9ZXRzHGnl8DePWrYt/BuqWMwXqMIMuT5/O8hZv2bdVH1GdQ3zYPyBSNCElT/XN+2eE2t+4BDVTCyAXMHcx3cmNtjVP/n67CNdiPlFhBLMR9OnquPfTrjP1cbCfITk/N0X6jwxxD3cjiYnelXa15MI10Aaqn2MrQvLuYG0Q8+dC2DErNAak52yXCB5aojU3BDliBtvQZCmM6La6+0gjtJA0oO0KrT3Z0pYC3v2F5788t13yLllp+U3Gvs2qVEdwp05FbHweDV1COEOSyn3ZKPqfzBUr1RAliUfFmuZtLWjPwg2oRL9sxKmXcUEmwfKrzNj8z04gmdz+wPPrlCU6Zl1WCA0h5OuZ/rAFnahlcQURwnYaD/yAYh+wGVqFYHxbwd6hFd3iACpIqEh0J0RKaq++VZ4vkaxLMEZIGef5aFvWF3GEzc3pLnrmjyqenQKWlTmPQg3fWInE4fW0oPi4TeSi3LbrIyUUrSNeaRJqOSLbHmhWSbRIO1YVpNQ2yfX7qR0U62DSnb2EOPdA9cNGdB0pIsTkM1j4R2fFidnZqvSPPv1IuLMw3YqgmO3nvp/8TQaRkswqBnQYAYUOBEoJXvIRdH5mAwVvCXS67h4S8E5ZkeiHUQlAsX+hDjv8f4aYwzP6f5KrEV9guUOoD35TRgXPup7R794tu2Z+E4QOzZo8UzkMu5dLuglAwo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(46966006)(36840700001)(40470700004)(40480700001)(16526019)(70206006)(47076005)(81166007)(356005)(83380400001)(36860700001)(82740400003)(2906002)(70586007)(110136005)(6666004)(26005)(5660300002)(7696005)(4326008)(336012)(1076003)(40460700003)(478600001)(426003)(8936002)(8676002)(54906003)(41300700001)(44832011)(316002)(2616005)(86362001)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:42:17.3216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 654f99ff-6bd2-495a-4a1b-08dbc052a3fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8041
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/acpi/apei/hest.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6aef1ee5e1bd..03cb0ece4235 100644
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
@@ -70,22 +84,53 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
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
 
+/* GHES and GHESv2 structures share the same format, starting from
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
+	else if (mces.dmc && mces.dmc->flags & ACPI_HEST_GHES_ASSIST &&
+		 related_source_id == mces.dmc->header.source_id)
+		return true;
+	else if (mces.mc && mces.mc->flags & ACPI_HEST_GHES_ASSIST &&
+		 related_source_id == mces.mc->header.source_id)
+		return true;
+
+	return false;
+}
+
 typedef int (*apei_hest_func_t)(struct acpi_hest_header *hest_hdr, void *data);
 
 static int apei_hest_parse(apei_hest_func_t func, void *data)
@@ -113,6 +158,10 @@ static int apei_hest_parse(apei_hest_func_t func, void *data)
 				hest_hdr->source_id);
 			return -EINVAL;
 		}
+		if (is_ghes_assist_struct(hest_hdr)) {
+			hest_hdr = (void *)hest_hdr + len;
+			continue;
+		}
 
 		rc = func(hest_hdr, data);
 		if (rc)
-- 
2.34.1

