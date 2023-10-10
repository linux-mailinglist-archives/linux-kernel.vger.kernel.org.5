Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C8D7BF6DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjJJJJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjJJJJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:09:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264FB9E;
        Tue, 10 Oct 2023 02:09:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUTOWzGfF0c/caZujYQt0Psdx9A3dTMKJVf+ugopRJCKvT9A2jtLRQHEfXLdI2j6sRfcWHz2McY38Uzveycjw9PSHQJmURe9gNVQyKz47AkZVuBV2Zf/KizGUdC4NB7nvNQEBPJIL99KOfArcwrVy+UAgBIvP3Rk6TfU5s+RMCTpFrlTASUUOAFrQGtlJ8c2btZ90Ny1gnik3bo4jZlS6erUod7W/Wve6jF05m0+ZLIl9iDkXco/jU/8iCZQK6McOJ6pi1JUNpPbTbZLQrGm5RAH5sb45oxpA4WrcWWItSojsqDG4SaKzehzjYfYT4T4bl0PLNG/IshVphlZqwdYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJUpUIVD79MuCYgfvf/E3+Yigi4UFkQOTEFPfojDDF8=;
 b=LThaOcdfFOSD9ZrICCf2arXtLlLn3v/7hPROCkcS+gb6xht21LA/VAQJV3M/0mXDwqelLmH/yJMoe0KBicdFPXuICBPH+0E8NtAYQs+SzSu47PVATI4702AidlQshLoshc2pvO4dDfwZMvVciSwmKXyTVMxapGizje7FE5wQaCcYvI0En1vUnKHJ+ySO1L5vSEGeSKHdXpADRHLwL6vaKNhOcwiHGCfsP9Oa3V/L7zf3TcJaZf5rz7AvsywpfiuKw5bJZTHOVm2zQj0dUqLmsksFF8+F5JiSS45NVk+Cc9bPGXwURlsgbHm+znDSl7Q9NehL/2BlUhz2uHYPgW9uEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJUpUIVD79MuCYgfvf/E3+Yigi4UFkQOTEFPfojDDF8=;
 b=GkFl3IJNlOw/ofXAhMTha71ABChjKbawwZV9WOTK9bmqRdNvVtsAovbwqnDFlwGC8/S4P6SLOMU22AWlQB5imFCGhGx7ZGs3y//kcAoPK0FEJ/oL2AXuDKIpupv87tcHLNPWM7oMCq5dgEIhy9D772sIc3KokQF5JwIJBTFYvN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PAXPR04MB9059.eurprd04.prod.outlook.com (2603:10a6:102:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 09:09:48 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 09:09:47 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v3 0/2] Rpmsg support for i.MX DSP with resource table
