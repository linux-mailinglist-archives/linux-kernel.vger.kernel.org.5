Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF3FE75AB18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGTJlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjGTJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:40:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204EA4EF2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NI53wK+sosQRnn3KqwaiJlLgLt5XOV61AG+WhlcgdA8vtsRXdukMxM4bRRu0JM8Jn+udGe5HOkOWtsQYTSgp/b3TogtGHHS6nPQ2iiI8E8ZnB4JK7C4DeRjighqetic5nGhW9muK48quzxSPsdnWJqilqy6EmkRm+5sj1cD5fsFV8dIW1D9O3YJjWxzcza0/UUiTfjVycmziWpFmYP0/qw7VAMytG8oOy8f5C21gg8zYWlndqxWOw1SoQFVaZcUkc4h2RBREiDR7Pn2u6lsl+vjHu71zpN3z8Cw9zl2RrDtFHAaxBoddwqxG4qsEgJB3AmgZbuVmr0NgDbTCVle6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2WETlg8N5L5x/1bG5+IWidxmFfX5fIXvq/u3VGHeHk=;
 b=m4h0GTGV5atioAxtYX5bHqzegDjViVrvmh3LZXr1xYmwtrKD3I3x1GiBM+RJ1VGJNTk16gA0vAy5arCGD0V4IbYkSMSgPBw7fGQvfGOqsfKDBkoWTuYFQ+s8WbYOm9tp15hgpRYjRPwsnwExH+pEI5V7WNcUrwMsx0cKkTa29LgMavUEC+HW1Z+8cNQj3eHDpxwXgHuJGxCuDR4QZhQ7JOpoU+gHgLuoTrZMzu9S9UcMAcHQCTqjBwlcE/b3q6St+PkdKl2kBk13+WaeXsDGTjBcoPTeWBoRoGdTFL1/vAOv5PI3pYc35792cqHPPOxvowyVH8ngvCedLaPHt1xt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2WETlg8N5L5x/1bG5+IWidxmFfX5fIXvq/u3VGHeHk=;
 b=jEJzfb9YYnd32ps4moxdgWrX7lSvSLnk7Elo/eVUQ+4Hdb2Lh3QufNEsLqspWoQ0TiHYyq+DL6BHddFWqi9JiKzCeenbiQAoNiqPIWtFvAZcMmo/G8n7OVmfME1ujWqjIwBZI4t+X5KhXTWC+gN+XTAgOS04HuYSFEVQFYc7ENw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:36:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:36:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/8] firmware: imx: scu/scu-irq: misc update
