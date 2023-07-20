Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4317475AAAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjGTJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGTJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A9D2709;
        Thu, 20 Jul 2023 02:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwRwJp1wC0QASSV9BZeoE5aTaq//8TqHjkCQh/PNScMyt07S3ZOh4dv9PxXiqWkQins2/zswWTEvgCbJ1UJvpRrHrlIiPr/9U3X0VXKpcxQkaSUn82cs1khUhMx2DdEuBFRqPl2GBrwZlSpiZ1elpplQCVbjiGdkbcc2dMfpSgO6TUseFjfAQnZlkXskTS23JWxL+JeMYfMsajNh/t69uFw6okRHELw0bEdV0ltpQDtlOkW+7JRRQe/DvOEPkU3RxIPn76X7pp/Su2ROIJcOg1azcB5xnGOplH6Q39pCOnyCRwrvmiFVTjwxoE6BEbq+wonUJHLDxyYu9d6ScMBi9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyBVgRzpyg5IR6E9+CmaVCWGHJxOd0Y7s/6JAqiYs+k=;
 b=CiZT3V5TGKXlrSOBC36resIS/egcDW3UuYZJEtpq+8N5LibUBY8nnDEXj5HZTMksF/N4UkZlNANzRoR0nRlb3Xsp9Slf86YOww+YyONHhvpttC5U+WKeRjUoLV43hdAzuTImQeCYSVoHjKct2/t7MFJFYxDWvReqaY0c8+6BpRaOh/2DwbferOWqqjmmI4GHnF2GmoDFOk883kqqesDfAky+oEkqUvWX6xoABv8nPGtlvBgOxslMJE3ViD79ywdp/OKNCfK3sp7rlvdvaiAqO0oYmQwzhM3TOt6fR8RJxOr/xOSDtxYYTWRkwyqLH1DhG2ISvV2PLjWroZllUxc2KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyBVgRzpyg5IR6E9+CmaVCWGHJxOd0Y7s/6JAqiYs+k=;
 b=X5PQLF2CA0EE3qppq2hVVG5BdMEwljGx+p+zy5C8zW05ZyTBoo0zS0yIUIa9dwgkebfL+5t4566C1gZQy0zAdwLcYSNpw54lenv0xUoN3wukjA1+saskIWpkUGHQ+zPGguLEitF9/kGWEVomPjnWjA+YxHWhM4UA5vDwCJ/1dUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/8] genpd: imx: scu-pd: do not power off console if no_console_suspend
