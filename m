Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E87CE9CF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjJRVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbjJRVMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:12:17 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2683240
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRghT4s+LZpzKBlc4IHOaUJXiyFY0dpbr2ZcUvzy1SVZlZ+AU7hq5BHoftPQbSzpdOutZ5zo3VDLODoNlL1pjc8+0GA4Z+Fxx4pUnKMaNzrhGkMbpOKM3cybe/3fH2SADeFNLmnS4uSdKWgHymDnk5dJVOV3eTNlGCgKFL9bzS/t162MGh6folX7lWSjQYV70VjCGop/aHW9MeNQZS45Ak53n9tYKbSfiPjL9Ndo3gqsX+ynm5xINXWbxDZXjEZB57FApl5IcPGuswE7KOqhcmohtYKha8uO+ZsJoNnYdnDI1Duka1EPRBxnLWjWliTamIQIHN8iqisM0hAaPAAWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6Cl60dnoPjAUbmXonCKZDXgPOEMJKNC0aDD2ikB6i0=;
 b=IUlXNjWAsOlHlblCN104+/aUdDnVUmzQbxmt1H+vHoWUnUPvf54wr86qzinnVOwAQ/JZLPEyth+JAptpp+xdJhm+VT+qsdcDstHJXQ1k1x8FMvjD/3U1psb077cwswWBWy7L9x6QWqFyAUUT6u+10Nu83Z7dE8ApasvIYnEkePGRRmILtKjlSrMsDjTA17pKy1vJDO6LblFRWSabx4/4eNwTepBv50qasvw0CVAJaTF1xRfyXvZP8/Eduj4CmV0wxY4mxCznNRg/AwHFv/F9+V7WazvvoJCK9YLabca8MGVgwJaaWYgCKqdUTjv41CFxrN6mgSJ5gkViy3oDWDyhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6Cl60dnoPjAUbmXonCKZDXgPOEMJKNC0aDD2ikB6i0=;
 b=ICX8KwTnYMtYPyggFhqvUAU/kahDnrwOIbVARL6WlTPhuwrzDze8suftIExPXclPZIbAwDFsE0obl9cHaESo+RS2l5Pnzk4bthdaeV7Lc3moaEJFiUn2vBV5uGLomp0vcOlGZmjCjRC73svryIL3IgWkg8EuQtpA1X99R/uGsyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8653.eurprd04.prod.outlook.com (2603:10a6:102:21c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 20:59:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:59:55 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] i3c: svc: rename read_len as actual_len
