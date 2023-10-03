Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731C97B682E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240468AbjJCLoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjJCLoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDEEA1;
        Tue,  3 Oct 2023 04:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwkGhgoiaGxR9ZheyaNPXXeGl2Dj/1zBLBzShHZgjnNhuodkwwK+L9baHXNls6z5oX6n8931DgWlRq7lNgXSTNj2xMEZlJi7BbAKVa+SSLPAtVjM6eNL75yVF1Ses55FcDPsU2dGRyjZ2sIy6z98wyBH+BPiDiWUR74ci9NXC4hBM7uLrKEvQN5/+GPulc+/Oh4cgKI6SaLgFH0t6mZ2ScYqS4tEr3v+BYGViaT+SW0oRdqadcm3sqU63b25D6+wg4cN0Zn5C6XetA5qkAmlf3C+XoodkhlPl/FR5RradwCsQ9jd8ebC4xxFc771ELyt3jnawgJL7aVYxfQFNgDAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2HGT6YyxMHibpmPPd3FDBTGUoCjrMHjDRHLzk/0iog=;
 b=NSvvEV2gNMmBd8M7qufvpRAsz6xzFjfx0SJ5n3cuM6Vae/Bcn/GK4dI3YPv9wQ+CmdlzQOvSLLRt4t4WwPm0Ma59ZvJQb/zz5+bPocXmodN0FwQe4qQUa9t0Gqif0ZVRK+2DsZXIM7fXJOfg2YnoBFG7mHwcZvRmKu1fe4th4unDdmAX0tDzsxi1gZUrS0+3mT7U3lfr+M4FIuFG3Xk37DozvS2kkRhCFOTe5/NbfUtmpGVrDrdkIFOCM11nu31Yk+iI+z5FwZFH0d3cO5RaeaSFrmuTOAdDLDslC7Wa1OrZ820hGY9my5Oc3I+cRnAHiUGDKXTfsZoqOGCLVPOj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2HGT6YyxMHibpmPPd3FDBTGUoCjrMHjDRHLzk/0iog=;
 b=fCe0x39WYAzTa7xc6IaMQIjK+Pk8oDWzoUffDs88mzFG+ggY+IeRzX4rNvpo0NyVfVOH8ew+LR0jw6yNMA+BCtgBXUi7RpEs4Z1YZ4RGNw3Sn0pEXfDtnTn96JkGNb7XVWbSaGi1XtKVMuf2kKNb6mqtQBV/pjtn+BhdfgCNtds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8718.eurprd04.prod.outlook.com (2603:10a6:102:21d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 11:44:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 11:44:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v4 0/2] firmware: arm_scmi: clock: support parents commands
