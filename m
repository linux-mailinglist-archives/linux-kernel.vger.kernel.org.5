Return-Path: <linux-kernel+bounces-165533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E538B8DAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050751C22657
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA12131724;
	Wed,  1 May 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="SSwqbC3Q"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2071.outbound.protection.outlook.com [40.92.45.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C38130E39;
	Wed,  1 May 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579441; cv=fail; b=asBvtaFOEQqXh5mPR1SwsDpuBcDeXdATWhpTmo6Qr/JuwiFS3GjxKkdmmC5K6SYjzpk3mb8PPPUzkgJLKvaxLbsMj0Jg62ENj26Br6E4Q36514wkwYIY3V0q5Ul15iOeKsuH5Zwj/WeKImTYM3IwFLwA1z5q5JyjVr6OsulxccY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579441; c=relaxed/simple;
	bh=G5yuoFn4CqSSLUoKUQSfijFjkAWJVZyf9iameQLSATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=En9SfNR9w0KDBUcccYo/0uVEkBg+1A410wYlxEuY3kEN+TI0T2KyE3DxwXMydKY/ip/VSA20L/erD9fdOfHYM8bkzo4N4Mh1eCh7qBvZRYHX9s+4+8inR/Atvv1Q+JJcIG/AGU0lX4c4z2ZxTLOdUtwg5aAAaxrb1Hw+UTkpiJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=SSwqbC3Q; arc=fail smtp.client-ip=40.92.45.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=milrI0Y12TMTgHxNXdRMFmsgONzBP3l5IJ9KEYZCGCB4diQDSjYa/QXL2vYHzUuyXnEvp84L0sjGw8qoVksUGK8xDxyzJGH0l2PZamqTEep4ALUjyOtUw4WVVWcMvZuIfpslD/xQDiJqIuAgGPMzF4017MtQWLgsAHYrLBClHhq1WzQwkfWbFfrOf+Y1pfpGbLIF7qIwXLRBtmD9v4h44DGDWNpXu91sWpqXzKoXu8pqguDTB3ygLT/Vmf2RKWGjGJucjysZPDRHDeaO0ej48Q0GtYNb4+h7+hgiUSbfpN7wqhigTbFu3EjmYeH23zZsDgjLNILypHS2d37r2TMk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=Ha3gRMi1HOEU2dkP9wWkfIVUGtle+furuuLRPBdxcXRHVK2w2y2hssKtR4iWRMj6GVXqoGnNOn8qpH7lUZs4+E1+epaLeMWBUpa8S7H1GKnjH64ZlycCcpIQBcN+3dg6cPQnjsGE+vIRg5cDmT10Bk160gVKgWSM/06+Ljkx7rC5bsr60lf+E6C9JjQwdDqX36fG8MOZLdJAQLGD8AHWsC46ORzd+g9OW1CBVIi1U7+mA3z65GsVMJHJf3vnmnxgxpgV9qlANIdZAiExzs7aZqbFbtzV/coAep2j95jSHHyYtSUoLbv6XqWCMmY+iiJMJB+56pit74ThpO6jmr4HKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=SSwqbC3Q+N5NQYTUvoJuTOpfJrE7nmjAB8NXueJKUCyeqiT0Da0XxyjNjDzltuPUiLThqGieoLTwcwo2n+qE/HTr157ZBhjfhgjv87I9BdzZyhlDcdG1qOc6RFUR3bq2j8wz4bkoao3O3v6dLgBzeOizWWYRBlhgiiIiMmjWKRrIMg1RYp3d850JPdbo3LCSGy3+bWhBWbitXPr45SyF1U9Qlf/iN74p4Mn5J57a3ioEMPo3adexOPYy4ZLMpttfslByvShJuPsJgbulLjcJ07UbRErxr2/Z7crBMooSTKl29yW/UPBPbCSfxZ4zbnmWtVCNiALasoT5BUio/ClGTg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:03:52 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:03:52 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date: Wed,  1 May 2024 12:03:24 -0400
Message-ID:
 <LV3P220MB1202EAC63D3241F9E04C96C4A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160324.27514-1-lnimi@hotmail.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [W9xVlnqhu+t66VuT0/qQKSqsQIxpGINf]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160324.27514-6-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: 239a4e85-8eb7-43f8-f426-08dc69f84b9c
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	CiifKFpCz9JPlKBR97BT1NIIoPAGhCWH8Dybd59DCSUiMcSW1gOGBhgRz++hrQ8WZWYyc29tLAHFL311+TnP6KvwzVrICFXJJwa/aO9jBgtQsUybRF+CvUwtapERTAm6rXtcBnPzWNVV2ZvJPmDb23wNyUNlZ82yZjPSxvk/qTLyzRLVMGThBsfiLes/O2x1Fk7VVty3Z0oQMkAh3ONYTtSxmYGrHeoHct4ocy0gh0v8EeNJATeFyTThAAnCBnQltvPDTCAn3f2NYfnmejABsgNsj/Lk8D65Wkn80hZq+pZ/hI4UAvmsDBtgXapU/t8/tgeF4RywA2KNFtZeL0AmVHLJHCAI3RZrS/wrPShcv3LHJ1J4bwafWimJhdrWDwcCwfdqmCiN8PKtIWE7KK8MFfrQWXyGYIi6aPBOSNReKjaQj86ODUDwTc12mmPi3E8aewa6IjX54tWH2ryYrKHl4DPP8xFBQav8JBrfr+v7HM73Rjf2/lmyki6jS9Fbo9EpggtJhB2G2ZyR3ZaUs1jixRIarZg5S/jX+Pd+xnA40Lnqqrsbtv5RywdiOnYA7fCn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VURGqxd839f1UpWM8BVIEz8mbrXT8kx8dKIghX0LEKBbFcZEYqpfBPr4rAnS?=
 =?us-ascii?Q?xMq0NZwDGeS7JlLBlp2axEIeE447S5X5Vjs/qCkDGQf2S71C4MPednqKaHxs?=
 =?us-ascii?Q?7MR2hOPwQGiFlVQhJs0JUsXmuFDON6gfLIi+2LrBaEfbVSO3lyJoGbuJiXUw?=
 =?us-ascii?Q?qrSOnJ3a5mlF2aVvpnOO+gcaK8U9nH9w64GLGTnkgIXMAhy4r/f+rxxSxc/D?=
 =?us-ascii?Q?jpL6WIMRx+ehi1IuPFbo7N31gjjaar/NM545reMINi3MRv5+RscF/jxLxpjk?=
 =?us-ascii?Q?J4PjDEgkt4XEr2vKgyJcG/oLwelznIElnxmDB0zVXbqRkUUVjesLE0BiwsGR?=
 =?us-ascii?Q?+xZLwHdng3ljx/vqeTdlDC7jj+r2nIQTpqAmT133/czBvoE/1y0P1AVJ20QZ?=
 =?us-ascii?Q?Z1l+tvnw4AMUnomwMn9567+DwNAt72izUR7SF952Cj41UaNS2NgXAHKtkLyV?=
 =?us-ascii?Q?o0r/9UVlEjGBBtBnb9O+i02qlDzesm76MKnRbp7AIkiR6BaC2QnWuTpv6Ivz?=
 =?us-ascii?Q?Dg92jZmaJntWoI9sy8jcy9U4B8ZrTWV5juEWU1WDAepeQGjJFRU/s17iAekA?=
 =?us-ascii?Q?G2hhgW+lTnlqG91XARQj2X/pfw+PXkFfQnygP8KF7gDTn2w7ilYBpAFyLAr4?=
 =?us-ascii?Q?c/XhI5UfA1k+j3powEnZ8eEnP+FomnKipT8SDEQjzy2LoXyMVtvnDCxGomfO?=
 =?us-ascii?Q?Wqd1uk9I22cvIj4fqHhpd0NPpbOPhnGzmnXxeYXMoEv/8HJX1uuHreuPv56x?=
 =?us-ascii?Q?74e3L1eZtAIROmhvkRlUejSp+XxeZmL5WAsm2iC3ScSoKqZhKlCN06t+TKip?=
 =?us-ascii?Q?O4FMzNXxETwF+ASb97vy20p6w+x1BbLXCgzGqBPbr5o8GR2eHk+3rX0vRlJo?=
 =?us-ascii?Q?vGxo2q94uc0dCjdRmnErUjX2nPLrOUfCxFtKcdraDRTaeL9uRcbhLQ15cOvn?=
 =?us-ascii?Q?9fDamdLX4/Zy9kV2Hcz6qfueGNneWOL67TbpoiYXapuLZ5RwWhSgfVkXr9Jm?=
 =?us-ascii?Q?GegxXTB98NOY0wbMCjuZ+9RTpLkyM5JaCgBTD7FuYbMShQvKGeDEloqVGf49?=
 =?us-ascii?Q?cXzMG3rxyUxDBK4lGK+yQHzOaeg8gAK2uun75+7YlcQxkGr6yQzjllzXWzBR?=
 =?us-ascii?Q?WoFEIRbsWrCnljkYLIHxCtkr4fdswkRzRn27fN6Wk+pxj4j8G16ekv6fxCgO?=
 =?us-ascii?Q?1dfxa+gMs91FW8qBSDhvDxwtXDgyjn5u1FA4WiHfKPqx7qod94RA4c0jLdc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 239a4e85-8eb7-43f8-f426-08dc69f84b9c
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:03:52.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

This change is needed by rsmu driver, which will be submitted separately
from mfd tree.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.h    |  33 ---------
 include/linux/mfd/idt8a340_reg.h | 121 +++++++++++++++++++++++++++++--
 2 files changed, 113 insertions(+), 41 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
index 31d90b1bf025..f041c7999ddc 100644
--- a/drivers/ptp/ptp_clockmatrix.h
+++ b/drivers/ptp/ptp_clockmatrix.h
@@ -21,32 +21,6 @@
 #define MAX_ABS_WRITE_PHASE_NANOSECONDS (107374182L)
 #define MAX_FFO_PPB (244000)
 
-#define TOD_MASK_ADDR		(0xFFA5)
-#define DEFAULT_TOD_MASK	(0x04)
-
-#define SET_U16_LSB(orig, val8) (orig = (0xff00 & (orig)) | (val8))
-#define SET_U16_MSB(orig, val8) (orig = (0x00ff & (orig)) | (val8 << 8))
-
-#define TOD0_PTP_PLL_ADDR		(0xFFA8)
-#define TOD1_PTP_PLL_ADDR		(0xFFA9)
-#define TOD2_PTP_PLL_ADDR		(0xFFAA)
-#define TOD3_PTP_PLL_ADDR		(0xFFAB)
-
-#define TOD0_OUT_ALIGN_MASK_ADDR	(0xFFB0)
-#define TOD1_OUT_ALIGN_MASK_ADDR	(0xFFB2)
-#define TOD2_OUT_ALIGN_MASK_ADDR	(0xFFB4)
-#define TOD3_OUT_ALIGN_MASK_ADDR	(0xFFB6)
-
-#define DEFAULT_OUTPUT_MASK_PLL0	(0x003)
-#define DEFAULT_OUTPUT_MASK_PLL1	(0x00c)
-#define DEFAULT_OUTPUT_MASK_PLL2	(0x030)
-#define DEFAULT_OUTPUT_MASK_PLL3	(0x0c0)
-
-#define DEFAULT_TOD0_PTP_PLL		(0)
-#define DEFAULT_TOD1_PTP_PLL		(1)
-#define DEFAULT_TOD2_PTP_PLL		(2)
-#define DEFAULT_TOD3_PTP_PLL		(3)
-
 #define PHASE_PULL_IN_THRESHOLD_NS_DEPRECATED	(150000)
 #define PHASE_PULL_IN_THRESHOLD_NS		(15000)
 #define TOD_WRITE_OVERHEAD_COUNT_MAX		(2)
@@ -121,11 +95,4 @@ struct idtcm {
 	ktime_t			start_time;
 };
 
-struct idtcm_fwrc {
-	u8 hiaddr;
-	u8 loaddr;
-	u8 value;
-	u8 reserved;
-} __packed;
-
 #endif /* PTP_IDTCLOCKMATRIX_H */
diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index 13b36f4858b3..5aeb0820f876 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -116,16 +116,41 @@
 #define OTP_SCSR_CONFIG_SELECT            0x0022
 
 #define STATUS                            0x2010c03c
-#define DPLL0_STATUS			  0x0018
-#define DPLL1_STATUS			  0x0019
-#define DPLL2_STATUS			  0x001a
-#define DPLL3_STATUS			  0x001b
-#define DPLL4_STATUS			  0x001c
-#define DPLL5_STATUS			  0x001d
-#define DPLL6_STATUS			  0x001e
-#define DPLL7_STATUS			  0x001f
+#define IN0_MON_STATUS                    0x0008
+#define IN1_MON_STATUS                    0x0009
+#define IN2_MON_STATUS                    0x000a
+#define IN3_MON_STATUS                    0x000b
+#define IN4_MON_STATUS                    0x000c
+#define IN5_MON_STATUS                    0x000d
+#define IN6_MON_STATUS                    0x000e
+#define IN7_MON_STATUS                    0x000f
+#define IN8_MON_STATUS                    0x0010
+#define IN9_MON_STATUS                    0x0011
+#define IN10_MON_STATUS                   0x0012
+#define IN11_MON_STATUS                   0x0013
+#define IN12_MON_STATUS                   0x0014
+#define IN13_MON_STATUS                   0x0015
+#define IN14_MON_STATUS                   0x0016
+#define IN15_MON_STATUS                   0x0017
+#define DPLL0_STATUS                      0x0018
+#define DPLL1_STATUS                      0x0019
+#define DPLL2_STATUS                      0x001a
+#define DPLL3_STATUS                      0x001b
+#define DPLL4_STATUS                      0x001c
+#define DPLL5_STATUS                      0x001d
+#define DPLL6_STATUS                      0x001e
+#define DPLL7_STATUS                      0x001f
 #define DPLL_SYS_STATUS                   0x0020
 #define DPLL_SYS_APLL_STATUS              0x0021
+#define DPLL0_REF_STATUS                  0x0022
+#define DPLL1_REF_STATUS                  0x0023
+#define DPLL2_REF_STATUS                  0x0024
+#define DPLL3_REF_STATUS                  0x0025
+#define DPLL4_REF_STATUS                  0x0026
+#define DPLL5_REF_STATUS                  0x0027
+#define DPLL6_REF_STATUS                  0x0028
+#define DPLL7_REF_STATUS                  0x0029
+#define DPLL_SYS_REF_STATUS               0x002a
 #define DPLL0_FILTER_STATUS               0x0044
 #define DPLL1_FILTER_STATUS               0x004c
 #define DPLL2_FILTER_STATUS               0x0054
@@ -192,6 +217,25 @@
 #define DPLL_CTRL_REG_0                   0x0002
 #define DPLL_CTRL_REG_1                   0x0003
 #define DPLL_CTRL_REG_2                   0x0004
+#define DPLL_REF_PRIORITY_0               0x000f
+#define DPLL_REF_PRIORITY_1               0x0010
+#define DPLL_REF_PRIORITY_2               0x0011
+#define DPLL_REF_PRIORITY_3               0x0012
+#define DPLL_REF_PRIORITY_4               0x0013
+#define DPLL_REF_PRIORITY_5               0x0014
+#define DPLL_REF_PRIORITY_6               0x0015
+#define DPLL_REF_PRIORITY_7               0x0016
+#define DPLL_REF_PRIORITY_8               0x0017
+#define DPLL_REF_PRIORITY_9               0x0018
+#define DPLL_REF_PRIORITY_10              0x0019
+#define DPLL_REF_PRIORITY_11              0x001a
+#define DPLL_REF_PRIORITY_12              0x001b
+#define DPLL_REF_PRIORITY_13              0x001c
+#define DPLL_REF_PRIORITY_14              0x001d
+#define DPLL_REF_PRIORITY_15              0x001e
+#define DPLL_REF_PRIORITY_16              0x001f
+#define DPLL_REF_PRIORITY_17              0x0020
+#define DPLL_REF_PRIORITY_18              0x0021
 #define DPLL_MAX_FREQ_OFFSET              0x0025
 #define DPLL_WF_TIMER                     0x002c
 #define DPLL_WP_TIMER                     0x002e
@@ -450,6 +494,10 @@
 #define OUTPUT_TDC_1                      0x2010cd08
 #define OUTPUT_TDC_2                      0x2010cd10
 #define OUTPUT_TDC_3                      0x2010cd18
+
+#define OUTPUT_TDC_CTRL_4                 0x0006
+#define OUTPUT_TDC_CTRL_4_V520            0x0007
+
 #define INPUT_TDC                         0x2010cd20
 
 #define SCRATCH                           0x2010cf50
@@ -668,6 +716,28 @@
 #define DPLL_STATE_MASK                   (0xf)
 #define DPLL_STATE_SHIFT                  (0x0)
 
+/* Bit definitions for the DPLL0_REF_STAT register */
+#define DPLL_REF_STATUS_MASK              (0x1f)
+
+/* Bit definitions for the DPLL register */
+#define DPLL_REF_PRIORITY_ENABLE_SHIFT       (0)
+#define DPLL_REF_PRIORITY_REF_SHIFT          (1)
+#define DPLL_REF_PRIORITY_GROUP_NUMBER_SHIFT (6)
+
+/* Bit definitions for the IN0_MON_STATUS register */
+#define IN_MON_STATUS_LOS_SHIFT       (0)
+#define IN_MON_STATUS_NO_ACT_SHIFT    (1)
+#define IN_MON_STATUS_FFO_LIMIT_SHIFT (2)
+
+#define DEFAULT_PRIORITY_GROUP (0)
+#define MAX_PRIORITY_GROUP     (3)
+
+#define MAX_REF_PRIORITIES (19)
+
+#define MAX_ELECTRICAL_REFERENCES (16)
+
+#define NO_REFERENCE (0x1f)
+
 /*
  * Return register address based on passed in firmware version
  */
@@ -778,4 +848,39 @@ enum scsr_tod_write_type_sel {
 	SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS = 2,
 	SCSR_TOD_WR_TYPE_SEL_MAX = SCSR_TOD_WR_TYPE_SEL_DELTA_MINUS,
 };
+
+/* firmware interface */
+struct idtcm_fwrc {
+	u8 hiaddr;
+	u8 loaddr;
+	u8 value;
+	u8 reserved;
+} __packed;
+
+#define SET_U16_LSB(orig, val8) (orig = (0xff00 & (orig)) | (val8))
+#define SET_U16_MSB(orig, val8) (orig = (0x00ff & (orig)) | (val8 << 8))
+
+#define TOD_MASK_ADDR		(0xFFA5)
+#define DEFAULT_TOD_MASK	(0x04)
+
+#define TOD0_PTP_PLL_ADDR		(0xFFA8)
+#define TOD1_PTP_PLL_ADDR		(0xFFA9)
+#define TOD2_PTP_PLL_ADDR		(0xFFAA)
+#define TOD3_PTP_PLL_ADDR		(0xFFAB)
+
+#define TOD0_OUT_ALIGN_MASK_ADDR	(0xFFB0)
+#define TOD1_OUT_ALIGN_MASK_ADDR	(0xFFB2)
+#define TOD2_OUT_ALIGN_MASK_ADDR	(0xFFB4)
+#define TOD3_OUT_ALIGN_MASK_ADDR	(0xFFB6)
+
+#define DEFAULT_OUTPUT_MASK_PLL0	(0x003)
+#define DEFAULT_OUTPUT_MASK_PLL1	(0x00c)
+#define DEFAULT_OUTPUT_MASK_PLL2	(0x030)
+#define DEFAULT_OUTPUT_MASK_PLL3	(0x0c0)
+
+#define DEFAULT_TOD0_PTP_PLL		(0)
+#define DEFAULT_TOD1_PTP_PLL		(1)
+#define DEFAULT_TOD2_PTP_PLL		(2)
+#define DEFAULT_TOD3_PTP_PLL		(3)
+
 #endif
-- 
2.39.2


