Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0075AA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjGTJAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGTIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:46:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF82690;
        Thu, 20 Jul 2023 01:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3ln6wv9wgggE+sViIfBmqSyVxBT3NheHap5qfzp0FQw8A/rMN9/7BwN5bGoQ6oBTrsev51ki2uVqO0/WBZikT+5Oed4uw/zFNszIDJS4HDY7TEhnbg1EVd+lUkZtOw6lQMlFltgzfKqThW8nhmH5u4g3TAkiXQATvlxh3lm8OYv64NHjrVOQwxPyN0szsWgIbjNGHPLY9CBP/uWWUUiKhF5Uinmf7AmjBG89aVebR0DNlWKt8lND8ex1dMwrffmfxFsQs6NWaYyZu9OfuscLAW5sAnD+xtrzeN1uCgXM87T6Mgieu+0cEM1H1UtyjgIHV9G5OjLxbttMx1e7kFKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqXuJob1MKcmKEhzOn1N85uEhqNHdw1Wt8Esnxw13+A=;
 b=akF3Y86FqUUayEIpMXaj5GsYGKYOLp1JffGiFfQ/Gxk2fs9Q1OKNp/Xh3El/HM34gtKrm5UzR27hIoVDAK47xwSYcIDDX2BR9c6tEQrzfTXKLM32/KUeUZds1JdGkktBQzvQaBST7G9xP81Plb3pjR/qy+fCJDYxOfk1jry6JVUqa80gcT3XaOubeZd+Lz6wZu4plAPYkZzCR57ytD8dXwJyybODnoR35fpcmPOX0zwhWgSKiLYTavpVNqKnxC+3xcqovJaBFgmxpiWu/QuG+aMPFAOSeEFWyv2tNUV/xD1iyFCgfh6pMK4mS7+wj41p4qc7h5SFtc5KDroa1Rp0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqXuJob1MKcmKEhzOn1N85uEhqNHdw1Wt8Esnxw13+A=;
 b=XRjcnQVn0R4QPUIQ8zLiip1us96VVcfE64GiDJj8p0Nfe5VFm9oUb5qzcCcJiT68JTRIzw1AwXQN7rVFcbHEWH7x4dGkMpl5b0/XedvHRH3kHDfWHXJNUnljdJq+W4OeZDdJOpXNVdogMaG463sTElNHEU1D38PSOKvC2jSnLcI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 08:45:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:45:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] genpd: Makefile: build imx
