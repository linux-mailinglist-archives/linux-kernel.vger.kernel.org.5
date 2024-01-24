Return-Path: <linux-kernel+bounces-37248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B583AD41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA6D1C225E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8D7E58B;
	Wed, 24 Jan 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OT9/Rdsi"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD77CF3C;
	Wed, 24 Jan 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109959; cv=fail; b=uDp+rLyJkZUfDXtmtZauinRnn6CVZvzHbzuxE2+y2gq/CH8IPGw/5dartwzrn13KYZIGlU1K2lwvARLd+q9ldKn63jbozrN0Ttazyn3EtbZrM8hjT9U95ccnN8JqqFNfFdSqQ1kAqV28hrG41zQxZf9ysY0mRDO8xsxWKDAcu78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109959; c=relaxed/simple;
	bh=abDY/yrrV6cszdmoSe7YlOSvUwccd5V8yKBucTZlMs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FaQTFOsZ3wV8+7AALITvVYT4Cn0guX/a/lQFnWe0XmWVrIJijon3wLfrZczx1wlxTgp6h//rLfDNJnmlNezhWPb8Jz/Zq01yjdOn5OOAXYRAZP8woRNRSqfUxsjRxJWX+HGVsoToU8SR1yMTl/e7hHe5jsnETnBzkIl2lNLLunc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OT9/Rdsi; arc=fail smtp.client-ip=40.107.22.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpx6ibOlkWycl95+0bkKfcz3mJIu8dfOVXMiS0g+zD+5xvqDSYx72I6siXIXhITLAUDZF/yxNpeKW35KhDvNSNcJdEih56mGCsVKlJgO4aM8T6To2NRPNsQiNqAjv4FMVVqw/jWCtW8Nirbn1aHmKMx/9Rc74NPGo5aAby3OP3lfZGnOxkrjvFIPdKM632+uwY7qbC0ElNm7W+wQRJwgAFR9BXABqChAt30Ud1lKF3dXyguzQ3dVUQV0/pYk/oFntmuEuTt9l6uMyqrxMFfsG25JZF4Ef5+EDL3JBsDfkGyfa8eikgwOhz5Nh/huPlEHmhYTdhnN+gG6dEs3FGGFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2YNLwFlK/0DlmwVYel/SooaFewXK6BFhZACn8VSamI=;
 b=f54sgrgaWdDSkA+EvXARtP8vPJ1+3LOJN7ph0w+KVQ+EyeNIhFfa5bCfhpSNdker2lqhe8vxokHxhIL2ysSR1uEEmFlh6Jj0qu5lH0tSPIzEL5WQMWtAD1yTZBvw2py6s3JfmjoTSkUSDtOyqf6RC+NW3W8998he+dhyvKTqUa9ee6lQCSuxtVrgEI7junz84kHBcnzp4gvvZastnU6lK8G7THjwAVqCTZS+JQGpwH10qo5C47Z3MiB2rAM56uvwBgl3a0ljD0HDqI2tT3DQzFaIaatdir2Xf7mUPBziNbdhNdZihptkU6OHHtu2WqV3clVQD0rIvKRcv/CmQsHiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2YNLwFlK/0DlmwVYel/SooaFewXK6BFhZACn8VSamI=;
 b=OT9/RdsiQLo53JBhT5e/js0LbO9+bKfoLyeKmu1l1S5RWq7BNTiiAGpKl6WJA3s6Xx0qLaplH+Ec36cSwAFNTF0Heb5EPctRiO5PrEhxrX5t6vVeEa3HGPdz+s31gi3Sn8CO2n6ObrBh0TPKX/uIpFGYXN+g6LGz1NL7tOKG1o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB10001.eurprd04.prod.outlook.com (2603:10a6:800:1d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 15:25:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 15:25:51 +0000
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
Subject: [PATCH v4 3/3] usb: dwc3: Add workaround for host mode VBUS glitch when boot
Date: Wed, 24 Jan 2024 10:25:25 -0500
Message-Id: <20240124152525.3910311-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124152525.3910311-1-Frank.Li@nxp.com>
References: <20240124152525.3910311-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB10001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d266023-b713-45d0-e134-08dc1cf0bfdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y9Xc2U68SxmJWXpzKb/vSdGbquMnEAe3TVDDIkr5kFhB2ozM0p8vJRA926cz7dmZb3ltQRmVTL0kHjbQHFsPyxdISoDSHx4rwF0+7zZuw3+/zOvdAOPZcL7TVoVPm38+ODJ/nBfB2HLEhriWPHTTu0r8KNgH7wosZEFddqRzACdqhMfrfWyKenRFaOKJ9PITrHYgQ6NMN7YOM3CK52iDEFjB4Cbio2Ns9wmsjZUHWDrffON3Qy/DwB2q2Ql659rMpZQzz8PeIRXY79W+98ceNxOvDNlCeE9IqS4p1RkFrp8myIaMCiiHrfFgZTYBt4ziuNl5Id/FFBQ8puTIL2LWvU8H6BUoxLRoP3/kacTNoDAddja1OBn6hSXGNrX/FCSJMGzuPhkjdGQ0E2kgcFt7AhxmAHaqP1csWlxR+k0SjKtnrwjW7Q82cIkgIwo9fQcutFiWA2hwMdXrvTVlEEx0NhXFE7s1eNRwuRHpbl+pmTS2Ab2C427C0YezEDXNg2FBM0L3vAAJrtCbacC0zRvZaPdIl1nR8egfhZXvANCzzmc5Nb09kG/GeeCVJanengatEbq4yU47hRMWyy4XXvoPHr7F1f5JOAdi1ats8ROOBes=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(5660300002)(8936002)(66556008)(66946007)(316002)(66476007)(6916009)(2906002)(38350700005)(36756003)(86362001)(41300700001)(7416002)(45080400002)(38100700002)(52116002)(6506007)(6512007)(6666004)(83380400001)(966005)(26005)(478600001)(6486002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1lXehTAJG+amwUHGzdxT8eqoI5wzi2T3wi1bcOZS6K8NLVbq1htuB6naulRE?=
 =?us-ascii?Q?AB9UASY7sld4iCJ25FWJXb2kLBxUJjBY0U9Iyh8HMZqou1KBCZagIJ8mKbca?=
 =?us-ascii?Q?MCYv3WjIVezSQSVXf1F5S6FKap8AI4Ih2bWugZ8BW6XCW7n14kOLgQe7Vz2C?=
 =?us-ascii?Q?kWi9A173s1pgfMYafV5eYdHsMsVYPYRRHofV/7OGXSFXMkLx1h4aXzEGbhZD?=
 =?us-ascii?Q?63onpp/ze+2f/mM0Iulkb8sLqVhWdK9M4CccLupuXu5abdllhaCfZQfMm2VV?=
 =?us-ascii?Q?H3wX28bP6zBWiPTBBFV9DDbGprC7J/NKOlVnqiTzbUD70jLlqiD7jMWbCLa4?=
 =?us-ascii?Q?iQyu+8hCJ4EtWfZlQUTzt6CDuvjVdXqUefJtnj8bLb/RkU4sqvJXHJ7TZJxH?=
 =?us-ascii?Q?Tr8zLdpKoPBhBedNSHqDYVnL7+UARz3oCyscR7RIpDYItWSVcdyQ/JL2p/qq?=
 =?us-ascii?Q?4aYilWVsT7A7/Fqgu7+Gk0jq5P6wf/z7XKhGCnvfP6McvnVgrKm9IBbxbBAW?=
 =?us-ascii?Q?MmlVxXTnvGQtj2Oay0ZUGz6gcpMiiikaG7E/qH0zf8XNkH/hRGDTnIiazM2+?=
 =?us-ascii?Q?Rhv4MEq1T9Jdnzamrv77tboBnd6OGBlExSgQ9ojhvmfpY6Uxs7XasxA+g4FD?=
 =?us-ascii?Q?kasS1FPiNhAZ31lFTl6J8qcNkdeOigexPi4WmnFuPVCgmzqNT9InODi5PfC1?=
 =?us-ascii?Q?M79M29nnT+flg4CweBUJM1idHY44B1YWMB125h6xAuYGVfhIG0WnrUnXzfBp?=
 =?us-ascii?Q?u2V0q9UYJSp3HYBJPLz2B+DChMAot1F4rNURq59ZQecLxNk6NoZtG/hI2ANa?=
 =?us-ascii?Q?OpX64h1/4qI2tVRVzLrJz3sqj1YABj9kZHx23rInVRMnbtKDBUGcZcEVSUCj?=
 =?us-ascii?Q?eOp378Qzx25Mn5uI9H06dXybcrbUU48Hz2F/gPbmwBM26g0EWiMr7e8eZArp?=
 =?us-ascii?Q?ntAmt6tSumLWqRK8zdU4ZYv+yYOcC0XPuE1PVwdmOPsmPrGqqPjU98/Y7nfO?=
 =?us-ascii?Q?kcAEcd1pkzKqW4v7xQ1PncPpRLUgkWRYr6cqc8gwLK+mWQw+QjVMX6uh06U3?=
 =?us-ascii?Q?49lBRcJgC05RYNCDg2hefLObUD16aOXsos37iQFQduBM0SozBQhibzXKW3Rb?=
 =?us-ascii?Q?KZKOmpOZxS1mlwQMq10422fgGhfavzu+mkAUagPQWA9Xn8zrzAlM0KDgGOam?=
 =?us-ascii?Q?Xfi+GlL7bbHJUmj7vIhPJ55dW6Yw+szqp4uMR0LSdTOGxZ0l+ELpN7HZNFxM?=
 =?us-ascii?Q?PN3gOzL5AW96y/+dg6tW2fgOTCAVceHYvKEmPJ1ZxJ2EqWsI3H/eYgjzyW1E?=
 =?us-ascii?Q?8hlMbSL8lLrXVCuiRAe7tVR38AmSx5HUnOzm5Pi2agVhUwfwDdpo5jFp1Gqk?=
 =?us-ascii?Q?joMZjxMOO49uAgWPznjp70V2Dra4K5C0YW3xMWdaNO7j7yFzoKZcouZpzUR9?=
 =?us-ascii?Q?MgR0eTx8HZOmeNB0ll4jmoVGzVr0c60Y3tp83mu7h3P1POpxYL7jlOy7NJAd?=
 =?us-ascii?Q?Jk7XAjh6jPfGuQ31iY/+pcG87FtY2OZNfRvv2ai51jXQyk5jjdTFB3NAYxYb?=
 =?us-ascii?Q?sJ5GyIC3eLPAPdShPVPYXH5jsrpOdg/FvM10p6u+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d266023-b713-45d0-e134-08dc1cf0bfdd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 15:25:51.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MWDFmdq9WBm7GrrAawHT+KmfP7yyJZ1BNIt5RzdQGi2z/7ZTXppQ5XBSIxCF5S82aO7lvACUU87FNqmokE2qA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10001

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

Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Chang from v3 to v4
    - fix kernel-doc comments.
    - fix ./script/kernel-doc check error.
    - Add Thinh's ACK tag
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
index 61f57fe5bb783..4957b9765dc56 100644
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
+/**
+ * dwc3_power_off_all_roothub_ports - Power off all Root hub ports
+ * @dwc: Pointer to our controller context structure
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


