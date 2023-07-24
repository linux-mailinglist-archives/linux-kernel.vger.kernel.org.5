Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5982675F98B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjGXONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjGXOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FCCE54;
        Mon, 24 Jul 2023 07:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0N024vQXx4g/i4Dj2+UO8Q7goVJjNBTtR9zuUtpH1PxrB0kTz6BhMvikvNnAVzuChkTGjjK74dMJz1iMPT2i5D4r3vyOFPouRcdPEha9DGwT/lq+YuI/vgb4La6ICN5xgtN49mHwqpKDpRi5q7w3t/aFWfur9ZeoV/xmU96L4SdG/SybRMMr8Gb4eP971yjeZrpXaSXJ54wSRlnK+iEnfr/RmYEUR2uPvBgw0YBFNWRrieYE6Vs8Efap0q4ad53v0vV4t3WPRxbN4SeulCSfVXxKeaj5A9iC2GvrpSEGhh+desKgamwqtOj7he9m8qoFXDS72tHeiNxmLuxZQwCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1CFwPxSvwe4qxbDWcvoMlXRbGRRvITsNWD8I3QDtog=;
 b=i0QIOCyjILfAbFAFEPmHP3fKk7iNrzThp3B+R8psHp3JOy2DI2SO1/UaifjM9wi1ocGxQcB7IkS84jVEqIhucyDHqO1bnRiiMDs+PrpbFJEKydszxSjKug6dA1GuXhwdPiWEWgOp6uqwyuJf8AavznArkhNiaKN/71iOkMw1Yh/hd4A20mnmIn0zbYPO6GL/WLcJ96JkIS2QvKIAZ6DSnxg478cX4cdWQ09CkNqIYXT1hsdo92HedgTN7CBY0Q11e9HDg8+em0izHvnWore88lY+6YBy2y8kUzCzV4jiEyh9uGeNnauUyO44s9hOhAVaCj4JmQyu5VdpXQqHnodpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1CFwPxSvwe4qxbDWcvoMlXRbGRRvITsNWD8I3QDtog=;
 b=fsQymfPC3Dk+usPxFE+ZZzoJKjt+6N9bKIZwDa31S4ffgM8POGrST5b08iZDwZSARHokVp2YEWbtmPF7276EsinwKDrUulpLvZCN10tN5ptC6TL12mQ30RHtjOomoma3W6C5Tk5Vv7H1uyBwlonvqtd5paG3lZ8US3MiNhAS5jo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:48 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:48 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 05/11] net: phy: nxp-c45-tja11xx: add TJA1120 support
