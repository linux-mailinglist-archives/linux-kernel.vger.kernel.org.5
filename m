Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA037CE9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjJRVMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbjJRVMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7524D5C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAx9Fi/NUKnIk/97Ks0YcHayuAw0p9KDkeoNboD1OI6rlEidXnyIWjFxZBieKPiCzNCTqbEx2rouP1wXOt0oNA1omnqGBOvVwd83xRurFt3J3F//uGs+dI3ATL2POwHBM+xS5lyW2v+8aIwafXGfdq256R1YcWW0TMiqwUV8BlM8p1DIiUuG0FwsJNHm3x46XUm1GmR5SPcAt9tkDli4dys1MpsxrC2wChMCNZijKaaLiNKVIRavMuS0cDvUbkSwP9UTMjrJOnYC9HCUeaqPTx2SrnRZTCRY8yE0VHJT/V5TPbI6kGgU+N2/IpC2FK7fsoB+uNW3y9PplGKSPnmPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhDtfvRDJLQQEx6FBz1tV1+D+StUUIbatEyD1ujWtxY=;
 b=IdODSCibVLur5Af4PjhPcIMbduuF0fNYR1PdGtsYZkt1yuqo76mpB9xF/ymHjXkx8Uv+4PUwKRqA/xG5l9Fhy6xXG7x6qkc2s2NuRUtbNFyRGke2Na3Z7Kwq0qjuS8OC/xX8m9rHTIEhguNpeN4boai6wr0VbcQeJ2kwopdSxR9cRIT4wMRzHIIi049Gvmk8t3XOEAusAF1lwPsrlTYL4Efwu3M2HDAQjq9US9vqPXVPEpLhq0ijY4o9DTJJb1JYbqGc101LaGccjhNwa+1bozIwNn5x+EtjqP3mMEVlXQ6RGZP8RnQ0rFFEgIawWdLNlusewnehmOnQkvWX+b4JXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhDtfvRDJLQQEx6FBz1tV1+D+StUUIbatEyD1ujWtxY=;
 b=HSogceWpmMNWAEbbfevIrDMqNjFd5m/IMAGvj0K1Ac/lex8S8wpKsyUHFfh08c5nqCKvbjAHyTYMokEoHKToH5DDBhxms/VDslkH+CUszg9ILS8LalNBk5jULQLmcEHzgK7I2MVdPNI3KRBblhTck1IoIrdqlGKevi1d7lfnbeg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] i3c: master: svc return actual transfer data len
