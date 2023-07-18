Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DE575779D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbjGRJQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjGRJQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:16:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D910E0;
        Tue, 18 Jul 2023 02:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzQGFlE0YK7Kw8b12j13f5YWJjtCstIwBN0EWRW1ait+4Z1N8UCvZdn+ij9/zuz887+1PnverGGbUY+dl2lyHXxlal9lCtFiaVXJINFw/ljclObzoWel5z3ol8+bpDhPuNGJRJyTEw8wWbcFcAvckjnkW5d286u2gcPE2FHPGedjO07OIyGFlUaIwFpPj8RUf3qADw57qu1RPD93uJIXFvnXnLz1Rp3NpdFbqj9yngHRBsh5MJp5iuUWArWq1SCq6r4wLAdXoLlBt9Tit8MOxE+BWW3lfYjXI4erqTMXpfr73DjCC6rXVMmtYu0I6/AuQCr0iL9EbDtGNj7MBUPyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkkAU0pu2XbALYKjcy6Iq8HGhF6SpG5UNEx58ZjEiTQ=;
 b=mDYRUxGnhGnWQxfWpFIoud6ipDyfVOkK8MqTH8TJ1pKOJg3ZECRaLOROl5ydKh9IqUT8vy52Gk9BslHBHyKI1Ozi1Ktcj7N4FzpjpVbbHHAZhcKniLsQUfmS45PU+Eljtp871k/RdsUdcN2rJTTVJ3PpuaXLTj0jCwVN4MmfEZnl6wwYhs+ttd5gxFCqckpEiAzeYHl/XwjokiZ+VU/rdlnZsA2XYaaCwGY/rJPO+zEHEFWqJCy/45PGZa9xEz5/h7Q26HraFnb+x+hA1kwP3YLpEKJfCgtCVNL5Izlpq2em3FOFCH0E43Q0n2hFudlamT4JVPmMo6/w2gvB9GqJ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkkAU0pu2XbALYKjcy6Iq8HGhF6SpG5UNEx58ZjEiTQ=;
 b=rtK5HGuSRGVJ+diY+PReQysayjjUm7eYgVt0OfqYr6LOLQfhQ+YRRMYq+qUlmrfn+PFsUr0ZuiuZOC3ILGNknHzqit0n9hHmZh5ZT+8xizu9MbxbM4gbZFV3ZdQvrYG1mQPTIOQMd5sCAQuvdW/cksbrylEGPDtQofdX1BWP284=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:16:12 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:16:12 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next 2/3] net: fec: remove fec_set_mac_address() from fec_enet_init()