Date:   Mon, 24 Jul 2023 17:12:26 +0300
Message-Id: <20230724141232.233101-6-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e30caf3-85ea-416c-9286-08db8c500f5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZTU6DMas5mh3EL0aFrj7M+jG4jkBx3wMJZBhR0Fm6ElTa6jviMU0qYHVN0xtuVTZpGEtnUhPjdSCXALS5HAXeratgeee2iARYxZfcqkVecp+vDzJ3MqoiAvCx1aPaa3+5sCGT/zrURMn3TtQXsxFQxoly8/ETr7XARuWS0uEtjF5I4Ajg9fDQaLrzbt3vKUhpJLEM9V6pTLT/ItCgf216Q4nV+f/cOOBYVMGhA7Y32sckdFOXtdcxN7q91HcchUvpGzWBc7XZvHjF2QAIyydIgW3uSoijP10EaAljWQ3TI+pYeSMrLPLf+JlnBBb3KPBIe4mBOg0yzgixZR4QYg0+CjZSwaYKgAf3URps3Mf8rQNUTsiseUw6p6imIuKGui/IMBhZGh7wAzubkP9gmwjPY3d7z0Kul0O43Q+YyEjito11BoO3yk235xDlmWBms2ysCU2WVe1yxdoqcXd8car5iOvJCvRtrxulkvkBCvGjX6rIBgAQ+XlIYLsHTBIc3SLbnfqFFAPmPI2lQ+hCkSr/DXWL0MTMcdDu3t0F+3w2TQUUwOMwevPa00zP493j9fA52tj4Hu9+FPXgpZLEbT2iEMLIBKMG5EtWI44fqL8iazXN6BwC4kcd2DoJmZSBpw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(66574015)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYTnNWsIk6wyi4/17qZYH5Trnael6XAiwdojaPXvce+tBf5uGR1V7MqsCT7X?=
 =?us-ascii?Q?ef9st5o90MBXyBLVxfURntExYVEK8bmx8hB6U+o0BSGBB065SK03R8KZku3O?=
 =?us-ascii?Q?0KOvyz4BD2+tNcNmGnfno86s8Qt58OGb4GyIlEPzEHNt4+Cp1lcHACtSPNTa?=
 =?us-ascii?Q?PQYZtRXcpz4RpA0uj3+F/EG0jcic/kBT2/qmuTt/7C4F9HsnHcWkjpvC5rm8?=
 =?us-ascii?Q?YFwrLb4Ki108ibTt9TWv5rlyIYTpTZBcMnRJ64hdEXgnyIM/2G2cB3Otdqht?=
 =?us-ascii?Q?Qo9V1JBqeOrs2SNfR5PRaikNAdDHKnjbht1ObyaVMJLwHTlk6ltZHVhmKQeT?=
 =?us-ascii?Q?f8bcAe3paNKaAlksoRUME3bg7GZOYOl02k7HibumUXUiPoLh7p2QcEcyXcI/?=
 =?us-ascii?Q?irbqdmxJbaqYqMJJ54g06HcT6NW/zeAP2jswBhNjNcjsO/RxtmF2uHhPvGGZ?=
 =?us-ascii?Q?h4hGiee0Jly1dBXdpBtm1nShr+FrGdRuXzL7IydBxiwWAlU242pCSCvzvyfa?=
 =?us-ascii?Q?PPR/TVZ6Volo7Z/LxDFzCW2qApOndGloX3/ty75b9D2xfzNMWnt+SLB/24l0?=
 =?us-ascii?Q?x8yrykNRdFJhqVVYN7+9R+gTBqGJ717bkqxfAT0+s+QjCwybQ7RvRBcsKyhM?=
 =?us-ascii?Q?WpSIuap5Vj8qgIEOIvM5gWjMhhvdPGu45/MngJ0LvBAB6LFCtDSbLYK5PRTQ?=
 =?us-ascii?Q?2nFz4a9nhkPt0+LqSNubhbG2Qd/3+FbSdLnV+XJSZY6qhd4AFHit6aSYxWiU?=
 =?us-ascii?Q?TG7e6+dGhdk5PvktqtaGXDS6TWrQqW3Z/9CuhMMmhNZf2lOu68ZStDqlkKf3?=
 =?us-ascii?Q?4HEiHIaTRiDb9OHOs87ZHPtsuInhm0lGkPs4jaTk0EM5BVWLylHTVApKNQVK?=
 =?us-ascii?Q?yqETU3/koBBd1/vENok7MMTX2HgCjVV7LUxY/JJAqDXynDTDYnwa+conrT0i?=
 =?us-ascii?Q?6QS8PjPbxXakPai7ssmjTd+yzzNB9wm+RZ3ZTkprzLAKMofH+nnJ9KaPrLsi?=
 =?us-ascii?Q?akCHmrygk2joMmtPPXoVYCSl9llK8yJ5jllBphTscCGICFdpkLnFbaA+Tl3i?=
 =?us-ascii?Q?I3jfcQy8Wqqpr27xE0/Ej93xIoQxjPoKppVZcevWqIH3Cp30xFGdW7VDO7Cd?=
 =?us-ascii?Q?ihpePTADhr5TOguzdgrYHgXuOdGpYkW3FHXKyLFlDPTOnVii/AMn9Z/IQ5Ev?=
 =?us-ascii?Q?Y068hLlwkDESYuhbwlKG/Ya8Qdoog6vVu2Q6F9dDh6baoTaXz2pT+9VlvLDf?=
 =?us-ascii?Q?W7UgRYc40+ne5V+E3E5zhVSGdEpP/jZX5DZvEDxqUhcsqBdC8Uhtp/4s/1co?=
 =?us-ascii?Q?y/FdIbLSyk5DM2tpSS3PyafrlyiecrVP3HpazPnUuSezzWPWfrcl6ttmzmAM?=
 =?us-ascii?Q?XMXSk7V9jU9h+tPKEFRce4t8RXluOhg+GCWRkbRs2lWlN0RTZScyCq37yfwJ?=
 =?us-ascii?Q?/dMbBJCS6tDbziZf2fyyaixdfOpmWzgARWuQzY7KpF6kNUD5uzRzkkel9iV3?=
 =?us-ascii?Q?WsKK+Ed9Pvs6MejXYJqdJfBuO0WS4WhIiioPBOrMoGzil3lT9oTc3ctFsWSn?=
 =?us-ascii?Q?3J//O8mET03cfkcbYMI7dvKaqdXCwms5uw6mZ09KR9eJxBjsglYVORepiegV?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30caf3-85ea-416c-9286-08db8c500f5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:48.7383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLAOiIuQHJej5jL5lucIp6TycmR3cwmB+JgVL+9AsBXLR/O0Ypt1lm0dO818rTQRwEJyBmaHvKvIVxO1oyFxtXgM1njz9DUckuy8tnEoxC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TJA1120 driver entry and its driver_data.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig           |   2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 159 ++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 87b823858717..ab9f249d4221 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -306,7 +306,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports only the TJA1103 PHY.
