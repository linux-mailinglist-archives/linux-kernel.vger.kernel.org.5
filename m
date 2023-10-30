Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344D37DB735
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjJ3KBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjJ3KAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:00:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2810B19BC;
        Mon, 30 Oct 2023 03:00:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ5qGShrg3YjVoZ1ebBXNGDEuBjb2YPcV7oZjDdRPkukeyhbYiZWvjZdcwzx/tMQvsaIzdr/5KVuqWb8WXnEb0JlwAXsXaO16sFGT5nc2Z1VqAQYtE+ord1SpAMYm1PVUs8W76rgy4u9hHqChpIW9fcYBJEl3CyInUUJMDg33GO+60OylCySaXsjiKzORvq50pw14BAy1K7fcOFxH8+jYbjBB9JdtFBhdXCHVnZ3CcAZGvkvtS2fi3rW+GFmWxW+3KVPCFqE+96XcadgUxQtMFXaOSVBjd9BU/vQWK4il0t+c+SeGjGJHmCY4bR1JIKhYjQmUKHZq4TleXQl3aqzyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akBPLowOSUrhs+oLGHxOe6fnx90X1v7778B2B188qTg=;
 b=jgUDuKxfPFHzx9BbRx227W/NuzIxpp5oKR3/aS6DQYIeQoE6QJ/52GigmJL5eH2AaWNV8eNsRe549EpKbvQlKNzlzl9ic2Q9ZeRtmfJGtYsSegafjDniJVybbW5kaDbyxImEkaN9tnoyuWor1GW01MAlwvloUedzLz7cHayByPqhYVO4snFyQxYoIOM4NyJ9pGg6e5WmN/CR8dRoGHAu4tO9G04pxPCycA5U+6uj1gKZXSwbubBqv9dhDb8LiaISvQhWXiKjnEznB9IRpDGRUFsJo1GuJe9EyGX1dLQLdBMaCs6O5JvEC1V4Ty9Um9mo9GknlFx5vdyJD92bgXaHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akBPLowOSUrhs+oLGHxOe6fnx90X1v7778B2B188qTg=;
 b=XWvNtVc3vxcqrLd/TTPS/XBC/x2va9fWMEI4Eq8lqIVWf4ianQjq2U3AdIFe7hzX0gfxm6MT8o83EId2V3zmIltmUPmLy/s3RuZudE8JRIOkgHb+zdvKV+a5Alz98kmfJJj1Ims2KxxbsZ+2rogwez687Dwf5eT1uSLcNidU6xI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8513.eurprd04.prod.outlook.com (2603:10a6:20b:340::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.16; Mon, 30 Oct
 2023 09:59:45 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::9ba:8e4f:1465:9351%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 09:59:45 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v7 03/11] arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
