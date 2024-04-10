Return-Path: <linux-kernel+bounces-138967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE9B89FCC2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CAA1C227A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7F17A93D;
	Wed, 10 Apr 2024 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="vM/wKYIg"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2105.outbound.protection.outlook.com [40.92.20.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8CA16F0EE;
	Wed, 10 Apr 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766239; cv=fail; b=Ca/MzeDWjeEyZAUhyy8lJAa3x1SbpeO+l8cH49o2ncxAPch5djnvRywdW3HaHOwD5alcuAt+QAYeAglTaBJPifWWZrVAUOkSkjZ8rbWZcrCRZWMcMJjUMgW4thLYsSbKQIlCAlw6PZu4XPUhrHljB5vqvtWe1/WriFBVv6Ceg/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766239; c=relaxed/simple;
	bh=CwdD5TnRukEHsTHZh9591rqPL5SeBfYXkZRGUhIixNU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZQVNqppckHiA9NA0bJU23p/f6xniMCfEBAAN2Lovs+elPBwAV6w/tHcXM04LHt7Io3NI1hh2N7RiOcDayv4rYc3EoEUbL8sy5Z0hlirP55yEwsaVSAGptjCc4He2+QEicWnWqStohIww848UNX7D2TtTZXRf7sjfeiZU6HVKUSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=vM/wKYIg; arc=fail smtp.client-ip=40.92.20.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6GDnJcIGchSNwCHbO+uEN2zwbt/ProzTpvMWG2a8C8RRRghhmN25IJc3Gyy1gXdMtR4IH7tZNEIyatm3bGtiA+zUa58eHUWAi79wZu3HtO51LehJ5RQrZ5VD5JOHER/oBjeNnBiSBo1pZxLescgKIfTgChpxGFtifqT8Dd48X26pmJo74DvxXNLnZPhuoL/2g1VtZ1OsB62r8BJgle3stVh7Nx9YTy5KSiQI4khhe2r7OfAhEKHe4d/3u3FR0YR4uZv46wo5twFVGqFQrd3GQ4kaGz1VJEcgGzgbojvo6erBd0yza4Z6Ps8ponyTRwUdrCQMttzvVXRbKueXQxVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmpRt412lq24ynXv8uaK41Cj3hG91nJB0S7j0V1z/0Y=;
 b=BP4UN94U8YqZyhOeNjX/Pg8jZVvtGujAbrKwlxoGVTczcmhoN+ZRU7ShoAnWxVBcDkrZO4+ReWJ99qlFJ+7YrUqSOWNjhxH00sHUjGbqIoS5ltp5OqnUAjyPRaP5nrXg0UvmGcQFDrwRSr5RUOsXIQpEsbBm8fqTfaRw+6asY+FNbyCvRhNm3FCNbXpTNn9+AvNaAzpOBIX5+KXjw9ayEVkrzOV5jjfA21w5QIjmePCK+p+mnUEIxhnP8JLMBeZUClhE3y01NFFsp4SqmkCxIM93lMNEeaB4pCZ3zWBoZoA9I/pHCJf6mpg/FWNcqe0jK5gHytws18T7J3wj/jvw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmpRt412lq24ynXv8uaK41Cj3hG91nJB0S7j0V1z/0Y=;
 b=vM/wKYIg0bwkosLgwSzz+J59E7PjAFPmovFLlnb1USrotvStGh1MLw0lz4AvlVIhTBv50lHX9WtIeCUrY2PHQzlNeUwwFEjHBeZ4hRfI9oAsxcUrfaA5NMB5zoysLpQxPii4lqN5mVLd94MHp868andn1OO6kbCeb+6YOQSoKo2RXA8j7Qm8RlxkQA2I/2wKIFIM6cr7UtKl/jo7LlO8plISzmLXp7p+yQ7hAy+VtTmUEyypRS6rxX6tRYiSkWfI7f+i1yUEKQlh+yttGrmK1OhyylPwRrnJrcPkfZCb1aE5/iIt7qXSxZJg5G65yWZNytpEd7BHUPySc8ivvaa+iA==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by IA2P220MB1967.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:4ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 16:23:55 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 16:23:55 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v2 1/1] ptp: 82p33: move register definitions out of ptp folder
