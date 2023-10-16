Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F97CAD92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjJPPdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJPPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:32:56 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89997E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBBxVUMQcPDWdqR3rhatFPJo32IP2xUTo+VKeqBERk019x75VsuAMvbOxI49k2IMJXA43YLbk+tnNxCG7rbMkKteCpQs7Fd3HI05R8MtzaQ+pFiCMY7iN6Z9Ub6FTXgZbA2nt/x4DuDYLZ0lD7cbfxjgWyb2GcErRTTekWeA5ObsHYgTWV5dszwH9w/keWni7h9xRG3waQW6BVP0ODRk14XdXNPm4r8skVq9eizLkhwFqd+dao3wzTl2bgHOCU4UeIH7JLShGdMDyuOiyxudXxu/Ihc2pqEqKR9Mxh1G9rl6cNRRIDeJdMLvlXyLk9tnIQWhY5sO6L8F6Y6qmYjLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nlpPOSgD82lCFohI2OxZVAzkZFLmByfJ5q7/Un/BtU=;
 b=jYYc0yN/fggC1AM3E8EBeGYa5w0uMjMks63rvv/OOQ78ZQl2OSudoPyFr5QG+cgpCnG39ZQmPZLSnbUKUq9ZpYXFUHlwgyLph6xpCeJipYnTJkBNf9fT2dgSPDEppAbxLZmBQUgeP7zPY2xqDxTPP2pB4xlOyh/ddOXus+9IYXHs4xt8HMd49uGlus7/bE6w/7BqDSmuVbwVHtJQUKjOHT0CjrQKnd7UD2JhuFc9DF/R8AETkoy00ws+0fxG29PQ7Stpnx6Vjd11fqHrAJt6SDT8Qc+QvygHqwD1nb//tFBco7HgpachLWUvTG7o4VYJk2/pryTRXSR/0rYgwO1iJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nlpPOSgD82lCFohI2OxZVAzkZFLmByfJ5q7/Un/BtU=;
 b=QVgiMOnZ6e31r5UB8NQNNvxRd59Mw737pHPAFE3sD8ExIMJlYvrH0N0/OdbnOOixXXY/690iPSNsDBCMmGfkA5umxybyq9M5wAELCRNNof7ypLmFzHkCMUWb37StIdFWlKaYppr+z5oNPXniV6bxlspo70VGanO5m6FveNEnquI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:32:52 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:32:52 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 3/6] i3c: master: svc: fix ibi may not return mandatory data byte