Date:   Thu, 20 Jul 2023 17:16:57 +0800
Message-Id: <20230720091701.517197-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720091701.517197-1-peng.fan@oss.nxp.com>
References: <20230720091701.517197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: fde83e8a-7cd4-4fa1-0ccb-08db890171c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No3zx9GlU3pxmD27rbj4AGaOWExjl9wvb0V95fQMr3pZ4d2Bsk0S4oAjmnnqohUczOpTn4pKjXlY5aAkxpvCgIo2H0PqUIwhTfQFunwmMplHQSIXaYf8/Oh3nGEddBRYrnn9NiXbtIsKSfEfQPWItFZJ0B3zDmFp83+/Qtm+Rp30/mPhOwFQuO28o1vsUjg9s9Stw3phKQ55GXRyHEbgXVCrtHpTyfPogooEKLSyL1bf1UFlUwlUOvzIesJSE2HPgcp55pUlLS+0I85ua+k7OHdvG2PueF/gLlGq4pwp3a1sa1sh4wNvMipKL263OEtsG3Y3K2YKyKaZMax/heP60OaNzTwGyFbkBZGlVA5JHJoOg+PLxksr6CYWGiyWX/iDGkI7MYdZgQHQ7AZHCO/t69UE8cPsAhR2dfBHLMUjvh1XkUrWHi8mPujUiwwCSu9U4K0AFA+8n4psD5UPZL+Z3xML87YMTeEO5VCZjDSgJnu4Id4JqyzZJnzYUPT39b9IxQQpK9PVkt1IEIpqSHmAMMkkQ8bubkEYS2wpnvCuiPTrWIMarI/DD5P00vzYZjNRK9yLPdDcnahHUBUIFnXZ8dq1GJGGl+Zp4Afjs86VA+ZeirM7Qfc7Xwo2aFO8S+Xv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(54906003)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aeEl73XYU+apRH/iYly8d64B6wrq8QGbY7PtdptYG//0ZpZ1wvs2rl67qFTB?=
 =?us-ascii?Q?9JvBOkno+dvyFm59F6g8rJ669uAWzGvI+56FFCc4CRxkOnStaf+ObkfSwSuZ?=
 =?us-ascii?Q?B0ZJFbPze52602uMLex8OaqJwWDjEQaFEyWb4vfn7RnH729Zf42qdIAIku8U?=
 =?us-ascii?Q?AMgutyUyfSCuZT2D5owS102aS9uHEwXcCzNlBx27/78PT7LHPnlq9ZkuWLev?=
 =?us-ascii?Q?fZgdu1VkCgh6RnpimCttn8n3a3oRTuBQ0oduhvrxFNhpafW61PlHOrvIqC6o?=
 =?us-ascii?Q?g/Rk56dBL1tmNdxUoNIkcqyYlZp29R71ByRRqob02f666QK+lggkuZBFiR/o?=
 =?us-ascii?Q?ta2EotZXt3SOCU+7Z5RjvIAa8OJm+NbGKSWkvDPN9eLerWBA7y5OyO9cLlpo?=
 =?us-ascii?Q?csarEok3VG73ZoJNLvYqD3aw1pOtEFIAx/g3Ck5oIJjUd2P40uM95lisTrGE?=
 =?us-ascii?Q?PtxcOdy/BiAkxHjQbz35JHJK2FGOZbXd2WozfF9dDhaJ/Ff/g9Z76y0+fKCJ?=
 =?us-ascii?Q?LF7lGQV2jqR9ioZhmvwCZocpZZ5GN+CuzDCt4197Ed6VJyN+GP91oQv/68j4?=
 =?us-ascii?Q?Iah4uvY8e2hRQU2uVbkyIHiNWeaVLk3EZvsiDcl5B0B5tLHyBK3QMXBukfdZ?=
 =?us-ascii?Q?C4X/9j14jgRueJIm2flFmoxcmoxnjq8tzT3d+lBXLJkKlHFOgsTQ2ZsrxkNy?=
 =?us-ascii?Q?uVMLFINb5JlQWbpSQ/dHmcxcrfCs79D/D/FRaR6iwLX+kdZs8MPsplj2HN7e?=
 =?us-ascii?Q?HZabkk0txThKJu05+k2AYz6DYvKaxc2cVzW9J4SwX3LAtPVayzr5BI2jg9yz?=
 =?us-ascii?Q?I6tn846MLaQjr08ArIFbBcMQXJLU3uMIehjnxHHfOikQqJponIt7vzu98CwE?=
 =?us-ascii?Q?5APDSzsNmJCY+D3tpZfh6VkxAqpsEc/eUgAWpBU60w73WiyPJKMmMIE3VLjd?=
 =?us-ascii?Q?I/WtqBd2WP6AsK5kDGx6QlaqAQb6rEZEE3aKGBPdKWMmjYg1PkBXJeRBGREY?=
 =?us-ascii?Q?n0iydJIx1dsEXSZNjWAoEQDQHOQQxnGQdHd3f36/CpFPIWpgI10ajeUrEhkP?=
 =?us-ascii?Q?9JxYmdQxGVhXbNHapUcEBppftZdz8YgrazAMiF0eTQyXc7w8HZ7TE+FVC7NA?=
 =?us-ascii?Q?9SE1U+SsjrR61CxeBIV3v7kJIZJlIhbwDCpWd/O2/osKUw0W18QkLBqG4C+h?=
 =?us-ascii?Q?Dtp7BaWN3526hvmGGq3nXvN5HuJFOYDEAp+ONQytrI/9uhD1L69A8WTRuFI/?=
 =?us-ascii?Q?Yyu9+HJkil4nHKkxtOBVqyRVlR/37vT1jxT6sqXpCJAbT0yze6WAC7zEIF0E?=
 =?us-ascii?Q?cYMfRFIahryKvKl4YYRLeABlYh44jP3WPxmZAkxmr/jE7JhDNUkiiH5PmqxY?=
 =?us-ascii?Q?gci+haKBfSKE+nleom3Jmld5kK5uxT/puRM8NpMeyc0m9ABojeo7w9VNm7o1?=
 =?us-ascii?Q?HrmF5nswvfZC7jZFZFPCYmZ34rWJiwkmlTGCUeEOrigqG/zGmqMDhh57kBPu?=
 =?us-ascii?Q?khY82/kSKJVfJyXge937L/iZtwvrXGR8gCAZ42Pd035u2HUh9ErlSxqsbIQ1?=
 =?us-ascii?Q?AD3ucaHsh7zW2umP/avklw+TujsCoiZZdyPCxnVa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde83e8a-7cd4-4fa1-0ccb-08db890171c4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:30.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxvpK65L9LOz/F+d3O53GzpupplzuHWRGHQCvSiv7ZMIhDzHzanm9MSeuscJ/LwqaStJEdaObQ8nilhzW9ykMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dong Aisheng <aisheng.dong@nxp.com>

Do not power off console if no_console_suspend

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 08583a10ac62..6770be51d234 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -52,6 +52,7 @@
  */
 
 #include <dt-bindings/firmware/imx/rsrc.h>
+#include <linux/console.h>
 #include <linux/firmware/imx/sci.h>
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/io.h>
@@ -324,6 +325,10 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 	msg.resource = pd->rsrc;
 	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
 
+	/* keep uart console power on for no_console_suspend */
+	if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
+		return 0;
+
 	ret = imx_scu_call_rpc(pm_ipc_handle, &msg, true);
 	if (ret)
 		dev_err(&domain->dev, "failed to power %s resource %d ret %d\n",
-- 
2.37.1

