Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73C786763
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbjHXGSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239994AbjHXGSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:18:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57A110F5;
        Wed, 23 Aug 2023 23:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9Mr7YZLAZbB39Rgm7pfkPjiNtTulf2RJ2Mz6kygsl7OjiZBh097Mw6P1YRnXPyDyJXCmzDpLfHtUP+LobJScVEXA6CxvXALRH5elXaHq5rIhnnqeg0qi1jUYtpB4IaIhk+prENA6FDAXXcwR7nzBroWZNpfh7BF8D+0c7bvSGQI64mgsn/0gnVRRw2apGeLPoVjmrt8gO8y3nsbN/aa61EMNEc62DWdtIN4b0ZWlMZgcFkxyMLzBxl7Ih0fA14QgVVCrDfjH7WBT8sJwCC9R115FopJydgy61niVZjroz3GIH+y6dug0aB3cVEW/jKkUb9WESL8AVHeQ3R+Qbeppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oelHKUQffewXaqOcVRaojG+VNGdwJVvfuA7pzhYfy6Q=;
 b=ExEFI7fq71atN571nkc3gcHaRzIeFxWSdYthwYIslHpNOR+9O+NhAOzz/x3CQfETs7ROQXhxypEAgwVB2f5IB1R1imXwmBnAf1/VFhphFamJCX3jYdC0poJ0shfDaS+97uXcwO9tqjoeGQNzBQcYp36bnt5aSAdvyRmz0InNMSmrIEsqAy64UuSr708WSRUE28hDfOqcInqWNB9fqzV/PByShMPWP3SVn0cD9qb1Y0CzqdrntGRNizMytU1BrxgfgodYSUjV3Adnb3WA/mUvQIYgGpcMrfuc7+4mvDwsns9MgymcVdB0SEchQmNOL9EvVfRASHFzg4m7Z4hkE6xASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oelHKUQffewXaqOcVRaojG+VNGdwJVvfuA7pzhYfy6Q=;
 b=pq76BHhmULj4sDEq9JE7XXwZnCgNH+sEyUJrH0DSHpJ46zTczdZj9C0CA579E9pUgZwrgt+gPCYuTDt0Rgwv9EzZL3PYw+4FPGs0z4K3XwDpM0gUrv9Y11gYSZrmQAFom+M/K+zo78Ii2otwqViQc8/+4aobwvLN2aBUVOYib1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB8689.eurprd04.prod.outlook.com (2603:10a6:20b:428::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 06:18:40 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6699.022; Thu, 24 Aug 2023
 06:18:39 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next] net: fec: add statistics for XDP_TX
