Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B775DC81
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGVM06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGVM0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:26:53 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618AE10DE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8GP516tWs7XekKvvPjQVmJmJcpxiXK4VEiFNaO1uQmRhAbQ3JHtBCAJXGfVI9M/oTjWpFlxxVEi8Vk4/MfPZ3GpEY2qTE+I79FMXFDqLd2zvN/t1qgFll/iBKEK1QfdNVziFXChF5pLSxnfHySd53bWafcHR7JLKpHzc7lJPhOMa2IxkaIdybCgmcDK8CfV6/jt8XpZt5Hyab6M4qrF+tXuiV3vOv1vZdR74qBtzisppRBVSFUblR4a8JPOAYmTzYVszTp8buNfoy79MIDIbMZqJz1yp792I2bofrFsYUPjpRbZnvayuZj/0GKdvhLt3D0jpgojE1NIP/VPfLV0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=HXaron2imy8369WkkEduDW/lbUQNDpYGw124MMcT1E3XoRh8IP3MQpsIw+vcOQ4Mq1xedYEgHb1G7QnIo8WEcRSR9kAAP17+Qm2v/l9RySWckexMYiW9Jz1n5GHmfoQbOo50ON/YvpuXU6rcDY/bzKMLX87P9Uu8GtZzrOokMClPhayk9esH6QFpVXplfl3SGErbccYlMEDTC84MzITP3+V8dwHxtlQU/fo6IzzMTPBywYuCKWwP36xBCc5ke6oVQq6WdYaJbsaSchMVJru/xkuTvUopNwyjo813BcOzIrKEKP44WG4DDgWYMp7hL2YWbLbJ4CKHiUlBHAoBUN4JTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=SdTne0RLVRj3K+oMIflmtK7XRS9LGZk6UPdgkqYTm/msyWknHIkWD3KJOk5NjQKqogPiq0j7ugZYW1HHiRc1Xyjs4WQ9GYiK0y9oZUhYc0j1F5BCrvqxPb57Ot5d1OEs2BH8MVCVFn2j7Fg2TkZbvB45RurPNOYxV4uxaiNtJ7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:46 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/8] firmware: imx: scu: drop return value check
Date:   Sat, 22 Jul 2023 20:31:14 +0800
Message-Id: <20230722123119.1966998-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
References: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 21910de4-88e0-4833-f317-08db8aaeea42
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t69pgKwanB/5juoEdl1SdiTA0fjaQonfyduub18lFPUpyeXVLwJyTlChbwP34yU8mTbSTpKL2t0Xci4Oece/SVIoOqguP8QkxcQA2TRwbwd3bDfdPX1pY5Giu/dp/op1iVCyTZXsdLOYnSkqSMLTQun/ihyjnQqSoYqcbny44ytu/X5vor04xbxXxIshExPPI7MQWNS1qPo4t/a9PmgyarjftxZf/30yPIjKZmJlf8LGXgy9+F5KwqHy5pMwzO61DCxskttNzwAOP0MZA1P9CYe4EPwa/CT/wTKRVbItCLry360MKAb4yX2b+RWIXrOixRu0jSpYNXI0ieYd02DT6hlxlgjWgj2f6VZrSOTReN031hsrJw4a3P/uG1iFttdVDxahYcG+ZFC127mP+RihmZsnzm6AQjS4soxzKs8rmNPV2F8s0UJoQHFVMINul5HGe45W7SUAvTwQrx+45C6/Ow6IbKiw13xUQO3wYOioNsqFrj8S/wApTqd9otH46g5qe1GWH2oZyzhV4lvLlmkNE3gpCrxOtzyIM4ceSp124ZMGcC4X8AYtEmfZW/hfvkIe0lTYQlAI0EUCCQav5wWCxzvHFl8TYzOa/9kvjvu9gjuzYfgyjK8OIYlpLK/NemZi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qpSO267RnlGxWHiAVJ1mKzNseMPfHsrgSXJ3RmSQvfjm11Dpj9KWqwPGvkUa?=
 =?us-ascii?Q?6gss5Yoqo6QzlD2nuJ/mOifte+Bvj/cggtK3lRHr+ywyY+9kXX2Yw7xIGHfx?=
 =?us-ascii?Q?H3AuEUYxTVZk8JwPZ4pc8RmuroZN9E5ydFDQT16SHhI4v3TvhWi+AsVgi6m4?=
 =?us-ascii?Q?H4oNofmKximGmursu3ihBSDtdS7GQLmDnoZCh1wXE7NrULtdIgnC2phuyBOd?=
 =?us-ascii?Q?8lK4VH7a+67XCh5/hLMF7i7wOsMuYyusKTRx/y5JwsV9EGU8zoQ4w5da9b9j?=
 =?us-ascii?Q?sB9UkKJVptzZZfyu9OjwZVKAItHVMMwBLr7FUYPp2FadooNk+zyAvbkSKi50?=
 =?us-ascii?Q?d5Pex+N3IRO8DGXkvePmTNp8Naz531jxOGGg+JRqtASFAdfFBRN85C+Rcrap?=
 =?us-ascii?Q?6FhiZBxRM+ubA7JrNp24v3s719kHN20FY4LwB9WHN2sBCEKEIA3pDZpyzkoO?=
 =?us-ascii?Q?MldvdPGSs5cQA0ZNjguPcbXGs7GoZHoo3qbbgWq6pqeMrkGCCBdT4bZ485zP?=
 =?us-ascii?Q?QYJf1ZvTy+7a+6cnk8P/D00wF6JZZsHezpZrtO84P70pVZBDMif5rdiKU3By?=
 =?us-ascii?Q?J/Iaqv58kBeIDwSbFPPUP46DM9n7JpuWCDUUeMzV8OcR9Q+XRY891QThzR6+?=
 =?us-ascii?Q?3yDlpKsbYNnUnpnRGEOt2Bw1cTnRVqEO7JnPXsG6Qe6mwiTjjLX4El5GEEML?=
 =?us-ascii?Q?mWigVIU/nPAnqmYUf3WONwvRll1KXSf7N+wToQjDd6tZn+0qjP4chIQc3zTO?=
 =?us-ascii?Q?npaS/ibi0qXlw1KMivVD8E9J7FQHtjSW8zLmhZWWldMDWcW05b4cI7q03foV?=
 =?us-ascii?Q?LcnsQbi2oNIEhax13oVJtIs3xG94v6PN25R4j9ky94rPmZRXj7ZPzzRtxUGk?=
 =?us-ascii?Q?Cb2K8x5z443h3ccjhMaWGyfPZ9l4w9n7GUwaeTZc1FVtuWEkUT1pZB9MO1k3?=
 =?us-ascii?Q?BTegrkeqKGqFDOKD7I+Yg8Tc6Ht3/0hbh4bfNvbavHApAZ67YUO7LyDlaVeG?=
 =?us-ascii?Q?xXhVPvnlJcFQ8mtJKSQxxr6nbNgvvGyDlVrfyPONgVYjiyRGga3d18Qxy3ys?=
 =?us-ascii?Q?O+YCZ0I/AWF/hwDNZng4NbZOcC/1yeA9oo8NgXqAs6dWTmt+KbS7xyqdj/od?=
 =?us-ascii?Q?jWGKy7PbPC9Ld2sg8xQL+Fp1BHn6TOvYFwu92mOkdUVOPDCSpdkJdWzVJecP?=
 =?us-ascii?Q?mhgfgUhQWS8VTgYXfwxawwemHwPsVyZYXnI6Lz8o+cE31aplc2fzfIkjZns6?=
 =?us-ascii?Q?jV2ItmtnXE1K0rTs36wHmqG2Crr6OBzB4Q25Hb0FOC4goembxbiaKFdoKVZv?=
 =?us-ascii?Q?ZupuE4ot0z+3Y7j/j/sWHuXttf48E8YqDufCcoYhksA8qHXdvHjS8QmbMsdC?=
 =?us-ascii?Q?uVrSml7pqJlJ+pn27KJlfKh9Q+IBevLHc+qkAXWqsTKktRoVFzwQDE2uNBNF?=
 =?us-ascii?Q?tc6BOfGbiOjfPxhS4Te20w1uvG3aNcUrx7Sa7pELlHwdscdDFYRLCoT+JBkc?=
 =?us-ascii?Q?pNWuMAN/1XxQzP5rNFMsEN25XU6wsMMdAt1vR667gxDeagQMNk7FUYkYjNZv?=
 =?us-ascii?Q?JoZQmST6Sxk6mlYTf1RNGjP+yHj7O9o4lrRfIOvf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21910de4-88e0-4833-f317-08db8aaeea42
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:46.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCtrtO0SQkc4Fl0YyTEBHWgP/YSXrWGAagJxvPOXxHZUOkg1G5yFziwl1uiFlfHze70WQ+zZP0Y6ibAWPCgbAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461
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

For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
and the imx-scu always return 0. So drop the return value check.

BTW, also initialize msg to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..ef9103987e76 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
 
 static int imx_scu_soc_uid(u64 *soc_uid)
 {
-	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
 	hdr->svc = IMX_SC_RPC_SVC_MISC;
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
+	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
 
 	*soc_uid = msg.uid_high;
 	*soc_uid <<= 32;
-- 
2.37.1