+	  Currently supports the TJA1103 and TJA1120 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 11fb5a4f47fb..47decf2677e1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -18,12 +18,17 @@
 #include <linux/net_tstamp.h>
 
 #define PHY_ID_TJA_1103			0x001BB010
+#define PHY_ID_TJA_1120			0x001BB031
 
 #define VEND1_DEVICE_CONTROL		0x0040
 #define DEVICE_CONTROL_RESET		BIT(15)
 #define DEVICE_CONTROL_CONFIG_GLOBAL_EN	BIT(14)
 #define DEVICE_CONTROL_CONFIG_ALL_EN	BIT(13)
 
+#define VEND1_DEVICE_CONFIG		0x0048
+
+#define TJA1120_VEND1_EXT_TS_MODE	0x1012
+
 #define VEND1_PHY_IRQ_ACK		0x80A0
 #define VEND1_PHY_IRQ_EN		0x80A1
 #define VEND1_PHY_IRQ_STATUS		0x80A2
@@ -76,6 +81,14 @@
 #define MII_BASIC_CONFIG_RMII		0x5
 #define MII_BASIC_CONFIG_MII		0x4
 
+#define VEND1_SYMBOL_ERROR_CNT_XTD	0x8351
+#define EXTENDED_CNT_EN			BIT(15)
+#define VEND1_MONITOR_STATUS		0xAC80
+#define MONITOR_RESET			BIT(15)
+#define VEND1_MONITOR_CONFIG		0xAC86
+#define LOST_FRAMES_CNT_EN		BIT(9)
+#define ALL_FRAMES_CNT_EN		BIT(8)
+
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
@@ -94,6 +107,10 @@
 #define VEND1_RX_TS_INSRT_CTRL		0x114D
 #define TJA1103_RX_TS_INSRT_MODE2	0x02
 
+#define TJA1120_RX_TS_INSRT_CTRL	0x9012
+#define TJA1120_RX_TS_INSRT_EN		BIT(15)
+#define TJA1120_TS_INSRT_MODE		BIT(4)
+
 #define VEND1_EGR_RING_DATA_0		0x114E
 #define VEND1_EGR_RING_CTRL		0x1154
 
