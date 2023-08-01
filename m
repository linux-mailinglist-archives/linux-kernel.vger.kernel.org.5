Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C376276B76D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjHAO3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjHAO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24DD1728;
        Tue,  1 Aug 2023 07:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUEqryHifm2Iazh1ndHuzoS17DltrVwp0YIDAYBUuQgoQvvZtFS88iXAh3nipTI3uaXxs07nlivgP4UWHIkWKwfEEuusTBsG6HKJ0DolnlwW8V3gfOgcgdZcOObal/LjC8wifOkXJwZtOUx1UEkZPE9EIMYAok9yOYhMTpXkax123ZisCJLeocu9xFLeAwr6rMf04Hc2CegKEzpNWDl3riaf4y6P6EvFik5YUcbx3YZWlyD/xL+kT2pJE+Z6etCYFc9gq3uG+gpWZSwnp5Dkw3FpaTl/ScQKn6Or8TBvKHXPi/NKy7TLGSgwxgGJC4JY1D6cG0vTTI+sB7j51D3eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0uMid8YSWleukVlwKvvYRFiDrcxiltc2VXkuNnpQ68=;
 b=lDEr6rEP2xaWRD9DTqSqCpNguPxC2iac+5uImtom3wnCkVvGlJkNz8Sw2rT9T6fZvQPyxA2k53DIHLAHuUuMQVltO7n+Vs2ecgOx8QWBFEDTpkS/qPOV6nTwjwfGW4MwMSptJsEVKCMu4cg2G+D7ZwvKN50+vzRtM3yAfdIFL2exynsh8S8Kpi82TlkyV6aWFdFUez7so51a8MVQ7SO1k5FLVTwTYd06wvojsDdnjZNW2IMt78cCHOljNHDjSlBvgBIrvZYic0U0ZPsEMXu4FYVFW9gmyRSiAm2M9YkywiSnUHTU2bjaS1tjPimPtd5fu6PwdFvU3/IdcO36J4Ge0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0uMid8YSWleukVlwKvvYRFiDrcxiltc2VXkuNnpQ68=;
 b=OUMkWA9fE5r5xAbMde/jB11FncZbePtbZ4Ud/PMw/iGUwSzh7oZnHLKUNhT9O2NoVqEEZDAljgYFgO0qg+FZCPmJkTlGAtX46rBMbFoOdU61e+TeyvdRPJnwh5Mihcn/4DoOIJ3RjtzWFSQBtidRrDYs1etsF1kY7vsBPOSUT7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:30 +0000
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
Subject: [PATCH v9 net-next 04/12] net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:16 +0300
Message-Id: <20230801142824.1772134-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f204b6b7-c050-42a4-4efe-08db929bb77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRLcwNYLk5rGqLCQ0j11HmryUoVOjjjsU1UX0rRQ4RRsesZipb5ct2m/DWF8aQxLXgbHipYLYQy4sSlRh5PVPkC8JwHAff9sLOBxhdy6OFWarkJoimLk0oMWnO/EXU7zN5sq/JVDcEuJPUcY+pkZ/N401R02yPdejTiXWia6cYf5AHDhB3hfckeLxmMJuTRXQNCSgrfQirXTh/lxOXfrepya66aE4lyKVUH+oYyqVBQZKZypGh7IAQ26vr4nNWcdxVZZ1Ta/6FTb5almb0o7FC/DuhbQqlkNTT5lnVxCwoHjfRAY/+JdjP1Fmiv6cBf+30ualXOPxct8jtSHm1p2EOQuC1HHX/4ClhseZPP7CfR0JE6x43i67ETFED4yBq+XLxcLpDLUDsI+DTIgn9KK/c016D4OClwu2x6Daz5IL8cGqGFQno1QY8nqHMfqb2NKvtySNdHCnGpyT1GFfcswFKjYNVy63K1fF8exKxSzDjWuwArXTjX+tuLjhJNTsmyvrAnKEL49hzK+HswIdCpth81yCLFrKFpW17Oxa5upe5c8yFtKT0JQrxsggYKEHnecKK0Jva8utuwaIkVdB8wMeogJc7fCxVxNHtFT9Nw9eUfMNd2sdFGyQDtvMpMyHMwN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5NupKeQo/4wbQFLPLEDk+mbgJ+asYDfNi1bckSw8J52qC1zTVivVoyobI4B4?=
 =?us-ascii?Q?JLvk2cqIK2leOu4xZe16jh5/fidSBHmtDiyt5eb2PLLMrYvrZQJoR+5B5Us0?=
 =?us-ascii?Q?cyI6hd5VH3kjvC0oQgib9i33GdgQ7XbiXaCIr/5jGlfvx0BC8ZiDcG62ngoF?=
 =?us-ascii?Q?HTbvyl99x0ngHVv166byJajRSzdlX0U4rI5QETcf6K+oPEKUJvKrzYDgQPv6?=
 =?us-ascii?Q?7TAbK/f8/YA5w7RX02fXCjw8kk1TPoAqp8GKzLRAfywDWek/qcUJiYBkFjo0?=
 =?us-ascii?Q?ggE5Zxpi5FdD9uXn8zGmO4AZsTldtVMVN3NaC0xI3d+BFhot6nY6dwJZqI/E?=
 =?us-ascii?Q?pKDaoiF9sAgz7K8KaE6RI0bhxzGscBfsC33U9JAMhx0UZsDFznl0Ng08JF8O?=
 =?us-ascii?Q?pltqoyUzjnRPblFOaUyE3PKZbeNidQlSHfV1gOSimcIYHvpURGkdIafOL6c5?=
 =?us-ascii?Q?Cepsk4xaQEKhnji6MQywqI6gi1JObcx93vJNwxFgddlTWu8UKXayjwe4ZJfk?=
 =?us-ascii?Q?6qawqfbmyv9G6jqOeoSOXMqf/pwNpRvNou7lcJ12J/ZAhkgtQuDFaK0+2Zvi?=
 =?us-ascii?Q?FxeIFlo4Y3II/YcQd4khLQ71nLOQ79A8zgm27yG/sSLudCOy5/VtWqG3ObFB?=
 =?us-ascii?Q?BfNozR6teFqk18Kuc3jkWAB8ZKoVsKIHzoEixD/mV+xmDwVNwHQfFTtAoEt8?=
 =?us-ascii?Q?IRSHnpcN1gGXPGmgSSbxVPulWQHYFYwcvvvM1SVR1s4tgxX3xrGKlERxnGKJ?=
 =?us-ascii?Q?quSX1BM2v1vBZZF+FxInCFB59iQruWjhpGjMU8q6s30cybWsd3Bbv0ymWyLe?=
 =?us-ascii?Q?UUfBGyhNtqCDS6KYXMA9ZuSMeX6wMeEEvQG6ieNFGkDv0uu3Ac25q4z9W/kX?=
 =?us-ascii?Q?EuAGYkILZTS16dC9HrBWYT9cFykmnW0e6tV8kRZg7K8x+jyLfYtxy2Pio1Oi?=
 =?us-ascii?Q?wGXrTaBgZjUnlWRpdrFX32vesnlvNxvOJuSle3528IdTySI9ad+t/dZ1vxEH?=
 =?us-ascii?Q?+71cvg8Tatt1oFag2XYvfvQFtYx0vq+u+tB9l0ATv15w3+cGKyGX73Xpmna3?=
 =?us-ascii?Q?kUc5Bxi4ilcn8OtHHV6BEsP5C9zwQ8ybvp8/j17ERTCa/O2KhyHrRnlrLBue?=
 =?us-ascii?Q?LfBymjBu88SQoC14UpaRhXETTzRPVF37AkQCnBQ3cckt2pJlFeG54iJv7Otn?=
 =?us-ascii?Q?ohYxAOYz1ErnVstXzYfXD96U8KASVEDoO97emSVg26P2LTbESh7bBdN+/FiM?=
 =?us-ascii?Q?4gKOkVeR7VJj4LbsMFHxwZA8rtjz8WPa+I4HNxK87qylVvoc0lgq4yYo3OL6?=
 =?us-ascii?Q?ylmn57Ho/OhxMYxh0i6Hu6GOOGpjtNIlcKGFsfrELezbXYDQtICD5kWxmFz7?=
 =?us-ascii?Q?go3iZUU5oyEzLwQJiA6fQH0mmcoJ7c7LoTZgsRQjIsNt0oRTIBsIZdwRT+Ok?=
 =?us-ascii?Q?3/GzAnwdoveWwarl0EquOO1ageDs1RbT7S24L/8FEIq0QEc6xyBn4x3MKUDP?=
 =?us-ascii?Q?A8eeU1IudF6sB0SYZlckCrYxHouptfU9xiZTxH3HhdSp26pT3MybdjKCP+uF?=
 =?us-ascii?Q?588ZdChpDuRMmM+mzozDSsU7S3lJjjbqYZN8HkP+ayHOyCq0XeN0sTj+v7dI?=
 =?us-ascii?Q?0Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f204b6b7-c050-42a4-4efe-08db929bb77a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:30.0887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKRdIvpb5mH9HIFupjpwh2MEo/mWZnsC8DihYK/rG1sJ9KZQJ+icPyc/9WV2KdQpBkz8rTZv+oU36Wcz5xFT3A==
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

