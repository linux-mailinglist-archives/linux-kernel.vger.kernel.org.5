Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603F47D2EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbjJWJoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjJWJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:43:57 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0646EFC;
        Mon, 23 Oct 2023 02:43:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUXsqBCXXGNd282RYP1EZk38N1+vGcIgOgMIPkwXiKv/ksx9oCleoFQniw4xGn5lzCQH3s6oRv79JU1/+kE5mEWzhCW9k5Xxr7b8nLd4rkDqkUeiSXzBab6f90kp+KTkqKZnnys/IHuvvLMfOPNUMqs4czUp1W2SUANnMwuows9NK149NzV3W7/f+rLmL2lX1jRsKcbmfey64eMD/rbqB3jRT7bTFbUrL+1mlE4HIwrpsC/FzSIYCJ0pqLikkdZfBhhcexKkQ0cghnoygrutXXTGI8628m/AErZWlbzOakfeCkkxYmLhnvfy9GA9C4anb8C8amgDQXVXSVZVqF2Snw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWVkFEwng79dZwgW3bhbDK4BZmAT0XTTv1V8NR7PuBo=;
 b=ifNST2UAT9z1M0ZZML8LNMKcJLmL2DFsTcUq34HLuCT7JGd3bDE8ShdInhO3EE5Qr1zdqrjxgh1zT3TITEvuR+qT/OaUvEPPQKfnC3OD3Rn/RcxT4HJ0xtt2SVeLmjgvU0oqn4u649R6I0uYcuivR/RAjx7r6Lh/1GyTDj6JSliuEn61dn90YYCHbRql8DuiWIEoiR4N0J9sztAYA4c4uZ1yNJfk472/ELBO0LfTe8U8IuPVoGG+rvBXXDOc7V6tHDWau2ylDk9AllniGyM8QEzzJBINodub9Oxi/REH0vIlpJNjIWXxYx2miXTO6LX1ae8RgYiRagKAWp2WiW2DCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWVkFEwng79dZwgW3bhbDK4BZmAT0XTTv1V8NR7PuBo=;
 b=k3OzcMf+ptcnQoRjDQqjcgfw383RCOWeshANTanEzmR9qxLATAgVSxbNVmYqr/6wKz7tKvCibqfKYXapETq27ahhS3jUnPaK+qQsiffGifEgNLlDD+DZ4HFFAppaqXYM6NBDWifIuP2WYPTprVDFUse8CE5ROv07uFR64aHUG8A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 3/7] net: macsec: revert the MAC address if mdo_upd_secy fails
