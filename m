Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2670C7F6232
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345963AbjKWPAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbjKWPAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:00:42 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A73A4;
        Thu, 23 Nov 2023 07:00:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbB6TfSMBEUXaaI0BJnPFf/qErN2BIRn/Mq8E26TNq/oBejEBwd6HkbWKElajri4UqX9RvTwZg6fLBzdpEffrX+3wRLhQvQvYzfxDu8ZBMqPIo8GNINAuAiwzjTWQXabxcA/RjhySw60hbb+j4eJRIuoouyX76eKeOkZuxMOya+NlKf5IyQuZU+h8z3J8Mq2pWFTuhJ3sya/mZwcOsCSSUI5z0rCRozK6k8lWe1WwNJTMA0d7Ks19JaJ4eljDu8PdnXWcTypqcK+zZJDzWDzhv+O/vA2gk/Hiigz9/ZyEReSoClJfq0isxdp7sdkfrqrOEbGK16Y1V+5JPSt8GWJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piInE089yVllZdOKd0m0VLSO2hbslUGk0OHC228YHrw=;
 b=jA7wLnxuRQE2kVdXQHFW4vcZ4+xjyf7ek98010t+owu72WO9qBz2pcjAfQOpCVJ8Dj9PxWNaxkfcORAxu9Uu73W9l8u32wka/LsE/LGMrZt6frWQddT/I2uB6rBb+EdqKj1HmlEb1CJafZelxh6PNssdLRux1AJtaTkKD1j9LhYYILBXfNNb9xugfuRl+aryEhe+7iwI6VDWaZ35dMprOfXHMQiV9W3y3zLq1IZdhWeaYzEW159pOExjIFIe/RWamY1FfHKNRhxgwf0POze8ZMOWedUkHTOUZy8399iACp/b7z/y3VH/aVyHDsUTEPRfg7jSrhP2+MPRHxNaiEZZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piInE089yVllZdOKd0m0VLSO2hbslUGk0OHC228YHrw=;
 b=ZO3hUeOgj6Qt/f1zlzIvQnD47IcBO+tnu/WvZqkUqCfzRpUo7fiyT5cvUNkGxm1VSHzHEOqTa1keTszb+xVXWJT7ZD2wSlYgypzEjNe+dp4DHwEZ+Z5pxtVCvNtKNd8ibeRdr5tcqCZy+iAcQyw1lXMDyDaxiwTwSbOB8qmeG8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9424.eurprd04.prod.outlook.com (2603:10a6:102:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:00:44 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:00:44 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: [PATCH v2 0/2] Introduce playback-only/capture-only DAI link
Date:   Thu, 23 Nov 2023 17:00:10 +0200
Message-Id: <20231123150012.154096-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: a26895dc-427d-4f8d-0f82-08dbec34f5f4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkebQSbs0HBhUPLCZR9ffckFkYkX0hf9EhRoCJJbGcvthSxHIZt+9csopf1DPQ/lzt7IKwv5VHb8Zk30nPLyxM3PqqgMrmvWLJZUDGYhqd+Nqc4EFJfBXj7OrjrRE2xOcgIrLnUcX8qFtDP3XN0nrn+ZIPYC4UL6qXgwVwL72kqvX5K+rvlqhlGzkAdvMShqCQE5F0MB1jY21tXCn2/GyG1X6i8dUkN3w8hf9xUrn5X7Zb7ugP6EfTFF/+ZG2xbUb+VRLIfzyhsYdoIgxXuBeRBqFMl5qJJxzazwAiIurAMoPlOGq1Om7ZZeESfu38Wab7+fOGGiY1F72b2W6PUHrfwNYFy8AWKeB88tgF0ZfQiNM4SPmplyhQ80jqdCDfYvzydMHC8FJA0+UvPsH5F9BblXF/Y1QzP4PHkpb+PkEz/BEw53xyCSu5qhyL+TkHu9hhgImmKKQ4bKoRUPlv988tx/vTmHAUmoOZ525dN7DZZK9e4hSOgmvg8oHkp/8q5hu+Acz2WrHriP8fiETo0COS73MVEl8pEO80v4DFvoZrhioGSa65pl4aoqfP1eGVA68zmT5O4aB1AfsXnvzZ3QePcnpbZ7m3iEN8iPPlcViME=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(44832011)(1076003)(2616005)(5660300002)(8676002)(6512007)(52116002)(4744005)(6506007)(4326008)(8936002)(2906002)(26005)(66946007)(66476007)(66556008)(966005)(6486002)(316002)(6666004)(478600001)(38350700005)(41300700001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gU77x0FoCnxK5d337W9Ceghzn4V7yjxrDedMX7KyPP8iEkDmRSztZGMJRqTx?=
 =?us-ascii?Q?72vQW7jFigvxcIbIdL/3P4ljUTvWmsrYx2RTDmhXXQw3uSG+w9KrMlWe98tB?=
 =?us-ascii?Q?RVUDSOmYR841ktlnhkQKj2Qg28WmNNiC0IK00CnZyvPLkReggGD1PRjV5tbc?=
 =?us-ascii?Q?thBRIGjJuAF3+ZcwNGLoYCYgMS3n53qyMiQXllRjDBthiqbI6IqmMl7yqh7q?=
 =?us-ascii?Q?+f/N3KhKEk5m1LEHMZsEYCWvcOk6hMjRUNnXvGiUeK9ubzdBKZSXShiYKpaV?=
 =?us-ascii?Q?2tAkcMYtX3P0PhgKtgW2JVO57SCbZ/w2vP9gtJH3iv2nmyrd9K+KoDl+m3wC?=
 =?us-ascii?Q?LQBddsUTCtJ28fjFHtXHZapg6HpXKyrgJDz+K1AFQNFWjBB39EJTz5h6xFLc?=
 =?us-ascii?Q?JatQSqCyIYgPJDnUnlUKvpC3Ne/KagzCJVB929dRBXSyrwDfdyIcdWVrFBpL?=
 =?us-ascii?Q?wrLuIuOofSirwi2yub9+rO6OfaBq4VEG81iNtc2IP91ycwS2PwvO1vYB75+p?=
 =?us-ascii?Q?AucnkDe2CBk5B5su7iG35Cg5NELrtBRTWzqOjlZLZb1AZM7SldIbkm2vZK+P?=
 =?us-ascii?Q?JMwNt3ns/BkqaHt6XhAQPm9MmEKU9psgYE0Grxi6bx97DQQtj7HkwbGucVUf?=
 =?us-ascii?Q?F6Ha1KEYu/ABxmo1bx5pS+YWYw1p7aiZcEJOT5G1qo6WApP4HPxkYcRSc2kX?=
 =?us-ascii?Q?9s74dVTYwgmT/lF+Nzp90kG6e2m1rgaMg2OYLymld67C4sPpxfRMk1gQKAaM?=
 =?us-ascii?Q?1cKUjXnz5gIBxDZFLMv3r5Ch75vU3fXT2ZNmwGmK8QrvIgOKmSb8G7OmbnT0?=
 =?us-ascii?Q?MtWc+GY+Kav9nu0tPUWBa8J3mYqz7O2qCFgjaeD/TsN1BZa1k44mx5fEF/cx?=
 =?us-ascii?Q?gHdtDxFMPIfx5duAH5HqpP0QHonEubENiKWiAKo12G7EC53FMh3GrcEO8PT3?=
 =?us-ascii?Q?jPbfBzml3if9tjBcu7PrOpnVIvoX/z9TFrLykBgn7NXT/d1dc1NWX95rVY1p?=
 =?us-ascii?Q?1k7QaQSZydWLv2Y7UqXJgCwPpp5Cffk0lKN9ZiusWwHwkgRrHzO5bD+cyKAT?=
 =?us-ascii?Q?aZAg1En9tRSPWcPygVuPq27IecIxXS3Ub/9sX3jt5NoOiSn/L51lqy3xFvU7?=
 =?us-ascii?Q?f2FV0oorvXcYUwbYNnOx3ddMXWGUC6TMxuhhF3i+Wj+c0YzevqvSxnd705y3?=
 =?us-ascii?Q?NVTGNDB7fssPUHN1hXj8qxWNE+m/zZ2gJmFLsIvietq1Yi8dxEC2qp3GtchQ?=
 =?us-ascii?Q?lD8NB9FuAMYoDYGW0c1yXnj3uPcUu/PU84GwtQg8sQW3ZmTAAl8qt2C3j1AU?=
 =?us-ascii?Q?0RgftuyEiMaoTBa0NxtaZTzmXbHaEHt7J09B1E/Eb3R/JFbIs3PL5YmCOwar?=
 =?us-ascii?Q?WSQR0bax8Eg3lJBdb/cCWPnI99g81g7B8kWqM71chTul8vBUQHofEi8QvoZt?=
 =?us-ascii?Q?Kmy5iRrWEg7IIQOWlvj2oh5GhPt76tIwsruxoP6CxYiu66KBoEA3GQhHMZjP?=
 =?us-ascii?Q?93BNR5WEK2xBRPUGQxtfKa/9muJ/C5puaZ0uu7OyhWGSPOeqvZndSRt9tPzW?=
 =?us-ascii?Q?suzhtH+oAJGiHzcqcAK/mFEMAMVua547FEZi5/hM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26895dc-427d-4f8d-0f82-08dbec34f5f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:00:44.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHbYls/2/JQrUxHdJDHCrACTblfv1PbGvqf80oWMHKcZNuZQpjKDdboAF9NjdYvXLoZKEUW2e4mtSgTC3G7ULg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9424
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patchseries allows users to specify a link only direction with
audio-graph-card2.

Changes since v1 - https://lore.kernel.org/lkml/20230801082433.548206-1-daniel.baluta@oss.nxp.com/T/
	- used audio-graph-card2 instead of simple-card as we are
	  deprecting simple-card.

Daniel Baluta (2):
  ASoC: audio-graph-card2: Introduce playback-only/capture only DAI link
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

