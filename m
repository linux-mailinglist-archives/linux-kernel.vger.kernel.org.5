Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E1769167
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjGaJSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGaJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:17:40 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C98197;
        Mon, 31 Jul 2023 02:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyUOR5WeyCM5q+5PF0YiOGuK0sXFnJ8xdKjA0THY/nzIFHqNGoqXuiehRfgZEPPqrLBcjV9bqqqfpJvf3/p9gZRH4gtKUt4UK7Z3chcuZ3H+uZcdbjws6FCYuQQS0k2kRYBTC0xwrO2iN0NkqgFgPr+IO3n1QD4pKDdEzax7ZjNSuLwdxUwIaziL7o6iUaN5tPtT+tKf5WxBst+VojIfEm6IKJDv+lzEMq4L4DbCb1IzdYS5xSQ2Ia3w+gcFKwTyOYG7PB6MQJWxAbucjJbbN5p3bufOB908Yr91Y5LXyEtjDdbInvo2mdyHtht2GNjgiCYaqX24gd7jnlOuFqIyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwfGeWX9xq+vcN6WAF1CVNsr8hWKROMKoG6lgX56xxc=;
 b=DmoE3iOqymDXv0tn10zPp8eEJWPc+SCML4h5M9IBnq8n+6n98MOOeXyCU/drUih1ETasYxkJa/pl7ALH3vx1KvnP/ss/Jl8OPx5kKW+Ux2eKkROILk5ymzP6XVdXfsVgz7wTzW+lcq90mjTe1fDFKxV/34M5Z9Fvtx9BO/zexlelAqQLkkCFIuWCfVYUBVpiuz4IAlE21U+1EuBb/P3JQINp8FUWjnFXT0O2FD40vHx137YJSJBEYnCjL2hMlPomNhyK2sjUcaq5W+qqBnYRVuE9X6aBXYZfwnQ0KwyvlbdJYU69koWjLC/H9POAx1w8/Px8QZgdct7WXUIxRTA78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwfGeWX9xq+vcN6WAF1CVNsr8hWKROMKoG6lgX56xxc=;
 b=C9lXXm0peAAYg29PwjC0SCGHa4ZXNRGuYl/XYrBjaYaGCB+j3e7MTsfgcXviLlbHlxHbu5nApOI6JqyD5MC51E4N1sonioZp4FfYEBSzew074+tVXmBEQJoxNH3YyErQy45dFuxjK4H5s12oBJutuNZ1FFD1OoKleWNTPU7Nvkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by GV1PR04MB9085.eurprd04.prod.outlook.com (2603:10a6:150:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:44 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:44 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 08/11] net: phy: nxp-c45-tja11xx: handle FUSA irq