@@ -110,6 +127,7 @@
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
 
 #define PTP_CLK_PERIOD_100BT1		15ULL
+#define PTP_CLK_PERIOD_1000BT1		8ULL
 
 #define EVENT_MSG_FILT_ALL		0x0F
 #define EVENT_MSG_FILT_NONE		0x00
@@ -929,6 +947,27 @@ static const struct nxp_c45_phy_stats tja1103_hw_stats[] = {
 		NXP_C45_REG_FIELD(0xAFD1, MDIO_MMD_VEND1, 0, 9), },
 };
 
+static const struct nxp_c45_phy_stats tja1120_hw_stats[] = {
+	{ "phy_symbol_error_cnt_ext",
+		NXP_C45_REG_FIELD(0x8351, MDIO_MMD_VEND1, 0, 14) },
+	{ "tx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA1, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_frames",
+		NXP_C45_REG_FIELD(0xACA0, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA3, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_frames",
+		NXP_C45_REG_FIELD(0xACA2, MDIO_MMD_VEND1, 0, 16), },
+	{ "tx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA5, MDIO_MMD_VEND1, 0, 8), },
+	{ "tx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA4, MDIO_MMD_VEND1, 0, 16), },
+	{ "rx_lost_frames_xtd",
+		NXP_C45_REG_FIELD(0xACA7, MDIO_MMD_VEND1, 0, 8), },
+	{ "rx_lost_frames",
+		NXP_C45_REG_FIELD(0xACA6, MDIO_MMD_VEND1, 0, 16), },
+};
+
 static int nxp_c45_get_sset_count(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
@@ -1511,6 +1550,101 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.ptp_enable = tja1103_ptp_enable,
 };
 
+static void tja1120_counters_enable(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_SYMBOL_ERROR_CNT_XTD,
+			 EXTENDED_CNT_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_STATUS,
+			 MONITOR_RESET);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_MONITOR_CONFIG,
+			 ALL_FRAMES_CNT_EN | LOST_FRAMES_CNT_EN);
+}
+
+static void tja1120_ptp_init(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_RX_TS_INSRT_CTRL,
+		      TJA1120_RX_TS_INSRT_EN | TJA1120_TS_INSRT_MODE);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, TJA1120_VEND1_EXT_TS_MODE,
+		      TJA1120_TS_INSRT_MODE);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_DEVICE_CONFIG,
+			 PTP_ENABLE);
+}
+
+static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
+{
+	if (enable)
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_FUNC_ENABLES,
+				 PTP_ENABLE);
+	else
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PORT_FUNC_ENABLES,
+				   PTP_ENABLE);
+}
+
+static const struct nxp_c45_regmap tja1120_regmap = {
+	.vend1_ptp_clk_period	= 0x1020,
+	.vend1_event_msg_filt	= 0x9010,
+	.pps_enable		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 4, 1),
+	.pps_polarity		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 5, 1),
+	.ltc_lock_ctrl		=
+		NXP_C45_REG_FIELD(0x1006, MDIO_MMD_VEND1, 2, 1),
+	.ltc_read		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 1, 1),
+	.ltc_write		=
+		NXP_C45_REG_FIELD(0x1000, MDIO_MMD_VEND1, 2, 1),
+	.vend1_ltc_wr_nsec_0	= 0x1040,
+	.vend1_ltc_wr_nsec_1	= 0x1041,
+	.vend1_ltc_wr_sec_0	= 0x1042,
+	.vend1_ltc_wr_sec_1	= 0x1043,
+	.vend1_ltc_rd_nsec_0	= 0x1048,
+	.vend1_ltc_rd_nsec_1	= 0x1049,
+	.vend1_ltc_rd_sec_0	= 0x104A,
+	.vend1_ltc_rd_sec_1	= 0x104B,
+	.vend1_rate_adj_subns_0	= 0x1030,
+	.vend1_rate_adj_subns_1	= 0x1031,
+	.irq_egr_ts_en		=
+		NXP_C45_REG_FIELD(0x900A, MDIO_MMD_VEND1, 1, 1),
+	.irq_egr_ts_status	=
+		NXP_C45_REG_FIELD(0x900C, MDIO_MMD_VEND1, 1, 1),
+	.domain_number		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 8, 8),
+	.msg_type		=
+		NXP_C45_REG_FIELD(0x9061, MDIO_MMD_VEND1, 4, 4),
+	.sequence_id		=
+		NXP_C45_REG_FIELD(0x9062, MDIO_MMD_VEND1, 0, 16),
+	.sec_1_0		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 0, 2),
+	.sec_4_2		=
+		NXP_C45_REG_FIELD(0x9065, MDIO_MMD_VEND1, 2, 3),
+	.nsec_15_0		=
+		NXP_C45_REG_FIELD(0x9063, MDIO_MMD_VEND1, 0, 16),
+	.nsec_29_16		=
+		NXP_C45_REG_FIELD(0x9064, MDIO_MMD_VEND1, 0, 14),
+	.vend1_ext_trg_data_0	= 0x1071,
+	.vend1_ext_trg_data_1	= 0x1072,
+	.vend1_ext_trg_data_2	= 0x1073,
+	.vend1_ext_trg_data_3	= 0x1074,
+	.vend1_ext_trg_ctrl	= 0x1075,
+	.cable_test		= 0x8360,
+	.cable_test_valid	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 15, 1),
+	.cable_test_result	=
+		NXP_C45_REG_FIELD(0x8361, MDIO_MMD_VEND1, 0, 3),
+};
+
+static const struct nxp_c45_phy_data tja1120_phy_data = {
+	.regmap = &tja1120_regmap,
+	.stats = tja1120_hw_stats,
+	.n_stats = ARRAY_SIZE(tja1120_hw_stats),
+	.ptp_clk_period = PTP_CLK_PERIOD_1000BT1,
+	.counters_enable = tja1120_counters_enable,
+	.ptp_init = tja1120_ptp_init,
+	.ptp_enable = tja1120_ptp_enable,
+};
+
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
@@ -1536,12 +1670,37 @@ static struct phy_driver nxp_c45_driver[] = {
 		.get_sqi_max		= nxp_c45_get_sqi_max,
 		.remove			= nxp_c45_remove,
 	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120),
