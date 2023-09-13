Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7A779E958
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbjIMNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbjIMNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38941BC3;
        Wed, 13 Sep 2023 06:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCE18a5VPmz/ciBP1ZFcB/o0B+sKgKh6Et2lb3/Q56jfc7UY2E9MU1bNEEMkgCbK+vLk3EZbAET03rbR109cZSo6fxGfGw0sBsgN54LSWMksCWRzr5S5EYlY4EUpCYVLY150BQcs9FdOgZ6WswonBNkYq+ssbubEUE/E+9AsBo/gxNP5zB52TQX7BrREtYMWOff9qiUCpvTOCJNXuTgR91zVtqapSwXrhIM0ohcHExBNrpfG6kNp/tN9yrXwtaSvffaIm5bZx1Aaszl9U/BTEz17yUEBep+kvCBN50m7cATRiwhXtD4NBguPGIXls9FupE/m8YUpakpVlLL9/lKSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLtt9O2JoH4I0/BWHpeRO3ltj5l0syDmAHTCifx+saI=;
 b=R/b0DZTkVRfDJMMJGQmI2aypgpm4O4kBwCthhkHMGCgZqLGnvT4zlqYBWI/AjpZp48mxVLRWH3oX+VCC4KXktzs8z7poGkz5AhIRRbBAw1aFDItKbEhKRao4Ef9ehRBRRY1cgs7TPmwNriA82f4uhi/0qta+4uNLXq1hTdUcDen2I0K0U05+Z1Sjo9H937WF+ttwn88Rgr5X5eCrSOy1UcenHhsBBLMGM3vsUSkPEz7r/dTq2Ep0UrtSoZ4rJGRkzwTpLaij22i6boxVJI853XJ9L7H+Wwfuj+s2ChtlpMRFGkLim6IyIoen6GRDWrmUJ8YP1apewrOLxEAduw2sIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLtt9O2JoH4I0/BWHpeRO3ltj5l0syDmAHTCifx+saI=;
 b=AgnfNZh96jds3ajeXOoohFXYJbVIkqxhQWPgNpQM77+VDF1w0ATIglD+0L3Y33V5ssvjuk3zcY5/j3ipCBoLAN2MnE0mOeS42z61ZxHlfyoyEYF2EKwvTb99Opw/WQth2xiEWflWadTddiaKlGHfT+5lpMNOrSRKrFxledmJSB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:30 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:30 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 7/7] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Wed, 13 Sep 2023 16:32:05 +0300