Date:   Mon, 31 Jul 2023 12:16:16 +0300
Message-Id: <20230731091619.77961-9-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|GV1PR04MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: b2996c67-c524-4a96-4dbe-08db91a6dc07
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I33lHCvXQHV2RvZ1GR5GYRNuCL9eKbEjvy08ITlWww38Df87LCa0ffqCZYq6up81Mh4H7jHZbCwsV7OpoAznLJNHGDd6yT2vJJKA0wI/mwJUVzH26OwIRFGpxxYgIPMUu7iE5QUK1++hAjwKuzX8A9DHwaYeBoDLtpDzdP1gRYOovKQ5K17gvUhJiHwXB0hGcU8r+pThNrKwQdfGjBrP0bzA3OwO5aYuQiofWmoGAXL1zDx1oIcUn/k011a/kgzL+oPOwHBbSz0LBnmjnMHjLHpdCeRIJc5MoY3KyA3mAhwf8HZMYJWC+YA8FyvOUVI6RkaXsntcxxSKnWpO7ONv/5x8Qb7xkTzitSUesLa8lkHywyWzwFFB3g8tM0qnStm/EycMKDszpBGoHMexMrZm46PM+51Wj1opzRUk8v4z1AU4XQ9Qe330sgeool/qoEzA2Yl7SPkHrMg2TW0laj/5e+GH2hZipSx7lJ9TjnkTBAig46y7w8ajTLnB8eomAE9vfNwyAqehQ0Ey8kczTTdLISqr/fq67uecsgMHbPao5gH+x51omfstxInWQeyvXft7VLJfMoL0+Gp8UVFIi3H1z14hf2xdSUFRK035kclpOjo7BQpo8neeCW/1QuDBz47P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(451199021)(66476007)(86362001)(41300700001)(8676002)(8936002)(316002)(5660300002)(4326008)(7416002)(66946007)(66556008)(38350700002)(478600001)(2906002)(38100700002)(6666004)(6512007)(52116002)(6486002)(6506007)(1076003)(26005)(83380400001)(186003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eYC34yxvO6sKHJc4u44GKO+MK31+OJ4Ez8zmh6rWjljRAdedrczYPZaGpaZ4?=
 =?us-ascii?Q?UfzHM7xviHw1ebPZU8xc1kjdI7dxLri09eTlt11j1dZZVzbM4VYV40BlbDrd?=
 =?us-ascii?Q?8ARa2G3CX0pjKbGFapcd4KUydDnO/R3Z/ajezAjKS2n0RWfQ+dQWjg507tDD?=
 =?us-ascii?Q?X85ILqvU00qrD6h9bsVs5n85tRxKSa+2dtEs7/gJm8ruc2W2hYjpuZ+mXHQJ?=
 =?us-ascii?Q?djG6aIS+fHnPNvhwhntOMsvENAQ4ZIep4X3d/49hejKV339Rvam5zVWSzT+R?=
 =?us-ascii?Q?ySBQuyJyP+LIbXx2SfMLmT/cpMNvtB/64SYIabyxWX8gZRqMvt1j7WrP36rU?=
 =?us-ascii?Q?pRnK8SferiHvRrjmonDb2mEQlT8xkeGWQqRlVd2eaJgNttf+Qvlt6CZihbim?=
 =?us-ascii?Q?6HpPyVaLiwfeZciZG3s5iCh/IsxDma+jduZsgyknbkWWM7s2kAfBcAFcZAya?=
 =?us-ascii?Q?io/ha5Qu3r2e0CWrEzXdbLqaDVLCbsuoeISmu0s8OdzwPur/RfEdNSHynEa2?=
 =?us-ascii?Q?6qlJsaHLV88GcU+NbyTzLwFWDiDCjwCf38bx7Ms5Xs3+R/W2Eywf2xnGUxx1?=
 =?us-ascii?Q?qy1S5JJhumTAxY6Mk063LEqX6I+6Z2hppW5srgneQyfoG+zmKnXPouEiyjfE?=
 =?us-ascii?Q?yUYd5t9bQrAmZmK876txyEG+GLxkX9x5QQb3oHh2xMsYf/rDlPG+pzRK/rdB?=
 =?us-ascii?Q?Cl92+YU6zuabNXjkB7WPvWrNef7kdqE25Dz0JCo/k/hotgTuQxhZMh44I+jS?=
 =?us-ascii?Q?9ZkTWRd1aUSJ0ADGO+CgL1W7ShLJTYH6iL757gD3xSXlxMBytYOdBKUUYlAP?=
 =?us-ascii?Q?LmcqSZnn/UEZOa5am96AjJjs8hH/EGhZS+xKei7rYzg9q2FOP9kY6VaXjqwT?=
 =?us-ascii?Q?RdsUnHs3Xp+jevLJiIQUIPeQgu80fi6psc5fIjSL+VaisSYguIkpStKiwPkT?=
 =?us-ascii?Q?U0JD08wC59c60uIiQqXxaIvlBVneuyRpRlKZvZVbSJ06tl7wYbLG16y7GMpM?=
 =?us-ascii?Q?VP5hWnwnq6KH22FkGlCzM2K91EsYvQNVTiYoXUCeJfi7f63jBV6R845IMSQZ?=
 =?us-ascii?Q?NCqmjJlQYGTq1gTBeK769tXC+sfgQgMR/gJXjwmRQSMGRQ0ILHmJ7r5F/D8y?=
 =?us-ascii?Q?+TZ9t2xEJVj2P2rPIyxMhKUibEGaXDdiWvTAJVZ+uxPalRoHW7+GZWW3d+wH?=
 =?us-ascii?Q?4gu56+c7NGC2t9fZgw+Pkbjk/t1lRKiKeHUAt+N4qCxJvk0BGHCdfOvEQjKQ?=
 =?us-ascii?Q?2rfs+82d+0WssF7Vw1Ne/d9o0wJJGaedIFpPOTnwvjfe0n0N8FOhCz2bOFfO?=
 =?us-ascii?Q?ciPU1P1ZSA6vpqpjK+7Bah+BxB14zU9FrlXRZNE++330iNvRRz2kx0dLd0pZ?=
 =?us-ascii?Q?EsGcsgEBXtWpvVoWcYbvX5gXwe20+3n8nc6bR4bWIiSmc31udeTwDr8kwuOq?=
 =?us-ascii?Q?uBTHyPTep5UJ6aPL8+4hOniKkZguYOdZ/DbHVThIjUzh53GViG39iXGlVGlb?=
 =?us-ascii?Q?oZ5IabBqUJqoQpmQ8g1SXQZMq7sok2G585MSVVug7Mq/yF90xfFK+uksfcjU?=
 =?us-ascii?Q?igiJe8W8xu4UFvqdUHIsFWPxHvRU9a2u4Q42BpdsbVxabSbffk1Fm46Eg80t?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2996c67-c524-4a96-4dbe-08db91a6dc07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:44.6732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkE2zjvP/T6JBpl49uTzSHKN9kJ+UTN2TGXnWw4P3dGXVvKyFWBcKj0utYliehO50G/rAasvQZldhhxs9W/aMvLKgxzgEH4wwF2Io8Cp+8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9085
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TJA1120 and TJA1103 have a set of functional safety hardware tests
executed after every reset, and when the tests are done, the IRQ line is
asserted. For the moment, the purpose of these handlers is to acknowledge
the IRQ and not to check the FUSA tests status.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 79 ++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index e596ffcf8683..a52067da9dbf 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -29,6 +29,11 @@
 
 #define TJA1120_VEND1_EXT_TS_MODE	0x1012
 
+#define TJA1120_GLOBAL_INFRA_IRQ_ACK	0x2C08
+#define TJA1120_GLOBAL_INFRA_IRQ_EN	0x2C0A
+#define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
+#define TJA1120_DEV_BOOT_DONE		BIT(1)
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -39,6 +44,9 @@
 #define VEND1_PHY_IRQ_STATUS		0x80A2
 #define PHY_IRQ_LINK_EVENT		BIT(1)
 
+#define VEND1_ALWAYS_ACCESSIBLE		0x801F
+#define FUSA_PASS			BIT(4)
+
 #define VEND1_PHY_CONTROL		0x8100
 #define PHY_CONFIG_EN			BIT(14)
 #define PHY_START_OP			BIT(0)
@@ -262,6 +270,8 @@ struct nxp_c45_phy_data {
 			     struct nxp_c45_hwts *hwts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
+	void (*nmi_handler)(struct phy_device *phydev,
+			    irqreturn_t *irq_status);
 };
 
 struct nxp_c45_phy {
@@ -1162,6 +1172,37 @@ static int nxp_c45_config_intr(struct phy_device *phydev)
 					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
 }
 
+static int tja1103_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	/* We can't disable the FUSA IRQ for TJA1103, but we can clean it up. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_ALWAYS_ACCESSIBLE,
+			    FUSA_PASS);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
+static int tja1120_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       TJA1120_GLOBAL_INFRA_IRQ_EN,
+				       TJA1120_DEV_BOOT_DONE);
+	else
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 TJA1120_GLOBAL_INFRA_IRQ_EN,
+					 TJA1120_DEV_BOOT_DONE);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
 static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
@@ -1193,6 +1234,8 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	data->nmi_handler(phydev, &ret);
+
 	return ret;
 }
 
@@ -1599,6 +1642,21 @@ static void tja1103_ptp_enable(struct phy_device *phydev, bool enable)
 				 PORT_PTP_CONTROL_BYPASS);
 }
 
+static void tja1103_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_ALWAYS_ACCESSIBLE);
+	if (ret & FUSA_PASS) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_ALWAYS_ACCESSIBLE,
+			      FUSA_PASS);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1103_regmap = {
 	.vend1_ptp_clk_period	= 0x1104,
 	.vend1_event_msg_filt	= 0x1148,
@@ -1663,6 +1721,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.get_egressts = nxp_c45_get_hwtxts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
+	.nmi_handler = tja1103_nmi_handler,
 };
 
 static void tja1120_counters_enable(struct phy_device *phydev)
@@ -1697,6 +1756,21 @@ static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
 				   PTP_ENABLE);
 }
 
+static void tja1120_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_GLOBAL_INFRA_IRQ_STATUS);
+	if (ret & TJA1120_DEV_BOOT_DONE) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      TJA1120_GLOBAL_INFRA_IRQ_ACK,
+			      TJA1120_DEV_BOOT_DONE);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -1761,6 +1835,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.get_egressts = tja1120_get_hwtxts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
+	.nmi_handler = tja1120_nmi_handler,
 };
 
 static struct phy_driver nxp_c45_driver[] = {
@@ -1773,7 +1848,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1103_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
@@ -1797,7 +1872,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
-- 
2.34.1

