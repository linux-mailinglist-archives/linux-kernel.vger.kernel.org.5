Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5626E7B0400
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjI0M05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjI0M0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:51 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C53CC6;
        Wed, 27 Sep 2023 05:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+S0HQQdfkBMAv2kth/w/KNYjEuJTUjSDhzrXZIUlPtEQjT35cpf2pEyc9J28gxCHdoVWWXT3K329v0ivux2cmnCNOvEY9bkEjyps9wtghZtMKlS1Sy8hL1qaUAMCOGLhUkqebCSholrBPZGevlnL1tAk9LlyS82BlXbT3q15gYCJTmmnDrBUhv1NZ8L2GjhgjLQ+Bl9PmylbfZUoyGYWjEO10rCIuMyraeDz5H19cCJVIB5rN9lboMbuBmKYr74nDR0mA/WXMOgAUPULCVTv2dKHiGAo+fnMO5f7AXZFxyBIFIgd4AOpbcBE+lBZ7B/biONbZjKF8xAwwF5mVdP4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IGdDA4++YHirN8WansbBnd/kYOSwl31f4gDzXfa7As=;
 b=Xv0cJ4/euwVwgqcTA1bFdZPo4uz+ixIY3fzTxzMGvXx15EBzjN690DqKeVNcsgFueO9O+wYnnAcMaMQp+DbRtDMEzoeQ3ZhEedf4SBni3/f7fI14d+k74pcVx7qpLTqozKcmeE/hnsl0dAx+1jYVhR0n+JeSkgGIsy05nFn7yk4R+ZigymzYWUJoE9rU1eqbiCDKLvJlJSAkFzPt2Ltqp9XEoam7FNWG9piRG9/xHaLsIrCgEK+Q2WMdAQozK4x7hWv4xQJLWJrrkEKlrpyKxaHSEcDAShGD/WZz7ImkZ/wsB8oOjGKEcSh2E9NOkdeGDTY3ZlsJ+7TYEZlnbUK2EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IGdDA4++YHirN8WansbBnd/kYOSwl31f4gDzXfa7As=;
 b=Y9m0r896KmPiG2ko2X1ZDuUnLRWPQcJ3dPAT1ZIrfYK0I7RLvmIUjn1mfB52YeKopr5LsTsAGeZQ4dK2HMsKR7N9NhiLUVbUnKJxlDcbk3twRSsup9vwdeU3M/OhGEHcTKm+PmryrmRuy+QPr+5J7WE8mLHi//msNCiFv67jTQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:26:43 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:43 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 03/11] arm64: dts: imx8ulp-evk: added nxp secure enclave firmware
