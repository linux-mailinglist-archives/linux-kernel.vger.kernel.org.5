Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1975EB92
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjGXGer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGXGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:31 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3125E55
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXc+CLCM5acEMg9bOpKlMc1P9nVFct0p3EbeBqzT0MLPy4Pvs1PNSpSuvZwDRx6bsv4qQmmOrnQVpugJWsBLz4xOiZb/FQbbF7YREUZkuwvKp9QAIxqJhpY+XkD1R/9ApHR5IT9nqBmGiTIgbxHH1pLF/Pi+FHlSuYLlAXy2/eB0VymWf6fYSdPRijXMTfxvu1gO9hhcQ2qpeuIY05B2dSw2tvuxm72P4Vgqbo2ePTRPOBaeyPLCCfB7k9AE1ZqF5St236FfnBq2wA+JM9TBIVl+uw7n7XM6uMdGHvXkm1LfYlk3Y4xW5ZzAq5jqyzrdl3Kj3yct6CweWDVjhIk6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=N+Hq4zm49gFK10OtKTUS5xOYtIWXgTn7nqgEmb+TYLIuiY8OnV9P20ygyzNwtaOZxqI0ZnTAbSkScYqb+Okq4EPH4/NusQTpNvCT+O+SZZzmeNX3Q0q7gQVV7X9C3DVTPFLzPNpBQtisRk66swYu7xbPKRJTSrQFsqRtt5mUnBOj/5S1cYunfhHIRV3WrItWx9FZI5idu7r6gM042XMpsH+Mdfsq7/5Ccq9EEYBcjVDV9Kkp8ZqTix473qWOuQDl7VDWCAUIW22lmyjw1fBWiB9tjvszVFlFaOWqA84L75+oNtJmXRupqFfrGOQRmzWr2RhF+6qGudFRol4rqCIOfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umI6ZrQ15cKelsFX67lK86cAvVI5zNZJ2V7Gcc2eaAA=;
 b=Uhn8SMSdI48fR0VucOjvm+eCmXWKO9cVKwUdbZTwoBxKYtzJfz+Yx95d3PIPHRvG8oEZIXwkpfDiqMNLJtcAql6JL/wLms9XsuSSlhn4bZ5BmKasOdPxf6eh/AO920vQJR0zHNbCz2gbEHKKvNssW/MGavk3nGfDHuohDRcrfKo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/8] firmware: imx: scu-irq: fix RCU complains after M4 partition reset
