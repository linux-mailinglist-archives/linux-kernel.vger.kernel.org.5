Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDD78DED4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbjH3TLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244992AbjH3OR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:17:59 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AAEC3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuxjBVxpBOM/NWdQFUVERQ9ycZBshJHkc1Zbv20bu+o+7dWE5j9A3HZ8u7aGi3XBjpGI5npnyaFrKDM76sm0fUwEKxoG8WAyRbv85nLO1cGkmt47g7I+lKIMlKcPeYR4GBfT9hVQGGwPCPrgqmVFJSOU2otjMqTr04qOUL+5jAJJdCNL1POy/wS4rq9yDW1cCXq/9JER7vPUHcjF+0dreWNvJABTiRjZVoemWHr7aqeJ7mzIBZJopfwxpaFEZGItxHRU776MQ7zYLl87saufBlLQC7w5d5Rl9F3NEcIxWfrAqZnIj38cvt4x9qbTUEkWaQ5dfIz1rwkBqGtXE+ku8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F74Yp5uHqsh8M3wM90HYsQ2WQME55W95xlGAf41dc4Y=;
 b=UAUvljjJx/nQz/q+VIf23jomPG+2DyvzOSSw2nS+OLDrnXQ5JewXoU6uBqQBpNTQYdbT4y0bU9YIcW/hNHZhfNEk1muRa+Iy9yU8SBci1ezpWGLVhFofjw6X2/KZTEbCUG2D5hWmWLwjB8toE3BvsVmWHVwuJVcBrF955lxPsIKqSxcW07pQNh5YqspB9/H2J6JKRE51nXVG2M4Uo6WKrW35enCeOsrIZKt76Mi4/PzQCvoeoQBm6dwRI5a/h1Y7Pk5VOgr2DNmbI6Mw46iIFSdT/FJXbNAdBoYAwyktASWXgRWpiAzkkquvcY0012LHl1r1qCJo9ugxJpnd6r8lvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F74Yp5uHqsh8M3wM90HYsQ2WQME55W95xlGAf41dc4Y=;
 b=de6OuMXONrZlclFqn8ciB3g0aodx/XANL4L032OhDhXId0rAWcbWEqD0wDoD4rA2BHH2YdsjCCx35vLlA1Cg/t74cZpN5E7pRDQwPZ8IpuOWNBlU1OIr/niy7xexIvObz33FalSHzOSaoAiV0tMV3m2+eP9z/bmKNhL0kpo1nYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6827.eurprd04.prod.outlook.com (2603:10a6:10:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 30 Aug
 2023 14:17:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 14:17:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] i3c: master: svc: fix probe failure when no i3c device exist
