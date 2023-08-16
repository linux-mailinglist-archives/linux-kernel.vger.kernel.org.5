Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46577DCFD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243224AbjHPJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243259AbjHPJJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:09:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B326211E;
        Wed, 16 Aug 2023 02:09:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4spocvfe4QTXrj8F4ag5a2+CBCAjuXyHv0kgvWM6olY6kvyZrQ6ovnHdLQMzzlKexKOL808Iq2nG9YerRUf5hnReEj6ltw4mjRjQBya/orVTFWc8x4eum1HzlrrUgk3pWGL/TEJQPD9VlStuhG+T0IPLz2O83LTO2gjXzstDzTb02dOd/hDlJyliRQ6E9WQfwpkqyfpfrlbJrgEZz6jqPBdsF8miRRt64BdWInF+MbTtg2NyJNNR2u/bsrzfTcBSgEMZ9hi2lZb1ZRtR/DysfrnViB/AW0zdCZ0naYjbZ+oFamdAqz5FDSzKGFqa6GwjpFJ9hsg49NwOK/YzK2pjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLny7DbUV1y0uaXJDSUC+cRQaYMy93gRLZBKvRG1JyM=;
 b=OX+LMUTWF/MdWeqY4hOx9BONk6lj81EEiEMkJe/49ibXjExftwysM0fiIl7o85sKgwYdJqWvDFhM5GuQMuDyZ9i4F6DXIUwKKCcLqNBAu0+43EHivjuVn+EFhqM8K8doBRE46GDHCbWTJPGvRCrhG8AjAOfa3OSmQM+F2SvTK7xmSWmMak2yVo1QIqR2+EEv745jpT3SiHQdd10NDKjTdGK9Bzt/5k32yujmS03Q2596WYiAN7H1XkR8owHPyZnBm+7osrWjQE97pUeflDWTZdyqYH+Yi5bt+p9mSZgQrTUaYw8MnWhY6Xy76jEEo+TJh75SQloZovnRVYyHQnJHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLny7DbUV1y0uaXJDSUC+cRQaYMy93gRLZBKvRG1JyM=;
 b=rMhPXELmjL0KbnnhzU+M0VB1lvWEdX68tjeKp/YXWsjDQJD1h6Fgc5932jNFaNLP9NxDGydunsvsfJOrMCySISJLMLSeSPEHdvataOIcmeBlC2k2ssV7ddFDBp5aKfeJM+V786t8uMQDnbJl8qIZnlB99K3vsOBRzGqp4G7uYus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 09:09:10 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 09:09:10 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.duyck@gmail.com,
        xiaoning.wang@nxp.com, shenwei.wang@nxp.com, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next] net: fec: use napi_consume_skb() in fec_enet_tx_queue()
