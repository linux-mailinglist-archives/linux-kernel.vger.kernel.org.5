Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB57567F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjGQP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjGQP2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:07 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA97138;
        Mon, 17 Jul 2023 08:27:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3DKu6Z+BduwwcF2IyySVdBwq/gqUMK9dJaCuGNHcTYu325ut6A7R/Y/xsVxQ7F87mYAfh/Pvjq3UHOyVnx4ae+3SWHoSHo7+m6dRDWAM1h7tzEJ0MUIFhnr97y/B0Sw/7e4jU7Ntah9UkWyhVkkIsTt63s9tVQfkEe2ZMViZWxh7gzVK1ILY4CRUco5+pA9HLDRtyVvkheCUn0Cw9bv6Ititrj2pvRfcTIGLcAT6qL8dI5hTh8GGlrao4OnhU7yvWg9cJqQYlp339WloGnqT+0XAm8u+znRi1oV+r/wKlNsaW84nOKks8rXRpwPf/v0R+Hyi0Ch8m9MUNfhzXRtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NUHxNUP+Eu2P3/cmRP9EQdFZZ8zYy0VLlFljFtH4KU=;
 b=m+BokpRbjE+Pekhb9bePg1gqfIQuMPrrWTvKn1NPBaJNvSe0KdQFOnqaha3zKfHMUGCWvn5p4ghghKF6YIfuygJV20RT9OT8GL5YA8cs2JrvoYOpJrb+LpU1WiPErebiGqR6OuaFF15m7CfleLt42FGwFdRZNHCDuMZL/EdZC4umCBIacMqqS+BMyr15Y3MexFRgKM07C8XV3INpKX7fei5OFOAYCpQ+6SAQxDmNZwo0s1pwo5/2bm6/hDgt2feTCV2Ia5Eu5cTVqq0TbQ53iHYNmr3S8ATQP1BKSqn0AYw2gGPHX45OEc5vbQpKsuIAW3J4KFVNQKnCKPCOL6F+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NUHxNUP+Eu2P3/cmRP9EQdFZZ8zYy0VLlFljFtH4KU=;
 b=agRh1P5oVGmGny+s400O88G14+H8+j5jiWp3pfXs5z1t831nlpWnrryR1RsUfYuuYCkuo7kiqMS/TL+N6E6e5W1ag+falcfxwIIiQwQRKlavbQ7wFrOQRVWn1wd6MZJCe1H6T9H1+KTTxvqS2rIz15pfG/1yd0uhBp9m1T0k88Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:29 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:29 +0000
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
Subject: [PATCH v8 net-next 03/12] net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:00 +0300
Message-Id: <20230717152709.574773-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbe0c5ee-01d8-42c0-2585-08db86da551b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +baf49l9hVPwLG5XyRN1lm85E/VWN9jl09fBKkS4J1xtjyLGVz7yhPGp7m7RrWJJi/qGq3mhUlQPqENuk6uXqrLRkRBE/pJ9rfbxtDVv7nA8fhNKAVyBu8pzH+HqhFTLL/TL9S9rxzywN0sPx7i0BxcuMLUmdE3PytJf4QhrovV/FNj+dwbTK1E7bsRbWuW03bFlkwdEOJrM3pc5B69wj66pVjssCj1Q+ymLQ5OePsRDSzWPvJ3ir4/2+EbQCO+x/mUTQKKPHMJtXAA6TSdmFMtvltZTu47y9ojEiSO9vncOUOftWTuPs4i+imFCEoF9zGOoJpSkGsNOquK1Yk6aii7vgQduTUZULMG1pD9wWVYYAk5sitIrFYVyMhi51fma7THCgwXiMIh4hm4opp5MKVU+v1B/2p+anuPSPgAM686hKgeS8Surh/pXWYmxQwTLybsIS0vlfNj06LQf2k1gZj3jNAbH0VexbI/RuXMWxpD271qHLChzwjscwfpxSnQtcum2EiYRh0V85qXp+gHRB1qjTpew3xH6UZyRi1/ceoahvyb9IwQj0kGYzzxhLAxMIuQb97+uzAawOjd0KmCPHtP25dq3l3S901e0ukxX/MUcpkvRx53PFdIiR4uGh4kn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pyGS5RA275M7L3RbugCHFinorrFHsYwpD8iVCNfwzHAfQnPzcCUwXFKBOqQJ?=
 =?us-ascii?Q?a0lIeVVhb0nyFw4ORM+qFUVx5fYqgYoPEdE4+hU45Br8bn3kDcQJ1FxDXJ95?=
 =?us-ascii?Q?+sN1rkWo4ZukYfBgEu9ckhAL2WQ0sBmSRpNKrgc4TBYpttaw+PSlHOAFxAfd?=
 =?us-ascii?Q?vqxrlvmPe58SeV4AxN5CW0KCEK3913kINBeUHJKiiyxbeavACd++MnQWO4lP?=
 =?us-ascii?Q?EtKWKMXxKkPVk50yYUg/ftYQRFQo1oUOixBFVpatx/wwhSWrn8xS/2D6RgBm?=
 =?us-ascii?Q?E54tV/inIqgdaLapGjumOotng+67w5x10HwR10PWYhe/lr+GaiaN0F7wKf21?=
 =?us-ascii?Q?oIj3jRu4vPA/rCVTiUMXCNxQP66pnRfq4d7NYrTwdJKGyrfj2bFmJXz/v0EY?=
 =?us-ascii?Q?dwoSiBxvrEXTezuuvnAG80+lTtbtLh01tLI33/GvQs0Lj+AmrMjigh+m75TN?=
 =?us-ascii?Q?3tdhrl9Z/MCCjvOqJbPucPwVh6lRlTdJYaZ6BZwtymvPRs9L6E72NyKO/Eb8?=
 =?us-ascii?Q?+c1dCPDmvfEFJda9az9hQjT2MzLfoZsEYwhTAuXGIsvo/Ol4rOo4T41ky1ko?=
 =?us-ascii?Q?IqkTsee3ScXsBjXOgUX9ZZSSgF5IqG7AkKnFH1CsrKHyTJCsNqORnTFIy5b1?=
 =?us-ascii?Q?F8N+UWPcu3uZJ6nFPtDbikir7saNgC3R3z2xc0NghnZjgmex6nBpXysgoF0c?=
 =?us-ascii?Q?QJgkuLd1eKSjO2cNI/6DqtVqNZsOIMfJ1ZuoBuiBoNDXI2Suj7SmV2A0MFok?=
 =?us-ascii?Q?9F7sK2NPd6x8tIFRdqqdeGXRmvPQt3BUegn2j0Ej+B31tsXXdFtlw9iQ5zXn?=
 =?us-ascii?Q?b3yA4qA9Jx9X5DMOOBNEUKJRhyJaBdp8VR06T43ITNARbNlvt62Rlrl0A8vf?=
 =?us-ascii?Q?AHEoMb/ag+uMZV6ymg8aV+UWU8wAzfY25T49d0YGTrbtcidXi3K7WS7Ach4H?=
 =?us-ascii?Q?hgqnWCEIduF6I+ZmMrRZZaiXBAzmdZ3Nqyc4CRxOe+KdsY0n19kl2umVz52G?=
 =?us-ascii?Q?PAbO5kG5STekm0Vsk125/nX43LgkVXV6k9THxi+ZF0TKBLIzpQS6+YwC1IeX?=
 =?us-ascii?Q?h/gcv6irr3/ttRkjRyzG5TOMZGFOrkTXGW6sdfgsCvAtwEirKMDtjvLUPf3e?=
 =?us-ascii?Q?kqnlwUCk0yAlj396cqMwyt/AohLQthxVoUWdDHwR4Frqv9MJnsnOLIf6rYOK?=
 =?us-ascii?Q?+X29M03MGcLAlxJUAyUYFPphmEdme9n2O44ZmI2efCvTiDJDpczxZuFY8ZJX?=
 =?us-ascii?Q?X71loyjDX9Byp/VjbYUEmy0lku+1586Pe03C9Zd/KoCIAGHGbwtt2xFyIdOa?=
 =?us-ascii?Q?EMeFcHasL+252WhcCkBEVIHBhXhm554XftRQjIF2v+pvE3vnsM8shC+cUPGz?=
 =?us-ascii?Q?PJZbr+bKNoLb66YRQ6FafXSoXXjmmSEInZhaU2jG5Jf4lkX5NgAl7NPKRZ+0?=
 =?us-ascii?Q?Y/V3Mbw5bHHnTqX7S4eir22L+3K+dxnLIc15NU0tzaHXbfbNhwVvGVzUWq45?=
 =?us-ascii?Q?uFw6R5EmOfUB7/nEYWUrQiNSAnIB5E6nitC7J8h3Udaor7/a8fs2G7sNRi9f?=
 =?us-ascii?Q?keaQE/H3QR839HznU5JL/Ebw5Dh51W2ru6bx2QzwraFY2GvGq9lNDZP52oRB?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe0c5ee-01d8-42c0-2585-08db86da551b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:29.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFSKaotM+6dizo1KJcaFtwIZSL8bqgYgj0LF4hwu+rQW8bpOGIy1AlxQLwZMCJMFqYqfIwvJf3UhekuIcOCzGA==
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

