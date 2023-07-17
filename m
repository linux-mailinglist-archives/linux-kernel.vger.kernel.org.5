Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8265D7567F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGQP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjGQP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CE10DF;
        Mon, 17 Jul 2023 08:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3phavZv7qyw8VfShr+tLn4VUctxbMcW5VaRwDEYUVWKveov17ofBBkS7lCAVSiZQijY98x13kVP12rMZ6QlV6fLRFCaHObeSLwvcI2wkT07lYMxctXGSDEu8ZTozoLqlgaa558Tzgs5Zca68ayxaQE+bpZXIWg2IG0KhExSWK7tDjcaN1cLMgRz7/gOcyYuqkrqnnXqwc2luFfBK63y5yhs0lCKBhVsNQZ8/FA+wt0SHO3wjUTywIOTU6jJzFLIpBVWi1inY2CYDIS9AvuMl6TZsxAosswVK5bufC4stnOJwelrc2NZLRFcgOoxZTJmtOeuwAcI73nKaEqWfjsInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BC0nTl8AHj9lufMrAhgkWMIdvAxRAnDTbH8XIbBzuMc=;
 b=d9gm5vLtKkFMkUoCnTMglITk0UEV4dRZ43/+zfI3FojtJbd0z4zo487DT/cHD+BXhIzAI16hxZwKO+vNN+YuktNjSSr1SR1fjsFp0N11h85f5pByFB4vWhnjdNlqkk06ZnA8gLoufQjyQVO7u/ZSsa4L+7EhZyWLzKjCKAzMj6Fa5ifmpjCpCYxrKWXjrzzg2GMaFLUJdx0MLiaU4/z7LOFU2mcIS9z52mAJ389QqnbwelE/IhDmo8/uZEbXd5qRMO0UdXGGHLqtRAPXngXBGpFk88bXFbtpsLYkb0J2Jlgx8JvfNVdCE9+FdQ7k++jV0nL9qEBYFRoKr1KIOGV7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BC0nTl8AHj9lufMrAhgkWMIdvAxRAnDTbH8XIbBzuMc=;
 b=lET/6FfnYZXPFGyr428cRQNGkw9p3FiuR2/MolO+5cjqLjigs+/1sRyxzVkOlCXH/G6TCa1qtJ6QPEf9gVZg5O4lqXVc8gyCMPL5NlAzEOHsBNDY115tQyMIz7Jp47T9TPYxo2vnzbs6yR/bGHe3jjrhWJ2Chd0tIYg2XLgrsc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:33 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:33 +0000
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
Subject: [PATCH v8 net-next 05/12] net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:02 +0300
Message-Id: <20230717152709.574773-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b73d49b3-1fb6-47d9-b124-08db86da5797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SjyFXwFL8NpWLSDzCtuQltPPgt81QDld9e8chkxivG+sD/dP6NE9YTD16ipEEGoTDgG+mPILCC47XcIQwxjhDlidZH04a9Ps09Birblr7aT0WVC/iz9h+09Qr+w7lHXkcUH295LlzdRlila7w1TGeQrqQr5Ip8Bvfv1qkBfgBEG2uMKoZ0C+UgS5Goibyi/SX0fK8yvTkD6PfmvVevUgS0M1W7Pra0eiwxWouR7kLWbNmUXt36b1O9epPiTd2lYn1fJXEC4EQOQJBuJYAuV30IYkaCruK6PdyX27zgovOH58yhFEzom/qn6oIDA6cCDc8KrldeS0Rd6YipIWPZZnIkq54lILWye1/ZFSw8ZD/y+hkd3rQ1QtPNSJEk5Lnmcb57OD1wxnmFY1FTK6jSzTbdEIEWUDAhGIsEaPaqmGEbQKPBGZ0j7zfh0/IX21B5o9aOrq+v+kmqPvyHS78IOP0ApblTqI7X9ak55Zql0O8Q8J7WPztWsG4yP14kUBknf8xpotkag0O6dH3SqmVimXSKtkz6UrzSeIcojMlZbcD7fkgVKBS3hN5eQ8MZo02wZwbGF6Vq8fCt002PwgBXeuJqPl8naXL707spJMvY9golNvit+ajAWQYHX0UaiTj3H/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PiEEIjZ929Szfc51CioV/4fsPcciz/nzJef0RuFacz9GTWUBw85AfI+mnWPX?=
 =?us-ascii?Q?cqEKWGlKyfoZVFEOrnKoRyLT1T1U8J7d6TEcU03fMnO5jlddFIWpd4WRKg1a?=
 =?us-ascii?Q?Ytundhn83e4E0780MU5LHflesrfOqn3VJgOXG135TNudtnAm/eGT2FhjGlMi?=
 =?us-ascii?Q?5oX5IN5CRcp9sCtR0w/DxbP2ADL2LNBCf0yDbCtQuasAdfwyUZUDl0eUr9Om?=
 =?us-ascii?Q?17lWzZca5c4Ff5i5R7DbSgRH8zBVDti8nhYCfs7tJCE5QD4BJNpTWl2g6LFg?=
 =?us-ascii?Q?lLoVKYPnvD7ejM/SaGCuQ2qIQBctF6przoCloPgmvKTBkTBPDvetaK3RWcJy?=
 =?us-ascii?Q?OxOW3j6uiy4jyV1Yg6hJ8n+KtWSzq6qZDhZI+L+PcFmdnSJSpKn4A+oehwK9?=
 =?us-ascii?Q?QvPFeO0Tbf08KG0OwfghRdUfxgDPY8GzeLvA4M2AN/OXCNcXMEcIKnhcpUnj?=
 =?us-ascii?Q?i/ezlTVjkpxBjztaQAoN7fYOXhWQDQqfmm1It7p8quIbnno3hJnOGdggfOya?=
 =?us-ascii?Q?e+jsNXAx/9+VYxpZNz6Xz23ON3hhYAUAHrXF0cwD/xxUc4nUrj1KDM4av9SN?=
 =?us-ascii?Q?CKqciCZnR9Eah/qbEpZUy2bIk20soTgAkfTMTpghFxYFZbIVzItVAKC8PpDf?=
 =?us-ascii?Q?IkriOOsxA+/BNc2Jriqc1WhWL18umT1FaJF0gh4zdHEbREa80l7hLoliOlbM?=
 =?us-ascii?Q?ZdI4i8cPyATHD90Qf/brs23zeoFQu9HBe0PgqiQkbSymtrJDUHinZJBIPacx?=
 =?us-ascii?Q?GWDsz0rYXdxcTCnNDgsDVYKueSvtu7pk+yv2SKGh5sQX8p3YoiiaPcnglyUS?=
 =?us-ascii?Q?ybq/2fYIkEVnnybiMAoHsgZsLnAKQ/3hIajJfqZsfcsozDbTCYpBAj5Ff4IA?=
 =?us-ascii?Q?dLVWfWFHkgx04jwSQ6d1P1VhNSVly3DnrMujK7Nggr5sznlLhItgDAlSsEwi?=
 =?us-ascii?Q?tG8hlPex14CClGRdqRhEZ3GFsBuDQYyfZcFIowLXCzftxudHjRLR6iGvuxzX?=
 =?us-ascii?Q?JqkY35ReIYI8guzzmYrSERtM8eYvREwfr0LhtUYnL8Ve7e2ovCr9soy9b97w?=
 =?us-ascii?Q?STJAm1zsnQ5R1IPypTJIDv7LqtmOuBnok/o12x+wU0jjZTmDB/f0Oa/DpWe9?=
 =?us-ascii?Q?O07USkYbzK4bOzjuId/lNFZpLgsoGGG+zX+xGjNazcg3k03UhvmXAYLAEShZ?=
 =?us-ascii?Q?TLbMp6nyBPC69JmZumpH33bZ3i/mBWuo2nRaBXWGwssdWYEI9uXquigyY+iB?=
 =?us-ascii?Q?Oo9vIzmhcPhuj+csjSR9X5/zisDpjKR5zoniu1N5idsgJRe7HwfT+y3gGOwp?=
 =?us-ascii?Q?w2HfkZChKGFg7vVK2qu91M11Lq9mRPlhCLMxRxoGXjCbLkXhM6qmxBdsbnvV?=
 =?us-ascii?Q?woM6lSP+XMzOT/wyzQPtImgX1zH5f+iAYoobRM4MNE2HNMfL5BmwyQ6gwzCX?=
 =?us-ascii?Q?KKxXp1e91Wl8HItKnQaz2iSre7BOEG3KLf3uRvQsqmTgg6zZOq9RSkh6oTbM?=
 =?us-ascii?Q?KNHomvgY83OnKx7PCVmhfulRVpkQmDtNc0Jkro4QYFJdoSNDS6JoIi+C29lO?=
 =?us-ascii?Q?exf7YxwuCpZawM1dhON4fOyfqPiZCtYIZVXNFtA3CpMqOaxVb1eDgW8zfJhP?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73d49b3-1fb6-47d9-b124-08db86da5797
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:33.5571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SP+5rQY5WgSp26YhCsDYotR1s+S5ubDg5VkDk/69L1n1iKSh8iQIv0gEXQ41JNdYudQR7XoVrNSDClWWoEvY4w==
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

