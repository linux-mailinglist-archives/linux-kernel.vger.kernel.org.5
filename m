Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA77AD39C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjIYInN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjIYInM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:43:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA5DAF;
        Mon, 25 Sep 2023 01:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hktWOQWSKoReXWPBrawqDyKVFnwUvQFg8qDezn5A31+krVJMj/EWKaPbkNmLJiExxVQCXSBMpPgS7Kab3m5xkrKP6gLd43XENf+Ep5nHouDpar8ApCIgP9Dcl+9hIjhgnYhYbuFu0mX7k3QK0WJFrsiURCvtVd9DltothNAk2DzdZSshcu/RslTBRf4xNCMSnR7K8OR4wto5g2+GRtkJt2bQgKiaROMHEEYbmLM4LBtbCOxQ7xQPmutpRws4IR2IgKNHn9S6/d3JH3Rk80fkWqlenQkDjqa1tKDRzxtPouczwa4aGz6AkKxLFnLkIRir20Cvo+aApwq8w3wpJjV2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KARDqmDq/pq7jxSicaWZ2dJzJSatVa1MZ5Hwdp5F62o=;
 b=CwiCUWsG2jXdyoAIVlDLi2x69aivctIe+NRMPfO6nHDGnJc+FZOY/RvyT8nELETXt0amExbyxVsXdb3/bs+zBTEQXlbmwajBdAiTTWWVid1c5An/dG8wlhM8pr6NrPz9TJ36H1QYW6JW3Hj1oMoBUpqwXpT66KzbHvfG5PoOXYJqeU4iIo606dde0eRAfznY+bbpm+wPh2ZsGEqroNFwpvbRuiE0ifZcctvFx6LXW/brKk1up3h6Z8a9vw1fgriRF2DUgg4E5rd0GACRDk4IYFYJofkRFVhvRMn0x4DjjsKGmeiv/TiAMpnwvxs6l6WuGufjL8cVsKit6yeLhTPabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KARDqmDq/pq7jxSicaWZ2dJzJSatVa1MZ5Hwdp5F62o=;
 b=Hjh5N1EpK8e4ZmnqsYJBsBGaPHiRLKkPJBS9/vLC3nSR9Heq0R8BxKGHnaKojYYNYQPmMnze8/tHBLwduH/i0vHTcG7FdwRr9DFvVIIuPXOABLy7ToPFSN4foCs/ijRfRjUGrJ9awnTehrnF6gDenAMMolEzfyNguXJwtBj8PtU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8940.eurprd04.prod.outlook.com (2603:10a6:20b:40b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 08:43:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 08:43:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/2] firmware: arm_scmi: clock: support parents commands
