Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1097F1DD6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjKTULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjKTULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:11:31 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EECD;
        Mon, 20 Nov 2023 12:11:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2qFeR7Jsewb9eS5asjNPgL+mXwn357/XZhQt6cfHW48uYvWkeRf95o/rEE/OghJwBxJbvYgBYFXedptBVyIRWXC3lGCz2aQ0DWDfh87n9QD6yMDzXIguoEh2Ew8B9abfszv3jlzY367iffYV3FcMy793SC8Cw4iGDHHKDhLU6p0xATBHm3lO/lUf76L8PyTv4oXptq7DqN7oKhZBI7DWMTNiKj389QOXn0zn/Wgi52a14WhDOtR+iWjAqIFFvUkFCP9yWDTujsdgD2QOiHM4Cu6OT4K0D/n7DAJq1cSGEXN1mVAbTtMjXhcML1ycKy1UDkjZHadwPC7b3yWe8vXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRyA/YMhwTzstrIDwn29fVagzssMEOha8d9vf84Qjps=;
 b=gIbbgO2+sjf/cnle9k7xpn/x98EkMhEwYpglOByQLhubG4PxEzh2mqETYciuOjlW5Kp+tu6on2OUJnLoERjL2ZdfgwEiSWKCwSEOMR9u5iNVg3DYfqRCtIUFGbk3Y378TEBc87c0jzSQJrNd2KsaUGU9/QH9lIxmo6HChOXey/vCFnXKfiHxAAikzKYmUXE7paEh01z4+hhOJeJNJdRUncFyeTxD/OtSfFEy2aL9/mvspGrhFujHgyXKr6pVIMyc3sMD2YP/TDlbV5H8QVhTSSe7ijE8gTgfaQaxFWR+i2CQpLzSMKyfCruTaqMXc6b22V2D8ALB6NtfBfDzzuaZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRyA/YMhwTzstrIDwn29fVagzssMEOha8d9vf84Qjps=;
 b=IbQ0WDq9GRjlwUrEqGHqdxi2dmlmNvpOdiJ7vUaMU38p5tO4YjZFnb2JHLCxh+yXgUzsoNe158Z3ktJ9cDbZiOs4RDKOMzjedsqEvJZv6CL6d30/nX/Zp8TNw6ALXzaC7ErBiqacqVOshxmtnn3i8EYbZCKv2M+br7IpIXo0aAxS2+WM3nbPfQ0gRDAiiMFLleCTfG+QdO9ATLROmHJHitmMnjmsR3Fvhibx5BFdHZ3qFg8nJtFfP/0mY96Cl/+JNn1XWx9I+frlgDZsU8Oshtb0yc0TKVNgzuMqS0tX6hlDNY1/QDVp0SJ8plKgJPs+hkk/a7gOPPUfyY2mt1GXBQ==
Received: from CY5P221CA0062.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::34) by
 SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.26; Mon, 20 Nov 2023 20:11:24 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::dd) by CY5P221CA0062.outlook.office365.com
 (2603:10b6:930:4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 20:11:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 20:11:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 12:11:12 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 12:11:12 -0800
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.41 via Frontend Transport; Mon, 20 Nov
 2023 12:11:11 -0800
From:   David Thompson <davthompson@nvidia.com>
To:     <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
        <markgross@kernel.org>, <vadimp@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kblaiech@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
Subject: [PATCH v1] mlxbf-bootctl: check the secure boot development mode status bit
Date:   Mon, 20 Nov 2023 15:11:09 -0500
Message-ID: <20231120201109.3435-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 26012adb-537d-4a29-9f6f-08dbea04dece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oes7epbeD9pEzzBDQX0SaOkR3iiWWxajQhJA07AojJa1aLKMi2Zc2S/oHF5YGua+xJCRMI9C0cnDa3HZw32P8brz4qxrz/xJM1lXpvo5mZkJ2dD0kDa78/yRIfdltdN7qJhgRq5FjKQTn4RiMdkrdWGcwzPH4meyUQoQXjdQRjQQt54W51aCFtP7zUl12FXMEx2u2zeOD55HOxEwMWhsWKlKUQ3j/1oudxjfadDIFOakzyxY4T9EpkrxO0rakZdG5jhGKMe4v+IW83DungPNisI7ygARX4GJr4eBpOEKtt/okSEeSuHeG7XEO6pyZtPKpaA89Nz9EwYols8FXKGr/AOqIHcnbUqy64bzkoycmyaXGNcEhbj0yPM06aQXZNZpZQ5ggrxmEfyQ4514DTh/x5qZ98y/k6MfGT2DqFDuZGBAxOcdowUdbLM2s2xw0kosAaimtr+8+A1FSrJ7YiyslpyFLUSxu7yjVHuO86Kp5wNWwRWxe6Dp+J8YHQg42AmwNYq2krJh7r7SynD2b+b0ZE5zncmWDDNuPhRe2304YJex2Xfoo1UNfHOrNYXkxgDGdK+KCte8BIJNo9JNw9bAyQ55y998ndpOYm+j7ZWfGhPz0U0NiDuKKpOHfbUAqLy4w6bWNDbQhUnI8PwTT8SWBcsGxilC8zOUYaTl2i4OTdLHeM9b8PiR++7r31ZeDHDq4uoY/xqzPpbBvaS0ahePUm3q8e+30fML+Qp4SmIJ9//6ryfR07yZowHLGAj4jaFL
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(82740400003)(83380400001)(426003)(336012)(36756003)(86362001)(40460700003)(36860700001)(47076005)(7636003)(356005)(70206006)(41300700001)(70586007)(110136005)(54906003)(8676002)(316002)(8936002)(4326008)(5660300002)(2906002)(1076003)(40480700001)(7696005)(2616005)(107886003)(26005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 20:11:24.0346
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26012adb-537d-4a29-9f6f-08dbea04dece
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the secure boot is enabled with the development key, then print
it to the output buffer when lifecycle_state_show() is invoked.

Fixes: 79e29cb8fbc5c ("platform/mellanox: Add bootctl driver for Mellanox BlueField Soc")
Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 24 +++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1ac7dab22c63..ed22908d79b9 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -20,6 +20,7 @@
 
 #define MLXBF_BOOTCTL_SB_SECURE_MASK		0x03
 #define MLXBF_BOOTCTL_SB_TEST_MASK		0x0c
+#define MLXBF_BOOTCTL_SB_DEV_MASK		0x10
 
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

