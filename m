Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3578CCE7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjH2T25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjH2T2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:28:36 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C133109;
        Tue, 29 Aug 2023 12:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFxmeoszpEhDDS2pdY5mPBHL2j6ZCLOprOHwo7Sfh5V4uD4aZHmjw2u+POKgyjz2gl3jsPan7WhU0W937c/HwQKRxfsXrIMLc+rwfuTmgW3Zd2mHWjoNGixwHrpVf5b21Ml+OivagUB2yifAPazWedGgBdsgU4Az/zI1sY5eikCW/9wlmN6Kx011Dspn/DF0LKGEuBkauLLClDmEHzjpg8iANbvjFJzBVbCnRI8OZ9jDFvranmIvfhum5awgr6vaHGioZjbeD4xUWbMIVGu9V6jS6Bqs1j9k0QbkWvq9Rydq3iwmgfpN9VanwOVXGyod0xpXoHQtxItVjcF8st/Q0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5gURe80H3yHwYoRHJxncDLAvVd1CcCI3+RzB/ToZc4=;
 b=VQnZ+ZYDpXypphtesbj7vNnd56TIjFoJ1neTvavkpT0iPAVVlHT+ZzmFuHGbdTm0IQOYrmh8S57ndqD4svEr6ioeftY6HUKAixr7cMOqwRF/xi08AMt4VDpYQReNCNYTB1owLqk3BPRywaBS0eZNvV4H3bF1zABSJ5ybqj7KOi90Y4sWjQvAh/A+kePP2qUVn2ILfqEv7XaPMMrucN1TjXUDVKMrjFeLCe4KUxrUddoL0c/IQSxY4ZTjYN7pB9VeXHrWNUcKxzETtKrgvpQQ+2SEEx83rZ+/Us0B76n5f3jpNYbOJBcfJHaGzsk5SG8ros0fiElLyWWHW2NOq72rQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5gURe80H3yHwYoRHJxncDLAvVd1CcCI3+RzB/ToZc4=;
 b=sdNjEGxp3LBtxanUIHtAKr8JKWEvvl7SyLKsVSq8O2U+SbykfwKxPyZzSav4EfKANs4Vx1HdPVcS0Ml8DzqIKMtCLsfVlhfb8PLesksaliv4JX2r61XuVkdISVzHpbEd5oBhl+y0FnLmm+jEenY5pGgBK4jPjqYOl8TBsEAdYMo=
Received: from CY5PR19CA0052.namprd19.prod.outlook.com (2603:10b6:930:1a::17)
 by BL1PR12MB5223.namprd12.prod.outlook.com (2603:10b6:208:315::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 19:28:31 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:1a:cafe::18) by CY5PR19CA0052.outlook.office365.com
 (2603:10b6:930:1a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 19:28:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 19:28:31 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 14:28:29 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <hdegoede@redhat.com>, <bhelgaas@google.com>, <rafael@kernel.org>,
        <Shyam-sundar.S-k@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v16 1/3] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date:   Tue, 29 Aug 2023 12:12:10 -0500
Message-ID: <20230829171212.156688-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829171212.156688-1-mario.limonciello@amd.com>
References: <20230829171212.156688-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL1PR12MB5223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcba554-bd7d-4db2-6fd2-08dba8c620ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgIb+tcJmv2MaLm7Uk0Xh7C3m9ckDj0F4AaPonV6oakQktCO7eLt+Awx0/Xfp4ib3I3vvo17biquGvIIqlPfDXaEv7d9AS8rilZkXRs+DIZRxZ460S9LDbTUZGNbRBX7ZFYcW9snw2zWap4r4bCavPDxz1uKJ73eQQP3K6wsOgCnHaWlSbBGe0Nz0IZpob7S9NHJ+SBFj9UW9HoIi59A4yyNRJAs2sooKhUZGty0RosgjbNVzJxlIoUoizGyTShU2QhABJeXWwWGzaiVIVL3qCsVgHBiTC8ZgcyjpiwK0xFukpXNZ3WhTYHLDBpP66mWTKHRiBxnHweYE0iVkJk0Mksd2sI/A9vlPez7lkA0HWMyqmbQ4/MOm3ZyLtHKq6PYcPHJg8LzAuY8039c3W39ATmfQg8lU4To9rQ1OcI3MH3LmAQ/rg07T0ygn8R+xCydOs6s3qnGV9/hOBaGUnNVS/ioFrBAH8YqUo/X5XB8MsXlML0zeVH0JIAjqPMEMOtU1bheDleZzmlTx+QCgOFWRYvvclFz9STzYgDuWKtOs9rKslbJ+vf2jfR6U4rjjj6N/8PRUH86wnNSVYjxP/LIa/FAi4gDw61f0i6MYZqvASZszabCDfHnNE1bjam1cLn3yvGwzUFgwtz6Xhg5QDQxmyYAGHIkbbs1ckqzWZUVHtLowk2UJaMmlmuVWJ5bz1uMW46geo0y6dvUuuoHGtrqtR6i9lVOG3QWMJrJ6zEZfIR+X5lg8+OPeOb91aT5xXWEyLs8bk5haR8q1KQUI5GSSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(346002)(396003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(83380400001)(478600001)(16526019)(336012)(26005)(426003)(2906002)(4744005)(6636002)(1076003)(316002)(54906003)(70586007)(41300700001)(110136005)(70206006)(5660300002)(2616005)(44832011)(8676002)(8936002)(4326008)(36756003)(40460700003)(40480700001)(36860700001)(81166007)(47076005)(86362001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 19:28:31.2565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcba554-bd7d-4db2-6fd2-08dba8c620ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v15->v16:
 * new patch
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..de9c313c21fa 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1

