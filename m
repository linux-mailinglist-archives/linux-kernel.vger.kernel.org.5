Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE7FFEA7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 23:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377218AbjK3Wom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 17:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjK3Woj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 17:44:39 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2080.outbound.protection.outlook.com [40.107.20.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267921704;
        Thu, 30 Nov 2023 14:44:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dBSjOU8IfeGqRnRRPIfVLeYe/pBTWm7ip6qpB1g72F+DWELNjgc1dx+mbtcPL12fJ2A4YSb3CZ+zmF6l9XoFlCSAQyDS/b6KIm5pu7nIZY67c5Y8t+uwYcwqX95OWWNnfh+iAalpzHJ9QW7lhjhA4ULnYr5G6+KWidwxJgKVegrr1j7xlUjq1q15vV403nxAD1BLn7Ij6IqPaUaYOD57oaToHYFB2Am0HSwmODDTVghgsztm5zu5dhu4MKtyOHIJ/Xu32IgKbt4eWsYyIp6auWPzDqi2YrSizrOZN99BvETc+5LuzbmsQwEbMBFYrevIP6Z+U6K56u3XbNuiUknOTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXDAhNm+DCe1srAC+lBUWMnfd6Ayz3DSi20A50myyuQ=;
 b=n0x/ldLT+sd2GLxdN3cXpb1pFEd3A3OePkdrupFtBBkbpxsQn8SjX/9QiGhe7y/yD6RzjnWKgG6biY5pfrqdHdiEddHKyly3NSFZjy/drZGPI7fwPSCHS4pw1Ks1iIzv6SgxVSsmBeOqwRk6cTTHi4P5tvj8o08VoLP8QUhH1K1+vBMV4NpI/jhR98IG7l22Gx5kkC7FzXRZ4NHyh9ZgfkFfsJZjL45NnpIvSl/+8pbFGmqXtJre3VkEUi+1MOpHhX2Gr2rxE3fWMU/17eu0M39PiB6Kd0GbtxsIdbU4M6P07UvSukCMsrxKImGsurBWhZuXpd4ugXX5Yp3oOE7aZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXDAhNm+DCe1srAC+lBUWMnfd6Ayz3DSi20A50myyuQ=;
 b=bamEUMo3WldkGBMya2I61xEn5kJ9sFOKNq5lIz8EqHKg3pLAw8jkOUzi704YRPyzOlXzRxWSlXq/QgdYPGFMhoLXiw5SfTr4iz+ws9NUUH4+D0k2AtC3WE9McfaB6XdJgD0uiITtM841aelb6aYvWzSVgcWEp7cHVgVGcqLxxbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 22:44:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 22:44:40 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v5 4/7] i3c: master: svc: rename read_len as actual_len
