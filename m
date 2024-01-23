Return-Path: <linux-kernel+bounces-35746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E9C8395D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56DB61C20E36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3D28005A;
	Tue, 23 Jan 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqRzNiV7"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C39880046;
	Tue, 23 Jan 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029355; cv=fail; b=P1uOmSRJUFDQ69wBXwJdYQdg6Ra2kNLLrPRMUN9jyXnViKOpj9FXuoyqeYns9temea5AhhtUk5jIstO0tDHTdWz++gSxBbfijxdUckKG38s9SobqVa0dGS/fkSnMiUM2/oWPtrtnsh4AY6pEVKEoC7Y7jPMejofjnkpUnTKk3uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029355; c=relaxed/simple;
	bh=G68x1yCEGD8Ou/tEMi5ZEhk5PQ9a4F9jl71aQCxqlqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UumOtpgymt240qaBjUa50UFuc9uJ1R8AswUuOxZQhuN49p1/bQ0Mhca/z1MeYHrCmagLwHf77XEm0qM0EKv8tAKC0ECJ/gAJkmao7HQQxE7uBlT2C8UCfIE1bY/5zUfD+2XFQjbx5Yt4Nzohn13kn7aP3cCk5oC+XMgn9LstS10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hqRzNiV7; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gaDtjGKV7cXPM74Gjf8+8yLFiLbsJ4s0okNK8Og6V3fZldT0H8gGN5vXQkyLKVG4fu+nE39cdIWZpdg5dyniAdSqaE77cofzdUI8oeSFh/DrVa0vhxqE8aKXvM7NXbntc0pVEgfbmSievssfx4M07iecl5ZjDvR4MZGlka9OHK4E8PEYHWICF0uxiv7zQoruYnFTJtbGDqKmjk1JJuzGp38VmTteu1cSHCPu5fv3dO3BRg8U3qtQNzu5zSwAXwGwpco43HoI/cLb9LfCeUrYyaeGmd3fXvQkBaM79MV6cSKHKkvfT1zbCX8cpxMNPtUZt3B/u08BlYqp0lKUq7Cr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6fKhxf57NRZOyaYmHUg4O8Z/T8SxsBFi1v1cuJskSc=;
 b=Icb/Vh3VdIcZSThljb2gzN1B6BTaaSWZRJl3c+vDaHcGEsC79Q9a+ibdqeevAmS0Nzs4BxvhAisNaI6JOlguihRbb+d6xWlGYBZu4nx/Y5M0XOktCQmDEjO94bBYwuOuEqvj/oyxheKBl1yR8WWKaVzDs+oqzJrwh2PbMP8NamLzB0QzAt357JqEXy8Kmn4p90qmmIh8dgrtUEfW4rp6bhEk3Fu91Yd36IV5dqAlUYVkO5WM0YCV0ZPUyhvu2o/ehz5sGxzAakQsixpZSxQl4vuEcB+lZsGcuiWgv3fRJPg7MNIrSb/h2FWL1AJHN9Hhi/2vxyxgE8T/BXe4ih6B6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6fKhxf57NRZOyaYmHUg4O8Z/T8SxsBFi1v1cuJskSc=;
 b=hqRzNiV7LbvOCetCpWjQK6MN2WMFSsT4w06erSfclHJvapU6goP/YJwmSuR/l7H0bRj1BYOj9GRU0YSEaW4ny/WPTVXeWE+ckIP2yTnm4TMhaskldVGYrRPJvcE6LZEAE+p3O85Zu7sLcF1WqFCGHgM5XxKohmlgsh0wFcMtNg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 17:02:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 17:02:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Frank.Li@nxp.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	mathias.nyman@intel.com,
	pku.leo@gmail.com,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH 2/2] usb: dwc3: core: allow overwrite reqinfo in GSBUSCFG0 by dts
