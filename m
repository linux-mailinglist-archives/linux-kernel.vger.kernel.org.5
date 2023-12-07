Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD002808382
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378368AbjLGIrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjLGIrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:47:20 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8381AC6;
        Thu,  7 Dec 2023 00:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1O9LFaYeWokIm42wHZa75RaULlA7+PwuCAvUFtKGJswnXARtyZ2fyRBAF/Lp38/MktU3o+EDi65UNDwnlRLp6cwQkzvHT4QomEHRkJvwQumQ/LgBj6enT9biRqP3Q1obkGW9+ON7qz3YUnILfgTrOFQAANCfi88DVx8eInAd/Sf35XMpXHDBeSJpYYX64Gu3hCCJqLIgdUHaY5Zr5kQLOdrnA5uOhDcv9ryXJqbEF8pXZRqfGpcIjgzsaCaCLLpiiGuXDdejeudKSH8jM1C5Rb25dADLMGOU2e8S2wqVaQQkE/Rc04Ec3fopHlIjdbOcpzengDOjB7V+KLqesiOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iJs9qJQ1bONPlJNCi6upX7UdxMYgDYFf3jHLAURVT0=;
 b=HhcryniN606SqM3qloi39ihofW0fzC6YjUa1uRnGZikVV3y93iQMCchBNb70gn+jz/nTEDateQ1kS33T0F9wZz+XYef9l5QxocItkJQlUvqWlrqutOCrmrLnYzF0wDq5Ke8GXfe4a2vmp2dUb667RIlpvwFWJ5QuvuqDkD4rY1WULA4p/VBwmwxfAZV0MLEKo17NWJGImSEZgR+zaz2wSrjgroxEl94e1RaHk05MX1VK3y9Wu5mDUdNTynLgElEhmqwwsuJKp3nH6A6h1EamZjTUh9Ml/GvedAysUWn+AimiFVabqK5Y06kAZCh9zqcVw4G8JPlitsxpjDIp7zcy5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iJs9qJQ1bONPlJNCi6upX7UdxMYgDYFf3jHLAURVT0=;
 b=FuYt+n1DEYhy/znDPRngH9+DemZ0tZLYQS9v9sz4Lr6D0yrXO/vd7KWAUCkNy3SBfxyh7/JsIEuZiof8BMO5Ehvgs13spLC6S3GVhUYKmuwgsVgdZXMv5oH6y1mlFu79IlUA/aFxSAqBabAdH/Ro8753mgAJNlYzgteL5CuB0TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 08:47:16 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::d6ee:d372:176b:1786%5]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 08:47:16 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     radu-andrei.bulie@nxp.com, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH net] net: fec: correct queue selection