From: Maxim Georgiev <glipus@gmail.com>

macvlan is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in macvlan by using the newly introduced helpers
for timestamping through lower devices, that handle both the new and the
old driver API.

macvlan only implements ndo_eth_ioctl() for these 2 operations, so
delete that method.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8-v9:
- None.
Changes in v7:
- Split vlan and macvlan to separate patches
- Reword commit message
Changes in v6:
- Patch title was updated. No code changes.
Changes in v5:
- Re-introduced the net namespace check which
  was dropped in v4.
Changes in v4:
- Moved hw timestamp get/set request processing logic
  from vlan_dev_ioctl() to .ndo_hwtstamp_get/set callbacks.
- Use the shared generic_hwtstamp_get/set_lower() functions
  to handle ndo_hwtstamp_get/set requests.
- Apply the same changes to macvlan driver.

 drivers/net/macvlan.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index ed908165a8b4..02bd201bc7e5 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -868,31 +868,24 @@ static int macvlan_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static int macvlan_eth_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+static int macvlan_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *cfg)
 {
 	struct net_device *real_dev = macvlan_dev_real_dev(dev);
-	const struct net_device_ops *ops = real_dev->netdev_ops;
-	struct ifreq ifrr;
-	int err = -EOPNOTSUPP;
 
-	strscpy(ifrr.ifr_name, real_dev->name, IFNAMSIZ);
-	ifrr.ifr_ifru = ifr->ifr_ifru;
+	return generic_hwtstamp_get_lower(real_dev, cfg);
+}
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), &init_net))
-			break;
-		fallthrough;
-	case SIOCGHWTSTAMP:
-		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl)
-			err = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
-		break;
-	}
+static int macvlan_hwtstamp_set(struct net_device *dev,
+				struct kernel_hwtstamp_config *cfg,
+				struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev = macvlan_dev_real_dev(dev);
 
-	if (!err)
-		ifr->ifr_ifru = ifrr.ifr_ifru;
+	if (!net_eq(dev_net(dev), &init_net))
+		return -EOPNOTSUPP;
 
-	return err;
+	return generic_hwtstamp_set_lower(real_dev, cfg, extack);
 }
 
 /*
@@ -1193,7 +1186,6 @@ static const struct net_device_ops macvlan_netdev_ops = {
 	.ndo_stop		= macvlan_stop,
 	.ndo_start_xmit		= macvlan_start_xmit,
 	.ndo_change_mtu		= macvlan_change_mtu,
-	.ndo_eth_ioctl		= macvlan_eth_ioctl,
 	.ndo_fix_features	= macvlan_fix_features,
 	.ndo_change_rx_flags	= macvlan_change_rx_flags,
 	.ndo_set_mac_address	= macvlan_set_mac_address,
@@ -1212,6 +1204,8 @@ static const struct net_device_ops macvlan_netdev_ops = {
 #endif
 	.ndo_get_iflink		= macvlan_dev_get_iflink,
 	.ndo_features_check	= passthru_features_check,
+	.ndo_hwtstamp_get	= macvlan_hwtstamp_get,
+	.ndo_hwtstamp_set	= macvlan_hwtstamp_set,
 };
 
 static void macvlan_dev_free(struct net_device *dev)
-- 
2.34.1

