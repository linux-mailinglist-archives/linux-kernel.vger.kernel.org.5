Return-Path: <linux-kernel+bounces-154743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642FA8AE070
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F311C21D37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA055646D;
	Tue, 23 Apr 2024 09:00:14 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D6755E51;
	Tue, 23 Apr 2024 09:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713862813; cv=fail; b=en0wCE8RjG2AtTFuUdkedayewtSHH8bPX6xFplMOwFXqvNJXN9CR5mNDy/d/tBZjmIqgzuKUZvhhOMtD5pZCx/ZDfcviaw6qVOV8n/QrztUhrtXlDf4BooyYt7+icOuYkPrSCmPWs7AU+cjki9hvlHZv/y19GfFTviEz7rL7qO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713862813; c=relaxed/simple;
	bh=c20SrivltBQSv4UDXfJZlmKhJB/g1OPzChZAgEwni8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t6vkWLuAFfyCSi8+zYo+OyYbqS78ihizpwRJIeHCYDo+0+XmPEUVrTum3FGUwyCL0AC5EHrtJC6jMgJv7wG3TD/e7fIPCpCaVcATdiB5GG1c7I1xWtmLGs+xCLKmLsTyTa+/M3h4mruUXWouKq7u+oiZB52yTVPB3Ikg0qVGYGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX9RoUFHbI/6KRpYKWvqGHdJiKEZ8RDQkc3SncvjxerZSvjfOjsCtq+JzRKZ+BLIrgcp0gyqAaV8ditbWWRcpcyDQzJZJYZqGrZnYI6L2cO+nO0Xt67Js/0epMLxk33g30n34ae+EoOJm3VXrPOWvOjafNq9mryz9b8qtV7OhAGTMSpJ8CIsM1MvQgGy9V/RnWd3YnAY7hUd0RAYmtGRmfYe3yOM7cRPGRLuDQGjHFNuV01qswU95pOTqPeOT7FHNp4ez8XQvMYXs/Gh83Hl/hZYvCQZIPlgPJpfhUOUY2Nt2D67/QQ4fkDiPL90wj4FgLFBMvaZcho2T3THuzpO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaJEuICYnqwRZRwIc5nMxgJI6EiDsLBePwT2RFZkVQM=;
 b=m9wmUnC/uSh1IXWaUP3pcrVtyqgUOXUIK1vNqU8eL6G3Zw+pIHEm+3qvgxYSyNzIqapGwa4dqvjjoLWNYYfCTzwzyobeUI04bgaDfJyimDCLW/cEGtwSCklmSFlYCfW35aV9k2NVNYPpEN+5nkzNYhDPi4+Ft9x94ef4bvj9kv/CyQNALNAQVcvUGTWAZfaU3Dx5qLogS4YSg5qVMHUHrD6ZN5BqUq5brX87o6+PyJOSpZaChaH8aVNL3XsKjlf87ytDAR2iAICEvNFKENqV4plq1+F3v378BXGt7BDT6RJ4yVECHFcMXX5VrfU3xJQdqKSlFd3RX3NJ6lfl6pVTDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0633.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:26:52 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:26:52 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 1/2] cache: Add StarFive StarLink cache management for StarFive JH8100
