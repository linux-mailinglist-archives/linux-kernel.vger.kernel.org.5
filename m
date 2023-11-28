Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB477FB3B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344050AbjK1ILq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbjK1ILm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:11:42 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C211B0;
        Tue, 28 Nov 2023 00:11:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCiAUn56NBF98iHlJZKJxAJsduO0fOIenJy+NN4Q1ZuYl+P+qdagLf0dOLqLKDP+JV6NJyyIg4++VZzjkZBuqkNmZ9STBwfAfxdMyE9Ohfz/tU01tgd8KbJrNC3l8wEGNY3mxXIwnujECvOtByREpHf6eeAOWhumuyLYIwBY9lWMQVnw/jAzISHK6B5ZYC+RCY6AVdsqHIiZZ69RKrotlnSjG13E77rtklBmSdO0hl8zHKlnvqdqe/dcO4Vql+mg9wFywwRhVVKNO7UA/RU/Lewbu7WJmFBb7mlcwCeTLL+SVVtfaInx179qmJ7Ud9JhgG1RQpsajXzGKhLZKiLCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VV1BPeC+yD1dfcbHRvt3ndOohr1TegIMYu5ToGVmYs=;
 b=fjP6c5JB+LIM8Os4HsQfl/EoH9uljv5pKEWCeZ5SUIYycuiKPtlhDQcEBI2Drn7Rq4ZZsG9S95zQJyI1EYfO6GBAW+4Z2tQr8WwrU96M5SDDQiIabobPnkdJipa2aJxVcqvon4EaRkUCwLSQEA99oZ4GUNVqhRl/b+aQhSG00KqAM/mwBzz6mDiQEzrWLfJnerjk1VCh33OKK1SbcwI56bZiFuafEguVwZD6urelfhCrbvv9LZreSNTVlDKQxB3eguFnz6lfbtGHh8CbA0Ybzr7bKhTm6ihZkRwiumOJYPp8LBYhD/EtsFer+nARJOrU4pWhFexOQSjkOIxlJ5ZRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VV1BPeC+yD1dfcbHRvt3ndOohr1TegIMYu5ToGVmYs=;
 b=iQFrUm/jzEeRjXm/UE+iW4rKtoS3qcY/wI7cXDYscAxm0GbKLBR+i5H88TseR5I4GG+iQYL2ipozGPqxzN7SfU0SRPAoVYaC8MuFJscYdS5AHeHxAObPKDVeikSEzDcmX8NUFwilJuJgA1YmZEE5TdBDkfOvjiVseYNOMl5xUqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 08:11:43 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:11:36 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        daniel.baluta@gmail.com, alsa-devel@alsa-project.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Subject: [PATCH v4 0/2] ASoC: audio-graph-card2: Introduce playback-only/capture-only DAI link flags
