Return-Path: <linux-kernel+bounces-23681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5382AFFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A6328CE93
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF7432C91;
	Thu, 11 Jan 2024 13:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="pzXltbBH"
Received: from outbound-ip24b.ess.barracuda.com (outbound-ip24b.ess.barracuda.com [209.222.82.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F34918023;
	Thu, 11 Jan 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168]) by mx-outbound45-241.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Jan 2024 13:53:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jWFkrmdT8nJ0MCy6F7amtNcTy3k/bBRncGyqX0L0+ByRGB+O+Hbv4+XFnFA0DAuZ8lmqBV5B9i6xYaL7+T227EkIGCCFg+4q5Atu02Mkoh1GUpruZHXAWfaF4wgkszDuicmYfNIdLeICUU9SoxjfBuAqYotnUNGzAU2wrImnrzCMXcvZ3ca5dRPLfOLGT7AUkZn7XTJLqFzO+OG0VKUB6raoiFpWSwkh5xFp5zH+NC9o8BFBwwd7/HNhevl+2kGeQQmaNVR2xRNZYPmXezhjtmQX4kgXd4crf55wOJAANO1BgIc2d77OddYQXrYxjE37kxMqP4haI13pb1RTzTdHpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=g+Gyh+C9MjgBTL8Yw96CcjN71aB636SCsHjfLRLQHdFYZsXpLJyDRMwfg/qFzVTeDRGvPq4hF+ZBf3NpkHnUuF8Zina6HzlPR34zP23qlzy+AWrw2OcVwI9Lqsr3lg4m2JcwUAWQGlFncTdVZPyLvyrF3q+T7BOdbFRTR4fXURfATAg8anDwUEH30yIZXDyfMUosVs/TxaWCQqaCGCu1lUz/pwmkxPME8oO7dTCdaLvd52MBWLlJPQUhbi0COARTCI/STWgWDBJDpKvHIpuWPEBNTzjAtRjH49hFdqkTVg5P9QQ8GAb10pfWI9/Uf4+gfrVASYHbaJqqxSNbrnbLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U66kNV+nxEwPq6JzmRc7XVuiSHyrKSzuiysTkD3mYJ4=;
 b=pzXltbBH6jRi5W5GLjp3SHLGa1VdamrjCfPeQJg2J7eKOX7+uJoVY4R/bSmo7L6OxeNJDPhc1SidTuQ3yTWE7eG0ongNz/pQWEbT3XXSmROdLDdnRMz9MCDpayOsqqpmcbo9dhcBUBjkMfoF6v/vfeUtfqNIzr76OSMjV5mHBWtVFsBAdLU1a+xxkB1SElANx0AMKUMsmK65Ff1SVn+IguHCO10mCGLvFD9J2PmV4lOWAOaDgKQFMCHna+amvKB6ihdCKXopwlla8M8uJ29MxNyKbiccCarqkSPQOG1ubX72xULBh4NGgOtCche0fmWP4qS6Q1IE6BYNjtXMn/CUeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by DM4PR10MB7389.namprd10.prod.outlook.com (2603:10b6:8:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 13:19:43 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 13:19:43 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: bartosz.golaszewski@linaro.org,
	linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	hector.palacios@digi.com
Subject: [PATCH 2/2] arm64: dts: imx93: specify available 'ngpios' per GPIO port
Date: Thu, 11 Jan 2024 14:19:04 +0100
Message-Id: <20240111131904.1491496-3-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131904.1491496-1-hector.palacios@digi.com>
References: <20240111131904.1491496-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|DM4PR10MB7389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9e7674-21e5-4bd7-4645-08dc12a7f91c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ob3k4sVOKAg1yBQkXWZjOG4tGEc9wP+lXH8l8/usEj9V38N7swixcpG8uWgO8/h0iChSc5W88u2t6nshzARgUpZZxhZIogo4xDGLyZQYT9m1BAKAkT+5LkXEfv4H8KqL4Wa8yRSgojEae8qOHGGQ3SY1JCAI4yTz1kL8KOGndKo50o1BaX7j8dgqnYh3x6wQ51HLRAaNdxFMVkfseLj7XWXOmBE/XeY/G27+mE+OJT1uOtq5M3VFWn4WYG728q71TXInMqeIWEud8p9ELDrCH26FbJfVUPaRp4zEq5SXJOedCkd3PFklAPYR6MQYlAEqZxcKiHqV0HCx8EXsXeogd3V7xdRH8Jt80HNeUM4b6K5+zkFPowLLd1qW0GkzC55jW64fHQQPhlBlTpJbLFaYlfBkKbydxKlyrZiPQvflkACPC5jVh7LcV1cEMknEGT6TQg3+1sVbVIYYj1mH1dQzpc2vvVL1fzsetzboC7hCe4P3VfXI/wq8Q0yU58X5uGsdaRt+DKW1g8z2jFnO4uyVW061MsL3kr5vvyrmPMGWeVrCWYSdtkwqLnAz39x7REAYlbVCyUJjP0bRVGObPrSXb9yFxsvqwGWBVCPeDEcH1D459IP2V/z6lNMgKKK6+rrl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(346002)(366004)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(66476007)(66556008)(66946007)(44832011)(8676002)(2906002)(5660300002)(6666004)(316002)(4326008)(8936002)(41300700001)(38100700002)(478600001)(6486002)(6506007)(1076003)(26005)(107886003)(6512007)(52116002)(83380400001)(36756003)(38350700005)(86362001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywlCpp+jdIJYwI2gxgfg/LS3wlaJKdd6fmhK6qLvFI0501e4BRM0ZgJOxKVo?=
 =?us-ascii?Q?85ZNEC9DvVFnwNf6ID4fdLclw7mm3A7ARx80/Os/EXsa1a5Zo5DuKGl5pfFS?=
 =?us-ascii?Q?TRBH39vueU1M2eAdqtKlUfh0tpxniqx39/Hk6oaeBlWjeuBO18Bz5bzknJ9z?=
 =?us-ascii?Q?6cnq/raY6Al10tcvrhWo5GeIfh3mxKf1IBZURzVgNiDWO5TfChMZP6qJNd07?=
 =?us-ascii?Q?J7M1ZYwbGa5mj70/Oh/W+Ye1SVKULVdGshPNOFcEBC8+ufeDmULHZB9LFe8A?=
 =?us-ascii?Q?eWrExAdp2jDC+B7VY4efxNpTEO2A7vWIPZf61VU6jYWb31SdC17tIk/qjEgS?=
 =?us-ascii?Q?emcsRKv9fF4+A0WO6DMoArJIAuW6twzkEjOpspNWse56dNDWP1fjGHMxYpVR?=
 =?us-ascii?Q?Hs8IDigfgyv6KhGzYx/q5m2R4DJkGcIOHz+P6idcbfF7iC2oQVvpkLk72AM5?=
 =?us-ascii?Q?L7Y9sIA4sEAd+HvE56sT34WkuUCGzh1Houqz+wALJDF2CAHRmA5TVHM8LBAk?=
 =?us-ascii?Q?Zu/FbA90l3158A0/66q+v6jWBqCFQ3s3C/f8x1XViUvz1mwQUuLzy6X9BWmX?=
 =?us-ascii?Q?oe+/y3MS5Nlieavw5Vqi/08FsebCeYOuvAFV0U+i9w8uE4SB/TBaqe16D51u?=
 =?us-ascii?Q?rw46Ul5WtMxVpGGTtWAPXzHOSrZQFuHjG8wHPM5pqgCxcxrO1sz8rPQ1mEOH?=
 =?us-ascii?Q?0IJ/CCknFe41gRI144LtTy3LIRF9d8l6Mw5tDYQ16Ee317CylvVUv2CPtU6u?=
 =?us-ascii?Q?tINsKJwIrB1gDeMo+sv/Y8HRn+zUUI++h/eNp/nc9ty+G4f4Kama/UcQCg44?=
 =?us-ascii?Q?nY8k873DJq9rD/T4iTc40/JQmNx9Q6cNot14WK7gPX8cygpNKimC4STzkFiu?=
 =?us-ascii?Q?lqqDkwSjSgIjnM4i8RoHVuDpceGDl2nkqoLISf+32+9tBX4vogY5jllUDkpG?=
 =?us-ascii?Q?ExqN29u5nopkOndZWOH8GA3E46sH58cHtW/ANQzXSqDzuf2NLmzskX+rWGdw?=
 =?us-ascii?Q?Xn8lt0EiZoek9BtfB2dl5FVmE73InpbBxBV20Qs35MIZ4xTai70KlDUaN7+O?=
 =?us-ascii?Q?K4RYklR9zxYiTfIRGdAA0CuwmTZ9fQJAC1kZ+EJND4po0sIFvAyXf3/x98hh?=
 =?us-ascii?Q?HXAOWasKa2jizQrSA/ihXTjTThMIykrRNc//84pfMcVT02c+lc86kbovzmDL?=
 =?us-ascii?Q?fYpN7qKiLK+BtpvL4pkPSJGhaFT2ZSOQkdFKfPB0mjnuH941bT21Wmj07RPE?=
 =?us-ascii?Q?1cuv+Cq7u6WIktqXn0qFnbLjRDcD21oeC0yHIiULEMzz/wykH5joDYrC9rK7?=
 =?us-ascii?Q?aAE47j0pIcik2uEwb9vQWs/ffaFdfCx8hQqKnTPM4+5Ea4RJ8smXfHCdBkCB?=
 =?us-ascii?Q?pMH28rNaR4PwsDqYspn9k/jdoxDxI5JM/+CjRq7V1xMOsDaahOMqblzDgwln?=
 =?us-ascii?Q?VwCsD+pZj1jOx/c9RjcWvns6xVOUjRVv2QdIT4zwcf6nk/mCVnIgaRAnCUua?=
 =?us-ascii?Q?Ftvuty1+YDJyJfeYPK+SB7HzQYDuDjo4/GtPpB3mk8c43bYCoWEP58leMw6r?=
 =?us-ascii?Q?sZ6le8t5oG1c6jLTns8CKLZsHfS1R0vXvi6EkNE+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9e7674-21e5-4bd7-4645-08dc12a7f91c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:19:42.9718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZuEPpq88CzRl36yGhdkpytxPmqp1i7xNJnnAZrAXv4l/jVtO4Adt+xp8z4CC5jsptwduqTg3nYneZUBOPr/Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7389
X-OriginatorOrg: digi.com
X-BESS-ID: 1704981237-111761-12501-8105-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.56.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmhsZAVgZQ0NQixdLI1DDR0M
	DS3NTQ0tQkNdk0EQQNE1MNTZItlGpjAVpic8VBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253449 [from 
	cloudscan20-174.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

According to NXP HRM for i.MX93, the following GPIO pins are available:
- GPIO1: 16 pins (0..15)
- GPIO2: 30 pins (0..29)
- GPIO3: 32 pins (0..31)
- GPIO4: 30 pins (0..29)

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 34c0540276d1..7eb2cab7c749 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -970,6 +970,7 @@ gpio2: gpio@43810000 {
 				 <&clk IMX93_CLK_GPIO2_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 4 30>;
+			ngpios = <30>;
 		};
 
 		gpio3: gpio@43820000 {
@@ -986,6 +987,7 @@ gpio3: gpio@43820000 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 84 8>, <&iomuxc 8 66 18>,
 				      <&iomuxc 26 34 2>, <&iomuxc 28 0 4>;
+			ngpios = <32>;
 		};
 
 		gpio4: gpio@43830000 {
@@ -1001,6 +1003,7 @@ gpio4: gpio@43830000 {
 				 <&clk IMX93_CLK_GPIO4_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 38 28>, <&iomuxc 28 36 2>;
+			ngpios = <30>;
 		};
 
 		gpio1: gpio@47400000 {
@@ -1016,6 +1019,7 @@ gpio1: gpio@47400000 {
 				 <&clk IMX93_CLK_GPIO1_GATE>;
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 92 16>;
+			ngpios = <16>;
 		};
 
 		ocotp: efuse@47510000 {

