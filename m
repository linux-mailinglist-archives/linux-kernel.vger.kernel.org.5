Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42CA760C55
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGYHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjGYHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:48:50 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C9D3;
        Tue, 25 Jul 2023 00:48:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBNzNfYm8QiPoE5c+2oGo75mJgR7k37EQOC7L3oGpahVIG4e6yYBDMWW+LF9AuSo3LRCU45lh3i57Bm1U1nlSsKT75F/AE6dXU4PiVD8I6toz6KVXOBazdauipKKJam14jsCKesm8n/ecERw89ULRb20eoaxGBbpECqiRZyaKTWaKMJFvvNwMveK6xmpM1WTmx6pctq6RfloSHQcV/5UYf5ZyCMb9K+7/Erq7SMGL+b3ZIrg3w75Hm5oL+9k2UFvkElHY7i4WBCn5oadiMS+apoWMHpSH2qqcJ4kGBuiRIBKFMg5KKfbnPqpJBlQvynuaU2ScqiFQ9GQD7nmb1QybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPD4r70exCIxlpDF9uRwDVRGKD216pl5ZxBnd5JxlTw=;
 b=L6sbhMZDUULwHHWF4tmw848GSEK7tmDIQ1DoIt7trcJPpm1Bo0Kbww2RsGoIW5izAVp7EBGWHEoKewC0niRO1zSBq9ZVCj2vrPJGvfBnhikmD27RX/MIdoC2PEok8kTsSeLDnJqfyJ0ZcGwQ0HbgYoHHvWVd5Na9uKAWlTThbg3o2NonS3ye0hGWpRkJ9MkvHaNwDXs1Bvb9QGleHaBaXxmiD0hPoEBwDxsfysaA4BXJPIwi0ZqYes4VIG9v4tMTat38XeAG4/VpbfQePui3nqyGxLAt3gDTTu/TqAvICs3TA1tE+rcHXZa3x3sTeXu/x3gq4dLgMtV5ZSGFE3mEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPD4r70exCIxlpDF9uRwDVRGKD216pl5ZxBnd5JxlTw=;
 b=W4bxqKsVQhpvaemDYyLxs3MZaWSwyBUR8SR1YDu9BXwmnxAJb+vUaTXUhhPE0PwZTIvnYBtTy/W3uSZbMx5hGN9fDJ6KQRPgAOM8z8fJtqfMuSvE+VMGeYUzyxP+7dxRoJle8szH6Qyd6djFqEEsSZdfe656+cUZnSD61WfElzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:48:45 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 07:48:45 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        shenwei.wang@nxp.com, xiaoning.wang@nxp.com, pabeni@redhat.com,
        netdev@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fec: tx processing does not call XDP APIs if budget is 0