Date:   Tue, 28 Nov 2023 10:11:17 +0200
Message-Id: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::11) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b150ee8-ca67-4bab-9fc3-08dbefe9a3f3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cO/eVZ9bvkSmmNb1PIpC527u7hdpcn3PG9bJqBzBV9l5tZ60ymSTwBbfr6DY3mIquJ4OjgKKKJeiJs1YWWs22nAiXf1oRV7EwYxXS1apWcyHazA7AhPZPi46yL98aLH0c0wYfBmmsmoxwsKktUEycfSYWtgTLvpp47XS2Hk/RxCFVymnRINzw8VoGkLNM42gCgkC4vMKMjPAYU7bHI6wZ1F2gYjqBbnuG0sOdMXwjBcGokJf063ujHyAwfoSAzdV4/AgKhPcP+hOiU7UZpi9ry3pxdEwb24Gy9IKHj6ktvgdnp0Miq9/Y+EpCbWwxg8bTeYmPr/i40G5yg/PtNE4MAIW/odocLcV8x71mqpQRU2lH8NQ2H1kLn/QQq+2QH5LzLndjwP5CdqeQLU/Rec9+P5RbdcRbwy8a1jz69ZlxGWgGrKF1LafadJLUxHmPUb6DLDPIQNsOPKZm+R1G9UMEyt2YBx4DzNMRIYC/VkQ4vo1oKvl6+X0xAYdR5Stdkh6VT/Fh2AQpWamcjyLN22M1A3itQt40RGQqnUkL+O3DVw680e5XyvHvDv2ZDRTLErbjSIffAkzErAcFqHqi2Aqg/k72mOJIXloVgB6jaEoMAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(2013699003)(86362001)(316002)(66946007)(66476007)(6486002)(66556008)(966005)(478600001)(41300700001)(4326008)(5660300002)(44832011)(8676002)(8936002)(4744005)(2906002)(1076003)(2616005)(6666004)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lbPOQ0LQqjMxhCTL9e0FUF4+H/pMpVdir1CoeW+XuGmklYi6W/yxsBXlwWr4?=
 =?us-ascii?Q?5evLWysXA7nt3ZzuJ/dBGd1tWpMnP7ScBZkTaYCF+tpemzFvk9hlE3A2ITlH?=
 =?us-ascii?Q?4EbGr3xwBBjxe//aFJJQHhHLlG1yA6rBk77Ryw8l4K4gNzDU2+f0VDmCLHkJ?=
 =?us-ascii?Q?2pV9GloV98GdVL0VPW0JhI9s70UsASKpqhadJuh3NIfTNFGXIksTfjxOFirm?=
 =?us-ascii?Q?QnZS/AIrrKWTVxfFbpi0ljEPLDSlHIUYRS09s5pZREyN4EZ0rVkTpf+RnYjA?=
 =?us-ascii?Q?bht8h5M1zoUdpPO+71Xizl9AYijNe+q6wWvphufVTLbtwXv2mRf7XjMxCxRU?=
 =?us-ascii?Q?6+WM0mso2XHGgxhVYonOgxe2xV9OgYeXnGwTLGICsTgtXlk8krpvLaYjMGYT?=
 =?us-ascii?Q?jAGK3M7zLmUCw95NNn4gs9EnunIFpKpmFObiE5CBrQtNRxpxA7VMoicBisgE?=
 =?us-ascii?Q?YsPrFLKGJuwYZtXQSRxOicOqsUXni44j8bA+D9ifl23KvTcC0kxWWpEAPi8c?=
 =?us-ascii?Q?xtxW3ppJ6olWbpFybQ2d9T260FlUWGmtC4vHZXRNPtjyyitUw+dqtRgMnIoj?=
 =?us-ascii?Q?gN52V8qeXkCVxlnYHKtImDJL55+8A47cFx7hRPrm69KP14acr+rWsJz60kJ+?=
 =?us-ascii?Q?v6yssQX1HENfO53BJr+v3KQ3itMQeE6EnIMgd2873WaqLaV7J+l8AQdU6JnO?=
 =?us-ascii?Q?I15Bi/ch+eLtY66VXtdj7X+q3N1YZ8pXcqjtl9PN+ZZ6S4+xFXMuK5pckhS8?=
 =?us-ascii?Q?ebO0PQjgrVg7rPVykc4iecSdEswaoi9HWXRspJTuAMuohn9AO/tl4OuB/x5v?=
 =?us-ascii?Q?7Gg9OsYfhmTEu3k0sVlmn/w5lf7rmclA4WNX5HR0RKAeCr+5JbEgH1/vmPB6?=
 =?us-ascii?Q?pltuS3HvetYk5Waohoy7w9AuFbT8ML/FHKG+a90XafLiE+x9IDTSP2MISXM9?=
 =?us-ascii?Q?O7oEumTD5qWnF6b5BpqXkP8qiBvDOOJWeX5URvJoF42VRb6kpWrkVNVTzLTS?=
 =?us-ascii?Q?14C1D6Uh8sVlt+AYfD0OI8aRjSrsGagCVqTMkGWIcPHUO7UF8mFhKozsj0Fp?=
 =?us-ascii?Q?vtvvbUi8dBee8+BcU41PuGzV+5qkxBpBpA9zOM18xb4iD3qvq+g4Ge1s+GYD?=
 =?us-ascii?Q?Ur0cz+0PfoSIiAkiLfJwDQM+CDgEzwDdffADLpbjWU9e0j8/1m92w9whlCcW?=
 =?us-ascii?Q?4maSsn9uFyyLyaH2I+Ezh+ByUBCmGhUAWtexdD2hg2pqbgHzqjM6mhN2b0Jb?=
 =?us-ascii?Q?Pc+pYFjrAy2FX63KcL+OjbPseIEXQ/lD4hIrCJOqUYqQz0pdD1LMJZc7xgqv?=
 =?us-ascii?Q?3jpMajzG/YREfoe3Tr7ZUNhnYW4X6hGtSYZ6bAWQj6ddTndhZfRgJ9v1VNsY?=
 =?us-ascii?Q?mfZWBMZIDr4PGpaV6Uy6+OO6sdayMoH7WtV4vBYwMxgUTYD68aW7UhwiL20l?=
 =?us-ascii?Q?UP9biZUjHFdvrN85pv67nCmQHfuSQ3yeFockxu5n/nAFouqUEov+/0qXOKxA?=
 =?us-ascii?Q?wVzpMulwYr2eYEvP1KfKuiMkwDkE6RIo8gREkxtVA/ql1/+Rfh5jgUqA678W?=
 =?us-ascii?Q?JDKuhSAZcHJcNAFxnPtuuzksMeyPBhadt9cj0+xBrtT1kKkIRkkTLmmtYFTj?=
 =?us-ascii?Q?Dz72xRFHQB8bH0aPjXFwqFBsuaezGBE76PyyNSb+mrOf5wk085OQHws2a+B4?=
 =?us-ascii?Q?cq8FgA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b150ee8-ca67-4bab-9fc3-08dbefe9a3f3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:11:36.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAgDfVyH9AppvJr0PWLnR8vsRhFKYXVkb/Fe4e2L9kHHrfou2LA79p0SxMyW/NF1M+fvaHl481ny97PL1qdkoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patchseries allows users to specify a link only direction with
audio-graph-card2.

Changes since v1 - https://lore.kernel.org/lkml/20230801082433.548206-1-daniel.baluta@oss.nxp.com/T/
     - used audio-graph-card2 instead of simple-card as we are deprecting simple-card.

Changes since v2:
     - Fix device tree binding error reported by Rob

Changes since v3:
     - Add signed-off-by line to patch 1/2
     - Enhance commit messsage for patch 1/2 to explain why the patch is needed.

Daniel Baluta (2):
  ASoC: audio-graph-card2: Introduce playback-only/capture-only DAI link
    flags
  ASoC: dt-bindings: audio-graph-port: Document new DAI link flags
    playback-only/capture-only

 .../bindings/sound/audio-graph-port.yaml      |  6 ++++++
 include/sound/simple_card_utils.h             |  3 +++
 sound/soc/generic/audio-graph-card2.c         |  6 ++++++
 sound/soc/generic/simple-card-utils.c         | 19 +++++++++++++++++++
 4 files changed, 34 insertions(+)

-- 
2.25.1

