Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0C75AB1B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGTJlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjGTJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2042.outbound.protection.outlook.com [40.107.13.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F526AD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bi8UzqKNTsozJMMbJyoz9uFGbOHRpDB4ifLwB3U1cqmF39KZAdmNAm8rjfj/JHU6VBxweOeB8toWivrZXUThRVXQzYmC7hihT8WtgYdBDi6j4n5rRLlqzxVnSVvbMl8YbMWBWgHSeb/ywdsRaRnQrcQfEAxBflYY858DL56cH2ONuye1aaCfDOCJPY2EB6MYlKuQe+Iap30END3u9XVShmxYMFIAstWeAIdPWNH7NEmjuhzjbXHpv4fqYEB2W3TSi228KnGKj+OFaIfhwYYc/bIwKG6uztE7y3wsrznr6ctQyqVHLAAZjXfuO4ooABeUAXRb5mX5Sr8iprz6LWhUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Usntcsf9jSPDXtSzDmufPBCJAQO95nl0cPYHpk6bmPs=;
 b=A7lPQ61/bg0tIlDAS/EU0vsdSAyQBWvNa+OPSyf10cyzU2Nfagd+EGb4nsUS6hMG5JnL+dCKuH7bNItPRBFoHVrhHArVhdxJCRaBcKT4iubh9n5jnWEQHbYROB3ywFejuFSqOxowFWlOOGVPQxDqsJdQljC4tkZoHV/I5vajm35lxYrpLyw72kbONhTA3RNd+e0zw8wpYZ9BCVLq7F0lfxJJCCoXcYR1VPQV5JAMI6g8mQbmTUGl5I2+tiDb6V3wIGqlMCTi1i328s3qswLcyv5yaMn7BudREEhBbSdC78A6yimnGcnHP8PPy7xyqU+P9Pe6HiM509HFWDfFYK7o6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Usntcsf9jSPDXtSzDmufPBCJAQO95nl0cPYHpk6bmPs=;
 b=L9xEN47vz2GE/sBiebUP/NxlmzNXy/WmviOf4o9jMMdGIdoMU6MpvGUYL88rDr3TJJQ1916ttdaHgyk2w3gYKUJF0tnr5qtrHUPdHdxOwITJ4z/PLdiwcfwd0tONlMv2Yr3aduFY7gQsqyTXxgSWrleqa+EqKmPUT7kLgY/kzww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8388.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:37:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:37:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
Date:   Thu, 20 Jul 2023 17:41:26 +0800
Message-Id: <20230720094128.536388-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7f44a3-7bce-4c69-7c04-08db8904e158
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNMbqc8OMNbvxaNNiF1GPY32UJ0PLC96Rf1PdIGketjrj20seCUZBUlxoOxDIjUt1KJTpKnuIuEsojtpZoXLE7cX4mhogNwckbfoZsPt+Gp1hCk5KpsCypnhuBrEOQ6/P9n2zPQoWne/eiUtWOKY7+zlYe2Ird0FH5MSB63Eg7V4QdBmZh/149fYatt81de8Q+PxD7geLrK+Cc/JpC2l7Y0Pq20pxcX6m6l2ZN1k8rEvWAXdQQD87AcTCQASxyyTy7tgODoKIb5UCF9pXb1DVtqUJ4UZg+Tb2wByjcR6cwY+qMD7wFw5VL9kiPwTOiOlR8z2dIQiLgXgoUXqeex/QGP5pMQZqyy9pz47CSCGvRCTpOi1JJhGXCqy12smXdjSWDmvgCW3vkX7T/Sg/Yzv4c9NnoqAi/im8ZoBJB7VFptT0NABzhJ16T6RbONfS1ZxlLtaWAmkUoLgdyw9x2m/G9KCkuDOnnMfo1WsZiNXvrv0jqHJI2bkwlpDBiXpnQQ1d7Xm7In6OexmWiFBrSQuKnwyQrGN3jpuQQSdCgdvQ3G7cDmd9nseGW7GcQks63chKSweIdPV1iHuTO237lQzoMGT4dEnN+lXoG/9NHAWw57Rlfv44PCSHH5tGdyXi3TC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199021)(186003)(2616005)(6512007)(1076003)(6506007)(26005)(83380400001)(316002)(41300700001)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(2906002)(4326008)(6486002)(52116002)(6666004)(478600001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWkN8PN3MW8WK0Wk7VmsnnR4tYrCIYGSvO8Y8cfYWzLxP2Qx8hbcjjT0bbTK?=
 =?us-ascii?Q?ERkIR6MoOx2EOlVscKOctsrb4b8vlzu8raOoeXAmFPktpjOFGzzmY8iyEV7/?=
 =?us-ascii?Q?noUqj/H9pmrQnmXlfbevkT+K9/RVkR8ESe48w8+T0SoL2aDU8GVHBRxh8GHg?=
 =?us-ascii?Q?xNvzSt/GHb5qBkJZ9ifawlE1IkvYfHT7mJOr94xnGpJTNfSqSrikoV84Rp3D?=
 =?us-ascii?Q?8DagxRrNcGRVaU/zrhVVRHMmBdiyiVGDfOERGJwEUIWcUtN+rwA/qV3miHzi?=
 =?us-ascii?Q?pslhDXXciTS18kShNX8u4gcGYBLAN/2Vy99dQDmz33Jk0H9pJIyyuMAtriO5?=
 =?us-ascii?Q?ikRdfCn5fZA+WwYr1V9NK5KYlrU+tTY6tWwAC9Jzgm97oTNk1yc9u9E2FFTZ?=
 =?us-ascii?Q?YlXaXAO2RD5zQXH3VQVZA1rFW9Tw0/gt7gKHyNR7efh4tw59v6jrZbgMFmKJ?=
 =?us-ascii?Q?eO3BHKwfb2Fndfsk56uDpV58HcbqlbStCDIG9GRAaGqa/FssQLNplCoRHV61?=
 =?us-ascii?Q?JgndP7QOszoOl014i2qUg2sV3oG/ZZH++ayZ2RYuWUYtQVdUTwx3N0I3SxB6?=
 =?us-ascii?Q?+r/usq5MlrBvHHUmZ/HZ/JaanNgXo4fQTYS+j6EsEuFHGczrWMaiZDueoC7B?=
 =?us-ascii?Q?RLVqjor6hB2JjBWZ49BGH/5Fb6pAQQZTBKaq4TYcBYWsXnNWJ2JjvBv0If3Q?=
 =?us-ascii?Q?ECOurDLxCtadTv2Y1RMOHCkZKmuReSTxK9cFEWXhxg/3SBvmiykGPMq/xrcL?=
 =?us-ascii?Q?GM+JeAPyZOZ1cwv0qW9wv7XkoI52YcsLH9VzNIAI4Wri+l2ufQX3UpTRNxml?=
 =?us-ascii?Q?2dtBrxFigyZCbSuu2vc2TbcGO7HaLDzUQuo0IDhKIXH08q1fC6PGLkTVbXXO?=
 =?us-ascii?Q?ytXfOxpf83P59n0fKx72sdijpsovq7QsdLG1MwXRBFAMnjILK7iQK9hLggNw?=
 =?us-ascii?Q?qJhXskLgQL+kDTr4s+9zxsus+9YNDWn6J0VVsVBtigpK7m9PPajVroQd95Ck?=
 =?us-ascii?Q?7GjSmkNuXzafvVmAz2777Ji2HjbISuuNa9KzCNuiyERS9EcFi3xoh5TNvReP?=
 =?us-ascii?Q?QsWxUZUtEqbn2UPKorcm76JZeQ0gE6hiY8clG+kymUcMBZoimZApj6bpislz?=
 =?us-ascii?Q?TRU2QsfgArHp0fn/NjetaEIacCkzerCd9tTcx4HwxZovxHem/tvyRkmsCDxt?=
 =?us-ascii?Q?TPyKfaopVd+uW89GbxDeWduKbgPQitHXacJJi25CHuWQzF25gNsMGTD7EkVJ?=
 =?us-ascii?Q?MQf5NtykQJ+IJyB05oA/0cazgA4j5F1/VPMovlDIXor31YcBcIg3RvSUGrDt?=
 =?us-ascii?Q?5MSKnput9HxOsDHfL7PE3nkq2mm4SX3jlH8/atp/IwpVK8/KlkGUis8mb4g/?=
 =?us-ascii?Q?OWAUx64Zo4F0x+t/5OaG3VMLNc8zG+VcCcz8QAK3kO97SgUsJjlFRx6TlyAB?=
 =?us-ascii?Q?uNSKbmlZEN7ZxHrJqTvlxsWTC/m2bfTtzfyuvkwl438juKqklZXZY4NqtUeU?=
 =?us-ascii?Q?MRLFxHPBfn2S+qNWbp9+vd1DDl6S9pbR6aRpbfQmCeJ+feVo/zvKL9bg+xGq?=
 =?us-ascii?Q?3kF6XH29ERxMKthyhhWf1rRm4usMVKueazU95nlS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7f44a3-7bce-4c69-7c04-08db8904e158
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:37:05.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4jzXNweUaytq4yAZqV8u6+HIj8t1IMViHtld28aQ01P5pkRAJ5cTwx+V9MIFeG6vARkOcut+zwQKrJnR+FZKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8388
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
index 5cc63fe7e84d..08346f312c51 100644
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
 	return -ENOTSUPP;
 }
+
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