Date: Wed, 10 Apr 2024 12:23:42 -0400
Message-ID:
 <LV3P220MB12026EB15790ABE932799E53A0062@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cW9zTqJ7KTggZCJrgIh5SYLG9NQ9x48O]
X-ClientProxiedBy: YQZPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::25) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240410162342.9516-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|IA2P220MB1967:EE_
X-MS-Office365-Filtering-Correlation-Id: ce366b45-86b4-458f-eb58-08dc597a9e1a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GwJSuvmC+enB1M0Dq1gR212B5r5qIvzCi2zTyQEfjR+NUICLRnZXi12d+hQ43Js5kLmvvtgTgCzajS3zyXR5LAh9MMtNGWPg+d0n2sB2qlgB6CIfpdxTHnhAEGRygi382+vJu3li+Cbt92mgBz+xej9eZ5ANRZNF1jiAEhIWPaai/H3HcIT+6LXxZno1QSDL6gLrldnqrRYRyRm+5JTLXx5N/fIxU6TVo2a5fcDu0Nm9p7YqFssC4mFbQZwWMiOKGDje7v9+XQeHB+Fw+HLhZ9ETe4LfaezXpHbSgVQJplJ2qiW6gR2bJtWFc/wFVeB3zyo3ZhpgpyXBbRU9GeyzMVvTSdIIYrMC9wAIUT+rroHjDbvgdBmV9wSw7PCn0FaRBRuv0Eu9yt3pImVXnBDRA2LOOk4ANjhCszCpEdDKJMPw3JlBw1NZcObR/lQM2HJD0b2bWfli0FfDCOvsMeDorIopILyIWXhysFTBPnKeCcgktDKAEHS7JV+r93ZysnvOJfYUd2bFIYfwSVATDVRpaaA9DLuWI8VmArAjs/Klv+cw6B7khlq7JxZEMr7lHOT5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qmeCs3yHVv32553n5TjSYrvyUoKK/QDlzTqYExghukFvYTwl8KJefMprbBrM?=
 =?us-ascii?Q?ghPQQ/mfmbvA4OPlSqZZ42lvyTYSlsu8Sgysdrt9yroxSC/NitlXVVc/o0AB?=
 =?us-ascii?Q?tJHQCloMiG0YLaibt/T5XSJ22432Axjgfm07/8Snt12+e5wBtfh13VLpkLDX?=
 =?us-ascii?Q?2a7M8vl9zxX61XXM3oQLvz9Khe5LXg9c01aeN01ZbktWg9GO12lQVPJFSjvg?=
 =?us-ascii?Q?+FXIkV/uJWwC8mTC/KJb2jDkAMl9QYyjAadKhhS47IrURbEjTCoeaYBowSPZ?=
 =?us-ascii?Q?bPgtL24kjVhHNvr3ZHCKs8lYm4dvmvXDYiKONxvfMW+GlsdQvaxC6+j/NmP/?=
 =?us-ascii?Q?1H/D0fCKgoyZXvSwRBMk6U3m8wS5k+RdC4OWI8+fh+fOR7LmvXwCM33vlfwJ?=
 =?us-ascii?Q?vfwWAzPdIDxwzUBJM9fhhC1i4kmSlh23oWE9igJKJlZOuUF3Crz/+r/E/FRm?=
 =?us-ascii?Q?kZ4lkpRDDFAUFmzkSczAR/7Rt4p75dBZPfw9Sk8cGOaciy6C3SPbT5EgOjDh?=
 =?us-ascii?Q?ZSMqX9VSV8F65cGZ1P0ORRH8O6N/gKkstEPMpJJwGPpBVw0vhe7TZUQtLumi?=
 =?us-ascii?Q?x/MXKTVT0sOgFupZQLaTVoCVV0J9NIkDFZSzDuWys54OfRrS1yscgRoHCKaR?=
 =?us-ascii?Q?djai78/C9joOp4xHSAiyCP4elURVIIHaSR/wtCGlQsfVYUzIPih9nY5md4zZ?=
 =?us-ascii?Q?a509w6a+vzrQxOzuHaLu0w0BCKnfvsZKnH3BZtnXfIfIKaoGNHsJFed8BSwE?=
 =?us-ascii?Q?p8LaGjypQJ819c6Xvoce5qAlw2caYj9rzDvbSesb33s1qzEoK3rSfflmHPHh?=
 =?us-ascii?Q?2NXKtrQMLXp34QxgtYtAAPm5+jt5Y1R8EzGfgeN8IOvsJvsh//wkulzqbfnK?=
 =?us-ascii?Q?RJ7sMf+O1Uo4bEjLGfL0ilDtUDwReEVObAsLyb9oo8aRK/hFhf1iYxi8eCOE?=
 =?us-ascii?Q?uopRnIfOUxRVkoBPD/X88ADVnDz6Un7c6wA7ZagJ8z5sAtoqzQn1dtB9qxt8?=
 =?us-ascii?Q?AMrHFZNkPCN5cD97GAuB4hNFExUTQRoEn3prz5qPfZKhC+t0TpvI6zhSACxI?=
 =?us-ascii?Q?v5Oo+XibXj4b40t7hss/cf9COgtxZ1o6ikX2uDV1Qul2HBXYhXudXR9Pg8qM?=
 =?us-ascii?Q?TOf0gbRntR2PgN8GVdWGGcS/oa8SIoN8YT2UMmHZZK3LC67DnWtdOaBw1OB+?=
 =?us-ascii?Q?0sgTur6zlBG1qW3ucbki1Zel8T+3GFycuM4DJU59fKBpKaK+Vt6hcHwpGVg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce366b45-86b4-458f-eb58-08dc597a9e1a
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 16:23:55.8222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2P220MB1967

