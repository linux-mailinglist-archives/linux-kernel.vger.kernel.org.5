Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9C75EB8A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGXGeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGXGeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B109E5B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ3eWjaY1f2jz61C6WFlc79HnyU7DTZ1aEZ16nJ7L7d0jxrFjQf/6c82Q12A8szVqSmraRZ39TVKwnuF2yk3jo2bGYseXfreqYZU/f4kFL0vC1eepHhNEm/FdBvTAkABjCWVHKB2J+FWT2kP8cDEktNSlAqXyH0JMaXawGmgbZ0J/dl4AyEU2CQoq1qakrMtKzX4PBQCAkLSPj2p/GMecz1GO+yDwUy9kNtxqAgbxQ3t/WT5MFk+1QKCKdINOUQRnFPmtZVjLvO/omByQmjNgZTJvZOwjNGT+0XcwRPrVo7hFJiU/J1QrHAX2boaVj/b9rf9H236BGI8NuCtRXvMcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xF7YcvrLeflnmBZqefC7mAh5r3oSgvlRzxrGndDQlnA=;
 b=YrrNA5zirbysotIjyVdDWID7vPJCJXGx3j4qza6glEAEjO7IktpJU221wMsvLRjNPIsh56hk0Cd2TRp9bP8n3BVhvZ/YabIpnEF/fPlx4SKS33RVGze/6hXF311vhhJ5HyIpUA/0YhI6kx89DsrhqP7oW3ORrrpBZP9z9UkwRzmt5JFjd+Zl18H6zjVO9ixU1cX7vh86oWaORGEWwX5RFdBToPiBrw/v8dNfDCjlZwy6Pt5T/Fs+Q4rcSkWibZgPaa0IL+NKWEjTFrzUexmH85UblrD5L4X7qljYMkIbsAnJhWwYgb8Fj4Erw15SAYLZ2pkYpBv4rd4mQam+OlgKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xF7YcvrLeflnmBZqefC7mAh5r3oSgvlRzxrGndDQlnA=;
 b=Wbcnh9Ueq1NsPgyjWlOPKUgusYR/tGyHbEWnW5A6rfH2aD+H+r/H99+PrjFWNi2n0VfIUbWw8JlKKbIZY+oipeCVHR1Tb0EYwqPZD3atLQPK4PuGKBxPZnxUnZSq4nHADHxyVlblHWBe2opBfa+b+/+TV9rHPQYtm5rFEjkM3a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/8] firmware: imx: scu/scu-irq: misc update