Date: Tue, 23 Apr 2024 15:26:38 +0800
Message-Id: <20240423072639.143450-2-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
References: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3f4860-9fa0-43f5-a460-08dc6366bf05
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qVUcYiCi9iTYgvdNjtP+MvEb1z5oHT++L8L91tDUX8VAP0M7EWv6J3RkEBFfeumCllwdcdH7rkc5mXSXmPZOmyW4S2uo1lrhXiycXyX5J+uxbaB8/U/eEzVoUEInnMMLqHCYZFTEs8UvBOQ+YowpaumrR3ORDj87QGhQNl+S8EqrV8YrhA9KosL76lupfGBLj0cxWHD2FO3z7Mcemwe2XhnjIM8dYlbvv31o8U3euJfhl7nCpq/2V/3DOtxTgOR5XoqpoRfoziz+LmbfJvLObMiyP1gG2C6pGSjOC8uXwNUwjp9sLQUO17tLd3WKVlF3mbzj15YA4NS2nVu2WsInh0ypt8axvqgsCCu936wmVS0vJHtSyTDAvgMDvPLRn1kGekM/+Jy9EfKZPH2V2p4fUMZC02D2Xmab6TiRHW6TvrFcKUz2XGFpVwgl6WJ+jAnu/Krn7ZIqFq5XtOwEvg5C72qVn6YvCw9OiJK+a7a7JVT9q6EXDRRp7d59rjaOHIfq8UhHefiF1coVoXFaIRXW0s+7I0UxS+Vc+A7+QHHIKVxaIdAxKwSRYXrcy+y85qvLvGDHnI7oH0gXbvXg55CkTK0MqsLG/Y+BlNX3/mRzRr437Zw9XwUuC6EOqH+svJdFwBJwiuB4I+Pwtf4KMxtOOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yyRkONQRCM/zdnM8Sm6D7T5thGx7GDYTCZ1jr5e7iYcBlj0TYea9VtVTWp0n?=
 =?us-ascii?Q?5K+YBT/ARytmkDypEYCO7Hv5Adw14+Pjmw8gJG4XBLz5nRlX3vILgZXXbhj2?=
 =?us-ascii?Q?YLldiKPqiZX5CzKspsIvt25pR7FVhjcUAQD5C1GuPvLXMUIp6jfxrV2ytsr5?=
 =?us-ascii?Q?H84dhFUEoIpbVOBSKbluR6dT7TvSlMNm6TsNpH/qG07I9zg2PeTVbWwiKlxI?=
 =?us-ascii?Q?YALXXIUBuQ/ZCq0aQ6q90O2fDAl6ucUAZojvXItJLuXzL2MpaFWqnvYXjLn1?=
 =?us-ascii?Q?T5sKFuSjMcl3xKudcCkJutaNzI6452chFZZ10y8oVq6SHvbh4AfgohCuwJAS?=
 =?us-ascii?Q?sPuhwwFS5fFrhPCTbCpYU9wMUCJhZL3ZPbpMYbm3TctHFkNf/It5Rs56OPJd?=
 =?us-ascii?Q?/a3ZZ50Dmvw8fXUBSnD5nZjk5ocoUO7qAkG+ySemuXyTxhsLKvDe6/+c02jc?=
 =?us-ascii?Q?oAgRz8l5RoAF+rHUFdarcGoXWsNWuZ1+fgiv3RqdsjLcY7FZesJGy++8MZNr?=
 =?us-ascii?Q?T0Dg2KcyUYXfiehls6LNGFGp5J/nZYYVTBPEk9iXNLA4dJwdbCA2+OToui93?=
 =?us-ascii?Q?sY5n4qBGsIifDWtFKrYB3kFtZ98XhohxR6ZweYCpTQbWF7pvf3aO0ciKzpQs?=
 =?us-ascii?Q?NgW3DrC9AeOAImtTR4PziBgTi1mTRmsnW6pLbZ1JVc2IeUkuYB226ifRIfgb?=
 =?us-ascii?Q?BZX/pyQq0hvbJjLCEbrNM/2dtw9YdKloh3rBXOVvPqAxd8aTq26P8yYf4MXj?=
 =?us-ascii?Q?lcnd/X0tfbu8WMtpUnESy4Pdrp+uH4rFYJk1247MFEwnbKWoq8/fd5AFUuYd?=
 =?us-ascii?Q?jdxVXe1yFlOwrTk1vBufUGnS06W+6Axeqt5Z2MTymsebi4K7CohEAHO9XaM6?=
 =?us-ascii?Q?Y+XN95f56XgIZ08KWYN1cdMnc14tHL39/V5+i1km0nDaOQBu60j5vruoiyxs?=
 =?us-ascii?Q?XrxMqBtMBofIPv06iW2AsbDFTvph2uQYBZFJdY+iuHEKyukxxE69Ihhxr9M3?=
 =?us-ascii?Q?7oQXd0DFH+6o7r/iclSzsLixPuRBbO7gyF6NwFpzRcgmbinGcFYgtutvhj7d?=
 =?us-ascii?Q?8EFj4zcs4lwbqkaVBsHpLsZvhnY2BgoDyZDxPfUaoWev5xTbMBvqZcOgzXap?=
 =?us-ascii?Q?OaB+1isvTmTSTnEqAsrBrqi3Fai7Z6uE2AjgsAlwn3ZM7rvtGETIhUH5DsZz?=
 =?us-ascii?Q?viF02XraC+RxAJfkyIwUeIFJFWp4gwcz4G4yAqgKP8APQhLCxG+WcVIOHocg?=
 =?us-ascii?Q?bPv+WLwBHy0B+Dr+PV+AbAdf+bPZwzhIlMhvfzuXS7sfkdzPZL8XJ0fOE4Hh?=
 =?us-ascii?Q?y9kIxOhvi7NFPi19jqLctE5hxpenluwvBzcCFm2c00mCRKoize4cKwAZfhBh?=
 =?us-ascii?Q?EnQPZMv1HyjEvD/X/lRrqWamGKY9Y02zaGak46e+Fn2DIVQA0a+8WofyLOGD?=
 =?us-ascii?Q?L2yXEhq0Ape/2WQ+SvzuW6i3uMkSM3Aw1nllZ3fb8CfQpgRiT35+OKvhDI/c?=
 =?us-ascii?Q?/zJwZEnB/ryFMkiQKdBUooXZ2yaKO+2vVfPI2k7H/oTWWw4SMG90Uhc7O/VI?=
 =?us-ascii?Q?QJMjsDno7ncLEkY4cXuNtCD2PpP4E3YEaGghl/vQZvMrmTRYaxi139ZoT5pd?=
 =?us-ascii?Q?qebrg1QSORXyfa3w2ARFK18=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3f4860-9fa0-43f5-a460-08dc6366bf05
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:26:52.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1haP8bfzhN47+t9OPZlzbq8QOKnnB05rQa3/4KjJD1K93k9mut+GCKm/amPXGdNDydlikRUf8EZKXkcTZzC9QRR43mvkVXdJwNpCMnDCaPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0633