Date:   Tue, 03 Oct 2023 19:48:47 +0800
Message-Id: <20231003-scmi-clock-v3-v4-0-358d7f916a05@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ//G2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDI2NDAwNj3eLk3Ezd5Jz85GzdMmPdxFQz09Qkc1PTFENTJaCegqLUtMwKsHn
 RsbW1AI17f55fAAAA
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696333746; l=1748;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6+XUYzt9wMY9uBV3Jh5dlOQKYQrV4HV51rhUGDzLeRU=;
 b=8Mul1+yVdl6UqTvxasCjhtbW72tBhAT7Ww6cbEM9Dm7/+uh9wEqxsyDfFPtL+/h2bhTazq7Zw
 yG9CGf2ST1CDgQoQE3JE3oswzYUKUqABfvyRFNL9aZ8hwR1jRcOTq/3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b5ddcb-3936-40c8-cca3-08dbc4061288
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIOpSekNNbW4fbAFzq/3OlO2muJjT42+WkpKmEiGjGCQXlA0dVXvYnw6rty3HzqPELwEUdn146RyXchGjdi/Sd992LqjJlp3zy1GSaccyoMF4z7D2g3F4KlLIXslxxDaJiQafl/rn2tDqLmXqPS2Iijb5nBNaGx6V13gRXxYQpZcWfE3rDP4MMyTif4y1gZBl3l67sg0kHhFPfvOpZIIOVZIES8axF7F+ZljAZFGcfE3BDY39Dx5J2G574oKKV6wRwa8+rE5ULwymBYnF2GUoRxmA7qPyPCZ7aox7YsUmcr19ObuNzh0Ii/1XYfl2chVWxFoUWwrhwE7yyjzrZQpwz4mj05hk+M81XdyQgAhk4W2GHK1qmM7QZKwbqkNGT42kpNYwZqszHjPFWWK0IJ8s9I0gp8Iqu4sVGtkmoCJHAyrt5ZjlhdL91i0nvRVVFbAWCeyO3YuZ2ZCcpG6qpSCQnAoUxRHDAodz1qDbGw2csISzGs+xTX3bEOyvpwSIZu2tbbVwr51fw7NF842YAnIlPWq3Fj7KHxwya6FXA5BLkhDYjUzylt4c5BXMyUILRBLZp2emkFZMTQqtQibvKO5/Ibbi611ihGTl58+MmABk6RhTTylYbkuu7NvnqSsCN8CHXHEkRFXYe7a/p9L+Q+udQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(39860400002)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6506007)(6486002)(52116002)(478600001)(6666004)(966005)(6512007)(38100700002)(86362001)(38350700002)(2906002)(9686003)(83380400001)(26005)(36756003)(110136005)(66946007)(41300700001)(5660300002)(66556008)(316002)(66476007)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHMvTERUTVBPKzVJbEVoUE81enJwTi9UOXA4TTJHYk51TEh5bXpJbytNRlRa?=
 =?utf-8?B?OFpNajA0VkFtVFowQm45eCtlb2FEeTB6cittZEdlL3FBWkJqbWRteFR1L2ZW?=
 =?utf-8?B?M1hJbWtnbktpcE1lNW5CRDBiL252akFZNWlFMzBjZThmYThieGFYVllJVWpa?=
 =?utf-8?B?NDNEbFNuTXAvcTY4L1Z5d3lvVkdFaGVUVFZQSzBZbktPUkZOUXd4SFltUElr?=
 =?utf-8?B?bmRCTmpsdHRMV0NlaFlwY0xvNURXUnpyeE9CT3c4eEM2RWZ5dUtMYzl3bGpS?=
 =?utf-8?B?SWdaUVljVm0rQnBwVWN0aHAxbG5Oc2wyRUoweFpwWFFOaWl0SjVpTEZtRnJR?=
 =?utf-8?B?Yk02YjQwSUJaeWNIalN2SU5ZMUJMajQyNkJSeVoyTlNDWGxBeVU2OWpCaVZR?=
 =?utf-8?B?cXI5eEx4Tlc2TFlFQ0dwQXpUWGJBejRLMVBtMlFNV1lrekY3ZHh4amQrTDRI?=
 =?utf-8?B?bWtxZEFtUWVaZGZ5bmJ0K28ySEtwMlBxRmJEVGY5VjBDbzVoRGxRN2tPZGNk?=
 =?utf-8?B?NW1qS3p2QlhPN3hWclpvc3ZTeFRRcGxVN0Z1bWxwb2ZhUVp0UXBHaGZVR3Rw?=
 =?utf-8?B?MnhtMjdKWDdJWlBTTGRkWVYwRVJzMGFLaVF3d0R4amlXa0dBMHZkamVLUytz?=
 =?utf-8?B?Tjl6Z0NkQzdpeWZhcnQ1dENnVjZ6ejk5b3kyeS81cGgyU2dXcW43RCswZkVm?=
 =?utf-8?B?WEluYXU3S2pUR3MwaklMOEFuMyt1Y3A1VDZWTGNGOTY1SmdGNkpYYzZMWVNR?=
 =?utf-8?B?MGpZc3R0a0huYmNmOEQ5Y0RCZlZSajlGeE9Xa215VGxPTmk3VE5aRXRsd2pG?=
 =?utf-8?B?NmxoUUZsQjlBdEtxVFZjd1VUa0xCTGZSbkdKQ0xrekJOTFBXUmpPbUVDMVE1?=
 =?utf-8?B?b0MvYTZMdGN0UGxRMjJFdzZseWpHa2ZOVDdCTFBNZEV0dnA2ODdjS2MvcnBt?=
 =?utf-8?B?ZGttcVZXZUVnUXZTTDRJWGFadGI0OU96V29IYUVKbENveTB0TEVpOUNLd0xi?=
 =?utf-8?B?bkRDSnlWdVhNSGx2ZG1zQjlPOXJrVlp4Tks0Q0ZqZklCRkZyR2w2OGRWcXVJ?=
 =?utf-8?B?czZzdTdYdE5XcFA0MWprNWhzeWRiN3RLNVZ3VWRPSzhjTW54RmVYYkxvWWxE?=
 =?utf-8?B?ZFcwY2syQ1BXZlJBbERMSEZ6dEJHakV3OXB2QjhCMHV4NmNldzJVc0VrZHoy?=
 =?utf-8?B?N2hYc2NQMHRHTFk3dFNRc1J4UnRQSW1FSDkza0ExMWszRkluYU54WU82SzUy?=
 =?utf-8?B?MDcvMFJ1ckwrY09GbE90cUgyZWJweDhwZ0w3WEF2QVB2U3ZoL1VZUDJJRmx3?=
 =?utf-8?B?eFpyOS82Smh2aDFIbDdiZmVpWlRTZjBtT3RPSjYrL04rUmRUQ0lHVXAzSzJv?=
 =?utf-8?B?bGVpNmM0a3VUb0QyMVc3Wi9Fc20xTFBrc2dGazVvd3ZoMFgyb01acDhVbWVQ?=
 =?utf-8?B?ajdMSVB1LytYYjc5WmhpQW0rOFEzdnkyRExwa1I0SEQ0dDhteVNpUjNhR3I0?=
 =?utf-8?B?VDByRmtmRXI1M0VEQkxGZXpZNWxJeWhVSlIzRnQyYlhIN3djU2dXNk9SQjJR?=
 =?utf-8?B?c05tbC9LUDMzSmUxNHFNSXBIOHE0N1RoTmhuRnBpRFJRK0pMcFpWSlNKUENI?=
 =?utf-8?B?ei9QUUFCVE9veWhvRFVFdFlBbFZJVUI2djAwYTJmVG84b1BLYU03SWw3dThr?=
 =?utf-8?B?OG1Ma2lKVWV2Mm14UXNZWDM3WDJrTHNEOUtCZEpGT3BoSU1RNWFraWYvTjlR?=
 =?utf-8?B?ZlVQZDFUNDduVmkzQ3o5T3ZaY2R2ZEQvZmVGMkZWSDk5Vy95a0RiaXpPWmdl?=
 =?utf-8?B?b0pXdDBPbkw4WEJCbzZYSlhXZ2J5d2FoNTA5U1Q0Ykd3SHRwZCt2eWZwT25P?=
 =?utf-8?B?WGJ5dlQwZ3FLMEROUnA4alZneFJMK2hqbVdtYW1JS2d1YkdrNUxRZkN5b3RJ?=
 =?utf-8?B?bVpjSlBSVExDU2NZaFBOWFlER1ZjaUI4N2RFNmdZRFJNN1M5V1dWUkFDNnZn?=
 =?utf-8?B?eGVJNXNDMjRSZG1yeVdpSVo2aTFpb1dkenZlZzVWaUZiQXNSRTBVWUZsejJW?=
 =?utf-8?B?MkQrZnpZQ2xMK1JORDA1VzBjb1R2YWlmeTF3ZVBTeGd3NGNBSkh4aTROOTVY?=
 =?utf-8?Q?9tbIDA8rac9H1XA9pb1u8Ua1M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b5ddcb-3936-40c8-cca3-08dbc4061288
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:44:16.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NL3sHdDSRkq7Hl4w9G0xbK0mtRwswJJVA/DGOrqfelQZE5er2wSRtI+zZunI6QB9NYkXPog/SyVHpdezEC/XnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8718
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCMI v3.2 spec adds parents commands, this patchset is to support them:
CLOCK_POSSIBLE_PARENTS_GET
CLOCK_PARENT_SET
CLOCK_PARENT_GET

Besides firmware api clock driver update, the clk_scmi driver also
updated to support set_parent and get_parent ops.

Signed-off-by: Peng Fan <peng.fan@nxp.com>

To: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org

Changes in v4:
 Included Cristian's fix in patch 2 for get parent. Thanks, Cristian.
 Add Cristian's R-b in patch 1
 Rebased on https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi/updates
 - Link to v3: https://lore.kernel.org/all/20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com/

Changes in v3:
  Address Cristian's comments:
   - Drop SCMI_MAX_NUM_PARENTS, alloc memory dynamically
   - Check clk_id, parent_id
   - Add comment for parent_get/set
 - Link to v2: https://lore.kernel.org/r/20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com

Changes in V2:
 - Add determine_rate hooks

---
Peng Fan (2):
      firmware: arm_scmi: clock: support clock parents
      clk: scmi: add set/get_parent support

 drivers/clk/clk-scmi.c            |  58 +++++++++++-
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   6 ++
 3 files changed, 239 insertions(+), 7 deletions(-)
---
base-commit: 8b6022be4c6e3e0d37c3e1378c9ff0a2c8717b09
change-id: 20231003-scmi-clock-v3-ae65eb755d15

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

