Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB17851A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjHWHfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjHWHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:35:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B174CE77;
        Wed, 23 Aug 2023 00:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT+I7cEK7O2JfQFEFhdZQNW+ypUyh0slc0jZrqYIAC8cAgcXflc3Hmkmc7GGvv2+TFDUOFX75haZ+miex4Xj1cogWjXXtaI114ygBoculYOQZCZLBcYBoTc3r0S2YSJfiYuf80qJU52FrjYJkpdQ267OZ0Q32OkBDWLjEjUiqYLwcL1nBJWl97XuZQ8IJ3ePXl8aVslBDfl8z24uu5kRZFNy/w6vO871+LFxF4JjSFamEzXUBVgHfSA0rJJ58eiuEjtUh0pZSxkgfDoGlnOM4vlh3UN4Mt3CsJZUY08ZkZHLZfPjniLF9Y1Ogwd0GgHaRiES6E0McGXjqz4+LoRMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsqqsDmr8J8CBCzLPwCW7VuFi6JgvTe3An2VCPXLgtE=;
 b=gYwDcS32mz6ZyUPF67sCwfAafCu4gt5d2sLhp30gVoxI9MgSfyZ9FC2GCN00e4rFO1t9/XX005oTRXlT+wHxVX5ij9H/A626r+PPVoYyXzfEG5fLPgMXh4Y8r5uyCXmxu2gLvZbTLu12+5Wf2fULGEhVd6REoyyCFvCOffgynZ0fnwYrSgcxIcAkqc+QCyH5mSStmExqqZf3yKUcfdysf/08McEF29CRSjxVxwqoZ/z0bbp3w8nFyb2510JjjZCCam6QHA8sswv2O/Q7ZVqp2UbrhQgRDP5Flw39BYyH3iLAXWQPWPeL3yTc88+sxCnNrtRV+nSzEzs/GfCTwqyg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsqqsDmr8J8CBCzLPwCW7VuFi6JgvTe3An2VCPXLgtE=;
 b=YlXRUEVRCxET/2bPKoXNGpvDSBKP4B09tSBtWn9RoOVbtgGxhzhoxMb667Ki9DM3+4R8TiuUGI1VZuBONT1tq9pHO7M2hk3VJcv5X6R/aozg1GbSVx1lDEMuQ+hyJiIYjm8PpiPse90Gm4FKWp31zKjm8L3U38+EKxt3nkWiTJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 07:34:58 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:34:58 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 02/11] arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
