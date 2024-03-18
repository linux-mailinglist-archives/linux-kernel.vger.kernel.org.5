Return-Path: <linux-kernel+bounces-106460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FD87EEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B738C1C2210C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EB25916D;
	Mon, 18 Mar 2024 17:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="MiJmhLYG"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2042.outbound.protection.outlook.com [40.92.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB458222;
	Mon, 18 Mar 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783170; cv=fail; b=G6F78ErDK/hxJ5V1uzWm8AOiGhQBNsahqzigGKhBbhdk2yEvlffivuKvIdx4M1S1S2ni59FhDzLZGXGdZ30mPHsaIYTN4LWg/nxbu7Lw9dcZmd1y52hk7Syp+yIYxcmQZdi2s6uLkiH7GpBexCQjol+VvgVknavaPh/F+6ZDsVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783170; c=relaxed/simple;
	bh=G5yuoFn4CqSSLUoKUQSfijFjkAWJVZyf9iameQLSATM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+htp/OKLegB0gVNZuC4EZUYgmoF/JpgLZq3EbR4RRLGcuQkFxZ6xVu31GRYAQrVYxZ4JZQnIi8YOYfhTHAf2mhMgce4wvsDNdV0JrCQY5hRSu9szdP3V/TgbMMEhYcAjG/tTNuzRv2SdeGy+zL/d/X1nbXvVxrQx9mSr18uoE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=MiJmhLYG; arc=fail smtp.client-ip=40.92.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0XESvwAPB2sWWZwytFd+7RGFMrvBt7BcI2f6aw5UlR5uA//VXYimyrT0k7sUylPNOWj3s70vaSPKXcETbPQIJex4X9wGymhkpZM3H+Oe7s4NvwVAyFWHVAs7b3bhxOgbPrtzH8XRFQ3EX6fPxtPJGSvxizke6b5CPFHlQ+0rdBimb44bmU3NJUHTtuwHtJeHnY26VR+/PeJPDDjpnRrlVsUxYint2zayZIR172HlUl8PV0m4tgWXXJ+eIq6Ewj6tFe9dHUTZcjwF5I/MDw9DpuG55pScIgNOscU5hdAd0dmo9xQgVyb16HEoDgFuN9XxdShZjEozpvZDUNn3YlwVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=h7bM6rhgo539eSH4SgT2l8hq8F5KQcgGukbNypIe8y7KA23xK+1uIKL5hsnJ+8fCB08HB0Ik11luvbU20uj9AR4gyX7Pkw/slxmkjozVEOAvClJvbxALAoyMgbRvaQDsLRg08XhmXYIK+GFV5Vh/nmVHfmsQtnkdHfGJ/8EwYV8WLMj5rhy3Hucycfr5NVayfpk0PjwfeRO/qv4Q6Ih9diGnZa673Ix+ZcvEwZw9SAhGqHLDpBXW2BhoJhpAfOjZTtv1UK+siFre1umNolpvYZ7uvjKvXT7kWRHH/ehB/AayKNSPuVilKFLBrp5cFaYpL30oXxG6C8G8adtTlGp/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jg7b6p+xqD2UoF2S3eJvncZGfTYlOgCJeL446xehAFE=;
 b=MiJmhLYG4XmKw9XrOcObsfcbNruF8CJxIMtNZL99rMU0jYDi/KZV6HedMaHecTYmVZfm7jpE2BCMwZN2CfaZhnAZDbICZXfUGWwqL/f6NFHwZEenmr0p3R1xHXfdT5p1IOZGv2WiTCe/BgNuHp7abVYY3FyEktKhSANUQ/JkwPPJXfui47ikaXzGjO+0VQOFzRBRvqOmJjJiutbO7eeZecFYm615Gfjz3dUcd2GmDDEGqASEtFuXmbF7fFYHQkBnjxgLqu8ytd5IXSHH+A1qcap+sqZKoUyDQsnB0p+hhI1cJUbHoFbPzx6AIYLDrprn3/wp+5anzluGXxvfS4HHow==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ0P220MB0785.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:32:45 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:45 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 5/5] ptp: clockmatrix: move register and firmware related definition to idt8a340_reg.h
