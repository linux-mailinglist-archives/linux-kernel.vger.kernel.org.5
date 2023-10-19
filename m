Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9086B7CEE36
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjJSCsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjJSCsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:48:37 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293A139;
        Wed, 18 Oct 2023 19:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYjcRVkfLX1XNn6F9VSL8o/n5tR+zK7pL9xaRbFt7jjv2vBmdjOI8bIYR9RJYmfkMj7nV018JR5vVlm0AleOo26OICDphwm+L/s0Opd2CiFYUcPjzG2hWlS8Wde1RMC2t35qfAPfTgrJK4c3rjJZr21FMiPcvwHZPPorWZp/3v7Y3yy7hlMM+tgnH6GMhMwLylquhvmloosic2/tMyYcNQXS2YCyuT0Zicii17ch+NHqhp0TuEeOYTHvk4pCTuL2Am8IXRvw2BbwlN4ETU5OVQopKuAK6AwajC49mhppo6TNXaBp7pvYaNKmt94RJ35q6WBQwBBwvnPX7aZ4U/7SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wUPrQZEQ/CAJ6s42tJWjQagL42TzmT4oqa4/CiOmX0=;
 b=Clahc0ktaQJbOOTUS2D2/XdbEeqoWZqw6wCd5lhVx7MAR1Du/tQzXu87DfAGYdBU2SEp9jwzz92ne5Mfs81KMmK/QOXYeaHM/b5KM5iAWkeA3ql6LYXFdA1iPL7LahWbKiPK6tBJHBtAH3EUViwNJfEL2DgAa9bV2bHQSWZ+ZkUiBEEIm+73mQxkLI4+LB+8mLELlQZZbKu8wi5dQNMrJgEh43mvgSSRzdBSLjIEI5lsuB51TPOe9pF7LySJyWbXgDO4vMHUkXTWRj3mFzotzkXD13mYf7JnIkj1QLH5CwnNPT4B3muku5+f147qE86InyVAENdJ/vp2MkLpKdAtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+wUPrQZEQ/CAJ6s42tJWjQagL42TzmT4oqa4/CiOmX0=;
 b=Q01lzVpt2fb9l/6dKUrdO/elRiOO8meOP38B4JIfST9cztBpgvrN9BeR7vzgN7hJwt1M/T06ofAOXuxhFlesC4kl0PMKqUNdweGcH3Tb+N3GEB9W0ErQ+BiQcxJZdAc6w5Zcs9ClYOef4INqdZ/hLPhanTsRH/YwjH80hpA6WTw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 02:48:32 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:48:32 +0000