Date:   Mon, 24 Jul 2023 14:38:49 +0800
Message-Id: <20230724063852.2666930-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: fa69bf11-8dd3-4946-7c86-08db8c1004ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGykgvqhhTkokEovmUVvYezYmxqzlE0Tj9Yp7is96G3zUiYRxngw+7cvDFyGSfErs62szEdJWXzkwSFiErMZnT6mW89f16gXgz/x88iPltmVzc6Gpk0q2UNjz0R8YusnWo+6qcp8j1A9gW/eXc+a7vSH1NjT+sI/wQJ1ffVcS0IEv4s2FsmN4l0KTdCwBDZzxNT8gHhWw5TrN2ccFWZvfHiRWBo73qP4HyY2QxOkHuMi+/Sn68cB33pRMAUfpngwoLJoQPfwj2g+vZ3V0IPuuyESf+P3bKzYqPuaLXdicYer36xBcweEqwG2r3Ovbc4JLtXUCAL4LgaLumL+q8xEWIoxOLiIl7Hm0HlE86TwDxlxsRhmwpJnXvEuINzeeN5qc9kYRoBMD1RkT7HSyGilZoYXlUn8+bjEDM/3wLWZNeoqWgZAR9cHZdouV7NTwI/ALk4a1Y9ebTi76GppEPe2bj4IpelhGGYI9JIrWIfUMWos0bwqzZSqU1e3YYRnB9AyY76ZnK2hlAjNIEPX65rGLAfLEWxhn/Fgn7XWYG/6l3CVCa6thOvwreGQfkXvSYTStGM7Xtct/k/W0hiuJ017adjdUgUwce5HCfpdShcWXdoT8tZy7uwrhTU68TcKSHWH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(45080400002)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(54906003)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?umKolLLCww/jM/ItZR/6Ik/Y6PtGlWIiI21+sRgNuYrvQSjyuQrMKkEEtFbX?=
 =?us-ascii?Q?qY4qCti/eenmbXEVeFm7b7Jk+Sn7cfkoiBQCSi/JjSCCbiRYwZ5R8MdJeLFc?=
 =?us-ascii?Q?q7k0teJd0IaZvWctU4We327JFbAlhtQRfAvR5TUm4Rbi6yJ9pzXGVW12Tk68?=
 =?us-ascii?Q?raacmjdRD/0rxSSIjDn2/u8b9TQSxNMyXFAjk4KTrikab58WQB3pZe5jzsdx?=
 =?us-ascii?Q?YGKy+hviOS/H7Wu2Tf/QA+R1vyAKVUdi6XjieVslqc9BvxvkdoK24DdBBP2v?=
 =?us-ascii?Q?xmOcSaDp+EAH6csVI86J99NnV5ePwgeUrWHsEVHe1Aiqq4cBFGPfoy6LZL71?=
 =?us-ascii?Q?wbbFE69gfsoXh9h4DbRQPQF88iXAuIIhvrPukwPWJFP2xKnotjJG8xQdvxPZ?=
 =?us-ascii?Q?1HrK1sEQOrD6c0y5NFTRut6hNpll2rcudvAbbUSGi/MVA276OGCCSw1XBHQK?=
 =?us-ascii?Q?npKBGlila4et+HrhjWG+J3qb/ehIb9fRFJFEanWI7M5qbd8xVpmu+yZ5MQOS?=
 =?us-ascii?Q?cNXo7ei89cL8b95dKzAzOJMKbj10AWQQieZxLJFrf+c+OgymTeBqKOMY0kNu?=
 =?us-ascii?Q?mWgMfCiI36mkpcV01HltNt86Z9+TckgOlj0gNDNpjzPLDJxIDHguBLnMmG3d?=
 =?us-ascii?Q?hSJVHhZGqXBZx0DXdEsWza5Qrp8+BdhObO7YFGidxCBiSvBn5v2ybQaSrTsK?=
 =?us-ascii?Q?QN7AiesGy19odMjLv85wfze2fZxYuAdyxFYf7hkF+PbelDGFwfPjWmRNf+ak?=
 =?us-ascii?Q?s9Kr5vFdP9s58utTfxFXav9spw1i+X3IY5y32SabDGvK9mBtPJAw/uLzA3AR?=
 =?us-ascii?Q?nbQLff5OMoSe5g8SfWAVJFKaoXpSY8hKDe8ilX+Os3cA+5A8/BpfJYYSSjkn?=
 =?us-ascii?Q?dhzVRTZKkmSueYpDmfIB/E4CZU4VI9VdXtBeYchCaaMnyz9WHqq7zSj2ABwr?=
 =?us-ascii?Q?beY/uowlMKLYfNWkFZXzR1A53hY1X8FM6HZb6F/6fOZu7JqgXgQKpko/4kQE?=
 =?us-ascii?Q?duQCnFycaBC7sn8bgGqo9V/ubw6vj4HTvIy5UPNJQvNOT22JIZlelQifT9gq?=
 =?us-ascii?Q?t0OIlxa50YosPLb5l7VK8xmkWoTX+pCIklSUJPHX3ftz0x21YGb526whvbUW?=
 =?us-ascii?Q?FvwjIV296v0VVHsXGZOKt+IoKnJ3gYv4IQqWvvMDgsM11M6Dl+8/fkV2UvAj?=
 =?us-ascii?Q?UFvpm53DDe7kJG007HY+ASXt7gL0uNP3bEBzduQ2wHeOWas7XXt78C8kWfiv?=
 =?us-ascii?Q?GaXZhSCBRpDLK2tOZye52qf8QKGFVWQpLOBjwHGwMF0aRLRblLn5wAUB6MH5?=
 =?us-ascii?Q?JY8Fz19ywcOSLZErTRL4p1IvCJdY5yoD5EXdL4WGov9WcK72EIygbg5u8FgB?=
 =?us-ascii?Q?gqCQFk9Xsu6sTuabC+59Mr5IkryVpKs126sK6Ba/CYMLy30m+ioQ2nZ3nG5z?=
 =?us-ascii?Q?ektytxoPX6FCwH0TjByoXSQ57Sdb6VTlB+BvfVOSt28cwGojAVg2HuKDFyAf?=
 =?us-ascii?Q?boDbkx1Hqd105GgXo5RPoMYZ34bnPsAHKKOyP7iDqqRACf6p0WTRqgRIF28g?=
 =?us-ascii?Q?bQv4KzBmmmAL+xtu8583KXCSgdUQB77Bsx9XAofn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa69bf11-8dd3-4946-7c86-08db8c1004ed
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:23.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDQU88Zc9Ie8xaY3LIVtz+imQcumzRoBFZsqFB4Km7SPkbN2uNC6AFJYa+ppQhXOeVevJrYHr2XVuJ48FpESug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

Use blocking_notifier_chain instead of atomic_notifier_chain, otherwise
below RCU complains would come out since unregister/register_virtio_device
() will issue mbox message (mbox_send_message() is blocking) again after
received M4 partition reset. Actually, no need atomic for notifier which
is so tough for user since this notifier is called in worker instead of
interrupt handler directly.

[  389.706645] i2c-rpmsg virtio0.rpmsg-i2c-channel.-1.2: i2c rpmsg driver is removed
[  389.767362] Wait for remote ready timeout, use first_notify.
[  389.774084] ------------[ cut here ]------------
[  389.778729] WARNING: CPU: 0 PID: 397 at kernel/rcu/tree_plugin.h:293 rcu_note_context_switch+0x34/0x338
[  389.788131] Modules linked in:
[  389.791195] CPU: 0 PID: 397 Comm: kworker/0:13 Not tainted 5.4.0-rc5-02977-g08f78722f07b #26
[  389.799633] Hardware name: Freescale i.MX8DXL Phantom MEK (DT)
[  389.805481] Workqueue: events imx_scu_irq_work_handler

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20945c6..4408f150b3d5 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -42,25 +42,25 @@ struct imx_sc_msg_irq_enable {
 
 static struct imx_sc_ipc *imx_sc_irq_ipc_handle;
 static struct work_struct imx_sc_irq_work;
-static ATOMIC_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
+static BLOCKING_NOTIFIER_HEAD(imx_scu_irq_notifier_chain);
 
 int imx_scu_irq_register_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(
+	return blocking_notifier_chain_register(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_register_notifier);
 
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(
+	return blocking_notifier_chain_unregister(
 		&imx_scu_irq_notifier_chain, nb);
 }
 EXPORT_SYMBOL(imx_scu_irq_unregister_notifier);
 
 static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 {
-	return atomic_notifier_call_chain(&imx_scu_irq_notifier_chain,
+	return blocking_notifier_call_chain(&imx_scu_irq_notifier_chain,
 		status, (void *)group);
 }
 
-- 
2.37.1