Date:   Wed, 18 Oct 2023 16:59:27 -0400
Message-Id: <20231018205929.3435110-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91104df0-f2e1-49ed-0451-08dbd01d2e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05+ovSc22uh0dv5Dk8/VPv9/zY7TEN/sQ0r4EyOTEdR0KyEyVi/MhoN+SRvYJxQEbwpYS5cERIc3Jl31W/yS8FlxSiELOz+GdQ+VaFjdEljuGE1FFraAtjmnpi90c5tIWKRDj+E94IUNQ63bJt/K+8mTdKlzsAlmeueBWhsEoWaq95uWwvIe0jySaod23jpOf+SXfeovxR4sv3O+VZ4WvNtKn6Zg1wSbb+358ElifC+c5j8JyA13f4OdbDdA+vPYYQPm5k4mdTLWWORFDxd8Foma2EvhlCgxTopb8aOWjtAhYsKXFqUOtt1EqojyObWFdDRFx254Va3rwOpiCGFIy1QQeykTAErRjIEaHUsnsSGZ3S1o0XJvw7DJUvya4yyksknIOpmfDA0TxBxkinGicOZ35j0tXbG4q3C2URSjNJKnSJz/pqyaFtnUHqa7JwqIcAM0mFov7uGG2T3hS7U0zoJm5ArkUUcYYY88loXQb5nTzW6vkfdC9Qnr15SKU+u3OcZ8qrRRxkRZ65h1oyF5rO3Sn9lN8UAiqSicpP9p1t5KahkKfwyMDviZb6dDQeYGXR+YVZu3nevy1+Rkb+pzsgtiRc3BskoaG0AIwqwVQ7khQdfa4Z6UkBCEwkbC8egO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(6666004)(6506007)(52116002)(2906002)(4326008)(41300700001)(478600001)(38350700005)(6486002)(1076003)(26005)(83380400001)(2616005)(36756003)(66476007)(66946007)(6916009)(316002)(66556008)(86362001)(8936002)(8676002)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/XaQ5kBo214J62ywOYeK3Z9XaqiMbXmyCdwmlSB6i54gRkrUWFZBg6QspaxV?=
 =?us-ascii?Q?g8ABKFr7HSD53Ct3Ge7nXoIBRQo3oo6LrinFWROoAw8XWrpM8OJh3+5SYFXA?=
 =?us-ascii?Q?ioI52SfFzNNJRNauLuhksmLImbS7vGhUTm64JYOuimBW7OXnvY9ydmR5b5e/?=
 =?us-ascii?Q?qb0Sjnl0eOdCwEN1XA9D3X33HYUw0ryNHOANqDitsSXAh3cDxZvraAVlmKBK?=
 =?us-ascii?Q?Mfx4bvJiNwH7eObHBpV977AEeQLIVmY3Z0cAra8x6jei5yTcIRj2JM/q771r?=
 =?us-ascii?Q?O+blQBSSgIk31yDNvC3ipOJTMtV+Ze+R+yvLVWLfuVcIZb7hbdHF8IYL6ZEk?=
 =?us-ascii?Q?IVSKouS49SzQOKFbOVbRxdHQpFsJs+YZXhOQPZwIOf4+M6gYQoA1nKjXHUix?=
 =?us-ascii?Q?cOr62ewOY2JJk0snHfxJdCwQtGqqfdQpZJlIDi/TLpDTMsZrvBLO9YO7uO1Q?=
 =?us-ascii?Q?jH+a6DDD065tS3btEFubDjeZoW73p1sUFPsN8rWPYAu2yiOhDrOtov0R1cAp?=
 =?us-ascii?Q?tdgCPJhuUeK8mxLBzw5xTf65P/BdbGQc2/EF/9AtrNXwD3ZE9UznMcMpLzrO?=
 =?us-ascii?Q?nEaGwYmbA4l/5Znw3ZSZrAGp3DhCbEzdJGftJqG9cIHvU6mSEvemhR/inR+Q?=
 =?us-ascii?Q?qTQXgLyfp+3Dbj8decRtd2OHe3gTGzKPB8Mv36nKOwTv8sddr7GkJNDugJtP?=
 =?us-ascii?Q?oDIz/oUj3KnF+p5bvVfBudpGaNWVXq7tYcwqgNAG2a9uf5lNT18SvbLHLifd?=
 =?us-ascii?Q?rIQIw4e7GCZEDYnSDk6TwJOHwK/OkqtPsw2Kgngo+9geys4C8nP039V3VQrE?=
 =?us-ascii?Q?6UatQxlyIxSl2Rl9fXhRMEnAqovhb8gBBrtd92yDasa4dFoASENvIu9qMhgc?=
 =?us-ascii?Q?1I9W9kUpnpV6YpWbqSXicdh+dURdpsUWMy91PPMAWAp7IwJ+qgEO8BtzYQcz?=
 =?us-ascii?Q?VYZ8Jt8TxT051aFpU2ld7S/8WBn4Ogy/1vW1i/pvw2m8sPpYq8jwSfIrcIAh?=
 =?us-ascii?Q?mZlCSr2noyjwYJG1p/c7wtl16yJ8/rUcsn3DUKJeGUNNxk2G4bOgFCgq9JqJ?=
 =?us-ascii?Q?/0QxnrJKv18WBmUITwAw7iHFXT7+cPXsV63esa9+CwVfYnyKyvOEP9164X27?=
 =?us-ascii?Q?BaredUJ1inkzTV3Db24Nd48Hqvbbu/y7HVwVVDYKoGTKJrGENs6WTzN/G/pz?=
 =?us-ascii?Q?0YtxkRNNYBVUoaaDxWFdBk64OZWbCqIDseb6H/jgNuB+JyPKdsC9+nsQOo5x?=
 =?us-ascii?Q?KcZwreUwZBDWdmVxuzlkl3c1azTLsAxY81QbK/xaeKku9xNLk7geAq64h/pp?=
 =?us-ascii?Q?rV7qusR2DWqC16tcorUD9smXVjZAQhzJVfGQxfQfO4dyrNgI+6d2D+wo/c5G?=
 =?us-ascii?Q?qbFJamy/MjGwkC3fTwBEjR6xvPODZIkacPCSxuszsx2PHhDhxjOE+Fa/QTGZ?=
 =?us-ascii?Q?ssuOxKAjnL6GT+4/fYqSz6QiIXqkhfcljaMBJegixDeknQNQK/w17epcUOCl?=
 =?us-ascii?Q?qWyjZBpQSsT5528l1WQE1MWUdtHn4j31hvpyAT9R4Rd153YW/k3PDp5YRWUp?=
 =?us-ascii?Q?lc8jtm7SKDT78PnnqkM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91104df0-f2e1-49ed-0451-08dbd01d2e44
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:59:55.3498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aM0h3Gcphr1j3jPfVWwGDNrQBb1OhvRXiRWmbByPuY4CJeMw2BrrBCvE7+pgEucjhaR6QvJcSmC4XwBlSDgRQ==
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

