Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045F776DDA7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjHCByn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjHCBxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:53:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701574C0C;
        Wed,  2 Aug 2023 18:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRxxu2aiberEzHsZPT2tnxJE8xj8N1UG6bmWjth1GKt0ACMTJYqGrjHwab1JrGrlaV+Rq3/c1FbUL/ghCfMevsJ4pB7/G05LCp7tzuGKngc8dKKKSAQLdH8H1xwMw9LJBFhJs1LmTKSmeXBibMoRQnGnSzHN7BU5cK+xl8hAUMXUWD1ecYPGtf+LD3OGWYQXpKlEZfqB0S2iGeAZwznfjzAprfOz0ZzmDBXZRRsY3OhNShMIJaXJOnU13+66fpr+45Q2DdRV34lXtPapHJKk5bCqxguTbNCfWwvEAWq2JY850/gqbIeDLJ0n5HlzNF/sAr24ctO/tvGkBJ7C6V5+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPeAtWGA5IgpMy8bGWlPUebHFttBKKl3kxuGbsfyuYA=;
 b=PB2sg+FFQSW5uYCR3wCLGhvPIJoCMJp0UOOArWk5jIF5V5wc3v9fDUboJJH1putybKlBSfUheC2M4nzUi/F1PjXLEe5Jkh53yAxXB+ABudW090FDM+H4KNOyFo4ohhNuRFyGY1YdIhprxwx+JpEq+7cfOmJXn4I7L4H/vSvurl4lhqmNGPlJyDbPnc39PmNtfa3ohKshuAlqZjNNX48vTUfRNQf85j4v2vk8Y1Oym9iX6HsQIs/syiBTZvOFBagkVBgurbCIaa1j1HMN1DLYBJKyVxBwC0sUVF5gjsyb/8+iBmnrhD2fUcqGyMUSPDFCQ0slQp2A81Pw/IAvvF6cuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPeAtWGA5IgpMy8bGWlPUebHFttBKKl3kxuGbsfyuYA=;
 b=H1EYz20WoFXbFydHlr72xJaWwnGLGjVpaWMCdDKue3OAsgiRPaSuZrvP7vMb6v/BMPqRoHhOTTQjbhb9zWmkvhTko51ivs1iFQEDkwKcA9x0hbIys8qvRST42J60DhkeCDexE6qSElLVfzLsamvj4T2pfH1y9Odfpi9zSrmiyyg=
Received: from MW4PR03CA0121.namprd03.prod.outlook.com (2603:10b6:303:8c::6)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 01:50:32 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::cf) by MW4PR03CA0121.outlook.office365.com
 (2603:10b6:303:8c::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 01:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 01:50:32 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:50:31 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/3] tpm: Add command line for not trusting tpm for RNG
Date:   Wed, 2 Aug 2023 20:50:14 -0500
Message-ID: <20230803015015.915-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015015.915-1-mario.limonciello@amd.com>
References: <20230803015015.915-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: bd28b192-6db6-4263-4ac7-08db93c405c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1Hk0i1XIF43XezUu/jk5xTyb+GGxzB+n4V+pA+qxdXnKr4arm75WZHmiT15+jrIJIjgWzRVrhZ9dAdi/3pvvOwv6tncCmqORQ8MFG2NPT0jzjK9rOcXXLuVnUJ/Ur+ycxmZANCam/fFVmhHE1hvHkrmV7Mwr039bIcWUlWi4cRyvpZ2pUv8zGxko9vllGfGDU6+alT0syKPXkAKsOlnC/qy9IZ4Gn+izyr/qewtISLYTIPaVarP7WrdcZeyOKY3q0KFf7y5FNO+4u9R/CfwiwzCdazVm8vmrAEKWUPYCdsG4KoTMvXQ0mp/td598LAEMPTZgENccCCZL0H6heWHJpByAyCHocKHW9eemHXF2zKqCit6AJ+hA1KJF8OypBmoDCge/+st4bJbz68nEtl3xrmAQ0UGQ3cTheq7VB8RVbCZll7N4Is1sURLjp0mH8MYYzTusWe1H4QgOJKzVVTq1S78PBL6hP9ylu1IhRiQAwxOMJSt6QL9VOUKM3uroZ9g+cVx+zBTSyrg6KdTlAQ+hfBQ3rLA3Kl1fmIPKNnzOXUnY7vPIcBawbHLxKgi0K6U1muZX/ovy+17HzbXHVjEbpCjS+WgqOU91o7rNFfLBVEx+vAyw8UaOucGAPhWWCxXpoI0IMo2cfptDXrNip0YnaJdZRWdPZnsk15Lik+6FecsNvZMKKDWSbfqzqjFWI/RCJsplsYsc7ZAduQxK9tSydjaWm5CRrKziMYk1k406XulErqYogQ5z+vhogydast+h/8SeP5oZ5IcAFk70ttQ+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(110136005)(83380400001)(478600001)(54906003)(6666004)(81166007)(7696005)(70206006)(86362001)(70586007)(4326008)(40480700001)(316002)(336012)(186003)(1076003)(26005)(16526019)(82740400003)(47076005)(2616005)(426003)(40460700003)(36860700001)(8936002)(8676002)(356005)(5660300002)(36756003)(44832011)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:50:32.0830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd28b192-6db6-4263-4ac7-08db93c405c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel supports random.cpu=off and random.bootloader=off.
As TPM RNG is also registered as a hwrng, add the ability to
prevent registering the TPM RNG.

Suggested-by: Mateusz Schyboll <dragonn@op.pl>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 drivers/char/tpm/tpm-chip.c                     | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41c..9ff602c09f55c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4672,6 +4672,11 @@
 			passed by the bootloader (if available) to
 			initialize the kernel's RNG.
 
+	random.trust_tpm=off
+			[KNL] Disable trusting the use of the TPM's
+			random number generator (if available) to
+			initialize the kernel's RNG.
+
 	randomize_kstack_offset=
 			[KNL] Enable or disable kernel stack offset
 			randomization, which provides roughly 5 bits of
diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 8f61b784810d6..8fb42232bd7a5 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -32,6 +32,13 @@ struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
 
+static bool trust_tpm __initdata = true;
+static int __init parse_trust_tpm(char *arg)
+{
+	return kstrtobool(arg, &trust_tpm);
+}
+early_param("random.trust_tpm", parse_trust_tpm);
+
 static int tpm_request_locality(struct tpm_chip *chip)
 {
 	int rc;
@@ -523,6 +530,9 @@ static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 
 static int tpm_add_hwrng(struct tpm_chip *chip)
 {
+	if (!trust_tpm)
+		chip->flags |= TPM_CHIP_FLAG_HWRNG_DISABLED;
+
 	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) ||
 	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
 		return 0;
-- 
2.34.1