Date:   Tue, 25 Jul 2023 15:41:48 +0800
Message-Id: <20230725074148.2936402-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|DB9PR04MB9380:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b8500c-67da-43de-4eb1-08db8ce392c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fK1M4R17gxzSCHQ2sSaBD3AGU/MPH0snqv+khUu+q8JtyFine6zs+kahVJmTHyDC/kXcHIlmjRs9wjRBuxsAjbIc9VGvghHV5n/tBX0ok1tt/OY1Mc4xgiKwNXEj0503+Armv2nPt9D1pDOIq2c3Hi/Ys6q1b50ysjdV2fcPBwZXTJhkLAZe+U82JecIcUe/He7ezULrVwiG1u5o+0G8JKhLTRI6GcLXuH3wa8PBE3nOz/pECgpanmK+SllOHlOQSKevr0lO1MxzqrAzSTd0vSQVygVG2/ekP0B5nkEFKjF97so4YWOBqRAHbaCv8W2svDjYGRXT6YDhBfmQlIwjshjvhpqLCEzZKIqB0L43v7QpHIehIzlA/5zqEqRbRIDH0rKuQoO2+dJ8+fQVai20wY/zsKLRzW1fKeB39rwBC7zJc4o8e+pUM2Jtj1cQolJPg/TArZ7ac/cPClSlukxGRGok+pVeDM3akuRN31+ev9vR6qKYPihCvj7pM7addsQlnsEzKx+7UpFj5EaoJsepOk2K+fYObJOIvVBIuSYYxjQD3YXBP2d8jNH8l3TX3Ks5H0eSIDfNHobc4zl3CMPfp3Qpcwq4zSeKAHWoDtsT+dM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(44832011)(8936002)(8676002)(5660300002)(316002)(41300700001)(2906002)(4326008)(66946007)(66476007)(66556008)(6486002)(6512007)(26005)(186003)(52116002)(478600001)(966005)(1076003)(6506007)(86362001)(36756003)(2616005)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?59rnqVCw1/CzgwGphhXMleUXIoBjEOmyPehvXpYb4lrU0hgarjTCYMdvKrFC?=
 =?us-ascii?Q?thW4JzIQUNLWb2gJMA0zb1bVcnIn5kqpvkldx+NSmUL1bedvUNOPPOXIQwSY?=
 =?us-ascii?Q?mv/QIw08isCyqYbYSsQ3Y38yyMJ0V/R32qazAJZXHlTHmpGVGO8EkjCs4PHT?=
 =?us-ascii?Q?YwUxVSS8brfiDu9j8KvQixmbTmZV3CWau4eTfKnrK3MZVxCWeouDQvviRCUW?=
 =?us-ascii?Q?EPkwVB9smq4b380bKRWSw8deP4/5ATTBSHlWFM6zTTmWt8Qyr+EIUUP9rwuK?=
 =?us-ascii?Q?38cIE/WTIB5zZS6eYSr5iBjPpUc503lZU9b+BoupryldwCJDeuvRuGqEf9KA?=
 =?us-ascii?Q?N3zg1p6DokxKfvnABe2ynh395N5vfpbaNq5dHDGhtj7//GiihZxLnwv3dTRl?=
 =?us-ascii?Q?Kw9IngSDHnQk/2o9Rea73rULsLug58ybumtkzRdUHyKd8CBLCwOi1X7CjjpR?=
 =?us-ascii?Q?F6pxrAIwN4nvulpDMAtrW/ouNYG/F4bEWgHmU3dW4vx9RGTHSLu0/Ymtcvp4?=
 =?us-ascii?Q?k98Td99tHwOoZt8pCQ6VD7WixBc4z17Ji4GVMVaJK9EzzwX2hQ9LUC68/fgu?=
 =?us-ascii?Q?D2hp+Sx1Sw9pk6o6Ui68bsacXjQOJamPsocnG/dUW1QaRPsZUZJbfdOkQ7vw?=
 =?us-ascii?Q?ZYbwCg9neTl3X1vi6yYor8eJSLKvprU77dSuBeBgr/8y39Py8yrJCQ7O4J/g?=
 =?us-ascii?Q?bAq/n7BldJbGlhBFRbe3u6sj+44i8MvJGwuIjDKPD0I9lDPSuY5fteuwDlH9?=
 =?us-ascii?Q?v0olWITgU/8BV8NHlGSFQmexm01rnSMui5TR1CiWPMNtApKCA/kTXlk2ale/?=
 =?us-ascii?Q?iIflFWbTEJ8PeexB6W+KDp6+Cl1RgzDhn141QKUi9lCceGbMoMDMwiknPRX1?=
 =?us-ascii?Q?08zjRkZ61B4zfaxDWxbTmUQruMmz8JrpPy001YFHtUaIwlwclx2bP/+jtzDy?=
 =?us-ascii?Q?oXzU09YDMSfAksasJFUI2FT9nZ+ay7RPRr25Q9VUWZsLMm33KY32PGGxmfJu?=
 =?us-ascii?Q?Sy7yx9gBQ72uLJzEFSv58XF/UQmzPh9fAksY7EnMpdC+Turt9eKwF//gFykl?=
 =?us-ascii?Q?e8VWjZaoD3mxkPWa3fh/xKVBLXAJ1YZKcLD3keYAZdylypk+esg3whF3GwJT?=
 =?us-ascii?Q?EKVSoAbfaXREGExT08ZCtJ/lk6XDTnnB1XHwMX6t5zNMSlOMNUVGmInSRZ4Q?=
 =?us-ascii?Q?uXco4FDbtE4otpMXDD1xdff8H/nfcISTKuRJ1YexEdj+WSlS4e36u/vUyhOK?=
 =?us-ascii?Q?HLNz+yiFSLs+UWkPQdhe7qoKwS+DkwZ/GURnc4b8qXP2hRgnFstPMEjXDlli?=
 =?us-ascii?Q?Kv/3/9GaRDzEK1PS2HEuH4cv3SLx1CxS3yEC4MgzK9QAkX31iCalKvVaOZO1?=
 =?us-ascii?Q?6UCmroLmI2sYi2ZvNXU1ODoFt/qzX0EGoiQYK055e+J3VIApO1yVmMYuvgwb?=
 =?us-ascii?Q?RJznE6GPxFeesmK8QhfUCBr5p9NsYIcWJjwRCWiUqam1ZXKOAuO3vdeT+RI0?=
 =?us-ascii?Q?RMrugkANG2cE562O4Vcf/wy6wkl1vh9BqVfIsH78al7oGM8LvzicQ5a/gKZy?=
 =?us-ascii?Q?dTsYwFwc3gjm3upSAnvxkbLyECbrrq0PFO8M1xdZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b8500c-67da-43de-4eb1-08db8ce392c4
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:48:45.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVY1jReBZ/nycXTnxFYvJDQ+alYIXgIeHMntSySbhxSRlf+uClu6RCFRJqeLiwdTgC0tTXIAXf+DQvEKJMf/sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9380
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the clarification [1] in the latest napi.rst, the tx
processing cannot call any XDP (or page pool) APIs if the "budget"
is 0. Because NAPI is called with the budget of 0 (such as netpoll)
indicates we may be in an IRQ context, however, we cannot use the
page pool from IRQ context.