From:   "Ming Qian (OSS)" <ming.qian@oss.nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/3] arm64: dts: imx8-ss-img: Add vendor prefix in slot property
Date:   Thu, 19 Oct 2023 10:48:01 +0800
Message-Id: <c2ca56b58038415f112e1d8018880323f44b6fac.1697597713.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1697597713.git.ming.qian@nxp.com>
References: <cover.1697597713.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef7da54-cb98-40b6-a4b3-08dbd04de1fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lon1IJMSOVl9cRyZYa4AKfXS5enScsZ4P7+UJxG2M0do7LeiIOiIB0FOtC4GrSzyRcM2HO+a0PtAD+rm7hAN2/mynSAUxzc469fS+6pAUrefucxj/WA4xWzyEabHXP0cI0sFWLsAx8c3xx3n5AmPe3EG1K6qPHL2mfzlzW8bSgP7eFRiQmJVvjJyrGa1LMeQ6CmpvMjPKk4hylKFlYrIH4Qv+h7ZdWiLClUrp3Nr/9Ccq91IuiqTkHUElAXF/AgMMlul6i3QnUcFXsYAj2IsOQoyeww4S/rciXT8n3O+Linmc05C6z7Pp7veIizoShqE0sAGf1yifWeJ1n9j4KOXz0I+4sDZrwlyhYrMX/6nVLZPEtmoAbrHU2ipaA+iSafIgklT5mEYsshXUqjhpl3PYTToctmHz2KLf5JphAfhITnTSFF/CZuwzR46pIJw9P8R2HZaLP9AevwMpT5eJV3XkSwIJt73b8CrlzCk6UvdRdYpIMP4b9yYLvO+IhxyIHjG4dgZBKLYWM3a8VvNXjYvvg6/a4RO6xbfZX3TCFqidIz2ZYwpVwfDIovtH5Jydx5xdxuxiC8yZlhesjao7ZLTWL5ZlHMbEyQxi04ebpJnWOMXEAe15ELqYdjIzT0CngO+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(6512007)(86362001)(36756003)(9686003)(8676002)(66476007)(66946007)(38100700002)(316002)(83380400001)(52116002)(6506007)(6666004)(66556008)(41300700001)(6486002)(478600001)(8936002)(7416002)(5660300002)(4326008)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?shntg41bxcKinErcmEyv8/FFtlY1/cT5eOFpUSk+U60Q58lJEA2KYNIR/tUy?=
 =?us-ascii?Q?IwCCN/rCiALdT049sniOB1Bp+QZuFl6dfvhMYBVQ5YpEnb5j3yCGRS8B4ZRp?=
 =?us-ascii?Q?paJ9fDk4zOAUn4xU0nANWvpzWlPHGiXjNay2tJhEMM0c4xDUXBBaaXxbz3EY?=
 =?us-ascii?Q?yhz6UzN4/47fuWR815hX9SljRPLEaYXJ7Vds4830iI1uXVR9w3pfwl+w6BQK?=
 =?us-ascii?Q?o3AAmxKoKFFmxySDshV5gV3ZUCG2715L8d3BnXlNn/sXEQfQMKMY3cvBonzh?=
 =?us-ascii?Q?SmBEmCDkDPo8fOeIKx4BIiJObTAHCmnFqLAGnKJPiVBGqkbpBGw261bUfVrw?=
 =?us-ascii?Q?ESFdOau3o11ALy2ypWTivhVTV+QvLoItWUI+WsqO4GDwl6yYkdQ8/pTf6tOc?=
 =?us-ascii?Q?1azD5fvAxunCPjr7q421AyXpfQJcoPpu0yiHim4mWUfALuBrjwv5aQah6Jvv?=
 =?us-ascii?Q?9jL/m279ZAO7e7YKD3v6EJ2djGZbNOeCJoOVR0ajQvm1dQqx6s6G3uXuAIxY?=
 =?us-ascii?Q?xO9DqlKP+ZCeVsdd4S9K0ysy3k0rG3f27Fl+GB2QGeJk/6CcOgVcaGRtzQ5f?=
 =?us-ascii?Q?GK7Gc35uvmBFAG8bcKfZWli8apQORxmKaZ+tu3kr01ezAbdT+HekGFwdBEiG?=
 =?us-ascii?Q?KC8mvlXWiwc1Urqwm7G3houAKU7yzYeBJaXgH4uQWYe8+41aAy6fzcPUOVy4?=
 =?us-ascii?Q?UHv41NkWsbCaK3wAPhYz60GPsqPLeqc4LTtOw3Ew1akXHj/XjgkY9vaPc0pt?=
 =?us-ascii?Q?uZ2rC+ZqTG9Q3AkUBMYkL+ouoGVvk0pnJdar2He3d9VB83BDbT9vuvfhS0Fi?=
 =?us-ascii?Q?Lp7/ZCHsJxLitaXRN30iSOWMBugBwsoVgI2yXma4EncMLOhHYDdtB37/X8pA?=
 =?us-ascii?Q?yYP4Uq0W8yDPzKOs5/CZjvd6thjRiQvsTqm2HGcA88nJKb09sn58syjOoW7v?=
 =?us-ascii?Q?6TPZlB0KS0uRAVCvt2cUbDmhRCZPNoBvBhEGU6kPcDrrL4B9MX5mncivf8Pu?=
 =?us-ascii?Q?1CANhPdg9WFqHez2xBB0vpfaIraCYLe0oO64uXbj3504LFDQEEbLquVyupH6?=
 =?us-ascii?Q?zIsl79GazK3ELZPLuvtiVsEO9HycAwn8gaE71jGKp2qI0ktp4x1xmJ1eZmEb?=
 =?us-ascii?Q?gTeYmBV9zhHb5H7wuu2krLYcc+a+fENJeHnfRxQBq1G5++LKfo5oYUXEPiDm?=
 =?us-ascii?Q?gxQJI73OyPXB7KRtuYECuFcFVYe7m/Vvllnho0/dKyDNryYX34PhDD52iPZu?=
 =?us-ascii?Q?649YEkv6guUYhymkuybdMOconFwPWwET3E+Yg5/VYbgzZ4eGhMuiR4Gvlvng?=
 =?us-ascii?Q?rY8OcpFcijb66KJ0hYKz1BHUapjs75sdH5v3fnm8ssrVKbXbJn6pJPiOvTzB?=
 =?us-ascii?Q?V4SofGsutOX94mkG4dcfrYhdyBAOO4wX+TvBGdypja6vi96vzsd15BtyCHxT?=
 =?us-ascii?Q?Q1cCyrE0w7WqCbt2r4MwzgaHm/6dl937oUvUvDyPaLk9X0WiLKFHIHQKAW2s?=
 =?us-ascii?Q?gWjnLwmdEJSVdWj54RjHsCXXSBBwEzjlwyhhcbJPk02VS7rbka1A8Wldl1ou?=
 =?us-ascii?Q?dekZU5dh9ntu2z56SKd+ZiGLn6X667vzU/Dv8DTW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef7da54-cb98-40b6-a4b3-08dbd04de1fa
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:48:32.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PW7Boew1bE/zQLavxpDfzbmNTGxcYkRgFYM2vMyU3Ztm0ClWOAmeD8DnwdO2tqmf9a89kt8gTIvybDd1HQl/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

