Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3476DD9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 03:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjHCBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 21:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHCBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 21:53:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF14C4C09;
        Wed,  2 Aug 2023 18:50:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd9/SIB/dq4tngoj2E/6g51tqnoaldJofDiTcwhEJ6wI2hJYCbVU9CzTrn+xGuUmfQ6yzLaTuLYDgBfLYXgm696B8MWwSxZWFXiGm1N0zX1pKHl/78J8tQg1Ci/vDbOelsm2e9pYovsIITqZSgmD4UuyrtApNWLX2EjQJxbbN+ojsHDleNezDAg8WoFYK0J4/7iIfxiKOCG4pxntCE4mV8S+NcNbHYQV2kTRE1syLhjbKPs7xCRP8K+jPMxN6nZf1D/y7ui/wcVOIpNEm/O3HYQnuvC4HGfhJIAkJPJ2nPySPIT/Q5pVHeOrm7Dj2jqsYrhX30dSvaabcIixPPR8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMOOmqq/eiZlUbhnmu/KV0sSYQzes5GaMDpH8G+Dg4c=;
 b=eT6Pz6MtCKUJqd0XKYI6I7zim6nqE1zUu5RFB+LHbQxYuzt6Nbd22+q3pSs7PBoi5wjqDBC81HE+K9MptKSNYbN7x7zroc+Lv3cS3TNoTvK3FBnIQJ5LlaBZVrYuydTlPytM0+DBXor3Lg8afh1e3rAIKHGGHMCWhSNWGG0J02bb7HUefw67kImF654jqvBuG82pQcokqPjFDUQjVRqkedL7CN91gYkKpildlwyJuRkN6uW/V/enBNV4WuEWx3kwplBhGDoXnh5SK98o2TemnFV/twU9VToOQeZaOaf6t/Ij4CiQ6bHAPLtjcHU/qLGRp396hN0krkzf04KqT4McQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMOOmqq/eiZlUbhnmu/KV0sSYQzes5GaMDpH8G+Dg4c=;
 b=rz+UIt00b05vp/qmI3yBTpSTwqEKfyDmSrnxGOU1SB67YB5T9K6PAAPr5X4TEv4hMnv9MQwa8X6tPOJI/PrkqZDDBJlENb6rdzM491f9WEnnEzlUb/XZ/KRQtXgBJrfuai6XUUoFETaA6fStOw7D8ZSHlic7qd8gmh7eevEjV4c=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 3 Aug
 2023 01:50:31 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:8c:cafe::2f) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45 via Frontend
 Transport; Thu, 3 Aug 2023 01:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 01:50:31 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 20:50:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
        <Jason@zx2c4.com>, <dragonn@op.pl>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] tpm: Add a missing check for TPM_CHIP_FLAG_HWRNG_DISABLED
Date:   Wed, 2 Aug 2023 20:50:13 -0500
Message-ID: <20230803015015.915-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: aff7b205-4aec-4494-b2d4-08db93c40548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qbkMPpfyqT1K7VzEVtRTk5a73P5xghN1smWbngsDZsLTj3X2xMW6o/ZUIHrid0lRxfibacKKHeXU6e9ars6EjoHjSQ1WHMeVjwZVhraD0amUl7bdlDuDVvb8b8t/yDyfgT1TwP6S+4W6isN8FDNSiSSa4EbWLVW4grO003wvaXrnd9bT2cSG+nyHfuYSIb4Q7Oy607ee3mTuq1PAtML0WO9AgwL99UVDnWZJ1X8SKWauV/EdU7R+ZJA8IJXmQJtUxNlTQFwi9FYgaZKBuqbFtYUEJJC7tEzd9ZGfH03dyZFXhIkDGO55Jdc0HDgwc6VMytmwGQyCnOrM3RpnJi4rtGu2tZcynPrdR09i4qRWD4vA9yC5y4aIyIXSHwt+ELtkPirH6+fbjmvLLoHRra1RkYZ480Vl3yGxDmbXJ4/iQj2CdgRzpR8wdaqKp0Pcq0mxhBpCfyIECkyQ8Jk7Xmce/EiPQxBinKoTfNuxb38t+sdQMDvsjHle83+r0TPGc92gLhO24oE+5GbreW77OPmjFwdFNkrA1Cqo6PndVYHbyG00k+0IpgpMlrOTzZ+sUdB7YFINDYYKYtRH8dYgPxQuqEimbu3IU5BgaM0KpVMjIMZosMhQQPRFPEt8F1ZusXkxNs2FukTMd8WMrCGVXa51i+yRUc4THRsWkrweK1W8ODHN7blOcFT96axMMT0V1nS0co8U0sLnJRqNeB2eQwZaxG82sebXr9kQCnEoJEgVtCYggwVYlRyTg+UnvboxSDDgwkSnwTkt8XTqJVLv/Z2Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(356005)(8676002)(8936002)(40460700003)(5660300002)(44832011)(36860700001)(2906002)(4744005)(83380400001)(186003)(26005)(1076003)(336012)(86362001)(16526019)(40480700001)(426003)(70586007)(70206006)(2616005)(47076005)(316002)(4326008)(54906003)(110136005)(478600001)(36756003)(7696005)(6666004)(41300700001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:50:31.3018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff7b205-4aec-4494-b2d4-08db93c40548
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the TPM is opted out of hwrng the error handling for
tpm_chip_register() needs to know this so it doesn't try to clean
up an uninitialized chip->hwrng.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/char/tpm/tpm-chip.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index e904aae9771be..8f61b784810d6 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -629,7 +629,8 @@ int tpm_chip_register(struct tpm_chip *chip)
 	return 0;
 
 out_hwrng:
-	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
+	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) &&
+	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
 		hwrng_unregister(&chip->hwrng);
 out_ppi:
 	tpm_bios_log_teardown(chip);
-- 
2.34.1