Date:   Wed, 30 Aug 2023 10:17:27 -0400
Message-Id: <20230830141727.3794152-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830141727.3794152-1-Frank.Li@nxp.com>
References: <20230830141727.3794152-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::11) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdba2fa-5405-43e9-e475-08dba963e592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oikQ/W7r2Wrx5nqLUA04mmWRxa4ma18awPEief1rK2CGLM0Y2F5iPFfOPKJ2j2pJFnENIggcUGFsgDf2t9L1Nij7wON6ftd8+eNWhTiMwnN6GXzaOfg3Gwl9tLkE01vlotWx5ak8+ryVP63finLKhLdHwt5UtOkGaeWkay919ZC/Azw360Dh3Y9h59bfv/gYU0r7HTkrfA/lG1AlvDXdOC8F9kqpPTZt1ytxJPKZ9Wn2LCdGRsHzET3XhVigffefro5ELnzqPkNs/yyQfqdWg1x8svuyVl4LO5rovDHCGZ06R50cm1hODkZPzGuSDA4Y1K8go7DAXozeSwdM1nhbrL418Mo2QgR+calCmTlzZWb6EB3iFvuUCArgMuaVRiD9sNi1qf75+LJvrjPRNsb6/KT5elAgYBfF2nXm9U5pMYUZjAECrLoIKWPOBkBsuknzn4IBo2ySNdB6Ju4Rs32nhlB/yloPFN5Wsbq7+kYRRA4nmg9XVSv1nRbl5d6TKMIU9VsMdcGfMuys69/hZMrDHXbyPLe0TpDIqHIrblKQPUnQM09cgoU++Yn+p2ydDNIK22YsrLdz9D7LBPrmNv4Qyx/PImpH9ewB5v+t8yMy7Mrm4bUfyAkF3WOPnNcmJexhSGqDg8JsyOlTAWq72FyCyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(66476007)(6916009)(36756003)(316002)(2616005)(66556008)(8936002)(478600001)(4326008)(6512007)(41300700001)(1076003)(6666004)(8676002)(66946007)(38350700002)(52116002)(6506007)(6486002)(2906002)(83380400001)(38100700002)(5660300002)(26005)(86362001)(42413004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6yofLeDdIoRU3/37goqjl01uBeYEmC/Jy0FmK+vUIX6OYFiPF9iZN2HfzX/F?=
 =?us-ascii?Q?HdR6Vi65Xb4sD3a912u+IaagpC5h5HjBfMzVsz/rc66x3GJYX8WZpOlsVM8p?=
 =?us-ascii?Q?Qjny9wvt2t30DF4EplB1szt3oryF6sSPTgHE/CPDMDTZes/vwS3P9R4zWPaH?=
 =?us-ascii?Q?646GMubshxOk9B0fdA99zQbcm8FILxOs8Biq50h2dkLwoJk3iC3aZ53Hn6nd?=
 =?us-ascii?Q?jq+6QTpEHMyGVvGwxrXFz1NHOEtuUh18f+O4jNox9heac5+9TjQImq9SyMD2?=
 =?us-ascii?Q?QoPKMdL8uMa0X2oadExCfCvKY46+0L2ldjVMYD2P9999trlJypvoVUuPGBYL?=
 =?us-ascii?Q?y88RhEkfNVs18JW5oPyHox9deEWzOjBeUom30i5P547US/A+QRdn37zcKp1b?=
 =?us-ascii?Q?XJf++DVKVdhuvkMEqp8JlxgT0A/oQf7k9vWGIjyJxUJjBxbihkoponokTkrk?=
 =?us-ascii?Q?oRVzCWRQatUb6xypFsxdltDmBOH+5X73enyBjdpNRX+wqpQKJX+aYnkHYkRa?=
 =?us-ascii?Q?na7tLO6IbZdzkGesE3lprtekPaPVtQRTLfncENg3f1XfBr6x7h+NQHLEDebK?=
 =?us-ascii?Q?INjOg9WQ9rgPvjDMP6wiCnHFBmpzNxfCDkOU2195q2740JHHXKkvM7e0uBDr?=
 =?us-ascii?Q?zr0RtScjhx+dtGXUDYbDimHswqSSAPRunQiTxzM2/HR+VRbTYYisVEUpJy1N?=
 =?us-ascii?Q?ZBfXmLDNP57xdDMsw8YjgPBLsPMO7QDwqniRU9wQxxP7ec682H5YkzHaVjOi?=
 =?us-ascii?Q?4D9J9psuLurxE1y6Tq246P/DYSxWs2Iv3XecweDsIOhWNkNhTkHyT9bYo1fc?=
 =?us-ascii?Q?km8B0bf3+niBGj260X0BvCRjXMQlAll/A55aM+Z1a/g1b4FZvvDtxyeAN5VR?=
 =?us-ascii?Q?mymEu3fSfbSm/vDaCyM8jIYEYQYhXeamGkBN9F0nlmi8vp6nohwuWZ1pyFIB?=
 =?us-ascii?Q?nq4iuDsp8YBlHd6Y03/6y7gYluKswjgC8pSRRBmgASofTU/7Cbz08Jps8Aty?=
 =?us-ascii?Q?i5k0KomYtkPmOZlj8RLa7NOtiNDZQWcua5Nvjc2Tudqk/EyFZJctIU/BTTEh?=
 =?us-ascii?Q?JfnlijNqkx/Ub/7j6iYYzDvF13diPQgxVplprhePOXp13stp/VaFpRM2sqsS?=
 =?us-ascii?Q?/tqHJt5zEoFUScTgq1BKBYAfHcf7ZijBRrR0yzk8R0Aezg/3i+w1HbABB96u?=
 =?us-ascii?Q?ydQ8s4Vd+fs58EMX2Yi10nXS1MWHOb0/W96LTHZtlW1FFWnhuB9/tf0jBGyu?=
 =?us-ascii?Q?89Oo620uGT5wYkEVSgeKb5TEbQTSN4oTH8sjaUbLj9DSyQkbWhWKRrisrxE8?=
 =?us-ascii?Q?l9wE7zOEw3PPOSJWfqRTibl4TzNHVIZbAKLPutRW4rQczqiQ0P70mQA1iTcd?=
 =?us-ascii?Q?2lcvHTMoqbE0VPQQa5TDUXpS3h/33QypZmFB4BF17iXnE872zvO/O5zsFbvA?=
 =?us-ascii?Q?dkTy5H1ZK1zrd7yRxc9mT+0kHMwb/mKmSqBvv8tQe38c+CS/+nQDEmfgAAiS?=
 =?us-ascii?Q?zP4QrrR/8oxKii4wMUHOsTdQPlIqDrf9cQKkmk8Ln3j/HRo0cWlpUVp3IAfM?=
 =?us-ascii?Q?Xkrys3QsO6bo9vQ5x6s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdba2fa-5405-43e9-e475-08dba963e592
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 14:17:52.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PLVQdPco8rKF9HZCK0B4hOIY1Jj+OGm+s/GL3/6vcSZrFKcMCF0Z2ZdHGl3OtXD48g/AEnq/weWiXRZQdF+ItQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C masters are expected to support hot-join. This means at initialization
time we might not yet discover any device and this should not be treated
as a fatal error.

During the DAA procedure which happens at probe time, if no device has
joined, all CCC will be NACKed (from a bus perspective). This leads to an
early return with an error code which fails the probe of the master.

Let's avoid this by just telling the core through an I3C_ERROR_M2
return command code that no device was discovered, which is a valid
situation. This way the master will no longer bail out and fail to probe
for a wrong reason.

Cc: stable@vger.kernel.org
Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2:
    - rewrite commit message
    - cc stable
    - add empty line in daa()

 drivers/i3c/master/svc-i3c-master.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 770b40e28015e..cf932ee056ef9 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -789,6 +789,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 				 */
 				break;
 			} else if (SVC_I3C_MSTATUS_NACKED(reg)) {
+				/* No I3C devices attached */
+				if (dev_nb == 0)
+					break;
+
 				/*
 				 * A slave device nacked the address, this is
 				 * allowed only once, DAA will be stopped and
@@ -1263,11 +1267,17 @@ static int svc_i3c_master_send_ccc_cmd(struct i3c_master_controller *m,
 {
 	struct svc_i3c_master *master = to_svc_i3c_master(m);
 	bool broadcast = cmd->id < 0x80;
+	int ret;
 
 	if (broadcast)
-		return svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_bdcast_ccc_cmd(master, cmd);
 	else
-		return svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+		ret = svc_i3c_master_send_direct_ccc_cmd(master, cmd);
+
+	if (ret)
+		cmd->err = I3C_ERROR_M2;
+
+	return ret;
 }
 
 static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
-- 
2.34.1

