Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5382175ECD8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGXHyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGXHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:54:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2084.outbound.protection.outlook.com [40.107.105.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EC2E53;
        Mon, 24 Jul 2023 00:54:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cvhyfph1Xqv3e2uOAZzoV9XqqMWewE+45xV2CY/5X/APfh3Ld4Wz39yxKoR8FVR7gNBLYFT2UNjxBQ+25i6IbsyHRXepSHavk4yF93840HYmAbV7FD/6HQ2ADkHcp1sWmXY2EZTef8mhuB1OJwgxyLwRFy7STzlT3CH/lJig6PAFN/2n4Cx0gRS8l0nk62VkXDM9NPImjssKQDTt8Dqx74ugFjSTdzuLO9a3+Y0ceOx6YkT1lPrf85tyN5hibCUI+f8YiZy4EA5/NsbjCUXscBkmICB7ibRNyi6sdRhP0R0ZGYvyZmMrGrXTFaTXUUodD83XLrE+NlQnjKU6hiGV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhoWCZiu6abm/BOQylS/16+U+PDfejlGE1Hc32qGa5I=;
 b=b3VrtAxk8cEr+y55rs4TAm9Cu9Fhf7ToLQeLUjC1cnoKEtAeoaoGR+rpZtvvA75aIxnvwFDub8JUz07PFER35cxAhCno/AiA0SGKIMyR8QkVbrtpbGVeyfFynn0XMBofl0lo7lS9nRChMzsQ7Dmt/GK1vzBYKBq8kee8/gBZzb/52fwTFe0EWtm8AYuqhz1+1yyE08GpLLn6Z9zFa7yu2JKl7mB3SQ8NMF3biaWxnfEGfDH8Qv3eLT+vxEoAxTgP5id/JSypHaFl/xoRMcEjtM586+YOEsDiN1pzxlCn0P+ejNzWrkgj5h2ct786n+gh3q1GQmDkkbJAEhS+hIIJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhoWCZiu6abm/BOQylS/16+U+PDfejlGE1Hc32qGa5I=;
 b=KlC3a4KYm0eEpF9cdCkwkC2j2Er9of0T6yy/TPXA6iYp+6Ys2OOHAVoFa1RQz21EypRjrPJg38HVGpwVwCYwftbK0lUcs5bD1z887p53Cvu5tjCK1EAKIPe5bVnnkM4AK1K6iLatO4srEa/q4ZNjyTBhI5MyGFv2EpYIVHL8LPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9794.eurprd04.prod.outlook.com (2603:10a6:10:4e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 03/10] arm64: dts: imx8ulp: add thermal node
Date:   Mon, 24 Jul 2023 15:58:26 +0800
Message-Id: <20230724075833.2763190-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 662e1de1-7702-4d56-37d4-08db8c1b2706
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21sWpjvqjdCWFMc7HQH97tRtA7OOmAp8TDjPpWQeayTlJ/IJcH2UDpVFwuFNhYXTpriTlDB5BgP2o1qXMwdgaokB5ST9gOysabecCoPG43T5WfWYkjcj2wex9waFbngRiuUahPqKpRZ8YtFGskGxk73POux3mToYxrR133OnGR6dH2V8nwU5JTJp3xo0+S+2b0l91KD7eTIe92v5DfYRc7l+zfcCjhHxcm3vkI16J3UgSAIfCpWtTg9t0ShfKDDcNTm3cM+FvUCbFytweqMnjIBoXA7APlkSjp7f4RBUldno7Das1W5xPg0+BGz6il3mRJ9Qlr5CpTx14mtf8gLOOrKZbvLcCQD+M0XtGWPzyJaL++0pU2Avpfdj4Dyp1sN4sVPY91QQOSU4axLrRafoBe3qfnMLOca5ujLQbCTvMZtyXxTdIDfosTPCpCkpmI+KQ7hcprYHdDp1SqiKONbndJJWRUNpPFPzyS5QOq1OAApdOUfKiwCPBgQQPkFnCpJbsCWeXsT3AqW6jMdWmjdJgq5V0KTOKpAoiwziTZa033hvze7b7R74MH/63BsLmlU8groNwkNowaAH8E/eIs4dkFR6dOUSj3xI2DS/b3MjQEz+rmEP4KxWTrBOLABZ6aZo2yN3QQIQcFnq4t/zkofwQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(6512007)(6486002)(52116002)(6666004)(478600001)(54906003)(186003)(2616005)(6506007)(1076003)(26005)(2906002)(41300700001)(66556008)(4326008)(5660300002)(316002)(8676002)(8936002)(66946007)(66476007)(38350700002)(38100700002)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iYn5FwElmnh6dV5e7VPEOrQnl/m8KOm9iUsuc9kRwAzLqkhkw2j1axYxlUKI?=
 =?us-ascii?Q?EB3zOstVSJMB33ukU3abtYgF/Ey620OQc23weT5LUAImW2by/0aiTseSRYNf?=
 =?us-ascii?Q?Ynsg/6H1VW0+pdJ5CW9a9wQWMmcyDPdyOFlZRVH+/7pDvfG8lSuIqe6yADUR?=
 =?us-ascii?Q?1fh+ajhWcMWmOGJKH9YHb1anIyULi/xuzLSj2f+LC608ExaaqJxWGT6//t7Z?=
 =?us-ascii?Q?jUdQ/t4BIGbR3Bpzi6yJcBZVOQc7RhMRG9K8TXO0orDUDYDMHOQM6K1bLAMu?=
 =?us-ascii?Q?UTtuE/zrQc/Z1Cy72yBxAREIZxih73ssMFhz4Mzdu1CE/VtDrGZeRwQK41Ye?=
 =?us-ascii?Q?F+WWyj8gUJB9PI3LOK4o3XSWrGZiO6daKPz6pC5ghJnLqFZd5RYtktF766Sn?=
 =?us-ascii?Q?V8nhT/dVGS2zTA07rFQLWeSq34nEPjBxTSRk8t3yoQGGqCw7UmUtXQWXg8fh?=
 =?us-ascii?Q?onBhgsVAi08nXfdwjjavo8RHTUl2uJgqYGUgetxQdNm8Rt8od7SMSMuLRRrv?=
 =?us-ascii?Q?mgdK+ohk4lpSuLKPOHDUNkAZsuexKazbsonOJXykpO+QaC9H2FojJKyZ7vUI?=
 =?us-ascii?Q?tY8RcdhSuW44a9jw5Hg+D5WXEBHJR0pMqQfYFPB6ClxfRnKzh1at0ULORoja?=
 =?us-ascii?Q?twQnscOUmomiAokGwIYLo4DHvWSln8qMayOFkny0nBS2iuDdRknyJQ2kkRlx?=
 =?us-ascii?Q?j21VMtBov0qvxWAOlCzAvyGsskydOtj16czeuqTe4EQ7+YudZVnoiei5I+Ol?=
 =?us-ascii?Q?f5FbHS8fOwvqwmtQ43uUUb3lVOOSDZlB8RfF2Vh9pwC/vjDjW7OjbRUlszYH?=
 =?us-ascii?Q?n8GU3L8wDAKblWtazzbyNBBKQtvLdN1BulTFGRxhlPFRDaoXhlKHWal9q8dV?=
 =?us-ascii?Q?s9Ml0SeVIzA/jc0Unbj2tCMXGymqpAb1oiDYpg4HTeWKmxN86vbVCt7kNoeN?=
 =?us-ascii?Q?dousfd79gsTGo3aI0lcajPXRxWue7XFAmenoitn+o0ChFauW0sBmaxc72H9L?=
 =?us-ascii?Q?ejLAjOyFi+fyjUG9B0ktCSDL+cy1bjJ52IsIHMe78bgoq1KcshJmBG+4jyqb?=
 =?us-ascii?Q?wvdklU0wX1etrYRKM6Qpy2EFzcoQ2hVlke47Ypdk20rmPWMxvW1Jf2EFpyB9?=
 =?us-ascii?Q?RsWa4G1civAVPV4HL5YewlDEn1coh4wN7Ffr98E6atdMK/F5g3mCnAXzpv5Q?=
 =?us-ascii?Q?H6rEUw7VLbphZzuJM96RC6UcQJtsedg3z7Q3sGYhcCtgHS38xpvmK+9TaXiZ?=
 =?us-ascii?Q?92xv1805WnMrFMNYmndtap2p+B4rZpi+9LHSYCW9bDOFjuosZ7zSB3dT0WWt?=
 =?us-ascii?Q?6ba3wU19ZARivv0wsHVF4zGrkv4Zr7wwUJ9f6e8GYX4rBi1SQvlv7FR1uNxM?=
 =?us-ascii?Q?u2+WhjyPGboYrLQ9Ym8Beu6bXrbynYMUeG5DDU0YOg1EXKC3cHTwk1c5/oDU?=
 =?us-ascii?Q?A36oSvxValYnARXdRBJUIvT6WySeUV82ah5Ohnsh9ypmGETjkgHquL6AaVzW?=
 =?us-ascii?Q?ADq1iOAxqeGw20zlnvc9yMh8VIZFKUe8MfJJxmdMpSCPhHTJRVtBd6jC435j?=
 =?us-ascii?Q?KlVH0cJ0+KwGE4Mz1Zm2PUCcOCetfMOQ6ULpjSEM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662e1de1-7702-4d56-37d4-08db8c1b2706
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:05.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQg8pKb0nbS+itZiyQzxiDp1WiiQ6TxyIBUm0iguNBOUc6fkr5hmh/eUnXAUmXJtTcPV8LitlMSKocLslBRuOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9794
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add thermal node. Cooling map is not added, because frequency runtime
changing not supported for now.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index ba0edb9a009b..8891b4dc3bea 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/imx8ulp-power.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #include "imx8ulp-pinfunc.h"
 
@@ -78,6 +79,28 @@ psci {
 		method = "smc";
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <2000>;
+			thermal-sensors = <&scmi_sensor 0>;
+
+			trips {
+				cpu_alert0: trip0 {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cpu_crit0: trip1 {
+					temperature = <95000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>, /* Physical Secure */
-- 
2.37.1

