Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAA79D1D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjILNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjILNMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:12:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BC10CB;
        Tue, 12 Sep 2023 06:12:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYLU38IBxONq9cJZkUgwI15JrKDz2tGcuaA10I+uD5lR6gv05E6VmKg7zoh3xwaJ0UWVXZJtHKSAy/HCBoPlTOqhySR3Nv4X7253y9cVC9wZIoHT6y61DK4dWfkTohstAjghnMQjGIim726Vp9ZaRn4tUC8sMuP4QiQO9IQ0KWiMxLjwGrwNKujvwvLXoMkkmR01FgGF/rkiTZZDjquE7ZWSZZq0VHoA66XYr2B6BDSiT9vRleXcPEFOKHxqeNKkqeSqToTYqvX0EqziOpO62Z17xb4stU68/ODDgmbaf/nWjGeLqJoK0chAZHKPNpGnMz2XugV32ZklV0qQW0Ayxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLP6lwXrgcn3NSFVWc+b0NSe/KZOZjD3gVKwnUO/ppo=;
 b=awzmsX28DD8G5zs7sK8hjdIOt97WVNyH1/w/rMzyV4JN8bZxlhHNboOMuN7XuMciYRUBCbH5lCzAavap393r20IlYHTT93fwGh8wLCxg4Bwug1n070NxPod8qHyyrvKZUjntXN55aRS/f6DRuybJkLZYsT9ZY2xgcywYwIYgTUF8rlk4NIdX2qCKbAsRf7DJdi1xJen7CUFuANN9BpdgQ5MHYw8eSKg7fwfaWuN9JxDegBvY4Vln7OdXbhUtsTswe9B1HzCBsU/JdxCkuVzbR1c8RurB9AiI+pFt+KiY2gYpRtcNLFd909SqPz1mekbGDH4/RuWz2OYY7uGDEOH8sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLP6lwXrgcn3NSFVWc+b0NSe/KZOZjD3gVKwnUO/ppo=;
 b=HAlHOQOnbmm2zLWjl5jiJP1cB7el+js/sVEG+/jEifMjCI8efng6rarP4RzfjygpQqJG34g7RZ7O1FXa+B7LLyp8qLv/sp/AYxMy4qwv/EwjO8FCYLWOG3P9wTifEEHkOnBdhLkfpZI/AFBF6CNdeM30tNWHqPFnofKk0IH+yaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:12:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:12:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/4] clk: imx: update the pllv4 mult table