Date:   Wed, 23 Aug 2023 13:03:21 +0530
Message-Id: <20230823073330.1712721-3-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: 16352f89-0290-491d-6d4d-08dba3ab7396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RH7okz/RoNCDttouSxZg/lE7//6Ix7edPMUERdFXFZ6p/KGDrk39T9lmnWyadbIuFWxzNwqeySfkmFpSyjewOywHwSwYFX/Tmgu07v+kA3BcyJr7th95/ZhiQPKYo1SSNtszFE+hT+U+tbWvFpdcHwsoNmwH8+yPwPZ3vxfxSLDO70NMavlYoWDzAevZWftbCSdDDVoTRQsWqvt+Fjp73TL5xb2sg7cO2r2nbxY1VFtug9w8SuhNkvDScPYtfmVbu6jZ6Hv1rtD5DZOnDQGHxti0TyP80Q/+hememrw6JOhW98K//4Vo5zPfKC8CbO4MOQih91SxjimjL3kXaSzKq2LQKN1VOpag3KO0d4jYX7V5Dn57xEAhCywgHGnXHiTHJJa/XP+XUFwF7SvF9vSuz7BgCKZ0MBk3g2z60UsuL3eBbo6hKcEzwXt8oqOIKGVm+atryOR9m8OE4IbxTe9l7onWXN6ioEN66q6ZuCKz7duUnb31QokTfeV/6FwGjSFLYgNYVoG59WauJ3041gInLjIKQyX/m+H1XJILoZrCPA22sqdavqrSkUpkuAkTtBB7UZQXjLCsC6cOr6W8lgq/AxMpXTqUTHUkumpOLBIngYdQQhEiV6QTdSNoHwmm7F8nnVsoJVxexFlnOgY0MCgg5qx3dj3zloxm3RXgCOawXw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(2906002)(7416002)(4744005)(38350700002)(52116002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(6636002)(478600001)(921005)(6666004)(36756003)(1076003)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OZP7+jfx6aah4Ox9zERYHb82LcV3T0oa+QU1CIebm107ndVJrSFq8fuGM3O8?=
 =?us-ascii?Q?n3Dwd1lFhqZtLxjDL0H3aEr4AvMGqyaoTs+5WyHx0wJWy4Rb4VYXAtuiDQAu?=
 =?us-ascii?Q?rVBclZwIS1LJlXfqSau80o6dl3y1VYbhOLIntnMbqyqGzlxPJhKgtiF7JwKN?=
 =?us-ascii?Q?AGmjm4Y3Sr89GtvNwQmNM7+PBHb5NU7Rd9Y9y25pCJehesMPa9qMthj13N8W?=
 =?us-ascii?Q?e5lqMwqiOVXmmkvhNiOT7Gwn6kgSWpLysQdl7xBovftYMnTGaINS5q83+oIZ?=
 =?us-ascii?Q?mOWPpH+muuaErpBJGA6e1u+jp2kIrPClA9ah0goZU7zSVEnBRM1wpWjZIhKP?=
 =?us-ascii?Q?PAHD5cMJmWe2ejesehMTbCsgd1mwmfT3BTimLPYLoKtSpmvr+feGn1NyTYP1?=
 =?us-ascii?Q?fg0l7RsMDh2RHXa/CywwvZX9idvFGFI30uZ99Y+Bhwiotw/1Biz/ZVBOoU9H?=
 =?us-ascii?Q?w/sW2Q5I3K/mOoObtXfmDNShZ5zuu2fMy1UEwtDTd+C2e04SzPkicHsiynIP?=
 =?us-ascii?Q?m3gZiprKQ6g5kIeg0K9gTfEObS8FR5dSjDZuCQ5P44dhtLwSG9cox6Yg+wcV?=
 =?us-ascii?Q?TSgROMbvpMgb0LUKLpkjNQa+D4MNsM1BRGlmBHRnv/n0feRoempJlHmFznFl?=
 =?us-ascii?Q?ITjlSpNsoPGgIFak3HBqWadF4bWaqjNgqFAo83ps8ub6TNXWrfkD9T3MkUW6?=
 =?us-ascii?Q?DCIR9Fl6GyEeZ1HflgFQl7Dc9bRP2JEiRwbKFCz81B2Gpv0v6zpWBTwGq5GW?=
 =?us-ascii?Q?BFPXT/vmgkUMB5fOJFLqnMMXYCDBtZnkmqwmTmPcIiBhLasAA6Ct0mf5oaYO?=
 =?us-ascii?Q?nsZ6HOkaGcYuc2lOoJCQ4gRH+BkEE57EZ/qWWgTnt4h8jfE1DF02BA5mdQN9?=
 =?us-ascii?Q?nDVUDNl5gHF1JRRaxw1KjWjbY6KQZSbGMuQdk0mZMJmaEs8rb9tEHru4dphY?=
 =?us-ascii?Q?xrknYPoJ0mlPCAIQ6Bt+8WGVUolAqXUEQh6Rszq98ZIgRFUqe/iOlRNLE8vN?=
 =?us-ascii?Q?Uku2E4U7EOaSj+LYGMZKSlg2LNudab7/ki+ARRqunEBmX1VmaL/aVqMNn1qA?=
 =?us-ascii?Q?hr4ag3AnCKY6ZRAanyx3krkCFBUPIYQ9tqoLZIb3ExSfxpLSpuz+griW27R+?=
 =?us-ascii?Q?fG09Vqz2xlwzZWJ7tmx4oak9Ep3IQ6TvNwSg4o8Q6q3jq+BagTI61S0EZmjD?=
 =?us-ascii?Q?ugQVXpxfQ6ZHkh0Ve8NCSiqbThdNniP+Qctzknl4zLQ3QKQulwTxUKLxrp7v?=
 =?us-ascii?Q?bpNxQdwK/TVy6BKrSooGxl7VWjxeYo8Xw8k2jQIZn2OTrtvKsqUBD8JK1hXm?=
 =?us-ascii?Q?EIiURy1Es5Hp2AGZWkDVcN1olNomrAbBK1irbzDMHItaHW9NB5JpPgi5Akei?=
 =?us-ascii?Q?BxmIqcYjOleqYJPszlgy82F7XGg2xo07b+jng5iAl9nHiNh8U0hV1BrSjcr3?=
 =?us-ascii?Q?m1ff2jd3F4Eu9VhMSd1Iakv4Z5YN+woSFVuFWz2YyQWGy0ODhUFDYK96a7mP?=
 =?us-ascii?Q?4F1W46g0aEjNvyqd9BimC7o8uHoPoaByOGYFrLeRPg25x96ruevOi/jMjicp?=
 =?us-ascii?Q?wME6EYbmA1f8U+dH9NJWPYvumUZ3D1NIH+UfXdgy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16352f89-0290-491d-6d4d-08dba3ab7396
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:34:58.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmjW3VfNuVivi/4RjHGEk6slNNR/Uax5OGoZn248R9NcteBHHYeN/seUkgIZ979cYJbBTAa27zmFcn16vSkBXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 3ddc0f3125b3..d4f03409be1a 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -114,7 +114,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -507,4 +507,13 @@ gpiod: gpio@2e200080 {
 			gpio-ranges = <&iomuxc1 0 0 24>;
 		};
 	};
+	ele_fw2: se-fw2 {
+		 compatible = "fsl,imx8ulp-se-fw";
+		 mbox-names = "tx", "rx";
+		 mboxes = <&s4muap 0 0>,
+			<&s4muap 1 0>;
+		 fsl,mu-id = <2>;
+		 sram-pool = <&sram0>;
+	 };
+
 };
-- 
2.34.1