Date:   Wed, 18 Oct 2023 16:59:28 -0400
Message-Id: <20231018205929.3435110-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018205929.3435110-1-Frank.Li@nxp.com>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: ae579055-1f4f-4ac6-2e11-08dbd01d2fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fA9xrhPnbvTfVARSNAGeqbt0obl8qBTlbf2nrK3zRsU6NceKveTifqJ/qqXw9jMGoh/SajPvPp1wMAkOAT+7WO8IXwsZhEBJAjAS4z8mtM7daA3eX8lA8wUd/kT6Y4tODYiKnGJOUbPKVdiFstuf36x6b2o2bBde1ptn1714FrvLD2LihCUJETfr2SEuhe5JGwTFGiIOntq80HRPaQpjmbFlOLXKEVREtU5QQIrNKqFCEJp+caPA4hbPxyrdiFuBjnstgRXM8RH79WNTLB/oxTHS/rmHwYZFQEox0dMexEwnRYh7CZ+d6DEt8LlZzwtUTeNn3L4TyoJ9m8oH7Ex8Hx6v/BsUEXJxOT23ukCjI36UnPbri7dR6BfSJQaZo+y9OzveN76/x9392gP9sh+iS4woy+oZG7OoetQVcfX+E2xJRS9XKueqmLpVU/DFoDiEae2SuhDeSQxRo47oaVuRJdhpBQfEqTBFH8x0veSQG1yG+6uh5RTIFzLhMabJM7/9duM7TmxAXJlqdOXyKl24KGYNhQQTjRu2W6gjxfkoMz9YLj6tyrh31NkKhyZSlVaccA163UTrURwAAgVGljkclyVhdJyaKcmfqoVnI7smCmQ6o3MJpUFs/AmdFexOOxM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmTj7euQlg8AZ4rOVj+Xa1qf9JkOR0fbkfHU4dus6Ipc2Oxde0inDj3oS1cv?=
 =?us-ascii?Q?cwYdxUiPVaD+JwRKNBsA+mVYwW1Wz1BiBFHC0KXOvCjoqRW5OcMuEkAhD15b?=
 =?us-ascii?Q?WKGbvs8zM1ih0sFD0XcPnnKWDwMqifogKg5tkhJaNFqEBYhFzRScymiCBlZV?=
 =?us-ascii?Q?F/GgX+ExkCjaAUK8FEwBtnoDQfbwTe1ql7ai8Q/qBBuZThmvvtUCpxtsACNs?=
 =?us-ascii?Q?aUzgzfb+tWGCxAfAHLDvtdl8IwY5at9eXlxwpit0E/IlTuRPoKJWR9hVj7/Z?=
 =?us-ascii?Q?7KMou8XevEIiihndOwIMVonq1WpJpDy/+SbYizXG8m0Jbavq0H/74Xq4GDK5?=
 =?us-ascii?Q?ZwY5Tuf2CphCfF/zu+hT8Sb6MPq8K3reMgy/aFpviEf8+LBDe5I17L7uYRdt?=
 =?us-ascii?Q?v1BKo0XYmAvmlHjYk9xyy2laiIDpEYehRJ6mtXVaoLvXbZjROQlEd1HEpZMg?=
 =?us-ascii?Q?r7rHJ17N9PzjFhtmF35StnNOI3P4AyMMPas+5x3Ka5xNceK7U/rd94rvB6cS?=
 =?us-ascii?Q?JCoXb4Fp1sZfyJzt7T4YIiUNftB3z68qCbA7S1o3pNfSUWRFixzUEXLpFFKG?=
 =?us-ascii?Q?8YTS2Vx0G9vG/LU6YDDpY9JKQ+vjUpb/LW05IKg9Sj3ouW6Hlt4IN3yChdYs?=
 =?us-ascii?Q?y8b+ycea5wa3Oadr/X7hKDkD6emTT5HtTm+aKk1KpCHV+QOkfATtF/n//pNF?=
 =?us-ascii?Q?b+Ay+dZy5atX6YMEsK0fQyYsld5+HnQvBkgTL6cee2+xKESqZKCibUk3iTEm?=
 =?us-ascii?Q?EYYwZRZ9kfcrf7Mo4JEbIys5oFiNkorIqr7F62AF+5xYvdso0Z2oY8G7l8D2?=
 =?us-ascii?Q?iw+7dnjUOZNqqfNdhzUIIoSbA5hDJ4qj4Tu0Q6XBTZ9Noyp0iy77Cb+pbssF?=
 =?us-ascii?Q?7axN4TqvSPZ6QU3yBsC4ar5Khw95XtDjaZV/Hkc74eqPec95SIdICTNE6bpy?=
 =?us-ascii?Q?OxuTJFLgkkBdu6XVQs6sWp7x2n96AG+9yIU7BDXcNRYN4jW0Czz8hQctIsqH?=
 =?us-ascii?Q?KifHaSvm1gqOdr0yAKMFhV0QQX5y3CxBMVBxNBFiBy0ay8uRZYso+Vk9nFvQ?=
 =?us-ascii?Q?4oEtj4gfvwFX51PyoNAYbDETIMnLF0RfhSAdRn4QgkDPdUzSaZgusoGrWsgt?=
 =?us-ascii?Q?jWEAtwaZPphpdc1/613OeyQgiyVog+92btmG7DVCjcWwyIeX4LI5ADDr8Sb3?=
 =?us-ascii?Q?oQyAWa6UPfevP6tdpsErZVBOxaZHvuCMC8N/YWRquW9xla3oi9+g92SgKtsL?=
 =?us-ascii?Q?1UtU9X0RCrjXuKWobfS0pnwGL2n8x3Be0oSVkffZzwhK4B6zaFCUvjcbt8sn?=
 =?us-ascii?Q?plY99KC1UnNXemIJJMjRpvCxQkM7sVQdxJ6JnlfrIhfHUZKf5kSHr4j2eAk/?=
 =?us-ascii?Q?9Gom3IXTIRd8CZscNM/dQ13/Y+bOT39z6PGP2P/00VRL0ZoZWyEArmJd1Dc6?=
 =?us-ascii?Q?JQorRzIDnApxQ9xKivJCv2WTCHxsyV36sjSPtHldR4fdLSjIXxaPKVnrjnHT?=
 =?us-ascii?Q?dhTy23vTK4djgFA8+m5aWaCRhTVK+J3O6mppbbHLPx8YEGt7S0Cds8ax/CQW?=
 =?us-ascii?Q?Z7evCt3IGDnhyZ1M/Bo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae579055-1f4f-4ac6-2e11-08dbd01d2fb3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:57.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +5i6NmL/tsXZAqTArh/CCKdvFcVR9InZZfh/jWoJm1nsWvcIV0heTen2OeUwj5yB/oO+2VFA3IY4DCYsXODYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8653
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C allow devices early terminate data transfer. So set "actual_len" to
indicate how much data get by i3c_priv_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 6cd4cab26141c..17e953a47b1bb 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -138,6 +138,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -1052,6 +1053,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1069,6 +1071,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1164,6 +1167,10 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
+		/* cmd->xfer is NULL if I2C or CCC transfer */
+		if (cmd->xfer)
+			cmd->xfer->actual_len = cmd->actual_len;
+
 		if (ret)
 			break;
 	}
@@ -1351,6 +1358,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

