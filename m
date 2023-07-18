Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51476757874
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjGRJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjGRJuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:50:46 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EE3FB;
        Tue, 18 Jul 2023 02:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGixpFSQOhnc8VKjTIwMxkUalCXUbyBLKh7R/LnuKqiEzLHNlEko+miJlAfl0+U8eS2PM2fzPKy0L66BfPtOPCkj5hYpuWX2btP/QursYPHICBcbPei701dJ0w3vUBwtsdwvw/WbyYwmmZ7VxdqdC9Mio1f8jeOsFy9npeVnFFN+i0ozPFEvm+dooennjUeTJ4uORxeFYmx6eF7Bqa++Iz/lkrGYN2tOGRWpyJCeH94RfmtPOFjbhv9wd+pRDdynd80ZST4Z2plN65ptwU0DeWipexJjPWc+Fqsn2Bi4i3TcdqzRkbCrd3TfvD1ubZ7c27CaurmAskASAG3TslV2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6MdaxAytz1pci2YqqlhDJoPpbGLB/n5nrnyjZl92u4=;
 b=gOxpRWOHfUTa0FLxLrbkB4e9IRB/sW89ag/wrWLCCzYm1fCL++RohxcOljU5BaDcuqZvytjHU/0hgyTlMR4CUfV9vcckg1ttWpr60LV7uY6GMifluHHdlq4v2lUzKTaUc9sFHbmyzaAnlwr24NCGwfWWbAllCMQ7BYIVm3sGsWF10POSvXaS6onByw0izBSdioJbV/JaRJYTLf9dwkfZpWT/VidlzR8Gx6//yRcAKqfWAWQLib/s5WRRKPykn7bhgr8w8ggDGRsd6cDvldC0+sz+IP9ItPMtd8TQmjbHQpokY+uCL9UequXZDSujqo5jGc9B3bo7vHD0+cLjmyEZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6MdaxAytz1pci2YqqlhDJoPpbGLB/n5nrnyjZl92u4=;
 b=gTNRTl1wd9XM1ndaVjWZF+H3h1BE9Urd4QSuWiIQcTpgAqpbtpsMizoAbfdZfBMp8MEHpG/c8oONxpodkrvNtJq76o6iuiZfQ7JOJ612TSmguRopC7ZVu8jXykaqd/gWCCujd6eEzIsIdNwUC6QfcfXr1+ZyzmSbwKYgSmI+2l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB8PR04MB7067.eurprd04.prod.outlook.com (2603:10a6:10:12a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 09:50:42 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:50:42 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/5] media: amphion: fix some issues reported by coverity
