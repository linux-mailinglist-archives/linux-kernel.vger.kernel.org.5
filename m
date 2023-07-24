Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAF975E980
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjGXCHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGXCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:07:31 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F304C03
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 19:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVfd5G9zEbq5+NGfX3znp/DVmGf8OoCsvzxOUJlelwIXG9i/U0LgPhAyU1FoepJZbWB7Xf+gXmK4zeFHcBvMnbnIyaleoim2NhCnzbpuPPB+Bic6jGg2MhC6tJ7yp5eMbovVmfb+D3ICwUU72LAee9ev1r/gHaFg5CmiblDMrnxOWgYG32m5hgzu0fIBhcskDezJvCGhClA0x9lAqm1AV74c6yh7bkau+awvbyfyTDsU7uVZOG3uDE2X6sxnpfiS9n+XqHQAYRtswMLCP27lsuZXX5i7a1KBd9LZ1j2V5pEKKOFzYVb3C9RI/VwcZehVzqxuspLaausUJwhwWzsLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGmVLfTPLm1dWcOA218nE3nTuk1j52UDmzkKKpzLp7A=;
 b=MDu3GOz/66z+QhEKC90a4shQxGb0OHeeKO0vbyrXBJnaWC6EqTXrTBwr4WqzwYQswzTuJHxG7+RPXhprVhxgtso5EgPB9uGHyp6lqi88LY+sDfDUQj1ly2VIloEGC65sBAztlB24QbL/YENnjxS03fUPZAdPxBT9aIKEMCVfU+5iIGPLB5kOjS7yES7Ud4GZPuQwKVW7hP/WKXbD1h61eBWz+gbMrwvAmF7TdJ6NwPWWgau8ogNBaKRMWQ0qIVbwLOP6i9hEM9rVlyi8izItBcD8ZWsZHEXtBCYo8OhwqPNPyWtQcnIglAOhhqjw9/AchTq0dbUrIiv3v8xqI953qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGmVLfTPLm1dWcOA218nE3nTuk1j52UDmzkKKpzLp7A=;
 b=g1Ru1MHls7gltnAG1pWyAQlaYoF3nfeY9Y+JoB8nPA+QABoBtm+VJalrpyJF4lfdQvnuhUhQtnHjFx0fsBWW8x9D4o3EKyQsns4xGvzNR42jTkuisRUZ6nSuiQHS6PjExOcmYoS5dQ+oOKQHb1BR0RF7z13WQ9LEd3yDLz0Rnoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8797.eurprd04.prod.outlook.com (2603:10a6:102:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 01:42:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 01:42:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/8] firmware: imx: scu/scu-irq: misc update