Date:   Thu, 24 Aug 2023 14:11:50 +0800
Message-Id: <20230824061150.638251-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2abc7787-d174-4721-3b6b-08dba469f527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Havs4TJRuD3JIiUXE1PG807s9nrur9sGIlvWL4GE3Ynw5sQOeJ/265yRWwK3leGuzBWKa2U4G96Wdu6BnBcdxtphSh6x9RCw+q1UmlIFP9IXXAAI+RULJEK8rG3FJgQ/Myjs9WVDfgjGmJgut0gw0BwYhoPH/2ZBJ+z5arutqHB1dUPCS1OpkoozKiGqfKOauV/rW5G6iQLEXTWjLVAMoyUKeuIhb/foF3uBAQYmASr7enL+AfaO043h8B7RCNaakzDuUxfQAeuNfzOWwWR/Zw1WTc/Tsnrk7PLsDqAEqXvmhr1e5CVHK4x8eCwbOFL2MyumQ6Hn1IAYIH2ZKx2h0UsuDPrr7ogSZFgq/0ODmBdXkqZ05BbfX3MrIghp8qF+LVSk8Jm8m1wBAJq4qxkXOJKrFXr8JHix7XzWpA3W7HM+PLSkjz+a7g4lMXeKUMz3Ob/q1/eTpGGBGesH+tH/g+GJ7du0D9jtxBdn49rQ1CnrdwSpJdq0h6FDlK7RZ+LWjjZI9ZFY6rFzaWvweZbr2qtFQ2Fft4zH6/Dbe5zOdFIYD8wXQaxKZSW4MtNwqvXfKRXWyPbOsipjYZPxJW9/XsIdRSFLGJ2muyTAgDlq40=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199024)(186009)(1800799009)(66946007)(66476007)(66556008)(316002)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(86362001)(6486002)(2906002)(6506007)(6512007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5u94rcHRdLsOikbMUOy5GgJkh1N3mWuTD+z2soK1mB03Gkhs/2dlzplVanwC?=
 =?us-ascii?Q?rB6lAmZDc793hBd4yPxq5sbhXctRLesmLoPKuMNBIip6B6cT+7wMAsmv9qs1?=
 =?us-ascii?Q?XNDoOzIw3tlfqb8DOs/vLvTIrzDVgl9YLqQ2Exq0hOPiK6njBaWLGszgHGcW?=
 =?us-ascii?Q?QLz4F8BFHpXzTTPAbFWcKCdrHnNaJqulWP/f5QdpkhP+eqQxBZy0lw8SY1Fb?=
 =?us-ascii?Q?ISmN2mxfWLo3TbKzszlhDCnc5hHaE/xEI5t3TB0aRU3r8DcT1W+g9zRypdRD?=
 =?us-ascii?Q?ecWlW8UbKT5lBS9nJSyZEEOeJkHzJyKHOQg/Dhksby8uWbrUF3E8ROklIadm?=
 =?us-ascii?Q?rU+86MLwxUPJu1PPO91kjr7hYdcvo/Yz0hmQOum24FDKt45rdy5svLGwRz8w?=
 =?us-ascii?Q?RPq8Nuuert88Mv39WYgCRYA8/KSP3/tgzbp/ZN+IorkWDZH59vwsKRhf85tR?=
 =?us-ascii?Q?7YzuhlNcwMfBPwKUrgu98ez7ic/fZfAgoxA0gcenqRk9IpRxkknE8IfZ9dwQ?=
 =?us-ascii?Q?+G8obcdlrtE6cxfec89HmtsYRlRuFrhZ+1T7CnV6j4MpWlz0BBXNUfe8CJUx?=
 =?us-ascii?Q?T+EO+OTPNIWhaWMTWSCAIFWnv3lWAw1SgulQBlCIbyPLZ3yrf8fNKv60D3Vy?=
 =?us-ascii?Q?0H92bElMgLx2xey7pw2JmDzgWTj5cTAs8QQAO3AF3JDuszUpKfYRMTHUgyRk?=
 =?us-ascii?Q?0Zi4FnPsDHca82bbLcSfEgmb1GbAPhQAZ0f+3Emoo8KShB/+Tkq7ePVCnWtx?=
 =?us-ascii?Q?mrxxHrehmiJxGvbea6vZhu+BGPYYWg2rn3lHCuN9D3TkJaAc6/GlMUixy0Rs?=
 =?us-ascii?Q?JMrTorUnjNzcePRRA/cuLioeYffJ88wzeP0GNoyX8qHiEs5P0XoxuOxd5WCN?=
 =?us-ascii?Q?vh55J9uN4140d+9trUmdyHCm0OS/7SsrK892hIQPhZL+0tcgMFaDOc+RKXnl?=
 =?us-ascii?Q?AW/4p9OKLPmlfbQnQHJPxw3+2RFYfUsWHd6B8cid+VZeR28t6d9XMrybcW5q?=
 =?us-ascii?Q?FcLKtrPdmrJ0bogPgGrpe0RJmUCp5bsZeyJMQAiMJjUMyVTErMsqCGm6sm1H?=
 =?us-ascii?Q?YsTwAKhHu36l4zhPNldB1xzMNSYw1pdHipWzuXuOfv5D8aGdXPMaW0vfEuOF?=
 =?us-ascii?Q?BRVxND159wqVCYFe6ApSQaPa3s297qJg7mELl2NlhyhdSpRelaHlc5qB/xo/?=
 =?us-ascii?Q?QebU/0jutNUXCs5eyqdc+GyLOpGBUkqok2v+MaVdl7E/uOiq/beN7i49PuMO?=
 =?us-ascii?Q?wvJRw7XnyC6bdzCGpuyN9Ico6GtXigJk2NsC67WeHCmXq74a4OBvwXseW9uX?=
 =?us-ascii?Q?ZAreocdMxLVcGlQjA7C8Z66NPnXl/Vs3zFfOATRJISST24fbGmyAjKJVLFxP?=
 =?us-ascii?Q?TEzVA27Mjf5iBxXtrR3qgAPom93KZgHMWeFhMxx/64M1qpl1DzNzgoQqwH/D?=
 =?us-ascii?Q?kT4vnm9Ywih3ewxcJNIlLKCJe/chxI6Jd4Y+z8hxmbcvHl7I4upQpC0cxhat?=
 =?us-ascii?Q?nKGmCoTtwKOvP9sr2gs3hQtPNBw9e/lusq+ENawNlckX8Jjgn0G15d9nGNXq?=
 =?us-ascii?Q?mNUEF/RLiCsKmL3PYuG1L0ywbMEJj9KiwSwj/kT6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2abc7787-d174-4721-3b6b-08dba469f527
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 06:18:39.8528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUl0Zz/J/U/qLzc7y3NOrqhXYuj8Kbwv3GEOtm/GQETtBslZwQjRxLN39mjut+Vxnf4KFYvebk7Bwt1+Zq1Q3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8689
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FEC driver supports the statistics for XDP actions except for
XDP_TX before, because the XDP_TX was not supported when adding
the statistics for XDP. Now the FEC driver has supported XDP_TX
since commit f601899e4321 ("net: fec: add XDP_TX feature support").
So it's reasonable and necessary to add statistics for XDP_TX.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8909899e9a31..77c8e9cfb445 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1590,9 +1590,12 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
 		break;
 
 	case XDP_TX:
+		rxq->stats[RX_XDP_TX]++;
 		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
-		if (unlikely(err))
+		if (unlikely(err)) {
+			rxq->stats[RX_XDP_TX_ERRORS]++;
 			goto xdp_err;
+		}
 
 		ret = FEC_ENET_XDP_TX;
 		break;
-- 
2.25.1