Date: Tue, 23 Jan 2024 12:02:06 -0500
Message-Id: <20240123170206.3702413-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123170206.3702413-1-Frank.Li@nxp.com>
References: <20240123170206.3702413-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0198.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: d2029f49-8c83-42b1-2c52-08dc1c3514f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rjP5BTONu5FfijvJy8o4YwMSLvglsTRn0GBtSS1dl6abw7zEC9Xzm3RgHnFiaauir7kNGpcNNmygWz4HiWuz/qdBRPH0R75tJaIlmDUXG/XZBUgfmahWJFwaV+gGPIGTT4PRgyJI4gIWVAhu/j2irJvT6WKYJesQbu5N6vVFW4WNkodvp/btNp3dY4Ui/prvslIx2bQgB72Gu+s6cYcPaqNmGDW6IYIv6/mRuZ5IASXTKDD9ErI0c6FkvVbFCHscbQl+R8Nk7TQwMo5o7ZURE7A3AqltYivN1RKIPooGf4iG9Z5Fcq1piid+N+A63OCVlLsuJbFx9Th4QSFY94jYacBPwScY+o31BZE8nBmRD4j26VoH79dlj2/OwNVZYhueycq16NqSCSXtD8dDlsCP1+cNINyVX0HE77wEOrzUeP+qBBGEwm2K5apvj3eWdzyTcB52e1VXzYpdnVOjFrmoR/iBG0XT95nWOYLGsN+UcM75puA90FfHQ1Xu4Y+aAUXOz2ZgD0tzmGk5VxQvedH8ut1uLUQ2PQDx1NZ37Q6HD+PUy4p48CrxPY/JAfgkuRiQbYR8ZFJ8hHqpM2hKnW3cV6W5Igg7OCu/lechGU1AJlXq/pDtRhaLU3JfCoffj5GR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(2906002)(5660300002)(7416002)(36756003)(38350700005)(4326008)(6506007)(6512007)(6486002)(86362001)(52116002)(478600001)(83380400001)(2616005)(1076003)(6666004)(26005)(8676002)(8936002)(66946007)(316002)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGjOQb9I9Plh+BMy1rSIku3lPHRj8RG25vBf0k/bNkTp6bLpigjnzaVixUo2?=
 =?us-ascii?Q?pebEIjtF/tQK+Em8YZDRatSbr1b7zJLE4YLeZUM97yjZrtt+E5MEUN2WhhpQ?=
 =?us-ascii?Q?aABhri/KUZ3DAB56aIplM+PkDDZysDkQ3nr61K+2tABVr+dB0nxJ1HhYwlgB?=
 =?us-ascii?Q?4uQd+IjlnMsk7RKmCn9rW+EhHGrUbnlO0V0QCRD2X6KNCqi1T/EtFSUqitgZ?=
 =?us-ascii?Q?LbNct8Bib/enpE6ueIjaYC9ngW8wSZqbuyJBe1qkcIWCxu4T3Y5/9yIZjK1X?=
 =?us-ascii?Q?oSogU4qw3NC5EaGVd0ZeLYIBEf+vV4gqTAzsqJ4ycHR7yq0mOnn3w1mJaWGF?=
 =?us-ascii?Q?XWOuCP2IvEbxe0DMl13gdkA/RI4LKml1K1NNowy8cE7b8XCuZPBVUWoow0Hs?=
 =?us-ascii?Q?pvGL5eyz4olYEprig4r6r4vhLB+Sl9KbIOSe/x5BbH5kfiOVYLZMXXbV9qkL?=
 =?us-ascii?Q?BTpFBtIYKqC2H0gSUZyFDjI5vZlYPKb+Ar5S/TQRMWclh8hddvYZdorbWYcI?=
 =?us-ascii?Q?bVoqR5/uRXvOpGCFWDZLLGds2RlATGEYDpxmz6JE/c4VyzAgaOMLo7Br18SE?=
 =?us-ascii?Q?0DjyA8eVe70EralZbL9sMh6SA1uyiAoyQq70wfBOtaGT6xYlr2CZr2veG14O?=
 =?us-ascii?Q?xYrHQ8FSDyho79cp+ItFSytWcMTwI9k8fT4y44r2E1hGQlwwYkLfVQuYwwpZ?=
 =?us-ascii?Q?3F9Jh8L8lm7zxooNbvOQzbdX8LCTkRCtuvPZTslp+Hf60hO/ZObjNA2euLul?=
 =?us-ascii?Q?XYw7gFSTzmSEVgMg6CSBlx/cj23txwSVVIlP0TGaTaN/QwpHiGZ3J8a4vFnU?=
 =?us-ascii?Q?H+3QqUbShKRygkc3pKQ5Pa5BfV4ATLjkJRhDzLQL+D+Tp1Hw9XWCSAcbrnDS?=
 =?us-ascii?Q?+OsnhdNGqwz8PQw/Gr5OexWDCsUPj6AhIqDYMJ9AWrGM1KIgapo7YeIadhML?=
 =?us-ascii?Q?zOw6MWlmpVR6BriUb+8y0WsNHuEOg6Qhd2lX9w8k/Ii+KG3gSiXaFH1q+mOl?=
 =?us-ascii?Q?uGixCkWaC+lnRZ8FYkzJm55Z9IAoPA5H5Tc7q0Lu+Ee+Twyf32XNuS4ZkzwD?=
 =?us-ascii?Q?aW5UX0omdO8RBFyMiyNySJTv1SmKuMFMLw6zXKzSNvKVH+Wrl4oCU25zw8rR?=
 =?us-ascii?Q?07PmWL9HwICN1+loa7bBcZkC5yCJJ/qez0fZ5Vp14jWWE993lrUzXDC0D8FX?=
 =?us-ascii?Q?KIlYkx4Jom8EKdL/ihxdzA28ZZ4LJxbo4p7wHH1dhJiT6glq4kPG7nb5/xro?=
 =?us-ascii?Q?fVPOvek7joNBmm/Cr9gotMPQDpaTQzx2sRCEBxKxyA8Yy6pdr2tHnLGW4R8/?=
 =?us-ascii?Q?Rf/mbd5zPvyDARozXYQ1/UPEGLUqFs1MMBRcJfDRUwIjjT1bZVHQN4FfwBqC?=
 =?us-ascii?Q?feGfylTSm5cWW3keeU19LMBlr14cGwzB4ckhW8xuvMz5w5xyaQpVFlLhCUde?=
 =?us-ascii?Q?wDNLw+yBcNKeN2IWIvu7aIOGtT1Hr+/p+DoneJ3uZI3+5c1JVAy1V3lHNENw?=
 =?us-ascii?Q?uB2ZrDl9JdmgUG44tWJ0W1FyE6d/Bor2nO99R2VLHTOnhJPt1JRnLWJF8q+G?=
 =?us-ascii?Q?35KXMt2cHcjKXi7p+TQ5C1VsZhnXLNMU4G52vG15?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2029f49-8c83-42b1-2c52-08dc1c3514f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 17:02:29.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zvgsgm/Zq5iyvx+lrydW8JRERcAYHh5HuC4xbVcwvrH3KpyiaYYGAFgZe1Fqd4RY6SSeBCUf8sd0JqXQ7f5FUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Add function dwc3_set_bus_req_info() to allow dts overwrite bus request