Date:   Thu, 30 Nov 2023 17:44:05 -0500
Message-Id: <20231130224408.3591288-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130224408.3591288-1-Frank.Li@nxp.com>
References: <20231130224408.3591288-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0212.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 0641e87c-b724-49aa-8836-08dbf1f5f087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3IrbjDB+WX3leaGPijqF313mH1qiw6ooFkMauAGED+19dCqodMxCCyOcJ3Nuq7YWdymAFSL4LVyAhZlgKVgiK6AsJ6BHOjlqd7cpHgKhrnHl13emGp8EEU4rATT6DFAyOeUliUQK38LQoAkH6aTtGaG4dk33TSaBGxlwIdhOjk32cOp1NyeR3cFRjoy+MNo1n9GF6Owv+CgUYVLv5zAqGFFxHTTR+5Yi94BC5C4CTuIG/kFheNTmwdi74gOHkpUigxWRjFpc5lYq9F5+1obTqkUQJq+dhPRtda00OPEcdnZXnI9U38uYZewgiLY7mgPwMvNfONcDSFcirEb4IXlBcWAmNOG1tOaR/ZMd7TvtwG2/R5OkSMLQm4VvUHyrS4f5dObxOW4cThTjWkvcvl5KRjn22HG1zVNefXHEnSGdyHcQ99lBOTw1Pp2Skv9g0cXpM3wxB3457zl3Mg3ODzRUgMskyg6X+T/MXzYN+z9uI4bB5Iy09yajke81DidOFdhQPRxCjJqe37Mx2ajadJ7x/qb6YKb9ISXjXMyCpXwxh6EULIdvZCwM7k47NrF2Cre3c0NnmsF61x+HBUlzNM+y+I+SNdF0GUBqcCvDlKiHRbNYGX4Fshr0+Scgi/pMM4ZoB/exxO1UZJFCsgcoQUyx8oHbbZgX7wOOXdslUDxDb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(6512007)(5660300002)(36756003)(41300700001)(6506007)(38350700005)(8676002)(52116002)(478600001)(2906002)(6486002)(6666004)(26005)(83380400001)(7416002)(2616005)(1076003)(4326008)(8936002)(66946007)(6916009)(66476007)(66556008)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Mm2wkNJDtQP26COCpJb84QjErefWJUGPiYA20nFtkF64tyIarsoj074RwMkn?=
 =?us-ascii?Q?BM/OoMxhtth52ZHN6c9Xw0UHOgenRgsl+Jog/WoYVyjZC/GcwK3gc54ABE6Y?=
 =?us-ascii?Q?Vf39g57p/spxlJz7P+zD6UZCvvOo3x1JyB5GxTM70Mi0QzQNChuPyjn84j2w?=
 =?us-ascii?Q?vqL8u5B6S2+rnAcD9ja+ahrlDlK3asIEh6pE7IMYbaZejF7GMX4aJLXz8PCq?=
 =?us-ascii?Q?Jx+O4od/Ai0BuHcprNgBIGQIC/zqKgil8ytyIy1n/do+V8LLtowdZqM0MgSY?=
 =?us-ascii?Q?2euWb+nQQ5a1YazKQwIwzcatxVmEyvHM4JizKtEzKluezT7RvAAceKU1MD6F?=
 =?us-ascii?Q?9jghKNy4+IFfeXHZRiRDi9g5xIWjA4lzWuITdpuDEc911XU0kR8y9hrYohg0?=
 =?us-ascii?Q?XPaTZ0KaVKWeOe7KiUIxVFOVxmpHuuQJPyqx6joRiXJbB3qhTiwQBVzFvT/x?=
 =?us-ascii?Q?vYYqAYNBg9pKseO2MeCA9ApBxFA60QJSqGEgd5RTS3HNxn7swS/aBada4SEE?=
 =?us-ascii?Q?uAQaetnlZ9ZwLpHEo3FRZHFnRiIk/AbdHSLo2wx9M0NrOcNWtB0EppYllCYb?=
 =?us-ascii?Q?C2KS1hSc/JT7Jsk1H4yqRz9MjggKRP1iM8kVfykxu4Evai4thE8RWVxDoGwY?=
 =?us-ascii?Q?SMPGzDPTtpiss0ouylGbykiSK1DhI/jJy6qCVlK6aLwIO57dNJaGtkoXXqu+?=
 =?us-ascii?Q?zN5MzvraemJHIDlhp8KQ0jXv1Zghg2A21FXGaLRwSUV35UBPHz0pTkdsKbop?=
 =?us-ascii?Q?KEGn/6SNqS6WTr3o0Ay3a9UYYHpOLYo9PtlS8edWFhYjkyNpk0Js5r6QtxIG?=
 =?us-ascii?Q?pPrWvpv38qokEqAqN8PnRPKxR3LejQvFFgPNTh+9YLlEfBLDQDjwDsUCMydK?=
 =?us-ascii?Q?yYGjWfOSSkMnd9KhOJSBLsKFuu1PBWw6lRW9BU3MQG3OE3KbRTxPjFnGAJwK?=
 =?us-ascii?Q?nZBwyaR2Z5IrMyz2DNNJ5zJqTPJCgtJl4HXig0/A70FkaEf90b4DRti5Z34v?=
 =?us-ascii?Q?gajJkn7N5fopviHrclMJPyWdULavPN+iv3/nfPbKQw1Uj7thsQBoq7czDnaG?=
 =?us-ascii?Q?h+owOARhiI+bgRYzXXPNOTef7TZVZDBKF7KIVJUHjpxTnDBMj+k+uevEjCLS?=
 =?us-ascii?Q?LyHDg34no1lzbND4/4mNSd2wnw1BAOtrDNCZhwVlLJbKHxqr5FhqJT7K+nNC?=
 =?us-ascii?Q?j2WN5T8jY8ZzKaA2kwo12hD3H1NAZ/W9D/M8HkG6Ds6t08x5lA2F4ulc/bm3?=
 =?us-ascii?Q?PAeHwy4oBNJO9gkD3Vev1TXySDj3xyh6g++yq7I9fq2ZKgjIOuYnUqTl3Lpo?=
 =?us-ascii?Q?Eh/cpIMfcUf/93mpGPlydzFa1jxHJFXb6CVNMktI9z/xUv4q9rAhiyjz+IEc?=
 =?us-ascii?Q?3TISWYcSW0AEH8HyZF0g5O3y2H1PR47wT8YUXFH1yJDGE9inYK1JruqT/6kW?=
 =?us-ascii?Q?Fac7ebADQbryY8GtWsRIUxH5ay53FwlhNdtHjyshEvyvre2NATr3cljZ0Zzy?=
 =?us-ascii?Q?tO1R7u69asO7ORDmXMEXW3y0dkcoXnHnW1jV70/cZBfHjqnZPtiJAkdbZQ5m?=
 =?us-ascii?Q?Qxx/VxZtT/L1PzNm6Jt2LPnSW7MKzVnDZ3Ex5C59?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0641e87c-b724-49aa-8836-08dbf1f5f087
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 22:44:40.9229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2YtxpGgr2B4jjDO0JeOwgbqOPlzdYKoku3sD6Z2cb0zdT36Eskzq+yjmKwZxLnJoB3uzwX/Cr4zWLFAihNcwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Notes:
    change from v4 to v5:
    use i3c: master: svc: prefix

 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f2058a36f869b..13a8b3c2aa541 100644
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
 
