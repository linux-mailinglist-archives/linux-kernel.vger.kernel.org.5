Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20F75ECE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjGXH4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjGXHzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:55:55 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2043.outbound.protection.outlook.com [40.107.13.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64751737;
        Mon, 24 Jul 2023 00:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXuUYns2eCt+/66OO3dqedOb7gjoxOozmKzvUse/z/UDyiQY0keBqYQQCutXhadY+lzEKyW3uiSHxDNUusWCQTZfWsuwg97nnL68Nx+AkkWgV8p2vIRO8GDvR8S9IirRfPLw6I1LlC+70/2plSEWtTunoNlJmrG1yj9ZcfAV+ndSkz4cYmhPoei2JimfLtyMYB7eot/mYIj4J2h898tz1DoLqCSrtD02tC3ZbUWyYKLR8ZddeF1HmMrf/4f6/MB4T73yo15UORqFj3yFGU1nISqxNSnh47mUDYSDS3V6f8znNS6HHlRmEpamaqi7YuBR9WFlNHF0mcN3AdRa7iN/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qA/qXiWi5TRwuUnrp1Dps/4yFIie/oDJS8G15Gwk7Y=;
 b=lYCkKEE/CX8J6+1ik+gfzuwgcqSFz0FJHiZmaFnCAPW02yra1xoL/fXcNXdYqxvF8oVFxY8jkD05ukw0M3g2EYq88Lp1dX5Wr8fqbfUHR/dlA+Gr1Q2LJ7fXCjJRDbkPYn/sevLbPZfIReFW1hKoJqgDmbWkhoiq0BLrqS9i4p6FetbrOFtpfIfiqT0UNw9CYrKhPcRvaSKoZmQbzyBYN7ABbPeZX4O3W8+8H+BQN0Oi6ZsvdC4eRTeyvz6wlBTRdA6CJ4wKH2gUwxILujo3JwTGCPgbf/07QpELSZFcg3QedgdKg+LP35HRs9Hk5RxGi36InDpXJ0iHyq0YtbDLcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qA/qXiWi5TRwuUnrp1Dps/4yFIie/oDJS8G15Gwk7Y=;
 b=F8H0A0QMJaww7EiP2Ldaw1fjobdCxpXlTAXEguPsiaahMMoKoe8R4NlavEV84UzN65l0GVv1JFzV+X45qOEK1TjlIhq4BFacsyKeNX8XJCh404fVsrwkOBTbN6d9xYgGHGZk4n1Pw2p7Yz3eiYW9CH9ZsYqxy46QFzyu8gY7Lhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 07/10] arm64: dts: imx8ulp-evk: enable CM33 node
