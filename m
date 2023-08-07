Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4811772377
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjHGMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjHGMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:10:35 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A8F10E5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:10:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odwkjPuCMRBA8fUFFrwp7UoKwLcGQoduZsGTlEqPh/18Bh2in7QvMj/BvYLcWC5CcLro/ABGTht5YbwP/QuQ5aBN5YHGL8OJ9gfiZc3LNyt4ONr81C6YLRUBW3ZL6czXvLz5hVL3XjkV+7hKRd3iXyjbcY0l8M004qlNpKOxP6nGzFKhQxAR+qU29DV+FRSo0+VQ1IG98l74MKC+M7eNJDMLdAd0EFS28WO1FkbSCn1PpdawNQ/RsA/mLi2I4oUBTb3teyliv/OWTDYN2u5dJGKhf8UN+WUXvw7oSevWz9Q/+Abqqx+CKyjyt/sHHZeaQ6m0KruNwe1UY655MmKtLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycM8aZvWdkkx1a/0yrIJZRXsK8RWsBF5NSrc6uF58PI=;
 b=GQJT4clrEcDMhXM+BzucAQ3HUOPhFXfmPPMR9hmSZTJVjLgcSwsoJLf8EBOeMgQc5jKqDjsXQsfnTm/AAVoHNUJovEA3zDEQyNuqHVk4OjIFCHLXLy4GMLNTOc0bnFRL6uB+gYXW+F6jjRn+yigMMTJTx7BWO5Qguec9wORkRNzpXhgjJyVk3Qg1cV8vIw0mIRfkbW8cj4pWVoSLBVAHjw0kWQ9C0aqpNArqgaBRsu7hlVfMcTYEr2W4Ly8ryZ1EaydBe3sdkYhFLmb2138EyuR2m4er3C/acw6QqzXPtZu0LWuezrUaWyndp/LLQkU225wM5nESikHWylVjDL11aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycM8aZvWdkkx1a/0yrIJZRXsK8RWsBF5NSrc6uF58PI=;
 b=Rho5WL3ChBOfQJXZ2sfht3Ngl0M5PduNLpj7sqD8jhsLUhUFkTOa/WVhEnDwLPxO3VQL52Z99fc/P0wl7y62Z3bEqzZSYVHlX5UfFbhMDxK2s3XFhQCPmnvXx6ljuX2zYoddVASAN52B+qDwhkIVFMVwrLCrdOgldHEv8QLpM/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6897.eurprd04.prod.outlook.com (2603:10a6:208:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:10:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:10:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 6/8] firmware: imx: scu-irq: add imx_scu_irq_get_status
