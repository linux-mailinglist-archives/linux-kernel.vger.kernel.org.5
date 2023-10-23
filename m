Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0611E7D2ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJWJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjJWJoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:44:08 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D9C2;
        Mon, 23 Oct 2023 02:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMF3bpmt/hjwUQw2xiewemalXwL/UXWSYQrK94ZYPwdMYqKTt7pW+V6CB0UR3cDEyhV7O+rQHVmpJgH1GvBzP0q2y0SjT1FXc+pf5NUY3qpliXn/RZIKc5skQzU83/R03fhfbxpzf31IYQ0F8cvYVzNwt3kmOPoyIHi9IG7xwapd9ZxWc4P1wxL4tEuVRIXk+Mu0xLK+hSRXg93hr+C9N+qCKUuUrZ5i8OKsH2w5RSRIQvGt8Xcu8kg1YRDQNHXksXwXz1+qized5iSHIRmTeHmLljwY70N/5eKGBfaaGonPMB8dMG6wVuhHC9ehNMWvJ8jX1CZEG+YEg2GDkd6S6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syLR/2p73jSA0O6ZYfKDQwgCZJxVgqgjijNib+mZFqU=;
 b=N5U4iP6hUwYydGcD016Z7iolaEJzsu/mYWcTxq9M8S+zbib4vfHEXflZs4h+I6Ek1eL4VHCO3MZLHP8h8yMsyi+jeSvFnZJX4BQwhJgQnAt0v4afWfHoSJ4uvdkCXEdViuKQ9zeNCrBwnx6+hP5qLP+LuC2p8h207J5XpUbwpdCc1S8AmuYGJ3yxWZ2Pss7YWiDEl7lvzG76xfRgTUnFy1QBERwEFKH57COFeWtT1eci7Mh4lbWN4P25P+pvMV2k390kQO4XhaKPTTLK8ok5AFcrSN3an1yIYXMIy5ZcSMj77pg7pINxtEpv+FAzI8jVrbrFzbRwuaJuo/632HhP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syLR/2p73jSA0O6ZYfKDQwgCZJxVgqgjijNib+mZFqU=;
 b=mRlbMiffjHXQs8ga2wIqEC6Uy3FI0AM8olGb+Y/CPuFpjpsHUYL0OGBGZhvx0S15ApQVzrFYk2WLZ1/mioJ3YxcC4ONWIIld1ECz3XDFkkWTsBzWTLuiOtJTgykftvyLd1Mwsz+uNg4a47HotRoH3fOGFz1+NsXDPlR1pdf+Dco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:54 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:54 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 7/7] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Mon, 23 Oct 2023 12:43:27 +0300
