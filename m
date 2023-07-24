Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008375F98E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjGXONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjGXOM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:56 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0687CE57;
        Mon, 24 Jul 2023 07:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY02DJwCKJ+3ymkI7zwTx950wZxh2z+SuEcdcOmBiLqFn0J3M9Hf7FsTfH0I3/+4FlBu0ANHldPCC8n0HpNPu8t9VUYMxpHt/WsOkeHOZc9YSM7mHdB0S7fv5LnjWerRaob/8/MGl8S4gAgUbIWhRcIHtFaqM904x17jKnl4TWNO2cSWTLWFdGKuttGslLSx6+ZSO4PHUDrm0EPAyLblEms6MS6K2bZcie58ijUfkSCCjavaQhaQChCGFBAkzVwBiNtw65IC3wHptaPdiQEdA338ahTsWwhldDvSpTvR2JSSzZxOs+8NTQVtgVfOPODdPebw9z4aZkvDIDcgXgR6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2nOYKhmPkPTNbx2/4hfbCT/8vW8K+MCzBmhWG+ZCgc=;
 b=aMpAwbz9Np+a1YCLA0UZ0HnQOtpTZeerKBTy6d7TusTipr8uU3nmpMEvAgZIIM7OMUGFjbG15cs5UiP3Vhed1i/qLraV6Jj5uuqTvUuY6zy750RTRvnLlqf9rOIl2mdR8Mrtdwe6/IEkUfEu50nGGbDMNA7Qf7evZp7IFx3tZFfJuU0ZT89q/KYE0td0jZMm31HvjKUcmI56sHWXfJxXtPWBJUEC4FDVF9U+H8DEgKkvtO9XDJAPKRQ7vpr+lGsci/zmQxP7nIfZHCCPYk8TMAoqedr3cu6BslXp0x2vAehw+UGeAqycDEMafNIwsqOER003tuHD0E5CnFtZtXj8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2nOYKhmPkPTNbx2/4hfbCT/8vW8K+MCzBmhWG+ZCgc=;
 b=VxSgzAJnA052bm0vGcIm15IacqpXojs+yY077JNfw7tolAXnVVqVUbpP/RVRtkBO6t12sVNc1T0jdxbQiFTqjK6VxcnLReoa76w7lvCJtnGdxdxiUT9zfqGtUbEU5dQ6UmyR6IDwpXFXsao0f7dqDsG/znUaafNfq9ZqyFLKsfE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 14:12:46 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:46 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 02/11] net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