Date:   Mon,  7 Aug 2023 20:14:30 +0800
Message-Id: <20230807121432.3970610-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
References: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: e756de66-3190-44f4-9072-08db973f4219
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSPhLHjZxoU9jaVEf2j7Fw9Jo6f8nppEQEB4p7KTUQu5knIuBOBvcN6kCIM/3gkp0G8rwhQajazqLmirvpCtICulsAv42VIL6UE3hC3fTqk3mleiOL/DNzreguQKaY521P3M+89pGMbe4s/qLP1TBqpDtZvPTkEV2+M9TnzEMtewIfB9Gww5qXB6iVScpjydPejjVir9BSVgCXS25y5zye1wIEnzcWA+FPSzTE7PJBzLtYaYxy8HLu3qlnvM5qLqb7UeFcFVmd7PKLkpPV+WDeAEzMSRypsSp8YrgP3MzQHcriPpv/s9gy2WMrY58fcfSmq+vBO2xNEPx9vWwgXZK3rS8Isjc2V8vKv4JLE1EmbhpQbUPD/sevKdgZphItpBeZoKSfBBhR2wJT/W336moif9DKy1cUPHiek0xpGah7u3KOHRaQO8NXig7cCBxJeWbEcm9Vc5ypfueXd666F6y4hMc4wgcMlDYJC/ZcDCykzDMLRO0s496lbkTN/aU6po+18gbvDOyDC+PtU9RQ5fGSuIzW2oNfLLl7AvqJqsT8qPmpW65GRyqE3lWkM/SofHdx3vENyhv00yU20QZAROPcq1W2xYeerH7yMgcVYGMggTWodctKhKKr/dGlNZd40D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199021)(1800799003)(186006)(2906002)(83380400001)(5660300002)(2616005)(6666004)(52116002)(38100700002)(38350700002)(6486002)(66476007)(66556008)(66946007)(6512007)(4326008)(316002)(41300700001)(86362001)(8936002)(26005)(8676002)(1076003)(6506007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Uxhoj//1ehfmYZ99BrLHyeOs47hN1/H/VkTwnmJDYp0Q8DyxZoMrBm7AdTO?=
 =?us-ascii?Q?YyhmD41iYnCw/cUfpDPD6v1ZyA0cVqQ12eVM+DDsemaI86tnOCuj0AG8j7Uh?=
 =?us-ascii?Q?oLXPwlyZuaT2Bgp4nFEieFZEo6q7nHmMlxEfqB/tgg/qWdyNeQ/Ztv+xQS3c?=
 =?us-ascii?Q?C6ncc/fxAXWYakVjLSb9FISDy7yNL6/OUd7+TGjB3xGZNA1JOUZuV3TBSlzC?=
 =?us-ascii?Q?WcueGKvtzvZZjNuAHYd+NGhN9ydLLNJcFY2QmjJqoYVtUEIc1WjKwlxn3/Nz?=
 =?us-ascii?Q?dHP5RqUIYAKCEYQL9CnCtxjOQiXUsfPcTIQeQwAj5ScK8BXimfBRMEMGuKhx?=
 =?us-ascii?Q?QBTcbdzXUpsLFvpPpmdkXk8dE597BWWNLTveBGaLizV3B92A0trHcwPLrE/C?=
 =?us-ascii?Q?W4b4gOavtwZ434qSQ8T4OeWihC1ebll80yqoT3F3YOQA9r9goAcN9SfT/cqm?=
 =?us-ascii?Q?VzMb9jpr2qmRPKYLGuuCMVRNhx8dp15zcLgzCTS9tpLSoJ8J5xxPiUeN+UtS?=
 =?us-ascii?Q?QgXHRLrQ5XIGshojMoX1q4rcVOW3ON1PGViXSeFpf2WRwfQ+u1oivd5nafk3?=
 =?us-ascii?Q?isaGVr2gATtyS97/lgvcNzu7HW8Ct6PIoVWgoCiINfM/Ry8LbjyMO9oX/d+r?=
 =?us-ascii?Q?9AzsF6hQgD8IG+qIVtiPlJKD8bMBBPOIV3N5wsC3OGFK3n3Y+Ebo75QTOLP0?=
 =?us-ascii?Q?IqbVuLfGjox6qkDGns/ZPE9mKC6LCEIxlGi5LwwJDB2sU7gNlK3LmELaDjHk?=
 =?us-ascii?Q?3X9W4wFO/cUbc3WowY/eNj5R8j/hzxZyxYyIzzF9gSrBAEwqmInM56p6A1er?=
 =?us-ascii?Q?oQZeebZurEDaZD2ByPYn76/8e14LfiY5Nx5lRl25LJnpPIWlVfqKdW21tqOp?=
 =?us-ascii?Q?r42xCC1+2wSCV82A5xnS0h0gq2SRDONnkLVleWsfO2tZdufYSpUhbE3Hhz6u?=
 =?us-ascii?Q?iNDIvSihwEAAtXIDWGLoF4A/8nd3wLTev0mYZgI1TzvjaFYg8RlLcKjAmLCM?=
 =?us-ascii?Q?SNRfu3wLs8zP2FD4jtyUqIWQi3KjYc78QGguMH12TcP+ovCbpbxtyi9Dzpcl?=
 =?us-ascii?Q?RzXwqldRcugR0OAkeA9fc09OmI9jmTBOpFeISe0k0BamlRI6H659Iq7Aq25o?=
 =?us-ascii?Q?Eimqk1qmLQ2uXaYWiXkjXfRE5gz/nqx2qR+k+doE1txqcQclQNkmepWZD1Ei?=
 =?us-ascii?Q?eT3SP5bFZtCseDI/ffmgOV8bhYuHpHYwvvpN8mjqxzYcyD1VOcNnVIAESmZK?=
 =?us-ascii?Q?/Lpt11xZy7FM7D01xMuwWTG+uTITsphh0jtRWepEVui6OKsPe9yE5BaefPl4?=
 =?us-ascii?Q?nY8qfdC/5ZPsXn9Lgoas+KcQZPqfhHCxb/BI6+JzCAAiNGzazMPsox8uL22s?=
 =?us-ascii?Q?iY+nVDwM8VDCZHdyvbF/a9ln43dSmMU0zQPfV2f2e8KR92GdvY2jh9HkRRJI?=
 =?us-ascii?Q?yxFiPE/HW6Kd0AE7tdddb6ZceZDohkk2wdonmC6yDdBmEuwuBo+8nDohr7+m?=
 =?us-ascii?Q?0tiLHHSEl6bjt9PRbR1i4RnNv6Aq053x9mF/iFaNgldo66Rbs2cr3lwRIzsH?=
 =?us-ascii?Q?CpZoA03rFRC+uGcPCQrxo33bJesFWlkuHdPJkieb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e756de66-3190-44f4-9072-08db973f4219
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:10:15.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JJ1Rhoqr5DZIZoTznh51H6QXnZiCiPFDS4ZfEgU03ZHPyFhJ7lQeOKcq5gow7fAjCcFqlIPV92poB5CKx2V2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6897
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Extract the scu irq get status code from imx_scu_irq_work_handler and
make into a new function imx_scu_irq_get_status which could be used
by others, such as SECO.

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

