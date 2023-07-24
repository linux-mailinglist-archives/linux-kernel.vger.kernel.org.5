Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926C775EB8E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGXGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGXGeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49B8FA
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFuOPF5cUORLb8oOjD2o5S+0vEUwBvAXcHWvQPmKhwWYtdjpH+n0JFkN7358sp4j/KXSslYwfN2UpLU+39QpomnJZGSOeupN5q0mmdTFCqX/0m4eNTYXTq9ANHn8LvMPpWjcb+B1OIetTizW4Pod5B1lOMUdv3fWNAUs0WzSJ/+eecJLZVHkiE+1aEZaudJaMmoo257slQrurFZY04Op9dg4JgKeAYy3DCkXfN94Vi4Pf6X1/8o6XujAemelt82B/8umjQ8ZIn9FtC+Z/7ZiL38uSE/RS+vqpr+eglzDwJAQqigDAi4PwApfbTKUkb7Yl9n9QI9TT0LfO1moWl7LhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=bFMhpecc++RLeLjNPaNJTKHd9vkFzQ8KBNULmTa8L7uOL0hR5RPiNXCfyMfJ1D6SAJduRTJ2+fWbE7bxi8wzMf5VXZXrHXCcmPuhEG+aIjKp7mUOu744wyg8wMwnD66gLo7PM2hlcEtik7c8XoQCPbCtQs0phipt8Fci65aneFvrebYhPDTkieLXHwWdTiY4aoJRoSqVk22l/KwtV+FZOJhQnmkFuSsjEFU6lRpixz5f1gtzYJ8hO843wjhG3LD1zeAEVYckJScLd/MYYCCToA1ul6iMkzv3dLP+4BtT5cE6xQpnWJUJmfAZMpBPC1pHHrOVw2Msq007Ia644ULscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF948BRl8NffqmzXY2ZKiRJwHdKM7ujns57fiU8YtXw=;
 b=Daq91PA8i+j5FLo2Kez8Cqhcx4g+fCeXy8ARSY3EPDXY+i92vkcXu7uNjW7D6nZnJ+dSVmNxoOlqnPulkvATFClG1yRfgiDO8yCFoqycC2Yqgr/pjwcsIau5KQdm3mnSRimdRYE1mseaJ9U9Ryu6necBF5dXu4/fJrb4QOO2qgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/8] firmware: imx: scu: increase RPC timeout
