Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084877567F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGQP2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjGQP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:14 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628B107;
        Mon, 17 Jul 2023 08:27:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/AisSpow/4fx6BZ7Jc5p/6SqnDHf251C1LaZLXO49S1y6tcMVrfa3POmwVp9X/H7DEx3S4h7sXOtuL6VF4WUFbaU9wYkZg6BHLAYWbL9QTS5gPHmcGvK9jhPc2JPixHcTRUrgdZW/8x8rT4i//etjgptUgQVcMYbA8YcngorZo0fEoKYMjNxfp2DGYqBTqCveIuEnTETaMry448AaMRFtiS6VXvUN23ojHcOZ/0v/ZZgDQ9KG+LE8RR/37c/NXV/DFzWIHU2EPSu+SBwwGnBkQ5pwLnfZmWy4CFcYPtG4WWGsjQroxGNk5K1iybi4iZv0UfHnCRyrbYF10zbp7RaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWwXS83P2zx4yIhHQw8PDkfdP1vWtRYXe3Yz4X1NgAk=;
 b=jurowIO9tdeS/4PhQzgUxCM4OGOktRHIHENLAr9655MC2s7I3AKBshqyx8FU0DltaLVp849b3SyaBYLoqkMspnLzq34fAHPhiqvu4xHL83UX8BGZtQDFiakpXq3wWf5RytAh6mnHUFXkhHahW/+/fzs9ZWOtnC9ZUmdy0+x9y2bTqpObSKzO2kvY/KgPcymyWpxshqM8pjV/gS0HYBcZNA1TTtaIVXw45S9WIarp049A4x/6KhYmaEtwZZ/5wjfRh08HcHezjwv/JdJsno+QTFIrJzK1ha6zhxXXiHmEgmJdI87iLWI5S9rghsZ8p+QVR4OGzC15U4Yl57FkDQVvNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWwXS83P2zx4yIhHQw8PDkfdP1vWtRYXe3Yz4X1NgAk=;
 b=kpvN9DYW5l7HUrwNIU8ACL4mKJsIZMKGvTF9NJ0Pvs72zUlod6etsVA3QdV67/dwoOMsUQnJ6C2/NLHUcNuxZn8BFkl5z9a4olxXTwA5zPezMvrOBVX/sloC4/77fKlugoGDEHbC22RWpfAfM9IwAVRRD+/qGZMyhVN5W6iLkjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:31 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:31 +0000
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
Subject: [PATCH v8 net-next 04/12] net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:27:01 +0300
Message-Id: <20230717152709.574773-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5dd41a24-c833-4e81-9c76-08db86da565a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0EKb3cMTvGRF0UDsQaD5egdEYv3NqgXPIjIYboQj4e1rhQ5LlZ+dnv3K8R8YDCBB1TZixY0BUgYUNVhdSWAaK0j7c4CiSxNeyVPVdOIuO0cbu8+vfGaBvylJZrSbtN4O81XIZK0kBoj19sB8DeEc27hWy9vNnjQH/Ew/jqij0GXygYGJEXqYnfOCY0tI1VIfTu+lWAKW2TRAoKRNhRbQ1+t5g9Umxyj1erRBBW8ejdp/LytcgHIbW7r+ln6pZeDzJfzxBvel2ydw/Dr2JqmH2aiWD5fKcxAeRdtSFGA2yKbnzbSPQk6hDMFm5J63dOh8u/0jN/5HCjuIve6RuViRoxcOaTZuuGU8qa0Vi88Orc1uZK9ZT7XXgfDa6/ko7GN7d1mbg+onXOL5djjAQHsr912mjjIMD2VzWuExxDd2aQoR/ZGVIHE5JKxHE3lzfbbV6ar3B+lSIVYEA7SMyMgStj/TL2bkgaTEVqAl8D7LCYPQ3n+3A1us6p7+NHJLoKaB7C/HYKMLLzCjUxkhDkbIvNNmS9aVErC0ih7RegIhM8tzavJ5Ez7qVO5rTAJfhx7Jp7wz6x/eQnJbCzlAaruEVCNJp4Me4yOMf3enUwcydA++J0sXiZW4fyK40V35FUQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VgxkbN96rUVOdHsOc5SeKXjnI+UKEe7cOnr9DKctYrkHK38dxrSXZ6xe85KJ?=
 =?us-ascii?Q?GoAl65O9RNoeVCESXz6QOHFPX5h1905sdXDXhQGq6kJPw4KxXT7hpuGZ/Jo4?=
 =?us-ascii?Q?FzHN470ol9cPj4Dn3ud9i9+NgbilpEhwWv84puP6kTlB3zc/F7Z9Aj9lWDAe?=
 =?us-ascii?Q?jrxVgrOofuHnTw8ALbXKds/UeZfb1Zag+zgXeJY0YZ8jVd3Nmv/9AIMiLVcX?=
 =?us-ascii?Q?ShePLEm7WmPHHrnIpkagU47DwnS/2w+7TrxEN2kW/KHOwHG+djNXlmxaTgn7?=
 =?us-ascii?Q?/FhVansSm0LrXqK7nFewe9lIbGVqJNlOIST44TL3W7vkELzK3VL9YZcOUAWM?=
 =?us-ascii?Q?SSIk8X3Dto+VO+MrVeC7tYNJOXypS83ilKqLj8fUZVA/G11UuMk16qY0vutX?=
 =?us-ascii?Q?0LhnRgEaHw/Zac5cnKAMeCptPz4Vfs+df+t1Ga7Y+7/0ExvF7xqzF/A76JCT?=
 =?us-ascii?Q?Xd40YdCETHqIgwNaQv2HC7Jh3uHKHEgZ96hplpOkJnbpPjzvXe32etmiytdr?=
 =?us-ascii?Q?EgEH3QgvfByVi/Ejosz++fVNdqXCVntECxW3rNc610UnrIIbz3B5EF5kEasm?=
 =?us-ascii?Q?3wGCMShPfQsi5ikTOq/4CzzyTh4GRvupdGPIB2DYvDYpOSdpmjDvV+ISOUrl?=
 =?us-ascii?Q?0WjemSVKQifs2/VdfrBPJDSv7UT4GmQe8kAvk0WBGNLiJHMBiH6M3d0orPBE?=
 =?us-ascii?Q?1Uekiz29pzSo9U0CC8zOoV/IPsdBHEi4byOxFz7pXPw/tn+7bqjcmrGiWABd?=
 =?us-ascii?Q?VMSZRGGRExkS7PDgSrVsPT4iEthkXJHwYJzuOvgu4sWS2C7cHQJBS3RZxGX3?=
 =?us-ascii?Q?2pNk3Ljj//Sbvg5Zw8L6wDYHLQqkFEty736rjFmD0JSpWlgf1PRyYLbCmzl5?=
 =?us-ascii?Q?fJ+wsUnDbCVPOZSZPrhjIakEEa++Nwvqm8uXK/l/hDA0aIK51S/nJVX+tqBz?=
 =?us-ascii?Q?vHCrf4qd9mr8EnPk3503s3+/QEOZy4a9WutqpVadey2AJv6tEW3LFyhWtlB5?=
 =?us-ascii?Q?OkVBwEzeVlMuloQ8yraOsy6W1c+Om52bFsB5e2C7pZE51Yjqs5M9k3qPsmaP?=
 =?us-ascii?Q?TV//YcsWP2ike9PT3yhheF6VtGO9IAQyIve76n/EHF0QvHTW1IRccbGwvqjE?=
 =?us-ascii?Q?n8Wg09uzw8bB+zkCR0zM+RGeWq7FwIqlzr+IcXINmekHbkj0ghWFfDCPVUVz?=
 =?us-ascii?Q?kbvLHKIdymfd42mv8i6BdSstz7AIb70qwzAYNN4UYASK/vpuogfFMiPOqnNO?=
 =?us-ascii?Q?qNK6s9Y9ZIQ8YalWXLHkw7XYBy6Z6yhx7qsHV3NpDXHuDlYOdJZzg9goCJiD?=
 =?us-ascii?Q?0j2jXs/gJJDXZNS3319hTfBn5XJgbiQX2v/ae/9nVArqU4HfjNE7j5LDEL+c?=
 =?us-ascii?Q?TTZ69IaAiypC5+bFlIu2ME9Ro2ov1C7ou3Ir080sUfBfn6qLnu3AAbOSvDko?=
 =?us-ascii?Q?8yC9DkLQ2W2hbeVNrhK5Yg39yaTPrQ8vsqrv+4b06ObITBNVvPVTweSA/9nc?=
 =?us-ascii?Q?ywoq4ZV2MfMuZ/v00RmIGvD4RUi5jc3SQqkraTePIP/0d+gVFSrMtL/DuCft?=
 =?us-ascii?Q?BRRS73BeJR+CVj4R7uDObb1eH0yNSFh5hFMa9nZkRU4y05aD3hA2TWlm2HLX?=
 =?us-ascii?Q?cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd41a24-c833-4e81-9c76-08db86da565a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:31.5134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DC7AY6hNaaYCOK2bAHXq9MUFVOAIS1XBljCxET//10uF9t2wxDuqG+SdPIr+2Ki03WvMyS1zFeLAAuSKhGjCbw==
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

 drivers/net/macvlan.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 4a53debf9d7c..01acb57aa40c 100644
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