Date:   Tue, 10 Oct 2023 12:09:27 +0300
Message-Id: <20231010090929.4371-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0054.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::14) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PAXPR04MB9059:EE_
X-MS-Office365-Filtering-Correlation-Id: 2697c9fc-cafb-4b0a-2c15-08dbc970a6eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOiYTjWKUCbYAyBtDpMyrxvAmBO82qywdakbLs/QHZBpPqXwdl1VG1gB2R2fxrimKhvL7u/3vYBm4I6t8HR4lrgyqZfgKExEudwFKQvoCXsUbScjhizM6zMxCnosUCMBFbE4p5P6cItEhyYLNBjYyO/Su1080eP9S1QS4brD2nvdZGkfLUJvW6lHntq+EdUUtZ0aP1JhqIfkIA3z7pjd5F+mXgBTSMH1oUiutXT5EWBkeRRdq6TgyfJyvQhsXgwpnWOs4zIUtKOXlz7qec009HTzDug7s1e5tu922xUzOgywGHCu+vA3AJKZSqnEPNF88MaFCS83qpwrnfxaw5wwljv1cbEV7tYHBXH0UdqOKdNP3aG/1nM7fbJr9M0OkVFAC8Ay7dGOr5rOssylirrmjWKBsgH4DaXKzDQc3KFSNdeLrqTbEFQvNqy32SqTL8xN+adNM/fDxCB9036SQu0AlgCfqwxU+YF7MGF6UrvwBC6MlyWa8Wlr4WnfNP4oB3gAWWYM5jDlIl/DKR5Lwb8I8/5R0R7v9Xec6v2XQKuGSLZfpIKzxjTyNk7XdrHDB8qdbbwymZE39cNE5/jPnhdqtK5t8NISgHOHtyGNKjjuJ53rNjVLyHmDwK53xgvBnQ5+4BZV4giyquf5x+lAcGYp2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(921005)(86362001)(38100700002)(38350700002)(2906002)(52116002)(478600001)(6486002)(41300700001)(6512007)(4744005)(4326008)(6506007)(5660300002)(8936002)(316002)(2616005)(83380400001)(1076003)(66476007)(66556008)(66946007)(7416002)(8676002)(6666004)(110136005)(54906003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ninyk1h4UCoZ27CDkdztpqZkO7E+pIrmhpT2IEFAHFYeaOTTInelaBS6rkr9?=
 =?us-ascii?Q?n2+SeZgf9D0315r14Wz52Xzfqhawg4t/LJRjlbrvGSZ/0qKE8rq87l2lCcV0?=
 =?us-ascii?Q?6VCpk+cRxQqwDDPb2n0uallURaktl1mOUEQ5o3xvbNLt+PxOgcbSDL+JGr7n?=
 =?us-ascii?Q?O2qc4GsTknTEn/VgQVWkGf0LgMJkJ+FlCjfIDoW0OFJajT5DvRJxk2yU41G3?=
 =?us-ascii?Q?tSAZY9Pl/byUWvQK787xuAUbl6vZPXRILufbYBY8eAtuVWJq1kGK3G/+Kvn/?=
 =?us-ascii?Q?E4tf4cv5btwim+QdHVHC9gCnwP3QGngaDKfiFUzagDvj6k0LWFyeVQp+TYKq?=
 =?us-ascii?Q?7vJDblDPdsrz2QotvORrUJ2CMdmR5GyNKnr+ifDp3q/yH+OnCdFP7GUAinS4?=
 =?us-ascii?Q?wieyiPT+2mVR35u918+K1yG7odv8USf4+6JSkwKFB+/cn2yhU1DPcLYruoRE?=
 =?us-ascii?Q?KeEc/KgqZsR4K5qI8R5IzIht/Ddmhqjg8euB/Rc+GYiHeEAIe1FylPO9LN/K?=
 =?us-ascii?Q?AjWop8wGtMbiz8z+FDAJiG7OwLUtCJSEHWjV6vLsDJtTIokTF2rQPP/ZXTtQ?=
 =?us-ascii?Q?lS3Wt9PEdJJek702niE610aZfcnLGwyrOICMe65JTFMJWi4J0Klv9TkjTS64?=
 =?us-ascii?Q?VEjIPIHc8Scfr/ahBf8EP59ceKOl92wJPvLizZYF7m0zWElc4v4O4hEuZn6P?=
 =?us-ascii?Q?7SfTgZlfzWpIxyGWDWbdhRD2KajQ26VNiQlxT6oVqi7WNpvew9k5i3+QpWsu?=
 =?us-ascii?Q?6ExXNTGjDyU5fGyfNAg7veDVJzUwDUYcQsPYQv5FdBiMiw7ZFklGsSuo2TVl?=
 =?us-ascii?Q?EuO6O7DWQkrMloAVw9hNdtO1CVu9uVp0JULpxRbzJXxxyIPhHN/9n+9AwOoR?=
 =?us-ascii?Q?etzYKvsWrMV5FEYLXlHqyUtf8cJ12EeHo2vJsXcvpBAwzuAinGoQDXblzcLX?=
 =?us-ascii?Q?Y+ymV/Emnj6abri+X0OOYPd7FlCVIdIqW/+7Yu9umRqCJujWfQ4wqVQ+faul?=
 =?us-ascii?Q?HneZh1jRrT+Ck1LA3jCh/XxD0YDfpEwkj5r3soSNA9y2zUPhp6WZWSj6h9w3?=
 =?us-ascii?Q?y4wc87YSZmElsIK3WeOZJ5XMt6xQjQEaq3NP7CULd/4CV5J87iUzjP1/SB64?=
 =?us-ascii?Q?lDQaun4dE5q1DJD5rM6rjLQ6RMoFA/IzCZlrdC39OAbGVrMPsTVWI5P0huBz?=
 =?us-ascii?Q?A+V2FPV85B57QSCa+6R8eWU4lyFA7AhqjFos7aDaLsA1QTmqIUIKYCAxMoNc?=
 =?us-ascii?Q?0NxWd11FATNU0reTbKppLKppWUfssEwqwNjqtiT0JSl7hpNFmmoPtIKeC7uP?=
 =?us-ascii?Q?CzKUEs5VwCHKmA8sMQ/qr5ksAfLKXAB7SYZ34rmk2Ebupe7GTLAKuB3PhJxJ?=
 =?us-ascii?Q?DgXF7ewuV7GLed0gnTt0QcKs/xMm68LBRZKZ95jLygKWFxH3z6ebr+QymtL6?=
 =?us-ascii?Q?Rg5VQdzxr1DTa8LA1d+0s237+pS3gDls/5qVOAlv/DI9C+RqxYVqmYo2PK4K?=
 =?us-ascii?Q?zouJejIN/B71NUdQrlsMtQNKR/QpxfkDIWGOEOrcZhwN3DQv2+X3slui4Mod?=
 =?us-ascii?Q?FVL5IcXbT+pfM7mHtvCCO4SjQPgDOw3rWhwzPbphryWCYcIM3aFY0kn7HoWG?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2697c9fc-cafb-4b0a-2c15-08dbc970a6eb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:09:47.8922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWeTTzGius3zZ++fwLMCqmawqZFIGvCyq8V2n+IYWzuj6snkr1IU/lxl2wilIWWGeQY0gGNCUQFdqs5dN7DGZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9059
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

These patches are needed in order to support rpmsg on DSP when a
resource table is available.

Changes since v2:
 - add newline between nodes in dtsi (patch 2/2)

Changes since v1:
 - add missing bracket in dtsi (patch 2/2)

Iuliana Prodan (2):
  remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
  arm64: dts: imx8mp: add reserve-memory nodes for DSP

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 16 ++++++++++++++++
 drivers/remoteproc/imx_dsp_rproc.c        |  1 +
 2 files changed, 17 insertions(+)

-- 
2.17.1

