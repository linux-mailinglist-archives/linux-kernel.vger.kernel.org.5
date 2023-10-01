Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD17B4539
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 06:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjJAEeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 00:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJAEeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 00:34:12 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A4A6;
        Sat, 30 Sep 2023 21:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOY4hGOkIpZt5sg8gwtdX4mnHNjDEuZMiwChOtOmLBd6ONk9d13JuO4Tt/ocvRlf9fYgk8KOlaL537LUoGG0emzedzPHI7g2ClHzjAAexMxs/rxeCOeJS0Juam+BFUWpWBA+8NjDR8xIZdbtG8QkeBef1iE/V9L6cY8MStB+Nbw6fjaGWJEWOl8A0iwpEFwkjLM7l5SZlqils1D2UXYYIi2rr+SawPRIz0U+dMtEKYwVVeIWtB+NmqaiT7te8M3u0wIK0rMHq7a49lMHCZv/AYj7EmBz81wn24h//cu7htBAPlzETwCFjns34d1U1Qt3PnU1jSPvSFNDZsaRFtL24g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP2/3RI9VDhAdK3xOz618H/3s7Dg9aoFmzsZCJONNe0=;
 b=PwuJj8GjXOKk3TNtpBp1R35FtYcGwXRqyhybxUCICthyzDMMaJ33WvH1EhgnkOczquNGGIc3AUgI0eGSOPyZ663fdq15S1brN4zsvEITllyUC8hXoI7zLoEBX1bJrtGwcq9zEHYvCxaOgI93Da2YsrX6PYiXksC6LmpBZetnUvRH/x0OtQgNnjou9VBcqtzK25+Bjmree3DXCl5N7uk/vGHR7mFDYPlfUTkaF8L14nHutzYO9GNLTj5hU1sVK4YfsU2+aVxSvKInVY5UQr4aad5C46Lu9I6nv1d1w3J3c2x6H9Em2Zlwu2P97nM282ZjBsRfRtyKLEM3VQGpxs4Mmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP2/3RI9VDhAdK3xOz618H/3s7Dg9aoFmzsZCJONNe0=;
 b=c2S076kA5XN6Kpdgbi8eemZI2rls4tvA4lD3DVcdEe1VhthOGN5F9fB1OwB+g++shJbts532FqmXRQ6s6I4Hn31ZY3B3+a1PezANrfLjukaI6kmETFmgFiRHceZXsh3EivG6PDaPfSBeH4tFFTad8/u+bY6bWd8icTh594xgllw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8335.eurprd04.prod.outlook.com (2603:10a6:102:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 04:34:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 04:34:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v3 0/2] firmware: arm_scmi: clock: support parents commands
