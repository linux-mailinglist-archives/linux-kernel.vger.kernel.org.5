Return-Path: <linux-kernel+bounces-35693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870EF839535
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3BF1C25D21
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6626986AFC;
	Tue, 23 Jan 2024 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P6bPBlxp"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543C186AC7;
	Tue, 23 Jan 2024 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028193; cv=fail; b=V9PkdFi9rR1ODlicV3o685mO3IcDuLhsioe2VXyVjh9pMpRivYcWPDEY086ZFOduV532gZVF1n+9AIwQbUfDSYWJbc6b4+nEnxNbOFIT4vAL9gyGs8fwkZ1EuiGvSTyAOgUNGSQ/Ciw/rMp3nDqXerms7OmTeRNTUw5tELQo2qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028193; c=relaxed/simple;
	bh=ClQflWiWr/3JAWBrONH/PyimVOgNCCN1R7ncz/TKSpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMFiW+KVOrOAwNA+/HclAveaAQLi3IhsZ9RbOIIcBIQvJXp4N34n+DwVyjqcUmALAZfTzecA5UDNKgM/F8yFlgVSfY4p1of2aaRq4wz7K6BwmegJWF/mqlLaUish049bsPdmyzO0+1uDrO0rd/90kASnDFo7i6Xf02246s5Q4Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P6bPBlxp; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjtM3MHRcUTOBrEG+ckt4cZF8tzZRxzqXX1JL3WHI7to72dTDbA9r6zPv3UQKuTaqljsHAiaVnmuCe0KCpVmfGqSlx7fEaYcR+UGt39DwmuwZFkMDM6WU/0JeplY7B20kxZ5bYHc5ytYq54ESYpPYQpVRcE68Omxnh/+VgnaS8nzyhXsBrWipcKdnXH34m2P761xz4QfDW2JgKtqs98tYjfX3Jj2V4EzWgVq5gbn4CvW6A7eKb7TtQfJmcbUpjHGhV56+kqwShio8N4T0fL/7y4sCwbskwvK1Zy5uIWOJmqV6dA3C1WGZOIeeYwbcFgNVwGxl9ulItqcKNJJRW8Log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb/PNUWzHvJLRi4Fvm5d48nIOk2bYdXGoLM6UlH56mI=;
 b=Y0l5ug9MEcf6Nh9HK98720yArkzW5LRqaacNPshFtvs/g5KnZxc35qWPZyCYDc/k0UhVpF99jrnhC3qpDdjRip40kb3Imq+HWPOhhSHmu39niEQvlHMMi6faVHshKZG4yS8FKgkLfrtX4zpxi4p1gz1QxNbXY8EiAEAOlJY3kRY3OSPAWNpTJaJ2/ywB1T81nKehoS8f6p97Em8yjPePCH8aksPmiamwIsca/X0sYOJkxkvQJkTo8937C3WAlXctUWi5H4AM4FkLVmFQhS7s8V8WqnO/k2TccppY1V05B3cjctKjkgC8ujrK6NHaWaxULiCrcoUiyIHFMlxcQxdeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb/PNUWzHvJLRi4Fvm5d48nIOk2bYdXGoLM6UlH56mI=;
 b=P6bPBlxpu24WItgst9ak0C39gvm+fmYaH/4l2NPOVCVA1+1NlB6LeLGxbyv8702SRo3TktXXzFeYiagkPLrX3a+md8sCYb9FvDxqAp3CFaZoea1J+9pridcKK7JkHJFu/FydA3aOTPUTAF8Y3w09I2l7DjhkRWltsGx75H6EYnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 16:43:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:43:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: thinh.nguyen@synopsys.com
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
	ran.wang_1@nxp.com,
	robh+dt@kernel.org,
	sergei.shtylyov@cogentembedded.com
