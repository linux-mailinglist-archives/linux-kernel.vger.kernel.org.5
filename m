Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA971752120
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjGMMUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbjGMMUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:20:01 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AA62D49;
        Thu, 13 Jul 2023 05:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z60wVrX3qFpvvnFsymNPA8f2rXxXQnqmCVR4ZCYNIAjRJie/p1iAl1x2LP8JHo2BrNVBX2AqDJ2036P5WCcAfEH0OdeZtY5MSuAiAnd3Qn2cFwRWkKS/JrMhWTmx6+VJdKyxi/rf5E9qtwWsjl/5YtDiIFjXRxQjcP2qjI+9bX18yUBdfndP2dberZsUgKeEA4jeCb0xWx6aipJEg2JUaZsoEQ0/ni39zydyrK2jX/0OPCkMx1DbKho2+1iAjj9yFBKBALOlB2VOkne8D0IEfXpsHNdvNqAPr877Bfa0zptI+oX+8v9OI40NCBzJds7VGXY9Vmjnd2dPBagf4rj1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZN3LC1u84wbWSCmba9zZEM9FLZr7JSy2wnRUwg4LxQ=;
 b=hDE0eyEfquQHFN0K4dJTKpO0XdYY5KL6OEbIZli8sF8aya/8MWxU3CERB7DnKrhyDVkydImPpbUwe3w0onCnmw2tKoNFH+L0SvpW8enE3HzlrEPHwfG+XzXkwNwc9QiK8ERKhQ5T+nqk4tM6xqmEgIuBvLHdA9R2wQkX4tvYPUAogfeyd3DQ/Z6KhN1fKAV8R2aariNH/h2ejcKwtfOQUi7hTQpweuHrLLBJVeF3vJhY1km9YY0/7ZAE2XjxocnZVOs9tRu3fsZ2OIdqS7YJPrDaBUJHHU4d3LfuQJLMF+QpQhpty2d/ERHC5O3hJ/UV4SlqZjX6XyBquJXs8guvmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZN3LC1u84wbWSCmba9zZEM9FLZr7JSy2wnRUwg4LxQ=;
 b=rU8wCBTxhHxI9Pb0ei+GXi7gqKjud8uvUr5zLZ1QgXJrPO0qw7b5dOVLq9dEzlHCNaHwp0ALR4dU3Dml69ubMKKnEyi77FHzwZde54LQXYmspuz+9P9zc52NVrk6TLOERXxNPy1gtAdHpXpRqyOZjIoRAXDgJEIZAJKxZPN/Y0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:41 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:41 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 07/10] net: fec: delete fec_ptp_disable_hwts()
