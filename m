Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752BB7CF7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345586AbjJSMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345573AbjJSMDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:19 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192C1B2;
        Thu, 19 Oct 2023 05:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv/mJHs/1e00WHFykGSW0SRYpS5kkZvOSZ9URdOQMDcsoMRPvtO6aLIuajOJz9+E8X3WfbvPDE5g5HubcYBoWO6M/0PvBzb6b8tUuzcM4ZrNLYvaCho/o1s/kTnunN5YveeQ3cndcHjgDGlm3raJ188ojHnijnStGr8J3B+5x6onCPL9iZM2dzpP/naoq0l+CVTfDAUOkIHFOulOcGk8/S9HXH+FKO52JDHBDQrjWNsbGKLiXAhS/NYgYG5QoiDV+3Wl9o6l1Vf7O2X5GcilDer/ojMJz31WsMuY8mmtKl1fqLVUerwSefUS2k/jkGBbTohWcli6UamOMDpLk3yA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFzavl0orK5XVqqdIgXQrzWPIl2tiW61OVoFktSbHI8=;
 b=W1boAkbuucCyJ3Xh8F39bayUAoZtlFOE8TLz1ZyGMmkAV7LInfZZwpfjptBp26ZaboR9qR6x4YidmYWJpoFPMDim7427piGfS1+vWFk/DzoJgb1J7TjAgpQX/4+N6Vl+shozDObol5ugObFiJg8+cwyhu5RxWdCluwpRBEIZbOkOu3unblGVmDpJ/U/LrkNaUMOW4lgpPZmsqFIslNyuefq9Er/Lh8iqxjP1ndoRBYRDqBBCDfuki/7sNbYEk9Fp650onMcz9gX1JhGIAMA7hcMKO7oDPIvyFLEInfGAeUt5vXJRVTCr6P4Q5NQ7P2/YOi2a7ka7w5P5DC466GHDtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFzavl0orK5XVqqdIgXQrzWPIl2tiW61OVoFktSbHI8=;
 b=FMOf6LVUDm6M+PIWNl2QliESKuyHpuqk5skbgYEnOg4p+qjlJ6k+WK5NOtc22zIJvfMNPLPHcc+pzZ0KlWgZyZC8XMjlmSJvVaAw6XvirA13oXyyLUFS1DDW6r67+U3ZC35C6xUK+Smc8OFEFLJy6qwDM+BGCIAhSq0xLTChskE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 12:02:56 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:02:56 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 3/7] net: macsec: revert the MAC address if mdo_upd_secy fails