info in GSBUSCFG0. Some platform (such as Layerscape) require correct
setting for dma-coherent. But default value is wrong in chips.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/core.c | 33 +++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  4 ++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3b68e8e45b8b9..c72929b122014 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -948,6 +948,37 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 static int dwc3_core_get_phy(struct dwc3 *dwc);
 static int dwc3_core_ulpi_init(struct dwc3 *dwc);
 
+static void dwc3_set_bus_req_info(struct dwc3 *dwc)
+{
+	struct device *dev = dwc->dev;
+	u32 cfg;
+	u8 val;
+
+	cfg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+
+	if (!device_property_read_u8(dev, "snps,des-wr-reqinfo", &val)) {
+		cfg &= ~DWC3_GSBUSCFG0_DESWRREQINFO_MASK;
+		cfg |= FIELD_PREP(DWC3_GSBUSCFG0_DESWRREQINFO_MASK, val);
+	}
+
+	if (!device_property_read_u8(dev, "snps,des-rd-reqinfo", &val)) {
+		cfg &= ~DWC3_GSBUSCFG0_DESRDREQINFO_MASK;
+		cfg |= FIELD_PREP(DWC3_GSBUSCFG0_DESRDREQINFO_MASK, val);
+	}
+
+	if (!device_property_read_u8(dev, "snps,dat-wr-reqinfo", &val)) {
+		cfg &= ~DWC3_GSBUSCFG0_DATWRREQINFO_MASK;
+		cfg |= FIELD_PREP(DWC3_GSBUSCFG0_DATWRREQINFO_MASK, val);
+	}
+
+	if (!device_property_read_u8(dev, "snps,dat-rd-reqinfo", &val)) {
+		cfg &= ~DWC3_GSBUSCFG0_DATRDREQINFO_MASK;
+		cfg |= FIELD_PREP(DWC3_GSBUSCFG0_DATRDREQINFO_MASK, val);
+	}
+
+	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
+}
+
 /* set global incr burst type configuration registers */
 static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 {
@@ -1256,6 +1287,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_set_bus_req_info(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index df544ec730d22..cf64cfc0f208a 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -186,6 +186,10 @@
 #define DWC3_GSBUSCFG0_INCR4BRSTENA	(1 << 1) /* INCR4 burst */
 #define DWC3_GSBUSCFG0_INCRBRSTENA	(1 << 0) /* undefined length enable */
 #define DWC3_GSBUSCFG0_INCRBRST_MASK	0xff
+#define DWC3_GSBUSCFG0_DESWRREQINFO_MASK	GENMASK(19, 16)
+#define DWC3_GSBUSCFG0_DATWRREQINFO_MASK	GENMASK(23, 20)
+#define DWC3_GSBUSCFG0_DESRDREQINFO_MASK	GENMASK(27, 24)
+#define DWC3_GSBUSCFG0_DATRDREQINFO_MASK	GENMASK(31, 28)
 
 /* Global Debug LSP MUX Select */
 #define DWC3_GDBGLSPMUX_ENDBC		BIT(15)	/* Host only */
-- 
2.34.1


