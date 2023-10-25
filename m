Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A7C7D6244
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbjJYHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYHS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:18:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD9AF;
        Wed, 25 Oct 2023 00:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVsLPRjvZUOpzDqDhD7ZuhaDn9j/19qV/vDv2gC+WXAo6bFWg6Qu7Jg4UnKwyMebWomHxyB61Rpq6k/5U8IGL+EA3/W9A614pMmsOAHO4b9iM+m0LmorKFs03guwb6ka3JM5buDZzpZv7Aka7gw4mHjos4mRSYNhSU0t3P2M9vVk1a2oCRe4pOq0Lv0/tUXNF5SNAvqkRKGt/OgqEVlFkrI317RyJ80cS5h4tWw/2YXRoG6B2xZh6U2cQZF3Duf8WxIJlhgM+WQ6kR1oKle3zIN5Xgr62O8bfVARmw74/LXcuba0FsfHSdVgHtR+fJe+25Bc+zBdYtcmlupGmcnu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWjxSn0cUaUw8CsEnle1NPosdEXhCX/DVl9AurKBj0A=;
 b=FuvQkI7AP5BXen6g5x8hy5NPxbkRVV3Cbl5EL/6PSSPnLszeCtuKG/YSMWfkASJV5XXGZLQoVi0CgcyGx8sj+kiemriojkacNFoAqhaipwViG3PsObAtbfwX8kYL22XtBwFvIb1SEpQMTXET+ACgmOspzVea6E0VLKLLA/xUuMkvG630Iwyk3xmQGK+zaCpcSPgdhPWEnSqcSodOe1baJ8XlN/uiQl9NeGQw5eG9HMSFr8pKzPenCQbCHrdBL3xqcHbEy0jdBnl2zqr10gjLVu/7edDfvSEVHEbFk5e7Uvcouadrx+ZlFIHE8sPXfBz5vwehU3FyGm03wQwWf7693g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DWjxSn0cUaUw8CsEnle1NPosdEXhCX/DVl9AurKBj0A=;
 b=bNW50soAfW79XHnVkiT5S35xdknS0Efz4mpMF8bgav/lli2kvlfUF55clQCfXaJPjXRyaPOtZG13wl/8PrbR5/1sjR6UWx92m/up91xVRVh8pS6x2pCRkPzpo9NZALRikm7lvywE6+wFBpBryxVIyJ4hXNzC2E9iKgzft1lcN78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 07:18:21 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::50bf:dcd6:885e:32c4%4]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 07:18:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/2] arm64: dts: imx93: update analog node
