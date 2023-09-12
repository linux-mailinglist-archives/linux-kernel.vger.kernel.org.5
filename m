Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90E979D4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236355AbjILPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:30:57 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54FC10D9;
        Tue, 12 Sep 2023 08:30:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHsoFI4vKAQVwlYiefDCTA0yjbvx6eyL2q3+RnEjxgg3xvx0eaFO5keRXKFSknjPwGIibzeO4VqmjdIe/3XZdr7ikGUBEAupFw84Dh0MvtmtIW8Boe41F9vNWf0DQFTnuxdVWUCsp9hsxcqTWYAUdoWrNHnQkxqrDazcZfg+uApk5uanVpmzuMXWAPhI1Pzt3wKvRQHt5mQ2P7H41UfVfwNf8q99S/XlifWorZkwbFn/xwMYm9mk0X6/+Z0SPq/yO23fMJNJALsXGQkscPejybA2/lbb5R72SEj7PkcNwRtoGmYboYSsBuKjzbrCyarX2+tat8YodQZjXjURxMwuYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1Kshpw2EwCBA4uYF8ahVWTreIWLjRHnrOX5Sjjpj9c=;
 b=PxbyDpOXXM5tUG44vWxg9rSz4eTVlaFs5e7ytBYFz8Nqr97MhHMSX/f6AFSCLP4dI5G7VS64WZQUfsLvhLJdhoEovZ7jIwXKcpsZaRwK79+c6X1SL7Rxgh3dhhYkjIrxiqpzF5CclNSdqo7hZ9rStULXA6HWBlgLiG3DqN8YTqC9TvWd9dwe1Eo2fcWTN2HMvbFfbAYHckz8YoNzDYLnRrOxRZsf59/Tbara2/rS4inkoxGunfYi3OXlE5hr8h0eyAojYeFNk481pbcLJVIrNwvgYOPEM8p8FwJQ1A7usOiF3GceLhJZaIQC3ZcYQq7E/QCSFDhnwZarChpuhHePlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1Kshpw2EwCBA4uYF8ahVWTreIWLjRHnrOX5Sjjpj9c=;
 b=Yk+3xV8rmKF+8dTMYzX/NoPd3gaEGPnvpm7jCTyf4caYiHoFKJEc5aJE3xp6ZAcZiuoDPrB6ZkDtCBCtD0ldIOJuJeIRHIQGOdF8sok7JQ/sodsdic6t6MxFEUK29XBfh6JdkmY4uzqBRjCZms68aJ4nn5st1mJhJhjXnnzIL3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 15:30:48 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:30:48 +0000
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
Subject: [PATCH v2 0/2] Rpmsg support for i.MX DSP with resource table
Date:   Tue, 12 Sep 2023 18:30:19 +0300
Message-Id: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 8808aa3e-b01d-44b0-df04-08dbb3a53d78
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFM8wCuvKs125MKSa8FOm7ct7uPZNXuuFV0JZ40rCOCg2qdxBJjUhi332cDSHZKt/YJgHKLAg+wf8XffkDnHmelEHkdtCzne7P4lyMfae677b3jxPMzGCXmGt13SCzQZiC7VeQDnj5SXnket33SzaOYPYTaKyIWQr75DqtwX2ZBlOV+Re2jLZ8wAYMspSDLQpUDYPka/aOGD1NPACKL5LdS+gTyymnTy2raaHkRO23C8BbLVa7jmZo8/tZx7x6UmsFE/e8c5zATcdHsAoWkcy+pzesM59i0W+tWMn4mt5QkmrYp3cgbsj6J/1rfMo/H6n65cfvo4iDL7M1P1N+olRK+Wh4qg26H9bT78iT2oiUHPRrTuCpEWnGILXd8JnKZqaNFCti+t43T99FfqZPx5yxX84Jn/W2hm7aFuv+VjYa3sdEKQQywqtuYG1YcWMALkUBudcyVSvxhhLnqZ7gWWvxT1waPfdGasiSjV9c0VZNk6nJxW88PxePPB8mkh8nwjUxaDNiJ8lbTHYb2BehNuIMBzsgFb1zRgb2eX6yPK10qaPygxw08cvSYDUv54cS5x5ui6j8xT+9TIstNpBKTMHeI2GgfLVf0+WwtsX2psLO3du9yWi0V/MR99QWGMxsIoFiL0AkZrXat+ekmCe6tnxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(6512007)(38100700002)(921005)(38350700002)(86362001)(6666004)(7416002)(66556008)(6506007)(5660300002)(66946007)(316002)(4744005)(110136005)(8676002)(2906002)(54906003)(478600001)(66476007)(8936002)(52116002)(83380400001)(41300700001)(6486002)(4326008)(2616005)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7z4XTw0H3WN0FWu2SGVZcJQQ1C1LZIauYBsS+GnztxVALzhXl3YqkTJHiOA?=
 =?us-ascii?Q?JtJht9j0bb0e6tqldHEntCowvmPOEncWVqtMtM1DoxkLR3YHb+cpXgNhreHS?=
 =?us-ascii?Q?NI+syxXUE3nRNzY4SOZXXHXrr7KUsEZf6qL3v08ACHu82sg2nnJB5cYvb2Wr?=
 =?us-ascii?Q?GxB9v1GZIjZpcwFP9KdhYib/C9wM8LpnNsSQSxCpevVvoaCFCRrins1HMv0P?=
 =?us-ascii?Q?tI2qTO/AEe3chdfpT2FlyEzi82nwGKOYVqvSNW6YqvKT970XDTgp/eIFgwWX?=
 =?us-ascii?Q?JJaNFm5qQ8Klah3RS7VcSon0JePCRMEbYt0LjReP+YxOZDoQO2DEXicUK42S?=
 =?us-ascii?Q?nadWHcz2XG4YAAew0kTZ//N6MhqGKIPybKOqeNZ1Irtwj80tyjYVD660ZzE2?=
 =?us-ascii?Q?1yEkCwMvP9GQVraQkN0VLBo2q6KPUeRZEvotwJpzJQkgwQkBAs+diBTsAI6D?=
 =?us-ascii?Q?wjT+ckvtx0kx/62Z8lW3AiYx6eM2I1wcO0dMLOuP8cX1Mc/OhhzdQiemSSqa?=
 =?us-ascii?Q?tCF7Qr2TPXbFVsMcZXO41KbuWEKt09eXceXnF7Ia//hZwyz2bA/w0fw2RvP6?=
 =?us-ascii?Q?rpQmH4na1SlrdoOPmOYvmRLJhPhcKnavSNhbWa9tUudfQuylXQWCejR7d6mm?=
 =?us-ascii?Q?4kGozQLClACed0pB9rY3Dbl+llyqLZShWG69wOJ2QW9n2FYRr/w9BGTYClFl?=
 =?us-ascii?Q?r1yGuPehIHmxz4T3lF/YobKNRHOV39UsxH9tzAoUJHXWHAuu/z1qEhd8qMmW?=
 =?us-ascii?Q?mh/km2eZnwtCEw3OcSY5fVHq8sEcThe8QKHqZ+/upUM6FiNTt2DPc1N2qS+9?=
 =?us-ascii?Q?+Wif0Puq9UF/03cCyMlsguJd7mayHpLmqlgbwh3wXAedz1a75TR2Sz/pZVOh?=
 =?us-ascii?Q?WsjV3SsPcJ7krDitXjq/R3WdSWAebUlrNpzDNccBA18SPmAClfan2XNAaNRq?=
 =?us-ascii?Q?+DvZp/VDMl3bf1Hk0mVeXTzB1Aq8jXYgDHWQvCHQFiZsIfbcrbhzVbsqN0AV?=
 =?us-ascii?Q?5S8mn7u0wqyCROxoSU6vzAEZQz9LhjFDl53EIIvAH14HYdTbE++tf0j4u8SS?=
 =?us-ascii?Q?TU3Jg84cy1yhK9LJIywea4aD0ikmM5pJ5xOPWPekSVc36qvlQgswirt/7oc6?=
 =?us-ascii?Q?Szj4O4DyEp41qckbbmWXhMfBGxOKLl/c5b1/eIlXHaPEun/THQMZNA5IO5ef?=
 =?us-ascii?Q?nTes0hPH8PQ6EuGYpo3WnYOh8T6xY8pFnCFi3XZe1UDXDWDMpLdQivwIYYWs?=
 =?us-ascii?Q?GbA6Nq/A15vuYqzP1nrK5QB4fb8+vRUWgdzcYRpq8NOWHzpDQxBH0fd3Ah+I?=
 =?us-ascii?Q?9teEc1NSl4SAJ8CmyJ6hhmmI1Ygi88Mapwzcje12ApBTLkp6c24IcTJ9yaws?=
 =?us-ascii?Q?9G3F28D0/IbbKgbH5VdDI/ZsXFFjjtCtWW2tRlYb5BtEcFHmtZAmuCYRvdaX?=
 =?us-ascii?Q?0FLPPwxibwjUX7+fJ/TLbk6morXvCY2GiFlwTmOfvV4tCjM7Ooh96kfGFZ0K?=
 =?us-ascii?Q?25j8jGumNW9KIAe06LtgkfGdNhwmCkebvFw2/KykSBVW5Adw/Ln37x0A1pIN?=
 =?us-ascii?Q?7cd+wPONRZW8FxNKd0XFYMxS7z8L7Y9hLVNveE04PLwUJX0uQz+O359ZvdTB?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8808aa3e-b01d-44b0-df04-08dbb3a53d78
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:30:48.7404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXVwpipV9IV4jHZr9KA2UE+4wSLLlsdUbvmsp5SHuuFbbvct+RO3pvsRgjUdPNZJUKroY8PlRl7/ESAiNOGUAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

These patches are needed in order to support rpmsg on DSP when a
resource table is available.

Changes since v1:
 - add missing bracket in dtsi (patch 2/2)

Iuliana Prodan (2):
  remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
  arm64: dts: imx8mp: add reserve-memory nodes for DSP

 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 13 +++++++++++++
 drivers/remoteproc/imx_dsp_rproc.c        |  1 +
 2 files changed, 14 insertions(+)

-- 
2.17.1

