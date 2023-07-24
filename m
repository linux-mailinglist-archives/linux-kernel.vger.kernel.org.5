Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205EC75ECE1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGXHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjGXHzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:55:05 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247EE70;
        Mon, 24 Jul 2023 00:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COaCXwydElINnH3++az3R0AN3PqWrhgcj97zXrXUiYV3KW88F0u2FGTdLDOrGkpelLwZR+wk1orEJSHkiJ83ZQ097jDakMA7KYexDcGqk0cltslt2Bm6oAZqIieN44vEwEXRjAR0FagoCom9wiiHuOuvUV8IFC6eAVNA7m9t2XXxKIGJb5KXA+fyaAYkHEaqmHkGtspddwSaZyY92hWHd3BI1lOT1OCmkVV/Uiywz0QQq/TUnlW5DKER+KtDhfRAVmNdYE0Dj6s9KnAKiYek5OIBkPxqAE6mY/hLLoqYFZVVga4hl2RSBxLaMSh04sWFqM7S5fGu0LHNUx+9oLD1wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp9nFpFZBlXnunG+1Bq2v0+un89/xIN/D0IL82NY/9w=;
 b=NvzTbwnWsYroQenGmjddKJTxUIUzsVD9A62tagEIKDC38HQiwZqTV5kEWdC3PotN78pnF+04Sbq2Ek7R9Uc1XH6IRojx8OOeac8pVXa94h+LwEYKNrpou5Cf82oO9kS0MgqOebB0VA6qq1JJO9Kk0LxQmHXOV3gT1ZH8YxZHxbT5cBQMuJQKXtjJ1MPF09rBRtr5Q0Ym45qRSgwoAMaI4uwB+ujUZKNj6Gn/uYaP97vwd7bC98iHoqWe5ftgU78666bb5Yruq+Bz0ApOtnyL+3TkgMi8dQ1p7wWHJkVP3//BxCfybidzs4+6Y9l2kEXWL0zPzo46DMOBgj8JniT1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp9nFpFZBlXnunG+1Bq2v0+un89/xIN/D0IL82NY/9w=;
 b=E35nDVwzOy876OOOm34oTXG6BNkauqE91J8hD/XiHBpYuWEUHLBLf1D+4zh5ycej4b8r15lAuXpnCvanUT3GKtAXAWv2I5/Xt/D6vIz6Gkh/wTJtcI/Xu+avJV3qtF9YCGWEt/7N6aBmvSLZ7LAr7ATHXkfceHJRHYhDS5Tsubs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 06/10] arm64: dts: imx8ulp-evk: add reserved memory for cma
