Return-Path: <linux-kernel+bounces-32205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403D835829
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4587E2820FD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6B939AEA;
	Sun, 21 Jan 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/ISb2s5"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF9F39ACD;
	Sun, 21 Jan 2024 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705875903; cv=fail; b=JtkJ82/nQ6jiNu58n7kWgG3UEl1X3QxIWmriT4eNgAoae9sGUmp89aD+d4Ud6Ss1RHibZ2pOzurJfYHynyX450jHHdtcPTrxch6k+Z5MkIb5HcBjtG65jx6aKmeGvPohVDbmBjJj/9qbEqGFXPkFEefnoHOFwLQQkXo4HcN2M7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705875903; c=relaxed/simple;
	bh=XVV1gSwV1UV1ScFgRL+jni2ulTpDQ7D9i/nGFyLqyAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=trTD7TKn+W0rgrs4NYGgxEZbTs06tv0Bb1oyfmNiqq7uhv6w6k3GLerds/npRMtRkmIWDs7B1o+ArH1nV+fc/rvtLDuW20/5Oz74njitlHjvuZwP8p359fcTv+jFTA218ejSIBkgGZhe7ynuRcnl/8DEx6KANoi4d0SXn6VqgGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m/ISb2s5; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffz62ZuZTocsviF5YRFG0mNS7R+JfA31xnyYrej4uBbFLJltwfuO6U8NDECsKwbPHQmo1uBQKUpujKTotNitfxltORFEba7g/ZTmVrthemeY1C7uMom1h0Odsh1eEJ9nQIj2JfjMZM063TE0UoGe9B5bBmIE2DY/XJcQ0sIAFtSFwe96HY+6ub6RwE66a0OxsfvzJjtHT2WTalV7ohskhscamuOMGKimLEnT7De8CxDI6oO7jmTPAO4N797CrDgC4qctc0n3IoBahQpo/OVzmTLXgZfi8RI3LOewl+m0uKreGQDe9KgzTCXIkrHWJPy35hU8Nm8T7DrWIuW8wGJM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WjEhoaKrfQXQ/3+dXzeqTAvAdn0vYPi9jBmGKxZQCs=;
 b=iw+SGziU5SikRd5cbV/7XRgM32Y0Nf+ZJh+GYLEp9uFfQstg7k+drqpJLHN12qpgy5BmOV4MlTt7oA31WQCQY0P980U8A2DDSreMRKKl2GJyBpl58syeUEtCahrVtdL71o2gtHkHQAgeHOIr/aWtRSgsD1tniUujUcxEt2+pKThOQI1KvOoEMf7+3gEWF0lF4UdxJTsZSGtotczmFIysZN00X0wacOcY6TC3J2VtFSv6ZrKUlJqeatjV5ya+hiRAlRW4meQPIbhn0Nul+dKvGiB4O1/sG4PC+h/Ofs75FjflYTWHNlTlKfr0xnQZmCsutJGPur8pysyaAA7DKckHnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WjEhoaKrfQXQ/3+dXzeqTAvAdn0vYPi9jBmGKxZQCs=;
 b=m/ISb2s5dSJBbnhwa8TH5813rDd1EM1CoHEQYAkgeF5EjASQUtq/sfApe47UTs3hfQ47BznpiEtG9FXKAq6ymE1NSeQMBFCvTFhFnQmORSCTlq5Z83/srvdZOIAd9YX8Uu20swkq9XzKYU1eNohULpBCwqyJl/GJo7SXnGWdnOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9074.eurprd04.prod.outlook.com (2603:10a6:102:227::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Sun, 21 Jan
 2024 22:24:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.031; Sun, 21 Jan 2024
 22:24:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	mathias.nyman@intel.com
Cc: Thinh.Nguyen@synopsys.com,
	balbi@kernel.org,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mark.rutland@arm.com,
	pku.leo@gmail.com,
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com,
	imx@lists.linux.dev
Subject: [PATCH v2 3/3] usb: dwc3: Add workaround for host mode VBUS glitch when boot
Date: Sun, 21 Jan 2024 17:24:28 -0500
Message-Id: <20240121222428.3396428-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121222428.3396428-1-Frank.Li@nxp.com>
References: <20240121222428.3396428-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0063.namprd17.prod.outlook.com
 (2603:10b6:a03:167::40) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b938549-5803-483e-2b05-08dc1acfcd1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XaIwgAakE21eHL/WMoh9wZJ33kO/BYafDY0M2EaCLHKVA76TYsyFBtsLhohdDTD1B7JaDPml+Px7CyIOeaIxIPvlkoouKOPqk2j7ZTMAyxjGDM4ZmB2qW6KDhjqoZzuiAByRb4sr+5TIRLaVZGFpg0gPE8wGajoovdaQNPhjvjESI9RukRcJsof5wpmI/GOArBWf65nvORWlprhX2yVEB/m/2cuHHoxiNshFXyXL5USVtrQ/2k/ndHsxcGOMIkUITCJkQOdiEkw24nBIgHe2LXyNReWXm0WanJtgWBRdt1EZBC0ngYTWcig5O1oNoGJbvFr2Jl6o4WeRfY4r7+kSSznnRT8ZONGSt/aeYNpsHWOgqvoIOyrzOXTviWgXTzVYGVl1RTfjFEY2/qMOP6E9rSF67ZDkFVGwa72GI36ZJB0yzjELSD4v1sNTzZuwog8XOShxUdJK4TnJoMc0ozyKPlxvSfvZXTqX+yebgPFtAjrrDrlGoQhHlJS54KWQ4J+A7tR6i8BAnxtbDIWuhrmL/fDOvlkt+y9H3YaNRYXUpJUGXF5HEkjdInnwZqQfY3FCowLs1xqMdAyi4dccbD+VPvbCe3XJdhkaEp8PvsnNnTan8gkgq+s29rBp8QUvbL0v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(8936002)(4326008)(8676002)(316002)(66556008)(66476007)(66946007)(36756003)(5660300002)(6506007)(6486002)(2906002)(41300700001)(52116002)(7416002)(38100700002)(38350700005)(83380400001)(26005)(1076003)(2616005)(6512007)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B5o11h7AC9ublTvHs7kqJiE+ZjuPInpBeCCpJRALyMRrhFRgrubRH6fb2zmW?=
 =?us-ascii?Q?NxAtbGnaYRFx96TZKgJwsi4k2Lfs06wdwlaMsAlHUSVfDWtFhdRDHFRrGT9v?=
 =?us-ascii?Q?R/6hKxM5wc8w5FooGqeYfXlcoR1SOkqiPFxxuYwz/CrwMHMFf1+kUuJpfV9M?=
 =?us-ascii?Q?UGzEPp+sykS4C/tdqddCn0wpOfTzhrPyY6xJkKQcceJ8X+qxiIhW27PNB/+U?=
 =?us-ascii?Q?xfQAlgZi77kb3V2ORMuH8sWIRmrt92AfJCJin7lffje0fXVPgTituwrwy4MP?=
 =?us-ascii?Q?E/pBfotgpjm1xFVCfvOzm/0U0pdkSF1KmLTbOp61h0INv1Ub/BYeLlv7XfQn?=
 =?us-ascii?Q?cOFXS1xNJ2rT5c4BdmT4Ia8UOdKJxZ7fH3+CO/6ueShbIQKOpDrr1Hl9mBhv?=
 =?us-ascii?Q?cHk9gfbFN+B6J/giRTPYnkQaZRtWOxScD/mGajT4EsZUWH4JJczgoAkwdIQf?=
 =?us-ascii?Q?MFHrTbw/P/JsAxqpKuxNPPt7w4szAqMFHlbSt8N7LNMlfjMjVz2ruDMwUaEI?=
 =?us-ascii?Q?QpXSG/AxbjA7l5ukgrR1SrnzOLSuPO3jc1E1OmJ1ovjZ9KW7/U5HPRm3Jrf/?=
 =?us-ascii?Q?XrTvWA5xujtd69MTwOHZ/z/DKhoyAl6mzjlSsiv6ALHHuOOkwCXFzQ6cy7Io?=
 =?us-ascii?Q?bUVkHcU/EVFb2IduUPByDUd0fTq5eKsufHRcK/N8K5TKs0sZzag72lG8qQ48?=
 =?us-ascii?Q?ksCjBPGajl9t3t35LbBSVWMfoce2hnuNb5yj5sEFM8vhql0S5HWdLSJYdTIN?=
 =?us-ascii?Q?7/q9SVUgVfdrv52yYUijZvCU5Q15R8f1JU+4Mj4O3LwCPdDPkCA+xaBsN73n?=
 =?us-ascii?Q?P9wVBRmT6hh32Tm3GBa8+BCEkRPWy/IGluJa4STruu5rxRXaXVW1we2dgpKT?=
 =?us-ascii?Q?VoBIdaur2yNSrVGMOa2CiT9894/aZbhHJ3BYl5qwfQ4Y45L3M2KGrYtu50mr?=
 =?us-ascii?Q?jMlh6eNA9ohWfY+P9JogcMh/tU+HBm3ahyuu831013d4g2wftc7f/0BF6p7t?=
 =?us-ascii?Q?Tr8esROsNwqUtHCSIYwxqNid5ibkf9B0yxCGcxKdrKIve3cszjUA1VGtfiVp?=
 =?us-ascii?Q?UD4lCMil6cbxIyCFD/6JxY6JdVD8QTvTLp6pM+newqP+Ci5FCasZ05iqJgvY?=
 =?us-ascii?Q?KwRw90kebF5YdwcXPc4436haj0gnLbAwYfXNmPhe/Ar0i8h9l9yNF2slocpM?=
 =?us-ascii?Q?OKfgSDaLTmRrbvMEhrY89yc3HwB7h+Pa+KyVBjpDZpHV176TdZo0Ds8oeMo8?=
 =?us-ascii?Q?hNldthzTO2rcmXMQy1dzgJcDyIiiu1SvVtkYGfAvKlxpwe8rxk10WgsO34ZG?=
 =?us-ascii?Q?t+RvU/bInpUj+CjslCTJJmYAOTqjmPEem0PH6+ThqeG7VcMBY3UU6zctuwA0?=
 =?us-ascii?Q?3xQlMElOSN4ojp9P0zczjgX/lV9WuiiC4+yOaoQ+h2ZM22JAUkimbidUiBkS?=
 =?us-ascii?Q?FHfWZubhtpaf25IdWmOjaehiU44y8t3qal63PMIpyVOg106oZNCQ4omimEwm?=
 =?us-ascii?Q?g1i9TARcqzGkdcTQMz0ZBNCMB5ni8VbCU5kGgvXRZv0eg5uXyoK1qz8MkiZ9?=
 =?us-ascii?Q?UZabRkpTPXfxefdDl50=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b938549-5803-483e-2b05-08dc1acfcd1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 22:24:58.5101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm87IuUU8ol6+LQ0hAKigFNrqdS3XJVu1OzJo/uBpB8sHeknB9PqoQoqFPFZfq9LvC22e6AzP/Rcjw4H4XkqYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9074

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
 drivers/usb/dwc3/core.c |  3 +++
 drivers/usb/dwc3/core.h |  2 ++
 drivers/usb/dwc3/host.c | 48 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c00014..3b68e8e45b8b9 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1626,6 +1626,9 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->dis_split_quirk = device_property_read_bool(dev,
 				"snps,dis-split-quirk");
 
+	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
+				"snps,host-vbus-glitches-quirk");
+
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e3eea965e57bf..df544ec730d22 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1132,6 +1132,7 @@ struct dwc3_scratchpad_array {
  *	2	- No de-emphasis
  *	3	- Reserved
  * @dis_metastability_quirk: set to disable metastability quirk.
+ * @host_vbus_glitches_quirk: set to avoid vbus glitch during xhci reset.
  * @dis_split_quirk: set to disable split boundary.
  * @wakeup_configured: set if the device is configured for remote wakeup.
  * @suspended: set to track suspend event due to U3/L2.
@@ -1353,6 +1354,7 @@ struct dwc3 {
 	unsigned		tx_de_emphasis:2;
 
 	unsigned		dis_metastability_quirk:1;
+	unsigned		host_vbus_glitches_quirk:1;
 
 	unsigned		dis_split_quirk:1;
 	unsigned		async_callbacks:1;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 61f57fe5bb783..ee1ffe1500560 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -11,6 +11,9 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../host/xhci-port.h"
+#include "../host/xhci-ext-caps.h"
+#include "../host/xhci-caps.h"
 #include "core.h"
 
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
@@ -28,6 +31,44 @@ static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
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
+		xhci_regs = ioremap(dwc->xhci_resources[0].start, DWC3_XHCI_REGS_END);
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
+			offset = op_regs_base + XHCI_PORTSC_BASE + 0x10 * (i - 1);
+			reg = readl(xhci_regs + offset);
+			reg &= ~PORT_POWER;
+			writel(reg, xhci_regs + offset);
+		}
+
+		iounmap(xhci_regs);
+	} else {
+		dev_err(dwc->dev, "xhci base reg invalid\n");
+	}
+}
+
 static int dwc3_host_get_irq(struct dwc3 *dwc)
 {
 	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
@@ -66,6 +107,13 @@ int dwc3_host_init(struct dwc3 *dwc)
 	int			ret, irq;
 	int			prop_idx = 0;
 
+	/*
+	 * We have to power off all Root hub ports immediately after DWC3 set
+	 * to host mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->host_vbus_glitches_quirk)
+		dwc3_power_off_all_roothub_ports(dwc);
+
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)
 		return irq;
-- 
2.34.1