The slot property isn't generic property, add vendor prefix. Change the
property name to nxp,slot.

This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
working on descriptor based manner. It supports up to 4 slots, each slot
can have its own chained descriptors. Host won't configure the engine
directly, but fill some descriptors to encode or decode one jpeg
picture. Then configure the descriptors to certain slot register. The
jpeg wrapper will schedule between different slots. When some slot is
finished, the slot interrupt will be triggered. The purpose of slot is
that engine can be shared across multiple VMS and os.

Currently, power domains and interrupts are enabled for all 4 slots, but
only one slot is used. There is no benefit in using more that one slot
from within the same OS, as the slots are scheduled in round-robin
manner and not executed in parallel.

Use the property "nxp,slot" to assign a single slot, and just expose the
parts of the h/w for the assigned slot. For example, only put slot 1's
power-domains entry in the DT when slot 1 is assigned. If not specified,
0 is used by default.

Fixes: 5943de495b6d ("arm64: dts: imx8-ss-img: Assign slot for imx jpeg encoder/decoder")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v5
- improve commit message
- update patch based on commit 4d5ab2376ec5

v4
- improve commit message

v3
- add vender prefix, change property slot to nxp,slot

v2
- add a new property in bindings document

 arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
index e7783cc2d830..8ba4b0260a6b 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi
@@ -27,7 +27,7 @@ jpegdec: jpegdec@58400000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
 				<&pd IMX_SC_R_MJPEG_DEC_S0>;
-		slot = <0>;
+		nxp,slot = <0>;
 	};
 
 	jpegenc: jpegenc@58450000 {
@@ -41,7 +41,7 @@ jpegenc: jpegenc@58450000 {
 		assigned-clock-rates = <200000000>, <200000000>;
 		power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
 				<&pd IMX_SC_R_MJPEG_ENC_S0>;
-		slot = <0>;
+		nxp,slot = <0>;
 	};
 
 	img_jpeg_dec_lpcg: clock-controller@585d0000 {
-- 
2.38.1

