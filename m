Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7877A75E982
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjGXCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGXCI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:08:27 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF659FF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpwPPSfrHqPMeNTDIVQOvq27AA3n3mDIsRZFdDd2ueKpMU8IZLoXFJnUf1kws5cOiBpcSHaTXMaA+V6frVp8slRTYxI//jpVr3Fe561+a0dtMmxhjpao6V0hmdRKfZsm3lG+3wI74mHpPcta9VZAHTcMTxtgt8IdEAdwfhKwCnLt9NGj5RHUUY1PyYa5qdyvdqVL7VUy6iWI1rvQJywkyCZQEj0zyZrpqbcUVmDnUQaZHMprAzOtwWxZSmIti2kVdoy5urfq7yZGWXZfTVpZyNDP5XpoXB5klHh6UWCK+lU3YUBCGs5rsHhZOWAmZ5vyVI4o8HoprpbntS78fhI/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d6XR1M4GmGZ0qoyBJ6wYmxEkLqFvXG9XVATmS9Hlf8=;
 b=iBIUlefkHHahOFLmfK+E78Uhwz1QI/Ttqyq4FUDv0A0qTfc9G6UpC/3FLutXnQWVzJ0fmBX6Abu9KwZm5l0RjwOEtOUCv+SvDSPfdUtuy1NhUVZIcFuUig2z8TfAY1j2DURZqU9zY4kMRrrsUG4tP+EY0jbpfDd5S0JuNlPiNnopviRbG6GqajAcuY0Qy1qfSb91HaWNEmgL8fNGaaiGK40KqQ8GQkd0V4tk6VlgooffFk30kWKb6r/kT2ThlxMHqxqPk68ln8FHlqbZOHiYAt9xDU//GMOEkpfYw1d/EXPFEaBC/OjgW8iMvDnUWHFTY6YEm82nqh68Dq4FHGvzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d6XR1M4GmGZ0qoyBJ6wYmxEkLqFvXG9XVATmS9Hlf8=;
 b=FbnJavwVXxWrdKog9VqFzhwVa6gGpgofPpeHVCNKecFvG1xzIUzQS0eaYjV44xvwUNXOVqOnDMHnCqYJSQaTWGFs4YNsw4B24Ovbg2pktmITDEnEotB1OmL9jHVQYDY8GZViEHEPrlJiM/Ss/kfYEjhPPiCt6dLPvXN7Qfq31G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/8] firmware: imx: scu-irq: export imx_scu_irq_get_status
