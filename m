Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931837FF976
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjK3Sfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjK3Sfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:35:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BA10FA;
        Thu, 30 Nov 2023 10:35:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqbxiFSeDMLQbIsnIgHDcSX455ngOgeeE6CgzfDXW2aAs2vWYr1VJI5xSk/cxXTjNTIRmWPQPNChz8zPngQ04VsraSolC2S8z+tcYe/Z5/VVcFxMoniMzuYcRxbcn8nCXgTzFHBNUtD5KcV5bvrh6dqNXpx3k3LGcRNJep3r1+ZNFPeoJKNvklRzBAoSaCkxmg3QpGv1z3q5BQ/lXlMW9AO7LpLH/r4ibv5I3o+osIzi4dhH+oIexM+QV7ItKWejIuFMJAi3GgKMizWswuULZg9cUYgXCaMAXGSzxXDwZr8dWzNcyF3QqLSTkI2SUltoMEfPL4txWszYICF/lEhtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8Xt+mOZB5ftKWAMY3+bNAcFx8SyYzr7SMbO/5GNPK8=;
 b=SeNSq8BV02+d/w5a3LC+PXHp08DdpyDSDK8pphQJEm+kStMuNRkNZej2cXyE92ExfsPXSgXtdNwrUUG2ralEFQpkq3kTQYcr4VVBDFi+K52Xb00AuIrwvNnhaTtBVj7iQxZpT9yHCdxcZ3V3avaeIO8vaFvO8Bq9VhyA4zqXaeh8K126Q1Oq+sNElv49KNfjXlmxq6rbI+nvthO40xcqCklX8W3xfWIAGea2QtocZFQkFXBuX7jsX3PXNwZKzCJNQwdc5zbjYIZO6h/r2xsrcf1Ps51p/QqDYI3sLRxKDT06gWkCaJ3E08m1MimDx4Bu1N+3vpl3ytXPus+aWnSk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8Xt+mOZB5ftKWAMY3+bNAcFx8SyYzr7SMbO/5GNPK8=;
 b=or4qLUr/r7mMzfzJoUGZ2I9h+Hxiy5o9ShEDVQAvSgVoz3UFry9Bu1ia/U6uedTuwSg6rp4er4Dwn/ulhc03vwRhXY+c5iWGKqJ/VqL9hqi4bx2iuWLwnrttdbu/N1z0jRHMWtxxwoSs56nRxS5ZPegRLKsJnHa5g1TN/13AMXpjy8A6FoOIs9MzPd3C7FszWfh06bmvMJV6WVDyUMSoR5mlYvlpJjW7YPCQDvEWYSRgK76nEoXWpcVQM4oJEQvUE2AbF8G8YSP9iI5dgvyNnb8H7quUbWThnc09gK8ULx/0XPX29PuAF8CkStiMfLf1JsV1Uj9+hydWLXg2/z3Pug==
Received: from SN7PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:f2::10)
 by CH0PR12MB5218.namprd12.prod.outlook.com (2603:10b6:610:d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 18:35:34 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f2:cafe::5c) by SN7PR04CA0005.outlook.office365.com
 (2603:10b6:806:f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 18:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 18:35:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 10:35:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 30 Nov
 2023 10:35:18 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Thu, 30 Nov
 2023 10:35:17 -0800
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
        <markgross@kernel.org>, <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kblaiech@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v3] mlxbf-bootctl: correctly identify secure boot with development keys
