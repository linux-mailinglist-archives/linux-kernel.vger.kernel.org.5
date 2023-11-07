Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC207E34DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 06:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbjKGF3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 00:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKGF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 00:29:10 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0090C119;
        Mon,  6 Nov 2023 21:29:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8LswbH/lU6u0VFCHPS2SeIeYoP2ErpEWYQdTZPYchtpJLvLzzJuJdduZnnKk+Un8VO3O3dYnJwpEnpt3FmBge8KgucejkkhMdMmx8Pa07RKBJoAG9+A/kPYeko6r8eLk7kHTb1EW2taH01P6LDF7OYAgF7XC/fFlXOdQcQtgjOzha5drL4JpY6qDHDDvHga2ueF5RF1zMOBDLEuAjuTiZaYDEfeJHVZnpDyOo9F50U/sKginFeddBy9xB+kfhFtwC+qDS9N3WZymwwdnG+0G6XUHoeHFQpkOyqOv8w/Kp7qq9ti0N++AqxDPmPt4Y8sy9YImqU6zrj9Rxa9ZN6BAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEVJ0uKdY7edIuwbK/xAIBTVHjU72/uZw2xlO/O6QMQ=;
 b=GxwetwGya4uNJV4TYDHiEzYzVOu/a3UUgJN+PU/dUMR6NApF2MMHEH4V3csap4OdKQunBah/auDeCn+ggPRFXAI7rfCgbv3WrsuGJSKgzqe2PI3A9UWKlIeOwNUuIV05noRwSmvGZqyp+4j/4+ePWZEKbbdRdnc15CBMrlBS2bQn4QusbtLoThEPlZO88x3rR7h2xKrIjVivD+BsCRKBC68cGmmDq81DPZntK2eqj7CPgnoKR/rpCKCBoo1dViDTGKjSRsIx6jETORNinENiOb5wG+V2+kBYHZlmfzC2uu83vSqk+ZJZ498Ck9hL/sbL5x34SbUxQwMeGb+eMJ9rBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEVJ0uKdY7edIuwbK/xAIBTVHjU72/uZw2xlO/O6QMQ=;
 b=H8o/vd8trgywYVRQCfLWcqUF5fdBp41dYn3LMx+nWT9U3zTzitU1H4Cu7WWAJ/qEI59hj7wjQIc9QW7J9w5YuJTIAupnY8Vzu2eTMq/OVThotMJcUeId1c/liELVdvrhKqMTgEAy7Hd6nfS8Arm+rsi66xuivAw1ekFxWMGJIWGo81zQnNzFMBKGoun1EBxiVQNfyk1/jAnMsiFAUYUX72YZDoQ86KO5QGqR/On0vgSZbm/pMuR2/vXk1kQ44FvN+kIDaM1zmUV09pnIsJpwXGN6+uJQzgFZzKFS3sIZMx/0qOrM2FXqp0ZaYLfBd1NNrR3UjBeQsQOqdAkEtHfO4A==
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by SJ2PR12MB8737.namprd12.prod.outlook.com (2603:10b6:a03:545::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 05:29:02 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::a7) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 05:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 05:29:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Nov 2023
 21:28:51 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 6 Nov 2023
 21:28:51 -0800
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 6 Nov 2023 21:28:48 -0800
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <dmitry.osipenko@collabora.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Ashish Mhetre" <amhetre@nvidia.com>
Subject: [PATCH 2/2] memory: tegra: Skip SID programming if SID registers aren't set
Date:   Tue, 7 Nov 2023 10:58:24 +0530
Message-ID: <20231107052824.29418-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231107052824.29418-1-amhetre@nvidia.com>
References: <20231107052824.29418-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB8737:EE_
X-MS-Office365-Filtering-Correlation-Id: 08397824-3832-41de-9f80-08dbdf5273d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q6xhy5XGwt6ZxZRS/9UOP0U4fgBsC9pE+ii56obPtg1fuuFYI76avOK0oqI4Auvem05kG5xFJ6nIuomGB/OlZ4IQbkYCxw8OxCdHfslLL2zoKJVafu48lMHNHLt+AQlYaBUYDo298yAzw4zXUS7i4eNTafYJBLGJl4uvd09T3wfTekBphk8d2RExVG0v4am6rLYuMQCQRHBnNFeGUBXAAAc9WbiQJEpoyq2fceihFVVZfUIgrnTusR44+SQdkGwyo6uGlPpAkk8zPmEMeGzUoRhSMAeamu48iyQXliJQ815rvqvKaUYwcmUkVy4up1NVSpN00FvSUhxc1JFmZ4YVwoRoCHRUeLaAkLU9lHcwFaC+LqkrfDZxGmEVLONzLK7AUBSYnbqC/PQOIEgrvXX4mW1i8hcslYHuHifbJx0TKiWGHJY0Vr8w8WdtsxAlYpCLYlh3N173YHGZHAH0uzKcbcnNI3MXUskq7GpOTOSDwYUPrey0QItvJ0rAyLWMIwmwmv8NJhiZ0/DXKsi77ivEm+fV213RSVM4645zsBdg29kAiQXpkEB36gV52rRn68e4/Ycq4cyjVDLUv/j9vruk3YMwAhTcKZ7A3EdpzYf1PMDQZCtz//MZL5RVaffk5Kx73qLtYLdWynV/kfumcG9AO6zMl7gOXwmYK0z0Kkq4Oq3nUKR/at5iXqDxDP65rqd2vMP6hcZSZW81DAj7rFD6q+MpNnACsdWaSsQAqb5/anGFEEpWpeXuycfe0Cm/uJ8v
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(82310400011)(64100799003)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(336012)(83380400001)(2616005)(426003)(6666004)(7696005)(1076003)(107886003)(82740400003)(26005)(40480700001)(478600001)(7636003)(47076005)(356005)(36860700001)(70586007)(70206006)(8936002)(54906003)(316002)(110136005)(4326008)(5660300002)(86362001)(2906002)(4744005)(8676002)(41300700001)(36756003)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 05:29:02.5055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08397824-3832-41de-9f80-08dbdf5273d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8737
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few MC clients where SID security and override register
offsets are not specified like "sw_cluster0" in Tegra234. Don't program
SID override for such clients because it leads to access to invalid
addresses.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/memory/tegra/tegra186.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/tegra/tegra186.c b/drivers/memory/tegra/tegra186.c
index bd8cecc3cde2..1abbd12dce0b 100644
--- a/drivers/memory/tegra/tegra186.c
+++ b/drivers/memory/tegra/tegra186.c
@@ -88,6 +88,9 @@ static void tegra186_mc_client_sid_override(struct tegra_mc *mc,
 {
 	u32 value, old;
 
+	if (client->regs.sid.security == 0 && client->regs.sid.override == 0)
+		return;
+
 	value = readl(mc->regs + client->regs.sid.security);
 	if ((value & MC_SID_STREAMID_SECURITY_OVERRIDE) == 0) {
 		/*
-- 
2.17.1

