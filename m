Return-Path: <linux-kernel+bounces-103516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC22E87C07A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF55E1C2103C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A0745E4;
	Thu, 14 Mar 2024 15:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GhvG/Vx3"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2103.outbound.protection.outlook.com [40.92.47.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0985B74411;
	Thu, 14 Mar 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430653; cv=fail; b=mSGr4czJE2vbgadjuzFJP/EKDLdKpiVrKO3mRd42YShUwCnNcJ9EvGeb9xtviff5eOyf1zip2voKph2ix4ZNGKev7Z1cMHmEAfN3HkvrQ2QvO/U+tgdRzeTmJFrkiw8vQG3tqOEmJr98UwJnzHxem39b+TdlzQ90+gvaNz+CDw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430653; c=relaxed/simple;
	bh=G5yuoFn4CqSSLUoKUQSfijFjkAWJVZyf9iameQLSATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvNL1Dy+JHpsgKhFjWC+wfnQIGO2IqB+oP23LAY9IPR+dw0Wh9QnsPyTQIb7E2/vt+GfI+cCmhKAfPNWI+Nxd/y+bWpilRrKxptTNy5BXHYfLxygUHg/h17dq60SPyC7cvRXXQHVnz4Gk2TUhvq9f5oZGnIKnbmFg/706g+Rkxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=GhvG/Vx3; arc=fail smtp.client-ip=40.92.47.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8nGjCDfk6ML3/je67MB4JGeI7umZqBstIy37gVJu1ELzduwpYR0gOAANAMTgjD+iukfdB2KQKuBpOB/vFCRf2RsEueFa4FxQkJVvH1BqMSl4PlUeeXXFSS/uc7oWi8sG0p7yd0AIbKHJjBTKte1KlErPV1q590vBqgEmxQM+hJNxhL5JU5pBObAuUkUgw8HbvwIwVwJmLReR8o8uz7fcOIvzfz10QvzFzev/HPlsjq/tCFUbt7h4eUkL3cD82znM41vBXXttOV5k9+UWjMNRWYIJ+oVdyWQdtIQ0CMcXENlO+ssBJcp0app26xDyNI8CTyfjNXcFctpYkdueg9H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=cWL/rPcvzKt+ffO5Ri2GNzf8/MYo9AOVhItdq/76z37Bjp1R0tZ3yw7wY32fIzFasSSLwZcPS/HGuxDUwWGS4lhPTU/hFF0EsbKsqBP/7sY8D6qorLAFd9WyB9TXTbDuvFuwWmtuKHt2FgRy1snTbVa1akajZ5zB0k7EzfSlJhgyW/FSF68LqOlpZZQmhJtMNDZlPQOPB5VcYidasB4idV+mE/eRZGzNQSrT1D+YQAsC4u9q/TS+TdyzQYLZGgGY5SBk8c8B5qX+0ZBPxPwHcwsArVk/VVfNByap9GjE/t/mSTPx0MmjeS+vAnepHmSUbSmeP79i+S78XTbkiRLaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=GhvG/Vx3k0JSTcH+MMJIdqCG0BgEIvoxTsnRxre/u7i8yo5xhYEwLVrBvGc0n80diYqOm7T35oFbOta/5sIauVKlOM/HTJRK21xjzjSbWcc1A0O/n9RKHQYbT2Ne2L5lhw4vDVzZDKV1414wTBS0fYRDNU/FfL7TSdq1jzPprEHs9qgWfb5HuCrOa8dBK2yOJ+uO0ilWVFPRAz9z7h2FsimgBxRBWx06g5dgSc6OAv580+Zct9XwHRDv54gIJHqzIgFN5RfVr56RmoHFho5S9hWuNNL6IuAXZzbUILxDskmfpVJVPDKtEVDV4/2N4Rk7ATeLKuZfxX3gdbp2NjdLcw==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by PH7P220MB1063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 15:37:28 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 15:37:28 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date: Thu, 14 Mar 2024 11:37:07 -0400
Message-ID:
 <LV3P220MB1202FBBFDEAE3650F5728BC9A0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314153707.31551-1-lnimi@hotmail.com>