Subject: [PATCH v3 3/3] usb: dwc3: Add workaround for host mode VBUS glitch when boot
Date: Tue, 23 Jan 2024 11:42:41 -0500
Message-Id: <20240123164241.3689109-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123164241.3689109-1-Frank.Li@nxp.com>
References: <20240123164241.3689109-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: da837f37-49a5-47b7-b69b-08dc1c3261eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iIntBQ9kOxUDPUlEV5I3kW9MlyB8yZcYBW86nuJ9W7C8s8XtZEE1WL5VF89jKlXHgrWAftIx3f8XqumhHoMOZokkn/qJ38rHvH4zQ7nQhuQlPbkORSiMfQoiT440qFCljMFEz4BXlPkSEvh9SVWbbLf7o8a4g2lHHMXjH2MUFFCNM4RW+SeTuVSUjc8JZ7Z8XfE6lbNL0m9Nu3Kv7h9n4errlrD+bAXe21l/qGgGfK3ITNS28YD82uQ34AvPO+h9IAS7dWmLVSqgWar06mh0KWyeLkn2VVARRMTGM0xz47XAW9LvjQfh4NRpYCBiBh0Kzxi2cexn8vZY7ajoi/yB4FpcZRzvpfoBpgT8Cxrj5a05plAEOymH2ehqd5Mv8nfp7N6UbcLUPstVF5dvuPDK0b2QpPDnTMgYv6Fd0smnd41dzHB0duW4e30fzy6nzK9t1kHKvcOFiEVKBntRVMaZ8jI0xnHawcc3HEB/TJZNV5Nq4HKaxmXy5Rd8mXP+JTf18MydBU5dbuanQQTYvCgKroIi7+5cmjEPylKYSCWG9ce5Vc4vubJqlqQrUq/NUNtISNqbWIEmeyinfWKzPU63tjw4BhGSq53qA6E19bEz7/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39860400002)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(4326008)(8936002)(8676002)(2906002)(5660300002)(7416002)(41300700001)(38350700005)(2616005)(6666004)(6506007)(52116002)(6512007)(83380400001)(478600001)(45080400002)(1076003)(26005)(966005)(66946007)(316002)(6486002)(66556008)(66476007)(6916009)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WcLvwdnCXiYiMTdSuAJ/21nkzdHIXFHFzQk+a6gLxnOYZF3P0uOTErt3cp0/?=
 =?us-ascii?Q?XpdlPvPyRk8HnBchL5LiiR5nPEe5qFwERNIssmyE6Zl1x0tVyvIdEVZAkYAX?=
 =?us-ascii?Q?45bDt6WwMFckTXpRFxhzr4wMFd3Pr6GFR+/JQ32bboizOcNnhT77zYTKQHPs?=
 =?us-ascii?Q?5RB4RJCFs1cCFWBaoEj/42X60u+90Yc/2i8b/Z8wQ8RlO4LDl+89UiMJ4zxq?=
 =?us-ascii?Q?ThTLCtT/Hivqk4hMBGZTxMUK9K3ydlLvzD274356/awDy9jRvXjr5jGfhmgz?=
 =?us-ascii?Q?9j9thk8/cxxD/+wyxkJGkAN6wvXwSTcBPy4T0BnWaGnE1tFpN2vTJaEPv3r2?=
 =?us-ascii?Q?po7oC0yKckGvBaJU3d0luwYh7MEooiAmaZV48ItROrcU5scn5KKUTKA9seoU?=
 =?us-ascii?Q?21qg5dxkFHgRq8t4tnHvf8865NrhRo8cO5VzjerKjjlskgNToK34525R2wgF?=
 =?us-ascii?Q?7foGixzFIfSjAcqOHACpGH92C8XWPmZPiSVkdGLLB8eS2zq2ShrGnoh6vZF/?=
 =?us-ascii?Q?EittMk0rH6HAdnepxqUX0sCdmwcWp9XRZqB6g57z6PwLgYMOiW//NhFGOmEr?=
 =?us-ascii?Q?u/ELnHLGcRolfXRFPkl71vg8bfS35y0D/4zAk+0w6FtRPSMeQ+biDAwMcexL?=
 =?us-ascii?Q?FXTuvdjlOCN30WhNrygUrXFCC+9b2spPajbnfeBTjysMqAy9H4n5zIO2Yptf?=
 =?us-ascii?Q?GcK906yzQCPQg1tDy/jbbMx5BJrx91Sx8PCyxgpwxX/5F/xeE9F7AwlL73Cj?=
 =?us-ascii?Q?UzI3ZFoqAQ+3tlQC1/V2tOFQSVrWc5ZgBDNYzYkr2VZMRWYGyOxCvBg+r+m8?=
 =?us-ascii?Q?+QRE4u9TuQx529CX6Lra6rZ9N/QV/S7KyqAyVl37voAMied+dF3zts4pktKY?=
 =?us-ascii?Q?EvhxLc5gZemNLwVgoElF9fTqRgiotXGv6VLGpkGRttP074ybrJyEZhL2208C?=
 =?us-ascii?Q?fT2hakOCWkOR3N0Rm8V2oOy/EAftdHO3wxgwSbthYhsrK5cK4L8d7zdy7HQS?=
 =?us-ascii?Q?BIfYzwWsZabcXMtsddWuZdnwWim9VI1mhTTOILfGzU6D2UJsFGbf5LnNYKGy?=
 =?us-ascii?Q?SlTSEoKH9YIlMW8dee5bwCCy9ItfsrQVdlhFZOtZ7vPqrIMmrVy43ni+zyW6?=
 =?us-ascii?Q?KOGUH0LXqZXqn3gorwnrSZvulWKsJ1nSB8h87djZ+1u9TVOHi+7N8O0d3sna?=
 =?us-ascii?Q?4NV5S05kAusWQ1QD4wrNF5x61wWWggazoJf0rG5ziP9KI37WwsjIBHRYNSdw?=
 =?us-ascii?Q?wh1YAMqa+eDI5zMyz9Vui/R1Mlvy03CGVtKjhhCJ/+4FPXB0ltqm5bcTxvK1?=
 =?us-ascii?Q?S0EmYwZPcE+3cCHitX1mNf6bzlAQSouPUZknItkGV15YLHlfHu59l9j2S1jh?=
 =?us-ascii?Q?wYRqHNJfUBol5mhrJ7OMwLgGymq5e+vnqxeiHLDLISBrcj16qORlkrItDreW?=
 =?us-ascii?Q?PXtHazohtesOhhmYsKS3PQe8MmZXGF3ohkRx2T4YB8NbLxr4LTKVLP18IGfb?=
 =?us-ascii?Q?6TBXlspxDGo1IaUpYt86wjBaXFp0UZHixXXGSjZ1DSF4aMf5rihlKaUhOSSr?=
 =?us-ascii?Q?lRwyTJ+XW5WXaLzkWug=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da837f37-49a5-47b7-b69b-08dc1c3261eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:43:09.8964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwp5+wRMQ6UlU9me3JTZLhv/lkr69UNF3gLbh08Th2VaP8xjPEnc05/xNhT//PB1p+Eg5zRxoPvI+AkzC26FOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929

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
    Change from v2 to v3
    - reversed christmas tree
    - please move major change hunk to the top
    - Reword "We have to ..." to "Some platforms need to ... "
    
    Change from v1 to v2:
    - split xhci.h
    Last review at June 06, 2019. Fixed all review comments and sent again.
    
    https://lore.kernel.org/linux-kernel/AM5PR0402MB2865979E26017BC5937DBBA5F1170@AM5PR0402MB2865.eurprd04.prod.outlook.com/

 drivers/usb/dwc3/core.c |  3 +++
 drivers/usb/dwc3/core.h |  2 ++
 drivers/usb/dwc3/host.c | 51 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

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
index 61f57fe5bb783..952d73d05dffa 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -11,8 +11,52 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
+#include "../host/xhci-port.h"
+#include "../host/xhci-ext-caps.h"
+#include "../host/xhci-caps.h"
 #include "core.h"
 
+#define XHCI_HCSPARAMS1		0x4
+#define XHCI_PORTSC_BASE	0x400
+
+/*
+ * dwc3_power_off_all_roothub_ports - Power off all Root hub ports
+ * @dwc3: Pointer to our controller context structure
+ */
+static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
+{
+	void __iomem *xhci_regs;
+	u32 op_regs_base;
+	int port_num;
+	u32 offset;
+	u32 reg;
+	int i;
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
 static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
 					int irq, char *name)
 {
@@ -66,6 +110,13 @@ int dwc3_host_init(struct dwc3 *dwc)
 	int			ret, irq;
 	int			prop_idx = 0;
 
+	/*
+	 * Some platforms need to power off all Root hub ports immediately after DWC3 set to host
+	 * mode to avoid VBUS glitch happen when xhci get reset later.
+	 */
+	if (dwc->host_vbus_glitches_quirk)
+		dwc3_power_off_all_roothub_ports(dwc);
+
 	irq = dwc3_host_get_irq(dwc);
 	if (irq < 0)
 		return irq;
-- 
2.34.1