Date:   Thu,  7 Dec 2023 16:38:01 +0800
Message-Id: <20231207083801.233704-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0137.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::17) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ee5707-291a-4a8b-060a-08dbf7011cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyhwSDLdZjKxK2iSDd5N+L3B963bZgB+aIh1MWkWJ45ezOVugAw0COyrXjaUJ612jBwKNOtWU/qMpp0FKHLj3QFzIOrdNkF3pRcMDcm5Z0haO06xC/Krr1oNMt4biOolTdFsKSfS9RQpeL07wo/0x2ZELquywM1DzWubkblxJl4uyGfcW/oBVQP5XO4UtOLpTbLL78gvZDn00IPhi2avuNqFGw+xlBSeRXZZoZCBfCWKvlxYFBVOGAFLLJOE9ymyB7ak44KfnVuGAXNdtpoH/T6rGhk2KvDfZJjnXAIhcLrSdJA//i2pMfFBagQGCTIEepBFJRohynTJlaQfTzD+I4QKbZzM2RD+j2kaENrcxIK+DYo69fYtNqn4YMQAUc4mOVKEu5MKuFfZoCaLsfLHGvmrn8F5gBcggejuu/GBl42ggvy+BtbQqj4w5QKP/taC+GUAK0szadJVLshXLbXX9ncraIari5EGyHywWq47JfPAsS+89B35ijHFQRPhM73OG6n3ZoL436uRbhx0a6FkQ1sPK+2qfRtr46ShnUBm6YHCqVBJCYyqyPPxkeCi6J1pItxZBzt10Bb9D9QjfT2szntnOsiOLkYBURcZSJZMwuVEaTxAdejAgY8tGdFVPLWA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(66556008)(66476007)(66946007)(6512007)(6506007)(36756003)(41300700001)(52116002)(6666004)(83380400001)(26005)(1076003)(6486002)(2616005)(478600001)(38350700005)(86362001)(38100700002)(44832011)(5660300002)(2906002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yg4X0ejig4FU5+Tm0pPXrJN2oEMm3au8bbbbmxhnFdhskWo/zCe1ka3TfkqW?=
 =?us-ascii?Q?UCsWvqsj8uYAhkaVlSyPd79MHAeKkmW/glnmazziGJX6149fmsNW3Uk7m2NS?=
 =?us-ascii?Q?FRCGK+awwDSFOg2vy7iGGAJrB3F/3tEg6MdaIjB3Ti1zJ7YKzCltqg+B4F1T?=
 =?us-ascii?Q?jT8DcM8LczFo3rmtomYX4829AJ5SEUCRWu6FwIZXGAaCe7k9eJRJz1eV4EZC?=
 =?us-ascii?Q?wty/Ys1KXV05BV1sh3EjDCkyiQH7hEjLS2eAnHqPTxBFj0D4XincIaHAaGLN?=
 =?us-ascii?Q?4XM9vx1GGhvbDl0dInsNBr21FnwfLihpiuxtwiBPbi7yLsWRKCIl6XMM685Z?=
 =?us-ascii?Q?8lXco0fKv/m81KYyKIkhMNZrG/jFMvWxsBG3SNwBmHKWcPbToFTt/L0FejDl?=
 =?us-ascii?Q?or+tlEMX8C4iy8U+yQQZ2q55/YyM9U14J0oPq/2YDrX19BIJp0MIWRBFY5rO?=
 =?us-ascii?Q?i9djGWCmwH9aC8SHj6ArR1zWLd5FA8H3c6IJOYfX7qfx1LdEAmLFslTqtppC?=
 =?us-ascii?Q?wcCkiTmwTkwQUzuQD6CD241pyd+aEBHC+z/HZot6JdEcaQW7yi+r2sVnFwBA?=
 =?us-ascii?Q?k9KM/fUKwUfOwWnhZz1qqCG3VqACVK5c70dpXq8amPCEfKSrvR5SqIZySgp+?=
 =?us-ascii?Q?hNm0o9M/INx2Ar2Po1hIlO7jGes10KQFF5pXmRjuHrYKwal/zMs/1Sujmqvt?=
 =?us-ascii?Q?FKPGLvYZ8kDbyLaNqQx80s7vjP8R5mfIIt6vxwD3TmgJoC3DXwar0UT42Hee?=
 =?us-ascii?Q?gqCKOc66i6p95798IZyN3U12d/OsqCPZpQzBFsTElLXFM30Atf6TlVPZ7Vx7?=
 =?us-ascii?Q?T6WHJbe/oMboWMGRwOd52R7k3TIxjm46UDfFyUm3n5R02AGWbOyz3soVZQiE?=
 =?us-ascii?Q?H31QvysACPEypsdwOV5z2/veADsgPKKAYh1iZUsBawKhr7K8HdrIYkyuUjpY?=
 =?us-ascii?Q?w7wq4pQezAaET3wMJy2pIJHT3ttUaY1dfLC1+SUyJ0uGb0Qfrt2yDeHYAO5M?=
 =?us-ascii?Q?4my9nR8SxTGapIBW6ZOzaWpCYScH4/THfgG536OYimLle/MKb5ipqO+ZkTCp?=
 =?us-ascii?Q?G8iITqI96dwPEKpPVqzv9a42v2zmiY20fosRjNxTJxiilQlYoszWHXxb53F7?=
 =?us-ascii?Q?wJUF4UvO8tRZqxsvdAkcZbmOUepIj7qJtPIUU/rRk+1WHzjH0eluZAIXIM6o?=
 =?us-ascii?Q?Z6GdfCcN6l7atxyBysQfUmQMuZ/Gb9V7bm3RII4jEN5+M3YzbzhxtBEVlp73?=
 =?us-ascii?Q?leSOMV0GMEmkh9a4DK99VLEdbuDW1IovZeUJBgL9TFjzSzkdwrsEApnsWzd9?=
 =?us-ascii?Q?/ab+VBIselNmlvLIqnOQ2/f5jnBBKzz/3jVBYjgcApB+KYL1Mpy/Pei60Lr1?=
 =?us-ascii?Q?nLuNWiu155guCfm7pYQY6eqhiWt/6etf66mYuuZ2XHQfO0f5zJm5/6SmUe25?=
 =?us-ascii?Q?eCOftbj2vfsKM8BkUMa3tmllrLs/XBVbQIHTfX/HGsjFFkSXE0RcySOZ8oRn?=
 =?us-ascii?Q?P2YoP9nwjQBEumQ4fC0LaNoGWpoSiz0baHSpRGcUA3EypFaLrTfY/OvGs2qh?=
 =?us-ascii?Q?EqPT7LguBlvtTWdbS7ROM1qcs0WKFfyRQSi0eRlE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ee5707-291a-4a8b-060a-08dbf7011cdf
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 08:47:16.2343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyiShRoVVggoFHOxh0kMAD83brpaIU8UYSecXf5+bT84PkMoDM1IfBVmaoc2PILikCt0+GCMilEyzBcPlxi0MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Bulie <radu-andrei.bulie@nxp.com>

