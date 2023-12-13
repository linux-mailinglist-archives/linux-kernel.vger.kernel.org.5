Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355D1811103
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378837AbjLMMV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378820AbjLMMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:21:18 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63EF3;
        Wed, 13 Dec 2023 04:21:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP74yNEhvWCHVyDbpauaJUzl1+W6PcgZe95qzJRwMbTXNfnS1tnBMF54fNjZ5tuvaKfHpc7BYG56pmANaniu+EFPQN9qVa38pptWIJGNhZevH8kmzGLmQiafJ7T4cXXDbmS9qb67MMXUDK5p+upkOMVeeG5e25OCYAo78tdQCDXart7Rj8hbxVIotDUW8rzEidLUjsmfVYECj2HMdIJmSvExJ7NDlqKUvpOL8RtM3UPMPdvdE63yQ+BAoIUzqGapEEvVMZKdhBvONtTO397R8A/sbmuRz02vnBybLlifAUbS/Y8sznrEuMGInXf9qAjLWn5lmGlHr/DJG2fjcg4P1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=Fvfc4iuIbA0qKNegrKzZ8IMCWLESqQztsFLizK6V2H2ExuhazNJ1+yni3zMh8b/6LIWegN051qmzhuo3O9RconNxSaWtcZ8uq5DZ4qQ+A2BAKMXtsxQzX24pJur+b71Z2C94EIpJtoszqSCvldXBDGiSxvAII0D5qak9m2H8EbcrPQ5LYf20m2kScoxZCbPYZGlh3klY5bOl7o43TT1z6yPd+sjnr4w0oG3hZfffq8c3NUIQ+uHeDXzecdbejnIjRNfi6FS7eeOC+QGd26w/A7B8vzpwq3kx+FVoYz/teWwOPSUgqVH9HcJP33La+5BhpyG9ruE4rQt0U+wYSc+iRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+o5KvE8nwX0WSeMin6w0eEZKvdESyMS9s4vHsWXmjE=;
 b=DzPBfIKHeuapME6mU/yiHAnzZy6s+122ESAVTR55Ktaxdr9kUERMIB8QdybeumooTy8ED8FgJqfiXrvjyjnFPaw3cIeGbdXquoJVm9hQzK2421Pdi7qw6bW57FzalDlcdM089zloBkkmGoRqazBvcxOgJbAu+1qwN31PVQk8hhB86s6v21UnOA9xWQyq9rYKacrNFCLRiWPCyijIaBTf5h2U1sL18tYHEHh5ybzvoRVp2WWh+BwgCH2n2I4pjwfugVMk48ckniykju7jpwWbueL3a0gCnDBlAbvoHHJxHJn16A1VFZtJ/zS2U2Zmk4SPxDkVcNiRqlceXsC1Ema/MQ==
Received: from DS7PR03CA0164.namprd03.prod.outlook.com (2603:10b6:5:3b2::19)
 by CH3PR12MB7499.namprd12.prod.outlook.com (2603:10b6:610:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 12:21:22 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::71) by DS7PR03CA0164.outlook.office365.com
 (2603:10b6:5:3b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Wed, 13 Dec 2023 12:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 12:21:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 13 Dec
 2023 04:21:12 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 13 Dec 2023 04:21:11 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Wed, 13 Dec 2023 04:21:09 -0800
From:   Akhil R <akhilrajeev@nvidia.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>
CC:     Akhil R <akhilrajeev@nvidia.com>
Subject: [PATCH 2/5] gpu: host1x: Add Tegra SE to SID table
Date:   Wed, 13 Dec 2023 17:50:27 +0530
Message-ID: <20231213122030.11734-3-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231213122030.11734-1-akhilrajeev@nvidia.com>
References: <20231213122030.11734-1-akhilrajeev@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH3PR12MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0a7d8f-444a-473b-081a-08dbfbd603fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKpFlrycgVscB7x9liVCAgqKv5InQhGiDklqHXoXoKFuumM6dvZY2ayO5y3LhUMl2y0hkXQwZYjmGjKStJSrm6EbfOkcdCAwsx44VdDq/qAqjtlcH427WV3iPhgMCt62P6LyJj14wcA/67BtFZCkDjgqFb+9mC3OeOdNHWlm0DmYwIEDm/DqC41/cJb6f3vCLicdnUBjYAtOwy3u4WS87KYiivmcLbwTBwkP3W4FHydf0cZxSXd4CvCVE87h7RFcatdpHHVLY03yi6+NGp6h/NajKI5aJsrgVbnxAv8MWcvTd47Qn2z3XFJwfaaWMyL+AP88aZZsnCuz8qoc64yTJVlUCE4rBclYp8oGhT57aDakO62FIoUDKkkHMKJkCkVzt3dhhqRLLjiDikVUeTP/SKaZlEcpawKxodHK+ohLAU4ZluisSU7zzHHcdM4R9uffeNVhmeDnop4yoGnUcaAdmWAD6gof0ha6yybw8fHUtmk4zFiYrpnu3Fb0nCCRTxTBQyqmMBsFSxMi4O1SP7CPWXjsMdl77uMOzfwWbk2qGooZoWs8EDR9pXCIrUHzi40x3HuNiJ7InyjO0y8674yQNupfFKaetc7f4jZtHE0NRz5EDJeGOdqB16N6qlWGij9LDzhgJVnKjkfJQmY1akiZ37PV8gCz3JQf7rd0WGsenVkeBs/i2GlBBnkvugY4bj/tGwFwAsNmoD5eEXnvTtYntYoKXPoLJrE7rE/e/LYYiEDUgxp+LNN8K76I7OLxft7nHw3/08Ot6rGn3GdPsDFIp8gcNBOGaSRuVJs6Xp9Murs=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(70586007)(70206006)(82740400003)(7636003)(356005)(36756003)(86362001)(36860700001)(47076005)(26005)(83380400001)(426003)(336012)(107886003)(1076003)(2616005)(4326008)(2906002)(4744005)(316002)(110136005)(6666004)(478600001)(5660300002)(8936002)(7696005)(41300700001)(8676002)(32563001)(357404004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 12:21:21.0098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0a7d8f-444a-473b-081a-08dbfbd603fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7499
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Tegra Security Engine details to the SID table in host1x driver.
These will be referred when registering the SE as host1x device.

Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/gpu/host1x/dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 42fd504abbcd..b564c7042235 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,6 +214,30 @@ static const struct host1x_info host1x07_info = {
  * and firmware stream ID in the MMIO path table.
  */
 static const struct host1x_sid_entry tegra234_sid_table[] = {
+	{
+		/* SE2 MMIO */
+		.base = 0x1658,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 MMIO */
+		.base = 0x1660,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE2 channel */
+		.base = 0x1738,
+		.offset = 0x90,
+		.limit = 0x90
+	},
+	{
+		/* SE4 channel */
+		.base = 0x1740,
+		.offset = 0x90,
+		.limit = 0x90
+	},
 	{
 		/* VIC channel */
 		.base = 0x17b8,
-- 
2.17.1

