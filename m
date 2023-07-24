Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B676575EB8D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjGXGe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGXGeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26DE64
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDgpRtPlNFOgDYIKWWqWvecBZCUTfmR53yiGc9ovv5P9ix4QOLKJGIE4sMNs/v1MTh8c8UL41aIK/X/r04MO/xzDH9iZ08Jd61iQRzsJlcLqypXkOOSyW7/9kT25/eHPAWc2iO57w3hftPqx2UF9tjmyYsRT/e9J+H017aZEZqsgZWUunCinb/w1M1a5jZGJM0CAwlGLDi7hi5bLLgPfLFkfcpll6GG4Vh//M3jMaUwXOB52RmTZXlB74OJIY9mtt0SnPvLlLQpm4Iz5OUKw8CjpQlHXMX8dgZ36QM3trL/kxmqmgSkfB+QLbv58xdUJtfysP/H3uu1p32g3LiYvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=ikvLxliRN2IaHNZXGzyNrNc5rDqNOpor2ISnYRK3igD8FKUy6IaLfXqmhWfFzKMe8Rsc8Y6YiQkWW+d/uIk/3rhcU8b3WTLsQMfj3Y/+P8DogfF8Pzdbrkfp5XaUo6m2LcT7PfhSJkxR3esXVuNF96se+quCLkJsJN5n8doNi4Ux3GC9UBxwshol7Wi0iaWUeorc57+J9631ij9ZqAeUSziuXf6qYaBbU5F56ozwbv2GFORgknPs5rg2K+QH3MC9hxUXz+6Zau/xbW3FK5EHr8ir7bPuvBUVcyLhdrI2x81nXRTL/l6QsoBGOSfkgDjDYiCuxuac/OL9MGTwc6CnHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXsJHj1jKik5zS42sb9oDfVAHK3/hCH/diRSXT4zP4=;
 b=izgOUfHgZnsdqWzDzx8+0L+uwa+evhDRxY4aPIxWAWrLSeFJYmPwu6fn4/ouGDzLf/j1RR9Yq9FzEC8YPYUcED7m0VwvYBG5pRqCEZW6MOo8yAMFIftNn1C7MYYdx6x7AVH0H9kNx6Ayif22Pcwy80szQ0e6PGRk7A0aoL98hx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/8] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Mon, 24 Jul 2023 14:38:45 +0800
