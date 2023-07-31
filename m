Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FED769105
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjGaJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGaJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:01:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A691B6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 02:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keZAgnhXPQZZ1q2TIuW/05hZjBRm8XUsL7fLf55KjfGYjQdFkDAzmnd6SpnoGMCjwWx67U5QJjm9LeuYZWGoRKW0Lgyd6bj3KYMNwom/DzwUJZcgiAN8v1wzdTW8IKwQbCXkPXRe66E0Uzep2a71oNs6U2gZ6O5Afy5zxj3/SVg3S0Pqd6vM1FPdddRqnpWMmFOFlLQYO3T3bP2m+jaNlimqkSASBEvPetkxXbxnAYKv/mVXOkIRFLmTqDZ3sn/k2GW/K8QEUVIukjkO3ABZj/7cb8avooeZIS53AqonO09YC+4qmwItTnD2VEMISpkmVjuJMIyD/kK1nbx8iMtO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOSwyoTYZ6x0eroytkCZygb8EdjGii6ak5j2QyBRG8o=;
 b=S4K7AmwqHqmTJH4ZS8jLIK9ZXY5U6udUtpd6Di3TZgxli0zPi1xezKQc61Qj4zwM/HlYSir64CnPRuzNzH9psxa5nZ5u9O/5P5WGZvIow0buyztl6GzyMg80koHViy50YAHdp3FO8xTQK0Lq1ZbPUcS545W7bd2Bqlet/yqO++uqJBuZGFmmKzJEAs05FmJZWaQSmEIPRnOZsAgbgGitNoMLaaGvRNUDNlNq9f0VLvYTXn2jOAenGSyeo8Xv5kVzNesq0n/JFVFy1/RG9+YNTc0jhxN8T/5uewdlaUnV/1ONFhR5vThdODsnyevH8J3CjmE8pumh1C+wE9fFI6IrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOSwyoTYZ6x0eroytkCZygb8EdjGii6ak5j2QyBRG8o=;
 b=aU9wvAH0OMJK4jdDfSLJprMjU9kmgWwvA2VfoCWXFZU3E1ecnM7XXEQ8xpSzwYVum25V0V4gdtXV8+Z9sg3eeFJmsjTA3J1PP0FbP6jmbsT6AWjkbNfvV52IApoc68XkJXX8xyxFZi9n3AO+ImZAwFHA+pmiiixOa97h6Mc/m+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 09:00:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 09:00:29 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 7/9] firmware: imx: scu-irq: export imx_scu_irq_get_status