Date:   Thu, 30 Nov 2023 13:35:15 -0500
Message-ID: <20231130183515.17214-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CH0PR12MB5218:EE_
X-MS-Office365-Filtering-Correlation-Id: 043affe7-5b03-4452-6bff-08dbf1d3238c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/vLgl1vPRHnS7tiQxRqAKKrm57FPrbtLqCgO3mt0r5KA4N7PBEsPdBET8HjvirENZjQsuPjx1nnXA3mtvbBteNz1+ph8EIoov1mUp+qWqH/ASRB6+v209aVkiqJ9/NtQ2plhM71Jc/L6C+E7wifDvLzagSGUpS/SXom1X8LOLxVzLvhlZHO0sap450go/c+qr0LIvWpEDqWFCIdR2PjHreHnJDSW167ovRStmFrbZJLEpUknwlLOouffxKSTqnXIfYeTe81wcZE1Hl+LYKpDaqIXXwI2ubP1q5NEvy+HijTCy0yU2wkwasaykNnoDprGgFSnBXyMweEtwjE6EPZGZqLxJRf5Qjojc525EwBbq7eRE9Y/CWGrfu8oMQBx5gTOAq55mtPhp2vbF5YsVccqppVqIvxG+A/tngAoSfX/oJTd+1KspXh5u2vuSN7J9x+aDXmt8PsYv2NxspshZOLJNXNay4u0zXVWyKcMVsg/dq1i0SRQysy8L8COWLx6STfm68QI5dghkqeungSo9yZNunGbDHWcKW+QvA4FNro75RMMgRE/im6gfhj9vV6poroDdYSmNBBzJyQcQIELovS0O/xPvYj0jgo8CEjn2nia6jSZf7DxI8WQsYAoTMyFkyzLzCdgOiG04l9yWM2zB2+gawfNcNXohkv/ZPAMbepCmLFj2c4w3s2dUuIhWlNhaNsbNmiph109VvWjv0oWdSc7Yw6ZwqCNVQWI5/AglSLNUj10MTWu9+y55/V9IIOul0I
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(376002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(478600001)(2616005)(1076003)(26005)(47076005)(107886003)(7696005)(336012)(82740400003)(426003)(2906002)(83380400001)(41300700001)(54906003)(5660300002)(70206006)(316002)(110136005)(8936002)(8676002)(4326008)(36860700001)(7636003)(356005)(36756003)(70586007)(86362001)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 18:35:33.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 043affe7-5b03-4452-6bff-08dbf1d3238c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5218
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secure boot state of the BlueField SoC is represented by two bits:
                0 = production state
                1 = secure boot enabled
                2 = non-secure (secure boot disabled)
                3 = RMA state
There is also a single bit to indicate whether production keys or
development keys are being used when secure boot is enabled.
This single bit (specified by MLXBF_BOOTCTL_SB_DEV_MASK) only has
meaning if secure boot state equals 1 (secure boot enabled).

The secure boot states are as follows:
- “GA secured” is when secure boot is enabled with official production keys.
- “Secured (development)” is when secure boot is enabled with development keys.

Without this fix “GA Secured” is displayed on development cards which is
misleading. This patch updates the logic in "lifecycle_state_show()" to
handle the case where the SoC is configured for secure boot and is using
development keys.

Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v3
a) added more description of SB_DEV_MASK and its usage
b) added status_bits, use_dev_key, and test_state variables to clarify logic
v2
a) commit message was expanded and re-worded for clarity
b) replaced use of hardcoded 0x10 with BIT(4) for MLXBF_BOOTCTL_SB_DEV_MASK
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 39 +++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1ac7dab22c63..1a687600b8b6 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -20,6 +20,7 @@
 
 #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
 #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
+#define MLXBF_BOOTCTL_SB_DEV_MASK		BIT(4)
 
 #define MLXBF_SB_KEY_NUM			4
 
@@ -40,11 +41,18 @@ static struct mlxbf_bootctl_name boot_names[] = {
 	{ MLXBF_BOOTCTL_NONE, "none" },
 };
 
+enum {
+	MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION = 0,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE = 1,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE = 2,
+	MLXBF_BOOTCTL_SB_LIFECYCLE_RMA = 3
+};
+
 static const char * const mlxbf_bootctl_lifecycle_states[] = {
-	[0] = "Production",
-	[1] = "GA Secured",
-	[2] = "GA Non-Secured",
-	[3] = "RMA",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_PRODUCTION] = "Production",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE] = "GA Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_GA_NON_SECURE] = "GA Non-Secured",
+	[MLXBF_BOOTCTL_SB_LIFECYCLE_RMA] = "RMA",
 };
 
 /* Log header format. */
@@ -247,25 +255,30 @@ static ssize_t second_reset_action_store(struct device *dev,
 static ssize_t lifecycle_state_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
+	int status_bits;
+	int use_dev_key;
+	int test_state;
 	int lc_state;
 
-	lc_state = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
-				     MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
-	if (lc_state < 0)
-		return lc_state;
+	status_bits = mlxbf_bootctl_smc(MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
+					MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
+	if (status_bits < 0)
+		return status_bits;
 
-	lc_state &=
-		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
+	use_dev_key = status_bits & MLXBF_BOOTCTL_SB_DEV_MASK;
+	test_state = status_bits & MLXBF_BOOTCTL_SB_TEST_MASK;
+	lc_state = status_bits & MLXBF_BOOTCTL_SB_SECURE_MASK;
 
 	/*
 	 * If the test bits are set, we specify that the current state may be
 	 * due to using the test bits.
 	 */
-	if (lc_state & MLXBF_BOOTCTL_SB_TEST_MASK) {
-		lc_state &= MLXBF_BOOTCTL_SB_SECURE_MASK;
-
+	if (test_state) {
 		return sprintf(buf, "%s(test)\n",
 			       mlxbf_bootctl_lifecycle_states[lc_state]);
+	} else if ((use_dev_key) &&
+		   (lc_state == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE)) {
+		return sprintf(buf, "Secured (development)\n");
 	}
 
 	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
-- 
2.30.1