Message-Id: <20230724063852.2666930-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02fb4307-6b68-40ee-09f0-08db8c0ffc5a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0q5u5OOB0DvefITnEulbUU2r8DmCjW+bYA0g7TxpmvgqIXQDDWjz0NG4ThCtWXiYliAbOUYWnhMxvjlR2oVDYhiXJGf7Ug+2ER8+KoE4YJV7bBRoEdUt9Ll99rLsG7zEG7kbHckdUSyFjBlTE18ZVlMQuPcYy7KhcQA51oW5O+fl/UQDwvepF45xc9koATC+4FEdK8O5O8+ZfOJmrLp2366WMnzlfGJv/llirWT3LkHdFQASw9R9m3V+qdRpfAzXbbzckKyolW3Ch9rZaXRrvTO/fEm8GXyuIkPpTCRYS1kFm4PjYkCnAkY4aiWLZBXCZOADVKP/6BMSYDSBsxs5J8U+fWMX7Frqdw37QLVW9udHtZnlRMwAcIXhBAnLrDQPhTxDrhCzmI2VDVHGHSkW7rqmqQqtJlBoD2MpTUD32ovCnFlYnl9fCA9GqmCTCeS+jXF+ZBSQkc9mh+l+QOR6X3EzgnQK92tm/7LCsosR9E7tvPpio60vqzSmfrvE5gudF0Q7jAHcF/AVqHjMmpfDM/R5n6z0KHxwLE+ZleMpMu7wlqTk18/OjMD7TEJ8+cuMOeHV8orqU/xm09vKhonmVCUWtx/m3VkNXssaZ+e/qqwb9rH1GDf0LQOriS4a97vB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(4744005)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H99QoDBwCEnt0NM7tYRbg9mPhtAf/br7Jl+Nn1TkqfxpMFUSmxP9Oer9xkQH?=
 =?us-ascii?Q?m0W3OENne3xBEwwnlQD5nSV7FRHQoSZqDWdyjjMmRRS8avRlmQZ1bpPUgxt1?=
 =?us-ascii?Q?9fPBO6nqfkXapBQwKFTDMbNmWzFtwMx2T6eeF6ehObm8kV4EfbkQhMJBFAId?=
 =?us-ascii?Q?jFWkwU6up6ImnilZokJcd4OzWttrcDg/bGhDjNsvrVpg5QasSTMt4Hu0lxMI?=
 =?us-ascii?Q?0DfTZ4frN0OpGUkjyDw8t5k/PMLPyRN9Eh44T7Sd4r593AD0o83pp4g+QfBu?=
 =?us-ascii?Q?/izjBmUho8GboAyUAPp2QGysnASo9qm58u5rhE8GPpzi/GHYfOGD7MOfsfFZ?=
 =?us-ascii?Q?sUpZw6EjUj1hc4nqhYwjZROjrmfymeWVZBklj+Fg0VpyegHE/JcGlf/YXaBn?=
 =?us-ascii?Q?0K6zQZ4/suzc+yf+tmbA5LK0vH4/MsUGGKrCZ4/MAwWGzs1m/bXM0m1UdDnw?=
 =?us-ascii?Q?ZT8ld94gatfh5dJW5dnLxVrALsypXGO8jK6tDtQxSXbQBp5tBV+ufkDO/3De?=
 =?us-ascii?Q?K2GLiLtjw8f10wwnHOJokBO6LDqOPbwwxWM1QUpy9Wdku8IM+Msjw8ez5SKw?=
 =?us-ascii?Q?eIxwv8vjw8RCI2aT9CtI/JnkUrPPd4PcMEPxV6RFnCQmA4gHDjbk974uOxij?=
 =?us-ascii?Q?POwYMFGSsdrfxWAs8sqNqgu8Yf/Ka0wnhINjclSrft56QyH3AExohliFYJHY?=
 =?us-ascii?Q?rNIo35xMkfz6nqX4qCgFMcXFGcqk3fPmmaivj0DoeU7PiBWXapBV0rp5Bt5z?=
 =?us-ascii?Q?TVi8fG3jJnRVO0zt3n2n+SyoY4jo5tQdBuOEd/Z02/clhEDXNujst7bIyF0X?=
 =?us-ascii?Q?vQ4dIqLtude41GkdkoikPHCCR84KwVbE8izrcYQpcj5n1AhgFRHtn8sRLLDx?=
 =?us-ascii?Q?2fMsuewtnLlbVb7K8GOeNIJOGlQWBPoZEQcxdpj/MNrTFLwtL0VVXEpNTwWQ?=
 =?us-ascii?Q?uI9ksFuiSNNRqjqT3ihFx3cNAexyUQbHZl45AAxt5c1MlJecRy2iLNnOwWz4?=
 =?us-ascii?Q?C/E9efCBJWJowpbalk+gXsJyJBp0oSuag5sHHrR2JIgX3JFPzPymvIpQ07TS?=
 =?us-ascii?Q?VgR0uVRpwhaFsBq27Iv7FwFWWyycN5OtCjFXJqxYP2dRc7BltOafTwZSOjSs?=
 =?us-ascii?Q?E4sJ2di+yj5fHDbuB4+NrKZUM7jAYA3duL875XU3MPv1a6KR6jCTkSBRUcKe?=
 =?us-ascii?Q?nR1hT3in0pxVd54CXOZTnFFxIc6AaZ2M+VNp65f/ZapV/yr0YS97nG3IVy/6?=
 =?us-ascii?Q?Z5qNsfw+xBJpfwXnyddrgucO4FqvDY2kz2WtVx6AB+G2uaFDLXVR31O8z4Vo?=
 =?us-ascii?Q?DJf8GDTm9CBIP976VokRsm/D8uz4zpdk1tJ4C4+SwyfiC4gq6V17exNfb9nV?=
 =?us-ascii?Q?JpfhSLEp/h5x23HhgVNsM0DxgNe9DwnNFYXLP35jyX1BUMIb6qh/NSfj2dS9?=
 =?us-ascii?Q?DxUSL/TlKe8NG4iBx1669PMFPYaA8ix6fe4xOC7LMQ2dG7liZfpQHOvbFPbp?=
 =?us-ascii?Q?z0ABVbQDo/q7QRg5FGNdNxTylbd22bggsMm7+kefR+dpLqTLF0pudYQzBvkQ?=
 =?us-ascii?Q?A9zXNjoX64go/4LWKioTVGHMg+getX/6khb6lU3g?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fb4307-6b68-40ee-09f0-08db8c0ffc5a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:09.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sqy1fRduoIQkrqVhNvkCIvKDcC0Fu09YlWWgHSIviRSrCRCnKZ6zWntxkXwxxtRxXnHG/e0hMLXoVLR89sLeIw==
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

Change firmware init level to subsys_initcall_sync to ensure it's
probed before most devices to avoid unnecessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2d24359420d8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -353,7 +353,12 @@ static struct platform_driver imx_scu_driver = {
 	},
 	.probe = imx_scu_probe,
 };
-builtin_platform_driver(imx_scu_driver);
+
+static int __init imx_scu_driver_init(void)
+{
+	return platform_driver_register(&imx_scu_driver);
+}
+subsys_initcall_sync(imx_scu_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-- 
2.37.1