Date:   Tue, 18 Jul 2023 17:50:08 +0800
Message-Id: <cover.1689673395.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|DB8PR04MB7067:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdb69cf-acda-4e3c-4eb1-08db877472dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwQbCMd2SeQbX8PojhZmpIZ3wVJh8QFoVNvsRS4aHSve2sFAn8iZz5/+NGtZr5465Ug1Q3M3fVj9S02lmOQGlepfEdtEhM2JLs29OiaxvC6jgAAY4q6Jq8+8ouhJc6iAxeoze+16sNUWZwox2BGVjt+pIKnViC1cG5bsziP2lUcAHjkJuvdpwSpsRQBXi4s+gi+roHppM2ZwlQwTyHCnvcGHZwwkV8G4ElXBpKJdVJnHg2DwaVDCK9OB+Wf6Xhl/KiMRevsLnj/h68NaXWSeHRMYb9xiWKQm2v14z2zU0iOkX4GuImgUZPtL+Vqy7vpiSPIVWIU4RpEJus/nVv6MVw8g8FMOyEsNSGt3FDP/cxtKIeMV5favBAqXRWERR3Hs+GuM+Fm7hS3UKjCSN32bbzIjjUC+lVvjxzoD9N9DtiJ6ck979Vb5uRPVLja+auFxeRow3tKDYxutvB5kWAuFbwHBpK3edaY9yBG8hC93k4Ro7FXoIgekLMlDNh/LIC3RBjubTEk88ZJLpZgu22XIeqkWu83vaPXSnEFtfj50DluFVa3Kv+AkQEv46D0pJpCSiuSkw9z5ojX6dbVgomdswPyZgA0ViCyoTtQZs0Umh21HiLkx+dymoAMPF3qUdBDP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(7416002)(86362001)(2906002)(4744005)(36756003)(44832011)(2616005)(6512007)(83380400001)(186003)(6506007)(26005)(38350700002)(38100700002)(52116002)(6486002)(6666004)(4326008)(66946007)(66476007)(66556008)(316002)(5660300002)(478600001)(8676002)(41300700001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V6//N9vhPvMnacZs6Ye30gX4i2OL8LHR4a62Jg6+j8EQi1MOPcfm5v8Jcr5z?=
 =?us-ascii?Q?9XYS5itEm8FIA0tskCBaw7OH8qAPJU+U1AvBIwKm64spSmE6w9dG4hQGyFNn?=
 =?us-ascii?Q?7v5ArpeUpJq3kj4NQI1eQTRdwfItBDy92WDphZSvSKaLiIQ7OSK76s7UhJrl?=
 =?us-ascii?Q?bmqzFxdLzi0B08saS17v9Hg/kDczWOtZMC89OnmWEAnf2JZI+L15BGvHDS9n?=
 =?us-ascii?Q?UHquhWMR7hJtZlAr+QoTExPno/7XhjBf4eQaJAZnaBkfRgDNwWvNFgYchUGl?=
 =?us-ascii?Q?LnVE1B+sCFwaxzL63sTUF7Z0NXayBGji0P3ltrq9PC7b8FajTF8ovoyLwwhR?=
 =?us-ascii?Q?VVn/I5LSineTs93tTnEe0jfbUe9hZL5tWyadogZ/lPSxf9tzq1+0r8b/aj8e?=
 =?us-ascii?Q?DYR+zGbCfVvoeuHLt0RX6EqT7F8UZ+HOnhvIcFnt7FDR0YJpfTMcWfFgx6Ad?=
 =?us-ascii?Q?VUPY8isJxxcdLcNE/DX5X7HhbPmt3BjuJ32Atd44QyllZ0t23VYE8YdQSaqF?=
 =?us-ascii?Q?yc8hHy+6RgMyV/8k6s97gPMR9gr9vFiWTBuT7EKTejk5gYWxBujwX1ay8j0z?=
 =?us-ascii?Q?u9TKDISwGah08Jet2jOFgDqJYTZFSG2uXGuQr5xl1DLMaOLzQKTq5oyxy9dN?=
 =?us-ascii?Q?gxdA/iJPQDDDHo/lWvbwbmTKxlmJLALctWGnIE+5CXEcGApGRq/Q7DzKLUVr?=
 =?us-ascii?Q?fAiPX0xxRl8Ej7/iAOi1+KT01+Yx7CSRrbygPz+B3A+i473JQqpL5r+GKwXw?=
 =?us-ascii?Q?i8UPeCCHunVk0ebTQI1bwpBGXS3wni0GlrVNcucbiZhJIbP+rg4cjp9Oh5i5?=
 =?us-ascii?Q?OxVGOpNnr2iBAnx9YWm/G4xRI7HWsoTtItm48zn5zIvlXkmG84SmLYSmkX18?=
 =?us-ascii?Q?RWSWXki2G6gfAT5P3HP4jUEtz4+Q7kZ8J3T8yqDR3ajAGo4xTYTOJrNSe9Qe?=
 =?us-ascii?Q?4zyLflj7A4w3H/3IHOHcwrwwdbANGATdQVn46orEjMwW3wDUdBCp+W8PZjG4?=
 =?us-ascii?Q?bKsP04y2KHSslLClLxV0ktFG2S5evoQlFMXpTdsuWZyq5WfOU1Sv+pW0lzps?=
 =?us-ascii?Q?enWaZoTp5bbxiDBEwdKj3Vo8+y4LFPdZ9JsMtY/n6/YFxRrBUcjXGeeXuwAH?=
 =?us-ascii?Q?BG9l8lHjqeA51CiHSWEOEp6QjTZNQlizjdqxk7/lPxnorjsDsx++TK+Uno/u?=
 =?us-ascii?Q?0O2soopzOGKs5MeAoEiJUhmg1r2S9tZuFk6MS71k/qkYwNlZyU/FaLnUUZzP?=
 =?us-ascii?Q?tHze+j6bQQwRtRjHtfGcBvfjS7+0Wfe8s5prQ+clsNac26nqVktRl0SfRTGC?=
 =?us-ascii?Q?x/ItR7kqiaGimT6pIhFCsNdcsvenWAU1o1tFWkOOrkMqTyWmyxsoWr6f0Icq?=
 =?us-ascii?Q?Oi9H1yxHLAiNBrsvmC8UxosUIkSvpyPOBu80yQmeSW+eKnlN5e88W2DjFdlG?=
 =?us-ascii?Q?tc+zOvrxzdKotg3wu4Xq0TNlCbF215i7E8AWuBUTsfKN1h0/1roE6gaWMqKI?=
 =?us-ascii?Q?57jQS/ODQskqTJFoeV9SlfFdPDZgDUwq9TEDIl23p4bjyK+XnFJCIGKKkfd4?=
 =?us-ascii?Q?a3Q6oyrTtEcaWpAz/3mpWx+7VHHbj02U3l08XYEk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdb69cf-acda-4e3c-4eb1-08db877472dc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:50:42.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2h5Cx8TwROGbpW8ZNA2WhGeArCVIgbpSrmVL/xV2JuQeNTNyloVOxSp9x7ax0KRg7pnukZu9DSx1yWonZPdhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7067
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity is a proprietary static code analysis tool from Synopsys.
And the coverity scan report some issues about amphion vpu driver,

CHECKED_RETURN: 4 case
REVERSE_INULL: 2 case
UNINIT: 6 case
UNUSED_VALUE: 1 case

Ming Qian (5):
  media: amphion: fix CHECKED_RETURN issues reported by coverity
  media: amphion: fix REVERSE_INULL issues reported by coverity
  media: amphion: fix UNINIT issues reported by coverity
  media: amphion: fix UNUSED_VALUE issue reported by coverity
  media: amphion: ensure the bitops don't cross boundaries

 drivers/media/platform/amphion/vdec.c     |  5 ++++-
 drivers/media/platform/amphion/venc.c     |  6 ++++--
 drivers/media/platform/amphion/vpu_cmds.c |  5 +++--
 drivers/media/platform/amphion/vpu_core.c |  2 ++
 drivers/media/platform/amphion/vpu_dbg.c  | 11 +++++++++--
 drivers/media/platform/amphion/vpu_msgs.c | 12 ++++++------
 6 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.38.1