Date:   Thu, 20 Jul 2023 16:50:41 +0800
Message-Id: <20230720085041.501344-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b9af24-3b17-4227-256a-08db88fdbb32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQQyJSnKrk/tmbn/ppGwDd5uogG09Et8rH1RvP9WMi04bFWRc+dZVriiOZ/X9JUzvgu5nY/BHN7OV+t9J4Lhz9h013oFX32nGoWcEeVD4yshiRGBQrfiOIwjVZsOQb3pA+tI5Oe90dzluoQtQZHsD4WceMn8oXNfXPL66zkofC44+MBE9yt395PXyT8V079fXmxyMxyLhwtqtXrsWYKj7sH99wPYWkh1ZfaOkEzQmkPSOZ2JRE4kAmO/uMZ2duMHD78djFeRa7ZIh4T4nF/cVscD2jhxdSsP6N9S2iz1j1YzX+35sTjbfRxqo1dpNskoR5tOstzNVdj6NaU47YkjsRF9E/A9GkyvbDIN3NqQcjawsAC72N+SB35en4XrM/DZNe9kDnxV4zxu2pYowcJ2Z6H/FCRqJbMIUmNaH1qDwI/rdFLb85pq0HWiFcj744lrjk3K3BJqL7q9v5qGXFR1IJSsxQObz1JFuHe19IqQFXYNNjZvO1VnE+o4uBCZlop/E9wotU6mNf7YiebeL8ftRes6CHaKB0A1mXHdAK+WYiEWcwJVthtnjCbuwZg9AWMS3+UAR4jRlc4yxitLS9nbDqIJhbMnJJTBbEFSJCCtg3PFjQeyfR5/xl8KcMHR1nRP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(4744005)(2906002)(2616005)(86362001)(38350700002)(38100700002)(66476007)(66556008)(316002)(66946007)(26005)(1076003)(41300700001)(186003)(6506007)(4326008)(478600001)(52116002)(6666004)(6512007)(6486002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2w9Mq+4emCj5lta30WXbAYBtP58jf7KJkEGze1PlWdovgWHM7q7x1/YGbXsH?=
 =?us-ascii?Q?SJrPOiXxka/GKl+eKvWoykxGfBcsPFNu5oc+staCe452kvwQsUu09zYzUJ98?=
 =?us-ascii?Q?iUHXLI8Vp0EZqBEHeeKn/T3dbyNVyRRuspU1GFHkeFiGcER2EreDXL7Vsr4V?=
 =?us-ascii?Q?B9qcyL7al9PUj5jNr+BC92Y63x8Zi/0Up3q4/Cuhcw0+KWW/itomhgvaZULR?=
 =?us-ascii?Q?U77ol8G1x1tfLkYcqTt5Vn4vAGIlucrhkGqmdAr4OPE0TJ4jkLyfRvnYNtX6?=
 =?us-ascii?Q?plVoks7To6gIidNvEyiTLAz3G0EBuFHAaxVtY24yaph4t5tpbCCeNfjKwBIk?=
 =?us-ascii?Q?vevE+LHjNo4PgzBbwFUWh4wnYt1X4R4PVVtgGWSyDhOwRUOI/rnAeonk5yj0?=
 =?us-ascii?Q?1SXWaT5QJ7X1GriZcTW+TkIeQoiA3eLtVQJtFETh2tQ4/ibMrL2ZYoN0iIW9?=
 =?us-ascii?Q?PqoMzUfzpF+X4wT7o0Ksal/FZwVC1pot11/6/eGfGwVoG5lOhilI4j7VN7w4?=
 =?us-ascii?Q?a7psNrLokT6o680s7BYYtWHpokIzGW9pe+Bll85Fj7FKM/hYNc/z08W3OFyU?=
 =?us-ascii?Q?fhMcLGLpbCbyKhrOxzo7wfQ/j9eeSAil4J4/x8yMKKwgWJf9osOEAIH4/GMq?=
 =?us-ascii?Q?wZI2qmm84CBNOg7wRLlaMpbNpwkbWeZoSVN8BB+swjjfwCRukD9xyhOtRVes?=
 =?us-ascii?Q?ojb/a80/3befkIiGiuv9m7ODg8YvpcjVnRG02SU5FTbCQp+V6rSgsW7pYayn?=
 =?us-ascii?Q?rB0GTbaiw19RE1vlX23pjmXLHgsmpW4+4kiknx2bxCC1VdWWOn7h5m7BR0Is?=
 =?us-ascii?Q?PpTgj2MTEgvVWum5Dx0SurhmqVSOIrYjPyGjmb7DIe1aHbCEewMPDonAbs04?=
 =?us-ascii?Q?Qow7dbauNZsKJVw86lcfTyyVgKGX5CUJUZXIwZYAzwGjw7cENPHHdOz1LI8f?=
 =?us-ascii?Q?p07kS95S1wQx8uujKefRR5Nn2PIbMVM3buUZzzeTlC7pPILstb0qG7MgKf3b?=
 =?us-ascii?Q?c6/RxPNE3ChCDGY14dWYzfWm5Yclm+YTndo4ZzkY2ML8JSX9VhdUl9A4J8fM?=
 =?us-ascii?Q?j408RgrE/8rEZJCuUwD2Uucxo5052cD/buCob0e6JGCiL8YSbZ74NORtlgwD?=
 =?us-ascii?Q?KEJZxXEFAnGf9Zkw22OO8kaTX7hUQytxZoIR5ASKCMzfg3av+9Gl1x3teO/C?=
 =?us-ascii?Q?4hVQU6kwXN24RIjutXCrEIMk6GLlbNRUF2mar+I3L1IkDybmwaVO4aTdmauv?=
 =?us-ascii?Q?PTTlQRxH2VQxpm6acyKnMFam6DJ9HPWmbXGtl7ouCQ6HDPnqpirS+lt45t0Q?=
 =?us-ascii?Q?sHe84XbM2KojYL3Kk9J4YulsuXkTYYJFZq6MjxiXQkhDSnklb71ka8+VLCq4?=
 =?us-ascii?Q?u1BXMlyvT+uPyBUwuXAxxMXwTKbJSFC4slGeySpGlPRV0JgM2zqBRhxWiRIL?=
 =?us-ascii?Q?TNEOOhGCvs5doNje07xSLC/bryPCmSM1ELcqwRKg9m38Al7lLjRJprnZdgcs?=
 =?us-ascii?Q?QdNwF9t4J+yfhIWk9cBzoQMnDwjrcx6T+aGZxplkfi2Rx9q8lLX5dokeKWbJ?=
 =?us-ascii?Q?Mkg/zoup8kVgLf1H9ZuJmiKJKyNfZlPQIcqppUP5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b9af24-3b17-4227-256a-08db88fdbb32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:45:55.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbY+ZfyFHOrQVGEbxCLtMap4zPXE4OsdgLoNyhfam3qCGWH+MwX/9mGvnWr0swB/47J7lWUAAUXMYqayiKIjAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The imx genpd was missed to be built out, add it in Makefile

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/Makefile                   | 1 +
 drivers/{firmware => genpd}/imx/scu-pd.c | 0
 2 files changed, 1 insertion(+)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (100%)

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index c429485c13f6..666753676e5c 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -3,6 +3,7 @@ obj-y					+= actions/
 obj-y					+= amlogic/
 obj-y					+= apple/
 obj-y					+= bcm/
+obj-y					+= imx/
 obj-y					+= mediatek/
 obj-y					+= qcom/
 obj-y					+= renesas/
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
similarity index 100%
rename from drivers/firmware/imx/scu-pd.c
rename to drivers/genpd/imx/scu-pd.c
-- 
2.37.1

