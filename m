Return-Path: <linux-kernel+bounces-143047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D08A338D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF391F22A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286BF149C57;
	Fri, 12 Apr 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="OR8+Nsty"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2061.outbound.protection.outlook.com [40.92.46.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D4205E2B;
	Fri, 12 Apr 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938686; cv=fail; b=B6WzQDQOLptjKG/O9linGuVqgvEOU9o9uM6uPENj3FLKC+Cq+27+Q4SxRvt6n00a47wiDTL8pEl7t2+I7cHEQ/fT0dePUGb5ELNfHCs3jMeWDaCwOj38WH/vTryHk+KyetAJUL25fn84UQVeOTFV/Y7MeGPnZ9hGKUvdQxY28kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938686; c=relaxed/simple;
	bh=8e6mZzPzqyujaJz+NX4/DvS3a0PR+8wHtr5ropE7NnE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kWBBtRcDung3OfqJFKI35naLhdGotyg5B0w5SXS5TEV2OK02UaU9C3T2JQskBeHNeLL4MVvbuE6GOSTSb86e5TfWlidN9ksR+HZ7L43FUIWPZqBmdM76h6jh+TTFs0KTCinibXxXaetk77CPrObbZ2irJyY73TkNWh9seYavTMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=OR8+Nsty; arc=fail smtp.client-ip=40.92.46.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRo0l+jGUdcpRurFYbQ1WUmucVFo57Ra8TrYd2GLWXBIGfwDZY9Y9D2RsAO0l35x7gB7mrLDbaPF6j6b/QT0ifsp86s/PubNuukdGB8fxPOPZdNJOP8R/CSr5wnCSOfOpEEqK+g+z+DAdj3ueGQDVv4ouYtzOHrDbqgGKMjgLPVEDsQB55akFflOvC+Ln0dFhCETR/43IbxZjml7TZvVOPV7q1QyYRXEDthZkTOrXnA6u/fg+b5XkRJ50JQhao65H9mcvl8Hl5RPKaR4be86byn4sRMvLyU40jVSqK5qk2yULuFE7ZTHoJ7b1yzIH40hNCOiHpK7Ae9Z88k0QlWIzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SBx+n/BA+Bq8ZgTu3vNhfJhCqPebXw6m2OaWwtJGwI=;
 b=Ke3++LewulXURu3xEaLO3sRlUiXGU8TA8wDznWUHfbbzrZREQaf6UA0WqnFIlej6sYkvAsH0pwzKUj1GT4TnefBGzhWKifQvhU+K3TYdnPKTMsqlOK9UVKrNds0wPMNCTdClrLAvf54Rm+LYEtAveBw7Kr/Hgkqmvf9tIML1zRppuHaPBZ3Sw1/5FdPzWMV9c5Kxek6kAW83qCqsMy2clKb5Om06kLhakXO/Qs4uMO0CErypeTId57GoUV7F6Anq2B8rxV0VBnS/6Wi7i/gB0F5zJMQY+swp19Gj9AtUSBvKMEIUBrTo7oo+zrrwha9MXorFedUrBqSTNhbReEUBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SBx+n/BA+Bq8ZgTu3vNhfJhCqPebXw6m2OaWwtJGwI=;
 b=OR8+NstySxUEI3lpbRIOp61Gc107COCRN2Hu9jBwTMql/MGZSMFD1b87VX0vuOcdXqHltTRnv9OgPC7JYx+Jb9p7iMq4Geb2RUZJRZXK+3K5+jLrH65bwIC4uV5trihrewc0OZGzunECMq+l6bLGdkVNwH3ZSy5o3GxTNYmMkJFxvAssYNBNkBSRfccL91BkstlYBCUw/EKoxDDMCdlbpnmcAB+TbrPRm+kFtpGOyt6AIRta6BqxPeUM2oG5dQztK5sJDipozrwEiNmwTTntCPEkCOshLo4Oj7VE5CwV6lMLJRwsjOBXmACKVTdByiDme15i4US071GVr69FTVSpOg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ2P220MB1236.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 16:18:02 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 16:18:02 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v3 1/1] ptp: 82p33: move register definitions out of ptp folder
Date: Fri, 12 Apr 2024 12:17:49 -0400
Message-ID:
 <LV3P220MB12025B8C285BC6D8541B052BA0042@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [S0J7c6mF76XyLkU+8vZ53Ktukravjh43]