Date:   Sun, 01 Oct 2023 12:38:42 +0800
Message-Id: <20231001-scmi-clock-v2-v3-0-898bd92d8939@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANL3GGUC/3XMQQ6CMBCF4auQWVtTBkjVFfcwLGQ6yEShpDUNh
 vTuFvYu/5e8b4PAXjjArdjAc5Qgbs5RnQqg8TE/WYnNDaix0ldsVKBJFL0dvVREpWuk4cIN9cZ
 A/iyeB1kP797lHiV8nP8efMR9/SftmEJbW1Oi4Z7Kdl6XM7kJupTSD4LWRcyoAAAA
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696135135; l=1119;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=OLAmIb3L8Tq4S6lzm+4T437dF/ZkjI/GTAFYqxdHPys=;
 b=x7hC8UvGvGkXNNyZNCC+zwXpoSeBjqMjVR50vlIrjETb+lCpgt1KTdv6R1VtKq4JCj93eAyO5
 jxsfjXQbcgXAVHmRNL1KbiLooMbRadQ1Dz6D3YOVt7Bw27RSwZDBH7L
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 20825a61-eec5-4dc1-7d89-08dbc237a53a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4v7iRZnz/nrSuQmUJ+xrvDHEylcjhPAYImwBNs9uSAz6e1QyiUMAOCn9/SeAFZl5C1vIcCet4zLK8ZtYfBWkwrxxxDlT9Br/0q5koLQtqAF8B2qVahrlgn2gsyIgo3tvluQ8qoe4ydcu8dca6nmpL1R98Fcdd/GjY6lWeRP2SG+d91M5ypn7kXx6FoYC3l9HGFNB2ZKcIWxa1+3z0v1rX5wZKbV97RCn8De2jfudcgiWl335vF+RiOmYo60QWlsqJVbsHO9vGL0X9xqTDorgfVLCUvBRzDgbpEerMbGAv/8uvvgB6HexeYf+j5hMrHUqJ5BRPXZJKzL0+Z7Nqhz76N+g4A9d18Z5GFB89OYJJzPC8jt1FWn0Fupdwe3pLQk1ip9PBY5wiNecsv+nQ4URQvIW5npzijaPqylXTg9BiYB6rb3G47ZkmfwNjxdprRcHRDFIU1ajlA+QCwe8uX6Q2DVx5gAMH8YFga45aobGjCjOEW/Wc14+Gu3Xz9k6DvlPf4ubU6UraixLk5NjS3h9o7oPHgqLZDejmGBS+/dKr2ryem2X2D5g8PuRmxTPmReEr1VqgeN7zR4f8lb7sP0e0sTaptpIVAzJY3Nis8fI24=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(38100700002)(86362001)(38350700002)(36756003)(83380400001)(316002)(4326008)(8936002)(8676002)(5660300002)(41300700001)(66476007)(66556008)(66946007)(110136005)(2906002)(6506007)(6666004)(52116002)(9686003)(6512007)(6486002)(966005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGU2M0pTU1FBRWphOGRzTVlhTjJBUStrY2JXeWFzZ3N0VStSSXZuYWdvY1dy?=
 =?utf-8?B?UncraisvbUlHd3RnQUlINnBuaXAvNmJFQmN1MnBMdUQ3a1YvY1VidEtVdGdk?=
 =?utf-8?B?Sk1BZ3dYTG1SL3QweU1zYmRJUDJ6QmZxWXlxUzlFRWZGRDVJZEFoNnRqK1p0?=
 =?utf-8?B?czNCU0JlZEtnWjNxYklZbldaSWJ0NVFzbE9SdHZSQ1lDSXlPdi9xVERUa0hB?=
 =?utf-8?B?SmNpcFFVeW1MZE1nRVF0SWpkT0VsWGcyTVNkcmorZ1RwWjVKRDIyZCtzTTJ6?=
 =?utf-8?B?RmRJV2VYREJYTzdjUjIyUDRtSllLQzFUbWRPZUJ2cXdaRFowUFFibmtNL0tZ?=
 =?utf-8?B?Y3ptb01jWHIwdTBGbVBkT1pyM2l5QWZFcEFlZzMyb1pNRHRxRDFtRjlSVlAw?=
 =?utf-8?B?ME5tdEhtOFQ0SnJYMFZyOUJ1NmVIVVdqTVcyK3JOVmhnYmxwZi9iTXFqMm1K?=
 =?utf-8?B?bnI1cFNaZ2xCYWE2RDRxL2xnVFVnemdDV0Z3TjlLajc5RjhiQTNHZjFBZEc4?=
 =?utf-8?B?TWZHa0NqbXQ1WS9wNndtY3V5bDlzdVErZ2hqcWZVSmpqZDVBRG5CL2FGWUNG?=
 =?utf-8?B?RDducC9ETGhwcmxvWkRHa3I0MVhRNGJ3cGpzbGFLT2h0ckRnMjIxMnFIS011?=
 =?utf-8?B?TjBjMmdBN0c0VVpFY0Jydk5lMWZnQnhoSEVFOGtRQm9adjl2SGJselFmTlc0?=
 =?utf-8?B?UWxGbmN2UGZwNmFnWGZRSFcwelVmeVlYaVRtRXZqN1YyMDh2ckJtUzZMZC9L?=
 =?utf-8?B?YmQxVGJIaHJkZGxxSnNZc3gvNmNuQU5yUUIwQXQyZ2ltWnZuWlpGdVNBNjE4?=
 =?utf-8?B?aUpnNzNqcjRiOGtiaTNQYlR5b2hHY3oxY01BWGpOZzNsbjl6ZGVod3JGcnpl?=
 =?utf-8?B?b0hjd1R4K2ZvMlpXSS96VVc2ankzYXdNTE1zaXNzd3daaDQyWlBZUU56STd4?=
 =?utf-8?B?REZOYjBPbks1NnlnQURJUitXV0lmWmd0alN2UTJ2Y0JLRGlIZ2RHYkV0dFZm?=
 =?utf-8?B?NWYxSitvMENMVldTNG1lTExHWG9VU1dYSExLMmd0allTSlpQMWFmNWdkOXhI?=
 =?utf-8?B?TzlwTHVPZStrRE85NDgzSmlxeHVXV3lWU3B6L2U3K3MzYWRUVG9sWXY5aVc1?=
 =?utf-8?B?alJEQmxNRHlqaXhWWm5DeXpRcU1yK0E0YVVWNFo3eFFhNjlTeUVyQTZFQnhw?=
 =?utf-8?B?dE9uVzFnWCtsNUViTi9zN0FuMDArejcvMlJ3NUR3bmplVGhFU253NzBvQ0tz?=
 =?utf-8?B?SWpIZ3R3ZitMUi9NRG1MVVFxekZSd05IMVlqYUNIQU5uWnQzN3BSUHZxakpl?=
 =?utf-8?B?cHAzRHdqR1EwL01nWHU2SXdTdytkUTF5YW84TnlrN3JGSkZoNDU1UEUwNFIr?=
 =?utf-8?B?M1NjMlV5d1V5VjNPUUFlT2VoQ0JKSnRxRDBtQ2xOeDd6YXk3c2FHKzZMNS8y?=
 =?utf-8?B?U3RzZGpCdEtCdng2aEdrc0t2UEhqcjJKZXRzTmcwcXdNVXg5SHFmTWxkbXcr?=
 =?utf-8?B?THAzT0h2QmkrVVYybGxiT2s3TituaDNrVjg2U1Q5L1J0UnFRTmhjaWhUaGdq?=
 =?utf-8?B?cEdINDFmSXhnS3daS1dxblFJNVFoTEJ6Q3g4alRndjFKdHI3RDU4dTVraEtT?=
 =?utf-8?B?a0IxYmxhdzNFbHNmWmtPTE4rNUd4ZFlveklZWFREajFhYUJHWkRiT1BSR0JQ?=
 =?utf-8?B?VFBxcWt2bFZ1d3IvRTVVSVZVQldaNkdIcFdOcXl6Z3RJbWhzdVlEVm4yR0pr?=
 =?utf-8?B?SHJpVTkrSjJkYy80bkNKSGR3eWZVaXdKOTdvc2N4a2JwV2drNjRvOHMxbzRl?=
 =?utf-8?B?blI5U0hWRVRJMTFJTXVDMWtpQTBXUUpZc3FGdXZHSk54UDRBbGtPN3lodHUx?=
 =?utf-8?B?Q1l4SjJONzkzL050bzlLak9WaTBobHkvN3Y2Slhic2plcWZlMm5JOW95REhL?=
 =?utf-8?B?cy80dERRTnFvamFzNUNtUXpNZTM4VW1Ka0VnVHVPUWdYbklSV3laTlBweGJS?=
 =?utf-8?B?TytBR25Xb2dWbC8xRGdjTXpVTVVINHhueGtpSDI3VC9EZ3BpR3BDNW15Znl6?=
 =?utf-8?B?MVI3WllkUmhOSm0wNDBTTndlM29EUFZ1YWloTjBlbUdjU0FGTEFCWEF4eHVD?=
 =?utf-8?Q?yE7AyA/6dsfIPLjOsn/smTxRW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20825a61-eec5-4dc1-7d89-08dbc237a53a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 04:34:05.7521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2SzrDYGcGv2wESTWMtj+C1ZocHwWgTWyJ1XM10WqJngjVFIAuD0t0K6X0ZPJq2NP1B3znrWCMVLi6ff7RUUfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8335
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
 Add determine_rate hooks

SCMI v3.2 spec adds parents commands, this patchset is to support them:
CLOCK_POSSIBLE_PARENTS_GET
CLOCK_PARENT_SET
CLOCK_PARENT_GET

Besides firmware api clock driver update, the clk_scmi driver also
updated to support set_parent and get_parent ops.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
 Address Cristian's comments:
  - Drop SCMI_MAX_NUM_PARENTS, alloc memory dynamically
  - Check clk_id, parent_id
  - Add comment for parent_get/set
- Link to v2: https://lore.kernel.org/r/20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com

---
Peng Fan (2):
      firmware: arm_scmi: clock: support clock parents
      clk: scmi: add set/get_parent support

 drivers/clk/clk-scmi.c            |  50 ++++++++++-
 drivers/firmware/arm_scmi/clock.c | 182 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   6 ++
 3 files changed, 231 insertions(+), 7 deletions(-)
---
base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
change-id: 20230925-scmi-clock-v2-042cf8e5cb77

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

