Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D030E75211A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbjGMMUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234697AbjGMMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:49 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2089.outbound.protection.outlook.com [40.107.104.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C987A213C;
        Thu, 13 Jul 2023 05:19:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJgYx75w6rvVtIx3g2qaDftZlyK+s4DMyn8WfMNmgHUMnZUR24Vh8CgRoTE9tZz4QtmeBMIi3XF4sfN7zl/HCH7T3va/VvOhIA4yK9/YVsOyzxX4yFyfES+vBd2E+yaA2u37dd1nDyWMRO5ivEZ33z0OpaR94upqHzrEF0x7e2ViK5RJj7vI7iQi+HaKeEfS8xaylfqKqO4MkFWFoYHWmSIVZVo95xCKOpiCZpf4IguDJuzUSf+uIpT6z6VI07pbU3NIb2McIPouxuUx217O1DQXXIVQPL/0Dp04pK9xZEUdihWZv8+lHmPSNEfkV33HacZ9yr99KcS3sv/mXJNPLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmKDwlwWKQU4hWJ7ZfCZjKndM34V/hNit1pWKU6enrk=;
 b=IonQudxPada9SB9J8PXZ0JY+llWvYsOU7NqnQzMToplYQoVxgYklNdBfe6EndJbxTq0z2lLvHUZV07SBPHn12T5EYUjwMBPPg8Rq/uWDns3ej/NA9PDq1C32TpbRQTarnL8aKgnVumoHurQ3FOdnRgFTry5SI7OOdpeBZTDTWMlPYDwnoIrx86b9byzyNEXmMypf7chX1PPycHgYV5NM8eo3nj+0HYHxHv42XzV/nJelm7zsTXUxY+CFPYY4Mwz4s8wv1vk64e1bAm07DuTnPi/EtEdc5nZmWui/wVexfVls+5//YhydvFEeLi8OkweP/C3k/dgnLStmN97WZqiC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmKDwlwWKQU4hWJ7ZfCZjKndM34V/hNit1pWKU6enrk=;
 b=QcYXpA1ksduNiIsal6j2OQIvCVRmuAq1iOiGPgKF03XxiEdkcfBGaOv7WUu3hivCurZMR823bEKTsJxyIOaGlYzVIOndiU9Ix1NmqhAx5fUq1imIxhDj6kpJtHt1hkTaEA1UP6UjxQiVj3K2Y4p67ZZifGLfecDRYlZB4vifGd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 12:19:35 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:35 +0000
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
Subject: [PATCH v7 net-next 03/10] net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:19:00 +0300
Message-Id: <20230713121907.3249291-4-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 205fbfff-df90-4eb4-66b0-08db839b6b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bOw5crCzX5E3yVB6TED//fEIQrSKOG93z3pq4z0wsnLj2vqLfBaG3CdaSlk/nDoKog7IJoWLmuJ5AKZLfMl8lKzGC7qheY2kd+fOtdfwT889ZK8/BKI8KJtta+5z2TAwi6uTu/JA+4NnyPlqYEkl8lTYiQYEfQ8Clkg1CLR7WozJw2W+4IPpuh1gtNvIFiWrBkqKUiR3GJIZbsXyWJt82WJTWBanXbbSBnDCFCM/VOEXBT/vP7rQF1+qjDdEkZcqIG97yoozV9B0Kct5GN7SvVdfGtMlnwnDps5giSAF2TDyxY4hddNX1rt42FQVEW3AirVrp47Xdn4dF4357mFWrjms40UxGj3sG2uWzjosEdfahB7J5Uwgt34LHqSPGVSpNXrmBFAtMVoBd7QnJiTpew1tsuJkTa43vqlcXhG3yyGeBSbMOga1QHHwGx7DqHYABnbLC4ckQdUbdc7tUpLOyoqw7i+wiKLUFsma2UjRo87WlHengKeWmkj1BNedU7PCXj37stT/coaQevex8h0d5kjgWn3DQfipaVlVg7VYsyJ8o1BWYnqq1Fz2KL0UvB318DO36MngsbOyqf9Lt3TOgGBKX0MtuPKHshJhdCMJn5LmDD1ep6W+KBywaD88Nhgd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199021)(6512007)(6916009)(4326008)(66556008)(66946007)(66476007)(38350700002)(38100700002)(86362001)(186003)(1076003)(26005)(6506007)(2616005)(83380400001)(52116002)(36756003)(478600001)(54906003)(41300700001)(5660300002)(8676002)(8936002)(44832011)(6486002)(6666004)(316002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ob+LB5FZ5NhKOjvY/pNqP1b2Hp5N6t7psfGmHzo/lgO1RRg+6rb4z8xmkGmG?=
 =?us-ascii?Q?YZAaAtUTdGKhDvdUv82PHaV4+AiI1nFNpllwEiBzl1YfjYfu+9RMlo9XDwJD?=
 =?us-ascii?Q?hIDNDmyHfGpl+qv4c1i6z5/1hIdPi7wcnHBGlxgjYRzVBfNvzzOV5lpPIN2l?=
 =?us-ascii?Q?V/mjbNuL4+LKRHlvUAc/gqEq+Ot7ZgriQDPqV0LNpZOnvmrORCMQyuegjMgW?=
 =?us-ascii?Q?+HvAaDlVgbhhkNcu9pEC4vvvqs3+DjRG1fddpiWL47oezVLtBAgLUDzrHD6r?=
 =?us-ascii?Q?Gad+sfeT5xjbAxRvmcTIJ75dXy22vom1WEEEWr2uQgZ8aPTAnzjThZH5CPbj?=
 =?us-ascii?Q?AKHLgpiiOURFqnWI+AbSFGMGavyjt1aKnNZJO7mdJW2+MWIofWERAwEQcRNa?=
 =?us-ascii?Q?uxzRyLLrHmSLpT+LqkINatMxVRgGRIoPgY6i6Q0iPmqszEJZDhxKZxlobFP2?=
 =?us-ascii?Q?oeJsGTnLSUJO4IGIlodr8dc8d2P63DPODVcYi/EwQ3QjfYc+4jvM5+KOGPI0?=
 =?us-ascii?Q?kAa/M9dXpZ2h/6iXcNBzCFK9NF/tHNdAVHBFYW/9egFATU1SUT169PEAmgub?=
 =?us-ascii?Q?4QJCbre65eco9/1XVkcIsSX7incY4WYQ/uq1eGqg3j8DwF4w+NQMoXenvGp8?=
 =?us-ascii?Q?i/4FkYeg6OLLhohQvwb8NaskjBVTBZ9s0qyak6Uwa1uPc5HvIjealC/ZQvWZ?=
 =?us-ascii?Q?xIvfoFTuZI+bDkutMMauEQoX93eSLpbAmq5OwR4++8Q44EGc6XuNbwADiSiQ?=
 =?us-ascii?Q?hOcoPD6S/giN9xP7K5LyItXEcu7sQ7N1gxAa861AyJfZyriwWzUa/qQAlqZB?=
 =?us-ascii?Q?mhLwmeLOHVwaWjNiWcPHkw5X+7refsSNnhphYZp70kdWzfxIeqED5cBXDi2c?=
 =?us-ascii?Q?HBlgRX9jTf55dw3sxNCW7/A2EXbc7PvWI+ltJeIFDkHOwMQ19HlIV2CH0pPQ?=
 =?us-ascii?Q?rfTxMDuThsdzsfDwxujdm+w1EEG9lAW/lXEmwESNK9g461jmsK9uoCydEGIZ?=
 =?us-ascii?Q?ADv/0VxuFGeoZPvM8l2DHVTed83+o98PLkpFCo6v13v+gbYZlibtrThcsQ9T?=
 =?us-ascii?Q?tsK1zYiiZneryOL1eReNqYBv3S5GEZtY7+ipYRJpWpo+vvygYC+NMPZHwTtb?=
 =?us-ascii?Q?9VNdmtYqxMsisS0MhE+/AQIx13pnuCtYnPe2Dab7R43GcX/Qeb8gpdv17Aej?=
 =?us-ascii?Q?ZPEgz2RxJ0kBG5e8SLjN9IMLyRSG5SUhuZ4ObZ76Glh4vjyQZ6TL0FaX42BT?=
 =?us-ascii?Q?h0vbCjdi7yjmFbjVLXaJ23Mk3W6a5nFkAyo/xftgKkRmuqUjIqVPbV9AOvdu?=
 =?us-ascii?Q?P+Vr5Gchk64W60t6gvxGb+ThJCxnGMQp72Gwq9+eVT+S601wTHy2O4v6d7Fy?=
 =?us-ascii?Q?d9hYc+uKJB4iNWqUhldbiTQHG7DIKz0YC8CxXiLAOYub5ePNaJTOBFS2IRf1?=
 =?us-ascii?Q?uyNl5CSbOH6MNPX720AI/2yJolCPIcNYuW9ED82PbQ7bSfAZB0HH/Kc2euNd?=
 =?us-ascii?Q?tN00r2vdZy/KV1GVlq7QrzzT8cMmR+bvE33KFJYadPNLQBbw9jFQCdu7s3e1?=
 =?us-ascii?Q?8aDnxYP9sviokIrOc8gD4FP4N6naiQgYVyAHl+YTMr9u6WlTM/v7nvkHY9Zf?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 205fbfff-df90-4eb4-66b0-08db839b6b72
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:35.0420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL3teI09DW2agfLnZBIkDjciJZ8n6XdldG9utsvH8RtlIC6MEFpe5FrhM9+xmKHK6ysf+jS0lfFwiRqLu0+/3A==
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

8021q is one of the stackable net devices which pass the hardware
timestamping ops to the real device through ndo_eth_ioctl(). This
prevents converting any device driver to the new hwtimestamping API
without regressions.

Remove that limitation in the vlan driver by using the newly introduced
helpers for timestamping through lower devices, that handle both the new
and the old driver API.

Signed-off-by: Maxim Georgiev <glipus@gmail.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
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

