Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8312975DC7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGVM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjGVM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 08:26:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64DD10E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 05:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2D67WbhRpJgFCm5mlgDmVB8Jhl58aVsTrRHM7G3GmS2zs6xA0+OcRNEQfaWi7L9UBQUtwr0Nc8JO8ZRtAKeGfUgvNcM1rFvdvYZbllvS/rS5ptynDx1GarS0ufcgy3iq10xEtgZLltdfN4q9MJNH2Dd5HtDGILBMQqZJqJYrHg1HnSSsYQ40dVSoIQZGj/aB5ArQWRZOng6IS5gDSWTlpYlqd2lBSXdGYq8ZRQ8ntE11LT+hu/asfF2QVyf2mavIc3B+QdtWksf+E05TFFJXg4gEXIirtVvXaAmr/4A3PW9GwzoJE7Ne8+vbUHXVSwmSwCI1JDfLSWVsR9PbOxFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUNfBJG7wzVoVecfPxyT5tu9q12kGvXiqpu1RZt37zE=;
 b=VPv5XUtM8n8kPaOv6oCrplcrYLTxnYd2fpFv99xnOKxxaLSqpxi8GYYsmU/pHu9FoK2q2+XR0IucjRti1OKfWIACBU0/kALnbmo1T0Xec1qLnBgYw3YVbQ+QgmFvR6OugFwGpixKdC4DH7Usa/Q5QXkLxzpQq6ofsrTg0NqQkJJbIqJUolX2c5a7GcXy+KJcZk/uY8ReU6OY0S1QwsQmkARCpjqkmOzhTPIlCIy361ycwYAR9ea3oJp2SUYzeTCknXBzTUNuE8yYrU4sdfDQm39TnSdxIWmhVE26eY4ygaO9J3jZEdrfER7G70u42yXGtUdiH2tYaEIO2xn02ygu6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUNfBJG7wzVoVecfPxyT5tu9q12kGvXiqpu1RZt37zE=;
 b=cxWcqpgnMt9ggrHov98Cg4lmXKNgGuwuKyPdDKUPPJXqWFACNNtAkxfeQ0lc0KJN5TS9hs/cfLgzNPCxeOjz6tK5ETdWebAzzwnZ21jTxBoN9znNBK5YYhBNMLYSTDpKiLAw6x/DHAIqABTmEj6gNM0lDsRsfnX/mZ/Iy3JV32w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.30; Sat, 22 Jul
 2023 12:26:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.029; Sat, 22 Jul 2023
 12:26:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/8] firmware: imx: scu/scu-irq: misc update