Date:   Mon, 24 Jul 2023 15:58:30 +0800
Message-Id: <20230724075833.2763190-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d2463cad-834f-4c02-85c9-08db8c1b3002
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ed8Q8ggabM8bpNvoeUZ6CM6cnxblpTJXsjqRjsY7EtUDieoClSWYkdc6jjYPUAsgfLJeCz79ToV3WDcwTm9TVfvWuXKefVfgB7VxLGL7VMlCyfLs9o8I4k/LCwPgV83qrhZzgy85Sun7iT2z+ZnpTLxalI4I1OsUS0K3p9kE1ksFobjDOnMZcO2sv7vg2EbHgcXdakrDwIW6R8/lpmwWWPREjMUnc7HcYQ0UjVhHJveimkuwGQcGrddc0jJdwTg+jQR8+LNslrlaRUq7hxcM2zjRW6SkuOhC/ogGcjDMQDNizXJnLA8DfQ82b7ClBgJH3gUdq39HD6e/FcSy/UnM8lxyH6jRSGfJUOlefZtplarvKWodCEKyhZuHTWooNWmNodQFrheH5PJxBWAMKFWL7yboNSmqY79LhZcsh03hY6gSjldYjyyE5Kxu7v3wBx7sYH6UKbFhF9QbBYfs6MpiW38C/Dc5C3TyzUyBSpmECG5WxYsa88MYQybZYUN03Igg9f9KrdO1NDX5cBesU0u9FsEbfuKZ1aPSsZGr65LLIBNwHGqNxiasZDeUAfR+j9zrkdiVKL2akmFjnb0lchnCQuRTfoxC8gttucjRbRyMBvBAnIT12GtbRDfiFIhWfZMBY/+UVX4dq3TjVxobkJujlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(6666004)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?obdNmF4se2sdkWFyCDGFPXSe9MrQv/tyr+OPVEm9z3QNgIP+xCSOMZtbKi61?=
 =?us-ascii?Q?V97ujgAguOEtyQKo6ezeJZQ7dBhLKMAOqVScl4cBYJT1nquMtl4zkAo7xKI+?=
 =?us-ascii?Q?Q1HdgGXkVN1qMzuNm8YB1DyBzY43tzX6CikLNaxk0iyLuhFXMPgQfljEY+CD?=
 =?us-ascii?Q?qsNa5JUKdRlYBGesV4CeSameMePeioZCN4BHx3/YIbu7BkupdgRUIM+VCdyh?=
 =?us-ascii?Q?uPT3AKoRlQWN1avaaib3q4r+pEjT3Le8VV9CZfZ8e/Vk3Q3kDqQB6x2Z1dEr?=
 =?us-ascii?Q?lZNDvW4+HfS9aQ16SXFhmhh0zu+XRaEcMnpgc9dYbIbFNGaFJqyOIkZbCsbG?=
 =?us-ascii?Q?r3v/zaRMw1LknES4Ubn45mQ4ZLh8rTCuraC8wrRHH+lC4GVa1UVAWy5CPbq+?=
 =?us-ascii?Q?GO5HKLxsdzsv5RWqrmQfSgrEDVwOkImYobuOmRJW9meNE+oEM4UUGXH5U/2M?=
 =?us-ascii?Q?u1+7qzzJm6YgJmTfa9nQAGapiBac93lgb1WZ5nZv8FMYSBHm5BkMYLES9tKK?=
 =?us-ascii?Q?hh73PfwLhFt5N/N6wd3v0FEG6NfsPmvzIqXG9yU4R89Svx+BnlQCMe48wFHx?=
 =?us-ascii?Q?HTpZGMvaO0xvCD+/vLoihW+FGcvUqm1xYCkXPHOMq5f9E+pWY2EEFFhCkCWK?=
 =?us-ascii?Q?eQ7hr9sISUL1qBFT7tDdyMLj36F9P9MCGVfP4//uffYWbN627wYqpaCI9jOb?=
 =?us-ascii?Q?9c1+s9qsM016AX5SKyguJ1F6HBIg7PzaakDJ5SLugphlEPJBFrVyHtZvGPio?=
 =?us-ascii?Q?Rh+Jcw75Nv65SWDjvI8JAq6zUYE3uFSXYRHy7peIj2FPrAoitQHdr4H/T2c6?=
 =?us-ascii?Q?GX8+w+mjkeVRNjigWWGkATlBcNIFLKK4gzcMad82miVHKCdGqF0paL81OzKB?=
 =?us-ascii?Q?6Z9VHT2HpXmZ+PLoX+/3ij/AJrx8bPMllPuFCF5+QXFx4lLA6ZejFM8EZBfa?=
 =?us-ascii?Q?AIn7gCDRxhMZ0BNQXAPjyRx5pttd5YVUiwUoUI70gPue9YUqXnUwujZJy3oC?=
 =?us-ascii?Q?pj1DQpA7kbjAXXXQ34S7EZiBkOdxFJqWDpHFoPoq7Z9JkthJw/FR1s+K+n2E?=
 =?us-ascii?Q?6JCwItHiUolyRSfDVcJGdqu7uHU4oQ9aoZbt3K3fRWtJ9xMTLOf5OaG0G9/A?=
 =?us-ascii?Q?thY2b8a4uXyfHrkmd6Irz76LKzimkpeJPHPNPCLk1w3A57NJsfubO4u4yJUX?=
 =?us-ascii?Q?Dbwxy08TvRPjdE7X3r+Z3YeZa6RAOEZToYxn0aGPxBYvSg+ZIbpcc4HJOTA7?=
 =?us-ascii?Q?D5Q64RbVyYB3sE1Zc+9YI/fsAJ9thaXBiy8U9F4cqAT8hS88b4Fm0tMSi4qQ?=
 =?us-ascii?Q?y5V/evPVrjnbm3nsn/LCPzTtv6eXFBhwhyum7NgYPF08intIkwyaNn9pLPfm?=
 =?us-ascii?Q?OKqCzZBuTdfaGaFn1Sq4T/5HBCjOmrijZwCYWocqG49xxPV9OfCg0uCQlMhH?=
 =?us-ascii?Q?FOyz/SorRcCbBzijBdR+HYpdj/krXkFNkyPExB2OOpxnjJzNzUGxl/VBOybn?=
 =?us-ascii?Q?lyr6MN7cikDWPT40lIFTyHesohF8aBAqrFgRKPm8/HlXn95iGPhyb+KBqWwM?=
 =?us-ascii?Q?9b6sSQs28MyIDVnDSKymU8dWMoIO3JPEk7011WGO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2463cad-834f-4c02-85c9-08db8c1b3002
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:20.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxlY1uSLzniec3IJ/cwsSwd2gxBnEo5BUDRZq4pSPltgxxvl9D6egwwabZvkG3MvugMCbkocamZTdeMura0yTg==
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