References: <20240314153707.31551-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [zR7w7SlwlIcwIccWUpxo2hdCd4RY8KDJ]
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240314153707.31551-5-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|PH7P220MB1063:EE_
X-MS-Office365-Filtering-Correlation-Id: 3137dff1-d5e1-4b43-4f09-08dc443ca7b4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5in300KGKBDF+KAtE19nN9dWvcdsN4AVIc64xFhsDbJY/dY6Zn4GDELYsW4DYRf83L76oI5KYmvb9J6iWM7OXxIPHfO9iGewsBoEfxUL0VptGrWuJdoOCTJ+txbqHZveCgyZOZ4kpIWt7XGMT8SIh/rnEQXcz1CIjuMt04PZUaR1+Rw0LCwW7g69U/nwEwpbXyJcAIXqvSz91aDY2YoqBXDj21U2lw3HxOAMFtCHJMkG8rHbLue4xBx015Ec4FVzV/GOU77GkG/QTvRpUDhega+oJtCS/sd+NnamReRneYiaSeJQAaSoa8FnR+iEm67nTC+8tgOSNZxyXIwZO2isRHo9git/CZLHZ+6ShMYCmRNs/mBTnVeWx5lq0Kcn4eLqC5lraILUiOimMJqpSpOxdGU1Zwl1wbCLMpansCqkQWTUAySnvobgSe2nifQ8lprY+KKcTR3u7Pdum0QqRjoifysapsx31Z2G4uSIU5xmbYVMIiJ2H5/rvm8BfuL+ESKcGscEJBrsvdEBP+DbulBuYxRdEKSkXX7zObYFpoiZIyPwiYb2rTLk0SSJmND0H1A
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gXjcBsYnxdXIMzT6GQaJKveW1ksYNNWGcgWTWDaEECuhSTCQ9gh+v+Xa2fkO?=
 =?us-ascii?Q?bFFcU4Uu3hU98jPYc6nqloYqIYQa97KCGjKcHhCMmRNE+wtrLukEuaqPE7R6?=
 =?us-ascii?Q?ZydLuBYodSahyUWGptxWz9/x7VcivAhS3CCeHjV8oo+sblTrkIWiE53x8FxL?=
 =?us-ascii?Q?a/9W7yeNOk78ZV7cXerRqsmnlkxdE1lPKQFll2npwTIwWIJ8WLpGJOUyvdlw?=
 =?us-ascii?Q?jCEkYMygBb9SIe6z4KLVGVx1Ch+iKBtP7dCoxqKqx3/UvtGQPl0QRLLipqsg?=
 =?us-ascii?Q?2E+5cnSGAuh8KiTf/3QO/g6QsPJMsyCSn8kIQRx9ExKqEBXi7l5ik6bPf4nt?=
 =?us-ascii?Q?Ogm13hD3WveIEyb270rdgCXdWg/9yX1xzSFs/hXF58avjIx2uS+uuwB/tP3G?=
 =?us-ascii?Q?XPLzlHcVwz0HhZcN6t6tD+oqwLAvMMiveMekIFzqE2kDI826BIwSHfDym6Za?=
 =?us-ascii?Q?8QHBJULU3QpChryJS+sbbPH0JjQ5vn4sRawyhYe4k7PMjfPIAtO7B+zxD3Z1?=
 =?us-ascii?Q?Ee7BE3bBnb8x4ZfPhOiI2h6Gw6Nm7Vs/uZBl5dB88NL5Hcy0v5PQxskdYbUl?=
 =?us-ascii?Q?kC/MKp1vWadOxuzkb2hsfsn4mvAmB3MlloQkSbKDoO1TuXKoQor5mhnwLNai?=
 =?us-ascii?Q?jZXDm7izKOkOgayYPoa4u8WdzvOnJDIr+35IzvtOc9ENGASImmnXLVdX80aj?=
 =?us-ascii?Q?wjpShtEjwofAdJN65HBVcQjD+t18FdzmbwlvI0wMinAKUehyq3m34NKTVec5?=
 =?us-ascii?Q?DNew9Kt9pn8Q/MgYK/HjNJoSKB48SemNaoBf12hcUBpxif8zBQgVsVFt/fJ/?=
 =?us-ascii?Q?ZP6OVPblkXx8DKmHjQP10oyxBABHf0v2mqWctNCEYDW7MSdVmgC21rdnZ8sB?=
 =?us-ascii?Q?PWABf77Og8BYiMPWnkqVrWFBkLsd78q2yfFlX2a7SI51uANtAZZTqBMkU8TV?=
 =?us-ascii?Q?I8tymE0L3qg21u0JjC5gv+areHTHf67JD+lIW+SR8INSqfTeJCMuTgC7wY3i?=
 =?us-ascii?Q?znUOBLVVX7R6zcsO2cxfKOifCCriVYeGdRic5TcahiWnIWe2ftdvFGGyjHbV?=
 =?us-ascii?Q?uAVnFOwZfG++adH8eicIt4rtmn4HjKwu8Elqw0oTjGfsHXh5YRgxy+2/UkhR?=
 =?us-ascii?Q?7WF5hG+wckP3tPFqd6byM/E4zzUNBwr+dQi4Ldnml0N7WATShlAFBajFeHd/?=
 =?us-ascii?Q?6o3msTWk/RngmeaFqTEMRKm2TXHJqZFZX4kpUpD0s9+nIa0/7xwKexVIzts?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3137dff1-d5e1-4b43-4f09-08dc443ca7b4
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:37:28.5181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1063

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