Date:   Mon, 24 Jul 2023 09:47:07 +0800
Message-Id: <20230724014711.2048958-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
References: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 52620ae8-ff46-4df9-9828-08db8be7491b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrasrB7cp5ZzjQtqMDvdvmxZsXqjD20DVXoUzZk2/tkiifryifD03ZHtPp4/b+LrTCRaGn5JnB8CVO9fa0MJXJ6ip6bxZzahG+1D1bVc0GGuoSwfyZFKwoetabo4l3QWgZK2O6JTuzTtsXskitN9BmNkoohqkhMRGlsugDXpn2PalhXJD+hdXpJ2LLR+8PcYyn+f/Ac2UCIN8m+RiAYAtGz1Fk7hMAbMPf/VIRPTS8RDWTlJCdUrNjKapfQcxg/PBpDbIsjp2QuP3ZtFScEfZdk12W6UOcANSKXbuLVT6IJEzBF1qJJ1UC/1wYj/PBMxL/8E0AhQaZyn5gkZHfGYr6O7d+ks1n1i0TU5R1G44iIS9b91DqLok8aO89UbwMritsUeBSD2JMgpBtyJdxHVTiUEw3t059ERQKI71kdEziWJQX9hEi4sqU8Kct5Sj9FAVYQ0cnRs7hrNEFewfEd6/HLtghGJBS7/AUXnNAcNX05rEEMFV7p0I+E4Jq2SjcDYNugyuCcaZ/ZYPTGuhBHRoYnIqDQu5yCWuuNnjVFSK/FcIfPcsgJOx19VtvXsXBiIYVYDKGCoUa7qeYjAdIzpip50/TAEEyhOIoV19PlhBOauSSGDrfs0arlKLzsZ1FnH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MakrVVKYV7nPNfoMhi1FTy+I0TQJpKo3xSRgBgHRipgsPVfZgL4qX5OdDuH0?=
 =?us-ascii?Q?k3VryncLvFrAyvJuGjAD587LKredx/zoNfxaSg2VM/iLBiDLKSEdptmJpHKR?=
 =?us-ascii?Q?u+SWoVu4CkJRp9A+EV6q0uaJxOezOdfRAlNcyy4PQHl4P1tyciYD9FxqbZyP?=
 =?us-ascii?Q?OTQflDNODk/DjRq87KLE5oQo2vhB4m/LEJ6cbYf3DOOCAhMpjM/FaQqqY+U+?=
 =?us-ascii?Q?A0rsnr2E/iZ8lZEhjEIo7+/70r/mr+bIU7EbTLk6pggHJgY7jsmIraJeaGcV?=
 =?us-ascii?Q?ALX0Ky7L7hWGn6xoQ8QoNVI9jFrOWNQ73y66mtvnwlWThlyv7VdKGoTpUfAS?=
 =?us-ascii?Q?vqbULUaSplQz5yGYSuN3YFpiqC2qG45v90jVjbC/ody/Ei6ftxVK+i6q2Eqo?=
 =?us-ascii?Q?3l9dvEy5LGc4HfjYzha8G4z2TbFsk2GNfwU2KXOSYedciKRE3OvCeabyhm2j?=
 =?us-ascii?Q?v8gxC6minaZrGUL43Mrs6ZANgvvCapK6xJyvxNwcGqMtNYW3+IuD7vexQpfh?=
 =?us-ascii?Q?C1gYDnPjJvcnjzEkcz6HsfcZBeJA8ZBSWuH+7sA1C9Zd6avzqM0H0PTL8mUD?=
 =?us-ascii?Q?lIzIEznpfYzErIinYoQzdJ9JcNV6RoxFjnePHD6/1MXJ14NPjRjeAP4xfspe?=
 =?us-ascii?Q?zpWOEGkUpy30bUo5zrgxOKiAwgp6K9SQDIguLrraXICawdGCRqQZC0C1GhJ6?=
 =?us-ascii?Q?YicuVdFs9f4xPAiiFU+4ImZZlyWlounFhqjVgddiy2+qAhNjvX1bXxvrLqrq?=
 =?us-ascii?Q?OSdObx+U9T7vJFyPK2Y7/e31kw9A5yvyq1DsG7Pc/NQlbCXCe0iV9mlaaRkn?=
 =?us-ascii?Q?Bo7269OsRxSYPZnr86/s425E9HsFR/w3Po45wFFSumxdBTjIRBbGS74rQG9u?=
 =?us-ascii?Q?0PUvHanGnxgc82E9K4c93nQsXYpsakikqiHLr5KpjembaUaa2sW5Z2TN9zb+?=
 =?us-ascii?Q?yZ3cNVBKSNnNg5/u8yJSBspRu0nq1sB0iZAMWUXE37+Qa1acxRfd02OtVL8j?=
 =?us-ascii?Q?FIT7Y8TWGfBA6gBn1zGG9wS4MWiqSr+XsN1vHCh8y2XZ713PPbscsEEvwgkl?=
 =?us-ascii?Q?XJlNjYvF49oULqVguh8xlkFL7N8tZBkcj03Za6RX1u3YMOVin0j1Re7x09VZ?=
 =?us-ascii?Q?wHUJzGFBJqKF9cBmCXfUXVBTZM/WTyz4L4rnXpmHP+t8I6dGPqZvm0i0udLt?=
 =?us-ascii?Q?vSmZrWRpPNoKMCf+ZXR47IFXHcTcgLblpCb6Amr+tmxYd2Py7FVW/AJaETZF?=
 =?us-ascii?Q?SO/tZVTCZ7+fBWYuvZZZe5QiE6p5FbDc3WUT+v1mnWF9PFd38B2gS3nNdBEk?=
 =?us-ascii?Q?jAycvPwWReVSuMv+aXRMsUYU0sbidSTS31ZryrUBXetO6x7JqFpDR7QA5WOD?=
 =?us-ascii?Q?8ohdrWL3aiz2/K1QMPS8/DtkJa9aKTFnHFlIcgPFp1z5rZWDk45nzdGXlB5k?=
 =?us-ascii?Q?f93aFnalc17pBYdCafM5qj4yraHuJFLkAzNEwdubJucJ+K4nuptYDuLpsA+M?=
 =?us-ascii?Q?aUYGw716G4d5AHMBC0s2s8fNulg1iAyIeIA9dqzLJA5Lbw8P/yODvhaCZnZp?=
 =?us-ascii?Q?v3P6vNFZliVbZtK4CP1COepnwk9v7VHkTinx90Xv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52620ae8-ff46-4df9-9828-08db8be7491b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:48.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GXnINAvlOFd/p13myYiEJc/OuEjiz2e38tAL8hNVhuQLUuDgMJxAmtILX3Kaul1HbYePMZHPZdjWgZ6e2YTgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8797
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
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
index 5cc63fe7e84d..db72f2bc6a26 100644
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
+int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 #endif /* _SC_SCI_H */
-- 
2.37.1