Date:   Thu, 13 Jul 2023 15:19:04 +0300
Message-Id: <20230713121907.3249291-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DBBPR04MB8010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aa13af7-6970-4802-a018-08db839b6f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7uUtpWorxFa8hby1Y9VsDSlsvoiqWIH98vRX8FLyhyBDHOmrWLDpCMZt+l54D/n339ZmdFFWAJh6Zeyh6WcLGjFIqVnkMtT+wh8KeaUugaHeFkPTjoNJR2TfWa9eD9wpqAeWbO6iSVO958jSocYH9nu7+kC8q/6wBVC/Z2/uhzbpVzmV093gZxWVKK0it7shNTGv80+cBrIbT9SbV1J6E+wSqVpO7sT/wWelH8FZ3o2wyxEPelvIFanxqOza6cKoWPENW9Sy+l5B88nS3zu5q3+v020ggZXVpMYyRBevSV3aH2YgO8XY2+udv8vpJpAlEocy/mMeSk8QEAzulEQr/HSZ6vJKf4l8UiEqMry657oiDqsLvQCx/wEL+deIevVoilxIGDOa+KDImFTqKsB2auoj+Tj2462VgZ3Mht9HdRUZoI+GiggIL3l462FO50anwrwj0mdhyrmMyG3cw998fuGZP9LP92J8xjJOTuj4SS7AmhsjUQD9FyWZCTcgv/6AXUFcp/0ZuJzNDZENAvhrKJ01zSUN8CtmDDdXOJ2Hxoraxi+RQzCKLIKSRKSHYewafB+yvL9qdrsicsHLrg+D/iqaA50Y33HoxTVOsHTCM82XWI5kuu/YgO+Z234vqMH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5JjBa29qsf58ncpZe/tDQqwh8pnYYjItFE+RNXqy2Ha/DMLQNHF7gAPa2R+?=
 =?us-ascii?Q?JzoInO1vONNvcUTfSOSL73uYFo+wX2GF/f9lNc2U72Na8kqGjD7WCAd5AzA/?=
 =?us-ascii?Q?T3rMmRresUrw1GwDwR32MYcPapJa4AQX/4+HgV3ZE2wqD5G1D5NY92ZUy2Od?=
 =?us-ascii?Q?bQkK72OdRhKLsZcjFl2zP8JqJuDsO3Iyjsli5pr13s/D67UTIqi+qZTEmOBj?=
 =?us-ascii?Q?LC3ePvXu1k+PrFBnBf3S7bZF+IjcsdLdOMBKWPyGwRdCzut91m8ZYzZS4JkY?=
 =?us-ascii?Q?7NDma2sSogPGr2PqWg41MTz1bPK1aHQTVTNZHT5n3KTzVct+umu+roPNA6jW?=
 =?us-ascii?Q?ZWR7tofcic3BQ+tJ/ReVTi2dXPBnhKilM3x+aBRq00Hk8Zj7gH24p0cdb/Cy?=
 =?us-ascii?Q?TbVrPsDEv2QpuNSgH71rDzNoL36sCU1A3/TMDkG9r+3Ur7O8JLQ3mF7sVN+E?=
 =?us-ascii?Q?AI7g99LIr9rkyv3QNE45UToEdIHc67kz3in2OzqnZhr7LDLwha0xLd/9QBYu?=
 =?us-ascii?Q?Y5dLqh9itYvqpnR8dNvBynHoVtgp5e4oluSEY9bbhDr2aVQ5mr+48zkroY++?=
 =?us-ascii?Q?wX0e1iJ09HduPPWjNl8nGuRgc4sJcW9hFqldMpdHnV/Jua7xgF0NEppTWd3Y?=
 =?us-ascii?Q?tBQgXR6fC2kktT4jqDCnBL5UpT6dAUgCIuXvmTVWI5cBBv7bb77bJeZwvJzK?=
 =?us-ascii?Q?8eNR+BCQSjldWSdStt7sgl3cN7fCRJke+1MFT/GT1HAMEcnuxnJvEyVdgZf/?=
 =?us-ascii?Q?gmSMSpV+5nEjRzVBoObCLqfmzw4PujaThHnuGdYQbL2EDZlisRpU86skplV3?=
 =?us-ascii?Q?VaSTlpgI7R21S147zdt7YwqAhjD5Rg47EGJrQTtrH6D5bWLRHE1fCONmB89Z?=
 =?us-ascii?Q?M15Yq8s+vnLw2bhdTmejDU6+3dxkVd8ssxIbWS32mO4Vl9Ah0VOeu9zy3lqm?=
 =?us-ascii?Q?oK4/Dm2SXOMKzVIDjVm4KbdE17T9EdSIPIm/dU4PICrEKAmAAzB2Tn2uZO9V?=
 =?us-ascii?Q?FwW3qzzUmbxBiVYJJrJ3ZfI1tOJQVwb4V3ez+9Ot+Y1Z3Ldhg6Fcwlx/VNcC?=
 =?us-ascii?Q?rPgBaHVOiqGnyHPKAR/UJxfBBOIwUuCEEZsdFXypaCAcQY5yYgfWLjVh4BeA?=
 =?us-ascii?Q?KrZQjOMVJArjGa0hA19X75J2MvMSBv0hbnplurbP0/R5ez1YF/gUKmu2cvLw?=
 =?us-ascii?Q?cDM6+LtCAAQoiGJSMs8wUzreEwukWTqNXHsAPEbNSPd4yIc+VsG/ylbPkFgM?=
 =?us-ascii?Q?sjMrK16HISt/UoWCbBf+GUg67KzLy53qY6uwos0yR+cHLSb0agf6omNqaSv7?=
 =?us-ascii?Q?l1QtU4IWtiUc2JDZ+T0sinmpdv8dFYOwkgKFFd3EuH5jWF0q60fQ1iHtejPZ?=
 =?us-ascii?Q?1dKqoucZUO9DD+RsFqsz+TzI5yweXgWwRrXOV0yArnerlvQg8g7KWfOvEksz?=
 =?us-ascii?Q?UucQtP1kZIUq0UPmX/od8tauYAd/o6i2pyRXTGU46bg8HKGmTs+3X3m5YFcP?=
 =?us-ascii?Q?0DdN1QYkRPW4QTAz9i3qAELvS7WR6Q2fRdop5/VtIQZe2bgrAI96x87JjJqH?=
 =?us-ascii?Q?ZBECVL8/IsYTvatLQ4ezxisIp8l0H2XkVZIqQKob66Ndzga6ywUOH7bNktUi?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aa13af7-6970-4802-a018-08db839b6f86
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:41.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvTheOHjBPRlKT4zN0iv0xJbncTRtjBVQL+m0qolAYvylJ5t5ivHOsfuozLzuYrqo5Uo0ugXwDHpishDffO75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 340746398b67 ("net: fec: fix hardware time stamping by external
devices") was overly cautious with calling fec_ptp_disable_hwts() when
cmd == SIOCSHWTSTAMP and use_fec_hwts == false, because use_fec_hwts is
based on a runtime invariant (phy_has_hwtstamp()). Thus, if use_fec_hwts
is false, then fep->hwts_tx_en and fep->hwts_rx_en cannot be changed at
runtime; their values depend on the initial memory allocation, which
already sets them to zeroes.

If the core will ever gain support for switching timestamping layers,
it will arrange for a more organized calling convention and disable
timestamping in the previous layer as a first step. This means that the
code in the FEC driver is not necessary in any case.

The purpose of this change is to arrange the phy_has_hwtstamp() code in
a way in which it can be refactored away into generic logic.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c |  5 +----
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 ------------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index d4ae0e7c0a44..e273129d44c9 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -690,7 +690,6 @@ struct fec_enet_private {
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
-void fec_ptp_disable_hwts(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack);
 void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c0b68fc3ec8b..08744e8164e3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3878,11 +3878,8 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
 
-	if (phy_has_hwtstamp(phydev)) {
-		fec_ptp_disable_hwts(ndev);
-
+	if (phy_has_hwtstamp(phydev))
 		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
-	}
 
 	if (!fep->bufdesc_ex)
 		return -EOPNOTSUPP;
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 3f53b8ae57dd..55cf98557e02 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -606,18 +606,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	}
 }
 
-/**
- * fec_ptp_disable_hwts - disable hardware time stamping
- * @ndev: pointer to net_device
- */
-void fec_ptp_disable_hwts(struct net_device *ndev)
-{
-	struct fec_enet_private *fep = netdev_priv(ndev);
-
-	fep->hwts_tx_en = 0;
-	fep->hwts_rx_en = 0;
-}
-
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack)
 {
-- 
2.34.1

