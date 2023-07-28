Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB97675EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjG1S6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 14:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjG1S6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 14:58:13 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1533530F7;
        Fri, 28 Jul 2023 11:58:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WV1XtvsD+G1Wr8PWchofnrY9OcrbVLXsG5WiU4aNPCrzfK5xtepTkBnL7ayvSeI8AodtM5nxXt6WUmxXWonkuWNG517Uy4VyTRPFqFmGETxJaSua8rzw+Y5Qj+c522t5o8Gh4T7+w8+6aojS62NPuEyZrOY+KaYTd9LD/4ZeHtyOjCA8WPSo2HfTkysueGgZb+YNBeKjs5a/hhA3405dMQEM0cRWJ2SW1HPFf9zoS7Ic63rGhCgU9cEoZB8BrTY02zgA7P8rbDxrXHtSu87iffToMd8ibfeWvDLft2NVFJy144EDoVV9pn3JEx5R1M0zxXwzRiBrGsawdkUcvgjuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+roanUuhZ47D99lNgC12YhsT159hlP8mOyyS+ytkOC4=;
 b=Nf00rUW3Jj7Ss+QQcAtjnNaZO4LMmhRSa1GrZRFjZbShC3KzAR8p0eC4g5n8NWRHP3F4EpTXlx5XFpxeETCmh9rQrjZOpwGar0FhErra5QclQua71mg1za69DF+8vHKWCHY0cCJh0tmghwZy1PlGT9nTTjJNDqNe0OuSwpc3nHwFvT0k+FC4F7UxHAU7jYnLyq/ccD+DKn/jhqUuCR/aSjhTDpct9dEyNdHbbJlxSxfVXvQM06iF1H/qEQKB8bzU2vEPFtdDBVFsypSSha5HXNsc7hfPlNcbsAiiq4lVKdvh+Ld+7ZCqrBxYyWkq1TIGQwR3latupeA4nDW8jVPJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+roanUuhZ47D99lNgC12YhsT159hlP8mOyyS+ytkOC4=;
 b=mYGU3Q//bdfupgLIQFeOk6lmUhVjjl2XCQ6RU3T/P+EJgbo1M+y5/awbwrooSzUWZynWnGSiKT5U1j8LM9C6KsdwZcByOpUiUxRrYwgzh9W/4wJdv8bSGMUfGDwWMb2bKvt9Vr2cvtp1xWwjBN6rdZN8yFbpce1NU3Ls2Stp1Ok=
Received: from BYAPR07CA0007.namprd07.prod.outlook.com (2603:10b6:a02:bc::20)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 28 Jul
 2023 18:58:09 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a02:bc:cafe::f7) by BYAPR07CA0007.outlook.office365.com
 (2603:10b6:a02:bc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 18:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 18:58:09 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 13:58:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <regressions@lists.linux.dev>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>
Subject: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
Date:   Fri, 28 Jul 2023 13:39:21 -0500
Message-ID: <20230728183921.17230-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2e088b-88b2-4faf-5e9c-08db8f9c95cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6qxtQcN8adCPqUt6F2BH1xe5w4C01MujOomj1hkNweSQCa/7aQIbVxFBZrY2hHaZHhNZsdp4PWmVn2q5KNihkyTwDfNusblPCVKauWjlKPVNfPT9ddSWwp6OhkIQgTO6dXwACPC9dCdCl0/v1hwmljLWnegS+4qPagVxWFKNe+Byar+aIWu2rYwyj4TQwELupEhv8lbM6eIRnR8zqp6vSLORsXclEgzXf1/A0T/EFyziSh0/tJ/RSsK5VUb4CPD7x34THI/i1OV/LpRsrocGjN6iPOhmqzvfLMrWs9tnCx19ptK0SM6dR4mvWXj18nO5xF+QV9QFzBE+QYnTsmBCBRWYWKID26ziXfA4qxbwLJJNirWgASh8CcikGvqsN1tZ08k5CaCEzvIGFUjAFoxcTHPUofvCkr2N5w4HZRvNJPRMIeTbp/9HWF+G8vHUfL9qm5TMF3lcPsG6QuHlMV52NSY10OyRe+WAxX7YkJO4WrqeXTLsydGTKW/xZvIiW9T1AGcnphImCHwrdGXSuri9OUbUeSQQ6+sdra8ikxNQzCzDskQMtbOEiFdfvFgIs96AVC+ziw/qPzVu5J17ndw9Yamqk/oJdpx1VucGc7dOmINDpzfm58meXUJjk0RoZmI4ZLLurjbYUmGpdAB2tzQ0L8D9aDDz+mk1c9rUKeigxQ+iWzEllUuJSqbWU89KhLeZ5szkkISoYvLGraqtyRcZOCsrNjVNXYMWuraR97PYCSYxeOOD0XIoJZdior6p/pPkD1u9Fzf0e3t8keOrpP7x1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(82740400003)(44832011)(47076005)(5660300002)(2616005)(70206006)(8936002)(4326008)(83380400001)(316002)(6916009)(8676002)(70586007)(36860700001)(426003)(81166007)(2906002)(41300700001)(478600001)(356005)(6666004)(7696005)(54906003)(36756003)(186003)(1076003)(336012)(16526019)(40460700003)(86362001)(26005)(966005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:58:09.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2e088b-88b2-4faf-5e9c-08db8f9c95cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
is incorrect in the MADT and the value from the DSDT should be used.

Reported-by: August Wikerfors <git@augustwikerfors.se>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/resource.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 1dd8d5aebf678..1a826419d5837 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -481,6 +481,17 @@ static const struct dmi_system_id lg_laptop[] = {
 	{ }
 };
 
+static const struct dmi_system_id lenovo_laptop[] = {
+	{
+		.ident = "Lenovo Yoga 7 14ARB7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
+		},
+	},
+	{ }
+};
+
 struct irq_override_cmp {
 	const struct dmi_system_id *system;
 	unsigned char irq;
@@ -494,6 +505,7 @@ static const struct irq_override_cmp override_table[] = {
 	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
 	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
+	{ lenovo_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false}
 };
 
 static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
-- 
2.34.1