Enable CM33 node to support rpmsg feature. To use rpmsg, also need
to enable mu node for mailbox doorbell and reserved memory node
for vring, and data buffer. And reserved a piece DRAM memory for case
that m33 images loaded in DRAM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index e171390a1888..d66e31cf83fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -31,6 +31,42 @@ linux,cma {
 			size = <0 0x28000000>;
 			linux,cma-default;
 		};
+
+		m33_reserved: noncacheable-section@a8600000 {
+			reg = <0 0xa8600000 0 0x1000000>;
+			no-map;
+		};
+
+		rsc_table: rsc-table@1fff8000{
+			reg = <0 0x1fff8000 0 0x1000>;
+			no-map;
+		};
+
+		vdev0vring0: vdev0vring0@aff00000 {
+			reg = <0 0xaff00000 0 0x8000>;
+			no-map;
+		};
+
+		vdev0vring1: vdev0vring1@aff08000 {
+			reg = <0 0xaff08000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring0: vdev1vring0@aff10000 {
+			reg = <0 0xaff10000 0 0x8000>;
+			no-map;
+		};
+
+		vdev1vring1: vdev1vring1@aff18000 {
+			reg = <0 0xaff18000 0 0x8000>;
+			no-map;
+		};
+
+		vdevbuffer: vdevbuffer@a8400000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa8400000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	clock_ext_rmii: clock-ext-rmii {
@@ -49,6 +85,16 @@ clock_ext_ts: clock-ext-ts {
 	};
 };
 
+&cm33 {
+	mbox-names = "tx", "rx", "rxdb";
+	mboxes = <&mu 0 1>,
+		 <&mu 1 1>,
+		 <&mu 3 1>;
+	memory-region = <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
+			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
+	status = "okay";
+};
+
 &lpuart5 {
 	/* console */
 	pinctrl-names = "default", "sleep";
@@ -92,6 +138,10 @@ ethphy: ethernet-phy@1 {
 	};
 };
 
+&mu {
+	status = "okay";
+};
+
 &iomuxc1 {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
-- 
2.37.1

