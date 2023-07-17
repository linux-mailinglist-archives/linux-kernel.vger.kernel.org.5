Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B927567F3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjGQP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510951722;
        Mon, 17 Jul 2023 08:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcokrBE9ffOs69vSdszDVg6BsteUKuTr0HC9ddEGNxAkyxjQUhnNQg+vxEK/pBRV/lSxT577wnH5yZL7OisvHRKxC23OhY1azgDWam57f29v7nDZ1cA5060N1qZebFP+gair/Rp6PB3NQ0W6L5lwR9f9Uxe/Re5fzQvQWvsyIWCnxdn3/djOYb74Ct+70o3WA17Nd/PAwZQXhJWFcXC0zxKj16qG7RDOMFdVs7Ntq6r2dY9+t7XPvqjiTsVKbBJDcWhamHhClfuITL7V7r7jgePdqaVZ3Hskg6bIHWCifT4lsswBq7EOxiITwxzr9IEIrLnXteuJrbHb/VsRIX3Q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUAanPRK1diQyomFpVqbG558jdidXyXGrqDt5hijqYI=;
 b=PRdkkUHT7wdPY/9kaD0u7B9hNj3VLdR6IuBDxXLXG3ZWNqnOCYs3eG5dQMkX1cT366BXrZnypALkD16HaaLz01P2DmzYpG/QWc8bDcb1nHZhKAtExdDbUGklr/pwE2a4dCSh8FDrydXYl6E2gOJlrx8/oyg840eqWMHwBFilrxmQsrEBTg19idxwn5NJtRY0lzi/c1DSacOrDUhYcDuPvdVhbTl6oT4qgMsKp5EB0I54puQ5XOegzr8ZMNF+lmFq3kMBH/H4DQ1ez7RVhnaYtyQckiQkAAHCnWgzWJXuBwqNqiqQpA422VtHyB1Qi85bFCw7MIJzUibcShf8XDlEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUAanPRK1diQyomFpVqbG558jdidXyXGrqDt5hijqYI=;
 b=gV2RE3SeVnANpe7wxldeAsdwWqkM+6JByTfg9y6+md0droxCdGa3dt4/mRkION5ArUX7OzyUa2BEcvSyIFU7xwplDIok7eEONK9Inu5qrNZ2U9swuLRCcXidYDZxhycLo7KQm5LPgM2FOPbrpBWy1FTkK+cbT5wznm+1e1Gy4nM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:37 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:37 +0000
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
Subject: [PATCH v8 net-next 07/12] net: fec: delete fec_ptp_disable_hwts()
Date:   Mon, 17 Jul 2023 18:27:04 +0300
Message-Id: <20230717152709.574773-8-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717152709.574773-1-vladimir.oltean@nxp.com>
References: <20230717152709.574773-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd8b566-8493-4446-7818-08db86da5a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XTqS0FQCwkrOdw9ast3MEIuqQbWDJglGoFvhr7tXmBgojLjlxf6FMZW4TpsAtWLVeBoQQVMfllLJO6GOy0WRlh8Irplf/GebBgaDht0NiiCKhEY7dNA2MvToUkBJGAbh+VmSvIzA38BYNIPpRAQ1Yav0sJII/TvbbO9+TTPLPcuGZ1ACguIm4QloG6h8tRwaSJE1OPSUY0/AQvt9Qbiw1M4MLhVTyAj5L9Tocv5npO77n+uyo5OKjtaWVWLMbJuaeBwylGL7vb2/hQm5CSBZwpmsr6tnhrs45kBLWC9k0/elBq0H7Nzv0T1Iszd1CsuFELUxdLLOxJfJEYV6fHU4ql3h1YYdpeRy6tMlf8jO37YOc/JGWyVafkqGY9n0MHtwULyKIPKrXigN0pVHue9vyKR9TReLMtIBXy9LFJAzY8Jz220XZxmrQLPuKi4jNo5twJ7gJaTUehD7QuisnIpziExYfllVe5eBUsgOW21JlaflV6dJorni1/PJIVXRH84M9sTVn6SaBs1aD6m8YuiEOjFBHvyDiFaqKjmANgko1lAURv1fgKUnxIMeyslrhwpR6puD0qlzG6AzN36Ykncd2UgzLF/MapZ32Kz58ExM55Gq+QhU/IyqDcECvmOR3RDk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/9QgzLrGUmi/YWl+P9WdYrZ8Hjf9UszQpnYlqwDfjQgtpmWZudevBtaCAqj?=
 =?us-ascii?Q?5+OEr8nB1Sz6TEDM9EUQ+rFG1Kbqaov0HrXraFQdzs3FVYc5NDD0bttn4Uh7?=
 =?us-ascii?Q?q9xmObmL4qecKgSVz+dTXipMGNecwBorXH9V+MzzjgK4bhW7S7gCIlXLx/iu?=
 =?us-ascii?Q?euvFw1KdmOJxzTzbtFeLWns1a/4h7eWU1Jya0Ey/YLfqjI7m+mWqlr0lJmFt?=
 =?us-ascii?Q?5StVKY6TiLQd1yk3ViTGrx2i41OL6mncJuH85pstUQMDjyVLJ2SmW1TVlDdc?=
 =?us-ascii?Q?dm3zglHEdASBHW32ZEd0pG88i/c3ZKHEpcBzIm/asR97f0kU4IzE6ZI/4Iz2?=
 =?us-ascii?Q?2Qbw/3Cv2MsHSzEkGxm7WIJ2z5masqyOhHttCmCKFyBgWKmyuydHJynInGti?=
 =?us-ascii?Q?ZuWTJkcMQDWRjkh1IaqdehBjmKr3O63U3CNnP7lKrHRCJAvf8ELv7NiQgomr?=
 =?us-ascii?Q?2Ajndnh/6HK9IMBJveg37UU+zuZfGbylT1hqY1LFyehN1eLD0ddQNGvN1f1K?=
 =?us-ascii?Q?datIogh8yUvxLQKKNesH11O3PNdz0Rg2yJm/cOa1Hmh2dxZAyDqZzxkHIsG6?=
 =?us-ascii?Q?VeofPHb5onbyaxRy/Srj/8ItGjpkH20oQJEKjXjSHFOP3u0FoD8DiWk1VQZJ?=
 =?us-ascii?Q?+BqcWMdk8KzmZkCaZHu1ZPjAIZiLGg+v8t62mP9fUDqI5rHzcOs/0vDX7NX6?=
 =?us-ascii?Q?b9pVTX4YKNZe7rKx5D4CpHIPv8Dg50a1jMo7xAX3Mr2O/J/EMq2DCqd1stBo?=
 =?us-ascii?Q?C8eqYHsa8FoGjsP1Bzg0Ar7a3OUeA149pXKKsctCJahsC3N++VQ6UoxjP1qK?=
 =?us-ascii?Q?VoVlZk35Ym2jRGqZK/PsEUGDsv4akW8Jcsn6MTGXdNN6UEAdRZgtzOWpMgg7?=
 =?us-ascii?Q?Z9Pkd8AR+kEJfQTEHqzbVZxqqAaKo0Qc4Sf2KXuIE1Irdmm7J5Yrmi46+ziN?=
 =?us-ascii?Q?8QA1XlHRLU936XpVcKxm6t2KZgPUdcDFIfbmUmtZWt7vYE+TJULELCWr5BCx?=
 =?us-ascii?Q?AszWsoJVbiFYzQP1GFdo+8IfTRqSC5nJJWK2o+RB5OwG2AqX4msjjDMGi6vA?=
 =?us-ascii?Q?V3sntXiVriFgH7n4sImvwITAnhgcF4BpSv7XxZGno6m3wj0ULxAW+RxxnmOV?=
 =?us-ascii?Q?F5Vq447Z0uDHFyUa06GO3jpWg8nIlHvrIbLL4uYYq8qc4khPXabCl43CN3b+?=
 =?us-ascii?Q?FHWOdQXmMOO8DseR4KV18wKWlPml1KPz/pxxgas8hsBMkGUmHFa3Obtqpt3u?=
 =?us-ascii?Q?7l6UUdCdGMCBPNM4e6GirNcVe0kHB6EkQ6BaTEI2ZRK3Id2mtMlngHlDvTrv?=
 =?us-ascii?Q?+At2jgFB6d8r1BkHZqL/egH3w+uqm51r9su4qNg0L7WQNguhH8PNbDqvuhak?=
 =?us-ascii?Q?laAOfXSr9yIaqydrqLkz4LIuFxTRCspNeQZO8CwPNbqGf541qGe54goGiB0/?=
 =?us-ascii?Q?fYuknHv7fXERqsoMoZcB/396aZfCzV9ZMVoxJWLizRo3yzpH0Ts0v+4slL/w?=
 =?us-ascii?Q?gWFdDEOHJxYeJ1s09HgIImjuNwBJWJfwZrCOVyWWcri6LLJPez+G95xoplGW?=
 =?us-ascii?Q?MC/pjTyS+26s5JOh6pdHKzDsZ3yeWIA3Np3XLYFxDkZAW/8+DQ2W4Zcj9UWb?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd8b566-8493-4446-7818-08db86da5a0f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:37.6726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CWXLF59zHwelOpq5dCsKxkVS08lSY7jD27Nja8vrA994hEvyj/OLh5FEBbnuvVHdImXkK+N/T2zAbDNd0uZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wei Fang <wei.fang@nxp.com>
---
Changes in v8:
- None
Changes in v7:
- Patch is new

 drivers/net/ethernet/freescale/fec.h      |  1 -
 drivers/net/ethernet/freescale/fec_main.c |  5 +----
 drivers/net/ethernet/freescale/fec_ptp.c  | 12 ------------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 5d7b76f0c829..ae356c5c2ba1 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -703,7 +703,6 @@ struct fec_enet_private {
 void fec_ptp_init(struct platform_device *pdev, int irq_idx);
 void fec_ptp_stop(struct platform_device *pdev);
 void fec_ptp_start_cyclecounter(struct net_device *ndev);
-void fec_ptp_disable_hwts(struct net_device *ndev);
 int fec_ptp_set(struct net_device *ndev, struct kernel_hwtstamp_config *config,
 		struct netlink_ext_ack *extack);
 void fec_ptp_get(struct net_device *ndev, struct kernel_hwtstamp_config *config);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c35b569d848a..28c5f8f8106d 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3924,11 +3924,8 @@ static int fec_hwtstamp_set(struct net_device *ndev,
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
index 50943db40f2d..8e64399452ef 100644
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