Message-Id: <20230913133205.3749628-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 836e563f-5e7f-409b-fd42-08dbb45de09b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q25xZ1W02ebgERPe+YStzMqeJfNtbzZ6M7lwTCCMLc4HCnHZH06ByZ22LdFzB0eHYju5kx9XtvuiHAUiGLgf9dGOHvFrD7xzhWedGy6T484lVFaqmK57NERVcjBZITYfyYYjNovXPxwzBgCBHbjME5D+NmCf3OZuvJ7LUZQrbEfLGjmkUr6MmvWfpoOGYIYQekreCpdYmfZi+CsDAZfvp22aKsj8YvMPvMjN2seKJoukM1cEY6qw5ShiCqWWa6TVfsJOhVVEiPIrbTYFkuTQuRUPyYigo9dtazTjENypTrmWCO83vlpZb2Uskqn6SVVDtpfPgmzf9ThXBAIdBpFY2eBxzdYc9doCEg0UG1BwUTA880/vlzQDGkkgzGsm2WCKEojkOUE91yYtmp4XOEt8s8dpxz46+akCDoWNIxbJ1xBcW9CZGQP8XiunYERzNaIaygo9T0WjUCNCKDKna/Plf0Miiq0gnu4mDD7YqUcDJnINNP4rICn81DmpHWoMWAG0jhjVKckZ2K1OrMNXcBD/YPYcKGl7J5rmK2cgkGHDKTzje4nuJkhDbqWxNALUdQESmb9qwlSnTn9Nogq/yhipHnRqzWrdu/2E+s0iqbfr/92B4RGpWxHFL8b7ka2wDMK8VKa9WDpUzMG9zN8BGw9IGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(2906002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVr1hFJGAwlYRwg0YUH4OhvW7tSfe5E7Mn8NHBzoPHTy8r1QgVqKP4XzYdlJ?=
 =?us-ascii?Q?MNPQutJ5qpa//QNHUZFxzP6jCKg6MrbcEfSXGlRByBUV95KSHgqJine97HqB?=
 =?us-ascii?Q?BPNbNxTWEuNlAjgJHHMy7mtC+VV1YXtc3r/G3TH8yMbEhQtR3K9o7rLg4mEu?=
 =?us-ascii?Q?wrckwClzcWmemB5fRyZVU9+OrJmmXQDp9j8/OPFTlKEGseHzhT+p9YL8r5S1?=
 =?us-ascii?Q?TOmoXZzeHJXFQfizC/cCURGTxOfovsgRmfd6tVowSZ0RqpPyq1Qtp7zmDDP6?=
 =?us-ascii?Q?UeIhBIbglfTK0AzFsRekcvmcux68KmCzDjIyjV+bTEAR/sg9dfwJbTNz5keL?=
 =?us-ascii?Q?SBIP/DedTDFfaYBJBN1S1u+vwI4Ms93dItDwEX6Ro/1ua4hEbvwgroKSpnga?=
 =?us-ascii?Q?WZ1YlEXMihxgoP2IcqggPlmTo07VVFzo0eXnXvj8RAFXK9EdTY4AQQr9hdXw?=
 =?us-ascii?Q?bAC9tg6NgI9BhLOcFS6Jqw4F49lh2VsxZ84FI+wiGnfPcWc/odAq8T3HSS6n?=
 =?us-ascii?Q?IXJuhxbqKKG5GHg+ZZehYzBdBvch11URRbhNhG7EgubK3o4EkYK6fdrDHDjZ?=
 =?us-ascii?Q?BhjuYGpHPskaS9H+vcnpLxVJ2JbEBcnxYRnrvDgeEX84yVlNQwUhnkmxy3zL?=
 =?us-ascii?Q?bd3JejPtZdj/NwdFoPr0EOlXg5T01NyPxf0+xusYW+07XXRJkpkQ4rY7b/pY?=
 =?us-ascii?Q?KAC4DSjgLMa8hrqswS8Kv4jPAoOVZk1qRKMAsZ3LqHmx43s0PAiC3JMIh5xD?=
 =?us-ascii?Q?LdPTPUZJWS20RRGn7l9/PvWE+FnsUHuMZ3yyFe8WWT9mqJ5fW4Vk2U6XK1wc?=
 =?us-ascii?Q?mwdavI+3NhlWsvk81cRQSkI1p3GtVa60BDw5Mud/YxiOZl9G7DRE9qIpi52s?=
 =?us-ascii?Q?wV1U6WlVIYtQZ/HZ9KxRnzhDBwjhmizMRgk3UqBMj/vFppZiYCFnZuS6hV53?=
 =?us-ascii?Q?u/pDY/pUqvKYdasx2jdSmnFT/1Dq0ebrA0jvHlWmSQTYZ1W5OIG8E5QTOxRf?=
 =?us-ascii?Q?n6f9qnTCRn00xsDV3VnDtZ901k+xb2b5DTjtX3heeL+8zgUk0vtwRC21mxgh?=
 =?us-ascii?Q?DTtciNh3vZHIss1scVHgP0DVxWo7yxncbwpCA1ry32psZSbSH93hPzKPnp2Q?=
 =?us-ascii?Q?aXsO/Zal3WyfZv10mkGKdnxFNmOfLrDdu2LIlZeFCllCjN4BSVFwIKdjDFZt?=
 =?us-ascii?Q?TlHWSadumBh6EsUZQXWykHgHdRkcwyFVTocsks5OUX0NyVicsH6ZeeFNYDoX?=
 =?us-ascii?Q?eGUUryk7abWNbJmLBF8cTk8IYoP4JqecmWOGR2Qlvs9VVTjn0BlOtcYV4sqr?=
 =?us-ascii?Q?XXIGueVnvf5LkTRL/msahMvW/wNeoCS6qbuPSFyiVSai1pN/WGb6qQW2swov?=
 =?us-ascii?Q?WeLKAewyE2bTMkO5KaCaELucEEka7YsE3b6/RaOyHGxDFyiuWxuyQvmxuw/k?=
 =?us-ascii?Q?jPmIfBJrQUB889N8ORM7Hzl9F+bHLVSxN90i3vipn5c5PZy2V3bo4lntvBKv?=
 =?us-ascii?Q?a2WAo6JofoOjfZy1IG5cTV6AwwNVeSoWtR/aMCO2OOfn/854KgVJAp+H6xTf?=
 =?us-ascii?Q?p8VTlQF4s1m8uUjtkvKuhH0hhG2Fw19MbDgv9KLPYCKiQL+LMI5b2tAfNsP7?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836e563f-5e7f-409b-fd42-08dbb45de09b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:29.9947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVAipLvXCkj1zrYfrsCCoF/BCdou9x/8gSnfhTj4p9OeVMSocglKLMvf+ognalv7WwAQ8Xj1lA80OgS6nN8GnSaysPFJdWFpfc2NgHeUDVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in V4:
- removed macsec_extscs parameter

Changes in V3:
- extscs parameter renamed to macsec_extscs and improved description

Changes in V2:
- added extscs parameter to choose the TX SC selection mechanism between
and MAC SA based selection and TLV header based selection

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 3634b6cedf24..a9f587d5fbca 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
+#include <net/dst_metadata.h>
 #include <net/macsec.h>
 
 #include "nxp-c45-tja11xx.h"
@@ -118,6 +119,8 @@
 #define ADPTR_CNTRL			0x0F00
 #define ADPTR_CNTRL_CONFIG_EN		BIT(14)
 #define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+#define ADPTR_TX_TAG_CNTRL		0x0F0C
+#define ADPTR_TX_TAG_CNTRL_ENA		BIT(31)
 
 #define TX_SC_FLT_BASE			0x800
 #define TX_SC_FLT_SIZE			0x10
@@ -166,6 +169,14 @@
 #define MACSEC_INPBTS			0x0638
 #define MACSEC_IPSNFS			0x063C
 
+#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
+#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
+
+#define MACSEC_TLV_CP			BIT(0)
+#define MACSEC_TLV_SC_ID_OFF		(2)
+
+#define ETH_P_TJA11XX_TLV		(0x4e58)
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -1537,6 +1548,31 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
 	return 0;
 }
 
+struct tja11xx_tlv_header {
+	struct ethhdr eth;
+	u8 subtype;
+	u8 len;
+	u8 payload[28];
+};
+
+static int nxp_c45_mdo_insert_tx_tag(struct phy_device *phydev,
+				     struct sk_buff *skb)
+{
+	struct tja11xx_tlv_header *tlv;
+	struct ethhdr *eth;
+
+	eth = eth_hdr(skb);
+	tlv = skb_push(skb, TJA11XX_TLV_TX_NEEDED_HEADROOM);
+	memmove(tlv, eth, sizeof(*eth));
+	skb_reset_mac_header(skb);
+	tlv->eth.h_proto = htons(ETH_P_TJA11XX_TLV);
+	tlv->subtype = 1;
+	tlv->len = sizeof(tlv->payload);
+	memset(tlv->payload, 0, sizeof(tlv->payload));
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1557,6 +1593,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1577,6 +1616,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = nxp_c45_macsec_write(phydev, ADPTR_TX_TAG_CNTRL,
+				   ADPTR_TX_TAG_CNTRL_ENA);
+	if (ret)
+		return ret;
+
 	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
 	if (ret)
 		return ret;
-- 
2.34.1