Date:   Mon, 23 Oct 2023 12:43:23 +0300
Message-Id: <20231023094327.565297-4-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2eb98cd-5512-4ce9-51b6-08dbd3ac8fad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaZQ7ILtGu1zyOn9Ub/G3X543H6rFU0UZKno1sL+TXb9gi5YxtIJ4X8kIaaYkKIYUGIc28PKKCFg0oYBugWbUuGWIO/0PnTGwKwPTZM0fCk76NoOFpGtODfUzSh2/6/dxJBqWIdedEnU3HJemIrdW+emHYjLzboNR/Rl8RhElcQq09FsoWgvrmnyPL9SJKfXciZbalUDEu5DNzRRNNZ/SDbCK7EI+E/ecA32yjZDFkSbDK3KrMFxLOZ056xhCHyAVZWWU+syXdBVA1U9uIX4mEfbsAeZPUoygydBHsw2JzS57bbKTJs7GEqwX9S+dQrHQp/J5Zgbg2TRibvAJ8ijYklPFUKic88mGxuBfxR9XjlqeyPOmQPio8BmCcTMufNuVloHe/QgZyub88GTboeiAzVGbuYFnKoFrdCPCPgUI0OGBmWGd4d/bhx27UwLMNN2y3zmmVpERwvh1Cft64XLtUBGrhAAOxizCP5rNUZYK2DSxxkxg4wGFhGY1tLov6VQSa2A6tqlYZHXgVI22Stmtr2r/mNqsdWl2Pef41af7Dtz/TAmfQVDTR7h5K9p5lh+Wnbv3DQ8+tu3NGFZeZkgsxXpW+G/d6SAMPOZnSytaTvKnJyXcgtmfiGn/wx+MqOo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(83380400001)(6506007)(8936002)(6666004)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7MCr809B3zDvtdEN+244r4ON5lxtpkvUkgystDP+rytskY6SnXGxYKTD6A/c?=
 =?us-ascii?Q?KOoMP99yiLA4dHI4Mg9cxZ4NP0hJPiWI/0YPwOU6c3EKAwVeyWeY4k1zVWIN?=
 =?us-ascii?Q?8LXqDdTX8h+FFKMwcZLJSyIRXG6N0yd5EwzrriACX6F0v9254DexL8LtKwwU?=
 =?us-ascii?Q?002agETjaLzDbhlUAvFP9gaMNqtuO8OJ0k6fSC+f2b8z30u7KQ7UUUdzVs48?=
 =?us-ascii?Q?hPi1R2g5fby+OS+5fTg/7fMpHGifgoLVURWSC0l6kSCxygVd2zaQ7m4E38BX?=
 =?us-ascii?Q?lXU1EiUn236P5gJ5q7j/gEaadNXKJwaSk3of5r5uo4vCAjYbmreAWdBGyQYJ?=
 =?us-ascii?Q?YcomTWPLw+cHibZvqTWUKkVg7Xy+nwFzRqcdbKXES9SWQInMF1zFiU2swX5i?=
 =?us-ascii?Q?fnfk4Koe4/0TeRA0XhK15T03K2XRLt0cc6KrPOClbgcT2MyiLvVQdrZOMS5Z?=
 =?us-ascii?Q?yKMb0yrSBBPEkBSm7ciE9/onHxZ3m0qo62BQq63Q69S42+lql4tIRIATOIS0?=
 =?us-ascii?Q?9W6oqLidakPwmAR28FYSXbFIeFVVco6zWQL2r9hC5I2shzlljnRiPEn66nTp?=
 =?us-ascii?Q?14ITJiwvlsB2Y1VfBI89+5LGzPptoMLW80UOcGQA5vOiD/lMAFVqqHm9KJLK?=
 =?us-ascii?Q?rzpO4zXYiWxnhSqbn6+yjTR5/+T1iO1QcfZKwgWpGD+9CJYHmAp/JyWjFxrb?=
 =?us-ascii?Q?EpuMGPM33PH9829+2FennW6fLuciKGsJBZbw8jbveotNmWu39b9Xhk4clMHt?=
 =?us-ascii?Q?vMCo0GF+JcNV08EI76fsmf23D/IvIvipfFi9jD4KdalbsFfrjV1NdMQsR6Le?=
 =?us-ascii?Q?xilpDdFG/1PnP4clMmFocBLQp0wWYVwRw/RJtqLCAEYdMXdH7ORKWzRhvYQ4?=
 =?us-ascii?Q?IYj2cjiau2u6Tc4yRc9zdXWu6guQR4jCtyvvU1pGpo1yx+4BPuQBXgp6rjV9?=
 =?us-ascii?Q?3i3YM3QeunyO5WzZWOqI+yD0ucs/zAdgV3+GR/dYR9iXeU0RAdOX+6EzUA9C?=
 =?us-ascii?Q?CihbkKGJb0HkgY011IThXzPCSuaiwYX4a2e+B4Sglf0EEuFM34QX1IKuSi6+?=
 =?us-ascii?Q?L6ukuSuEP5mhQrCwMJ7P/eSvJ0VFdIDUesewB2LIn6OLXrPdCRkJ6K1KkpVx?=
 =?us-ascii?Q?K5fUsfN0ovegcVeGYtl6u+g0tMG76p2vcyKrT6LHBaNKC9pCntCn7wa0Tv+6?=
 =?us-ascii?Q?uQZ5V5LjEL4DrOWRLFrCz+YsK4w04B07nt0BV59HD9aYXth8RuVkBQRD3q4N?=
 =?us-ascii?Q?H4sYVDHokgwed/BedkNcMNIg9NgbQ1AHD3hAffdy3UG8JHOFE9LDX4t8LBhl?=
 =?us-ascii?Q?ED6xh49p0dNhsFdikDGvJbxir3GswgvWNFkq4/qGE29jdSFuClaV6y/IyRgf?=
 =?us-ascii?Q?0/VMF9e+yefZRFn3E2pazJS8Hjv2U8UC94K7O4J551nGa9iyl1tdjwRqKmu7?=
 =?us-ascii?Q?yBipdQEhZmzKpQqffBQuyQujJf+AyFQV8CWyx7oT9qHGqSFSfjbxolzbupSP?=
 =?us-ascii?Q?v5z84UvhTGaA+fEoYeMaKDWOSMcRR2oe+JRu+m0vvmpsvO09G4CE24gLHUM2?=
 =?us-ascii?Q?htr7VQ1Z/E+inG7DclLz2OlFcXgLIjUUicdngNkIklSXF5JxOh7OJ8IaWiu7?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2eb98cd-5512-4ce9-51b6-08dbd3ac8fad
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:50.2883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99jRzEfLrHyt4r76WJG1JFVy9vyxv9p6YQYTF5YHvqeYGDT1VLY7VGUNAyQDESmQePWok0nD1JBIyDhWiGvEPaWzBWgpaBUa1WnlW41QiIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the MAC address if mdo_upd_secy fails. Offloaded MACsec device
might be left in an inconsistent state.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v8:
- call dev_uc_del at the end of mac address change operation
- return -EOPNOTSUPP instead of -EINVAL if the macsec ops are missing

Changes in v7:
- patch added in v7

 drivers/net/macsec.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..87ae7e1ff99f 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3604,21 +3604,19 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct net_device *real_dev = macsec->real_dev;
 	struct sockaddr *addr = p;
+	u8  old_addr[ETH_ALEN];
 	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	if (!(dev->flags & IFF_UP))
-		goto out;
-
-	err = dev_uc_add(real_dev, addr->sa_data);
-	if (err < 0)
-		return err;
-
-	dev_uc_del(real_dev, dev->dev_addr);
+	if (dev->flags & IFF_UP) {
+		err = dev_uc_add(real_dev, addr->sa_data);
+		if (err < 0)
+			return err;
+	}
 
-out:
+	ether_addr_copy(old_addr, dev->dev_addr);
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* If h/w offloading is available, propagate to the device */
@@ -3627,13 +3625,29 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 		struct macsec_context ctx;
 
 		ops = macsec_get_ops(macsec, &ctx);
-		if (ops) {
-			ctx.secy = &macsec->secy;
-			macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (!ops) {
+			err = -EOPNOTSUPP;
+			goto restore_old_addr;
 		}
+
+		ctx.secy = &macsec->secy;
+		err = macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (err)
+			goto restore_old_addr;
 	}
 
+	if (dev->flags & IFF_UP)
+		dev_uc_del(real_dev, old_addr);
+
 	return 0;
+
+restore_old_addr:
+	if (dev->flags & IFF_UP)
+		dev_uc_del(real_dev, addr->sa_data);
+
+	eth_hw_addr_set(dev, old_addr);
+
+	return err;
 }
 
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
-- 
2.34.1

