Return-Path: <linux-kernel+bounces-31579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB24833050
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733BC1F24179
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5106F58AC6;
	Fri, 19 Jan 2024 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bU/eU2Sw"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AD58210;
	Fri, 19 Jan 2024 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699913; cv=fail; b=mz61vg3zjKqw/DUo2O5bDF24xE3Qsi22PHqo9ZLG4yvgmZ+HGQvKk0+z6LPxOKzK4W1S7jc/9zfRkL0Z6k8IFLsIj03ngfik3Sq0aOp1E5ryvS4xu22aBAr7mP5ApGDEHt1EsgjdEKJaBAQhRGUTdfrI2Se/GNUo7pPjYLBNTCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699913; c=relaxed/simple;
	bh=sWn7eNJsv7QevaCwVtRZTZGoKX7P8VRhvgQ1e8fwVw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMaZ5AvQKUrGG+iSlgSn8wA2dTw+7zjNupxHRDTT2rGMMsvvkolLVcvb8uAxzmhBkjFxKb6l3yGYyukxy7eh2XeviIcQOghYTWFWkT/aI3xHilqgwx/+4rB7gdPNyNL67yrZuJ4p9T2GMVtXSaqavbtekTyy/tkUhTDlIsVsZtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bU/eU2Sw; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgOq/d/0xgI9Ddau4fXGVT0InMDMFyU8NQkLp+CJTiGtUqOIId7wik1fXqb251ef7f7Jt2m5jAOREeJHI0674oIRNIVR9ZAFZtl3XZEpaoKtS8VPZldaWQEeIUbZm21R97hfHnT7EDPrqt7qVovd7bkFTq5uzCFm8EXf9wKjQ8X2nOU70EXa3TzFBq7TaN5t6ZAEOFB70DmLLMoWflmnP3jytzNpljzwAsBboG+Lc+r84CZcxAfgXwd1qxEKHaMxPL+scRkPRzhzfBJSMqN1bJGjIxFWEWVkzhfHWbjlUJ47qApGbq81ChK0x5FbpbsbEyuaaD7yLcfRkT80qvSr2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fVOIiSbFLuzbmEiE10O7ufJbCdQqgHUs8529IcsgEM=;
 b=WCNwt/1ypMU0uG8DfIN9OPYfJ2WWzoiGtIvJpI5158ukQ5WBMGs14rJEN5S8kmTHVGQDUUbrg5Fn9sO91rH9Zr3/fpNL7ZjNA/xRznoqCK+9O1+pKn/IYNsp8veXbOXA/BNvuY5YNihZUOgmVgD7maOa19kG+HBjMO6XUiOuzsjaYs7pNJtJXiC5FO35GHMdHM1hxv8ewzVawMMxhUgyOHzmXP86HZnThmYfzB9uXPq6+Y+Zu3vCIbKMv6uG6N2JgRS0kr68kFm/DsnXsnz2ZH4+IVILJzk32QdZ27SXfk4GnQi9ZNe2SMnPITF27vHgSg/o1urNUwuzygz3KEuVwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fVOIiSbFLuzbmEiE10O7ufJbCdQqgHUs8529IcsgEM=;
 b=bU/eU2SwgUbzhWgbwz2JyhX08EMP9QF859VufzKnSue+POYE7FG0e4QYNx+s+eYkEQze+0ILXHoj+XSVFe+xFY5q7ioJXEAIF7MvG4l1k6ce4Jv+rcs61NHCdH3UKlD+ySF1cu47pJh/DCBaNDtRT6wTGht8EweZy8V1QX1FKR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8795.eurprd04.prod.outlook.com (2603:10a6:20b:40a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.27; Fri, 19 Jan
 2024 21:31:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 21:31:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: ran.wang_1@nxp.com,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: balbi@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	pku.leo@gmail.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch when boot
Date: Fri, 19 Jan 2024 16:31:29 -0500
Message-Id: <20240119213130.3147517-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119213130.3147517-1-Frank.Li@nxp.com>
References: <20240119213130.3147517-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa251c2-5905-4676-28d5-08dc19360b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	temKoJ2utQMN13ebSZ9qfcmwM2n82KmvAnwkRavLZrnhQiQPJARuqRz4HBseTSzRmpPScT4B+sPc4c5FJF0P7kyIJLgJYdoVPFe19XHoW6jBVJGhMPFwtndHaVVd0sZB25/hbPyH9RT9xyQSpZ2HN2izbV7b9KfCcj9WNHV4uqPN/MP9tUl2SzfolKD/iUWWizto5zhsAo+kBROWUmgBgn75AdHU9ctO2Hsy4JzHtva+raH40M//1x7U47z9kODfBl9kl4C3CYQ3lBYeM00JOM52ZckVzLPqrIVzPr/veTvTGimdAIyg5SYYGgAtMnATTRx3OggX1q9AXSKS0hTdEhonMlf1xj195hykn0UGWpPpkskPcBoynIqOd3VS9IUB7fs1XoF7KKOftR4HpsZoXVvbOtzfzz7XI6XnwKsmP9aH00w0nHlQuVnpFOflc06g30alb2qyUotaEVcT23y3Pik5TMOxVF0jMY51kaEj/PAgCmkab07vtMiYm1xoTB8YxqlhyTD3P6cryz2oeEAtzyIHRQa6CKEeoMzwlHlcEUL2cpdjDuu/qqk4jyGPOIG7knOrJYT3V51QhYVrHu14ig8hp4wXT9Ybu09R6T72Z/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(1076003)(5660300002)(38350700005)(7416002)(26005)(4326008)(8676002)(8936002)(2906002)(86362001)(83380400001)(478600001)(6506007)(966005)(52116002)(45080400002)(6512007)(66476007)(6666004)(2616005)(6486002)(36756003)(66556008)(66946007)(316002)(110136005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BH3DqpHaVc0e4N8LclasmiHmnDyKzbFs0Wn7ro0xrUly/+lX9ZREsvE5oErx?=
 =?us-ascii?Q?IbOPaPEpsx0sG6IzfIBRPEbEcjdkS6bwtw1OiGHYmglGr3Q5xQrjRdkjhNEr?=
 =?us-ascii?Q?ayf5aNIkIaSe/EHNfeOccDfy3Fh/mg/++bj9eqcJ/ZCpDJzYnbuTRXwMYbJe?=
 =?us-ascii?Q?X7RXqemzE2RmOBxFv0UdhXNhFu46P9yWSsd18DZQyFB/TtaQNq3E86yLgaTL?=
 =?us-ascii?Q?UnfHLphiat+PT3VNz4XzvWkhluG9UJ0jkSDl6tC9XdjG4dvXvryyODH3U4lI?=
 =?us-ascii?Q?pXQMuvFROc7yLx0LIjqjAL+1NE/WNT5uXGKItaQfJIth4e9TJUSpei4sIRgW?=
 =?us-ascii?Q?+8KBKk3tgl747cK0SvMGi0iz1quxXkDqIPinhjODjFgOgjlFA+wFXdEKo4q1?=
 =?us-ascii?Q?OW8QBAO+cOfkW6X7Y8Doyifu9o1W9imz7yc6jiNEoAvOMoYOt5bSrxnPt6Ad?=
 =?us-ascii?Q?WSObGQvRy+zRY0s2z4X/G2bY5TDNCTkkPb0Ln+yIaj5dUC8z2j2XnGEkGHw9?=
 =?us-ascii?Q?Ldafk0N2g04n/SjfYaGa3wp+obmrBboRPj2MxyvCKP+m//QYem33nAs2t/o4?=
 =?us-ascii?Q?tNlw0XRCUKCwelMby03AyWLQI8hxhnXmlIGK59BKzS+5x6R46eeebkoWaCFX?=
 =?us-ascii?Q?X6sdr2T9FdRxAn+Ha978R5fLHkIOM55zGfUHEulhyFPL1JAZcA64m5K92iTm?=
 =?us-ascii?Q?TawIf8WSHxJjqTB3wSR0dPZI808Xi4wsszLnLCy2+EbpJqrTo2C6p4pusX7e?=
 =?us-ascii?Q?x6komWVda1GKlSRLkpTph0G4Y2X6ffMTMOva8oogNM0oajIKGvEjY1ih+Ulw?=
 =?us-ascii?Q?TAI+5mdQn31q9Jg4ucYCpCrAf5Ebwd74sKDRHzct+D50V3LI+vbUG9jzG8FP?=
 =?us-ascii?Q?dOCLXmzEWK1C9ZIbEOFh/elS+MPtHvYn4hSaqjswNoE2HUsd0+FQxseYM86g?=
 =?us-ascii?Q?IuENq6OGCLZKEmt/p6JUBuisA0XOoWiwsDNi1SPgx97U4WQRVZtP0ALFQtXY?=
 =?us-ascii?Q?uuYT1+Ul9BUszZ0YuajYeLOfiC2TFCrwIAp1INQE7BBEk4J5tnBv1cql+sdH?=
 =?us-ascii?Q?UdxVx8k79gQ2DuOV4cI12NOkTEsFrZiKFTxBPqSHTuABX8RXDMe+tQZ25ZIo?=
 =?us-ascii?Q?SVnsvu5IWG7kPUIufXb3pbutK6pJfqrfbbPaUmjHpBgTnhbD9mITXVT5jdgv?=
 =?us-ascii?Q?Jgi9d6Ub9VkA12ZnHTNIXKbeXczJqyGwRQoKpYRaMP1kaXU+huA2N9hhFri7?=
 =?us-ascii?Q?2mIHusDjtYVlojdP+OebduR3e+pD0U1FSGJRFykZpzKLJDrBI4HVeJeU5Hvd?=
 =?us-ascii?Q?WQauPbfhMACFMLnkxXYkFgHtiWujro814JuKhJWa1vdRbdSThoBvTgyg9ewW?=
 =?us-ascii?Q?dlhN5h4S72Y6FlaDo1lBRE5fXaKjWFgAR1bxLm7BsoUex5HQgJSWow2+W72r?=
 =?us-ascii?Q?QhZ4QEqaW6ltZMkz65FcUgopdL2Hyrsl8gez121WBc8xvpdS+kfhNxEJWbSz?=
 =?us-ascii?Q?iCg6I9jS0a4ent/v2cuKalSZDMprbkCUis7DesHmcylqI49340q7dBcN0cN5?=
 =?us-ascii?Q?+J3b0ycIJQ8HogacXPew+e+DeMEdLj9HagLIk0RT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa251c2-5905-4676-28d5-08dc19360b98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 21:31:49.5361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hmicvz5S5DZiGHZfM3dYc+urNTMsYiK13r14fXl+DbIN2wCSs4FAwVj08t+q+lyer0b3J0LwRCCe9a3HqPkUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8795

From: Ran Wang <ran.wang_1@nxp.com>

When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
(or its control signal) will be turned on immediately on related Root Hub
ports. Then, the VBUS is turned off for a little while(15us) when do xhci
reset (conducted by xhci driver) and back to normal finally, we can
observe a negative glitch of related signal happen.

This VBUS glitch might cause some USB devices enumeration fail if kernel
boot with them connected. Such as LS1012AFWRY/LS1043ARDB/LX2160AQDS
/LS1088ARDB with Kingston 16GB USB2.0/Kingston USB3.0/JetFlash Transcend
4GB USB2.0 drives. The fail cases include enumerated as full-speed device
or report wrong device descriptor, etc.

One SW workaround which can fix this is by programing all xhci PORTSC[PP]
to 0 to turn off VBUS immediately after setting host mode in DWC3 driver
(per signal measurement result, it will be too late to do it in
xhci-plat.c or xhci.c). Then, after xhci reset complete in xhci driver,
PORTSC[PP]s' value will back to 1 automatically and VBUS on at that time,
no glitch happen and normal enumeration process has no impact.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Last review at June 06, 2019. Fixed all review comments and sent again.
    
    https://lore.kernel.org/linux-kernel/AM5PR0402MB2865979E26017BC5937DBBA5F1170@AM5PR0402MB2865.eurprd04.prod.outlook.com/

 drivers/usb/dwc3/core.c |  2 ++
 drivers/usb/dwc3/core.h |  2 ++
 drivers/usb/dwc3/host.c | 46 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c00014..a57adf0c11dd1 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1626,6 +1626,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->host_vbus_glitches = device_property_read_bool(dev, "snps,host-vbus-glitches");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e3eea965e57bf..0269bacbbf6bd 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1135,6 +1135,7 @@ struct dwc3_scratchpad_array {
  * @dis_split_quirk: set to disable split boundary.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
+ * @host_vbus_glitches: set to avoid vbus glitch during xhci reset.
  * @imod_interval: set the interrupt moderation interval in 250ns
  *			increments or 0 to disable.
  * @max_cfg_eps: current max number of IN eps used across all USB configs.
@@ -1353,6 +1354,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
 
 	unsigned		dis_metastability_quirk:1;
+	unsigned		host_vbus_glitches:1;
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe5bb783..af8903ee37c20 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../host/xhci.h"
 #include "core.h"
 
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
@@ -28,6 +29,44 @@ static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 		dwc->xhci_resources[1].name = name;
 }
 
+#define XHCI_HCSPARAMS1		0x4
+#define XHCI_PORTSC_BASE	0x400
+
+/*
+ * dwc3_power_off_all_roothub_ports - Power off all Root hub ports
+ * @dwc3: Pointer to our controller context structure
+ */
+static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
+{
+	int i, port_num;
+	u32 reg, op_regs_base, offset;
+	void __iomem *xhci_regs;
+
+	/* xhci regs is not mapped yet, do it temperary here */
+	if (dwc->xhci_resources[0].start) {
+		xhci_regs = ioremap(dwc->xhci_resources[0].start,
+				DWC3_XHCI_REGS_END);
+		if (IS_ERR(xhci_regs)) {
+			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
+			return;
+		}
+
+		op_regs_base = HC_LENGTH(readl(xhci_regs));
+		reg = readl(xhci_regs + XHCI_HCSPARAMS1);
+		port_num = HCS_MAX_PORTS(reg);
+
+		for (i = 1; i <= port_num; i++) {
+			offset = op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
+			reg = readl(xhci_regs + offset);
+			reg &= ~PORT_POWER;
+			writel(reg, xhci_regs + offset);
+		}
+
+		iounmap(xhci_regs);
+	} else
+		dev_err(dwc->dev, "xhci base reg invalid\n");
+}
+
 static int dwc3_host_get_irq(struct dwc3 *dwc)
 {
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
@@ -66,6 +105,13 @@ int dwc3_host_init(struct dwc3 *dwc)
 	int			ret, irq;
 	int			prop_idx = 0;
 
+	/*
+	 * We have to power off all Root hub ports immediately after DWC3 set
+	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->host_vbus_glitches)
+		dwc3_power_off_all_roothub_ports(dwc);
+
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)
 		return irq;
-- 
2.34.1


