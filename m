Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7F680164C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441861AbjLAW0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441848AbjLAW0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:26:03 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0146D10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:26:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSWHchDzwVSO6I+2RcooBdWwGwhwblMKBQl11kupf48CmiaOxtCfYjQyLRQV94mcGuD3GOGUIn+TUIRjngJyZEv9+FNZ6ElY+7gCYcS7TDFVD1z+RRdxPxwv6A2DKAHy4yUUxhH5jlaqnvXzMcvLlisx7BYpSRbLxjQfjjTTeZnU7vOi5nqk7Gw+2QwUEJ2tmYIjrwpfgCAzcB6pA/3R56O2HbAN+QbNRHv04hltCtUbnEZ99/MlHAAyui/2V+O53eznN5KxAyA2vzRY8rIm8j55ddmwecW6csEF65eoxirWc3s2xECqp6I+MXw1LUPtr69Gblgz0WTsFwzQUr2ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZK3nbhXsExbv0Znn3D5HF/BW5CgmYGvGvpxgFhIT0s=;
 b=j3M5CSYXH9+yVy35GhAATf2hepFfDTdfI4Qh+6dbQsblAxGwJMAVGn843scHkY2yZxVPyYC75q64AdLb/fex7PZw4/3NKFKJHCmQWAyQnaDXEJ6N9idZrI8R6hZGFT0KU+6sd/iq7Hkn3F6x+fSRN9/TvoC4t88y6T/l9gi7qdolvtQcl13muXE59i8XVF3CofSMsXn9TQhSNl7UZaqkrMtHpSoOFBv1jML3pjok4ni0APLiqvJDbfuhS/LxMnIPRYO7QR+6vz622OZX9nfcHCh85C6Mcw9AViwXyQw2WM8C0ZQp2wbhNfxigFMYwAz3RGbjmc1elN8U60YPaFOBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZK3nbhXsExbv0Znn3D5HF/BW5CgmYGvGvpxgFhIT0s=;
 b=M3fbhi1Uuar5MdcfOk4AeIpkb7dOadZ+1RexnoPFBXNJjY0eQd8N82s3tBGxEL2Odj3zG2Hs6fnvUxCj++vOFtCzA4hcjUxRPobXLQu3mdGnOfoWVeDjry+G/+4Og7ICgKmvgiL7cJ2yplrwkCJU8svNs+q4GIDkd6rkM4QBSxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9573.eurprd04.prod.outlook.com (2603:10a6:20b:4fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Fri, 1 Dec
 2023 22:26:08 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.016; Fri, 1 Dec 2023
 22:26:08 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zbigniew.lukwinski@linux.intel.com
Subject: [v5 resend 5/6] i3c: master: svc: return actual transfer data len
Date:   Fri,  1 Dec 2023 17:25:31 -0500
Message-Id: <20231201222532.2431484-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201222532.2431484-1-Frank.Li@nxp.com>
References: <20231201222532.2431484-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0022.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 366b7918-1f91-4312-e94a-08dbf2bc83bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jjMXqum+sE/hGrx8e3XaUUDC5r82rKoAK4Ney2fxyHM0yhinVOG0ixBJuUB1i5QcaI3cdH3YNER25mPM6KGwNBgEG92k8FEsCa0x8+InVnFJ+BfA5vsHMMBPb2Fik9875CJsO/Dj5KCHyy0TVjJ1WTrq2nTJHZ/0bcyeh92ughizlrlFCRh0k2iZwOLKGmmlI3r97N2KdEXJS4lidsVDMOflzvkioEUTmcUumxkVWWaVehjB365BusXe8YkWQrfvPN6neI77+NkOd0uUFbkFdm+2F1/rWZdjZW8Lg69TU97BUw9qiuEBap7Zlu3mSgdy6pfNc29I5sNMV1M2JKP5xQsrWo+llHo/B4vl7ACB9I2e9BhhdmWBV0l7jsQVHNd+3w7YDZfRLQeprV+Id4PWUD5qLan5YzAPQsgJjttirSlxM2yGsLhq6NXLl1ZcIWHz+MKUz+qO48MgKE0RxDO+rLYgYVSC6EU2/0drw28d/rCnJ0HGYBoMBDqCSYH0YYgxrujQU/FyHzxWIcGaMLzh2DqlfucdNrRSemfcEGHJ99OCZgR2QwqESBYOwX6HcYEc8Jgk06FfGuBMd0dxZnOHojf2w5CUEy6VqvY8Os7GWoIa0+WHo+cHfIeFswdb26f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(86362001)(6506007)(26005)(1076003)(6666004)(52116002)(2616005)(6512007)(41300700001)(5660300002)(8936002)(8676002)(6486002)(478600001)(2906002)(4326008)(316002)(66556008)(6916009)(66476007)(36756003)(38100700002)(66946007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6J+m3IeuWmiOylioAIIPL0x+9yFnigaqYLlOvn9Ft3gZUUnxcU18cpfUW5m6?=
 =?us-ascii?Q?dz7sgHSo0Q4GmLztUdgLQfep5pGpzKe2wFVUkaqHlN7NWxWs12j7uAscWEr6?=
 =?us-ascii?Q?Idc9sNdIZ0h7AdXuzFOrJvWfqaI+4+RrYFImDyXQXCsHOL+NyQWAit1hU694?=
 =?us-ascii?Q?0D7vzBWIVw9EV4LVOgAFG5NllDF1vn1P82pr2QF1hAZiqNWgWbHvaQqdm75o?=
 =?us-ascii?Q?LT1ItqlogpwZeYPKjcCFZt5g2lEB1Q0fe6YtxL3bcaQID0sRcjNf2NgB8FNg?=
 =?us-ascii?Q?+++UCbYHye8IF8doZ/jVt6e8PNHbvuM3Llhhxr7zBgWF8B6x1X0xsH9wJAV4?=
 =?us-ascii?Q?Il/Ca4+SqdIPa2ebOGf8wg1dT5trAV6ThtPP0WkuWO+DYXKSuLmGkqHJsUyQ?=
 =?us-ascii?Q?VNgWq+Ox7GDH/p8ie2lwiVfmKX6awP2juQYnzCyyk0Q4d13uVIdd8anulOUh?=
 =?us-ascii?Q?kUf8Tmy0NKnxk/LKkrrPindCQcUnpxaGmLv7QobeQJXsDspyLUUJaejm45Qm?=
 =?us-ascii?Q?bghEcFZ6pFLwn4HI4sCB/6snViOR1iVyQpOdR2pf/XgMvc45XniUcbperBBz?=
 =?us-ascii?Q?a9Vou8MNEJ94BbmZ6tLUFawwSKMAOWsIMTvIkKbxUsaT5VD8sfhvw7cKosWS?=
 =?us-ascii?Q?Jqd9YFRRD4tamzMp8UTDtAdJ2uv8twvGAEfnETgo++ntGFFQx0uzLR1v2yVV?=
 =?us-ascii?Q?kzvOIUzSnhgqA9+2A04vx8BSkpCtk8GJxTN92INYAhumlpJkVeIBlewx1968?=
 =?us-ascii?Q?O1rI+fGFxmc6En+TBvxx/f9m5mz0YbKdOyghNhqkhadJZzx1VRbd+aTa2QfF?=
 =?us-ascii?Q?QVOG5f5ZV6OBGRqkG2QDiOVn4he96s+MYeADjpawbJWv2I5WzbWLClpHr+Hw?=
 =?us-ascii?Q?N6A+NbxuVUb9c+LPiNADxzjj2r8Zj6SIgrGXuWPw0Xxq4uF1UDsmjeg+d7n9?=
 =?us-ascii?Q?MuRG1e+0tW2ntqJvKEqbbgz70jS496uT/2Kh906MjDl4c4tQu+OpG5iulzPu?=
 =?us-ascii?Q?jbNKdZIKQSbCwSNBNSrOcI1ADoXkMYZxPFEs7RMt5Zo6nIahiI03J+KIX2E4?=
 =?us-ascii?Q?vX/9tH9WbKOigcCAzWauvApz9T2vK7rnbT2HaFfq/8ly6B18G56+7U+oFAOR?=
 =?us-ascii?Q?JdvSHrV1/pVjwTuavwWaluwvQ6HCoZ/F1ClM/b/z1S8+mX97CgIB+ptWURW1?=
 =?us-ascii?Q?mYvCvxIlmbWNN0N7r07SWuZOCeBaiRgA1T3E20v4bxnqio6vN6ZK+r1Ss5KH?=
 =?us-ascii?Q?hsjUjW/dkQlDMuuyJxqM7RXSD0txNCf7d4kcLEH/ZammhQujz05VhNJSBHFT?=
 =?us-ascii?Q?lGZPE2nynauo01jO8QhGCpM7Rcbf+Ib88PMoeGCBgAv24LoCGbsiO1pdAUZn?=
 =?us-ascii?Q?hdK8vtruuMWeXrThbxYIAtzrEohz2Na0SpWUQZxXYqqv2o3r+yhvq9PvgrCn?=
 =?us-ascii?Q?Dh1MlJGTx9uuUOX9oVm0C+7yp9JRn1M+Wf8NZppYw5/hD353WLrKEk6I+OSH?=
 =?us-ascii?Q?TXrlOxHb8dZ9ucECjuEfcZkm0xQ5PCNiZEjX8feXGlfcV1cXntCB7ZriqVil?=
 =?us-ascii?Q?nSQR870F11NhHpuiafiQggmTblFiDKSeDaqbW7kg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366b7918-1f91-4312-e94a-08dbf2bc83bb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 22:26:08.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dVlk5+EshCdBsMS2KGVvvvbqI0syIe7AGdj0IJ66CeXtFIiW/KN658rZdefg82As4ozqZawA7lLqznwDsMaDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9573
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C allow devices early terminate data transfer. So set "actual_len" to
indicate how much data get by i3c_priv_xfer.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v4 to v5
    update prefix
    add Miquel's review tag

 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 13a8b3c2aa541..bd10bb698da0f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -138,6 +138,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -1061,6 +1062,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1078,6 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1173,6 +1176,10 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
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
@@ -1360,6 +1367,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

