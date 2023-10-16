Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEB97CAE07
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbjJPPrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233738AbjJPPrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:47:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C2F5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:47:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC63Vy8RV0HVKD9Y9X1Yyt11DQjTsNyAoj0VzoR+2DflTQOffgGlzhovZkfiigPJjVlhH0f1ZHNmWbVnqQ92f8sCSvHjDke9op9EJh11/olcq19hqljYHQ4O01bWnJ9L+w6RGQhaXB3L+mLm5AH4JABao6E+/f3Peht5zikMtcxVBShH4EK/IPb8JaGrXs9Hajg6qCHMDfuryd4PAX4bAyDCn6WtmwVyKvkrFY9jp3rQCWpp+shBihnNatLN3VUyCEZSsojmfbY9a+r3rXudjikK/TYaHR0EIT17TMe/v3WdGMCC+YwjrA8WjgdcZR2TOcH6u+ncw7ba3Su8OGLTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JvC4g+VD60esWxTBSv5RI8lGH6ctutNh7mqUTggFg4=;
 b=Q3cxx1j+5BWyV8Xxc34x5VZjQ5z7ykhEqk79pt3M/ekZOgW1SNk3rpHAfHyBzPrWqOrTV+HHdT6cSeEQn2/I9lFlGbqya23LkeGOLvDYBRxWoGU8eaJD9qWeOZuoZ0HJnfKLOSsI3cWflYBZRaWFJsEyrSBE/TI2/faK5d17QCKZgkKvtO7VuUy7UmahwVNB2qRH2w5DNZQLQrHdjQ2XIQ0Aa0DLem9LQ9JPT3pcSVx/+r6X/4PP26myzOI2wff4fVEMpEVejNZSzu2BZlTpTGrFZRQcEHvbcqvOMs4kT7HppKatViJ6DKfZyDAHAhrQlMoHcgmcy1UZApGdGxKRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JvC4g+VD60esWxTBSv5RI8lGH6ctutNh7mqUTggFg4=;
 b=LsDggOlDpdF0D5PC7RDi556E7dlhJCMvdMhLUOEpim4v7GobtHQW34vnHaA8eDjLZBj/VYBiKjStYxsTYlkeSsRZhF1lAxV/3ECexolwrePCw3xFfPZFzj4q2bgRFGk36t/gd5HfV9QK9Zy/zbQ2Ra8DodiNEx4LEBztsBBx2nI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 15:46:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:56 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 4/5] i3c: master: svc return actual transfer data len
