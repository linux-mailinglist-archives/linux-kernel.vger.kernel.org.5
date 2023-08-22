Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EB7784652
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237412AbjHVPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjHVPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:54:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6BDCE5;
        Tue, 22 Aug 2023 08:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9vpu4a1aVQMFs0/bQC6v67YwEIi+BnE3V9upjzTgivG0zQOwL+JKyExjMPK9GGcNPZY9htB2evcg6AmXpHcMZ+fFRwbe4NQMDADu1fXfLupzE9vUfZwp0r2ilx+uWeJsM/oiXAKvw7QLUwanF8I6GxpPMs3+ULWKmMCxly3+53Vd4KNbme0ztsDfBrDxzXTHYQYu+M7xT2ep4mUyTk6QpdTjHu95JOGSbt2kYEnJA1IFH2Ollkv46OKQ/TAa0pKd3nyYW15U+kM+WN4L+mcMTbpAS/njJ24vtmtl83hh5kWf/TtzKeUiUjGwU2slWDV8aQJTnSS2jDXH3uYz7U1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEq90g5Uih0h0zUkO+r8Hp+rp3zboJv8ugKKl6GiZu8=;
 b=W5P8NiJXrMx2X1GkH03kHWGAIx2Ku9RfoNSIJAx+fABTawyqW1hR58pJm6AsG2fdgkt5sG+qhglbRQraXUQVtqQB04FeLL3kD7qxwyQaH0Zwz8xye1Q3JPeJww7gxD8h0n3VO3aDV7kejIdCAlpbPuT/clYmLZWUUQIU0OS25skkyEbabusj8eyeNoOtAm2+Xja+jTd/Pru6a/0QZFuUkZjtYswEK6gwGXnYesqzDjdCN2MoNB4F4rWm+w2Ul4hftXje+5meHgTRnZjc60Yo939AbboBZ20XA3K1UlOoCj0cjxQonxorIBHX5k3kiPXXY/0o/liKGzq3X0MuGjMYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEq90g5Uih0h0zUkO+r8Hp+rp3zboJv8ugKKl6GiZu8=;
 b=Dreer0drGI8NMUaE2h0+e9yM8IJXLUDhtg/yvzpBFjfTvSYFeqHBsKTywVDIYhXbGiPmxGDsKRcCkV0nL/xsszZmcnltunC536XgueAffOW3sXbLUAD8CjiObaNc7kvjf+9FKVkO9Ed9OYEMm1JwkfovCMbyTQO3CiE6UYC62QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:54:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:54:18 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 5/5] arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3
