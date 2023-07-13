Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70375211C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjGMMUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbjGMMT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:59 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FF02727;
        Thu, 13 Jul 2023 05:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADVi/Hni37mzr34iZZTx+WHOOBevXjonOcNxrvt4RSGaVTA3MH8RaqQugMm5HsbztHUDwzg7uEQi2w9PNkCt2Lk+Y6F4euh8tcvOeUTiBL7z6DUNrfGJq25GovdKXU6fbJMTZeKEbvbIxNxT0pAxhAmcn/L0l8MpMooEyLyBQsERg3JKRhIDfnUGAjiwZkQnTqbh1sBEwC5+cD5Vh7yOESIvFCMQweIs+xeXRRPad2unHpENwZbe6tZnn09xeLSs0w+IlxsiGNU+tr5V63kEP9hKJ3Adfxsc1Iiq4J7QkOgBix/N8+H1SRJIOlQSwoMfb6IfYLIXEtKTi0p9CniYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct1I3YYpFbatY6yl7g6JtCHFuKTariKU1KzrtX40v3Q=;
 b=Qm2Gq3OhcRyfmq1URnrLCvyI5rh2DOKfTecD5JWXeg1sRcRGzONGxIOfZtfyffKA/4pYP893cMh5Vj6eYR04Y5DlCft0g8I+AeNRKaFURvXvm3LWvmb8bcCP/J8vJ/FQpxNylxiJtReriw3xf2Fr367MkdrwRg0usTzESPYGxAXLwK3+3LGextN8sriHlPTVwLNmBjcdz5B7WWZl3MmGL2qB9x2xUYoxnBC5/vkJ/HZOrriPURjBrMiEcW3YV7iPuocIZ172XybNJy5AqZSKIAFWI+PF+H9FxeUhLUo8pNgE4BUpZDSNjDcDwdJAprTLbMTZM2NNMPbvEgp+b6A8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct1I3YYpFbatY6yl7g6JtCHFuKTariKU1KzrtX40v3Q=;
 b=FtOHebNJW6oDKUnSmAyW4tt9OqTyMQl/+r1SPnXeIq2cUxeNOxcWKZhKDfVnmwl4HS9w1OuemIHrdKmOBWN5+oK6e0JQkcqPRnzkGgdHgzA732QnG2L8GhfLrDs1swfi4p+ar/RjmjmQNvm77Ik3qcKDqiZmU6+SAn+HpaY2HpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:38 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:38 +0000
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
Subject: [PATCH v7 net-next 05/10] net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:02 +0300
Message-Id: <20230713121907.3249291-6-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 574bb50d-3399-453e-beca-08db839b6d77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: smDJxNsJVzEHw0cnXIkqCqEAQjQz9xaZpiwS0uCfFgqt8i3gmuxuwtqTIvTH9MRrVgzve/IaiSTsKTRs9bIQvMuFmDQxYB0OCCpwdpaeL7ZOkXsR5VbGNCJWYm174KIVTGdohjedR6bzLLc7alt0bW+IlwIi0XS+AGNlydu3d9vw9FdRWLFkMVWepWOrAsLu6srf9omcSStoLDn4NyRAxlQ6erfdimRUM6q6JZBlYF//H7Cle0g/cErmyKLNghA68WnCW9r2fVhemXxIZvMiBt3V9oJbzVqKwjDjUXgV+HV3itvvpJqwhAXkTf2YdaIRtDWKOiqp9PZKgBCZBOIraERrfQu5iHJ22I9NPbWKwO4OBNLl9ldEuVjx0D+fi7ydrE8tCGKBEj0YDsgQYfTM7Pm4ClJ3rI7dEbA0ZI2RNVF8Zlmme9Es9g4XvNmNV8i4r0faaHw4zvscTDrtD3tTPqiDLtWP45aSu2SQIo7uUnWEcyvx5EslY7M7E/chntbO6Q371gPCI/wUl1NDy1S4HL7Z2o8DfYOLKY71fLRO3XnOfJKbdhrwKhV6BUUf/MMdudwJ01/l71MsvQcmrAMC66cKBdeUHQBaNTgCe5El+uNrOgps1pf0geQ+Z0cWPcjD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c4S0neEr1Rf3MbKIkMKT0kQGRM2LU482SbhDxoWMbJs3E+JB7yRjBtBo9QdB?=
 =?us-ascii?Q?fp2gVfZ2jEu/4MMZjEJs0yDvxrBLJjg44kgB2C03qX6xEl0OBeYrxmso5xJV?=
 =?us-ascii?Q?smjqXjLMpFRE4jNuy7ZcqI+y6i67j4eXqPod+6m0i/7OvZU5gyrlIcu9aXZt?=
 =?us-ascii?Q?ceNyIV3Yc0OMykkR5R3BNG4Us8/2lY5nJqTsD3cZn7XZ/rymuooP3QN05gWb?=
 =?us-ascii?Q?NVYwx1C+x280+tiVuEtaNVuThSPVrWBW3Pa1x6nAM7HdvFxWHj2JG0YE7yB8?=
 =?us-ascii?Q?w4aFepMttTpx0p+GuUFDALab0OIifQQ5yqOV4a71sFAdonJ5yXD2xTcMpa+S?=
 =?us-ascii?Q?zcFkkIK4J+dom491cemnzesuhXsI5VcBURtXPuB/7hmdz/fJCHYRBJE+Kzhm?=
 =?us-ascii?Q?HZGjCb9LOaM3cy2QWPq7/FGExwpsdkY1rFP/Ckp60h+9qmwo0Buz1LI/KEeJ?=
 =?us-ascii?Q?fT6cKAxUl7xHbpQVK3Rfjvah0fVbJFH9poj730JmvLYULUTCFq6ixdTjW0ov?=
 =?us-ascii?Q?LGTiQfqBo2gojKEda0uUuFtWS5hR1HCeTGmTQMVILOIne12c/BipcylFGNwr?=
 =?us-ascii?Q?67eobLly43KP4a4SSmNPZ8nlomG15sKTBMRRJpxdbWUpXS0C+te60uqsr60o?=
 =?us-ascii?Q?VzCaUPNGBnMit1G789vQX0mw1Er66g9J6KoVIZof9gEslSrn9M4LmeSweaSW?=
 =?us-ascii?Q?Bx6W1C2mMsXBqBHg5XH9MWq3V6E9F5BJkS6R67frEYZ4vFW/lM8/oMQhTKqc?=
 =?us-ascii?Q?svQ43ue+lRSZw1ilbgm6Can72daK+8gXxFhdAEK3zg7HYjFTt9g8GaQOWF7m?=
 =?us-ascii?Q?+KQ46utHLiErn/eNgJkxauvD7QQpFDc7c3pO6mbSj0Hyg4fPN5AuJgOUNNnq?=
 =?us-ascii?Q?X+uBKnM2h/eunHqDz6VCF4agkoM2rx7ieumWVGEpFKHeoo39eFK4UomjF4Uc?=
 =?us-ascii?Q?Xj2jJzgIaLBFsbqMeTJIZ3f2XRmJx5LspPsvEjr19AFEvkXaGMyX6TU4NtfV?=
 =?us-ascii?Q?2tBGtbjwWPRoU1svvuXfoDSOlq8EnNrj6BEvkQNnEqHDe1FXar610VxIsA65?=
 =?us-ascii?Q?VXaZOqebGu/6c6MaNKZeBWspXkezGob95+47+kMdgMrhRCYdDTkSxh4/s9U/?=
 =?us-ascii?Q?FYbDgtiKVKPzLLZFsZ5aYYj5EJJous0wyt+ZidGofP3hg1zxJCqESUnwHaXl?=
 =?us-ascii?Q?EBfw2rVvKOG4/X9AE4i59cj+AlMj+BmW6t8CcrcXB5IdfF4AGaY7swsBnQ49?=
 =?us-ascii?Q?tWSz4J1e3Zwp2R2OjN07UvRhTox64DwAmKAh0w7VmF4QXxPpgGd2F6+9Dclu?=
 =?us-ascii?Q?RnKQu5KuI5GygHc4QSXG4cTMMKvkDJykJaY6iq+G6aL3vvzjFSTVgrHuoFV3?=
 =?us-ascii?Q?NkJ812igFzu64nB3o+Y6Z69RixmG3KF180D5h6D6u6IrRh+oTMH74lx1YBdI?=
 =?us-ascii?Q?iLEVLoHcRXk/4jkRuNWULLk8jQNV1BFjOcVxjVnRHFbEa/GcTvx/GiVu4lsC?=
 =?us-ascii?Q?L4ypt5NVk156lf7xcOHYWkh+8azFWDl5ycPuMq60wWD/SoIF4RD4Ue22M3tb?=
 =?us-ascii?Q?tKzG5G+oUWEC7CT+HD13Hb06+ZgyjXSt3TqUP8daaPYFQV6BFUcrhbN0YVB7?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574bb50d-3399-453e-beca-08db839b6d77
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:38.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7XoAWyg1Z5vb1BqG+zksdrnb+I8ZK0BHLVLG6Ttxq6GtXwCkfjrAGQ2i2H3Z+EwD5473GQbaH/BsrAyA3ibew==
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
---
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