The old implementation extracted VLAN TCI info from the payload
before the VLAN tag has been pushed in the payload.

Another problem was that the VLAN TCI was extracted even if the
packet did not have VLAN protocol header.

This resulted in invalid VLAN TCI and as a consequence a random
queue was computed.

This patch fixes the above issues and use the VLAN TCI from the
skb if it is present or VLAN TCI from payload if present. If no
VLAN header is present queue 0 is selected.

Fixes: 52c4a1a85f4b ("net: fec: add ndo_select_queue to fix TX bandwidth fluctuations")
Signed-off-by: Radu Bulie <radu-andrei.bulie@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 27 +++++++++--------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c3b7694a7485..e08c7b572497 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3731,31 +3731,26 @@ static int fec_set_features(struct net_device *netdev,
 	return 0;
 }
 
-static u16 fec_enet_get_raw_vlan_tci(struct sk_buff *skb)
-{
-	struct vlan_ethhdr *vhdr;
-	unsigned short vlan_TCI = 0;
-
-	if (skb->protocol == htons(ETH_P_ALL)) {
-		vhdr = (struct vlan_ethhdr *)(skb->data);
-		vlan_TCI = ntohs(vhdr->h_vlan_TCI);
-	}
-
-	return vlan_TCI;
-}
-
 static u16 fec_enet_select_queue(struct net_device *ndev, struct sk_buff *skb,
 				 struct net_device *sb_dev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u16 vlan_tag;
+	u16 vlan_tag = 0;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_AVB))
 		return netdev_pick_tx(ndev, skb, NULL);
 
-	vlan_tag = fec_enet_get_raw_vlan_tci(skb);
-	if (!vlan_tag)
+	/* VLAN is present in the payload.*/
+	if (eth_type_vlan(skb->protocol)) {
+		struct vlan_ethhdr *vhdr = skb_vlan_eth_hdr(skb);
+
+		vlan_tag = ntohs(vhdr->h_vlan_TCI);
+	/*  VLAN is present in the skb but not yet pushed in the payload.*/
+	} else if (skb_vlan_tag_present(skb)) {
+		vlan_tag = skb->vlan_tci;
+	} else {
 		return vlan_tag;
+	}
 
 	return fec_enet_vlan_pri_to_queue[vlan_tag >> 13];
 }
-- 
2.25.1