Date:   Thu, 20 Jul 2023 17:41:20 +0800
Message-Id: <20230720094128.536388-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 447dda49-5ce9-4e18-8338-08db8904d45d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1spYIUBbzffyoTd73+t4C6YgAfr/j5GTC+efUFt0ISeNyGzrMoXRanXiTLPonzKzbUdLO6rogvgzF71tgRWBsqGtFZ8AsIkSjcB5Luo3kec3bvZ3beqSNOLGQNOb6QBWZQF8FjoWxWBNvzhyhYWKD71vrjFjOYwzbsyYekcdjqyKfx3vOE13UEKehwvlnGHjfUG3fPK21933mS2ToTI78nGbBgqLitxkFLLrMYD6VJ5iU6S4SzSUqx7RkMQHvLlfACKhx6cLUZ/7K6SPeR/rPo22HTbWWzt+zXR3vSpDX5iLst2vRtFOYWu3ijASVrL5pmgHkkHSXSbqiz4/YZWjDuVHE8XbvFBYDTNCN3Y2isqYWRVZU7IUWPiqqYZJm/JdcFvPdysZQf10adqUqEfPTzT7rvhKadvaRaD0obKe6XDOJ2PK8meAx3UsmqYYH8O75GPg6IK3TskrLAg66m8WMyDdSBoIL+VpR5nbi9DUGnpKtJPMuFhF0kxTW1BmZV4uWX8iPVJKpjrKrsafN4vNyO/ms+dXeDb+LC2vklSpARTJlqu8S8SBML/Doktwcl8ya5ZkvHbAyOhyykrGk4e8528b54E6/A7vEnCjrGLIzyzdZ1aIVG8NKBSpsWuXnuly
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(4744005)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Pk5dvF4errsl9i39i6mAzOu19Bs9IPEoyWtjsYWp8zUGghpmAXue0pBcTJ6?=
 =?us-ascii?Q?85jGqCiXyX9cEzpMcu3twW2Et8HfEc17JHO2LZo2fmyw4aDC2K+3EulbAlbA?=
 =?us-ascii?Q?j+ue9hxjgzOkvj/vZ7vYTUFG6cq+Now87Zyim2/yrBI7QR7BJHhkCj3RETN7?=
 =?us-ascii?Q?Xj1bOrPaJciDFC1qFrGebf7FPe9+nHavrhCgNfeFZmeej8cvyPGZRn+7P74F?=
 =?us-ascii?Q?qaJb5kT257Egdv93pJ9PF7qrgeBZNJGJGp7d9leRH+1dmEluDJ2sIEWVeJqQ?=
 =?us-ascii?Q?j52MkJL2fLBA5nc9YgW8i6VqXbHa+fO3rr1E7Y0xtXkvN8cvJXvRCxugbEEP?=
 =?us-ascii?Q?QZQtJ1vDCN/G0hbqyW1O1s6gf405fSb8iPWnwLwzw2PzJRMuMQPQLiJwAp6c?=
 =?us-ascii?Q?EUlMgu0FUVTLckIM6A6hHKL76VSXRVoeaROfxb7ruTFov0M6P4Fqd+F8CulA?=
 =?us-ascii?Q?33YVEeUud/+UMJ5WltbY+otCCKPDmm5O8IlCL/WeZo54gCyUxOd7bqLO5E69?=
 =?us-ascii?Q?TI3v9mUc5ZP+vqskaiD27J3sZPU9vGQLeBbRxcWQ3iHtOkFDQM2KuAyYhKHQ?=
 =?us-ascii?Q?8ZxNEMHDuzKK21IIHWVTsY+DyYuNZmdZ7srrJYVRy7KGGg+YPgeGDt61X2FX?=
 =?us-ascii?Q?0BEWAg2iIFgqXzZBlKlq2dApsU8PUiMnZPp2fDFVswYxdvSui5JvNwQZBvQN?=
 =?us-ascii?Q?cB/kJhJ9y6riy4XXFpHN5lJbyVt3dtaqweNGnpfnjGAB/+DSQPGr6KVuU5CS?=
 =?us-ascii?Q?+W1IBpBFlm12W2r0Y6gUY4PAfqzLnVERYzJUxm+yqbv6iDepk5VlYU1YAiTT?=
 =?us-ascii?Q?z66JzQMJmxa2utqU2yf+sn6MfzlEnyXqn30rlHGFh4quSd/T9QtuVDxaMk2g?=
 =?us-ascii?Q?57Ms1+Sz+RyC0vBComKvFkxiJP85Ix0SPRITVs9hSSDhYe4UfKRHRlcKDqxz?=
 =?us-ascii?Q?skbfD4pbblkPINgqMhJkmVHhZxM1QFkPlC4x3jgQJG1fgFlXEZ5TxBeTH0Wh?=
 =?us-ascii?Q?w+X+irjzO+6+dDmQWGeJ139wQV7AZBZcMzxTm9F5HY2ohDC+SlM+zrVsCFhD?=
 =?us-ascii?Q?Ew8oh0gg6yt3oziHrbwsnvMhrbUxYuLkAQAjaBfUyJBgIimG2xoNtgpDoLvn?=
 =?us-ascii?Q?wmJZpu8mpK+KQ221MQdIZMybHcVRyOYuya+jxvGAJbSgNHlZVkmCeComceNT?=
 =?us-ascii?Q?KnpT95cUQ7Lbiv/vV2pXODjtVpexNZQdHhvzmPnZJ15T6/hhK7F13sw57pcy?=
 =?us-ascii?Q?a/WnaV6tso4Bv55RpJnh0fZWx6x6/mUTCb2TcAFPGY9qhJc6xkEUlJvbFcza?=
 =?us-ascii?Q?yWHVThQd3GbaoJUtdwrF6yjG3JjPKE6qv4w9qFpG9b8zBIGTne+8C9R8Yp2T?=
 =?us-ascii?Q?0pK7Z0CrVeE62j4XdeOXuQ1utGz6vLM66ksvINFDuVAr8J2JVMTf7UNrbruk?=
 =?us-ascii?Q?+wqwKyownDySe8d2XNcIcxR+elAICIhwyZpy3WREvM1RVU34P949rrYpSmQF?=
 =?us-ascii?Q?AoQyfLPSzooJsRMgokkpVbUblUVqtRlowyk4Y0aJiTAO0xJCdmTwTxkPlThv?=
 =?us-ascii?Q?cyaSaCMpdrFTgygUzNIY+kXaJFh8FSX6Rop9igEx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447dda49-5ce9-4e18-8338-08db8904d45d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:36:44.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeSCffM6XrMyRkaB8D0L5C6Fn6JlMPIPcrL27gVYLUzquGnB7DiJGIzTK3kOtSc82zx6E86o+172ObZvjbLZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
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

This is to upstream NXP downstream scu misc changes includes imx-scu
and imx-scu-irq driver.

Dong Aisheng (2):
  firmware: imx: scu: change init level to subsys_initcall_sync
  firmware: imx: scu: increase RPC timeout

Peng Fan (4):
  firmware: imx: scu: drop return value check
  firmware: imx: scu: use soc name for soc_id
  firmware: imx: scu-irq: export imx_scu_irq_get_status
  firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP

Ranjani Vaidyanathan (1):
  firmware: imx: scu-irq: support identifying SCU wakeup source from
    sysfs

Robin Gong (1):
  firmware: imx: scu-irq: fix RCU complains after M4 partition reset

 drivers/firmware/imx/imx-scu-irq.c | 114 +++++++++++++++++++++++------
 drivers/firmware/imx/imx-scu-soc.c |  19 ++---
 drivers/firmware/imx/imx-scu.c     |   9 ++-
 include/linux/firmware/imx/sci.h   |   6 ++
 4 files changed, 114 insertions(+), 34 deletions(-)

-- 
2.37.1