Date:   Mon, 24 Jul 2023 14:38:44 +0800
Message-Id: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: ef8244a1-136c-4b65-30ba-08db8c0ff9db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p5EjNIsDX+ZRRJDEQZrsph3QkqcubcfAOhWzeG4KFFXVumc5QV1yiU97ea9hg6D7PoNzFF1OEBIVoicYGJkOQUFDmcn6t0NADNhNfD9vxbPSTpTqyVXvvqQIJN6jX7muz+7R2Q+ZLZ4rpLznwQw8aDVI16u0awo3TNKBR86k3qRoqXFomjPY6STN9VO/Dir5d6nkCxtEVTKlSWPsdBK8DXYMhxVfmtgGpijNKi+DkCo/MUff3KLOU0DHAnEOvfXcsVSbNLVO7M1s1qwsdOpXLB/Y4eojA+lJkuFDe3JpSOmuCetFdBNMyCLt0/tU50s4AfKwM8QLro87w/lyrrBqbRGF4CH+hJf30TklwRaLl4+yWKfVBLT6dXrNUkXL4o4ZcULXQ/XkPS381w5pzqdlwU2ZdXqmfT9cmKSbVd83jzsAkmBGQMOsmZQwM8GLaU6pGN0wqlE5xGpChy9pNW4k/IVXhvp7WauuC/CFz+HYMORh0zO7aAwtGf6Y2e5qQTzG1/t3EuXAV7e7gymOdbCmR+nVGYaWx+ib2GDzq2m9CGLcLk7ogv+/WUHUckIia2xNwGiHuRv5l0oM3K8yDGkL9oc0Xp4NyGLG36livKgYklMD+4EKQ/qQtRe8+G5mtGsz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(4744005)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWQjPKbXhxZIRyhW+EZqUtQIEqkQidNtGRKMvcu3nOa+ArD6NhDjT26NrgRj?=
 =?us-ascii?Q?tdUOT8UTAad4HOdcl0N9v/Nf0bV7oUVgiUIpE763RgPvjtWz8/xNtRrYvhcz?=
 =?us-ascii?Q?vP7/yV94WvkkwS8Sk6qe8gYdo8vVqmyFSpyls08LsT/cpP8FZXmS/SB4rg2y?=
 =?us-ascii?Q?IehCAntuAPRb4FLZyu15hXIx3Be+U3lDFxCJtcpQ+iulpkw2o66ZDIfCbebx?=
 =?us-ascii?Q?5UVDUVLbHwRdxDuOLBNKrxb67Oz+JCBIojnN47+p+VvHu1sPE48MhpanNPTH?=
 =?us-ascii?Q?Y1LS4E9zC1JnfklzXYT/goJ4Psh9YxfxgzZNhUt3nVt7zFdATgT4uMq/AWKO?=
 =?us-ascii?Q?cd9JUf5OgIMAiI3oNgQIZsSlsIjcF3A2pfRmm9L/kDbqqDvU37yVca1oUPcA?=
 =?us-ascii?Q?zsxQPpR4Rg/5AngEiNgee5r9Gg++aU5aMyd6i6fEyhBpqmAdbVvRwTD9MSPT?=
 =?us-ascii?Q?CORpl90lIbOHJSBFBkxwyIMheHrGpa4YopSZr8WdFjCdig9hLOSeKbWfO2WQ?=
 =?us-ascii?Q?g1Pi3ZMbAwTqBGchPkPfGF2T4gnisAx9pmCnHaSPxW5C6MqmUX9LDVTqfk3Q?=
 =?us-ascii?Q?lm77h6ayHmRMlTolAgzMTUo0nspQRt+ZhlePOYWjg4p0+KgBb8ulhcbeiHsF?=
 =?us-ascii?Q?LIkYMg9YZSoqjV+vOkEPRtpg6atFN7WsjvWuiTs2yoHA9SjoLqj/auDakOEx?=
 =?us-ascii?Q?iujpXiLkfr7GRNwbZKD9ygyFskK/QxrBiEV5OuNSf+XyhqbbONh/6DjPHZ/5?=
 =?us-ascii?Q?cdyfiyV823qepieXycgv+2B4zWsM8nWXwVg1yI+A3KHbQsiDc5iRNXdyKDBe?=
 =?us-ascii?Q?9MF+ascJ/UJQdnCpUmfaZutRLl4HrRS7yNA/2yFFipIhChAnc4zAWcmwlnwM?=
 =?us-ascii?Q?iy74/pxaTe5D8yb15CNdL0vErk7KXJOV7mBe3vbQ77Cw12EUIKSVGW2F/V34?=
 =?us-ascii?Q?/HEbuTZRxsu2vdIXbrLsTebhEIMOnsbPl6hEd5ecE0fXzW4ADOSw9FTvR5Aj?=
 =?us-ascii?Q?FD/n7iaD0/14gZSRCceEDPKca3R20V4UWt76LtLyV2iCO0/Y4BtSXy9HIaaF?=
 =?us-ascii?Q?SBtW7aqHbV61FDFaAIF2f+YGFv04WW4TeQzykpkS2wWhtjlIawe0gF1FMJP3?=
 =?us-ascii?Q?J9529dcx4wWjWohUoKeFbOk5uRcbQo0uX/mMueH5c3QCiFTaoWQsylpevliv?=
 =?us-ascii?Q?QFcvK7dDzIhXvKTVSquwDlfksah23bWrX4xUXxboJOC/2Dr06jyaICxpehGe?=
 =?us-ascii?Q?RnWOYQHGKwVJ+VX/kc7X6XM4sBtskGGCLlSZWwwLH1LpgWbXQPgrP6GfkdJT?=
 =?us-ascii?Q?oFsOfoy3bCDTTCWJzBsnZXkyj7SdO6dt8ThkoR4jtGOf8i18LNVFnL1GCekR?=
 =?us-ascii?Q?FLJC74iFQoQlawYDgQROuC9zZIyxR/OX1kddogdqYboOmdDePrjOt2wEWgdq?=
 =?us-ascii?Q?XCIS8lVHlO6fh3H1mR9Hpuk8OX81lUX/1cn61Mx6x1NpmGzXh6lci7ILLmzC?=
 =?us-ascii?Q?x+X/4JO53TzGBmwyw/SrL337gdg/UGW0PXyY0DsxCupW86O5yuFz0aBTXcu2?=
 =?us-ascii?Q?wXNiAXcGiNNTeNUWnj7VkIyDcUuf/B6yM63IAaiq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8244a1-136c-4b65-30ba-08db8c0ff9db
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:05.0523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP8UJJ4EOmR3u09+sJqo7hrlt0spgH1wwTUBwNLjFnkNKs2SkEFbpO5KmQXeGtl6mstHnQoU7BE3lD+KjiTxqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Add static inline for irq get status when SCU not defined
 Drop two patches wrongly included

V3:
 Fix build error reported by kernel robot
 Add patch subject-prefix

V2:
 Fix build warning


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

 drivers/firmware/imx/imx-scu-irq.c | 116 +++++++++++++++++++++++------
 drivers/firmware/imx/imx-scu-soc.c |  19 ++---
 drivers/firmware/imx/imx-scu.c     |   9 ++-
 include/linux/firmware/imx/sci.h   |   6 ++
 4 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.37.1