Date:   Wed, 25 Oct 2023 15:22:42 +0800
Message-Id: <20231025072242.1134090-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231025072242.1134090-1-peng.fan@oss.nxp.com>
References: <20231025072242.1134090-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 38c905de-def8-4b0b-566a-08dbd52a91a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3Tf3AMAF/G49PermYeXxf1SiozOoxDYx/esECOh1obioHTcA/HL3P4iC2ofslSPUbscWubb1po8Q68lMj0MKNiOohjsyOsXN8BwaK6D+z2iEUXdG1/sl6Dbs+lQxQNW6zsF5gYzaoIWPNKniuI7DD6Z/J0/tb2cIw003Ba3BOYg/t+aWLAWKUxx8WnMed1421/73ROFkqWdXbHlVWFB1Zeg+vaYXDLWwAFoLQ9jaqp0+lUpCob7pultLJ94lUgSfF8FpV7ckAqTmB7TKS5+HXovbyvqG2FO26gqs4FOQrYYHF8buv+NsSQZOW1In3geAlUd61cDQ+2iTXM3heCk+at88kclL6j4+rD9UZpj/OKKWgrm1WkZpwmjf4bolsPFOG2EvnVysu84l9whyiujaGeuO3LMoTFBPtcLtfLvRPLVVwfu3/trSddMpFwiPpl6eM+0XSHG4VV2sf1woLqvc0FCnTIVvmAPq38rOjGDgKEazFLIwU1K/KA0i5aAF8iQgfW54/3NSHbl87Jj3G44XsTz4OkvtMe1TeL52kgMl3I3K9C8LCfO9LIALlmFFy6c21yobbYfVeoTVifyxeR34wA4XNAWxLGprVD0Ad7L7sdboWmShaYS9fwMj82y00Wo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(52116002)(1076003)(26005)(6512007)(38100700002)(86362001)(38350700005)(83380400001)(7416002)(2906002)(15650500001)(6486002)(4744005)(478600001)(6666004)(6506007)(2616005)(8676002)(4326008)(8936002)(316002)(5660300002)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y+Fs/ooqBfolCcCV3mMl10Zx6RjaNUhOnEu7ThKXUQ/luaP6+JO6PUpLqIfs?=
 =?us-ascii?Q?Bkw8hfR3+zE3ZdZjnbL3Zn4yWVMGn+H6jnnoXcffq7pxW4exUj/GS/LLWzFS?=
 =?us-ascii?Q?kqRHFeP0PzEU0I3lurMgT1NgFGVPtzrehU6kB3lnHoBJw8ZCgoQ08t3bqn2G?=
 =?us-ascii?Q?mXhpdsZw1wekZ+vMzPP29qvQjej8YDEfQLpDmhnhixsQ1TrfCTRd9zaxNRbr?=
 =?us-ascii?Q?jQVuJTTsDdNkDCMVi1j5T1roGkvZR4rl0qHgBzRz3CKWuOB4qGTyqsdzHDEC?=
 =?us-ascii?Q?IN4PKrRVlf57mZzkD8w0JtpsoTmxpxn6/pTn1XEEk/H/+Y2PtNoPDg6DyKE8?=
 =?us-ascii?Q?H0IDpFYw2r3fqUDpE5G941tThT2uaaTwCYklGwZRFJmbOCb4jLti8qECtSr9?=
 =?us-ascii?Q?f0VOLR6YYD+xMEmncOT2zhuFA9aB0wFoeySPbhXOBd8kXYGSYXH2lvxNyW0m?=
 =?us-ascii?Q?ivwh2Dv7lxjAZYYgM4FwTqj/u1GaSElnEe8WOuoqR4+Oo/CFCDsDgRyIuUEA?=
 =?us-ascii?Q?Yszy8aUvaxwqETb9OTZUy1Xa/SZFKZXdGsoI7e4dZL1j7FrAwokK5d6wJ9q6?=
 =?us-ascii?Q?GBA53mIe2/KzD5RBCGY44IRvCMKS8di3+8hmB7NaiBq4wXKo92iB9h9s/b1/?=
 =?us-ascii?Q?ZzzkqIyxpfmPffUyCMMYvo1F+kSduPBitoLomEjcDbjhxH++7Bb3jbJ6Gnwr?=
 =?us-ascii?Q?RmU2xCs+Rk2B8MjzKoNHyJrEXAuVsDkT76FtfBKKnbS/sRa8/qOuIZE6SQQP?=
 =?us-ascii?Q?weGeJpZhq2MOfrkfqxA6AHU0HcCbtDWLU0d1v7YNBa06oq/NKc2DeXAD9uIL?=
 =?us-ascii?Q?Oou2z7DdVgCdN6s5JhhU0ABDCpxsg1Hm+K7qr5rVmc1YHU5X0oZBoeT4tW5f?=
 =?us-ascii?Q?EhuxGjjGP2QtkMhsuKcHi97sYWU/U3SlKiP8UJZL3/YkIvgtPr3BW9y55XJN?=
 =?us-ascii?Q?Aj0KkTXHbJqZ2qlCAL39XwdUlSlhWmYEbVg23VUHNHCx9isMU0w2KCyeWC/B?=
 =?us-ascii?Q?RwhNxvr9tjvjSPPzbQpWsy+T4O811dBgJmfpQDNp5/ZWehYSdkXvPq8I+IBz?=
 =?us-ascii?Q?b62dNl7+Vjq4GTxOZKF4NmGap3/JqwZaAvBBxdhKMazI6xaZhSX9MlvTL+ud?=
 =?us-ascii?Q?2QSL7CK92gRGrSYMoN2PnVVXC7xBAJCAUxNj8wWpi7iSpXmBi1CFHES1esap?=
 =?us-ascii?Q?Bk6oq7/T0wcIUeT7Uj2lsUPDIk13ixTpRRIB7jz3/6vKZtw/VunYsk4ooZjE?=
 =?us-ascii?Q?3wXefIlBFh6dXYNNDZKObppKaIIWNXl1G85RpJMw2jQjWJ3H8tvzJkCoD+CJ?=
 =?us-ascii?Q?FAbCVr90uH8yLyJmsEgoV+ZV3h2QiHCgbQpxJ+99+UqBMa3FCwk6KsKBlYB1?=
 =?us-ascii?Q?PwxjpntkGtUP4nHFfK+RBeKbRYHA3Bwcjz+eMcs5S3/Vkl5+CdrZvMRI1Na8?=
 =?us-ascii?Q?pb5aRy2tYIVgas3hxtZZDwf5CY9LILROoXEe0RCNfqwV9JdTrOffSQx84bWS?=
 =?us-ascii?Q?4f8L5OWFvlcVjGw8315h56i/g1QNKzQBuPAzIkrryD5jwq0Pae6r2Be+92+D?=
 =?us-ascii?Q?GRtr1bAwGVyhBU2+cP9mtUylhHFKJ2gTvqIP9y0I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c905de-def8-4b0b-566a-08dbd52a91a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 07:18:21.5803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEF196bqZHejOvHsIGDuMzbA48d0uGcGroWyyip2LxZ2HBIdwsvOPV7g40e3+PkkX9dZUyRKMUtBBxcNgQxJjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The analog module produces PLL and OSC for Clock Controller Module. Since
the binding doc has been updated to clock-controller for this module,
Let's also update the device tree node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
V3:
 None
V2:
 Update subject/commit
 Drop node alias

 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..235f1ae583e5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -422,9 +422,10 @@ mediamix: power-domain@44462400 {
 				};
 			};
 
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
+			clock-controller@44480000 {
+				compatible = "fsl,imx93-anatop";
 				reg = <0x44480000 0x2000>;
+				#clock-cells = <1>;
 			};
 
 			tmu: tmu@44482000 {
-- 
2.37.1