+		.name			= "NXP C45 TJA1120",
+		.get_features		= nxp_c45_get_features,
+		.driver_data		= &tja1120_phy_data,
+		.probe			= nxp_c45_probe,
+		.soft_reset		= nxp_c45_soft_reset,
+		.config_aneg		= genphy_c45_config_aneg,
+		.config_init		= nxp_c45_config_init,
+		.config_intr		= nxp_c45_config_intr,
+		.handle_interrupt	= nxp_c45_handle_interrupt,
+		.read_status		= genphy_c45_read_status,
+		.suspend		= genphy_c45_pma_suspend,
+		.resume			= genphy_c45_pma_resume,
+		.get_sset_count		= nxp_c45_get_sset_count,
+		.get_strings		= nxp_c45_get_strings,
+		.get_stats		= nxp_c45_get_stats,
+		.cable_test_start	= nxp_c45_cable_test_start,
+		.cable_test_get_status	= nxp_c45_cable_test_get_status,
+		.set_loopback		= genphy_c45_loopback,
+		.get_sqi		= nxp_c45_get_sqi,
+		.get_sqi_max		= nxp_c45_get_sqi_max,
+		.remove			= nxp_c45_remove,
+	},
 };
 
 module_phy_driver(nxp_c45_driver);
 
 static struct mdio_device_id __maybe_unused nxp_c45_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_TJA_1120) },
 	{ /*sentinel*/ },
 };
 
-- 
2.34.1