Date:   Thu, 19 Oct 2023 15:02:05 +0300
Message-Id: <20231019120209.290480-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6961ba36-a888-467c-0790-08dbd09b545a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLGwqU4IZ9aN7SoYBZFV3/KL7BW/Oa6mDGOBRCikQ+zAJwYHhHmQ+rJ1E+2VBKRaw2FYKgjLKL6XKqHcW0Tv74WRPSoji6z24t2BV5trdXKhoKj/+N4C+h22MUlXR1LpelGDmneuHyixVCdu1M0KYTjdYNMjFEblpbdwkkXP/Jb9qpATCbPKa+zDSbrGv4FkwNpVssr2A3pOyv3to5b0nwj4PEh543VIGiy5oVqNkD2dpSyf/a5cSi4WDrRrQ8XfkGKc3MuzlRcLdNEFeA0C5nS8D+sL9xqtkgHxFRvmvTlYXSSb2c+Z6zRGpOHa82ewq5UdAR+zY4BzfeHStMlvOmdEoRUu97xSxGKzR6Tr464HK/9ersO1Nt9NU4QO9P3yZeIFqQamepD5yYgNt1AlAKfOwWGhtZ31zrJdX+9VWlRSae4MrpwQiz8tXZNaUfRYKaxwcMD+6g9GrkvmjZA0yhFcuwqTi4eDPbAW2YP8hFC8m5Z3RCMSkmdA2zcl3aBKi8Bp9yFzoV6RElli7DUn7AlQ4i2CW1d6wYPL68OYZ3+B2a3LdFJVmqguMdvGwa0hjposrdUOu4Mo2S4oe8QuOgq9a/p8vV8kGSfCi8WqktmMLMxmKy+ERAfS1cFFx45n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(41300700001)(6506007)(38100700002)(4326008)(8676002)(2906002)(7416002)(86362001)(83380400001)(1076003)(26005)(6512007)(2616005)(52116002)(5660300002)(6486002)(6666004)(478600001)(8936002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U1pGS95IwChuz1UdcQ6BmfaR/pHrx1cYp1E5CwABY+/i68stBqjs48uQtmfe?=
 =?us-ascii?Q?zlvzxjNyAYTEr5dcKjvPfHwlYSqtV4ffUDzByb5Bld9GA51Ost5fcUZqm6Pv?=
 =?us-ascii?Q?GZ951h7Jl0zKG+S8ejheyZqW5bvq3Of9V9VPzYU5qNEx5TYMbd4Yg/F1e9At?=
 =?us-ascii?Q?bOAc9auFMWSknVUPAuN1oVdV84U05bCZPf+SK7gWwcGEUMUj+HH2eGkhX2c8?=
 =?us-ascii?Q?jXA4M3pDAPLvxihrFUon/jUjwtbhyCnEtPgHIItSLHL+Z1uJQzm9w9Mbz6cb?=
 =?us-ascii?Q?lSmQ+N92VeWfLifS2Uf0SGeAgnOF5fJd5FVsG6DQ7fz2/fYhSUXGRrDlzTda?=
 =?us-ascii?Q?1Qt4Ae7szUWU/KVQOatYSztmUiWTR8XSAdrPsWY6Gm4LEp7rcuijMkoWzAMV?=
 =?us-ascii?Q?jjy+5eIxVxv+UrDx4lWiP/WwbKzWmM/G0hB+p0dcLOQbcDSH5tG6c/4FD+P6?=
 =?us-ascii?Q?Wv/2vqBx5eNu28U98tbilGacXfHDOmVyeN55U8eVjATvl1DrtyTrPtomc9iR?=
 =?us-ascii?Q?qWORK2ExbWbMaB1prE48m4UXTh+DZq5kDBUja/yILaO7wSNRpJmJOQ9Bwvzq?=
 =?us-ascii?Q?gUENkSQPrg4IO8i4e6nsSHfokivx79IiuJkvnPoNwrzCw/sIMV0RJhqntFMZ?=
 =?us-ascii?Q?gaHzsJO9jEzGrcHrbLArtTjffqBQRZfYUQV36cL39wHMHglEvTubAxMFo1rw?=
 =?us-ascii?Q?io0LLwAvJMxBBwk0nYs5f17rLyWMuzkqiKsmzkOkVbMl1hu46lZC/HppWs77?=
 =?us-ascii?Q?JEoONOL3pa8/IlT4mpDHpd9ZSsnO3+DzimOE77c4fagnsnjaczlHojiE0rlC?=
 =?us-ascii?Q?6iWtLOYFqJB6ODmabyu4M70SC0Zcg23eDZ0MD2l6xABZwGVwSMFne2SxYwLK?=
 =?us-ascii?Q?9Zkn0BpTcwVuqgwtZdnWLdfh5P2dr0jFAT0XH8eGphJum6RG81+9mnyz++oj?=
 =?us-ascii?Q?JXQWcDkQBdDSXTlWqIJ9H/4YJd3YpJVKiZ0TXwqw7dApBHMyLHOlXSyTYz4q?=
 =?us-ascii?Q?4KAlym5Hs5g05u02+Zuc4MERJaTz/bKZm+a5LYE86Bq33f96UpzFvj5tugnR?=
 =?us-ascii?Q?rAuynYkNK+wuaw2lbuTuQWd7NQO4O6OS6rNwE2HxQZY8wu5zYvSkw5ms404x?=
 =?us-ascii?Q?zNaTiblTomcEop8Y/wpGwjFTm17KbNrtafndQiL3psTxxU1OAmC87Zvj292u?=
 =?us-ascii?Q?kMCUTD72LnSerNnRbfRpAxV5snHJGwJDjj6XMsEgesXREK+HPqt8b6nRF2Vc?=
 =?us-ascii?Q?75iFZxcd3OgeKA048eG0ZmfRnz/vQWpkuqGVK7hBcvyGVL6PFKKgn8MPQ6J8?=
 =?us-ascii?Q?5bOqDyoKLrvRvhcUfY+Ffggw/nsAJhj3kw8f2E6/RBOKsAbOG7Qm4zfhEsZ9?=
 =?us-ascii?Q?JL24Q/5kURRlmqIFwacwBig0tgh1d3BQcq1B0kTSTgkgHb2rU4XVfsx5iwhW?=
 =?us-ascii?Q?dsk2ZFzdeTXIiGvPzVXj/bFH6uFvcMXKt8R1ULOhPPNtK6zniYVdDKwlO++u?=
 =?us-ascii?Q?5ZcU4C/w3xS3fVY09bOIMCfgKTkNgX3HAqzndYc02shq5diSlVY6MYYi5AC1?=
 =?us-ascii?Q?TKA90r8sd7gxbzBGwMBiKrwX8ZrqUEySVv0HpOMUDGeazyO18/j0atqox9H1?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6961ba36-a888-467c-0790-08dbd09b545a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:55.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgpPX/mHUlNH5NJZc9q0/5MLlFwRzhkL7ZBz+BzDZ+OvSTXZRr1sXLAFEg42DfwzJ47SSUwv7wOHW5I6qqRFnx6ZEcs/J/b1+R99sWzk4x0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert the MAC address if mdo_upd_secy fails. Offloaded MACsec device
might be left in an inconsistent state.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v7:
- patch added in v7

 drivers/net/macsec.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 9663050a852d..569b27b2e276 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3599,11 +3599,27 @@ static void macsec_dev_set_rx_mode(struct net_device *dev)
 	dev_uc_sync(real_dev, dev);
 }
 
