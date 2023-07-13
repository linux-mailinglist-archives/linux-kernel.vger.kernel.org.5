Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D18752407
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjGMNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjGMNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:39:08 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E471B4;
        Thu, 13 Jul 2023 06:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Obokz1qcYlIapBDEQzeOmwJ8xVVHZpgbKEl3iShfkOhMvl+dUJugJ1x31rwcM0IbTedJAZpzPONjHEtopalrP/ndMMQOkYO7R8NhnGDl2wig049OWGX5OZkYfLz7Hf/iW9jB8iwSkCxvbXEr/C6Mov4zw8IaoyP3Q6+J/6UwWOYbWSrDJazdfCjG6rHlnRgP8QAOBepIcAu1jox/GxK7zyxuLOr+Du6WeobHxq9Jr+VEWrulnNe5vdzpTPPb1yE5qUyGx2vppRRi8q/KCoKM1pf7iMw+vdrUE+nTo5l6Xk2Ol0CPGJXfFyBzq56XbsZfL1l53CQ+kLm9ogEZyVaZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAcq5pMDy6e+BMNtaIR0V3v2Fcl7rRATb00eyu8YVRM=;
 b=G32NGnp80tBTwY5gd9xWWaZz6n7AAZEVlc9HGpKyLLAouPXDIf80JDDWH7iTpt0Wc3lXp0MRUsIBmlnakJABdgWp3EEOgPoaUZBn9xbwvMoUdizHTJvy0Deqr9Xz9o+A5YhhfUp/6//5c7wevomq/itwf+OT/NkLvg0cQQnyEZL+Y7zF1zjWuDwHXPRKQbDc0HwsQ+SXxbbtOZk4MUZRskUhmSy7MmZz74hX1sOrOI30IE+G2/blvL1+mt5L6r96V0zyfTD4oQtIxUq1L+K1x4iZEeTSH4TA6CsFsGuzEUfKqY3ayWfXsdPDLXqPDIYhGwQoaH73i+UHjzy3pq7nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAcq5pMDy6e+BMNtaIR0V3v2Fcl7rRATb00eyu8YVRM=;
 b=Rg9pdnaViLgfiRtcXKkOIong28Elrp9dJ4WrF/3ghwUN41jgK8U8JqUKYlYyvUNvAyCTpS7pWhjRQAycby54dJ6+Buo57upOKSkJGxe7qFyTukfHxrBn06LiIlNlJBJo/6vdkzXcrUytaodsVKXgwSpzWlO/8JRuQaIxaV9pQLBkEd4VqgnVBH83jeVNi9Miipzs/xztpnI0nqEws80RvLJTOtS/Vbbcg6RgLnM2WZsg8PIRXSNkohfglI3InO3rh6H27vVsYEs20Ij/ONRVULT0cI1w5cG5KwS2pGwNEqi40YWJ6v35yVX2NSCppuKk4yz2wGZct03Nkv0XAjK5NA==
Received: from DS7PR03CA0156.namprd03.prod.outlook.com (2603:10b6:5:3b2::11)
 by DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 13:39:04 +0000
