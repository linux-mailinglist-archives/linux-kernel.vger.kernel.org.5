Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6B75AAA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjGTJ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGTJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25565268E;
        Thu, 20 Jul 2023 02:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D59DmU2TssHzlsxmMWwgQBYNcF050CEN/4vrLlyAaAeijDgM7p2B1mnh59ggbXfKNYAYYgZrmdu7ef3YYLYuJHjTBXR13qAbb3NRToeZOAV76Be6wl3DFhxUQLxFHr4LK7l1Ti4sAYqTitgfeFJdNwtzraIO8rziZhBPu/cNmk1QSxXXLY0sME+qEU235MpGqApsl9ntLQlc4dRbRb+FOR3kMjkT6j1vXbYyNgXUy2mV4cB0PF6B9J0vlnkeqKIBYy6qxbcgMS3UIuRpCJfrpRbphFBazkMwrOUAnjDZ8ZD7Qz0aD8/DK1T9FPJ1A8wM4p38X7ZDCsAOI47ZbKOfxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=Zn9/w+ho/0H11kwJu0ydc4HJuRV/6VUZ97sYO1iCEA5cSVgsRpG/1cQeuLkf68Hfugp7QbOhhsaXKVFGmh8nBfIwKQXA74glVrLzztjR5geijUJ2euqsxryKjtg7ROMpDRPY6oY2fnS0Gs2Wv7/73WzDJXAXOGXDh68fKYRoNtw5MblFbshRN9GBAJ7esz60bIZSBjuPFVY5k9w+zRctJoXIodcfccGsFKfM2IoES8qgH6uEqhzh61NwosHUAygA0rA3wzMcX4e1U5vDkKeLjmTVZqMan9LzIzLaKkS0VFPEWBYreJO5o1Bi0HxSScEWGRhBayXGe73jJSx+C+P73w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=iOS+FW5yhReHiwsCyIMlQLGG0kheuLrjK6Pu2ehXb5lhje14AZW3/Tnd83hC7knzuZ1FrqC0dqbj7BLHd6hPqkwZoRz/9ISr6vYchtqqFicCFZmyawtoYZHrfVofJ8T10THwvdmjzXOZ3lBlkfAi3fBh1VIeL9C1oSdYQ3wFh0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/8] genpd: imx: relocate scu-pd under genpd
