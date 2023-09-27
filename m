Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA47B0403
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjI0M1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjI0M06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:58 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2053.outbound.protection.outlook.com [40.107.105.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAF1BF;
        Wed, 27 Sep 2023 05:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOiNbMFXgdAHOoKAMvep1tIYmP7OGFv266mDC6pME/GcJ/KiN0HERv2E9GJYeQaG2GXzSJEpI3N8xPI95lfdPSTNH7x/FMBinCLPVwdpfuEPlnX+ULguqCwW7fFptKMtB1AK5UP0/XtLihomrLLisFRFZ3SDe2+w4kCRqdPwv3TuwXll1yG7Z+J8JZWl9pJj8eliF4daAOUsCbH0lBs/JXY5P25iLO0NatC80CiNze9tj/T9r0hi0qY7GySfas4lf7Af60sScENaqBF9m8Mh6O2rbKy1/3hlrZDLcKT4ioY3iKGlYw40heHLdUl3ynAjxx9e18IQgNJxCJN6ORR6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXuDmsJ4NYqcfo6ZtOu3Lk7rp0SukW1T5R5zV/3/gPg=;
 b=Vn7Z2PCKGfpXRW+Mt+8Vn9otS1DeqZ6stfOl/kZfiC0T4nol/dEhkOdFAthcqohW+LTFRYNfWxdbwPC3LMRUA6j+2pAd563uGXsFIAmvtJ67Ci80yCw9NxJZuDH0/JQGCSBToYrcAn4g770dvbIO8vjOUG1vqeDTSM3eId4vydNWNQC8q1qZFKfTVw+3Vtqe5uJB5JNBCCWHbJ+Ve9pygp7rEc51L8vfx+AafkvKjkNVnoifFNNQovr1WMsg8Lj7bt1uOyDMaSOjZSe2IT6iVxosWB261B4JtubpP54h5m7MU9fafmXpDLUKJsQi1IU2W2mkRj9R/tMvO1mHC89cBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXuDmsJ4NYqcfo6ZtOu3Lk7rp0SukW1T5R5zV/3/gPg=;
 b=WLZFE92vY+sbhAxLFPAmMiNoEZzoICyKsHd6C2tN5l0m+qqzSzOjC1NFavBTshc3Bc0tkW/koeiteNnd3BdjkHfYGz0b+nYbE8KzzX0MyKCfslGaAmIPbDPDhjMzp2oHfRcptPmCTk8U2Utt1s0lJF/2EHZvV0jOUYqOW1zL34U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:26:54 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:54 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v6 05/11] arm64: dts: imx93-11x11-evk: added nxp secure enclave fw