Received: from DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::d5) by DS7PR03CA0156.outlook.office365.com
 (2603:10b6:5:3b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 13:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT088.mail.protection.outlook.com (10.13.172.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26 via Frontend Transport; Thu, 13 Jul 2023 13:39:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 06:38:57 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 06:38:57 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Jul 2023 06:38:54 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <shaochunk@nvidia.com>, <sumitg@nvidia.com>
Subject: [Patch] arm64: tegra: update CPU OPP tables
Date:   Thu, 13 Jul 2023 19:08:50 +0530
Message-ID: <20230713133850.823-1-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT088:EE_|DM4PR12MB5198:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb3b1c7-d310-4b49-67d5-08db83a6864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +V8c4L22ROmBzPXvqnRX2qEM9SEkA4PTft7mvkWerwM4NxlNLAWqZ6mVfZL9dpOah81fX++TvCeZ+Q6BIBldm0AFP+sU23XMH7k69oMbVP0gB/Y9AML4BzILg70gEY34WNjJYigRWX0YJCeWp1eZ0wp00rqHbmqbBvBRJEkPmQoILEXMKJfiRv39Og1S3k2hQ3DhWy0d4drsxv0eqBGlCZ5vVVtNT8wZodaxOs4+yeE02XhRnGDNOWenchkDv5gdoHx20ytozP81NQZGHNxD9OoNU7qHzMYcts6kkAD1J3Bas0rd6VnjT7RPucxlGa2zwrO0rPODKlToxHvLujSG0MvxweQvZoFcaDjrT4QNAnKCgEWzACMgjRQd34/pbgvmWr9OQ/qgSvKNyRXbuw1lfPP4EIlfRcRb+Qny8+W4sPt67udjmZgHhFFTztVcR3RtneJQIr+3yCde/E8owZblO9itRNsGW3kDIKhwSc+q17ha//K5RSAjWw9feyqO5LfKED1Gq7zeB6/V+VdMUxEHeh0jR2ay+294ebra3LKq9tgHoV9HL018dhAkGS7YztQxqEXWpLj0JiJSopediYe9ysuKFOjvloVszHSr+o6hznmPOC//47MvaTe1hkMYIusfm9HmdH2k5enpLFUcrGctMcLfICMMre8oh3GXAZ6FxoZNEQeXfsa30wrxFNBW319HONMezgxf5IVM9CgBYnVSoR1X4TLn8ROUNGoiezbFj427omCNgv/N8Se6wxhGb+s6
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:nb;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(70206006)(70586007)(316002)(2906002)(30864003)(41300700001)(478600001)(8676002)(8936002)(110136005)(15650500001)(5660300002)(54906003)(36860700001)(6666004)(7696005)(40460700003)(107886003)(40480700001)(426003)(1076003)(186003)(36756003)(83380400001)(336012)(82310400005)(47076005)(356005)(7636003)(82740400003)(26005)(86362001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 13:39:04.2655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb3b1c7-d310-4b49-67d5-08db83a6864f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the CPU OPP table to include all frequencies supported by
Tegra234. Different platforms can choose to keep all or few entries
based on their power and performance tunings.

Signed-off-by: Shao-Chun Kao <shaochunk@nvidia.com>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 318 +++++++++++++++++++----
 1 file changed, 264 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index f4974e81dd4b..32067cea9202 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -3589,72 +3589,142 @@
 			  opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp2: opp-268800000 {
+		cl0_ch1_opp2: opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp3: opp-268800000 {
 			opp-hz = /bits/ 64 <268800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp3: opp-422400000 {
+		cl0_ch1_opp4: opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp5: opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp4: opp-576000000 {
+		cl0_ch1_opp6: opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp7: opp-576000000 {
 			opp-hz = /bits/ 64 <576000000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp5: opp-729600000 {
+		cl0_ch1_opp8: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp9: opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp6: opp-883200000 {
+		cl0_ch1_opp10: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp11: opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp7: opp-1036800000 {
+		cl0_ch1_opp12: opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl0_ch1_opp13: opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl0_ch1_opp8: opp-1190400000 {
+		cl0_ch1_opp14: opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl0_ch1_opp15: opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
-			opp-peak-kBps = <816000>;
+			opp-peak-kBps = <1632000>;
 		};
 
-		cl0_ch1_opp9: opp-1344000000 {
+		cl0_ch1_opp16: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl0_ch1_opp17: opp-1344000000 {
 			opp-hz = /bits/ 64 <1344000000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl0_ch1_opp10: opp-1497600000 {
-			opp-hz = /bits/ 64 <1497600000>;
+		cl0_ch1_opp18: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl0_ch1_opp11: opp-1651200000 {
+		cl0_ch1_opp19: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp20: opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp21: opp-1651200000 {
 			opp-hz = /bits/ 64 <1651200000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp22: opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl0_ch1_opp12: opp-1804800000 {
+		cl0_ch1_opp23: opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl0_ch1_opp13: opp-1958400000 {
+		cl0_ch1_opp24: opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp25: opp-1958400000 {
 			opp-hz = /bits/ 64 <1958400000>;
 			opp-peak-kBps = <3200000>;
 		};
 
-		cl0_ch1_opp14: opp-2112000000 {
+		cl0_ch1_opp26: opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl0_ch1_opp27: opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
 			opp-peak-kBps = <6400000>;
 		};
 
-		cl0_ch1_opp15: opp-2201600000 {
+		cl0_ch1_opp28: opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl0_ch1_opp29: opp-2201600000 {
 			opp-hz = /bits/ 64 <2201600000>;
 			opp-peak-kBps = <6400000>;
 		};
@@ -3669,72 +3739,142 @@
 			  opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp2: opp-268800000 {
+		cl1_ch1_opp2: opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp3: opp-268800000 {
 			opp-hz = /bits/ 64 <268800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp3: opp-422400000 {
+		cl1_ch1_opp4: opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp5: opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp4: opp-576000000 {
+		cl1_ch1_opp6: opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp7: opp-576000000 {
 			opp-hz = /bits/ 64 <576000000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp5: opp-729600000 {
+		cl1_ch1_opp8: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp9: opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp6: opp-883200000 {
+		cl1_ch1_opp10: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp11: opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp7: opp-1036800000 {
+		cl1_ch1_opp12: opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl1_ch1_opp13: opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl1_ch1_opp8: opp-1190400000 {
+		cl1_ch1_opp14: opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl1_ch1_opp15: opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
-			opp-peak-kBps = <816000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl1_ch1_opp16: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <1632000>;
 		};
 
-		cl1_ch1_opp9: opp-1344000000 {
+		cl1_ch1_opp17: opp-1344000000 {
 			opp-hz = /bits/ 64 <1344000000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl1_ch1_opp10: opp-1497600000 {
-			opp-hz = /bits/ 64 <1497600000>;
+		cl1_ch1_opp18: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl1_ch1_opp11: opp-1651200000 {
+		cl1_ch1_opp19: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp20: opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp21: opp-1651200000 {
 			opp-hz = /bits/ 64 <1651200000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp22: opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl1_ch1_opp12: opp-1804800000 {
+		cl1_ch1_opp23: opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp24: opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl1_ch1_opp13: opp-1958400000 {
+		cl1_ch1_opp25: opp-1958400000 {
 			opp-hz = /bits/ 64 <1958400000>;
 			opp-peak-kBps = <3200000>;
 		};
 
-		cl1_ch1_opp14: opp-2112000000 {
+		cl1_ch1_opp26: opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl1_ch1_opp27: opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
 			opp-peak-kBps = <6400000>;
 		};
 
-		cl1_ch1_opp15: opp-2201600000 {
+		cl1_ch1_opp28: opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl1_ch1_opp29: opp-2201600000 {
 			opp-hz = /bits/ 64 <2201600000>;
 			opp-peak-kBps = <6400000>;
 		};
@@ -3749,72 +3889,142 @@
 			  opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp2: opp-268800000 {
+		cl2_ch1_opp2: opp-192000000 {
+			opp-hz = /bits/ 64 <192000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp3: opp-268800000 {
 			opp-hz = /bits/ 64 <268800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp3: opp-422400000 {
+		cl2_ch1_opp4: opp-345600000 {
+			opp-hz = /bits/ 64 <345600000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp5: opp-422400000 {
 			opp-hz = /bits/ 64 <422400000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp4: opp-576000000 {
+		cl2_ch1_opp6: opp-499200000 {
+			opp-hz = /bits/ 64 <499200000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp7: opp-576000000 {
 			opp-hz = /bits/ 64 <576000000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp5: opp-729600000 {
+		cl2_ch1_opp8: opp-652800000 {
+			opp-hz = /bits/ 64 <652800000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp9: opp-729600000 {
 			opp-hz = /bits/ 64 <729600000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp6: opp-883200000 {
+		cl2_ch1_opp10: opp-806400000 {
+			opp-hz = /bits/ 64 <806400000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp11: opp-883200000 {
 			opp-hz = /bits/ 64 <883200000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp7: opp-1036800000 {
+		cl2_ch1_opp12: opp-960000000 {
+			opp-hz = /bits/ 64 <960000000>;
+			opp-peak-kBps = <816000>;
+		};
+
+		cl2_ch1_opp13: opp-1036800000 {
 			opp-hz = /bits/ 64 <1036800000>;
 			opp-peak-kBps = <816000>;
 		};
 
-		cl2_ch1_opp8: opp-1190400000 {
+		cl2_ch1_opp14: opp-1113600000 {
+			opp-hz = /bits/ 64 <1113600000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl2_ch1_opp15: opp-1190400000 {
 			opp-hz = /bits/ 64 <1190400000>;
-			opp-peak-kBps = <816000>;
+			opp-peak-kBps = <1632000>;
+		};
+
+		cl2_ch1_opp16: opp-1267200000 {
+			opp-hz = /bits/ 64 <1267200000>;
+			opp-peak-kBps = <1632000>;
 		};
 
-		cl2_ch1_opp9: opp-1344000000 {
+		cl2_ch1_opp17: opp-1344000000 {
 			opp-hz = /bits/ 64 <1344000000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl2_ch1_opp10: opp-1497600000 {
-			opp-hz = /bits/ 64 <1497600000>;
+		cl2_ch1_opp18: opp-1420800000 {
+			opp-hz = /bits/ 64 <1420800000>;
 			opp-peak-kBps = <1632000>;
 		};
 
-		cl2_ch1_opp11: opp-1651200000 {
+		cl2_ch1_opp19: opp-1497600000 {
+			opp-hz = /bits/ 64 <1497600000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp20: opp-1574400000 {
+			opp-hz = /bits/ 64 <1574400000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp21: opp-1651200000 {
 			opp-hz = /bits/ 64 <1651200000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl2_ch1_opp12: opp-1804800000 {
+		cl2_ch1_opp22: opp-1728000000 {
+			opp-hz = /bits/ 64 <1728000000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp23: opp-1804800000 {
 			opp-hz = /bits/ 64 <1804800000>;
-			opp-peak-kBps = <2660000>;
+			opp-peak-kBps = <3200000>;
 		};
 
-		cl2_ch1_opp13: opp-1958400000 {
+		cl2_ch1_opp24: opp-1881600000 {
+			opp-hz = /bits/ 64 <1881600000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp25: opp-1958400000 {
 			opp-hz = /bits/ 64 <1958400000>;
 			opp-peak-kBps = <3200000>;
 		};
 
-		cl2_ch1_opp14: opp-2112000000 {
+		cl2_ch1_opp26: opp-2035200000 {
+			opp-hz = /bits/ 64 <2035200000>;
+			opp-peak-kBps = <3200000>;
+		};
+
+		cl2_ch1_opp27: opp-2112000000 {
 			opp-hz = /bits/ 64 <2112000000>;
 			opp-peak-kBps = <6400000>;
 		};
 
-		cl2_ch1_opp15: opp-2201600000 {
+		cl2_ch1_opp28: opp-2188800000 {
+			opp-hz = /bits/ 64 <2188800000>;
+			opp-peak-kBps = <6400000>;
+		};
+
+		cl2_ch1_opp29: opp-2201600000 {
 			opp-hz = /bits/ 64 <2201600000>;
 			opp-peak-kBps = <6400000>;
 		};
-- 
2.17.1