Date:   Tue, 12 Sep 2023 21:16:49 +0800
Message-Id: <20230912131649.1491378-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
References: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a491870-a8a7-4998-daf0-08dbb391ebea
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: io9419cxvD6vw4r0IVdpgE9Fl4U+BchCYfjxZv9rK2WPm1vGXKQI5yJKvoZ66wlNfX+JI/B3jsd9X49rqI/murAD7U1hl/CcjWSLq0BN1+KS77nVk9lPeDi/k0hQnk6fVPaPwV4iCZAr3k4gEZWM8Pe6XXoCLd1l2DaMpy8vILmAWHqyg0TIYvlpkhNgosKrhnK4ARscGpgaG3WjNqWnlrFCdwvYU6HsCZsv8h8yz2Mcr0D4roKHILHa3r7B2La2tx5nji08PJBTZV4/ifITwljqpF8M9uiAP9hZtvG0RZP9vSFR/FhpEj355kJnDrhFiBrpx0Eb9OHZnfN1Cl7Lp1ilacNetdCb+nM/pqPnCvwbZxkc/1z3pGgl6Ef1W9IM67sPCrl/FclV6Qfhaa8GWzPPjU33PfrjUZcYUR2dK+9MLQyiLOhP5ZxV7qb0lLkTkRKIZYxZqsJs05qMKB7oCfrG7kNmFON3bywBZuH9146KAh8qJC+9taQkkFf5Gv9b9MKR2J4/2IUa4xdu579CQGC1ormvjaBDaNtkP6inlkFb7zJTYH9F9t6JbYUeGY6xsUPKkj7s9bcECHg67pXb9nLxwHf710ofxZBpwIRIXqeIDKUjLf6fQeD5AwiGZ2BV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(52116002)(2616005)(478600001)(66946007)(316002)(54906003)(66476007)(41300700001)(66556008)(86362001)(2906002)(4744005)(15650500001)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTf7P7SYKP3D8kRRyMJdCrXarZR/lNR7RkeuusUyZPqVlQybz6RduM2NgLnH?=
 =?us-ascii?Q?ALBiR2lCF8M+3KqIVecUfq7Bbn1bDHgj6hnkm2kFHEfdhvv0hc3t5g8hfmrm?=
 =?us-ascii?Q?0hUQ7hPu4ToJIx6B4Fj3RmUVbK8+ahdEL8/pbo29morpdFlr6j7+97CtszO5?=
 =?us-ascii?Q?EnG0PeITdHrebSsfDZG7X/OWgpalbAow2ZdPNnwBYsxsocMKh2dYmp0ktbkt?=
 =?us-ascii?Q?0+bSyER8roiVdmrwdSV6k6Ba/HFrkWTD8UdhKFr9pGwfk3gaQa11CfCI0/eJ?=
 =?us-ascii?Q?yteBQvk3Gu4sTCaOa8yXnPqP3l7a8obHnTy50H2WSq1+vidRwe2PXXpFtpTZ?=
 =?us-ascii?Q?y/7DOlKs6vF8q+m7bZREFRATrZhu2vw8e7kmzoeuE92tcVqEWaS9olCvb1SS?=
 =?us-ascii?Q?imp1lygDTCuhF3blF9u3+HqWy34uVuXjKe7fAany73KO2jj4e4SRR89TxvN/?=
 =?us-ascii?Q?VPa3m2Exz3ER5JAw6JHLNy86fjm76W3HOESGcsMK2kW0wmVDp10aQ2RPQ+2J?=
 =?us-ascii?Q?tbMggqCFFnrjYG89AgokyNZ2wHm+050AVW/I4bfV+xolHeFFQhIiVsGIsiJM?=
 =?us-ascii?Q?NKjxxekkkbk2TJWJ/0GuHfV6ycNNq34Q43ZVyFOmMMepiicoDVqSZHWTAvMo?=
 =?us-ascii?Q?TCGoSEGiYOoGjHdwZsMcuC/kk34WKkZ2Ek4t5qIaFQUazhXnBXyfQLIjfc5A?=
 =?us-ascii?Q?Qdy9vP17yAtG2O5p6yUrnfjY73ucBMP5BASzyUnMqW/zLRXwNh6QbN8HE8cd?=
 =?us-ascii?Q?p/N6VeAh/nECoJsXDRwklovhKOeQp4Dkc6cdGv68pnLmMLqfnZGftzKOELHJ?=
 =?us-ascii?Q?5bJ+wA2a1zB2LUTeZwX4Lr9Ng97m0IjJJvP8Il+x5vJsVR8l6/bZrqmLHdQF?=
 =?us-ascii?Q?Tkl/1bBddxGaR6MuXebLRmVKRhlgAtWgX1QtTYW1tmexFr0iAyE+CzWfjx1R?=
 =?us-ascii?Q?6kfRh8I1xdM7LGu+j12wZdc2OmgnSeak/sACuSkXLfsQx5KXcpCbvoFFQei9?=
 =?us-ascii?Q?NScKxRYKNPQ5YasV9Ja5dRGLiiYuT2gH14b6nYCo84S0zEN8mWJllO4O5ylc?=
 =?us-ascii?Q?SGaX1azsenvUtRJ6eJAwEWYkoo7peytzhmtj6navFwM5msX2L0ZEgCvj0KX3?=
 =?us-ascii?Q?vd0fBPYOtb+fNX9mXQv9/6N29xl6obDs/up3N7AoMc/UAzB9C1AffwP6o4Hl?=
 =?us-ascii?Q?yfjtcPGMwnR/xWW+W4MlFgaNQ/ZkbvEoir50XMPlSdo974Y7k4tvXjIyjOSa?=
 =?us-ascii?Q?+72tOa4DkG6VhJ+ItCGrafgBAsb3t9PPNPKSv7I94DC1vICGmuDva7e+BCRk?=
 =?us-ascii?Q?o2jJH1e98JynqvNi/TkKoc39L7O/R5HonqzfAuovQ9fjTGmNoadRP9ZVoBAO?=
 =?us-ascii?Q?yRwnZVj65alt/yr/nTUnpSGWCsL1th6HwI0hPCpK3N4yU7lA5uZPrJoLFwGr?=
 =?us-ascii?Q?eWuipHZ8lcvAMtKzz/80FFH5qtyZ2+vPY5DhXnWvFbsA3aCevKK5RLZDHQhB?=
 =?us-ascii?Q?kCvDbeshNw1qvM3myWR1yhoiqmOpMTchVB83c/VARwA1pFXUl3fj3PlNB35K?=
 =?us-ascii?Q?Yj5B+26CHKWpOBaiVu4+E0+7f3u7BE5KHYlOEQIT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a491870-a8a7-4998-daf0-08dbb391ebea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:12:31.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHE26uCQE8HSTOVf5svPg8R28IuYm6GAJI+tK71oqacqKEoC8nQn5vB0Yn0qthORo5J7XJV4KE1RhPUz7QeDYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

On i.MX8ULP, the ARM PLL can run at 960MHz, so need to
update the mult table to make sure the ARM PLL can
get a correct PLL frequency as we expected.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-pllv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index 9b136c951762..7ea26e15f245 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -48,7 +48,7 @@ struct clk_pllv4 {
 };
 
 /* Valid PLL MULT Table */
-static const int pllv4_mult_table[] = {33, 27, 22, 20, 17, 16};
+static const int pllv4_mult_table[] = {40, 33, 27, 22, 20, 17, 16};
 
 /* Valid PLL MULT range, (max, min) */
 static const int pllv4_mult_range[] = {54, 27};
-- 
2.37.1