Message-Id: <20231023094327.565297-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: b4438ac4-2847-4f88-3973-08dbd3ac91fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zaUGqm1QbkeFhmCFeJKEDohVgE+h28SBdTKtI8zze0TrC0Im5r0X8JYxl/3AWUaDOgPeBY/5Q2HZWBIBnYoBF7kkdJZI/goBEqZ7/Oqgz6ZMvfUmPANTAZeecO0LU9A92+jwOwPfwY6kzdSTHY0wULHAzvJ3Co0jQp0cKl3GEElrw5bfm+FyGnyI3S53tXwinaHF6yluic9ZYRVYAQNZDjrFsjm5AZQkmfXPxE70CKQUosJSC+/63Ubzlsz3+oreRTRVQXoIk0ytmh1qMWV9ldvDcOqxLXmNgOtmyyOzQuR7G/+l0/Hg4dUCSS37DEDWx0iA8aNokNPv78XWeO1+cBXwrZbXUod0JQMRVFkQljHrrkTYc4SQNOKu1Il5OfrCKxgvkaFsFQmFzd9amOW9KwXZS+rNHJI6XQK9SjeJ+rBdsoPFTvb4knEGm7y41X+Pkeb3IAlkTMO09d1wyotQTZnhmgyXJBobAKHoPheX2KODP3znjQQgBA6KgtA6CAQ9U0O0/9mCW1KNDZ/ZAMoFD3+Ht0ZCFU2wKOwvcASzD+LyEW7p8rkxr7/Vzaq0ndm0mcQswrktwR5FHzvlrfAfviKZOvjm7B+fBsgevBrhIxUPPiIKrDy8ZefeJNf+DlN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(6506007)(8936002)(6666004)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BwEImSvRVIccV2EgjygO2MpAivi0ZJBDXSaqpfzJWmZVmi9jMLvoxmq+eWji?=
 =?us-ascii?Q?VAPZDw8Phk7Wk/5OA4qfFGlZsrfha/E4PzoIOHc/7cOjK/h1EliQmoOA3YdR?=
 =?us-ascii?Q?b6qiOFPrXA9fFKKSBn3DEQ27ftGOqgR1B7WFgxlDSqZazIUcCRa59pXWTS58?=
 =?us-ascii?Q?RyvyA7kOxFU91z6NWd5DCXbBy41pw+OnieVogq1NIaCZTAyXpuZCh+bPuEqB?=
 =?us-ascii?Q?eKNMLI4kDvpzzdzpLjNEewiByVMHsL0BV1cKAx2h1OZcG6KG2XL3hciYPOHo?=
 =?us-ascii?Q?b+11TkD7VqRXlNE7+ob5Wh3thuv0BZtNG2ZsuqEitDYXoAbyAEo/ro6swSux?=
 =?us-ascii?Q?yKK4KtCF8kqGfM0U23G76nBfY/cn4VQZvmlWHmtpJ4d/6u/1UAZ5eYINsYT5?=
 =?us-ascii?Q?X0hDrZithU/xvehP7JJtp3QCjROZ7yOhIJ/IkB8Tzey2DvHzW3Hlont7Xad/?=
 =?us-ascii?Q?wLP9MzRcMo7caa4ArbKYf/rhYqCZlR5ukRo0BzOY940yxg+oyM2RODwLHavo?=
 =?us-ascii?Q?OLjFTopqq7piY+XMsxgfs82kIPteqcP95B5zX5SQ6cS6fTrPxff8lRX/v6Mm?=
 =?us-ascii?Q?ZRpJJ+HmmWklpMKhjSlqQsEB3NRy2OBBnXW0q48IVf8yjRXsoKMENTrh2BL/?=
 =?us-ascii?Q?2WuA8K7TV9nFepB6dkUkkHAn9XcnGGC6XqYKrsuoIGqJk/p+qJPczRofBmRp?=
 =?us-ascii?Q?uyB0av49qKkF0fL6JWRvNkyZ7zm2Od3Oxfm2ATAOe13b23YI7ucwcBbL6Gtb?=
 =?us-ascii?Q?0N0QTcCiX3rv5spk43Vo79OB6aMRI6LQ8x2T+ePOLr6DrynJB7JslhTLuhmU?=
 =?us-ascii?Q?NHhJXiulbrz4ouuT4qb6KTPNXQ/FtT8Q23VrAuzn1zmcPvgjxMzBDkCyY7VJ?=
 =?us-ascii?Q?TgaDYVffjCTJgtQqQ7DSqA9sUcADjfEDWhMZXmdUbAJLv5tKgD56n82lyWMO?=
 =?us-ascii?Q?MdEwLdCLzz6mQLvkOfVl1ZMKgzkHCTNnyzIvjo+COh35pFzknIiHApREY7a0?=
 =?us-ascii?Q?tYYgnLycMBcOPkR/K/t69UaUVHDf/5EZWY2u4xdJ2hO106mgPzwDOaBse38b?=
 =?us-ascii?Q?dRcqMKepsLGVyXbQ3+89geso94mUbfvUshap9M0qWKsdIrZIP65yUG46/3Yu?=
 =?us-ascii?Q?N5+regquR5ZZDDYEBS6Ax5jcRzwyTqeN8QPZtvV6iqLTITyQdrciSzwm5OkN?=
 =?us-ascii?Q?Flwa0E1obVVhHvVCo1yj7dbzv90OmUoON52IgRn4VDgv+YSDsEJv1anXYWCM?=
 =?us-ascii?Q?gYpHmgkcSDReDYUWQbKrY3FBwt2aAL2u/Le80cs1G/UhemF9ZyxnQ01vNGV6?=
 =?us-ascii?Q?2Ww+A95e1+ANweZC6o+sbCdJ6QvfMAFCq1Jl7WfKSV1+EBjb0qUuL0VZZZm0?=
 =?us-ascii?Q?33tfOzaT8phOeEkGl7qFfYH0pn8ay75GOlvY+fL7Af/0Pt8emBdhDtSLd1Cs?=
 =?us-ascii?Q?eA9I9c6j0sXwoiT64x3hDVPMnQlGog3KJ76ZOOaWAGEg2hMAeqzOOWnVzcfI?=
 =?us-ascii?Q?OZqXOfYY5gBxoc/WxF3ZmwzEymNv0YALpjhpCUr6tCbZ1gN3+hFLSdUulaNr?=
 =?us-ascii?Q?AjPZedchDNnvCSfq5z4FE3aHMM20dpfcXc82Wx4nEg0wh0DiBWgqrnno+eTA?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4438ac4-2847-4f88-3973-08dbd3ac91fa
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:54.1755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2WcJsi4gfoi9cCV8ViRPypnbmr4fxaoCmoeSlf5gKUzTnTBtE0vxhSmjxiPc0W+CaV6+zyx5AdQFEEYcnbaVFWfX163/9BDuCb45N+X1U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6-v8:
- none

Changes in V5:
- removed unused defines MACSEC_TLV_CP and MACSEC_TLV_SC_ID_OFF

Changes in V4:
- removed macsec_extscs parameter

Changes in V3:
- extscs parameter renamed to macsec_extscs and improved description

Changes in V2:
- added extscs parameter to choose the TX SC selection mechanism between
and MAC SA based selection and TLV header based selection

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 4dd10ea6e06c..6ff0ceeeecd1 100644
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
@@ -166,6 +169,11 @@
 #define MACSEC_INPBTS			0x0638
 #define MACSEC_IPSNFS			0x063C
 
+#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
+#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
+
+#define ETH_P_TJA11XX_TLV		(0x4e58)
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -1541,6 +1549,31 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
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
@@ -1561,6 +1594,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1581,6 +1617,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
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

