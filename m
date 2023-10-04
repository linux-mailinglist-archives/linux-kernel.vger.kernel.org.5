Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD227B7E08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242249AbjJDLRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbjJDLRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:17:39 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E562D8;
        Wed,  4 Oct 2023 04:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guD++ZG4zWg4OaiR7f5LT2tuDJ6vITr/Ng6ep3BldLAdHeJ3AEOAg+c1MSuImUfOyAiDvIeftMrVLqAdaruPyUGl3vT5Ls4bdebupz47AYycb61ssphOkygyiQeh7s/EbDbBIaAecmC1JKODKRUnFXgJZNWNI5GCWOOgq4L73EQ1WlLChqj8LcHs0wp/xC6uZL9xcAgqLOi0ZmBcTCOM8XrBGiaaF0HYFMf63fHwFKmqrrydvpwCf9TXAyd96ucHoTWPF25ZfCEDIwDpP7vwPDwNM7x+Ng5uh94dxM/QoChDLtrbgMrqdVryTLJZYT//SZf6YPUC9981J5ykMk6Grw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfBpsr5loHx0M3PWrCkscibuUZoXkmjr3n85GaOmIIU=;
 b=QR6UAWQrZrn5hN5Y9XJC12E+wIr6txSAvSXF4YDu0tUHE5ViXheYIDqGiCqFJsAOngZejDH4f+vGiKcPfxoE0rFDbcEMfZW5qKOJbM6Qhq8gQRaRFT6G1VqEa0AiL1Tf5FO5GJElnTvogalfyJ5nUvvlTz8/VfdoFYjQBpPlTkuoEz+fssxERjhnUu1veofG7JGqQSXnIebvXxDGHFDs54FmRUf6yYOBImr2Ct5hMVA0fa/aGeNijTP9qnsF4Z2EIvC7H/Y6GcFCI8r+et0+IvbiQc0GHvOsvy0hs3GDVAzGxmKpRo5aCTqmtGWSdBh6iJZyn8NmZw9mVCervUzmHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfBpsr5loHx0M3PWrCkscibuUZoXkmjr3n85GaOmIIU=;
 b=L+xyG6wSdpDJy8sixlUai2zkhZjWMj6JjI+Kkvbft3w005A7T1J7KLRzP92RWQLKyHULHOaWzK/wXWdffX8gQzmqQFVzkZ1P4jkhiGEuM2E53CSD4Ex1rsXwKBkJ2m56YeXsq5kONxppg+zT1qNrrovwJ/eXH9Q+X8cOIDE74nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.36; Wed, 4 Oct
 2023 11:17:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 11:17:24 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared registers