Date:   Mon, 30 Oct 2023 15:28:41 +0530
Message-Id: <20231030095849.3456820-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
References: <20231030095849.3456820-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8513:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ca4284-c0f3-4df2-dd3a-08dbd92ef1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbNmNfaGGiMY+m3C3yFH5TlzXnWUUvHZuv8fy7q3vuMeJW4hJ8ZhbncI89044IJNk/8unAOS16LQ4w3RQBAxGHeigO2Cn2wuewrvaRNryWkMoNkOZdbCr+FWXm00Wx3sUHJJO88ELAqyr/4+iQKYGFLYN6473LbaHBMex+cDz3DikqV7RPubb3vwjsoIi7RmeTK+I7aimg7wZkSf+586qYtf5mr1J1FakgLeAymmw+7Y4er5sr0gVDhd0JtrR7hfNZIiwrgKhdIKNOV7iJWgzT/52U0cRJEWZnh5YTAHi0MJGbHz+N5oZdDy97kV2LM1yJxALeySfdCcjN5AKLTv1a48SprNHqovsATGO4rpPRrUVRaLwcYbnX3N6JRzDWF0nZfgmzRfjYAyKhGt6lf/rhcwdJu7itD1IZfe7u40BdLGXfQzb9VU0QBhnKJcJ3GhRA54mLdso6uMJqEQ68ie2254pNu3r3PWIZK6F4dP6PWEAP6S8yv5YlXiqrqJYQgmHZt9we7J7idAHn00nHBXCBv87/vBcgqxX5AcEh/9Kd/A5VGqtcfInfZCoXbFSuA6zMLo2PkPMo3Xq8gHubVosUPgzB4/vRokc6557mF/45PKCTOwd39L6L4FFw4RQEzmB6NBeAgDt+oCtH9xejZePAzSIa62ebOLbHM7ap5YLP4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(6666004)(66946007)(6486002)(6506007)(83380400001)(36756003)(38100700002)(66556008)(1076003)(2616005)(66476007)(2906002)(41300700001)(26005)(52116002)(6512007)(44832011)(86362001)(38350700005)(921008)(4744005)(6636002)(8676002)(4326008)(5660300002)(8936002)(316002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w6oZH6O8sIsYRlyE6F5rmLX7KpKm6tR8cRGLzdIyGLGgWZqsMFnhSdZDqeWs?=
 =?us-ascii?Q?SRls0KIIokdzz/QvhSMx13lnxmrbXHS3ZQQ13ZGG4QTdQyCLhMx8dDZy5XNK?=
 =?us-ascii?Q?/LrE47GGKayaveVvv9YFbOdQYM+htkc9pk7/0laHvOc0hmd9DhcJUWT2sTRb?=
 =?us-ascii?Q?3iNdcjt884ELK8wEMAH6bUKEdcCZDosuMcLBqZnueAvVqu3Jq7vhcvmTCNUT?=
 =?us-ascii?Q?mTmvpg6hoJc5njyzV10lELzwKQN+b3DI8Jgkr3W5HIi3CdKfq9P3acSKvi6X?=
 =?us-ascii?Q?ot63mFNrxO2BMS+WbBKCNtkmWjLB5pGiOZH3F7Jeme0qUAEIkzhVzq11cB2z?=
 =?us-ascii?Q?BcRhDM2QkWi2Pq14DBOxYPjQXA6IDDHxi9UCEX4+DFtyNQt97Z+VYV6sApi4?=
 =?us-ascii?Q?Z9P5EoHnvV5cABCkZyNUX+CroDVQyfgvjd657xf5gIyG/2rZV7VHobbTQQ8P?=
 =?us-ascii?Q?6h0APQnJZO3+YndOclWDyOxfPqVy/V6ajqvXkZPz7FV/GuCEdav5/r184ktU?=
 =?us-ascii?Q?DiPyd+EMVraMgBi8puKWRAFNugn7D6+engy+7QDbGPfSxiX/TtH6VyRORg9g?=
 =?us-ascii?Q?zzYBHVlrta/KFXdAmvnNVFMJMCMY7Lh9V0O2FCPijjcwWbKu4LtchEzOhTW3?=
 =?us-ascii?Q?nfQrbqS8PQFV4q4MYtAUndS8EN0nhd9zxPoh9NgcrDu/xfsNKm8720fYNYbn?=
 =?us-ascii?Q?MDAf45xYFm0VMP+7x8eyUXbxwucI+8oKSspHUnC0Q/PCC8K0QBbkuYYL36CN?=
 =?us-ascii?Q?b4lw9+ERB4xWyTxD/0QOEY50sQdghcMR1So9VmtykwLUeU7t69o7dlMfCy24?=
 =?us-ascii?Q?PcQ/t2GTv+7Rm8x6SJ5zWTQxJnI3sAo4oLWfAUWYSYAHVgWx9NMeSZC0qRe1?=
 =?us-ascii?Q?UjMy9jzdLk8GthM3V0jt5LFx07B7Y+owTICwErLRtGI51TPVdy49ZfL39S4W?=
 =?us-ascii?Q?+RE8mDQcRbZ46F3aryo84p3P3ZCzYBxDt+BSI3gxnW1YE040KIbZ5MaRvJtj?=
 =?us-ascii?Q?BISt6IhRXcJuQntieR0/l+waKY8rn0C5zTB1K0Te3oTxJMncMpSEt8EvQuS1?=
 =?us-ascii?Q?DyfHl3SfHT7nxm0L9eNwLY5rC7iZQqsSNjL4i33KfXEg/dDAd3unBRZL4tIe?=
 =?us-ascii?Q?NCVILoRk3lePCAe6Ijt8cnCzRE9xqhF4j5JLDrpxFmq88KDUgoJy2qbKeu+4?=
 =?us-ascii?Q?fJUekxchvpy4LfJEB45xLn5dQKTV4VH0svxiGSpnLCCfhHoRHK4TBhPnUDuA?=
 =?us-ascii?Q?mqQmxK+tpZCKHFD4Nq6Rt/eBYMk0+woHqUxL9KTvGTQjO/3XKK1TMDTrpk35?=
 =?us-ascii?Q?NLezJ6ifDKkArPb4U7sJsTAQkdUuuZVVPs7EpyloOZvdoy3NR37A+mzWKF+G?=
 =?us-ascii?Q?ZHwjt2Mrd7MgdQCKsFBULnNcU+FqcdARxdYmV+F7TwdpLAcntB6/3P0Vh3iE?=
 =?us-ascii?Q?Q/G0TStk6MJuTn/K+izt7ctwY96uRrXPgBuC/1EmmhDgcRFTt/dT5F4hjbky?=
 =?us-ascii?Q?PJBDLJZz3OIGmbyNhVgSIw323q/xkCVhehpqSZ+9DVoHiFZ9VdyUxfxIccFk?=
 =?us-ascii?Q?V5r+N1YtKDar4p2YCrmSN46atlDsvH3cGQswyOCe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ca4284-c0f3-4df2-dd3a-08dbd92ef1ab
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 09:59:45.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bqYTdtqt2W9uFVXMmttSJy4IXkgfQ/z/tdfg3KEsx9tGBPZdGzprLLGIGyOUB2y1DF+vMTLXO0lI9+ntY+XgkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8513
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 946f2b68d16f..7b66de3a392d 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -578,4 +578,12 @@ gpiod: gpio@2e200080 {
 			gpio-ranges = <&iomuxc1 0 0 24>;
 		};
 	};
+
+	ele_fw2: se-fw2 {
+		compatible = "fsl,imx8ulp-se-fw";
+		mbox-names = "tx", "rx";
+		mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+		sram = <&sram0>;
+	};
+
 };
-- 
2.34.1