Date:   Mon, 24 Jul 2023 15:58:29 +0800
Message-Id: <20230724075833.2763190-7-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: e412e8bc-071b-44d4-3184-08db8c1b2dcb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 68NiQo1IaLoe6AalPkKXJT8ymd5WRNWJoJG+Jlo31vck44aaYxF6QG9t+XIJdfANPYcjg34JZJ37Itnz632T4RB6MhI1W0ir+OkOiUc7jzaDD+TnbsCm5eGPyMLL/ULY2TdyACkng66QUzQeuY0cal+B7syLUf1Im2R4cFZKgKkKNhV+h3vsAJhwwwhpwX5lXxXXQkWlKVG1/MK/fm2gC0fOmawTWd/EFv1uYJ/Q7g5TX7iUk/3L+5YMrKmKgocUCMmMiqj/jUsJX+M3aS7k55TzbCO5ubxn7vPjYJsSS23SmrNgdzQsDEQxlzjNfoHV0TSjpmiU/ODC0xWxelnYOvtKGaYXHYxfYGl/1fJgKRb+v7tZVQ3a9bBCaQVVb1tw/e8rqfLB4iaPdBEVTpDgoydKiSxY08Zi5eD4tPY+esbxEATwrCLYvAqwAH9NFF9FsGmgzXb0h3oGMeUCbbQ8FVaGPL9abwV1o9u5IQwp/SifSwOapjnm9sc7TsFFy0kBuKb/7fj5oxlX0sDac4Um3FX9lWMzmMUqLlFwFJlQXzGRZwTqhru+jUrzB1ttmciC22PK3094mHJwEcnBeWfeV8rAEvaKDYGy9cCz9+P9kNowoqPoNDTAtyS1InTIKz6c9GKl0TnAlHRCPYWjlXqIUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(4744005)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(6666004)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H7YvNaDo3ggV5aPk4yDUT4F2jkS+5/vliLwZ6iMU47L8MmfGZ5hKiVlr4gcN?=
 =?us-ascii?Q?nMu9b0JUXOK5lfaOKOc1NhW/f6kT/NwoYBqoaTUVHKdavOMge2KA5iI+HBr+?=
 =?us-ascii?Q?D87M8sAp8KPASqLjGzG/53jExxVrEvdAJjgg/0v4ewZ1XmZPQJYCTUPSqANe?=
 =?us-ascii?Q?29fN4OF8b3KmHAtW5fPczaMr+SUBAenD+y614oibcX6xjNJuAeLbeEOJpt+N?=
 =?us-ascii?Q?2WdBct5EX6DpzDgotLJSkSmXQWWU5O+g3tphC3EHivctdVR3kmY3pjL3FfXc?=
 =?us-ascii?Q?2vgfy17jWdaX2LHPRUrMo3BWzfl8Mfo0rVZNOz2TQDugEnM/V9A0KDUYFXu5?=
 =?us-ascii?Q?zDvNUuJ9TSZJa8Y8zebWIFM927It9yNHXn0Yx/G4dZsWqyVpq6D/ZvwI7QKx?=
 =?us-ascii?Q?pXp2QDltl9hOhcSi1fanv9iNScqniz2d0C2KhTA5n9LlN4m9kzz5ZwdDoln6?=
 =?us-ascii?Q?Oi+H5cHJH27lEbZ9s8Z3szzDQ6wRkW4NfSbj/qWYWIPiyn9+VBuiGfTJJ6un?=
 =?us-ascii?Q?AwZJtPfQMFWBHJSXhg68OnzCfmQ5o15Lz8K/SfK0n9AdJrjmDX2s56Ylk7aQ?=
 =?us-ascii?Q?KcoNt+OkJew1lSuc5wCIgB7GwBxxSCac+IEHFxG4CDaneo/5p5jgXsoZFGdt?=
 =?us-ascii?Q?zvOi2zU5YNuG9PCgbQfNf6grDYlSihAqTyq+wqjiEOlwQDAeoqvXGeeEIWva?=
 =?us-ascii?Q?trgXUdXm92yfSv0l3JV0Suky4/NR4sFQgVtksioJasgothbVo1Is365FSGOx?=
 =?us-ascii?Q?f23aL1OT4q+ijWP3XEqhI1fyDkn8lwXV+DPcg4r6MywTI/mqDl7XdjrGKklx?=
 =?us-ascii?Q?K7GNNnpXc7HrpGwXR234P84RK7Vo66GdH7g04jcG7nDloiz6rMzQLv4F9yRa?=
 =?us-ascii?Q?gQ8OB/lAZICBG0JD1xjGyHao9i6/3LN9/28DpaGIsCFnRLlWVu+jnuQ1glNk?=
 =?us-ascii?Q?CUvKJext3dqQZhWu0NSEnKW+zZ7u2TEm2VJeKqA0OI56Dhi2m0pXvMQNcYOb?=
 =?us-ascii?Q?ycuUMspksBdKK2ja3bnvVqAmjzOUGGHMT58haqHuYyAsxQ3GBy84CdrUZayg?=
 =?us-ascii?Q?3gWtPyrjCxr2PApDYDrdILKSsu+s4Sw8lYKTwKoF9xyu1aqH4PquOe8fIyo2?=
 =?us-ascii?Q?LlMlrKrutLgv/iEQnnqKJdmd1P1T9resZ93XEegpzBB9XSC8wvP+x24SLnqZ?=
 =?us-ascii?Q?FriHCrk/J1c5AZ9yiWQn8yU3TCWjM3Fasgzeo6Gt2/UW0smyvZWFYdrNOhQr?=
 =?us-ascii?Q?kr+1Exn55B/0Ew75cq7tjPTqw9EYQFWjJbXrp5wHj200TtTOL2aGTQW80fmC?=
 =?us-ascii?Q?OeAPnDPKdB2G1w5BB1dolR+GvokcwbpUpMsql8mT6v3b186U9iGGPH/iqZyy?=
 =?us-ascii?Q?n0EL/uvGaiaQqtq0T3Dcn0OHGSCF3wdFU8SWkzDWtcY5VAIQIXAc+KU+j7KS?=
 =?us-ascii?Q?5qvkZ/A23+p+rA7uqm0F5uAGdcS3ernX7M4jWuFmHzf7N6ZOA6PWEG4kjlNB?=
 =?us-ascii?Q?/Ih4Df0Mrc/krthMhLWHNnWgj1WJzCZuNch+Qm4GbZPwqRT4Wq8d4hITJx74?=
 =?us-ascii?Q?QtQzYlptHycR6RyU0M43xipkP4IpEL478pIWgReI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e412e8bc-071b-44d4-3184-08db8c1b2dcb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:16.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+UyU0vQMlwdFMzmGo+ZUu4oG8MLvvQTxaV1Xartv7IapURzXbK2Nc24vO36/ZiAj4xg7i4bvl/UBU0J12RanA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add reserved memory node for CMA usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f1c6d933a17c..e171390a1888 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -20,6 +20,19 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0 0x28000000>;
+			linux,cma-default;
+		};
+	};
+
 	clock_ext_rmii: clock-ext-rmii {
 		compatible = "fixed-clock";
 		clock-frequency = <50000000>;
-- 
2.37.1