@@ -1038,7 +1038,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int *read_len, bool continued)
+			       unsigned int *actual_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -1051,7 +1051,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*read_len),
+	       SVC_I3C_MCTRL_RDTERM(*actual_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1089,7 +1089,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 
 	if (rnw)
-		*read_len = ret;
+		*actual_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
@@ -1171,7 +1171,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, &cmd->read_len,
+					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1257,7 +1257,7 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = buf;
 	cmd->len = xfer_len;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1277,7 +1277,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 					      struct i3c_ccc_cmd *ccc)
 {
 	unsigned int xfer_len = ccc->dests[0].payload.len;
-	unsigned int read_len = ccc->rnw ? xfer_len : 0;
+	unsigned int actual_len = ccc->rnw ? xfer_len : 0;
 	struct svc_i3c_xfer *xfer;
 	struct svc_i3c_cmd *cmd;
 	int ret;
@@ -1295,7 +1295,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = &ccc->id;
 	cmd->len = 1;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = true;
 
 	/* Directed message */
@@ -1305,7 +1305,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = ccc->rnw ? ccc->dests[0].payload.data : NULL;
 	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data,
 	cmd->len = xfer_len;
-	cmd->read_len = read_len;
+	cmd->actual_len = actual_len;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1314,8 +1314,8 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 		svc_i3c_master_dequeue_xfer(master, xfer);
 	mutex_unlock(&master->lock);
 
-	if (cmd->read_len != xfer_len)
-		ccc->dests[0].payload.len = cmd->read_len;
+	if (cmd->actual_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->actual_len;
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1365,7 +1365,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
 		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->read_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 
@@ -1405,7 +1405,7 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->in = cmd->rnw ? xfers[i].buf : NULL;
 		cmd->out = cmd->rnw ? NULL : xfers[i].buf;
 		cmd->len = xfers[i].len;
-		cmd->read_len = cmd->rnw ? xfers[i].len : 0;
+		cmd->actual_len = cmd->rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1 < nxfers);
 	}
 
-- 
2.34.1