Date:   Mon, 24 Jul 2023 14:38:46 +0800
Message-Id: <20230724063852.2666930-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 615bb70a-6fcd-4113-9e59-08db8c0ffe6d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcVNcZvFn1e7Z4lVweJPkWSwxjO5ddQalN+g0v42ZFckabcMMEANuePZrF3uPaEXlSwcYozYecmu4jF4C90lWoPPOmzS21fzSXheoVzvTvnJ4v4nUtAyccKTnSCKcmuhCauviOWY8yNTVdilIZ37hEjGRe6FL/+VZ9fK/tR0zZLFU2s6j8qT/IFEhpkatupObuJdiQL8a3obRjLt6IEO6RovJEdNIsWHstS9paMjgztyWN5hSI7TFCMuLJh0gVSzqhqaU60t+Q1wx0hYgr7tinsNvnuziGjRVqDPS6dfLVYFAySUim1DEvJm4vRUT3cX56Vw4O7Q3nR3Tyh4e/dLaxHXgBnQj11gImVOChxg+PtJhW7UoXrrdITCNbw6MHbEfkwX8LLmQu60OMLd/ZmPWZdYKOHiSl727mOKYM4mxJe7Kbvsp4d8h8wWSfkH+BOmR7tttp+egRKzHLF9j7tD5Z/yXercRmqRveGGuaxMxBggIqHhvhAYeMA1x4/s1GZ3RwFev/699L6BX0mkVFxsYqMKlwg7lQxV5Mv/AjehvdRWj9BT6dCqa1y3Ki/D+eXwSdpo6kluD2OGDaPwo0azETzWckXBPjgBoUzxUD+0RIdfNoVlqvdBCM/fKiwDOqRO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(4744005)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGpeK+ka/BrJFWzoC07SniA7UoE8G2bePshdGFnh1AbSZovn8Y7BFNe6rY4Q?=
 =?us-ascii?Q?Q7jOu/jeHqYTFH9KLeQHrwVNjdMcdnsFIB9Lw7epmv6qu6Np6DLIYRdKKwry?=
 =?us-ascii?Q?nGbplk5T615ujTvXDlRcR/3Qr/Ax8npDAIwgMqSry3iEmObWAmgKZgaEgqA+?=
 =?us-ascii?Q?+qTed4cDNPpBPDvgCuJ8GCMuS1i4X6YwqWOz8LSVZ3+tqmG/nGCyNgroGiPO?=
 =?us-ascii?Q?0sacVKQl7NkcADNjVQmIdUIcl5AlBDM3k0QV79dMqbPjoAiI3BAhbwI71vsb?=
 =?us-ascii?Q?oKxm7NTIQNnZq7oqjWuTScQmilDGcKMuVRMLYUkjX+SqYzMi8c6Of7ye6Xyb?=
 =?us-ascii?Q?e8QLnOwD/yNK+oIbGete+TwCfL0/yDQ7RgWVHrw5zC8Ow7Rw1EGPxpFrd9Nw?=
 =?us-ascii?Q?/0b1a/mwYeuUflJj16W5sn7A+1aqk4U9m6hau0gD+i+1CF9rgs4vS6SLyevN?=
 =?us-ascii?Q?VPvm1q2h3ctCqllrCDxV+xH50e7vHfbSjqpbTa99Mduk4FxaZ1cHAeS4M3ny?=
 =?us-ascii?Q?gPHT+pcaGrwz2PjybmlYV0wCqwOzJvxGIiDGbbUOcJlyzXe58dLqaBdMcUJm?=
 =?us-ascii?Q?u2EsVmer7b/vnBszpKlaBjv8xQKdK0Fu4wC1y08N31X7UFVGtQVHFt9QhPLy?=
 =?us-ascii?Q?xxinVSgeLkYtbpMZmeA1++0Pkg8ZK8/5xDQ+q8GU3Hy2PYqQUxgkdu2wTFzU?=
 =?us-ascii?Q?IliApVRxtjtj4caVzUjO+BguUEdZUAkYOFP0i8jVRximrbIRgZnMmAhCmO//?=
 =?us-ascii?Q?UFpbXBb2F8JNVR9LgH0Z1heI6rbBOLqLdFqPn5efW7RbnWwxC+EET0fptJbN?=
 =?us-ascii?Q?b86mmg4yqlVMS8Z+I0/Vvx/xxmNvHZuf/P8dInoaIQT6OlsMxb22VdI1ayvP?=
 =?us-ascii?Q?dsORZCHbMYDU/odc76Dd63db+8QEgTkioUhcHhSO6l/F08TC4E/tH3+YTcIc?=
 =?us-ascii?Q?r0QOc3dtsUngQCzSkvLb0JngK81QmjGv3gGQw2jKnDAqa7KrQ7a/YYi9PyCP?=
 =?us-ascii?Q?oec/dahhcES6Q1xcE/ZFCgDiyrsZ8qmSs/8ApFbASz3Otu5QFl5MtpMlku5M?=
 =?us-ascii?Q?kXi7ponrW4OX4oUpLEGDM6BnA2EPpKlZhwgDAasVPT12mf2Q+1x4JGjyb6at?=
 =?us-ascii?Q?7GS2SBujjtTmeU+on+WlHwjlqz0Fx2Uv9d61YopBNHXT/KlODAc3OcuTxa6f?=
 =?us-ascii?Q?Z+0DWxDYlUA6i7FJIIdO2m0cA0yn/JAQB0g2m8DoDgDzR6MtexMjnnx+vmEN?=
 =?us-ascii?Q?PFGKCvXnarAMMZubEj/mN6b4mOXqX1rp+JAyCx6uSqQrcYsnpIH3U1xwguYH?=
 =?us-ascii?Q?ByZI1j10Hco2c5qbNuDQN5T6MtcO2LqO5K4DuPfwXAtE8Kcc+yWCiaqLTlNR?=
 =?us-ascii?Q?b0gu5xAVWfPmtQGeJnJZ+M3oq12o2nyLc69TJKyulFD10rB7XlAN9oq/znNP?=
 =?us-ascii?Q?1xq4Ajx6eYAPZUJRZj9Kxfo7fDgHfk8eBVfsxfB8srkFVjLM4NauJ2en32PX?=
 =?us-ascii?Q?GGR+fXVD1IsoUQnQq0BGlys5mMlBhXpOJQSbw6Qz+QmKZ1cMI2TdNMgeaknA?=
 =?us-ascii?Q?2u2WK3SrQx0LDRVIxhR40LxXUAnTmsgK3qZSNXtY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615bb70a-6fcd-4113-9e59-08db8c0ffe6d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:12.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6PBiqefi7HbtHiqggxESYR9Er1E0By52X/KDH9s/O1Hl4ecgfsrMibpvYduiKUszv1U8i0NeiBGgWdVMkniFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

When system loading is high, we can met some command timeout
issue occasionaly, so increase the timeout to a more safe value.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 2d24359420d8..14ff9d3504bf 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -20,7 +20,7 @@
 #include <linux/platform_device.h>
 
 #define SCU_MU_CHAN_NUM		8
-#define MAX_RX_TIMEOUT		(msecs_to_jiffies(30))
+#define MAX_RX_TIMEOUT		(msecs_to_jiffies(3000))
 
 struct imx_sc_chan {
 	struct imx_sc_ipc *sc_ipc;
-- 
2.37.1