I3C transfer (SDR), target can early terminate read transfer.
I3C transfer (HDR), target can end write transfer.
I2C transfer, target can NACK write transfer.

'actual_len' is better name than 'read_len'.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d8467607602af..6cd4cab26141c 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -137,7 +137,7 @@ struct svc_i3c_cmd {
 	u8 *in;
 	const void *out;
 	unsigned int len;
-	unsigned int read_len;
+	unsigned int actual_len;
 	bool continued;
 };
 
@@ -1029,7 +1029,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int *read_len, bool continued)
+			       unsigned int *actual_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -1042,7 +1042,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*read_len),
+	       SVC_I3C_MCTRL_RDTERM(*actual_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1080,7 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 
 	if (rnw)
-		*read_len = ret;
+		*actual_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
@@ -1162,7 +1162,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, &cmd->read_len,
+					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1248,7 +1248,7 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = buf;
 	cmd->len = xfer_len;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1268,7 +1268,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 					      struct i3c_ccc_cmd *ccc)
 {
 	unsigned int xfer_len = ccc->dests[0].payload.len;
-	unsigned int read_len = ccc->rnw ? xfer_len : 0;
+	unsigned int actual_len = ccc->rnw ? xfer_len : 0;
 	struct svc_i3c_xfer *xfer;
 	struct svc_i3c_cmd *cmd;
 	int ret;
@@ -1286,7 +1286,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = &ccc->id;
 	cmd->len = 1;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = true;
 
 	/* Directed message */
@@ -1296,7 +1296,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = ccc->rnw ? ccc->dests[0].payload.data : NULL;
 	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data,
 	cmd->len = xfer_len;
-	cmd->read_len = read_len;
+	cmd->actual_len = actual_len;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1305,8 +1305,8 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 		svc_i3c_master_dequeue_xfer(master, xfer);
 	mutex_unlock(&master->lock);
 
-	if (cmd->read_len != xfer_len)
-		ccc->dests[0].payload.len = cmd->read_len;
+	if (cmd->actual_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->actual_len;
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1356,7 +1356,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
 		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->read_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 
@@ -1396,7 +1396,7 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->in = cmd->rnw ? xfers[i].buf : NULL;
 		cmd->out = cmd->rnw ? NULL : xfers[i].buf;
 		cmd->len = xfers[i].len;
-		cmd->read_len = cmd->rnw ? xfers[i].len : 0;
+		cmd->actual_len = cmd->rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1 < nxfers);
 	}
 
-- 
2.34.1