Date:   Thu, 20 Jul 2023 17:16:54 +0800
Message-Id: <20230720091701.517197-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e91c0e1b-bf94-4b5e-cc0c-08db89016b60
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3c4hYi+p5AWD/dbaZeQYdITJTigkqHZvjfetpejyGf5noYjQ8dZESaNVQCF1RmbSypBMyuIjiMIlTQzfTcM9a09HG1x1teM/Y8RpIqqTSmp+8A8Oo6Gl0FH5G4r3hpR56Vbpny9jRkiM/hY34IRYYAgWwN6J501YBlSL/+r2ScnTxys2Qsa8RU2GcKOdHrTsgz5ujaLmVozuNnyF5Cchh5NeaFlt5z0mXYVVBt8P0FAmb8FkJp3+p4tql9x9BiTA31q+15bmqn8ack/QulVuti3KJs4tE5ew1KPiAcx2e31EYT6EKyf1+4N02vYWMq5NEvQb217dtNwwvxWskM1Nqqr7nij5pdXVMP4hZwHtO1OwuLg4IuaEEX+AVKni0uDXi75r1VD0XbUfTsnqRo1e4wxb0hI/kT/CVhRl2P0VbKz7EnOqBKSqm1wln/N2SgXoXad9D9cp/908jQTK+T6pneuMgYE8/1fdbJKDWkBUv+floLU228Ka8ii3bhReV4LRGqETMsJwxqNzvchUzog2C5dsgRX758fvAFeo7HZ01BmhQBrpbAWnRux3n1b5y95ZsMAWwRv5gOoW2TTwmsN9w+TxumokwbRWm9w2I6qdvm9WLBmcQdJ03ew+ogMRPEdY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyPnsHxf7ItD1VoME3qTadKt9WyNBxUiDdyRx3far37YS0HMulu+lAh/airn?=
 =?us-ascii?Q?8NzSwaMX4Ctd2Qm8MD1GYdQjHu6t/mppOSVVPPX/1orgcDruphWQNfeknwqz?=
 =?us-ascii?Q?XZ7/OemJw01S8Kj1xsduQMKvE6CD7oSu68tEvncYoPmW5BQoqsVQ8RtZjzp4?=
 =?us-ascii?Q?VlzZzHOKLfX69ZWTyxDAuesH/NgxgROPvW3DIS0NWa0NoBNGvGvhww+Iq7di?=
 =?us-ascii?Q?1E6pGPK0H1n2puPSK12KElxl2/EHgaXpLXvIxIXE6A7xiD3oAgN7LD2mLDby?=
 =?us-ascii?Q?J+lT9znP9Dap6lNRnof4p49hda+nc05yZfraTZVAQ3ecUQKXGBmwroz+fYib?=
 =?us-ascii?Q?/KXDIKXoKXgSATNPC1GpQP64EBe3kEpr3lMmROax3147UVVL00E8cVuZW2lF?=
 =?us-ascii?Q?sd9hyoHrK1L/iz0xJ07wPBqHtmeI7ETZuVaMZT58NVVDccC1sXwhI4NbWe1b?=
 =?us-ascii?Q?VuK++9XEbWBhND5p692IKWhECg8z0H+jqaMpRjWk6xs6/c+nZxp8qR/Ef4il?=
 =?us-ascii?Q?sn+q97IhppsI2t9FTKA/wWHx3lhK+j8ivQfQxU7p64DB+EgStz8ItiNLNwYS?=
 =?us-ascii?Q?e02bTjP/EiTUBctJu9YJrA2kUAZ6MSyciNpDB0bGRUTiNl7luK/UgKHmIkwe?=
 =?us-ascii?Q?z9NuLYHJv6tiWfoQpKCTOBIDtiixvc8LHZzdsqAW80Xx/mWQk6CHpbG7I6Nx?=
 =?us-ascii?Q?MGnqNgyQsteO/BoFtxNrkuBatqO887lpSlKEH+okXXtniTe5gODcukyJYi70?=
 =?us-ascii?Q?VOG9m/J0nbWvJoi2tHeLjTc4wF0siNFulC0ic5+weXp1Qn4dF1abPw4JFcAs?=
 =?us-ascii?Q?7WXhQmqSzq7ZIMj0Rq3gF85B2knhht4JUuYe+6ZzbDqZ/34WaNu5pJr9gbPt?=
 =?us-ascii?Q?HT3XpEtfLN4OiczdtFF5B0z2Wa+V2GK4cczUBK2ljX+vgDibZIydSZs938cP?=
 =?us-ascii?Q?4uqisfdKtWDwiOMz0ZS4lVjpnAQlMCfGY3kPX2SQXATBwIhylOKxOEDvlWgH?=
 =?us-ascii?Q?ewuPgdGoHwDy3ISBYOOhlavTIZh/XHcMIink0SXCsyPd3ndIlI/DCfauPSSd?=
 =?us-ascii?Q?u+ACunRfcrdiFY5o3oVw7m07wUBJ2dTxKCEabqc7tlt9rGQsGJcSYya36UFz?=
 =?us-ascii?Q?O7nMp5ty9dLVSlgmOor5NT8qZLOqnr3E0GVPLHYNzxJZBIFnSyKJIbDgoLPB?=
 =?us-ascii?Q?LLR+J6sgCB7aBdsmg1lnCGPpzUzfvay/EFGZfyNM8HZVAtM+1V18XrB/yXNb?=
 =?us-ascii?Q?n+DWL6QdarN8VIlEZqlaK+PsO0FrZgWdsk5RRbwxbOsdXJHqT2QkFv54ChH0?=
 =?us-ascii?Q?MxPKuoTsE9Whz9azUvI6LMxM7ifyPu2vTjcKRjGa4qsxdq/W/QNobTmEM/Fj?=
 =?us-ascii?Q?Mi2K0g3LVWfLMQ6Vr5CbB2ZEdsLbcU6JYXl3aUS2brqj5wPKpKCeABsDe7sB?=
 =?us-ascii?Q?YrW/em76HNPBqTuthNI61TspPiM5RBLggQIACw7ZlpsqEgwpvE7OW8oEaiW6?=
 =?us-ascii?Q?VV3WDmsknWLaRW9Gg7tOHPW3crpr0s5nr9yHrN+sayeAF5VgtKSXdZF2uAnX?=
 =?us-ascii?Q?XRPeaqds7bD4aRYyvYuePGRnC69NRuXcQsQIiVAb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91c0e1b-bf94-4b5e-cc0c-08db89016b60
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:19.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s6XgE3NHqid7r4ek9j6NPiAQgkVoI1IAqU08Du/NATsJikQekanKtIv/uFG4W0N/XXheMKSgyTjq2tfg1/ZMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Move scu-pd driver under genpd directory where the driver
should be.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile            | 1 -
 drivers/genpd/imx/Makefile               | 1 +
 drivers/{firmware => genpd}/imx/scu-pd.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (100%)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acbade2a0..8f9f04a513a8 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
-obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/genpd/imx/Makefile b/drivers/genpd/imx/Makefile
index 5f012717a666..52d2629014a7 100644
--- a/drivers/genpd/imx/Makefile
+++ b/drivers/genpd/imx/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX_SCU_PD) += scu-pd.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
similarity index 100%
rename from drivers/firmware/imx/scu-pd.c
rename to drivers/genpd/imx/scu-pd.c
-- 
2.37.1

