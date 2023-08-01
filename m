Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015E76B770
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjHAOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjHAO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145AC2689;
        Tue,  1 Aug 2023 07:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLm1lfLvMFnkrcdwrgx7J7Hd1UgGDkD0Z93qykvXxxMzh010tZ0dkvyyEhsAuhsaQqhCSjh4suJ8ceOEnvzQz0jqhXozoRoVFrXpkEfwmlJop+wZbs/3JTvjTmfbYvD5vGnUsHqKjChQmEmwlh1lYmAbXoRUooYGs1NkorS0lmL32M6pqeIJcEF7/ru8ZmBa4I/V2EzCKl9XFvtPKv/mvV43KdJTugJ26C9Flc13rQF7XhjjvKVl7m0Wt9uVa2dzLqOorTlw6zkYHxxC9Y/eHOF694svz3gYhN1CooLOvETTLSEdSdWh7x5Uw0lwmB739eoh/uCreOIIkupSImZjTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHdO4wO5z3rC5h6mj3wqvqjg01Za8sFP+SQfz+yM254=;
 b=elkoe1rUS+HemI6WWf8lrfVVbbsBjMj/mRJ+Cg/89z/duZO8Xf4R7Nb0fhDb6Qi4pVWYUT3Q6VtkM+zHi1mPrMgRz2ifxHQLFV5C/CPPxgoA5TT8w6VVhJL6iLE/OgevqtNxBus+AU0Vnxef5HjxvfSmctzVrBe332YAVncNSO2FRH6JJl1iGmi9VMRls3uRc2EYMJO56ZbeBjHs+vg3SNIqMAHFp/J9pvPrVAyrU52RfwVtZS1urAjhYvKx1WDi9BpMzLWP53TpIKjzYnrII+ni78KKcL3y6XUqle+hURU+HFtnsMpsY+i6Qi5rryVnhUVxOKikce8c0NVB3GZ7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHdO4wO5z3rC5h6mj3wqvqjg01Za8sFP+SQfz+yM254=;
 b=XDgCTbvY0sGs6sPKUl5wy2C/3O7ImYTQ3qCHuWTjlMj4fTXF6uI1nXzgIKeOsj/cZalpPHM4Sm3DOKSlbgxajJPfMWwrNiJyKutDLjLNn2GziFLP3Q/YUPLrleIM1eXQgv9P14j8npVz39xTH/3dJo0C0TDYjHXDdgx0CGJ2FPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:36 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:36 +0000
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
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 net-next 07/12] net: fec: delete fec_ptp_disable_hwts()
Date:   Tue,  1 Aug 2023 17:28:19 +0300
Message-Id: <20230801142824.1772134-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:208:122::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bf1206-af56-4443-0600-08db929bbb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uv7+fX5n1T2ohnCXMyJ4EUMot45iwRBwmbLl4Jh9iJLqchpWO9gO7HPw9f1qO4kYXenjR1Y4dMv8SJtdJ+IJRrXvzjfekpVSRHe/MfOQLxgU9mCDrnuBBZeY00B0tPV5V2JMGIgPDsirFqB4rsGW+JfR/glUj4rrAL8Zy1hYZmwj73vN+ialNGtIJXfXx3S2wlw6HV5SbDR5jvnrWus/YSH5zmhbNBjanaTGRAWKZoQHOam29EwAMsd7ojx1xWfhNUr1PItCEu3OzGuYX+6/EyQqhb2eR+2v72cyeSZD0guze7Nfq9Wu8HgJTl+MSGkwdie4pw2ZV1sGchyav1QmlcGPHjgpgKKCQrJMTSb3rgQMNUXXPIm0ouwnTuBujdoLJBYdHKI89Tj5CHp6fLnALvBURP0GQf6ulFikCbycf/PHmFt3tE2GUMVl20trtLVosMEz4y4IES2urqXR2tMQfk2eHBqZQMHC5faWMOIkPLpag5yEQcFoIBTouVM/VP+u33VV7UFLHOZ6m/ufos/weqEZKvFbIgFa2X+yHslMWxuVdD7dDBJ82Q7BvAZ1dD68ipyr7QKVye7NNKQOw+ewI24s1vfKmbcnxU/bq/NTx0l5FrVZVelxvGhqbbvkUACg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C8Vtre+t97ZVb5Rzm7Ja39wF1ScFqt7D3AcHnNY5q960zNrt6Z54G9Z4R7zv?=
 =?us-ascii?Q?S5NOHSucDwcYGx2jhscvongH89pK8z6jweC9YZvQiYJFHhYkeIooi45zlE3Y?=
 =?us-ascii?Q?E/o6bUPly302yvGqnYAoNcbsgC78kXyFTr8G4BJWK89psqfIuFNOVanGZL9b?=
 =?us-ascii?Q?m6+yq3dCWwiSGCjdf2/UtzIIGM5uo1eXN7HLfQtoNZP+8vhqU3ehGpo4Ca0l?=
 =?us-ascii?Q?QpII3+UxG3WknGOdGTRjT41UT/cuAdyNhyzgcypLvj+CZHHLfckrQTy4fCkS?=
 =?us-ascii?Q?QYXttGE1/fFJMhhmUbExMoj7/FiFTZYdzFn7MFXMnFaB+wASKyw4uZPkTI0H?=
 =?us-ascii?Q?UqrJehDgzFb9nYIXxf6dtbTmX3s5j9GHDpLSeV3OTx33qjY/Kx4H+dzgragW?=
 =?us-ascii?Q?O/z7Oe+n7eZHNmWRFga9kGy2FPJz+sOo2SAKK8XYsFSmyptGAOQHplPV7p8f?=
 =?us-ascii?Q?egE3PB+NjWGcE479OJRZCo3PVV7nIASJMv39Cfhly0fqVh424yszwRshVohS?=
 =?us-ascii?Q?VHdf6ZqiQPLg3o3UTDnbTcCiB+IAHxqlAhzNmmjlaLO3ZN1DZG5dWpzZANyB?=
 =?us-ascii?Q?G3BlhaMrywM4DL8asrQhlB0z0QEpHi425cwF0KUc/wHzBBFihr28ui/oFab6?=
 =?us-ascii?Q?K3zi30wBkeYUo9iWgyC8Bg8JoZzBtEpzA6NNPHGG0aW8yx6twl+K5w6MwUgE?=
 =?us-ascii?Q?XLhqNYxWO3mIlKvzHDZle7bizL908EZILXr4Ul5sx0Q0wulreK42dwYpm0Hq?=
 =?us-ascii?Q?nxzQtuk6++3DywUY5PitK8peBVunZO+QyvU4WYJOcL+80PmreUHdVsO+cIWI?=
 =?us-ascii?Q?3hARp6nreKe3ckB+LgT8ngPfYrmDoNK8vhck4RW27+VJ7YcTgCb9V1n4j8fi?=
 =?us-ascii?Q?TvwiaItZ6cVBYHG/srCsFQ6cFdLVGIJWDotkF/3IP5S6E8M2ttJ55g5XaXgo?=
 =?us-ascii?Q?2bJMwZ+kfQ5mOFqxR40rhq0lot5Y2QUre9x4oZOXBk9gYq8dVjB8DDGyeZw9?=
 =?us-ascii?Q?Oya4LV49EhGKUxiKLPqgZB+KCFWR+i9fnqSLaGWTxAbagZqauMaVjdqgkYVa?=
 =?us-ascii?Q?+rMplAsvskooaBlPqrZY16UFD0rT64vXuvgnUpuUNvAt1D8QvEpGjFML5l+D?=
 =?us-ascii?Q?g3lMVTiHOOrHgLvGCJiRvPt+hYg2Jc2T6Dn4twP8xRCnKySOtYW6xO6i5S82?=
 =?us-ascii?Q?hcpA3R86DgjrDXHpEvR63bVX9SZWPySH6XevHL2qb1owK+oPhz9dk/DwT6uZ?=
 =?us-ascii?Q?E7UBZsGXc55zAB/TUCuOZyu5z2/heobS0zKoINWXkdQL4jiB9WbTvVFQrK5O?=
 =?us-ascii?Q?pQJrGGYzTivHjZJrfuZ2s8SBCbJsMZ+SHFgz36vDuhOwmVP6rvZ58wqkLbj2?=
 =?us-ascii?Q?Khdv9Z9AzLrrAeNnfqIoNrIxs1LG1bZtZ+jTgyWPz6FK5vjpQJpA6FP1nAmS?=
 =?us-ascii?Q?XomAR1s7fPpJrKZQ4odmyE4Q26hDRl5vXWZ5pgwx4KQ2hcDOa+GFv4IKo1kl?=
 =?us-ascii?Q?ZCrRrEIQi2oDF7rZsaFhNdD6D84J5JKWHDZrdj3QkocDmxQHkG8d0O6PuXOU?=
 =?us-ascii?Q?tI0xGrPR01NkANCSdTg9dwNqJ/T2AvJ1UpMrM6Pb4hNAVASakWl6T9+fEK8P?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bf1206-af56-4443-0600-08db929bbb09
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:36.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmiHE5HrTSoDSfQiI3vytODLkAC6DQtM1Vn+iFS1KVj7Jlb6cYRiXyCAmr4CacsTR0RYT6Bx7mEW8/u4goz+ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
Changes in v8-v9:
- None
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c |  5 +----
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 ------------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index ec64067ca782..110f2e9f3e3f 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -698,7 +698,6 @@ struct fec_enet_private {
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
-void fec_ptp_disable_hwts(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack);
 void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index bbd0cc97905a..6d81fff0227e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3895,11 +3895,8 @@ static int fec_hwtstamp_set(struct net_device *ndev,
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
 
-	if (phy_has_hwtstamp(phydev)) {
-		fec_ptp_disable_hwts(ndev);
-
+	if (phy_has_hwtstamp(phydev))
 		return phy_mii_ioctl(phydev, config->ifr, SIOCSHWTSTAMP);
-	}
 
 	if (!netif_running(ndev))
 		return -EINVAL;
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index befd49b8bd71..181d9bfbee22 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -605,18 +605,6 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
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