Date:   Mon, 25 Sep 2023 16:47:41 +0800
Message-Id: <20230925-scmi-clock-v2-v2-0-2d4d7127ebc1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1JEWUC/x3MSwqAMAwA0atI1gZKVKpeRVxojBr80kIRpHe3u
 HyLmRe8OBUPbfaCk6BerzOB8gx4Hc5FUKdkIEOFaahCz4ci7xdvGAhNSTzXUvFoLaTmdjLr8/+
 6PsYPlD9tsl8AAAA=
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695631674; l=854;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=6E8TJHOLUnH9ScsX8CrnbmYS97OZvI3vDTk5+VuRFFM=;
 b=VCY7X1g+/9Sh8uWg24RXnQ96FbZ05Nr6F1gAsSRZZdRFbpxUa6VRkPm8c2f62/+3UDo6E6eMf
 J0scGUZK44BA9IWq+Gt8H9RBoxW81VOhaMKtUdYSAFRBLdVsG2Ur6ZH
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f69714e-b24c-47c6-d560-08dbbda36e11
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZai49Q9is1h09GudJgU1FbbXzaz3xXHMNGcbEz5dKI6qi8ysljTmmhQ48frIi0NKLorUFvAF0rZsY+XpKHEQp6jT/N7mhV/gjE3HCXOQDjGGkyfuVJQjnVDstZj0L+uDDoRAotCR1c9nfQ6h1dwTxQ49xU9EQNq6BCEUERmL+1eC39+VEGTMB3jqZWMVhy4Mkti7eq97xkWlg98RBrbbNgOuC6R+V4/fV4DUsOAOdRvDhQq2f4DqyMpi1XNFi4K46Ht8HbYMgt153dPajP9ihPCQgiL0pS/U38hlymoxDgNqbt1V0Qw39zpFcYNIEtvPmaNaQ/nAHx8ZpcSdGv6RfdkRFqGVTTFq7ijbjPgtjoMjoKYOEx5aEFySzM6txOP1mZfPwBKlrjz1Ohr+VsWtOS/bPlyCj8VQbxx5sJ9nLDJt4tb+8fNw/ivmeKQjlX3vl7ZBb7WDn+s3hQJjHirlWMVcyvII3myt5lU5TfaUNC3W8weQSAdc2VkLX48ax6TXNPHhEAzrakaF8yk45HCRODsLG35lGDvwqn901cXYX0VsAGLySvChQulDiVzmFV14feJYGP7FV8zu3usiHIegiM+FPLyeKiiIQlW+JxsRWStBs9toSMBS94XVxaF6X3/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799009)(186009)(316002)(41300700001)(26005)(2906002)(5660300002)(8676002)(478600001)(66556008)(110136005)(4744005)(66476007)(66946007)(4326008)(8936002)(6486002)(6666004)(6506007)(52116002)(6512007)(9686003)(36756003)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpUTkJucGdlZ0xqZ3hKbmlIMFZsWkRTZjUydXlQSm1sbmRHdlpTQ29QVGFw?=
 =?utf-8?B?WWZGWGc5ZW5tZjBKTjFEaGZFZHhCVGNhNUZ2MTQwekdhZ21YOEZxU3BBV0FF?=
 =?utf-8?B?aHFLdEJyNlJ5b3JJWHRqbzlGSVV6S3k0TGJXaEpyUDJHb2tNV3Y0ZFZHWkhC?=
 =?utf-8?B?V2d2WWM3YmdLT1JvbURCVUZHWG5BWkd6ZHB0bjUxYzJOWmZtbjlGR0JaeW94?=
 =?utf-8?B?WlYzWDBNVm5rbGtWeXF3d2dMS3BsVTZsK2RWS3dCYWRiV3Q3d3pWUUZYRk1m?=
 =?utf-8?B?UzFRMkV6eTg5OUhpUmpHQzJuK1NCc3Z1TURFTUFzTkZBZzk4UFR5a3h3OEFN?=
 =?utf-8?B?QmlhMTYxcnpSa1BrMlo2cHdCWktpRzJEdU1rNGNyYW0xRXNwaUo4ZDBrUnU2?=
 =?utf-8?B?QW1SSVkzMklsUE5JUE9UcXNRc3VYNzJIeVFmMFU5cDU0RkdZYklqaVVrby91?=
 =?utf-8?B?MGw5MXBLREo1MUgraVZsSEhEcGZJQUg2YW1od1BZdENvK0JCWjVDUEdJbzVw?=
 =?utf-8?B?aWpjdUM0eDVhK0RzdlMydVVJei94RUdodmdtYWdvNjYrTFc1WnlpRTZvbS90?=
 =?utf-8?B?QlZqMFJ1NDNIRURmVHJXU3hUSXNFVzdlOEhnc0VpOGVBRit3ekZhaGJZTEls?=
 =?utf-8?B?NWVTT3JlOFFiSDdYaVI4WDB2MnV6UytCTk1xNGhOTTBWNVRxZUZrTndWQ1No?=
 =?utf-8?B?MWF1clExNC9Gd1pqVjc3RlFBRVlBVjY1eTlIMjBUTWUrVlhUUFRGKyt5QUtl?=
 =?utf-8?B?OWtkbExTRGcxM25ObVVXY1BTUzdZWStxQytrcUNXb1BhRHRObHI0NmgxTVV1?=
 =?utf-8?B?QkdGVGNrQlJwRHNQOUVWRXdnOVFFN1lxR3hMaUZZMnFacERydEk5azJkWHVp?=
 =?utf-8?B?ODVkcHdPVGtkaXZLcVorQWk0Vy9DS1FoM1lyQUV4MTUxZ3pLaVBqN2w4elFa?=
 =?utf-8?B?c1RuazZrWUJTTGtWUGhMVjA2MGZjVzVWaHJqUmYxbTRnYlZ6TnRWQktnVlI2?=
 =?utf-8?B?NmxwWWpZV0RRcENkODlkMUZ6b3VYVEVHWU1rS21oZVEvdmRoR0xvNTRXQUho?=
 =?utf-8?B?d0NFUmo5cm5nTHpzY1N0M3VtVUZ1TUNKeTN4VGVMeE0xc2JCOE1lN0s0UkZL?=
 =?utf-8?B?N0k1MFo4TFhBLzB2a0dUTDRMQzFDdEprNlRLdlYrSFFpbHNHbGl5QmxRYjYv?=
 =?utf-8?B?V001UHkrcXpOTHozVUlPRXBZcmNIMFFoWGZOamp5Z3JKazlxWnYwTld2eERB?=
 =?utf-8?B?NDVsNkc1Rm8xQ2pDSVFGZHJtV2xGb1IxbEdYRGtUc0pBNHYrSlJHNy9HZHBh?=
 =?utf-8?B?eFM1blU4Qysxb2I5MHBESU9HSzJhdzR2VjFxM0JXRWE5TU5jVkpGczEyR1Vl?=
 =?utf-8?B?NFM2RWdaVHNudW9yU1Q0UXZKRU02UjBibFFHYnlWTlVTYmlpMC9tWWxIYzBY?=
 =?utf-8?B?V0FzVk9mUVZTVWhSQ3dPKytoRTQ2djFLY0NTRllTdVVTdXI5NGVnS2ZndGJp?=
 =?utf-8?B?UDg0bHRSQVVQQU03QTdwZS9TSkhQNWQ2TUtvdmdFNTNxUTNiNGZRUlZYUGlU?=
 =?utf-8?B?eVBlQ1lvbjZ2b2JlNENLaVorWFNoQnJ4TXlaaTZlS0RCcVI1dGV0WE15MG5v?=
 =?utf-8?B?dHVNaXUvd0g1T0pVdFR3NkhsVFB4dk1QWUNNL1llbHNtRXNLV1NVdUhBeW13?=
 =?utf-8?B?UTRDaUpBb2duOE1oZDlwVlhzNXkwZGR5U3RNNjVlN2ZLSWcrdTNNS1M0dFdS?=
 =?utf-8?B?OGhUVlhWZG0rZzBxRVJ4V0xxMEJRZUdVRElxL0lJV25obzh5bnd3cEZ3WnJh?=
 =?utf-8?B?QU9lbGRZcVU4M3NnK0tKbTdJVlg5c3hCZlNkYzUwVG9OV24rdHVnSDFOOHVJ?=
 =?utf-8?B?Rmt4d3k5dFdycnVPY2ZxUUoyYng3YUMyeTFTU0U1c09BV1dwcS9jWVBWcE1M?=
 =?utf-8?B?ZW9rSGh0SXB5LzBzTnptdW9FcFl1blJhK2d1Q2txelNrSHJiWHJHUUxHTnNw?=
 =?utf-8?B?YnN2ckhpbGNjeFRPSGV4aEZGdExTMDJhYmhtaDQxbEZVaytJaXpKd2ZDMVgw?=
 =?utf-8?B?d2hRSlRSSW9oeUJXRE1zRFRHa1VubnFzYmtla1FxeE5PNVUyNWFsNEs1S0N2?=
 =?utf-8?Q?NdhvBZ9djl+4jup4w3Nu0NAn/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f69714e-b24c-47c6-d560-08dbbda36e11
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 08:43:03.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqIE/W4ccBFkq/rPPns/F/fPZok+JXCVf3USQhMcksn5I6EYL1LajacaNMB3o9t5qN7Zms8CCJEmGHbDA2sBRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Peng Fan (2):
      firmware: arm_scmi: clock: support clock parents
      clk: scmi: add set/get_parent support

 drivers/clk/clk-scmi.c            |  50 +++++++++++-
 drivers/firmware/arm_scmi/clock.c | 156 ++++++++++++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h     |   5 ++
 3 files changed, 204 insertions(+), 7 deletions(-)
---
base-commit: 8fff9184d1b5810dca5dd1a02726d4f844af88fc
change-id: 20230925-scmi-clock-v2-042cf8e5cb77

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