Date:   Wed,  4 Oct 2023 14:17:08 +0300
Message-Id: <20231004111708.3598832-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
References: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 347fb13a-3dce-4112-f465-08dbc4cb7c25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iqx81h1ug1viH2sz2NnGpCNh+45c5nYFV0HaPYmuG7cxfsGiwx7MdGbvaZgJzrmL1+Ah+bE+Wiq0WuT0n9Wfl2hURCMbF42VRJrGPPiC+Fy/lACyknWcHPQcsuacVG0s+V5HS/LmB7V20hzWQg8BZ/EjogHDHGUoFblATrecJuiaftQQ9jo0ibVr8pEPLkIGHWaGQ1JK50vSp2Lz+86tadX5KmcmKl5lUmWh+rIjN2M6suF6qZR0o8SU8JExBCmuFiPnC7x5S30uG2z4ZfgNy6LNnv47Omjfl0HlEyE7UdZUgxseT6vNI3a1g96tAtJWPLkBS2g+VaUKVbg1Qqdk41tgtJGbj7uUFMTM45DPDoz2ErVOKDoKZTR7TvnkcSWP1EhsdoqcWCDrF4APNddP/z5X4nfrAe/RWx9oxNvcdmSMeqWiyjUCZgMeOqnpwLYf9Duqipc8ZdNGVKWomWdz8dzpyb2txEwrzFfd3VCgnZNsrR0gLZXsvnQowHld2EMeULhUxJ/heL+x6i0SHzDZQwjwDBfDZ1WQEC73zL0UUJBEdgMuhFvPweWehYAZHCeORn0Qa2H2emFLs/cAF+tG/EZG0huKTFgP/3aDBniS/VLrEK7F+KcxW0OEJhi03Nw1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(66556008)(66476007)(54906003)(66946007)(2616005)(1076003)(26005)(83380400001)(6512007)(52116002)(6666004)(38350700002)(38100700002)(86362001)(36756003)(478600001)(6486002)(6506007)(2906002)(41300700001)(8676002)(8936002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vK0tRTwR4ZAvrXjdv1oHJMcwWuNW7EFV9SjYWiMhiIQNLNDUETmSyEpLxbY+?=
 =?us-ascii?Q?DujT7DMIrpaycxEpv5Rn3Fj0Qr+AbYh6QBJSOfngXn9NlGpHg5OkbVUGtk1z?=
 =?us-ascii?Q?m/azMzQqcoyACVzCSfBVZYYK6OTZePydk+F2wdEq+qxyag5UAfgIsHlMx3r9?=
 =?us-ascii?Q?X/4HoO3etOm2JX9ImU9zMmyfRJE3PSQchSDk/VAXaDO5DVMY0j5z+yw/rBbN?=
 =?us-ascii?Q?Hs0u2jiopTu5TZqgIuz5sbAr08l7xieXcafKf1IP5i4dzfmEd8grcmtQXZl7?=
 =?us-ascii?Q?rVZnvrce5MifDu3R7ReB2oyVjWfDUhKPwJCnk6+7e0MR528eJTkwKOXq0geb?=
 =?us-ascii?Q?CFHgcJ9Sg9znybSj8XtcABoN+80PbLNP1FkEbC2AdmFkpBhDagLbstKv1etj?=
 =?us-ascii?Q?JCAh9I+TEX77ExwiNGk7LCvfRrujU+uckP9g3VCHyKvfU0oruSOU/7xaZ7zj?=
 =?us-ascii?Q?SdbnEDHUZ1sp6sE7KT+tiT5xLG/LApONxMpx/zNC0YUlSR6FN4z2P0ZZQDUb?=
 =?us-ascii?Q?Nrr0WqqhMk7wzjoAXJbuvutyBHLKPg+K0VWlNBciqPdjelYT/LO6fYoB8jaw?=
 =?us-ascii?Q?aFOolzvidOjgt2iENOn1QPwJ4aMXmUZFnRH42TgCaNCXv8mHY9KRneSzkuYu?=
 =?us-ascii?Q?ruMkkXyb94RdplHW6VdEFuKKNKKE63x3ojdjeEiRBvL9Sr+DvW/ukwId12wJ?=
 =?us-ascii?Q?0eDrLjPsRW7i1+rt3DVlgd+te6IOlJlcGL+NYdjJ7BnYTPjz1WT0ADBRXYRz?=
 =?us-ascii?Q?8glRRjA1afdrlU25ye38MBa01o++A962SEk1Rn1Nv7Z7N/SjUCGlqEocrMKn?=
 =?us-ascii?Q?cbcqqvZvUhjDAyeneUI0odc9qcKcf5sJuRLKdlHbZ3/bnbTCltMO7itM9TGp?=
 =?us-ascii?Q?fX/ow1DMfrwdFTfIAXdPViqXtD36roF7RVmr1lStmO4WvNZQBfbJ96lnnHkH?=
 =?us-ascii?Q?/60Ov1e4yiZ5p/GZZ3ala/kPdlZwpX0RvJ1jPtBAcN3cP853sDQA7r9thk3r?=
 =?us-ascii?Q?4P46eCIq27sddRE2+/b52Mw+VzIJf7Vm075J23kX3A2bu63hjOWDwJWmIot/?=
 =?us-ascii?Q?OuGNCMckplQr6q3xsUSz9GpPF3sknefCdlgDcP3jTJX2IfrnrtnZyMP4F0lw?=
 =?us-ascii?Q?VczgZkS6vUFvjTdR+SIFjB/taurtKjXBJW5hdVxp7v+UgPqO4XImZ7TDgQYG?=
 =?us-ascii?Q?Jex3p+qeNbrEeCmbbyqyD38rrIBhXEMr738rAYi6BWP9II5ds06vggr6Q29g?=
 =?us-ascii?Q?Ca9kvhZoMhw39G6LpFdpu52tEG5CYXCB/AaVB3QnmYAmCX8a33tqLcWapma9?=
 =?us-ascii?Q?IpiuYASRo0HW6iFWj8Nxy6QkfYiAgjisYtBjZONAY/CUziArmymYNHCx+KP0?=
 =?us-ascii?Q?xYaGk3qou1RU2+wgF3KFVNZcCo+C8MNyY+x9ZlvzSjrZy0W1KFT+pyJgJk9w?=
 =?us-ascii?Q?QuuaBHZny77F0Zrzww7tSJVRM9gDT5lKWFhCvRptAYsA+ZW4vZYCLlTVc9Mi?=
 =?us-ascii?Q?T3E3SbNcHXL7zkempoaJuj9XMOohsjeLkXBQtmxwAQixOxw6+ewtp5im7u3L?=
 =?us-ascii?Q?qnrbkNHpABoHtDMLZxO/qDxpyMlAdDOSPh93HpdjctlniC6meoBROn1ZD3kW?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347fb13a-3dce-4112-f465-08dbc4cb7c25
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:17:24.4684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/xWOsfdUICK3kxeEoW/JuWDehAXFoS/np6CNfQd2ZmyU6A+kN3P0sgkpt8FpYfx7MdGhiedn/7/TgLE1v9ycQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protocol converter configuration registers PCC8, PCCC, PCCD
(implemented by the driver), as well as others, control protocol
converters from multiple lanes (each represented as a different
struct phy). So, if there are simultaneous calls to phy_set_mode_ext()
to lanes sharing the same PCC register (either for the "old" or for the
"new" protocol), corruption of the values programmed to hardware is
possible, because lynx_28g_rmw() has no locking.

Add a spinlock in the struct lynx_28g_priv shared by all lanes, and take
the global spinlock from the phy_ops :: set_mode() implementation. There
are no other callers which modify PCC registers.

Fixes: 8f73b37cf3fb ("phy: add support for the Layerscape SerDes 28G")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/phy/freescale/phy-fsl-lynx-28g.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index d5385d36735d..e2187767ce00 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -127,6 +127,10 @@ struct lynx_28g_lane {
 struct lynx_28g_priv {
 	void __iomem *base;
 	struct device *dev;
+	/* Serialize concurrent access to registers shared between lanes,
+	 * like PCCn
+	 */
+	spinlock_t pcc_lock;
 	struct lynx_28g_pll pll[LYNX_28G_NUM_PLL];
 	struct lynx_28g_lane lane[LYNX_28G_NUM_LANE];
 
@@ -397,6 +401,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (powered_up)
 		lynx_28g_power_off(phy);
 
+	spin_lock(&priv->pcc_lock);
+
 	switch (submode) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_1000BASEX:
@@ -413,6 +419,8 @@ static int lynx_28g_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	lane->interface = submode;
 
 out:
+	spin_unlock(&priv->pcc_lock);
+
 	/* Power up the lane if necessary */
 	if (powered_up)
 		lynx_28g_power_on(phy);
@@ -596,6 +604,7 @@ static int lynx_28g_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
+	spin_lock_init(&priv->pcc_lock);
 	INIT_DELAYED_WORK(&priv->cdr_check, lynx_28g_cdr_lock_check);
 
 	queue_delayed_work(system_power_efficient_wq, &priv->cdr_check,
-- 
2.34.1