Date:   Mon, 24 Jul 2023 09:47:01 +0800
Message-Id: <20230724014711.2048958-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: b525265a-8b05-4041-cc69-08db8be73aa0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vf29L7Axn4c//vR9jEarYmRnOYkpDCYpNeZV+Mv1bL52heWUYC68Bb2xaC1wOcV3vHQL6IcsjHM18miupeIG0dtBAExdvJjzf5rkecmRCAJDT0UHoen0HFrMbKebVV3aWT3443SW5p4DjSQlQMeR56XyMlRd47cadAkOd1XHxq9+Cg3GlrcsVVbKIkXTISwfpp3F8eYabRe1vwgdc9L9LfWa3DjnsDGCgfn7oHK1o//B3+B0SrIYIKe/uRoQyx+01ijXgH7SN6luHGnVvBsUU3SpHubO4oK4YPHOcjH6EtyUT+lK9CmIA1P/TPEGL2ZvNLW2bM2Psol2hm+uKznFItCI623l4UexOO2LAJg2pGw2wp4hAmi81P0VNhAmE3xsJ8SktRt9nuxiQa/+w4w9hZ0lPVftah3A9McGHKpI79kuK5VcZ036KUgg9SU2afYoGuA8F2YJulpNz+MtlCVc8W0WkiVJXmPK4hlZ2WozdCG6dY8Idy3aasy82CyjPxW1aVzj5Yp1fd8Oh0GLihzS1W5AEJqRVEEVlRfDSZw+TT37nlAaZjsEZtSCrrjFlN4bOwcjYNJ5/pXK6s6JhTbB9LFUXLdbMmRfBeRZzFjZ9Sn3uWKxwbfMpn46mHnRrcgS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(83380400001)(38350700002)(38100700002)(86362001)(4744005)(478600001)(2906002)(1076003)(186003)(26005)(6506007)(6666004)(6512007)(6486002)(52116002)(8936002)(5660300002)(8676002)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o64c3kusFjb1njDTZPJItZ0DaW4T07CZkQPiiWSKxLieFPX08xUifRYwGUZQ?=
 =?us-ascii?Q?uW2yGCExmwtgbi1CQj/p/EYVWNe3vFHJ1jMTHtzVpjT6OYHM+7RDEJMij+rF?=
 =?us-ascii?Q?gjVDXMOXwvByaTSN1n3A7yNJh+hmql0hSmNPagjzfukA2dCG3xLBsc6gSios?=
 =?us-ascii?Q?fNBQ1J9E7/7rFdpM6JrPsIULDFVkxvzSXhAPvHNTsfrKQ8OY2NJ96yUN49MQ?=
 =?us-ascii?Q?Lk1Ouk/GJP2NFbLr6PYrvdyfryY992eOZ4av/jcLyVKT2xnrKMEBBSGdgtE+?=
 =?us-ascii?Q?bOnuSKKGfyv5Xv7ajryP4TMp7hNpBjJc4bw0hSUQMBPXUIJWXy3qZwEWfca2?=
 =?us-ascii?Q?Eh8/JRtuM76RABw8zmCtOL6FRbgMzI7VlfiE/laVGVqNZPrvpIcJSXs5FWOe?=
 =?us-ascii?Q?HFy62m7RTIIkPMXCWPnQSJ3+cX+UtZ65a4SyTGa1BG2nUTCy4Ey0Sc/ybr4z?=
 =?us-ascii?Q?6KWGvSKiXMB4e6+af2es6tleBLm+/WOVRSPiQZYQ0Pfee0Hz45VlFBF9Yvzc?=
 =?us-ascii?Q?uWCMMBvKYWKujL1SG07Pzqm7hBYtbThi/27br/AAdEvUUynMNesvQhBMRdUn?=
 =?us-ascii?Q?o2u8h5+FCCVHv8kCmpnQS3y0kx3QmnIWcJu3wE5IzIZTT5VVS/fzkPvGqUEP?=
 =?us-ascii?Q?coK/SDSKgjOZzkYvr/r+uWM7Rw4dg9ENJwHKyC1TavgcqZytUY+A16PWf7S5?=
 =?us-ascii?Q?2bwAHUws0ZHoMEjGfeXR9Ghlh+C658/9R2qyWx/wN73zJUnGVnWRsYPf0lTU?=
 =?us-ascii?Q?lUWNGznK7XVSyFskmpbzjmTKOaaOiFrQ19Ld2AX30YpBP1FbwdCs7SeksYEV?=
 =?us-ascii?Q?qtDd3CMiMCAzv4aqkC2NtulKqQHjM9ZH32OgRxsf8Q0mnhbamxkx3bop0xgL?=
 =?us-ascii?Q?5x0e5J1LsOSlHUTFLwFWzconnWmSPQTEx3tpvwNqpSreEe70PENTc+sa8mEB?=
 =?us-ascii?Q?RcK7MF6FHE7O19X58S1/F/W/qWG4iems3Ox1azickI6gibkV0efhtrbgO7wb?=
 =?us-ascii?Q?sbTD+pgysdagPhW5iTBHiRSWx+CD9dxRu8/LuHbVIc+Wz6N8+KdXTTfscYTD?=
 =?us-ascii?Q?5gM/CSo0FpJlNLPXP5DgF3zrYM1sacH6FDUlEDdqPyCRCNI5CFu8oSVTzrMt?=
 =?us-ascii?Q?oYNuMtD34EmGKfQsSOP8uUkSn5L5OJBfvuew7VuxmP+O85fe5tlXXO+b0Tq8?=
 =?us-ascii?Q?VcbZIazzdw4coxCG84wBIZJ8G8bWYy7fPj8f++cyeMF1wccBlTS4Dmo83Dzh?=
 =?us-ascii?Q?zLMtR/YZqQlBh2vFoCUgI0ni50Gf6AZ6Sn+K3AljZ8qZTlt1y8Xo/0voXd6l?=
 =?us-ascii?Q?ItNO0vwH9vER0tOAyEV/Cu5rWCtEzxx4g7Gac/YXjoll1xKbxKpj78PHZJ0x?=
 =?us-ascii?Q?hYMLzPQ+shQI57JErYlZhwTYPYn5P/XmG/tpQ/cUBCGLKyuq4jjGnEQEdTVR?=
 =?us-ascii?Q?2/0sUIIl8qwHDE3RRX4wZ++C9yOb5y63x5U/AWN6Xe63AZN15nJb0ITjXOqr?=
 =?us-ascii?Q?5gf79Or4jiDGMSAkz6mXrbIGuteLQhO6UBfo17SEdZETvmIg/rd2Tl8LIIGt?=
 =?us-ascii?Q?iXQah0cjXoKzYKPvy1rtaHV36RWmf3PEaAhXMSIZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b525265a-8b05-4041-cc69-08db8be73aa0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 01:42:25.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmGAMeRxyTKHwAnVujIoljEeIRyDFQcujwripu/Nk5BYfhFw3dmyZQFjCSErEAkAX6VjLyZlM/UpIQY2rBVQPw==
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

