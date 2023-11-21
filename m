Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DB37F335E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjKUQMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjKUQMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:12:51 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564C5194;
        Tue, 21 Nov 2023 08:12:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2LaqQAiMyVQqkdoobCUPSkB3EFixSYA8J39PpLcGZ3zqCIPF/tfxmpJWzaTOS5Z356OAjNmZi4ImGkAfZS77iREvSHUoS1P8LBkt1BQZSB3fH4AjldIv7rfR3lP5FxyMgmFiLsVFpt36tWcRIumGko927FbXndrJKPPZ2Wx8Xla0epqFp00JZfrz76FBNu9o/xNh3l5IFfZODcvyw4sbgwbu3svueYjAh5nk4x3JJs+CkHu8AJ3G0Nf94WltrLL8Q37ZQbM8fOh4uTO5MJyeih7oFWWXyfDl/7uxtTn8S/0pVwGZQ0c/RPSPZhDyvBsOERb8NQIezs7rx5eIBbIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pYo85pVw5O1P/XQHOBKCYeEOj55GPP2cmWTy8vaOsE=;
 b=EbNZPDQVsYYXI5J5vUG+GnHCt5Q+ZvR3QxQ3ukhoRQdD3ymC7y9jipR10SL+AUwRN76O3CWweE3nnFQ7MYaAu3Jafz80SEyTqSZM/fSor/eXqLFDYffGyw+sP5fdXSfbmlxTcOWH5PLuk51Dxb3VbXk/NBri/Vqjrm2HG82Uak1aYjCUq2zE1/ors5vK+cukSQWGFDr/za87KzLgSMVljBg9YSAEySJPL6GGCm8MG0n98/FOLWG/Qv7Sk2QqUnH0cIZUYd663m3pkgpcg0qEKAyfitrjxgS/gKzzOFk3kAAQlS0eeD3YOHygrXUZE07YNiqs2EJdLAAht/lCERXD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pYo85pVw5O1P/XQHOBKCYeEOj55GPP2cmWTy8vaOsE=;
 b=YcKvC6q0Wend6peQAq6nbcSGiRtDuYagjNk/TgFdrjDjvtTqmw4PjJEEpvGXCCdCXs9ozdL3CLXz7uuNLQNattLEnbEKCKaot9Pqe5Ecc+xAcacNedAfdktzs6Ai6cMSZJpHsM0ppe1TSKbHIszFzMndnYpDT9cdcN0FOLNVlb/37gX+iNTNWM/wWWysLgYUrt8+rTorIQ6ElEJ31Tvy4DmLFeNRjDq5WbYlBahpPJALFWl503+Rdu9KH5o6bWltP+N8w7uxMqWFuvpoddoaOfsdcpa74Waj6mVKgMPsgJlutl3ufmxFTRTuOF1IlfvsHrmSiQDe51OkYclaNvT+5w==
Received: from PH8PR02CA0005.namprd02.prod.outlook.com (2603:10b6:510:2d0::13)
 by CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 16:12:41 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::88) by PH8PR02CA0005.outlook.office365.com
 (2603:10b6:510:2d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 16:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 16:12:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Nov
 2023 08:12:19 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Nov
 2023 08:12:19 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Tue, 21 Nov
 2023 08:12:18 -0800
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
        <markgross@kernel.org>, <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kblaiech@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2] mlxbf-bootctl: correctly identify secure boot with development keys
Date:   Tue, 21 Nov 2023 11:12:16 -0500
Message-ID: <20231121161216.3803-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: c86b6580-de93-4445-3eff-08dbeaacafdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HaHcs7GRyllaWzYs8VEDSHCU1nV/HXBmRWgDE87+BoYPxQcFMDXJ0rakWEMeEiGuIIl0FfovV4q+6Y8fGqkULivKitAUKBt7871xDstmKWyEKGWkDR58yvwioabNM4dxavVyeBZXVwEGOWCttP/Kw0gPOMwhKWbX9C3tHMPM4BGlnndL+1MhPoWuFkEtBZ/BwleyYXNJwbAhLkKo0ByH6BiLVA7BK63sHJAUnf25pxyjo8uGA7mLvX3Y/FrMBpvWQt/fQybC/VuGstyyXzw6A9fju1IbqZnUqkHeiaxVt4zoI4JDHWpidBKh0r9vH84ewa19e42LvJlSpJVGa+ZlliMzVtBxg4rwDxmBeJpXPQU8EpO/uJ/pAfYJBBLg8Put2R6p325JXqZZK3OCHDrhl6GNxeztrdE1Pv32X2RFhzkELK3G9M3sJOCcnwtAq2blBcjNpLRvDFvPtaqApIz0IzQw78YEGSJTW1aC7XK+KnVYJHtKgcaU4oNzq4bMzTucs1n1VFOKVosxB9vK653BFY08TEq0gRJRMq5xW37JvkFCaRzWFei7cu+ff5A5y+Z9kHdNyXpRlvHAt/+RZiBh6Oeh15HN+WR33ZBd3mvvfDQdNJ0mAfFdzAv6EYYUr8buO/ii+IZzM9RDWZnP7pqVXGaRXIcflYW0o0XPPT6lQeyBwzIWJV88ATxS7laCK76wV5SEmYRfozCfxhdnbvepmmBNeMYLB7pRmo5XtAsUa4Yglq4vn0AG/RIw2J2tZvJh
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(7696005)(478600001)(82740400003)(26005)(8936002)(4326008)(8676002)(2616005)(426003)(336012)(110136005)(70206006)(70586007)(54906003)(356005)(7636003)(83380400001)(47076005)(107886003)(316002)(1076003)(5660300002)(2906002)(40460700003)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 16:12:40.7568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c86b6580-de93-4445-3eff-08dbeaacafdf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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

The current logic in "lifecycle_state_show()" does not handle the case
where the SoC is configured for secure boot and is using development
keys. This patch updates the logic in "lifecycle_state_show()" to
support this combination and properly report this state.

Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
v1->v2
a) commit message was expanded and re-worded for clarity
b) replaced use of hardcoded 0x10 with BIT(4) for MLXBF_BOOTCTL_SB_DEV_MASK
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 24 +++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1ac7dab22c63..13c62a97a6f7 100644
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
@@ -254,8 +262,9 @@ static ssize_t lifecycle_state_show(struct device *dev,
 	if (lc_state < 0)
 		return lc_state;
 
-	lc_state &=
-		MLXBF_BOOTCTL_SB_TEST_MASK | MLXBF_BOOTCTL_SB_SECURE_MASK;
+	lc_state &= (MLXBF_BOOTCTL_SB_TEST_MASK |
+		     MLXBF_BOOTCTL_SB_SECURE_MASK |
+		     MLXBF_BOOTCTL_SB_DEV_MASK);
 
 	/*
 	 * If the test bits are set, we specify that the current state may be
@@ -266,6 +275,9 @@ static ssize_t lifecycle_state_show(struct device *dev,
 
 		return sprintf(buf, "%s(test)\n",
 			       mlxbf_bootctl_lifecycle_states[lc_state]);
+	} else if ((lc_state & MLXBF_BOOTCTL_SB_SECURE_MASK) == MLXBF_BOOTCTL_SB_LIFECYCLE_GA_SECURE
+		   && (lc_state & MLXBF_BOOTCTL_SB_DEV_MASK)) {
+		return sprintf(buf, "Secured (development)\n");
 	}
 
 	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
-- 
2.30.1