8021q is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in the vlan driver by using the newly introduced
helpers for timestamping through lower devices, that handle both the new
and the old driver API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v8:
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

 net/8021q/vlan_dev.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index b90781b9ece6..2a7f1b15714a 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -354,6 +354,26 @@ static int vlan_dev_set_mac_address(struct net_device *dev, void *p)
 	return 0;
 }
 
+static int vlan_hwtstamp_get(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg)
+{
+	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+	return generic_hwtstamp_get_lower(real_dev, cfg);
+}
+
+static int vlan_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *cfg,
+			     struct netlink_ext_ack *extack)
+{
+	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
+
+	if (!net_eq(dev_net(dev), dev_net(real_dev)))
+		return -EOPNOTSUPP;
+
+	return generic_hwtstamp_set_lower(real_dev, cfg, extack);
+}
+
 static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct net_device *real_dev = vlan_dev_priv(dev)->real_dev;
@@ -365,14 +385,9 @@ static int vlan_dev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 	ifrr.ifr_ifru = ifr->ifr_ifru;
 
 	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (!net_eq(dev_net(dev), dev_net(real_dev)))
-			break;
-		fallthrough;
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
 	case SIOCSMIIREG:
-	case SIOCGHWTSTAMP:
 		if (netif_device_present(real_dev) && ops->ndo_eth_ioctl)
 			err = ops->ndo_eth_ioctl(real_dev, &ifrr, cmd);
 		break;
@@ -1081,6 +1096,8 @@ static const struct net_device_ops vlan_netdev_ops = {
 	.ndo_fix_features	= vlan_dev_fix_features,
 	.ndo_get_iflink		= vlan_dev_get_iflink,
 	.ndo_fill_forward_path	= vlan_dev_fill_forward_path,
+	.ndo_hwtstamp_get	= vlan_hwtstamp_get,
+	.ndo_hwtstamp_set	= vlan_hwtstamp_set,
 };
 
 static void vlan_dev_free(struct net_device *dev)
-- 
2.34.1