Date:   Wed, 27 Sep 2023 23:23:53 +0530
Message-Id: <20230927175401.1962733-4-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: aa266497-e8aa-44dd-65f3-08dbbf5501d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ovC1U13UJNsaBv3OvZbmI6uHk52vEfNudzQVITx6c5pO1r1C+kKLD0rY2ayw3YUzIo2S3iGbIlyNUS5lYM5Pin93jWZ3tbB+bzYqBrI0C6IHxdUw4PgS2aSpWVRIZTd9XI/hm/Wh3D5yRojIPs5LMD+Y2R0KBlEFsf8MfHUGaCRGOTkg//agHop4hwz6+j0Ai4BnP8pqCZssbQU7gVRlF4477SsGSEafP8MWHeH8SJv3qYt+FhgMOoTFYxGyULKT3mSELmxOuWGh62RLs8r7zqEZBN2sP/qfXcdogXSboZQLRQG2mAXT3IebTdtIwVUpMBDhqiz5DBi+sZtS+tLA+/PNKWgw3vaVoMngUAKt8ANZq+xElIEe0ocVbPOBnRq/lVm8kMkjrH0xmAeMrCBGZSE3iPTPmryW6BJiHXkxVVv9gcBhZKwWpFNTlRQF0bJgwsxUVPRXAyyUqtA/SVKz6YIrxwV3xKLVQOhr4G+NY6RNaAYS4YWf1i4fgfB/c5gDpZJSApeE2rpssGt6vdUHyaITZFsS5vjj59jqgguOiaCoxMjMqkZCa4wIWPtmmUoEOX5kgV1SzTQZnAiIUW+0MBlmZG34KGhzlpg3PYAIl1akOjoSK6CdLR5/Ccfok6qkw0TflIZg2EPLGgQtRvyW+bKWvtBio7Udmip34kdTeao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(4744005)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L6Md0ODiqjoQAPUzJ7PAajX5Hsm8Zz+Q0psWftvV6JFAlZ4EoPbgy9OizX7P?=
 =?us-ascii?Q?kTcFJXushyq15HLbmBsz9/BzJ+Ez9VEZeH/FyHWaHyBjdDWvut4BDq4Ztp2j?=
 =?us-ascii?Q?vY+NyNTlkSwc0X8lY95ozf0KQH0KGmezNKDGVJ+/3IwGnr8V/2qJkCn3pKQZ?=
 =?us-ascii?Q?EuT1wizDsHNKSvXr41qsnB1Fet1anSwB4r/2MbfgTrxJh5HWQfnlQ3t5/+tT?=
 =?us-ascii?Q?oyUWLFbN9Mf6znkUOvnCuoEsvdR3fCIqrKH4rjZmk6lDBWniPXbHbW5KJS81?=
 =?us-ascii?Q?qKBrCUTvLjN/8ye6vjXbbaJlVJKAM01Yt1uAjYeSu93wcOZVHGaT/AEn7jpB?=
 =?us-ascii?Q?sHo0tD1ZzvBmy4aR1A0huC6BbkgP3wcswFUcGKoKxjJ6FD0Wc4TBomy0fsI8?=
 =?us-ascii?Q?yFhqcTcqS/BSQV/uWQYs8F4rKjUt0J4blinjssl3PxZL6o8opaAs6ugz5SCC?=
 =?us-ascii?Q?vFB2AqRBl9oBWyNH2KjJAk1SVupaJkmkoONeNjPDsZkbo4auwczLt6cbwa+c?=
 =?us-ascii?Q?ATyS5u47ldDaIcZOP9y8/wfmqy94KLYbRgR4eJw72Hzua7d8INwvC5Km6uRb?=
 =?us-ascii?Q?XvNY+GZlcfCkE06dCjZ7OZdBlyAtSuvydDkiHqqrasEBFxBe5zbrND4Gg/WA?=
 =?us-ascii?Q?Co2WNw6FIM8mAZ/4fT25+3v3NDo/VvKCmBVbp/kko22DKhnB27NTF1H33ImE?=
 =?us-ascii?Q?j06K4wCFa/b/XRk/BlJtVIcC0JlZivlDalKG9IzIcg2nfLBHqA5Raav2RIyU?=
 =?us-ascii?Q?J82PnHYbQ63s0x5nNC1q5hLDyPcY68xudvKD4EJJ1PdA3oVzaS/wAZlyZHq0?=
 =?us-ascii?Q?kAZ6CbJDfke++ttYsuwT47FxkDYjOGE6UhYBfqi/o+NQblFTAGghEdGqlXIG?=
 =?us-ascii?Q?kcT8VX971urkKJFfmEdBVtdf0OMVh7NYfBUwbT/WavMXFA26cNsMGzhh2gop?=
 =?us-ascii?Q?pC7yBXDkSUwsWU1sT8uCoqcyl3Gy1OK3hhNJ/RZKG8gj/rZnFI9rhh0qUnc7?=
 =?us-ascii?Q?plMGDMI27v75dSYi0gOeC204rrDfardXb+5vlOaFMKgHv6u6v2Es5Jr/cjXl?=
 =?us-ascii?Q?1WglwQc/8ySHxm+ri7LM0xnFRSX46VTa+NNbU3tMsCSij5gxoUjLuOQpXq9x?=
 =?us-ascii?Q?PIabwuQoLMRjK1COaoJAlkLuEhBi+fguIPveS7qACXGXeudvcxvH+AmgO6fT?=
 =?us-ascii?Q?T3W8ZTMhQlZFh6CZZMPRzDaz1mo0qP1GUczjoVQ14ji/CMevudC2h0XuFTJQ?=
 =?us-ascii?Q?IyZWhv+o5my8dzSTcMCEQ7PmXyatPglUzPlDC7WxiMvK73uPfojD9q0LsgZu?=
 =?us-ascii?Q?OAUw+BcpC3DYHmNaLLu28aWrSH/scyJE/17GS3KPc2Upcag72s75EWjIq4XV?=
 =?us-ascii?Q?v2s59FLen1klDsoyZevp4DT9cIU6yehUzVicIL4xeoI/Fyr/6xGDRAst+Gxv?=
 =?us-ascii?Q?4pb/kkAGj1gvLen1hxdau1KTtytmKdcB0l/pPbMuYu60f+rhEREDxviDOk96?=
 =?us-ascii?Q?boRt8apsApHnRt7ZC5hAWluMMnk3Uj6qTabTro2KeBN4FSSfXcK+x88oORkL?=
 =?us-ascii?Q?V5J+dPE/henVZLByaGXfRdNkQ33gb5ndam/ts/7M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa266497-e8aa-44dd-65f3-08dbbf5501d5
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:43.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: muCNXIXydpCHfBlkZmJ6iUv76Iazt1fqGyXu3qgpl9TuczvbS3qtz73xjGo2qJHhDPEuyU1tITxLnYpjzCTejg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 946f2b68d16f..0724a2524ac2 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -578,4 +578,14 @@ gpiod: gpio@2e200080 {
 			gpio-ranges = <&iomuxc1 0 0 24>;
 		};
 	};
+
+	ele_fw2: se-fw2 {
+		 compatible = "fsl,imx8ulp-se-fw";
+		 mbox-names = "tx", "rx";
+		 mboxes = <&s4muap 0 0>,
+			<&s4muap 1 0>;
+		 fsl,mu-id = <2>;
+		 fsl,sram = <&sram0>;
+	 };
+
 };
-- 
2.34.1