From: Maxim Georgiev <glipus@gmail.com>

bonding is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in bonding by using the newly introduced helpers
for timestamping through lower devices, that handle both the new and the
old driver API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8:
- None.
Changes in v7:
- Use copied_to_user instead of KERNEL_HWTSTAMP_FLAG_IFR_RESULT
- Reword commit message
Changes in v6:
- Patch title was updated. No code changes.

 drivers/net/bonding/bond_main.c | 105 ++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 40 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7a0f25301f7e..d591992e3eda 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4441,11 +4441,6 @@ static int bond_eth_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cm
 {
 	struct bonding *bond = netdev_priv(bond_dev);
 	struct mii_ioctl_data *mii = NULL;
-	const struct net_device_ops *ops;
-	struct net_device *real_dev;
-	struct hwtstamp_config cfg;
-	struct ifreq ifrr;
-	int res = 0;
 
 	netdev_dbg(bond_dev, "bond_eth_ioctl: cmd=%d\n", cmd);
 
@@ -4472,44 +4467,11 @@ static int bond_eth_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cm
 		}
 
 		break;
-	case SIOCSHWTSTAMP:
-		if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-			return -EFAULT;
-
-		if (!(cfg.flags & HWTSTAMP_FLAG_BONDED_PHC_INDEX))
-			return -EOPNOTSUPP;
-
-		fallthrough;
-	case SIOCGHWTSTAMP:
-		real_dev = bond_option_active_slave_get_rcu(bond);
-		if (!real_dev)
-			return -EOPNOTSUPP;
-
-		strscpy_pad(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
-		ifrr.ifr_ifru = ifr->ifr_ifru;
-
-		ops = real_dev->netdev_ops;
-		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl) {
-			res = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
-			if (res)
-				return res;
-
-			ifr->ifr_ifru = ifrr.ifr_ifru;
-			if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
-				return -EFAULT;
-
-			/* Set the BOND_PHC_INDEX flag to notify user space */
-			cfg.flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
-
-			return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ?
-				-EFAULT : 0;
-		}
-		fallthrough;
 	default:
-		res = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
-	return res;
+	return 0;
 }
 
 static int bond_do_ioctl(struct net_device *bond_dev, struct ifreq *ifr, int cmd)
@@ -5683,6 +5645,67 @@ static u32 bond_mode_bcast_speed(struct slave *slave, u32 speed)
 	return speed;
 }
 
+/* Set the BOND_PHC_INDEX flag to notify user space */
+static int bond_set_phc_index_flag(struct kernel_hwtstamp_config *kernel_cfg)
+{
+	struct ifreq *ifr = kernel_cfg->ifr;
+	struct hwtstamp_config cfg;
+
+	if (kernel_cfg->copied_to_user) {
+		/* Lower device has a legacy implementation */
+		if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
+			return -EFAULT;
+
+		cfg.flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
+		if (copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)))
+			return -EFAULT;
+	} else {
+		kernel_cfg->flags |= HWTSTAMP_FLAG_BONDED_PHC_INDEX;
+	}
+
+	return 0;
+}
+
+static int bond_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *real_dev;
+	int err;
+
+	real_dev = bond_option_active_slave_get_rcu(bond);
+	if (!real_dev)
+		return -EOPNOTSUPP;
+
+	err = generic_hwtstamp_get_lower(real_dev, cfg);
+	if (err)
+		return err;
+
+	return bond_set_phc_index_flag(cfg);
+}
+
+static int bond_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
+{
+	struct bonding *bond = netdev_priv(dev);
+	struct net_device *real_dev;
+	int err;
+
+	if (!(cfg->flags & HWTSTAMP_FLAG_BONDED_PHC_INDEX))
+		return -EOPNOTSUPP;
+
+	real_dev = bond_option_active_slave_get_rcu(bond);
+	if (!real_dev)
+		return -EOPNOTSUPP;
+
+	err = generic_hwtstamp_set_lower(real_dev, cfg, extack);
+	if (err)
+		return err;
+
+	return bond_set_phc_index_flag(cfg);
+}
+
 static int bond_ethtool_get_link_ksettings(struct net_device *bond_dev,
 					   struct ethtool_link_ksettings *cmd)
 {
@@ -5831,6 +5854,8 @@ static const struct net_device_ops bond_netdev_ops = {
 	.ndo_bpf		= bond_xdp,
 	.ndo_xdp_xmit           = bond_xdp_xmit,
 	.ndo_xdp_get_xmit_slave = bond_xdp_get_xmit_slave,
+	.ndo_hwtstamp_get	= bond_hwtstamp_get,
+	.ndo_hwtstamp_set	= bond_hwtstamp_set,
 };
 
 static const struct device_type bond_type = {
-- 
2.34.1

