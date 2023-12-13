Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F405681110C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378843AbjLMMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378869AbjLMMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:21:52 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52662E4;
        Wed, 13 Dec 2023 04:21:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9C7jrFK8ItVqcQPogkaRxyYIR6pyFvYcugAfj65zPehVmO6Z4Q4mY0iQ8mRuhMlUxAClDFGThsVPBtIC57uMBGb2CBUHND29AHTxGgLDKJTHYolk6YrXOXGsawpc5zpSucslOFy8HTx2pI5K/nWWCv4vgwRS79P4jf2oSbt9bMKbfz+pUqxQyHhtxZ1Cp9ddknIMJ3fxpPd9ctXR5JyTa47XuzStjUU8qCd/+IL4QZsUS0viOZ04Z3s9KfWErwYdI6XGScfEowgYn4wOR+268ToZS0Pn3VePbxJb85ZOTrBQofr6WkoQz7QOFzPvQQ5tizF7OTWUWCQXB1ay6LPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTjBz/387QFHsZurS9QrEILBOOT8XiyPiir0bp+arWM=;
 b=MChrGVoAXOR1GbSrtB7W6UC/A2a9S6o4trtbdMR9TVvPu3tu3PjHVHPiE4c7/UrxZN18jActnGHNQpSCXNMjqvWFKN8oQAvjzdo3EfAG7BpYZtS9rH59kErEcQ1ACNvsY1LtVnqog8xf62BrjZar6WEtV4VlXBrc6Ks6OKL6h1NjRHt2NannL/PLDEjTywosxliXdNB4CBVblzE4mbqieUk0LppB0DCob0lsgYYZ+I0C2/K2B+IXIsueeDznrHOIuBgcsujS8Tg4GcRvyI0cFPm6up4Kw1wZ3sVoe+3dbFCkCzF3znoqRRDMV21KZFtRMq+IQhNotdap5OzQk8Wq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTjBz/387QFHsZurS9QrEILBOOT8XiyPiir0bp+arWM=;
 b=YJOKH/EVJJJCi1hRalXtIiaPsLG+4J46zjuk5A1ZiUCN9h+kGpVI+JiTGmGcpIOsDEksXbLyl1cLkee55ruOB7aipa4ZIhn6arnXkBxeMQ+JXY+YstV+Wf8RiD1VBf8Kmu5dA3aJLshsTghAiToiYH6Yqg08FJya7rPVxXcJ28Fe2aWgVy5k7eYnc9D/53YZVax5N0E7qK0VLsc226IFEj8EE2zxUV/vzaQ2/DM8VTWsY5XSr9YmX0fFmOJscJp8mBUeXDQsDESzF3dJeh6c7sUF/usGSNHVhNJkAy51R43AYRHZYpxZx24OxyYGgLWMGd5XYK7V9OFXMDwwwspWoA==
Received: from CY8PR10CA0043.namprd10.prod.outlook.com (2603:10b6:930:4b::8)
 by DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 12:21:52 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::ff) by CY8PR10CA0043.outlook.office365.com
 (2603:10b6:930:4b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 12:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 12:21:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 04:21:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Dec 2023 04:21:41 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 04:21:39 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH 4/5] arm64: defconfig: Enable Tegra Security Engine
Date:   Wed, 13 Dec 2023 17:50:29 +0530
Message-ID: <20231213122030.11734-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213122030.11734-1-akhilrajeev@nvidia.com>
References: <20231213122030.11734-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 35448e40-1020-4d88-8bc1-08dbfbd61628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WzcQ01cuin98R8SXMgxzC3KxOnmt+neLv24n+tjgy1xWk1NGvoJtXb9YTS42ZZDQBtKyFEpJ7FzHo2y8lpWTNvQfdrw2veV5YFXHnKuPYf/zhw7MvCSxsk3/Nx20as+gVuOIIvAEJUpQtWtl3uWPf0g6P1GPXcFNiPw4fPsTJOt9mp5N+NBPD/by9f3ylADsOFInfInikoQZ3TXwowhK8MdKv/5LNAvNAMLbUjGJG85QD9fHezSDzoZJSv0zIO+k4yzvKyOveYlnUWeUu7x2N3hXMTjCFMySJhlKU8Zhj04lHNAucIk4782zdOEM31y1wd6RvSap/waFnfIMMvWk5oxMk6TQP+3ct7Lm+36Ht8ZHw3aJd8dVrKYrf8GqVRl5q2ViEui5kgoTVrQH1Ut/4C2Lqm0L1Hd9WtbRh/UAZ7YzttpB1PMGm7LnOJFgXHwAZ9TswKdmosbCGh99d4GDqdeE3GRQBaRzEFAaHdzavD8oKKun25nE6crilpye6+s7+uCiSuXtfUv2r4Rs8QZQ+nUM4etht6uPTDlZX5fVRgNF8GyKTPJ1OG+Al+zOfTb83D+u1mQLp1+lBeVnctg+Zu4eceLuvranuZ8ycg5/BPNU8fvBktRg4kMNM1h0x9WjezgyIvyTqgSz5npEvbdQ/aVKpCFHFBae0zL7iLpNT5qcdI7yVOekvGElCLj0ulm8z1ULwROr+Q7XCjiV47pujPZC/pkP+LzwN5Txy5Iyq6J/Ycwro63oTttYYTwjlXT
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(36840700001)(40470700004)(46966006)(107886003)(2616005)(478600001)(7696005)(1076003)(6666004)(26005)(41300700001)(4744005)(47076005)(336012)(83380400001)(15650500001)(5660300002)(426003)(2906002)(70586007)(4326008)(8936002)(8676002)(110136005)(70206006)(316002)(36860700001)(7636003)(82740400003)(356005)(86362001)(36756003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:21:51.5448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35448e40-1020-4d88-8bc1-08dbfbd61628
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Tegra Security Engine which can accelerate various
AES and HASH algorithms on supported hardware.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b130e6b74003..60a098e2a691 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1594,6 +1594,7 @@ CONFIG_CRYPTO_DEV_FSL_CAAM=m
 CONFIG_CRYPTO_DEV_FSL_DPAA2_CAAM=m
 CONFIG_CRYPTO_DEV_QCE=m
 CONFIG_CRYPTO_DEV_QCOM_RNG=m
+CONFIG_CRYPTO_DEV_TEGRA=m
 CONFIG_CRYPTO_DEV_CCREE=m
 CONFIG_CRYPTO_DEV_HISI_SEC2=m
 CONFIG_CRYPTO_DEV_HISI_ZIP=m
-- 
2.17.1