Date:   Wed, 16 Aug 2023 17:02:42 +0800
Message-Id: <20230816090242.463822-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 647e070b-5389-4276-4801-08db9e3873a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZW3/bsj433AUGHNWw3LTECkJkL+7MmQNWyls/K8E2UlyKzHnUUCLTqR+lK2cVKn1vREXhjadgpXGIdu7VSzlaPmg43ZOql8Vnt4L7Vj1vkp/vmObg+EylzEqjUnc9h4jeosxxZ8UiA0/fQ5D0bF7U5XqFmcWbaSAbC1wVNsgiDKF18eGxAGL37AUybwjVq2xSYDEo5c8Zshu1eoKNcs2M5YRaO1NDHOqtBJLbYPZ7bazv4tSmuaDK52B/8QlnRG7OvDCalqML48PabI4MrmRAgF2P4oj7osSPIuQy/S87e/sngOT+mzuhys2dysfHCzSRD1ChX8HkvuTAenOmPnHyRpi4ob2GfGJSxr0dnJTEsCLIndD3ag/v9RrwVikyn03kp5Q8ItiDIIp5g5pah5lK99R4Mk/V4/z3X9lLsD+CIxJ6HMuctZD6j5+xfw4mdtpVo7zR8mtT81UMkeLrU3ojrjImgb9eGpuU9g8jnwPDDxjx6r/cz4K7jxTRYX5caCYvQMSMje8vMm/PE4Imi7c5IsdEIAMnPz9Ijsqr5qoL2UrFMz1EhBN/vw66ruaQyGkkAUZaWqql+KflFzxay5Wrq6sa0YVBA9Gqy+NdeAwcVOG7aIwxAL3wZNQClpoQhS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(376002)(39860400002)(1800799009)(451199024)(186009)(2906002)(83380400001)(4744005)(86362001)(478600001)(36756003)(2616005)(6486002)(6506007)(6666004)(1076003)(52116002)(6512007)(26005)(5660300002)(44832011)(41300700001)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4wtv3bqIUEpRkOsDieOcNInQqI3zZdq0vf1N9+HXIP64dDg/aVFqOHzcOfIN?=
 =?us-ascii?Q?yVd3/x+J1cuk2hh1wfsevflCX1N+8KLKJ20+okeEZW/VwWilI1LpG0flsmhs?=
 =?us-ascii?Q?NmNfIb1cTQP+49uJ9r33RMDo321fViHP+uIXOcrIxOBMNophhC6t96FFZYQT?=
 =?us-ascii?Q?lFSrXZXTyDLE6NxVKML08FudVQ33P7ET8EedA8DoBvIB6IZRvlfLoTIRwVns?=
 =?us-ascii?Q?8Zc95LD/mZTpvwg4/QaBS4Oehq3iyhYR6HT9vrsR//Xav+mk7bDc3lf8iS8v?=
 =?us-ascii?Q?X/53ZQYLWP6nWxc54D7CDS0msjB17x7nOVbLS7lPCZ/k23hGy3Pe6KhGS6Ki?=
 =?us-ascii?Q?Upmo+btD50nmhHVQl2xWJ1QbbVw1XirHiYxDq+XJ93oVIBzcqFJLTDw0D+zc?=
 =?us-ascii?Q?rsaE/PLnItu2yM7kvkpFXT7EdGrkHTqSrsloC3JMK7pMrZbVwbqiSRKlJ7ma?=
 =?us-ascii?Q?zalTsN9l9LHeACoPJXJWghVY+jhpFQtM/G5Gmel9X7ZOSCZenMoNuwcGdDNM?=
 =?us-ascii?Q?OwYy00ckRplP79iSLwDZya23uKWNjjIcdk70jMDhZR2gXv7fkdUbZq2qKjOK?=
 =?us-ascii?Q?2kMlqJBmvhpiO+7dtBwLgVvx36QD67e1FxWdS6S+lO0olBIfbh4YLb/eksjp?=
 =?us-ascii?Q?kH317CWKx5TAe2Bz/HLMq63MbJRBKeCC117Lv+VzuVyxKfABGZur5cOg90mF?=
 =?us-ascii?Q?vcE+PO0ufU1nInhmILX5OYlO5zOLfmoTV3r02NEBIWaCuO2LybNW+D6IhjTd?=
 =?us-ascii?Q?UV5XHYwFCK8ygbXvmyDuiSI+ZRShi+mYJV8UXebyGurlcLlWlBuNGfHQbM1h?=
 =?us-ascii?Q?hglI2cyNeZdw40T9jV8tHcLg393z1opIzy/GkfBmCE+gYTBgQFUCezj5k/JR?=
 =?us-ascii?Q?8lYA6yBx0K5NA/FuhAl21syCdqMbh/MJCZ/GeIjPMBChDNiVbgGjLNR8E5lr?=
 =?us-ascii?Q?wHUKrCw2BHABImRD2khMHdMkqt18TtY/hClGpbIYlB+03t762wLsYvakEVxu?=
 =?us-ascii?Q?m1R0/VkhRJ9jbaMYahVdC5RRhOZVuT20iTsMkcqtQ8geCZFNixeCN7et15Db?=
 =?us-ascii?Q?q09EvpQhX3JKo6TUdZItW8fCbn5bjfTK564/SPOzFN7XjAPvdGuOspdgieCQ?=
 =?us-ascii?Q?dkpSV+94uYsH0MVPuc4doJ7oLKRcBEjE3JkPyajLmsPbJ3isRP8NmEXgG3be?=
 =?us-ascii?Q?cVCCBJ8IWcW4WabnSZAcmxyfvb2Y3mAOtU1cmgFSjOSxAZJQ3SZGMV+kYuCD?=
 =?us-ascii?Q?XuvJh+5/rEjBOS+gvcYTM+gwE/sEHYpyTkDQUi12rgj4fmJHqhP1End+V3eN?=
 =?us-ascii?Q?aioPL1aiHxANuLTGH/zTzAAD4Uy5qIMR2TMRWMQmm37qUd34AQw16CRs/9xW?=
 =?us-ascii?Q?PGc5G6atu/t3QwRtgzGJjF9BVXkOy2ePPqOn+mznRDDDeiwsm35FEKQVfWEB?=
 =?us-ascii?Q?kCAyMWKUDJrS8RbgdoIEZCFOWW5xbDoiWryPJ13SNS67QQrqdkazP+NsR2YB?=
 =?us-ascii?Q?9Xp/Q3v5cgwThJiTW9+hqYMTHWripavV7UfUhtvmWt7McUZlQ/B2fdJtqWgf?=
 =?us-ascii?Q?keKaD5F/kBlOwPZ6zjpDIB2n0Fj0xi43+/cYx5j+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647e070b-5389-4276-4801-08db9e3873a4
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:09:10.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+MAh9pWkhiH5ZgL8+YFOhv185BWSQlsSlvU8O5Rl8Elu+2zOd1OsBesUX2c7exf9i5vo453lXzT8mowE1o9AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the "budget" is passed into fec_enet_tx_queue(), one
optimization we can do is to use napi_consume_skb() to instead
of dev_kfree_skb_any().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Alexander H Duyck <alexander.duyck@gmail.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f77105f017c1..e23a55977183 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1494,7 +1494,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 			}
 
 			/* Free the sk buffer associated with this last transmit */
-			dev_kfree_skb_any(skb);
+			napi_consume_skb(skb, budget);
 		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
 			xdp_return_frame_rx_napi(xdpf);
 		} else { /* recycle pages of XDP_TX frames */
-- 
2.25.1