Date:   Mon, 24 Jul 2023 17:12:23 +0300
Message-Id: <20230724141232.233101-3-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed8b06f-d01e-4652-2eb8-08db8c500dbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnO/wz1dK5xVUvx9wnwkqccQ71pzW0zQyFfUhK2dc7I9O3LiJCBcEWfsvZ/usLgEJxaGff+s6L+PyNpbtzr9utyPhzqc/LdMmpJWaioSgOfj1Sr8xn4uo6vyas6n+Q6ieTpuiPog3feGkMHzqpUHCJdHdrDVyuGutMCnKn2XbXAnA1C6cqhKKkU22NCnVD4xeBilRz92F6HnJTuS8TKTpDJ5N/iCpphXculOWx5fXryR6zQKVBSwIKTK6u59VQNnDYScER7/1deloKoY0HjRT2/hteeHIudaKl5LazzrngCxt1+2JC+ZOivTdgcLA+numx7PEmheblXwVROnOPugho4OjC+XHg5XACpGsdJatcM+HJNdnokm6Ap56mt6AL9NaBfNQICGcJXO8xXhAdhaROxf/GO4vKgRQeIVgpQD247U/9KSwnFNY5ZpQQSv0gtjPkeZkrn1HgcNFrE9905nVdqRjF3JO0JFBK82afjMZ6svDFo45vv6eb9sTGeJmP8kc1xhEYK5KM+Pg9/UEfklunxpBI67rLkrcZcT8YjGLgjQxsLRV4nBGjazCF8LhoDoCj6rrpu37qKhA60TzKx5EIaI3qGLskqel8gjKGFbvIAwYIFFF5Yh8cllyDJLnTKk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(52116002)(6486002)(6512007)(478600001)(6666004)(83380400001)(86362001)(2906002)(186003)(2616005)(26005)(6506007)(1076003)(38350700002)(38100700002)(66946007)(66556008)(4326008)(66476007)(316002)(41300700001)(5660300002)(8676002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K9OjNukQrYudqldYNEGW6QXyJeeDK+1ra81t2MCmtUWnp3++tHfzySkAucaN?=
 =?us-ascii?Q?zBffJ0Wd6UBHCKUPsrdg4/XamVSB/jhMQw1OOOrmHhXxHHN3HyoFybsrihtU?=
 =?us-ascii?Q?wjkoCbavemDo3bhcCkImwMoOPPw2SiJROmmBuP/4J3eYLLgLkB94TXp7+SCz?=
 =?us-ascii?Q?xANEYlqvrl9csMH8B+RShCrIX3zM/dEc7DNVfboa1z8243ncAXsUvTp9SVYC?=
 =?us-ascii?Q?ZrIyS7nJ7sHSxVm0xzmj+HrcbMWVJ7jKcKDAflE0qpagg6/lSdOIFq6t1+NU?=
 =?us-ascii?Q?Rl08G6JUYush6Rdj0OgvNSGv4JGSy5u05tNcRgHSIDG+cbDh8s6fqofCO9u7?=
 =?us-ascii?Q?ZXpCQLHFiEeGVkqqWOOW2b3o8xo/RKmx0RB7nctX1US/y7UjwovDEQqX7t+S?=
 =?us-ascii?Q?MXHZT/OvCdBN5a3br7gVNDASSSjy6oVwytvlarcYUzpK9wPA5nClHMor4JC8?=
 =?us-ascii?Q?9hsMp9UFjBqoaR9GVHa+YYpDUlhdZh2H69fypquuXbCZdwht6KKN/jZL+Qs6?=
 =?us-ascii?Q?+l9r9gHZbCigpOfs6RY411GncHq3xZH7fRfni8uw22k8wA5W2d9Kiz04VtY3?=
 =?us-ascii?Q?BZ//0ap3h0fETGjGWaYqnNFmJSypl7tWMYpAYtpJ2zSN+U+dR3+RltfpvWm0?=
 =?us-ascii?Q?xMdCXAfC0xS1JfVK13gw/7BQLkka4n727tguasuUeDdMRAYN+aZ80AIGmO0o?=
 =?us-ascii?Q?CQvPE05E8lHeacGKbfsxv37+jwRbaDEy0pggLY4estVBB07/PDwqXu098r7B?=
 =?us-ascii?Q?HLAbgZqopBBCviYdLmJTi1NhIw5Kc1kO1IfXWW8Umtt7ODqE9QtJs317IkQp?=
 =?us-ascii?Q?qAKipPAqrlDA9oOYfVw+VnHbSoz5O+bh3m45MubprHnvKhf8xaxqLbuQt7++?=
 =?us-ascii?Q?Z4Zs2wTLqo15nZlgWbvapp+hbj9rwqtBUWIjDy8FcSHboGdCosbdycCZHyKc?=
 =?us-ascii?Q?1LUNtno1QMwNOfRZ85C2I+LIo3ui9sK7lR6bPiWGOKSlcRpMUrrwYZBb95kS?=
 =?us-ascii?Q?ThzdSOtAkhtN/vuvpfF3rBNn460e5rIyrGbgRlUMUoDKqjDL0kQdwdcM/rdy?=
 =?us-ascii?Q?ByT1d5I1BaIk8KxLWiVN11XdYVlQ8OsecSDovAN9b1r0fe5NWw0QYef/s7Z8?=
 =?us-ascii?Q?97stKPf4ED4/fxCm1AIsAAPSZKMppP/F0oO7FFyu9GadNafGJaiojyhEsFPj?=
 =?us-ascii?Q?bFatbr8Mz0HaA/w6Vhk3EJ/zQq+XL9k+HklZfmiaNFwcE2rWQa2IO7YkZZMX?=
 =?us-ascii?Q?bjvzU2klW68T3xP0E+XKn6ykHABpRsiZMIGGDjWvlVHlfwQIIFSBzq+9D7LO?=
 =?us-ascii?Q?l7EHAIDUMAJK3YsjTJjBlPbERauAStccZQsc1pCnXFr3mdhsUPkH6+bzX8f5?=
 =?us-ascii?Q?EYZb5XCKpo4ofHtL4k/CTf6xyzwbXL50RULdBuXCeGdvOQeqL17bBRR3sHMe?=
 =?us-ascii?Q?jbik5xga5L1vpi6geLgJc6+/maIOqsGhX5go08juQvzbBNaAFZz4683Eopkj?=
 =?us-ascii?Q?6HUhkUOveVUlPfrcO7knahmr3MKG3/SR7tVpnfBGr1Co+mE2h+//1J25MvfM?=
 =?us-ascii?Q?ngS3C28WTzERrb1OC72QbrGiB6zBU0PVOoAJ921R2C7SEkPnwkNSePTn9KVW?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed8b06f-d01e-4652-2eb8-08db8c500dbf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:46.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWtOh2JMjGlY3Vf/n39FwW9TxzlvIJx0H+UH5ukr0RyZ8ttIvLbkRJhhl7c8HLjuh0uiG8ATH8eIU/zkSxudHxl6kaC3eVC7NgkIliczuBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RX BIST frame counters from the PHY statistics.
In production mode, these counters are always read as 0.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 41b8af0547e4..f1f15a1b6cfc 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -81,9 +81,6 @@
 #define VEND1_SYMBOL_ERROR_COUNTER	0x8350
 #define VEND1_LINK_DROP_COUNTER		0x8352
 #define VEND1_LINK_LOSSES_AND_FAILURES	0x8353
-#define VEND1_R_GOOD_FRAME_CNT		0xA950
-#define VEND1_R_BAD_FRAME_CNT		0xA952
-#define VEND1_R_RXER_FRAME_CNT		0xA954
 #define VEND1_RX_PREAMBLE_COUNT		0xAFCE
 #define VEND1_TX_PREAMBLE_COUNT		0xAFCF
 #define VEND1_RX_IPG_LENGTH		0xAFD0
@@ -809,12 +806,6 @@ static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
 		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
 	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
 		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "r_good_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_GOOD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_bad_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_BAD_FRAME_CNT, 0, GENMASK(15, 0) },
-	{ "r_rxer_frame_cnt", MDIO_MMD_VEND1,
-		VEND1_R_RXER_FRAME_CNT, 0, GENMASK(15, 0) },
 	{ "rx_preamble_count", MDIO_MMD_VEND1,
 		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
 	{ "tx_preamble_count", MDIO_MMD_VEND1,
-- 
2.34.1