From: Min Li <min.li.xe@renesas.com>

Relocate idt82p33 register definitions so that other multi-functional
devices can access those definitions.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
Submit to net-next and add driver name suggested by Jakub

 drivers/ptp/ptp_idt82p33.h       | 27 -----------------------
 include/linux/mfd/idt82p33_reg.h | 38 +++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/ptp/ptp_idt82p33.h b/drivers/ptp/ptp_idt82p33.h
index 6a63c14b6966..b4f3ee40389f 100644
--- a/drivers/ptp/ptp_idt82p33.h
+++ b/drivers/ptp/ptp_idt82p33.h
@@ -23,25 +23,6 @@
 #define DDCO_THRESHOLD_NS	(5)
 #define IDT82P33_MAX_WRITE_COUNT	(512)
 
-#define PLLMASK_ADDR_HI	0xFF
-#define PLLMASK_ADDR_LO	0xA5
-
-#define PLL0_OUTMASK_ADDR_HI	0xFF
-#define PLL0_OUTMASK_ADDR_LO	0xB0
-
-#define PLL1_OUTMASK_ADDR_HI	0xFF
-#define PLL1_OUTMASK_ADDR_LO	0xB2
-
-#define PLL2_OUTMASK_ADDR_HI	0xFF
-#define PLL2_OUTMASK_ADDR_LO	0xB4
-
-#define PLL3_OUTMASK_ADDR_HI	0xFF
-#define PLL3_OUTMASK_ADDR_LO	0xB6
-
-#define DEFAULT_PLL_MASK	(0x01)
-#define DEFAULT_OUTPUT_MASK_PLL0	(0xc0)
-#define DEFAULT_OUTPUT_MASK_PLL1	DEFAULT_OUTPUT_MASK_PLL0
-
 /**
  * @brief Maximum absolute value for write phase offset in nanoseconds
  */