Date:   Mon, 16 Oct 2023 11:46:31 -0400
Message-Id: <20231016154632.2851957-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016154632.2851957-1-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 161f0a0d-488c-4f24-6797-08dbce5f20a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZP4zi1TXB2RW3tc0UjLWEfyIfKkJGYn6XJgWeEq+B8tpUDrOcTqGTObIV+sxrggL1v1Tn5V2FwE0ketkYHN6flV1Pht0MWZq8uSNlmxl0lN/s/WiaJkX//WqHdDxuQmP5H/BJ8bOt1j4EeJjrlVf/hM/5PIg+qDupIqIgx6uXpBTjZbeNuw0TP5zKkxOhpHvpS74s3Byi0seNM04XTNY4Nb2Exj8Q7jGLSJ2zbDnTpQgOHMaTDtJ2Ok0nVvJuDJVNt3Z9XzvYtiMBgX1N4B0MdRZIJXTVkwC0Y0u+GFYVlQboP/6z9xQivqzr2Lii8HPPSh0ia/vT3Hm6SP5mNVqoz1CPFve43YHU9SdZIQCmQZKfoLshcEnh2UhYq15zIylX9YxsTqbiHw4+Ie+/XzqqQxp/LRenXmS1h2zeWSQRA37TJO0scN/5cIsO1Si1ZmOATwZsyE3IAkFSUSh/3eVnFjUYnofpL4nlGLNCjLrDgBa9u46vXBJlmDLqMuo9ZeFrJoyqC7Mn7pjThmHE5IPxi/j7ouUY8elJFoXRL75NLDwASd4KxcN5JeHuU3JLb7ne2hxs1Xu4PdLrRLycClhkBCRGz9D5duFtHIA5toIj8OwQOw0I1GKW0qI4L+3b94
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6512007)(6506007)(52116002)(5660300002)(8936002)(8676002)(38350700005)(478600001)(6486002)(1076003)(83380400001)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(41300700001)(86362001)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s55BwbT+di1ygJjsy++c9ZIyg1r/4g2JZ7mx7+jNLH/zoaNOzFDiYouvX6Ls?=
 =?us-ascii?Q?kWibhokFdEudYhG3xAz4VaP+7gD3s5H7DjLW0UHAFI9EvG9di5VunkHD0Yaj?=
 =?us-ascii?Q?lBTrrfCWXIhzoCaKL0Y9ASrkzsD+xZ/AVzZttxggqgKG+eRvdvqH2b1p+OxV?=
 =?us-ascii?Q?bFQk7ceMzKEzN7zCXrzdZdeIIdt2PzXRt91dQbh1up+hOtLHsJSPkG+0EbeJ?=
 =?us-ascii?Q?lGyWYfQTj1NmPJF9Tqxcuyl7kOStRGd86mtpy3Te2aTgpaF5nH03PnpYzK4e?=
 =?us-ascii?Q?LfGRy2g98YiQQ3IxNrVIL5EbFK2msV+kvKQbY0Ze7IdS0cHcGPlPaOdRkCNK?=
 =?us-ascii?Q?nvfFXhB1KpKRwEqnVURrayr4+yiGEI2WuYiCJVfpyc9baoKsc9kGCU4NbSCk?=
 =?us-ascii?Q?j2+2DfFiX6HemkcGJhr1C43uS6QvzjN+E2vT0fqS5+o/ivS8GJIuiIhvEcvH?=
 =?us-ascii?Q?mdmgsFdZDGD/X3vI73kkxxhobQQMQCbxhTh+4HwH1RguUef/M6vVeqJEvRQQ?=
 =?us-ascii?Q?7SSPWjRd7hKGCmlWC+hIRncg8UuKQpnxB3IJ5rTzDJZRFavBiOA/j8lv6wnT?=
 =?us-ascii?Q?QWSbgp0M4ISyjA6/J30rhQTdawGFtElGMUh2RlI0jzqetESWhwz6r1GWSJah?=
 =?us-ascii?Q?NRwphUxL6g+rYXyNRiQHC+vYvVbta8VnRi7AInUKmKuZLN02zEPJzJ540az4?=
 =?us-ascii?Q?Wazz04/FtT6KlSxxDfRuuezsUgVzZ/T4LPunWYeeVJi/S8BH4bt9tWJivwEG?=
 =?us-ascii?Q?qoFXIz5C6DQ7sYb3gdiJA4agpjU2rNOi8YKxapOyP4hiakTaDQrUhj258OFU?=
 =?us-ascii?Q?+zppjE4QhXrn+plHpqdZ38N1/krQh/X4IigIr7bGtOs23seWbIDoasVHh2es?=
 =?us-ascii?Q?TYa9AWc5Kf9q4U/tagVww+4iRkHgh679RnmKcDJg6hZhqhktn6d5/yi4xkA5?=
 =?us-ascii?Q?DtwU4yKK+ScwB44AUsQHKllfQKxSx7gthKtm01H4NKdT8LddgUus+2RuHzSG?=
 =?us-ascii?Q?8iLk0kSP1X946/zbBmE+gAdAKY5BH4tEjpEdYUKILDTZtErjgBGmIDG20i8V?=
 =?us-ascii?Q?5eSBwxZthKpyDnu6ci5OrqHLWILVCgAtVVGE7ySnKCsGn1XE7R/tFuJQbZBs?=
 =?us-ascii?Q?gfe554D7rgI0v6ifdxGEq8JmsEAKduhdL6tYFsBrxJXTJ00eHIJVssrypV+m?=
 =?us-ascii?Q?38mNS8f0O9fb3kQECTCx2k1mqObeh/coXNYJvXWMptZHDFKcHk25J+1vu05g?=
 =?us-ascii?Q?pogCU2gqULyKZixpDD1HajOIxXIytq7ZT2xQl/axGKTQ3C9M/RDHVqQouISm?=
 =?us-ascii?Q?OZVM+VIw3HAeShXv3c/cNS/j0Zr9qFOTi1ofq2u83XAARentOjobLXKOPQLK?=
 =?us-ascii?Q?vnV4vrIcA4xnWi198l5h4q9OEsi4kS30LEr8Oj6p0vySiDjR+88aXgyIDQH3?=
 =?us-ascii?Q?IxfJT4q18yNiWiOPZVn93cw/i4uzP3rRj8gYhGNo2v86uWwF5JlOV5mP6/hc?=
 =?us-ascii?Q?n4N4zs9VxJ2DywBCy8UpZuDl7LYljTJGtatNljuBvrEIcL4NX1rFJNkoAml9?=
 =?us-ascii?Q?d3Q8tPUP9EtO7qnK8qc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161f0a0d-488c-4f24-6797-08dbce5f20a4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:56.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCx1GMDBNUymHlGT9sARvJMbYQ3aHpIjC74ifTcRNHCBehZTlK4FOyogFMYFMPVGefxyjrSW+ZxTT+yjThZVCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
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
 drivers/i3c/master/svc-i3c-master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 3570b709cf60..444825aafa6f 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -138,6 +138,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -1045,6 +1046,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1062,6 +1064,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1157,6 +1160,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
+		if (cmd->xfer)
+			cmd->xfer->actual = cmd->actual_len;
+
 		if (ret)
 			break;
 	}
@@ -1344,6 +1350,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = xfers + i;
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