Date: Mon, 18 Mar 2024 13:32:13 -0400
Message-ID:
 <LV3P220MB120205604D94BE8942320858A02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318173213.28475-1-lnimi@hotmail.com>
References: <20240318173213.28475-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [tMzmzpmL3hIupQ9yZIbLiCD7YxBNZC0m]
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240318173213.28475-6-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ0P220MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e1f5d4-004d-4dc5-0f87-08dc47716c55
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnr9wYTvfIwcniUcOEk7m2BTqhTnwCwXm8cdX/aiDBq5yTdEXBuT1V3OPXk/iGS7qh07A5GmT9f6juCftcYgvNx4JS29NC3Ynm4/xCaPsH5IAWHgMtQuXomTEPs+pkAKNXGGqVUAHtbEUbz1A2yDbRiZeQISuh4YDHkOzIvBhEeSsnQDzZz90ue9v2ullB9nscg1EmeRgGvkY4vbVvNbDiNuo2hM8nZkM6GoN8YGg/bnbCv8OlFig9jzXnfuS6FUGyhqd6SlcP/B7ln/4s1YYfeYsta1/nP4iXsBLbc/pZWG2hxLIiho+cI/vLiDd3PID+nc7ZZmzBxk19X6dnA1RV8UsBvHY3gyhz/M4rq4tIKQ7R+Y8K0ZXB/iFF9XpmolXXEJUMHloSctxFKAs+xB0zJjr96+ibmCTZ+DZ5I/somxD8MgQ8TeLIp4YOh+nw7LMqn5FkWp4/bHwvGxLPmjhG4YjuxFGlK9FDd2aKNDIxPQrbHgqigh+iGQtoc1eUKTcb/2J+NUm/3vdDfDsc/TY0KtIxZcfil0ly/FXic2iP8b9VB+38x0lN8ZKU8jLw7h+79gVj2yBdmNuAoYLx2JJsYMl5rEIM1j7S2XlYdp5LI48QgdMBjSvdcnk/+BgtC4QVGB5nKlGaCMf1VySrhNNKf+HO7E4D6oKOSKyI90ZD+qAazBx5dhnrWfAUJ1+AG1+3RY6LvwEvYtF/8QLCFZeDhMmdZA0qoFySdGr4FpqT3iQPUASaWjLZ647EE6xfJTxhI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rtva2Oj4u/4yu5r2QqdLQJ3mVjc7f+Y5McGjQYpjGwTCdTcHdAaGLKWEaCxtQTB2YXvH5Je1X/Rv4yRZYIyr4QJ1NHiIEB/jWwkcocudC5RJMvSkh2F5SUai19l6znwUuW8wpOqnoaV5EXoR7HASoKTexge1GHD6vK3TcUFmLnlxyNtARke4UnBolYoQYvDE/iNwAgZGMXroVROZq7mDpdDVoRnxl+n7nq9MiVJoqMP/bPJBroOSIuhTOxZ2zZ+eHmsj9LmHNJp/d85QtAniSTGVIdSNMSe38qhuK1ayKWnewOkIC6YSNS0ETdhNqLe5yq7iLcieFBFN0LtHglS5+Ldkndb5/oPvg4x+Ji80gfmV5I8ZZbTL4cS+ReyADvHr26YJAT87MAYHwAh81QjZrd+jjyV8Uq2m7Wh3uvaZ6UZXdd82iIM5Oa0PIEnIeyFEnaCoe0iHLol9i5wXKkcmrfXcdMit/UdnfZcBFwufwIyE2rLZb+L1SD73TkUi6Dqfk8V+pJ6rSClK0r1t+v6SKP7fX2vFYHg0Tu4N8tzefokeRl2FnaKIc2gz8luiSvGC
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFXzg/uiM4Ltk45a5crToygr0kUD5eZP21JmcYjPsH+F18gNgkpFFKx6Ivqv?=
 =?us-ascii?Q?qwPiJAuVBydQq0HgwlXBqkBsD7vsgL3P/Va47yBBAgE+DT7CRidYgZna0Bxy?=
 =?us-ascii?Q?LlzQlYwr1lnZsuJt8+uxvSsuydqzebZ/WE9vqhDBSPzdWQLmgeoUtCT1paVv?=
 =?us-ascii?Q?Qqpnb66o96qTzSVd+0wt44uPs0Jd7VCwxhoSwp0Lt3AB6r0czoQWjtYDNscr?=
 =?us-ascii?Q?JlXDtJIqEe2xOmGL39SEaWiseArdoeVZ3TE2Pczr9WM0G8RQcgDV96BkslXB?=
 =?us-ascii?Q?hDbyEPbJ9rOU53kEUXS6Bsm8wzSKDKgDciKaPoygCJY/rjo/XiLjoDaJVha5?=
 =?us-ascii?Q?FQfhGYp464JxUTxvT8D6vxM0jiw/BIMay7bBrvJaEBdoi8JpTkcaVzG+cV7s?=
 =?us-ascii?Q?zQP1Kq8kUs/hwG6KjxOT4LDIZc0AIVkhVSudHKWRzLj9N3cavCXDxgV2um1O?=
 =?us-ascii?Q?LySwYTzqTIzSY/rUtBg2m7grMsAAQDnzA9nhg2xRuM6tTF05Q+1NJ01fBhvX?=
 =?us-ascii?Q?lQM0mZUfYbPLtxqWdhjDM8LVp3OzZYLwF+9gK530+ClIDVCz3aEOoJr80shQ?=
 =?us-ascii?Q?G1+yaLleOD2GCHTTCVMsc9wIOJH4JOAsHjoKAJRu815JcZ7To1t7VBNTLsNX?=
 =?us-ascii?Q?ae4K+9rAnShKvSU7eqXj7QkYf8kb4EDJsdsj+yUbeUGokd1eukb5RW9ZTZ6f?=
 =?us-ascii?Q?LSjt3mjQIk7MS81n/miP2y+44eyKFZJmP09+gu/ee1T3kFvH21f2VCOSgdQY?=
 =?us-ascii?Q?i+h5wJtbLTqCzvsi1KQblZq9evMejKKBy69LcIrNtDcbokXiHiyALAXxEefi?=
 =?us-ascii?Q?3OiHE4ZvYnFUssvCgmQcHS4UA5BIyl0qJ/roTCdbI2S8h5J2XvULLYgeeuZq?=
 =?us-ascii?Q?5y7n2zVINn1JF4OLQQW6mMPvBz5zVwFupGyFg1/9ZdF3EcsZymLhjrzc3zTs?=
 =?us-ascii?Q?pAYOLA4e/7sb+kBeuYWM9q/e7+z5Tfl1pgbYDTdcH2YLt/eDpJdL0AEg7N4R?=
 =?us-ascii?Q?/CEPt4k9GgeK705T6LqVO3liGs/usd76IOlkJBr5u0JO9xvmDnSa+lUiItA3?=
 =?us-ascii?Q?wB5TOe3qiqsGi5VR75tX6f4UYfUmRCN8J0iyx9xi2m7te13s/PHQ/s+0kt2n?=
 =?us-ascii?Q?N/6tembeK+sKzXEjkwKsIxFDldP2ch87oO/29WdFNIQTmVNx6mUokfaCsvOB?=
 =?us-ascii?Q?eLqWAvy4Z8vWh60xgozHX+4b3Q0Ef5uENaaDvmtmViA2nCmmALQfxnWUg20?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e1f5d4-004d-4dc5-0f87-08dc47716c55
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:45.6832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0785

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