Date:   Mon, 31 Jul 2023 17:04:47 +0800
Message-Id: <20230731090449.2845997-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab2d4ab-8f75-467a-0940-08db91a4967f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afgAoqF2ZYSjjR/3vu6clF7nhF01nHccwZOGuq2H5tMd8mqCn2kj61xCq/dH3FXS9q/B2v6R33sOQ8yFbxArVVISul1sFjZxUUKRjg1VcArMy0JohB5DzdQZsNLIKLdqL71wAt33YYBrmt0Q+QjPhBQir7uRKswsSiDvMegEyzWZBMIe/qWFchBt4xRG9GdmL7fATjdvPyJ00ma/0i0xVw+79iAnXOPKxt7boWyL62mYFwwHDEF4VZVBDw1YNG+sOiBVx6jbzlI3m3xXKgwJ42XZN3XesUjB+IM+zS+5/YWNLbZCHMZ+HilPX/bq2KcnRoMXywAEfQt/6Zuh7WT0UuTy/XfAGhq9sDJP+7xgZ2VC0PzOZNfcF3YlWRdRkCGbq4ypJQclny/8So/ytABHLZasX4dWXbnA1dUz1dqx3x3uzUFBFigMzQdQq+YSz5hIvWLiph4nYAJTWzNyVpEbnyLmFhz0vzIzYpVABPwLrLMjhBA5H7I6PDzE6PNiKDv/6X6aDjDouCYP/cO+mSoZqjyAa4q3VqOboFXyg7noVVl79V90nXi85OE3LwmdAe2qJvEWJ7ri02DwEV7Pv3ztFsgRozfQtFkYvllwN2vS30w1x+uEu39w4N1alp3imR6h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(6512007)(6486002)(52116002)(2616005)(6506007)(1076003)(26005)(83380400001)(186003)(66946007)(66556008)(38350700002)(41300700001)(86362001)(66476007)(316002)(4326008)(5660300002)(8676002)(8936002)(38100700002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LUTmo1+1YBsURzB2DUZMYVNMuvHVp5n7Y6CtcXJk/fdwPN4uApNL8Jh1vHiK?=
 =?us-ascii?Q?Evr/KF6wyQFo+T/l+KSDiKy3Gr0T3luAPeFHINw7oSgY7U3G7u1RGCOy1KN7?=
 =?us-ascii?Q?3D0ZfAyG1xaketEzZmCyh/CFJJuUYAU04+6J9J0ZWi/10LQynEuVECO2d9KN?=
 =?us-ascii?Q?CADQIKe+BnuSzLMdFxy2fbQxM/V3FHxjA/upykPGDUPMmU6psDRX4oyk8sVe?=
 =?us-ascii?Q?b2c0gWYIYIAbntoGjulR343ZgyJSDWPICNiMjzc4RkL0J8uIHu3lcYrPiVbm?=
 =?us-ascii?Q?RMhy4BRG6Tfvpc8FjfkWSAhB0ozFtfH/TAN77fFD/l9y1TG1D7iNly0Yz70G?=
 =?us-ascii?Q?cfI6LWkhXNebir0dmGePRnawQeDskEYKkZPSjv7U3YuD2luX8xLx5KbjHkUe?=
 =?us-ascii?Q?gzndDN/GW2JMYYKGnZ3KD6a79RP2SeIrkoCwJfx2LMEcvojpuPQ+DuEjTg4T?=
 =?us-ascii?Q?HWNimuAZcW/JpBEaKfZqfeSbbTGc+mVM4PIJp/MXCankC4RllIvGaZRrCh1Z?=
 =?us-ascii?Q?6MzVxKpsl+Ug0Z/i/Z4Gp9XrvOWLYLTUqmB/i1Qsbr+G34L4YyPrWgsFL5r6?=
 =?us-ascii?Q?Onb82ToswwAR/MSyyIhjYIyD5c+xg/FrvNShePuV7hDwVbDNiVmtfC5bpumg?=
 =?us-ascii?Q?yGCvWpKvs6dKMhYVCdf3vLqQT6W3O6fYzvaSGX574oLhb8/kjBigieucG+hZ?=
 =?us-ascii?Q?Uweuv2JmMcsCdTXDZqf2/xUGgVLuC+M3jU/8sFnm6xwwu/uHJQgo4XdQO2/3?=
 =?us-ascii?Q?Uu/ZeEwc/02FonTcUVIn/ez++yPDGShqN5VT9GIkiNHu0FouK5S/AdttrjZW?=
 =?us-ascii?Q?0uV88bBigMFHSvjNKWT0Pfz64nYcOwWL1dwEE0GNLd6CC+UNsOnT6a6oqi8/?=
 =?us-ascii?Q?001oa8AxaSL5C6Aq9IbdFAZ9Ev8ShAPe9fjUIuXVRfY0BFRDqrrqYRTPWM8k?=
 =?us-ascii?Q?Z9SKIRsl9T5DuU1pvWryPgRVbHOTGQ0LgjN5cwUI7lyjZ0qI2knvi51jJjua?=
 =?us-ascii?Q?LfV6UzMExeSzh9EY13fP+z1Sf0tve+F5zPzJEGsb86zDfLsgCQcGHFkkkrXr?=
 =?us-ascii?Q?ksepEu02CN43zkou2+N5qlaka8V40SNwOf12LJmPS5S4Vw2AxFBxnZCrsc1I?=
 =?us-ascii?Q?guAPFH7xXMCSxBmW8XYLoV/HuFO8IrtKmZ3ndTigMD7EEwhmfDX0p7SCMQIK?=
 =?us-ascii?Q?UGI2wnnEgP4yVjG22GJK3zH8XUyLUdTNz40egjphFiOG7mehbeHitaAAHu7C?=
 =?us-ascii?Q?zSK87mx73+Y+DLDvC/Sh3lN2ajQQLCpTiiK4R9ZTlI6RQgX9bBPiQxN5Pxe5?=
 =?us-ascii?Q?YsQf6V/gLeaMb01Vk/uSrCF8AE1KZz9At0D6cyfkPQi1pVvQZL6LAl6/Rn/h?=
 =?us-ascii?Q?icSFfMlY0nFoR+AEa2yngeV42cRsypjXtyxLDgO2oD5nMWZvcZMHOJ7qOi8h?=
 =?us-ascii?Q?gsJdDyitiK38qbabsCGRcUmjKtQnWMpbrfoBS9ukCH3M3jSLgmclpUrH5kYE?=
 =?us-ascii?Q?m9YSTgp3RzpPZd+OrMKvYqCrhT1z3O1y0b9uBLrklVjEt5HK0L8ZSdLa2rYN?=
 =?us-ascii?Q?flY4bPfzwsAKXxX2lhS6SSbBFvNSTUowZaDghuUw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab2d4ab-8f75-467a-0940-08db91a4967f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:00:29.1200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF4TO/4++qNAiUhpZTvAp/A/ogcCGF7FSnqDysMIrvnuforWFgujCWlXiCRiPWWazNPCseZZT5iI9NnceLCRjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Cleanup code to export imx_scu_irq_get_status API to make it could
be used by others, such as SECO.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 40 ++++++++++++++++++++----------
 include/linux/firmware/imx/sci.h   |  6 +++++
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 4408f150b3d5..6549f3792a0f 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2019 NXP
+ * Copyright 2019,2023 NXP
  *
  * Implementation of the SCU IRQ functions using MU.
  *
@@ -66,29 +66,18 @@ static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 
 static void imx_scu_irq_work_handler(struct work_struct *work)
 {
-	struct imx_sc_msg_irq_get_status msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	u32 irq_status;
 	int ret;
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
-		hdr->ver = IMX_SC_RPC_VERSION;
-		hdr->svc = IMX_SC_RPC_SVC_IRQ;
-		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
-		hdr->size = 2;
-
-		msg.data.req.resource = mu_resource_id;
-		msg.data.req.group = i;
-
-		ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
 			pr_err("get irq group %d status failed, ret %d\n",
 			       i, ret);
 			return;
 		}
 
-		irq_status = msg.data.resp.status;
 		if (!irq_status)
 			continue;
 
@@ -97,6 +86,31 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	}
 }
 
+int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_IRQ;
+	hdr->func = IMX_SC_IRQ_FUNC_STATUS;
+	hdr->size = 2;
+
+	msg.data.req.resource = mu_resource_id;
+	msg.data.req.group = group;
+
+	ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	if (irq_status)
+		*irq_status = msg.data.resp.status;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_irq_get_status);
+
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	struct imx_sc_msg_irq_enable msg;
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 7fa0f3b329b5..df17196df5ff 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -21,6 +21,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 int imx_scu_soc_init(struct device *dev);
 #else
 static inline int imx_scu_soc_init(struct device *dev)
@@ -47,5 +48,10 @@ static inline int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