X-ClientProxiedBy: YQBPR0101CA0309.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::13) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240412161749.20389-1-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ2P220MB1236:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aec3615-d176-414f-a2a3-08dc5b0c20a6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gRWKit7neCz6MWz8MiJci+pEkHajghIKZTLnybaiNC7ugsyT1oxlABiz3F0Ndu4R48T4OMAQYiHvZewOoT7o/vURkfVqMXRnPHLfrNUeEzCDJvjdYtNdXyBjgvl7xUGiSEpKt2dhcHizekw1kk4FMLocaSlEw/QiyIAFGYzxxrYN35cgBACHx47LZSYw+4/khQOq5n+4u30hUiTYZxSSiyLYGle53ta9KkbHSSiYiUPW5tGyoDfRbq+Yhdj5E4clp+D7Yio+xpwAshkTCsA/qzQrvRyN4XIrCsM92fDr7ZgPv9bOknXDgsaWLFT7bVSW/kUTPedoZSRVO426B5HQ7wvsO4RpS71nIcuvH/kxg4vQsISQxP1oDX1I4YtBlAkldEUD6OspcPE10CmP1svr78x4UezjFTb0vCRLtlAofurIbWsuTKTprULVLLxvwAm7xUphkF29O9HxrhAF8jsx96keyTe0lVSrbfRiRgdYcopaBWa+Qq96tGL9qTSIsnTb8DzDRMGqia0hKMivqrVGy9j2/p/zqPTvu7AY+mo0ZKNQoAWoqYFJXR2rYLAqaC0s
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/QesaviNH91VS8QTpqcZZ5PlGk2Ul0wgDSDFuHnoii+fMJEPZvfKZK9Gljrv?=
 =?us-ascii?Q?cNhwFyPlM6weVI+e+/MtV2ErFvCXgONELbxp1C9mQ4VqHRyHBHzU+wx0A0Xk?=
 =?us-ascii?Q?zONiob3Z91y1+VjPbd7Z4X/xNbqQMyUnF2pdiLO25qnOTzUQ3unSsKFkIwp5?=
 =?us-ascii?Q?jACdxwHwt2k/krElydDdnY9Hsfj6BLs//OtiODIOvI7Jzu9qJItCpeGQnb+S?=
 =?us-ascii?Q?ws6TnOlQiP8JtBkBlOVInt6D1mF5G4ZYs0H3NBdeXn3d/OOnwOchpbEtzs2p?=
 =?us-ascii?Q?PRka13ylGXwfFit/HmNWIoh1dEVARagwsPI5UjASpXUEisdbfUpVIw/08qDx?=
 =?us-ascii?Q?f/eF0B3lqKX0b203yD/98dSerhMvqURfB+coSDkg9GTG8pHK+NMB5yBa4Cg4?=
 =?us-ascii?Q?/gEoZ5d/4JCY1UtIdNWTPfXMBYS+c7BAzzCIoorIxtCeCNJ3BcmT9TW0GRNe?=
 =?us-ascii?Q?kmubVUzfkYmqtq13iNcjLfkWZezWXVYY/esrhbSP9k/FFit6TyGhkPD0XEDF?=
 =?us-ascii?Q?Cu689Na8xr3e/hqY5vgwl/rPtpg9wEmVuO/4uxiXmBc1akv7f1vd5HS1XFO0?=
 =?us-ascii?Q?7ZmaxO6lGpHVIhB8I3Ha5syg2xTbhhOuA6Om2bZZdzopROazleho3rCTYXS5?=
 =?us-ascii?Q?a2wHBZ/gYWLp7VK04hLG4cOqKzfp4CTb8Q9z0/WxTCo60/cajixrkMN6MFZp?=
 =?us-ascii?Q?XwKU0rTbpbT3WUjMz7M3NUZmbFt5jhCQQ6J3DwoVVcT9iox6jjwsV5xZwscZ?=
 =?us-ascii?Q?yuZ9Zcisw/i8+Da4EiIsr4tEb/6lw1VjFrgSMsUtzJ2uw5VrI9hrM/DNJucd?=
 =?us-ascii?Q?VpPzz+DQu3D+cb//UtPZsYuREezn0R0tOjgdhatWZNM0/DFqkNltBa7kFcbO?=
 =?us-ascii?Q?ric0WZ9hSCOiw9Uc/Bl17/ng/iv/B20RBgaT8KiAn3QjOvJeKXT/d8vBDW0F?=
 =?us-ascii?Q?fy5hJvrsklB5HZnnSFFF0bRf2bT68WbdToDLrnlCs1gysY6Lyrz6SPzvwU5V?=
 =?us-ascii?Q?z+/l+LHdQj0ooccRBaSx5MC/5ApGGoPt/KdXUQ7rMPNVexQZ4Rrdbpz8vBqn?=
 =?us-ascii?Q?E7MRGjGTBpjlRkHjAX4hLbw6gtOQClu+G5BfOKU1zyJGfGesAaUcrodMPirh?=
 =?us-ascii?Q?vVY2zGLlGVXNYlnWbDQOJtBevq+2JjR+Dk1EzFoIB0eQvfdwGIY3sqZw8iIC?=
 =?us-ascii?Q?fnQj2h3HIrXXc9Zg6qclC1e1yvGZQZyye2mFly1K7dNdCjopcEL87FKs/CI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aec3615-d176-414f-a2a3-08dc5b0c20a6
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 16:18:02.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2P220MB1236

From: Min Li <min.li.xe@renesas.com>

Relocate idt82p33 register definitions so that other multi-functional
devices (such as the future DPLL subsystem hardware driver that are
currently being developed for Renesas timing devices) can access them.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
-Submit to net-next and add driver name suggested by Jakub
-Name the driver that can benefit from thie change suggested by Jakub

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