-static int macsec_set_mac_address(struct net_device *dev, void *p)
+static int macsec_dev_uc_update(struct net_device *dev, u8 *new_addr)
 {
 	struct macsec_dev *macsec = macsec_priv(dev);
 	struct net_device *real_dev = macsec->real_dev;
+	int err;
+
+	err = dev_uc_add(real_dev, new_addr);
+	if (err < 0)
+		return err;
+
+	dev_uc_del(real_dev, dev->dev_addr);
+
+	return 0;
+}
+
+static int macsec_set_mac_address(struct net_device *dev, void *p)
+{
+	struct macsec_dev *macsec = macsec_priv(dev);
+	bool offloaded = macsec_is_offloaded(macsec);
 	struct sockaddr *addr = p;
+	u8  old_addr[ETH_ALEN];
 	int err;
 
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -3612,28 +3628,46 @@ static int macsec_set_mac_address(struct net_device *dev, void *p)
 	if (!(dev->flags & IFF_UP))
 		goto out;
 
-	err = dev_uc_add(real_dev, addr->sa_data);
-	if (err < 0)
+	err = macsec_dev_uc_update(dev, addr->sa_data);
+	if (err)
 		return err;
 
-	dev_uc_del(real_dev, dev->dev_addr);
-
 out:
+	if (offloaded)
+		ether_addr_copy(old_addr, dev->dev_addr);
 	eth_hw_addr_set(dev, addr->sa_data);
 
 	/* If h/w offloading is available, propagate to the device */
-	if (macsec_is_offloaded(macsec)) {
+	if (offloaded) {
 		const struct macsec_ops *ops;
 		struct macsec_context ctx;
 
 		ops = macsec_get_ops(macsec, &ctx);
-		if (ops) {
-			ctx.secy = &macsec->secy;
-			macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (!ops) {
+			err = -EINVAL;
+			goto restore_old_addr;
 		}
+
+		ctx.secy = &macsec->secy;
+		err = macsec_offload(ops->mdo_upd_secy, &ctx);
+		if (err)
+			goto restore_old_addr;
 	}
 
 	return 0;
+
+restore_old_addr:
+	if (dev->flags & IFF_UP) {
+		int err;
+
+		err = macsec_dev_uc_update(dev, old_addr);
+		if (err)
+			return err;
+	}
+
+	eth_hw_addr_set(dev, old_addr);
+
+	return err;
 }
 
 static int macsec_change_mtu(struct net_device *dev, int new_mtu)
-- 
2.34.1