Date:   Tue, 18 Jul 2023 17:09:27 +0800
Message-Id: <20230718090928.2654347-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718090928.2654347-1-wei.fang@nxp.com>
References: <20230718090928.2654347-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: d3464d16-2f6e-41dc-d3f2-08db876fa12a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfhXaUKikeHMlvWRKDigY29WWlJSc15b4u0n7vYyn1X2uSMEYrv2MRrAGX7i42zR884qAZxf7HaBKfAZH/otitcuUxBF80MvmmE8aVYApqLc8DskT5GGDpsQUQRql0cQvXgExCUAhnjNj6EkNFaQKS2VTXN6/8w1ZeTlHJyggOi5HlSrxELauTCd+zNIjqxPwRgG32YkffoEJetePjW2prPC0dkT2ATLv6ZA8V7ifkycueBsTZyKPmAEvOsRNkwUKrmvSDg15QvTaKAGz6hWegegwCp3DKj445t4zwDAeEDj4Agj0psDZqDK8yPLbomRSOr5N/T32P52t7P/V9bqmRMVlZ2MjLWUJmTTNhU8EBvn7uN8f7nQnShGM0JeuvABEq2JXWMgfLPiVe6ga9ZzyTbmEjf9WMuaut6uOWQZwzOfSxlaK4swDwye4ucozY2qFTzwub6WiDsjNYX63Va4KW/hWXN5URFfw7FXi92dAoY73Jqj0jYHLm8kF1TorUxG0Wa35efBKnVQsSTshjiwRU0LbVMy+wKia+vBAD1mQaFmQcmTkOExAZecMWWFr8RTUKfiRloVZI6PD0NEBAra4enZ0tTW7UCFQe23tBlLIISOVNWxXj9J2/tHtFAYnYys
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(66556008)(83380400001)(2616005)(41300700001)(5660300002)(36756003)(86362001)(44832011)(8676002)(8936002)(38350700002)(38100700002)(6666004)(6512007)(316002)(52116002)(6486002)(66476007)(66946007)(4326008)(478600001)(2906002)(186003)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o8fza16xtDCWF5Q4W07H7cVQfeFyjlleDgLAfpUiZb3vl2fKSxKR7+3yl05a?=
 =?us-ascii?Q?I4X0hAlxc9d8suZBcKYEv/R3RT903j0kvmWUqUaAoQDAy6lh1BlBR9P7qTlI?=
 =?us-ascii?Q?l5NHGfYree9/sOpV2xpXcu6E6RdrFwBIu5vCb16rMTDmRB+NlW+R7frjl7B2?=
 =?us-ascii?Q?7mfssntSEAna/FCwkBwhuEqhKExFv6HDozrKV99peQcczsuHeltANOSHa8/D?=
 =?us-ascii?Q?bWRlUkH8E7vFc7UmOPYoXtkqzKLkgHZoJ7Ok2pQS4HncxgACeKFFB0iAgAVd?=
 =?us-ascii?Q?+FDtUiNZHuNh+Y4I+c9x14s37ZzklL5adfaOos5gmCTNfwZKqpU9izvOde0B?=
 =?us-ascii?Q?nzkC0FsSKGkt7EkrVOnDbFYXNTH8exwX9xnLqoErtLhqBTIH2rhcypPxdvgu?=
 =?us-ascii?Q?7ejAI9lcU8pRp0uFlJVdQ0hFEp+0i3CQ/NOrv5Y0jxUCT/VIEK3AoJZwK58P?=
 =?us-ascii?Q?iDqpaSooos1fFnLpGOlgT8QwcqaBqwBVvyIcv2qsudMS7+0LINClIvpYccrm?=
 =?us-ascii?Q?D98nikJPsbggVBxeu7xb7c16k89z0wap4eqHF4P/oUBXStdu/Vvg/EFfjb9m?=
 =?us-ascii?Q?VQ1iepuhnB1sGaGv01F7c/1B0Tem9/8sJawtezXO5AB08rUL7No6Y5o9On1B?=
 =?us-ascii?Q?CpLg8zoApcFMoexGuy/+QnetBTKSrSmjimd7O9D5dCSpW+2rcsrdwEGnvNHd?=
 =?us-ascii?Q?fPCtdLuliIW1YMMGUnxK6BwNZz05w7UJwrL3lHyvVSWmjbDUY+qkAcD4+3aK?=
 =?us-ascii?Q?aoVQqJKcWiTtEe+kdJdFzuFREuBYsjtEyTZ0Gc00PqV3ZtFWkbABKBYKkkmC?=
 =?us-ascii?Q?BlfL2kAtVV93ttjDGibgPmLauMAG9vR+KwBShXiWFBSOIVrEOFqIWeCqAa8K?=
 =?us-ascii?Q?Z3nd/KlsnZ8pQBw56CYy083Gc6RocB1EFbR1tm2i/j/htTR3T1Y/2qewgqub?=
 =?us-ascii?Q?7K5Qx+gR6ezA86MOAtE7Jik2qj/7aIc7DzPWvzv1ABda7ir/qUO1yhpcLb5T?=
 =?us-ascii?Q?AayemwsWHI5uxiNasoLyYeo3bfaycmibkaRpDnj84Q1f3hez54B7xjqtcaay?=
 =?us-ascii?Q?ft5O8dsz2tvtcvGNZzwbF6CEe0xTvjNCzVGDJaXSkPtg+qSKSZtUr9s42ypk?=
 =?us-ascii?Q?e8Hw98V6I+FtHabzmq3YuYKkOra1o124G5w3Qb5NqQ8hkYZ/s9HymbEjCaXu?=
 =?us-ascii?Q?GF6uP2IUFNU2qEcYwxmoWjoaybSr1GzkXYowTan4FS0PQFeMdXLZiGwr/CyK?=
 =?us-ascii?Q?vPOS9cck8D+KZkfEBoY+x6G6iPHlu4rNLEn/fNimDmCiWhXzm+VdoWbPYRM1?=
 =?us-ascii?Q?CRnZu7WILZIhwns/4IApUtGS/6VTr7DGue2i2RFfYSRHiLRbePhdPVwLqL9j?=
 =?us-ascii?Q?e3MaDYqhvePHhZ/0YdIsZ8p/shnMwG6vT8yPLrb2E7/HZ0f0qNoFP7Qg5ZNS?=
 =?us-ascii?Q?wa/1ChpjY2xA58PmAaWAQlY47zMif2zwjgaMhDtrpb7aMf8b+gcTP9bjFimr?=
 =?us-ascii?Q?drNxFmm0R2FzgvCkSUKKqzNR/P+v8/7Xr/7397NTWY40AxU/7+CRgC9bNO/K?=
 =?us-ascii?Q?/VKQg3n/+7bv+Dq+aYIHqxBk8NSuPp8koPpu2/r2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3464d16-2f6e-41dc-d3f2-08db876fa12a
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:16:12.1163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6/ayd9cugIGdgj+xZjdwqnvnB7Ef1RkZP8buo4yDMARVsq+oYlRiuLN1prBpS8Ve3YfRmOyPAhGagFXQGB7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fec_enet_init() is only invoked when the FEC driver probes, and
the network device of FEC is not been brought up at this moment. So
the fec_set_mac_address() does nothing and just returns zero when it
is invoked in the fec_enet_init(). Actually, the MAC address is set
into the hardware through fec_restart() which is also called in the
fec_enet_init().

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index d33bf7979430..1a21cff019b0 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4015,9 +4015,6 @@ static int fec_enet_init(struct net_device *ndev)
 	if (ret)
 		goto free_queue_mem;
 
-	/* make sure MAC we just acquired is programmed into the hw */
-	fec_set_mac_address(ndev, NULL);
-
 	/* Set receive and transmit descriptor base. */
 	for (i = 0; i < fep->num_rx_queues; i++) {
 		struct fec_enet_priv_rx_q *rxq = fep->rx_queue[i];
-- 
2.25.1