@@ -103,12 +84,4 @@ struct idt82p33 {
 	s64			tod_write_overhead_ns;
 };
 
-/* firmware interface */
-struct idt82p33_fwrc {
-	u8 hiaddr;
-	u8 loaddr;
-	u8 value;
-	u8 reserved;
-} __packed;
-
 #endif /* PTP_IDT82P33_H */
diff --git a/include/linux/mfd/idt82p33_reg.h b/include/linux/mfd/idt82p33_reg.h
index 1db532feeb91..15828e205fa8 100644
--- a/include/linux/mfd/idt82p33_reg.h
+++ b/include/linux/mfd/idt82p33_reg.h
@@ -22,6 +22,12 @@
 #define DPLL1_OPERATING_MODE_CNFG 0x120
 #define DPLL2_OPERATING_MODE_CNFG 0x1A0
 
+#define DPLL1_HOLDOVER_MODE_CNFG_LSB 0x12A
+#define DPLL1_HOLDOVER_MODE_CNFG_MSB 0x12B
+
+#define DPLL2_HOLDOVER_MODE_CNFG_LSB 0x1A9
+#define DPLL2_HOLDOVER_MODE_CNFG_MSB 0x1AA
+
 #define DPLL1_HOLDOVER_FREQ_CNFG 0x12C
 #define DPLL2_HOLDOVER_FREQ_CNFG 0x1AC
 
@@ -43,7 +49,6 @@
 #define REG_SOFT_RESET 0X381
 
 #define OUT_MUX_CNFG(outn) REG_ADDR(0x6, (0xC * (outn)))
-#define TOD_TRIGGER(wr_trig, rd_trig) ((wr_trig & 0xf) << 4 | (rd_trig & 0xf))
 
 /* Register bit definitions */
 #define SYNC_TOD BIT(1)
@@ -101,7 +106,7 @@ enum hw_tod_trig_sel {
 	WR_TRIG_SEL_MAX = HW_TOD_WR_TRIG_SEL_MSB_TOD_CNFG,
 };
 
-/** @brief Enumerated type listing DPLL operational modes */
+/* Enumerated type listing DPLL operational modes */
 enum dpll_state {
 	DPLL_STATE_FREERUN = 1,
 	DPLL_STATE_HOLDOVER = 2,
@@ -109,7 +114,34 @@ enum dpll_state {
 	DPLL_STATE_PRELOCKED2 = 5,
 	DPLL_STATE_PRELOCKED = 6,
 	DPLL_STATE_LOSTPHASE = 7,
-	DPLL_STATE_MAX
+	DPLL_STATE_MAX = DPLL_STATE_LOSTPHASE,
 };
 
+/* firmware interface */
+struct idt82p33_fwrc {
+	u8 hiaddr;
+	u8 loaddr;
+	u8 value;
+	u8 reserved;
+} __packed;
+
+#define PLLMASK_ADDR_HI	0xFF
+#define PLLMASK_ADDR_LO	0xA5
+
+#define PLL0_OUTMASK_ADDR_HI	0xFF
+#define PLL0_OUTMASK_ADDR_LO	0xB0
+
+#define PLL1_OUTMASK_ADDR_HI	0xFF
+#define PLL1_OUTMASK_ADDR_LO	0xB2
+
+#define PLL2_OUTMASK_ADDR_HI	0xFF
+#define PLL2_OUTMASK_ADDR_LO	0xB4
+
+#define PLL3_OUTMASK_ADDR_HI	0xFF
+#define PLL3_OUTMASK_ADDR_LO	0xB6
+
+#define DEFAULT_PLL_MASK	(0x01)
+#define DEFAULT_OUTPUT_MASK_PLL0	(0xc0)
+#define DEFAULT_OUTPUT_MASK_PLL1	DEFAULT_OUTPUT_MASK_PLL0
+
 #endif
-- 
2.39.2