Add StarFive Starlink cache management driver for
JH8100 SoC. This driver enables RISC-V
non-standard cache operation on JH8100 that does
not support Zicbom extension instructions.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 drivers/cache/Kconfig                   |   9 ++
 drivers/cache/Makefile                  |   1 +
 drivers/cache/starfive_starlink_cache.c | 132 ++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 drivers/cache/starfive_starlink_cache.c

diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 9345ce4976d7..9181cd391f53 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -14,4 +14,13 @@ config SIFIVE_CCACHE
 	help
 	  Support for the composable cache controller on SiFive platforms.
 
+config STARFIVE_STARLINK_CACHE
+	bool "StarFive StarLink Cache controller"
+	depends on RISCV
+	depends on ARCH_STARFIVE
+	select RISCV_DMA_NONCOHERENT
+	select RISCV_NONSTANDARD_CACHE_OPS
+	help
+	  Support for the StarLink cache controller on StarFive platforms.
+
 endmenu
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 7657cff3bd6c..8ff8b47ac3f7 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_AX45MP_L2_CACHE)	+= ax45mp_cache.o
 obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
+obj-$(CONFIG_STARFIVE_STARLINK_CACHE) += starfive_starlink_cache.o
diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
new file mode 100644
index 000000000000..96fd6a4f4c08
--- /dev/null
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Non-coherent cache functions for StarFive's Starlink cache controller
+ *
+ * Copyright (C) 2024 Shanghai StarFive Technology Co., Ltd.
+ *
+ * Author: Joshua Yeong <joshua.yeong@starfivetech.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cacheflush.h>
+#include <linux/iopoll.h>
+#include <linux/of_address.h>
+
+#include <asm/dma-noncoherent.h>
+
+#define STARLINK_CACHE_FLUSH_START_ADDR			0x0
+#define STARLINK_CACHE_FLUSH_END_ADDR			0x8
+#define STARLINK_CACHE_FLUSH_CTL			0x10
+#define STARLINK_CACHE_CACHE_ALIGN			0x40
+
+#define STARLINK_CACHE_ADDRESS_RANGE_MASK		GENMASK(39, 0)
+#define STARLINK_CACHE_FLUSH_CTL_MODE_MASK		GENMASK(2, 1)
+#define STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK		BIT(0)
+
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE	0
+#define STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE	1
+#define STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED		2
+#define STARLINK_CACHE_FLUSH_TIMEOUT_US			5000000
+
+struct starlink_cache_priv {
+	void __iomem *base_addr;
+};
+
+static struct starlink_cache_priv starlink_cache_priv;
+
+static void starlink_cache_flush_complete(void)
+{
+	volatile void __iomem *_ctl = starlink_cache_priv.base_addr +
+                                      STARLINK_CACHE_FLUSH_CTL;
+	u64 v;
+
+	if (readq_poll_timeout_atomic((_ctl), v,
+	    !(v & STARLINK_CACHE_FLUSH_CTL_ENABLE_MASK), 1,
+	    STARLINK_CACHE_FLUSH_TIMEOUT_US))
+		WARN(1, "StarFive Starlink cache flush operation timeout\n");
+}
+
+static void starlink_cache_dma_cache_wback(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+	       STARLINK_CACHE_FLUSH_CTL_CLEAN_SHARED),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_invalidate(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+	       STARLINK_CACHE_FLUSH_CTL_MAKE_INVALIDATE),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static void starlink_cache_dma_cache_wback_inv(phys_addr_t paddr, unsigned long size)
+{
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_START_ADDR);
+	writeq(FIELD_PREP(STARLINK_CACHE_ADDRESS_RANGE_MASK, paddr + size),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_END_ADDR);
+
+	mb();
+	writeq(FIELD_PREP(STARLINK_CACHE_FLUSH_CTL_MODE_MASK,
+	       STARLINK_CACHE_FLUSH_CTL_CLEAN_INVALIDATE),
+	       starlink_cache_priv.base_addr + STARLINK_CACHE_FLUSH_CTL);
+
+	starlink_cache_flush_complete();
+}
+
+static const struct riscv_nonstd_cache_ops starlink_cache_ops = {
+	.wback = &starlink_cache_dma_cache_wback,
+	.inv = &starlink_cache_dma_cache_invalidate,
+	.wback_inv = &starlink_cache_dma_cache_wback_inv,
+};
+
+static const struct of_device_id starlink_cache_ids[] = {
+	{ .compatible = "starfive,jh8100-starlink-cache" },
+	{ /* sentinel */ }
+};
+
+static int __init starlink_cache_init(void)
+{
+	struct device_node *np;
+	u32 block_size = 0;
+
+	np = of_find_matching_node(NULL, starlink_cache_ids);
+	if (!of_device_is_available(np))
+		return -ENODEV;
+
+	of_property_read_u32(np, "cache-block-size", &block_size);
+
+	if (!block_size)
+		return -ENODEV;
+
+	if (block_size & STARLINK_CACHE_CACHE_ALIGN)
+		return -ENODEV;
+
+	starlink_cache_priv.base_addr = of_iomap(np, 0);
+	if (!starlink_cache_priv.base_addr)
+		return -ENOMEM;
+
+	riscv_cbom_block_size = block_size;
+	riscv_noncoherent_supported();
+	riscv_noncoherent_register_cache_ops(&starlink_cache_ops);
+
+	return 0;
+}
+early_initcall(starlink_cache_init);
-- 
2.25.1


