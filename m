Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F797AE065
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjIYUtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:49:44 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2042.outbound.protection.outlook.com [40.107.105.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86142BE;
        Mon, 25 Sep 2023 13:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H67xh/O3i7bem6ua5de9p2S2qBUjyZ15q9v5eHiKSaoLaaQP7sIoyKK3PxDLTJoDVXqabR73nKb14SjGwyCXfba6S3UIjcotHwod1YlRVvKIs7RxEE8jPyNmU+OjDCKrvuZ5KFvdXr4s+mD1vPVsP22WQL66MKttl6CS1G1Y/2gaSerS1H/f7vLOTdkJ7GIDPxa4PheTZZNJRoVak7n7VUYMHeTvfwfeCXrc2oxUMfdEKpNjxjJslimXOsDZbGmujqBUYSvHWubV9TERPzFnGjc3TDgSvCe+IHJRG8WJBea5YRehE72BvPS+s0a5nnBoLtkFqlsMaz0XuQ15KYPH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9vSr/55g5ootAKPrNkFQaAfmsipHLQeUOCxIu0sjs4=;
 b=nxVz0AE/qvIS8hMmTtWBymu+QIW2awsMr1ZzS5GtXtY4kXsLGzLgD7giagTOHUNd12c35LwdRkHFmY11iaTI8iwlQ99v8JqCZ9blWbAcqA5UamTtICZWlxtc25m3Di++eSP4Zx/TDx33W8jVaK9yMAzPD2nunKAyIMferMlDkG4piaVZI5KPyskJ5mli/CE8Q0Qv1Y0Cs1PJHkUspQL8tVv4NdsUoCopfY8nZJwjsHdI+P11B/nkmnMQhuuodFJ+8DNfSn4CrFY9WEuoQfWUMc+yFEJlkieGrCPck/+vfIizIfve2vpgEOMYlv5piKaBpWuzdHKxE6mlrOW/Apt+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9vSr/55g5ootAKPrNkFQaAfmsipHLQeUOCxIu0sjs4=;
 b=CBKDHbpdkPn5uRa/VwxPsc4F37AuQxpKp2ZEfBlq/q4nSRQWqEFAKZr7WJonvJx0mkiBpMpo7cPBl8xBoMsRgG2hr/Ji4adcPQL/Ysot6tdz60o+nb5arIZLYXTjOTjjc3BQiSkfJA7Z0KNVp5pScyNei1GZoUWLlpbSfLrgwQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 20:49:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 20:49:34 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        joy.zou@nxp.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, pierre.gondois@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shenwei.wang@nxp.com,
        sherry.sun@nxp.com
Subject: [PATCH v2 0/7] arm64: dts: imx8qxp add emda support
Date:   Mon, 25 Sep 2023 16:49:06 -0400
Message-Id: <20230925204913.3776656-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: ec65a158-206f-4d5d-6319-08dbbe08ecbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtFEjTi2Rc3wOuQh+UfcjdLEQYO/9kXAfJkyZAaJ7MkDOqD19PjOjS8If9o1N90z7+0iKuo7nrUNIZD8XE3YIELLOyVB3QoaTIelii0FAZ7WN0zUYjWK2PXZfEgVfW8jbXMR9HSwh0ham3V1AooAE+khpuolx97HBToLB8rRnKRzCsItwkYBejFkZ4P65ZH1wU2yfGYBL55THKEbFh9y2j1curAxcvxAGG54EZq2hJQTQuV6yZmquyqpA6iR4xv6aXCpQd1QoZFN8R3hXEfD0GcwFvGIkPqQ0iykydr/PBUaB0aQfXaptigBn56TIDYvmG9kDrz+J3H9MdKD3sgGjfLTPt6xD+R3i/pFHf6PB2XU7Cxq0feOre2nIYQ1QdCIj11mP3PSV4ApKfh+4lV2RmAOtejuvyWsD9bFgtGb56QDiEIVR1Fmq7RH0tVLudH3Mqo8HNdry/xBGGY0k9Kl2SDmRNvqeUVcS5v/aZzu5/x95HxUUV4bCM3aeb5oEX2Zh/ZINzP1Nouk6osO89nzOZHaYIGDfMyuVY2Mr5eZdYZdOSaHdhy7TvlFU4xMfSEIHep5rceQ0evA7eLkNex6fdmE9vArsEWAjBysETtEj/WOZxa4RT3C2D69h2T/1fMs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(5660300002)(83380400001)(2906002)(316002)(41300700001)(8676002)(7416002)(8936002)(36756003)(4326008)(2616005)(86362001)(66476007)(66556008)(66946007)(1076003)(6486002)(966005)(52116002)(6512007)(6666004)(6506007)(26005)(38100700002)(38350700002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKPKqJ6k9OO6g48BjWbnyEj8F4dMcmVilSjAIL59wlI03nKxidu1I9dt+7Zi?=
 =?us-ascii?Q?/BSG8gRyDUbRlRydh/8VXiQsgMsknSeAjFp230Ji/SMq1X7VxbujPNWCXgz5?=
 =?us-ascii?Q?WPSfRg9PWjSCYc3nlSretLQvlpBFfvxbczlEAIOKN/1j5m8H0Qf6prTc3RUk?=
 =?us-ascii?Q?o1LJmiYG2nMZ+IQQ3KVdywnF2YKY7HmFy0RUGkF9wh7D2U4vvKEtQeqrD4x0?=
 =?us-ascii?Q?vzR1XkO0dEWd7wdvw9ilS5dZ5L8chu7FTa+7OUAiNvF+/VL77+XvGwLPq2tW?=
 =?us-ascii?Q?XpXqJ+KyBui8Wz9Q7lXRTdelYygcM+sV6M57MJypRt49MFyLONiNgn3pEtrL?=
 =?us-ascii?Q?BwMdoGtz6xdINOf395GOCEhnREEMdIHzvts5+gAzFixir2dllVjs6CMmhmrh?=
 =?us-ascii?Q?Ug+Butbs6U6hw6QR1gEB/8MGD48yQ3RdPF2kSve6hF+6EyZszmN5je46RrXI?=
 =?us-ascii?Q?mzKrW2nYh4xV+RmotJdanmpBmu2GNYxbDKIigdcbRsCYAThJjIuE15DDlmXc?=
 =?us-ascii?Q?ZfQM13LQrKTq0u0lGi/pmQkeZcSuxRCBe664Ef5LqNEqXw0RnBYJvXQijcHy?=
 =?us-ascii?Q?TR+AJIUtFZMx34v3N0zpyu8eQIakkEXE/kxRNqe7mryRz4IKm1jlcZs+TPUb?=
 =?us-ascii?Q?rbpVN27Zn4rFxL1PESrBGmod2Lf+TGtKV7HYDkW4L9ySmj7fTUC+PKk4po82?=
 =?us-ascii?Q?f7RDgfroKogcfgH/o0mVAoR75SpvnybJEaoctzGdPksa83zeYV2CAPwkV16J?=
 =?us-ascii?Q?OBgT46UIhkYpUS4ULvNu6WLYESveItSW0rv9F4S9m25PG7oRnpoOWtDJJTA9?=
 =?us-ascii?Q?i4XSN3ZFetIG/YZbPdatTP/vf4e5AUP7JB3g5plWLL55Bgl+33uKRq1Z4Nd+?=
 =?us-ascii?Q?CQNHtvAQXHzmoNYaKCyGnZtTWFCAVreJuFayy9NZrLiRp9vh0QWoxDOFbStj?=
 =?us-ascii?Q?y58OUi+tqgZRwvVgbSD1Yw8bD57VbhZEnpTznlg1wpurnV/LzwHn5Ha7JbPs?=
 =?us-ascii?Q?opQUjzUJU5d+b293xBhvG2aWZrKkIzYQR1ozfcFOoLcczBivgRJSaMuAkvJn?=
 =?us-ascii?Q?KsPQOvqB+Wctdk3z+QKKO439/p1plmx9zMMrzwnFMB3oeQgVSmlrGRJ5/KDQ?=
 =?us-ascii?Q?WnkC/3Ce+DcmmKcwnm3mhLous1APZX2aNCxgSxhyLx28npVIfknDtIwhbIIb?=
 =?us-ascii?Q?QT7Y/RcElHYOvytUUMkZ5brOoPWcJ1dkzX06csPext7snsJnqCuWu9TYUbo1?=
 =?us-ascii?Q?SgbYwtbg+X6Yvkt79mmBg32lYq+BPDPIFgX0IKBtU3SFjuhruXEIN0L7OvSq?=
 =?us-ascii?Q?dwveeTcDpyh6JwqR6/jskSQlp/7ga+Dm5T/GqbCqJK1ivJFCBw486nQi6fqj?=
 =?us-ascii?Q?1Jo+QUMgUNF/AsgI7NKxvkFr0P0+D3ZArNAguOZK6H3NFQAKx9kfh72HBJfK?=
 =?us-ascii?Q?sk3kJsAmVvbGvpguUQ34Vd36pdyTi9ygwX/KAeMkR8yacTU0ak0nmzqG2zGG?=
 =?us-ascii?Q?ju3XTfWKaFTjB7jH656kXWeO9NvY0qhTsFowEETUxgGxoqFLMJrU9QnZZr6Q?=
 =?us-ascii?Q?78OT1Vadrci6wSvxqpk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec65a158-206f-4d5d-6319-08dbbe08ecbb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 20:49:34.7472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0QuglkDj13YuIUgp1Ghc1wqKtfzYYTvMMJIWkIDLz1hWwPYPpdYJLxop1r/EpNuYTENhIhCw4QmAL8gihgI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

eDMAv3 patch was accepted.
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/log/?h=next

This is dts parts.

Add 8qxp edma support and enable lpuart1..3 dma support.

Change from v1 to v2
- rebase scu-pd.c to 6.6rc1
- change "F" to "f"
- Add 8qm edma dts change.
- Add lpuart0 dma setting (console tty will disable dma)

Frank Li (7):
  genpd: imx: scu-pd: fixed dma2-ch domain defination
  arm64: dts: imx8: add edma[0..3]
  arm64: dts: imx8: add edma for uart[0..3]
  arm64: dts: imx8qm: Update edma channel for uart[0..3]
  arm64: dts: imx8: update lpuart[0..3] irq number
  arm64: dts: imx8qxp-mek: enable 8qxp lpuart2 and lpuart3
  arm64: dts: imx8qm-mek: enable 8qm lpuart2 and lpuart3

 .../boot/dts/freescale/imx8-ss-audio.dtsi     | 88 +++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 78 +++++++++++++++-
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 30 +++++++
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts  | 26 ++++++
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 56 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 26 ++++++
 drivers/genpd/imx/scu-pd.c                    |  3 +-
 7 files changed, 302 insertions(+), 5 deletions(-)

-- 
2.34.1