Date:   Sat, 22 Jul 2023 20:31:11 +0800
Message-Id: <20230722123119.1966998-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b13a4fb-eb2f-4c87-931e-08db8aaee37b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dD2zFYl4/ppNKW5sqBaFKrcX9QCjcHgbnY0haUEcRp7pZ8B7x9D+Uf7ytcjtVHJIeFQEU46XWdYynWLVCCrhbR1XoU78lgyijHN0pP9xfHnDwP2Tbssl6yzbzQsALc3cWqwlgcj4s3vHOmVN81agmltMA9Yh6fZatYDnJfzYUhhKMfbrd2XUKnq1sR3cgwA2GEuprVAla9kOQgYEwScyWFBjRliPTmhfZcRB2AO37LULOV5s6x7IqHh24hHrn1rzat/+7PnZAzo+t4jp2X0JXBtZT+ZVnt7v/qmRGho0c5exb89n6vjM6UVJGDjQDjjczUwRVaBdr2RVoVS3MDm92TJK3IlVzWM84rNwwRwCF2UF5UgR0UjefPS5CApgrJ1SZXBoKn3tpl8vUr0SUUAUjVZ/BcaArVSi51/hdxo37KM3Dp0V9AbuQKxeRrw9qSavK5jsXuBg/BbqjeOOlMI/5EMbMcsCjruV0vjKybDG/GD0Eoud11DtDrgn+mdPWTkZVzDd/efLOgiiCzPstkOHB0dhwSfqw7ZR9dgMIhOcyk46XZkRI9+vs2xsVZPYr/Mp8OnrH2ur/SnzlId1kDLfTZ5B2UxwTeGTgJJHSYTrFHgau1rrpfT7zfeuZlihs0Bi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(451199021)(38100700002)(38350700002)(2616005)(83380400001)(8936002)(8676002)(5660300002)(478600001)(66556008)(66476007)(4326008)(316002)(66946007)(41300700001)(26005)(186003)(1076003)(6506007)(52116002)(6486002)(6512007)(6666004)(4744005)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKUZpS1/TZ1qXsIWQgAe1wYKtuRUgoeW0AhiJu+KMuI92wUaizj9zvBaRVvk?=
 =?us-ascii?Q?FtFqcLDGlB/ZUwEz5lHi76FwpXj6TJg6/TlAsPPhTgSa7ajJotDdZhY3rIHg?=
 =?us-ascii?Q?HGorqtvCvMKKjcld+rHaq3gbm8/cJWnmfJNXZRISNEkwBk9576FftmE9Wm5r?=
 =?us-ascii?Q?Tieus+CTNawybTSlN5nSA2YnqktPpv5vGc8Om5dSqOAdvl62j9AZS63cTcne?=
 =?us-ascii?Q?YNuBDptU5ne6bcjHypSODp9hdxLnxigzJAwWMk+NCvOSmllzgl8iCPoqGzF8?=
 =?us-ascii?Q?7pqcbLKae81Om5GnnfI5AUJG8PDoPGGE1EcazKIGL8qGJBuIQD2/FSMOiDoR?=
 =?us-ascii?Q?nZacTF56NiEySWX087L7qwChjnw3NzmdeOVsWovL6gtNbYtou8lVDXX4Ohw0?=
 =?us-ascii?Q?6OKRupjiSN2wtF6wAJIEJsJ4hT1wv/5zQtltc+fj9pC04iM6BSZcHOIAIvGB?=
 =?us-ascii?Q?xvhD+9EhwQDqERF9F1gVKz6MS5IuxOjM1Vhpn8gR4iopYKNkqvsHCiM+uwNe?=
 =?us-ascii?Q?hGpoo386BND8f62HlmHtD38ozivYxjo1pAS8xw6+usSYgiRYPcWEYrM8Oino?=
 =?us-ascii?Q?xTF+ajnM4qrU704f1Cs7C3kjpMMWjPasDd/Wd9qedzE8Br/ra36z8pzVXXbi?=
 =?us-ascii?Q?uTIpDc6lYxm0xmHPZ3rCyX90d2WA4a+Xly53g490Y7CzrfNQ10giX5jgzXVJ?=
 =?us-ascii?Q?bCheEAJ8lcZj0OZMCUNe6IGIt4cCWTXzPgeq3qCpSAT1pCg4+RgmDlgHK2Qa?=
 =?us-ascii?Q?OoZeE0Nbg/j+AQ1vi6ETm83lkth1/8hBffbunu4uwUFh2nMGOg8yZuat2EaU?=
 =?us-ascii?Q?DQ2IIANIcT3KXKGaNsecdb8GShps9fCXNiOpJAbxjNjO6csdsqN4otPPQX4m?=
 =?us-ascii?Q?+buZc1I5OCoF8F8ovvQl4aLjDXU4qo/I/CzHW74P3e3CLQUu57RMZ1e1xf3Y?=
 =?us-ascii?Q?LubB8TlZmb1rL7I9Chr4eKQWYX1+Xa6xaYqjknYvzN24od9Cc3UJFvGij0BG?=
 =?us-ascii?Q?v9ySWoFdlO5b1zhgNsKTbIbsl12f1ATJMpVjLaCPloUuBqXzjRj/oxv0pno+?=
 =?us-ascii?Q?lmUsm/mBGGFgxQ0PXiOG4Zy4Kq2EJpiGiqBXCEf35jmIdsb4/uf3mL6ZWkIh?=
 =?us-ascii?Q?AvahKRHWOxvS5r/54HChSJMzANFI+C29paJ9WdZ3hZf8L1nzqlIpdndtMWVU?=
 =?us-ascii?Q?r8saezgD+rin74WZNNE2rDpU42j86xApuPZd7u81HvJeyMHZU+w5OfP4sUfK?=
 =?us-ascii?Q?i8PmYS4JFfzaLcFbiEYPGSI1VTHi6fnJmWtLITdAvw2iO8+s3NDt4ZqaXC1S?=
 =?us-ascii?Q?jODxWEY34nT5tEYL6j4zM2prxc8E2g+CPtWZuKr/I6+YoYniduvRXDNXeS82?=
 =?us-ascii?Q?0Ay8LMgibQ8XRMz0FUlmzHTtVK2fyRLRpzctaTZMazfwa7nRYbDO5rskjzsJ?=
 =?us-ascii?Q?Qo0nAolqygTo9qe6ujBk//7vZgoOzyOFe+3YAYHOIhlv82m3NPjVlBBKa/zI?=
 =?us-ascii?Q?NmEEguZld5p+isTt8UoGVS6WXBVuGxxNs6Dlym1+ZGXfVVpViFcUZNGDimFy?=
 =?us-ascii?Q?4cX/0cVk0OGc2wzqj3r5MuW6NGFUfV32KNMntbgf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b13a4fb-eb2f-4c87-931e-08db8aaee37b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 12:26:35.2507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2GdmXrZi9J+DJXJKnJnxIz1FXdUHXuP48Hxuls7wyV+7WBhQfMeTVKNkrDX8+37/hQlfJL530Rijw2uJbbrQ+Q==
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

V2:
 Fix build warning

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

 drivers/firmware/imx/imx-scu-irq.c | 116 +++++++++++++++++++++++------
 drivers/firmware/imx/imx-scu-soc.c |  19 ++---
 drivers/firmware/imx/imx-scu.c     |   9 ++-
 include/linux/firmware/imx/sci.h   |   6 ++
 4 files changed, 114 insertions(+), 36 deletions(-)

-- 
2.37.1