Date:   Wed, 27 Sep 2023 23:23:55 +0530
Message-Id: <20230927175401.1962733-6-pankaj.gupta@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 85bd2cb1-0e06-439e-3c0f-08dbbf550893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cYZz2B8+yIU3Ar+B4YHS08tfJzpc39Zl4cxcXWyBdCbDwh250zdLagSfofJtJB/PRgvfqx6QLj8xs2/pJTuQZmoo7MyVa5L3F3n0pqwj2D4lKigDEW5JGwULa6+NZq0e/Ee8JZwvc4SgfA5LN801PH/8QRR5zcNAcBzb6lf0PTspyerWmb8k6E2fnNMMLcae86WnFyruSf8kaVj6rUpnmTLygkaNxzX2M3AC4lZI958/6uHiMzSqV5Qx/kjDDE8PoCQu9QTRKps4A6h6YXt+Gl0N80filtg1Kf2kljWpyx3AUj9aBkqZXn7UlvIXU8l/aKLR23+1IpBripFeNtX9zei6mK2j1U9EqpqGEG85G0mA8cLwg03EnoZ0kZooRFz19z6Dqk2DvyF2GEho8z16HayxtCX8KVSugjCweKQ3KVX6ZOWnNI5ccrq/bGf48UsPAWAhw+K87xCmsSpf3AgVuAc9g5C9DKfJTtsIrIGD+3pEprXA65fgng5CfCR5BbGl+WsEJVu9wv8sWIUn/ZbxKes9E0JxnSB2JMhi97HLq+SreLyJnjVji5zeIk9qP8r4LOLodxXXA/ggm1apv1vqKnSy+Nra8y3dtB0loI+YR1e0vJeOlYSzV5gWCekKrBZYiwRvcXV74SsctiGweSFO8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(4744005)(7416002)(5660300002)(316002)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0GoqfCv4qFwaPJ12DAxV4hBVMLJDEg1Gey5fTAdVi4PjlNnBjhR1u2fuCAt2?=
 =?us-ascii?Q?CBCiS1NbzM1lSh7glGt1rWnMiAu7hJQ7UAwj0XaF/dktB8jEKbmbLZtKAy15?=
 =?us-ascii?Q?bXqavu2kb5B9oofTvyJiMC7su0QFhC4qSwi2U43VZf9dQnAwqwpuNJ48Aswb?=
 =?us-ascii?Q?zm8pXdYHj5CfeBcr80yjkDOB5bB7CTIElJysYe74HI1cy1Yq8HaR2pSv2ane?=
 =?us-ascii?Q?xuSjiO8pCSO2zpqE7ltDrqQCI+933onIUm236yLlUhB38UFdpnNp75x4/4Y9?=
 =?us-ascii?Q?+EqW9C4j6nPvq5dboaobf5jgd2gQ8Zb7mluaEapQW5zgthz9XJxr2RqKoPjy?=
 =?us-ascii?Q?DRqBo1Dw/QGgri3OY3kHF2AEffH2g8DEYCf0g7yNPHqkGCMGWlucPOxTjrR+?=
 =?us-ascii?Q?tzqeTBAEw0yY5P/qlFRdoyV/W3ocgjTXrgzYmEHXQVObzz0mjHf7HRpJlZAH?=
 =?us-ascii?Q?v3EMHZCUuxDHSqhMhzb3mTxmONWPSOeRxRYP2GDEU/fR82HNzRBVdbe/qzvK?=
 =?us-ascii?Q?D9fEzrCa5pn5qH1H6lYsFKn8nsjhupcEd7PfXpG/uIoLh51L8yoL8zHCYaps?=
 =?us-ascii?Q?E02aTHDTF+XppmYrpjgelPQDQOHqLJl/c6E4BvWvzgJqc/nzGJgycKF8+l/6?=
 =?us-ascii?Q?jYJXpgsOC7wArYUHmfxehxPHp97s1jSVO0WtQgpXpfhjc4EN+TcdHDP845lO?=
 =?us-ascii?Q?okoyfkQI2q262ZxHnD/pH7wXfZoOKDoZEF+TITzjspIAeOL8sjqUZMGJGl2T?=
 =?us-ascii?Q?iHzhbP7kilMDeMu0zzTxX0PTbhrbH/dOSh7VefMKhFYjk/uM6RuSs9Hjqk04?=
 =?us-ascii?Q?s5L0l0OBXUT3uqdIBONno/qhTW5VTeOHD9QsXVWHgcY6biq0kNlFwDggdjSW?=
 =?us-ascii?Q?jp9wCsA0ZuO+l834H+NeqRYyqHXmZqCv0nWj72hR8yrk3MTWIDKGCzbwGM86?=
 =?us-ascii?Q?ApyY1YqNcf6RDY6C1CtYf6Ek87i+L6szXdCqIa55nGIxB1OlaLqBpy5Tr3N7?=
 =?us-ascii?Q?hUA2/tDzuuRwmouL/lRnhNkCRRVXv5AOS/Bd/QFKCtdwuQJZcp/X9B99Ikkl?=
 =?us-ascii?Q?+VRT8jHA54dm1+UOAJZZppvhaL1clhSD+9FtdUetUVLEW3jdubiAMfHuSYyz?=
 =?us-ascii?Q?RNhhWNkzq9KLcF5ZNdevlHen/Foz9fGfYss3GVQqLVoMdqAulU0n3EKODWIC?=
 =?us-ascii?Q?8gNFrLmf6a4a4bAJV6P7jniQ2M/ed7ZuH/r5I3mLMAv6PR/0WMHq3OFdNPhd?=
 =?us-ascii?Q?hWvd8dzIunVHxC9R6MeFM4+F03+PaIggBy0+gZbOWI088JkJvquaFlvOmawP?=
 =?us-ascii?Q?sb+JuyaWAk/6ke/Hgc5eeYBVEKp2QAXwnYSTiDh0Pbh/t2lLLrNgy+b82EOi?=
 =?us-ascii?Q?21LIjfEb6l3KTlAug6YdzPsJlUJglNZrUQ3anv0n3qr2UoRl1+CmJciM2+f7?=
 =?us-ascii?Q?tuMUWUgaPfNy493Iw2fb4wPOQnNhJOMgulxIFYDCgbL9neVDnk9JJrCWj1Lv?=
 =?us-ascii?Q?gYnhWRFGVW7b2xTgUjdVjTNYdwwkMQ7fFLN8EFJry1lK2jHOSWnWOpJZ6xuz?=
 =?us-ascii?Q?sv6Q1bJMc02EbZYks/Pn0X8HM3llb7mS9uIMt95j?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bd2cb1-0e06-439e-3c0f-08dbbf550893
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:54.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BESfDwR45f0VucOB5fPqDvU3J/Dv+yEWyucdO0ZCvQxfS/FyfOZ5Icny/fya1LJ670Oy1fc41tpymn9s6GS5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx93-11x11-evk.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..04c9af059461 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2022 NXP
+ * Copyright 2022-2023 NXP
  */
 
 #include <dt-bindings/clock/imx93-clock.h>
@@ -923,4 +923,12 @@ ddr-pmu@4e300dc0 {
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		};
 	};
+
+	ele_fw2: se-fw2 {
+		compatible = "fsl,imx93-se-fw";
+		mbox-names = "tx", "rx";
+		mboxes = <&s4muap 0 0>,
+			<&s4muap 1 0>;
+		fsl,mu-id = <2>;
+	};
 };
-- 
2.34.1

