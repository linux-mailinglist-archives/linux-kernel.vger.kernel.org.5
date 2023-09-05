Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFF79310A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbjIEVjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244367AbjIEVjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:39:12 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2081.outbound.protection.outlook.com [40.107.6.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C6133
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZLQ2oq8vUkBRQCXKbltWIOTXDjOZLiRi4eiTe1lC7kNfQtGUiQ3ub5SHA8kDtrvYyshVvnW+id+X3CPIooh5y9Ho4e2gM+CoIPpvMxUarspYTlEC859zuexLHfj46MdwxcF0NZoOIyasNzn/3hAIfauvGIUua7EJdhoyyDS6Z5zv0DRvvBAF7FSQaxmXtewkkx9pD7aFyfLblA4PDT1Ha1fy/4iSu6imhvHXfwMDSevK8CtDyyQ3gNW6NljdvKQ5x/sef/anGBkjzgUItG9uLnfZdb7Rw7DtI0T9ZFk9n1Ibs3gM38uhHPrhRT/NSjsfPaUhNRcv1b5dXQ26R+FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXqM//NQ+ysAHEKZp2WurCborK3eF6VEZ1fJI6P1LIA=;
 b=WOVlc8h4oJdMdcM9eL4piR3rSWvfeAU9qB90iiS1mXqtHMqCZT1tkOFIejsiOS0ctWS3cnovN++5jH1EhgOdV/h0y4GMp9pK+DF2TJNole8/vnsGUs5JDBNMdAGadl+hki3UsdWl9hwslairxqmH0fYLqXXiJgSmc0VI4KuVNFsEA2JCXCcpyyU56228Y1cBC2Jgm/IvcAlpnfDR9oMmIKZqes9lkAzUuLtNj9P9o2PM0ynzI88ILkk0k2Z371EFsLgg/B6bObg/Il8xviAORfpHrS2bAWJOVU7DYEM8qtP2UXcJ2H1EXjPydmjV5ZMWRTgjMSUDDSRNzqHrBAvWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXqM//NQ+ysAHEKZp2WurCborK3eF6VEZ1fJI6P1LIA=;
 b=IVeGLTMmrTyGnzwbiXXs5mIyYT7WJMIXFE3uJQJ2iRuN90+d+sfkl77C8sipPKyAKXUDlzfpztoBt2pMNzrsT1XpxlJPW28c5XXS1tdICNH4Fu4ScWzkP3q/yPSdTjcEWlC2G698lKCRneI8Mvk9lyMPvcfhSzqBqcV+i6dq0P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9256.eurprd04.prod.outlook.com (2603:10a6:102:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 5 Sep
 2023 21:39:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::aa90:117d:c1d0:346a%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:39:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/9] i3c: master: svc return actual transfer data len
Date:   Tue,  5 Sep 2023 17:38:36 -0400
Message-Id: <20230905213842.3035779-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905213842.3035779-1-Frank.Li@nxp.com>
References: <20230905213842.3035779-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa53bd6-43ab-43fb-60c1-08dbae588880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ias2/aIhxpzuTonShQajFzoQn2143LncfIpSJMaHkQ5hfSnfZ+w4bjcwJ+ixmss40lVL/hdegcL3cyy5iHSCTFt8t7mTnulu7WJxmAnT8tHxsDWvArJj3DRXe1mMNP68qFPhX3FGPwOAV+mSlpkkWwFuFDgJpdFgeX8HqywAZV/EX+YvOzPNJiCrj4HQgHr6eWMTd2GzAMVObEGfcMIaCydy/EIYflRO5P+W2xU99q0g7mKUZf/HCD8zcpWQdoVUH/UT2i7HV/sH8v9aeOeVabmgfFkXZSY2vgFv4Arf9t+Ihc6FjEeTu092p7qIR5cHP4vDaxMdHLTz0JI83SIs/R113AT4d3f2Wtwx1O/CXaFOmj2mcxzx4a6eTUbOAb2EhGdZ6COyCxvivzXwRD1fvsORXr7giMgWkGa68lcxuiZNTNB7/2X2sfo4xm56iqPzgBojmykMHyhLluaqWeK4dZQWl/3XGXU0Ay/D8/cnC3e/7zkAUC/hav54B8rA+PaNPcE5bISUTynoRNp2aC6Uwu4chIh9wC2/vUKAcnuZ24YiuF2jxqzX7vRhQZfIDlDVzEWZcm67v/6ulzIgIjuvWhl6o0KJxG2G+NuhUztEcKr02yJSNuQyCE3QlnYms7U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(186009)(1800799009)(451199024)(2906002)(83380400001)(6486002)(52116002)(6506007)(6916009)(316002)(66946007)(66556008)(66476007)(478600001)(26005)(6666004)(5660300002)(1076003)(41300700001)(8676002)(8936002)(6512007)(2616005)(4326008)(36756003)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1zc4jwhL+V9y6rpfU2jC1mq1GDKyobdHT5q58cc3UaBqHQlsJgO0i7f4y6s?=
 =?us-ascii?Q?oOBYmAGvlsFOCnEoL/6AXyAZfDslBY2Z/2ZwM7wLr+lbH2iu+YmW5Rcrhk3w?=
 =?us-ascii?Q?Wo25AVlbSAQp1aWm4Lx/u4uCg8aJQjQI95vfJ3I6vdZ8dKsEJCdzYeUzEAh9?=
 =?us-ascii?Q?exNsWNwwaMviojXTM10LcFAufroGBEvyZVyEcIVLT2t/MLV9FS6yUEYBkYpQ?=
 =?us-ascii?Q?fpXNa2/blaYXWkij8NSj6doU0p4yi2Ryq1AlWjOebDIu/EgYLqV3Ilpt2xZ3?=
 =?us-ascii?Q?22ZjXYuLGCKaexEAHHmiB1lHti1u9jMfyqeVrZOY7i60tDCXlVl4+LKctMGd?=
 =?us-ascii?Q?/+XyvUniSG0w5KntMsWE/5oxh63KA9qZEsUlQjdmGZNtYo/HyXI51BRelUia?=
 =?us-ascii?Q?SxmvEQGIuWf+t/BFrdDmcWJ5nKSZwf5zDRbaHlIYsCyKQRib0MPoaIzfzKcC?=
 =?us-ascii?Q?OSdJy8AwsnONhKKI/FbtwH8uCrceF5HXXpnHbPg+xcjvKhiPluYLgc4U4PAN?=
 =?us-ascii?Q?o25JaIGR39iFdfxvAElUcDlyzp2bAKKdVI3iDxHADOjpVFChanCecNJ5OtiX?=
 =?us-ascii?Q?sNxhKwtMkD7sDz7z5GChBsQeE2K0Z3TQlX/il4AiGR5G7D0MgrucBzckFBVA?=
 =?us-ascii?Q?6h3ALnfJhSUBr2FeMBz7SLOZXfCEPX8CmiXLnOuiWjJ9M5wMLA5Ebl+oEbjA?=
 =?us-ascii?Q?OWg6TX1daOxH3YLiNKpkUYRGxA89KaQwFWRMba5KwxmM2RY2WbAhS5e9rH7o?=
 =?us-ascii?Q?ahl+m4z0VJJYHKu5YNohsDYy6WnGfLNneZDHwzzrw31SCgEJK31IC7oKFtJH?=
 =?us-ascii?Q?d2CW2o0uBNSh7Ex1mHLdo00+D0XvEc9JWIHeA826pgAZe4K7CLRDz/p5fVkY?=
 =?us-ascii?Q?LEAIJN2yuKihe6UFGFy+Cr0peWDas1qpi0U7VYNCrXeeM8GfsqzMHIytJbWJ?=
 =?us-ascii?Q?LYkd7CjUrbiahI2DjJMkY59MFO1pjV7G4onvgs6RkylU3mDAfL0lCDE33TJD?=
 =?us-ascii?Q?SEL68TwgSVopjbvgMzd7UPDF0nLiu4q43YZzy8k4BN1bxAMWQiaN7hYGO2Ej?=
 =?us-ascii?Q?5XyS+miMYL21zdC/QUM05db2AwceLkhi23vF0kTQhPVAUGlBOvICqzUAVEqV?=
 =?us-ascii?Q?uv8ozViAUEAV2GO/2BEO5VeGkdefiDNvl+o+eYwPpJjcOC8Zxf3ih6xn1vPg?=
 =?us-ascii?Q?fPlUiUNwBBh29S1ew7aZxbG4/XEjO/VG8JeRX1Urb+Q4RqeMZGbSylQD/5b6?=
 =?us-ascii?Q?bGgNFHgDPNADFZfUDrzw3oFb1sF0lH1m4yfW62D+YY/5rxTZY4Om3xdGCKxR?=
 =?us-ascii?Q?BxTuUU1XaOSPcNq22J5G/AB9x85DQ6PXjFckvnWKIq6bQ+UJDzfQn4CDNv3/?=
 =?us-ascii?Q?bqqakrOwUAJOEhwZg6Ri/JZwL4VpvT8GD7mt6uqRaqEtEVy6wGH41b+rzP3W?=
 =?us-ascii?Q?+x23uxuyN7DuXg+db2wzzRB9m9fyJPlReMIYZxlGLemO/aOY9NE+EhA0zFZz?=
 =?us-ascii?Q?RdTco9dkhPVL0yVo5gkD4sUT/K8hxsWJkW2b1CHm/tbFoZnmJ91zZbsJlqbn?=
 =?us-ascii?Q?mY+jZNllmbCq6EM1aywjIBf4YBL62tiC8rNzRNqJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa53bd6-43ab-43fb-60c1-08dbae588880
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:39:07.5037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PqIXrNlmQNqm+rDN+p9IPJdPeXLZF9jZhlVnU3tfdYvvdVq2VuVnbXVuVZmfurTUKVBzcptVKcQAXy9aUMswQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C allow devices early terminate data transfer. So set "actual" to
indicate how much data get by i3c_priv_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 14185ee7dd19b..74c4ce8789daf 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -134,6 +134,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -972,12 +973,14 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
 }
 
 static int svc_i3c_master_write(struct svc_i3c_master *master,
-				const u8 *out, unsigned int len)
+				const u8 *out, unsigned int len, unsigned int *actual)
 {
-	int offset = 0, ret;
+	int ret;
 	u32 mdctrl;
 
-	while (offset < len) {
+	*actual = 0;
+
+	while (*actual < len) {
 		ret = readl_poll_timeout(master->regs + SVC_I3C_MDATACTRL,
 					 mdctrl,
 					 !(mdctrl & SVC_I3C_MDATACTRL_TXFULL),
@@ -989,10 +992,10 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 		 * The last byte to be sent over the bus must either have the
 		 * "end" bit set or be written in MWDATABE.
 		 */
-		if (likely(offset < (len - 1)))
-			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
+		if (likely(*actual < (len - 1)))
+			writel(out[(*actual)++], master->regs + SVC_I3C_MWDATAB);
 		else
-			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
+			writel(out[(*actual)++], master->regs + SVC_I3C_MWDATABE);
 	}
 
 	return 0;
@@ -1027,7 +1030,8 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	if (rnw)
 		ret = svc_i3c_master_read(master, in, xfer_len);
 	else
-		ret = svc_i3c_master_write(master, out, xfer_len);
+		ret = svc_i3c_master_write(master, out, xfer_len, actual_len);
+
 	if (ret < 0)
 		goto emit_stop;
 
@@ -1047,6 +1051,10 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		/* Wait idle if stop is sent. */
 		readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				   SVC_I3C_MSTATUS_STATE_IDLE(reg), 0, 1000);
+
+		if (!rnw)
+			*actual_len -= SVC_I3C_MDATACTRL_RXCOUNT(
+							readl(master->regs + SVC_I3C_MDATACTRL));
 	}
 
 	return 0;
@@ -1116,6 +1124,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
+		if (cmd->xfer)
+			cmd->xfer->actual = cmd->actual_len;
+
 		if (ret)
 			break;
 	}
@@ -1299,6 +1310,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = xfers + i;
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