Date:   Mon, 16 Oct 2023 11:32:29 -0400
Message-Id: <20231016153232.2851095-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016153232.2851095-1-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 228fb6ec-eb36-4ae8-85e1-08dbce5d295b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r5DQA8AAe9uCLCPw/yNtnHF/BtLLZ69MhREwJTvSOIez5aXdTkCF1A6/c8xUnWGcrxtBpzo7dhhfRinvgLyIZEcF3BlrLeg2Q2nLP7iCKrQLvsIkIO95YYU0j1zy373/aEkdGL5gafcDyu4yf+gnoh7JLPdh/0d/nOnvcUAAzGy0JSZRHUhm6iyDjitb/hWuLml8pLQmdk30f+F9Az9W2W+z0afAoCfuuO33f3AIpb2Uz8WkaDWTa7EpqvkDfVIyqRGljipGellu4mqw5wjUEmwa77qO6r3dNntVO2Z9usPT9mFkrAA8p1glwNVgCEF9NyTHfV01U3hdMCU2Y/mBOYYJjVyK7QwibjgwXYLgpqQVALrqqwKlGi6Me3JNJe1CDxIn6a1sJEY+b1e48Q43cTDYAxYaHmknn06YhiHxKXuGw+LyP9KVNC+rdixvHH6P0QoiDUZHdH0+W2V3P+6+6Hj4mv81du7s3a3vAlDs2FFdp9KkoFHfoD3TCyqcWKLV86vdoYjQkjgzapsHsgWlmAgMn7kG821cuZM5QvkNnS6aI/hCbpVStc8mSVIx8dWJHdVJg6Q9w9wE2NQ/8m10Y2KMRhRXPqOaiIvjMLxcuW4DVfyMb/cy/A7LN+x9yGaP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(38350700005)(36756003)(38100700002)(83380400001)(6666004)(6512007)(26005)(6506007)(316002)(66946007)(66556008)(66476007)(478600001)(1076003)(2616005)(52116002)(2906002)(41300700001)(86362001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IoBqb4FNPokrL02kKzDsKh0FN2+tQuLyUOPGzgEtYslwTLUdJ2I2mvRkzfct?=
 =?us-ascii?Q?UnsVX2jeEiViDKjY7ttXGPaLlr9A8LgSYIdnEJKtTgMuzXsuRr4PZX4v9Kcg?=
 =?us-ascii?Q?BAp/foqajeWElzOBPq34eNaRsRuUFZTYlNSR73QoRnOgkGIw0ruSZjc0uFt9?=
 =?us-ascii?Q?6Rc3/VztkYZdKF/7ie2ySBM7xTbOmyllIhclZF6uUkpf9zw6tNo3X2SiUsY8?=
 =?us-ascii?Q?TPHKpX2nAEG3wS4YeYMSj9yDsgJLMV3Xphs9Gc4Zh4B/L7Wo2ZuQ58swDCSO?=
 =?us-ascii?Q?w60nF1iw0I+2ycqw1d7uZW+NnLF83oUpdEEww88uh/FpWiaMiIFscjiQ5O43?=
 =?us-ascii?Q?x+U0mcplVplUxWW2qOgbFhvNlZKWG9T78QaGvVUkvR9tBMsq1wzIroQLVjAw?=
 =?us-ascii?Q?1v5rXExt5Q68gTNxekBdrYIhw/0LnEAtnthlY39JX4L0UE0ldfG8CKTLGEId?=
 =?us-ascii?Q?xMG6T7Fqe9s2lN7nCcbyHIgqjqmUEotv8QQZSvaroUNUKfXrEBbdQEt9DLWH?=
 =?us-ascii?Q?44boC3YFakrXyb+MGvohu6HBEjumpa+2VsnVPZCkzoRyiakd8Nu2TOc72/lT?=
 =?us-ascii?Q?pZrbIwHUli2P2DLmfKy2OOd39rqGZmTT5l7VNoLkD656wohOFmJUCU5L2Nr2?=
 =?us-ascii?Q?FOi42weOMyVlAGSSzbl4ok20AH5WIX6F40wNm24RaK480J0DcjPSS5oMdUDn?=
 =?us-ascii?Q?Wra8XhAr9XrIBj074AmqmamD1TlGVx0gHoD5iBOJl90FM03ByOFaYxGDuH1L?=
 =?us-ascii?Q?YXXYUsE1kyAYRBcYVDKnDwBhc6f8Lc5M5ujBqAfhfG9JixbrNuZufUtFWSTr?=
 =?us-ascii?Q?ix2fkJwOLQgBgMt9nzqU8nEkopjaYTrIYRqjsSWUPLNi0oaPSol/EIfNPD0m?=
 =?us-ascii?Q?q82+1gJFiWFJriYR2+g55fkGj6q++DTgc3X1VdqugGYXN+UDEFsWBwkMNcfP?=
 =?us-ascii?Q?6XckpfnGXtWnkN0faxRvDKLAFBElF3qAPXAExQgSdr2OLDCc//F1/cy8Xnfv?=
 =?us-ascii?Q?ulkZg3NXsu0lmtii+lUYXKeRnvPOY8ibyBGfPtK8oGBUK3/DoNQVse4VhSH1?=
 =?us-ascii?Q?pwLfIwaPT7g3bHJsSUaLGmH7q9E4RnI4lqkvv/Cavq9QTlPKne5Qsi+thE4E?=
 =?us-ascii?Q?y9UMpxXW7eD/OId+iqJ5a3CEIrvXEsOwTc2Dl5GlQdyiGYWnUaYFr9eAbDZT?=
 =?us-ascii?Q?pIe6nfD0ur+H+rRsQXL6fBWpOwa+v8QKMfhU31nBn8OjabMkw7bmLHlXVRcT?=
 =?us-ascii?Q?PkOXUbFEAhTUyeZc5jnTUZB7dnOTrs8f1CoX55P7dlX4qjp6gHOs0VQYn5J9?=
 =?us-ascii?Q?1nJkrUvTa/vpoPmaGM2WsYaeNMUh8Ries0lVyYiqntvyvBhg0KrE+wHQu/uX?=
 =?us-ascii?Q?XwMga5SSBpoxgmvIVS9oRIiD5S/CWSqoIxNeWkVABWRbLul8iPYp4vLxppnR?=
 =?us-ascii?Q?GXqsSRwmuTLUw6+kQpzuVUr/LhBPReSfZriA3bcce8pJS0MwuIuLpAQPTNO3?=
 =?us-ascii?Q?Qxp36vIuh4Zf0kyM/FsykEE1aggt1HBiQVRskrCfqHVC+3u67HsoUtIey9Wm?=
 =?us-ascii?Q?te5NrHaxIa6Mxd5/0y8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228fb6ec-eb36-4ae8-85e1-08dbce5d295b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:32:52.5814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8TH6LOoBvCXB3j3NM3BetkRqfwiIOaRbtjPpHw3s4Jy+SI1PqPDcN0o33A8+Jk6JvnF9NFGvckCHXGJfkIEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSTATUS[RXPEND] is only updated after the data transfer cycle started. This
creates an issue when the I3C clock is slow, and the CPU is running fast
enough that MSTATUS[RXPEND] may not be updated when the code reach checking
point. As a result, mandatory data are being missed.

Add a wait for MSTATUS[COMPLETE] to ensure that all mandatory data already
in FIFO.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0f57a5f75e39..c252446b2bc5 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -331,6 +331,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	struct i3c_ibi_slot *slot;
 	unsigned int count;
 	u32 mdatactrl;
+	int ret, val;
 	u8 *buf;
 
 	slot = i3c_generic_ibi_get_free_slot(data->ibi_pool);
@@ -340,6 +341,13 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 	slot->len = 0;
 	buf = slot->data;
 
+	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
+	if (ret) {
+		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		return ret;
+	}
+
 	while (SVC_I3C_MSTATUS_RXPEND(readl(master->regs + SVC_I3C_MSTATUS))  &&
 	       slot->len < SVC_I3C_FIFO_SIZE) {
 		mdatactrl = readl(master->regs + SVC_I3C_MDATACTRL);
-- 
2.34.1