Date:   Tue, 22 Aug 2023 11:53:33 -0400
Message-Id: <20230822155333.2261262-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822155333.2261262-1-Frank.Li@nxp.com>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c57016c-afa2-4f18-3cd7-08dba3280ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QX5ObXLDcTh8HZVhVn24/hRoMzHn/5yaKo5VRTHJP1kWdWRiOQQiNWnvW1mCZ9qBx+yw0NY8IXdBTzzosNkx7riSRRu8fpY3sRL9ph2hl1jLuoaEX0gLl8WKX+AuTpq0F2WusJpYujO9qpniNCNv57/jID7Kjeoluwan//cXoZX9duJPI+VuLjpatQwWeRT2izDc7cJNUVovfnLHm7rilHHaI8qUJY6IJo7RQb1O6B+ijhnhkNiac8Rb/32x/9qrkAaKhr8HM81usanWdzKNoxMUkZacx6pb98x9YgT5otb7voW7HMH5tvi2nxRsQXl8qFJSatgru0PLvt/7VWsjMNktL0LABzUbEQqfr8jO3Ap0vEq1ECG/i1nmsfhOYb4S+Gx+amB5vHOMaGFB9xmjHppZAIEzwhjDrrrMCRwu6AUw5Mk7KnxcmaqgWQj373WCYzCX1VTGt7GgbaUjfu9alpj41+wmOxuO5nWRyATtK9rb4+28VTt5Oqvo2Q/f6aWP5edulXxtnBqEIB4tzhyEinsKtcawaIsfbFgeJjzjR1wX23sPltUZ+EATtT49a//pZ3LkLYqkrzp8dgfeS7iSELDrso+Jz0TC+BZ/8jpPmTDFXsUI1/KG5J0Z7ZpEyOIjG6966Er21vymvtAb8PvuJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38350700002)(52116002)(6486002)(38100700002)(6506007)(5660300002)(86362001)(26005)(8936002)(2616005)(4326008)(66946007)(316002)(66476007)(66556008)(6512007)(6636002)(478600001)(8676002)(6666004)(41300700001)(36756003)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1xrxcptlBxEJGsDgqgyjGymg6uOPWNT3+09VkMbtyufmG86wZZxSU3jwmSHy?=
 =?us-ascii?Q?wk/+oqEfj2R2JyhRnqXCzNwzXMXs7md6EMMW34bfnh6H9rZ5ODK8kAy6lptG?=
 =?us-ascii?Q?DXi1cYE/NV1Phb/XGJXN5wANHbIHaMP3QPnPyHqBwiOXCGtZ8YOeqD/PVuBs?=
 =?us-ascii?Q?LJUAHCx8b/GRd/guL5Mq2i68M8GnalbD0T1ej0gi2gytwcv00pv455IjHHxA?=
 =?us-ascii?Q?bTFd77ZMj8eDRKzChGB1i3P0Xk5YDCAfIwtGSXaZSOhC16pUFsOUO7jHKqgs?=
 =?us-ascii?Q?/XlvbzpdqbXtu6Er33Y8N2iMOjHyduEB8ucyNStwuYhC/jzaLUCTXGVyG/hV?=
 =?us-ascii?Q?+nN4d6QVWSxY9Qd4StfLS+5XFAYZhL3A7KVy65Eegc1buzN3p19MDIC9WEQf?=
 =?us-ascii?Q?poAkUVB93u94aq9++zpGDCEA4FKNitDtmCCioYtj3kOPgYY0Wj9w6EYBzoR8?=
 =?us-ascii?Q?N/za46DxDqJPcpGkWZ54//GG3oZPKQHAnCaUFTd2fN+rvA+CZsxvE4mqxI6g?=
 =?us-ascii?Q?G0tUBSc9IGTJ/JrIwYKoQIFDnO4eXjiKbVziStJrr00qWkCa2oiQKW1wQRl9?=
 =?us-ascii?Q?MlHcPSNH01FVWe4H66v4H2QbJoQhiRplkb7BcpNuppTzVJFtnAAfLLeNTEAl?=
 =?us-ascii?Q?4Os5LU8lA1YYlbAqtAKzi7QjMnncNqx3M1Bh1W522ADMi51uVpnbH32QKnZt?=
 =?us-ascii?Q?kUXQE9Pa5PI1o8/ihb7s/jHqznWMWtDS2/Bxyw2NBwHBpVqjTeFGJRmUtN6/?=
 =?us-ascii?Q?rWiNbNlO1SS3t81dDxCZLiUtg3CGehFHNQDEbKha/T+2erVszFzj/3GFYsGk?=
 =?us-ascii?Q?A5gNIT3fFEfjP0ucTy7yKLqFRGJXhBND+hedMxcC9FgKOni5ygOB/kEJPgGS?=
 =?us-ascii?Q?VrTI5KLmVx5pgqABpPEjxgo9oGey1wiIoJKnOLLASMnIoaK73WFpmTEDsTFt?=
 =?us-ascii?Q?1Fo3pauHumYjZVArrYA2QAl+8h7riIQ521C9zG7j1jDHPaQ9EgHreyq8JOdD?=
 =?us-ascii?Q?o2nUGFkI4LfvDIkspV0jVKvtpQO8oygax0g3Hj6zKDupuL68CWC03kK9+DRq?=
 =?us-ascii?Q?7smRNu7AgWtKTixRHQP1Oi24Q1aCOrlzD1qcn4ffZZiAyayIdz0R/LqPuSXv?=
 =?us-ascii?Q?yKcLKKFq/8495Hhy7WZDmZ2uBgNnhJc/tM7/8UPgTDwYsPrqwXFrQG740E8m?=
 =?us-ascii?Q?EnqhbHrw51vJUoH2t196EXASREtqph+H/S21doWtRKaBjiMJL+mk1dedcHkJ?=
 =?us-ascii?Q?k2bZwcNLY8ne0+loaAUkPZEgcC+DKUNc+0WTjF+xtozrrXHdE7gl74b47wEY?=
 =?us-ascii?Q?K2TeiRhDU7WybxuR0iW54ZrUHAkeo5SBbNbCt19Mw+LqPtlLQOzlNiR+olVG?=
 =?us-ascii?Q?2iS6PYWH4+ZDESmVF3S6ql4dSv8wWiXCBfrm3D+e5ksJKDrROUddJ8SRU+lI?=
 =?us-ascii?Q?Z5/3QfWoWCqKWMEXPaKC/1vwT0pCU4ArxRV9zRijbUdcx9pKKN5pynwnZHb9?=
 =?us-ascii?Q?PGYiu1eLV+gQ6+SDh/VZpVOOnbLQCaQnBpsetHI1JUnoWVocBTFMKIiGX5H7?=
 =?us-ascii?Q?4zkbcTpKx+FtHIrmmeA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c57016c-afa2-4f18-3cd7-08dba3280ad3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:54:18.1399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJ0zFfqFjnvfixAIYHn+Rh8x7PxzICSXcKOtxsu+h5Rfo13Wtcqar1zlTWtd06S8tQaE1pht/6XR0/hfmGq6BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable uart2 and uart5 for imx8qxp-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
index 7924b0969ad8..99611729943c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
@@ -187,6 +187,18 @@ &lpuart0 {
 	status = "okay";
 };
 
+&lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+	status = "okay";
+};
+
+&lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>;
+	status = "okay";
+};
+
 &mu_m0 {
 	status = "okay";
 };
@@ -340,6 +352,20 @@ IMX8QXP_UART0_TX_ADMA_UART0_TX				0x06000020
 		>;
 	};
 
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			IMX8QXP_UART2_TX_ADMA_UART2_TX          0x06000020
+			IMX8QXP_UART2_RX_ADMA_UART2_RX          0x06000020
+		>;
+	};
+
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX       0x06000020
+			IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX       0x06000020
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			IMX8QXP_SPI2_SCK_LSIO_GPIO1_IO03                        0x06000021
-- 
2.34.1