[1] https://lore.kernel.org/all/20230720161323.2025379-1-kuba@kernel.org/

Fixes: 20f797399035 ("net: fec: recycle pages for transmitted XDP frames")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Suggested-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 073d61619336..66b5cbdb43b9 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1372,7 +1372,7 @@ fec_enet_hwtstamp(struct fec_enet_private *fep, unsigned ts,
 }
 
 static void
-fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
+fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
 {
 	struct	fec_enet_private *fep;
 	struct xdp_frame *xdpf;
@@ -1416,6 +1416,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 			if (!skb)
 				goto tx_buf_done;
 		} else {
+			/* Tx processing cannot call any XDP (or page pool) APIs if
+			 * the "budget" is 0. Because NAPI is called with budget of
+			 * 0 (such as netpoll) indicates we may be in an IRQ context,
+			 * however, we can't use the page pool from IRQ context.
+			 */
+			if (unlikely(!budget))
+				break;
+
 			xdpf = txq->tx_buf[index].xdp;
 			if (bdp->cbd_bufaddr)
 				dma_unmap_single(&fep->pdev->dev,
@@ -1508,14 +1516,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
 		writel(0, txq->bd.reg_desc_active);
 }
 
-static void fec_enet_tx(struct net_device *ndev)
+static void fec_enet_tx(struct net_device *ndev, int budget)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	int i;
 
 	/* Make sure that AVB queues are processed first. */
 	for (i = fep->num_tx_queues - 1; i >= 0; i--)
-		fec_enet_tx_queue(ndev, i);
+		fec_enet_tx_queue(ndev, i, budget);
 }
 
 static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
@@ -1858,7 +1866,7 @@ static int fec_enet_rx_napi(struct napi_struct *napi, int budget)
 
 	do {
 		done += fec_enet_rx(ndev, budget - done);
-		fec_enet_tx(ndev);
+		fec_enet_tx(ndev, budget);
 	} while ((done < budget) && fec_enet_collect_events(fep));
 
 	if (done < budget) {
-- 
2.25.1

