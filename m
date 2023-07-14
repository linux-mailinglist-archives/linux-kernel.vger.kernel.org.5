Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14F8753607
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGNJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjGNJF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:05:28 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343A30FB
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Npp/bFBM+7CRnznSeLkcE+c/y26fkRrIQ5fE4p0UUlE+1RqPHAOGhznT9z3vOnir1ycC9BeKVvsYa0SqVs3D/G2IqZvzlvmtrIOowuBPmVpAWTpB431DJxpa9mUq0wJ6ck0FXoSuQ3usz6wp6clf3kpSFCqLH1Jj54kuOjd/QNBTA4la1itR+zQ388MtyiwZpfWF0HK8sLALCI2lBrG1gf/z9ZUkAMOlVkmIz+OUafGtS/kUiJwzLh1ff3jjMqr5WJz0O95X6Mmz+P83grObvdvEz7KNggJCvUJIxcsAX+1eoLRHjg30epAU7ZtLBUjFxDBsx3y5foMNYt+9hF5uMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD/iJTB2ymjNjEGPIvWFr3Lp3W8RTCEPU+VUUuutAtM=;
 b=TAERgJTWT9B3jVXj7x4mKgoWaqyIiBlxlZa1DaUNOho76o7j9FVT3EcrDsN/i+/8rzP17gK7eX2FS0NeX5vFoPokrdoXqEcO0ngaWRJCpcd6J31AtGUC2vwcejTTijIAOTEQoCAus2OkHa/5QVlL7LwcggIo/1EigKH253Il77NT4O6vrDy6SQRv1Gi7hjV1pyXTRE7hJT8qNvDvnUtiiLwgi6wEhbO1w8QWK/yug1nlbh3u9YAB1slXJK+OPkwPrrLs41rlLsHhMN4/DZf7Z0bvgT3Pi8MCPe3OfIMVHh0D1JVvwcm7jh3/eGroieiR/BQnCJ+Z1leRr/Z/qJxUFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD/iJTB2ymjNjEGPIvWFr3Lp3W8RTCEPU+VUUuutAtM=;
 b=mt+8ow15RqqY8fmuhFf1aUAnserAYkmlitb6G8Pa3uQu9a+cLdo6iehX0vhFV5kzU2S+yvJUht6J23mbZ1ObzVYCb+ZLbXjaVq3KlxXqCyvSWbc+X8KS1ERP3coD8wIIXwzlW586NwADxsWFZru3lJ6Psl4UWNF/BFbH+9Ckwp8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8916.eurprd04.prod.outlook.com (2603:10a6:20b:42f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 14 Jul
 2023 09:05:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5c40:ed07:b875:18c0%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:05:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Frank.Li@nxp.com, aisheng.dong@nxp.com,
        marcel.ziswiler@toradex.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] firmware: imx: scu-pd: add multi states support
Date:   Fri, 14 Jul 2023 17:09:35 +0800
Message-Id: <20230714090936.937344-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230714090936.937344-1-peng.fan@oss.nxp.com>
References: <20230714090936.937344-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:4:188::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8916:EE_
X-MS-Office365-Filtering-Correlation-Id: 607da5b5-1f27-4651-a12a-08db84496efd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0Y1ZEQItJ1Ywhh9aiD0gwDMQVNOOHVMFQxugDeP9mLmlsANyF+RCvPi7yBWAD3wn3S09sjfBnBaCFDBeKeM1oNnXDJUsehGX4cTZEPlKPjMGsMvwBvXDjyHXM8dJsGChJlgLCsgq6zfiyai8YgT0wZtifXsGvYkJAaPhN38IdgzHUX6wAB9cvgYRWxyy5wiotcpQJyHin4Ap0DzzO6+hdbrrEvL2RhzpUt/aFZGrcPb7VlCRBjkfMTl5R6LET7hJ5/kokyDBmFY3EeNTVltX9eFtYHde5tDmX6p1dENifM7g3J0bH9nYfCDmRyJOyoQJiJHrZkFyWGUdgtVGopIFAoyTJzS2ak/xn+dbs0TDY3u3fQCsA9pSOujextjPQ6wj0i8hhOuI4e9a7B8SfhoOqlSMWH+i7sQGQMNYBggEVbQLdOO4T/EeEIxnJSPOFsvYrvZiquGWJ3KcOWO6n8dUhhsAR87YHtl+DcuY0SPRFvKrcjOOSYsW8VhxRrmA3my8x+wP/g4yVaxWNmZF1n3F/vrLVLPZAwa0onM4YcNF9XvgrwwBgsA6YZzWxmsAgUz5F97KlBH0oX1onDnkqmSx2NlwwyNYMfc4Rn75/hVCDLfFUzPn5zQTpEqg6K75ITa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(451199021)(2906002)(41300700001)(478600001)(6486002)(8676002)(6666004)(86362001)(8936002)(52116002)(5660300002)(316002)(4326008)(66946007)(38100700002)(66556008)(38350700002)(26005)(1076003)(6506007)(186003)(66476007)(2616005)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YA3kxK5Rta9K4SOG9kwT9YHNs37H8Iv9Uq/dax3rK7WKUD6K6EdD+y+Mi3ha?=
 =?us-ascii?Q?fieN0MJfRzO3DmRokGMil/dEvBPyajudUGBcUOUB23m7zVnsV9sq6gXYXRFo?=
 =?us-ascii?Q?2KkTcsFXj/3KsDXbdOhEfF9QmQmTCGPhJ7G8zgzGQsf+0iTMu/3EyQV0FUpA?=
 =?us-ascii?Q?lza3EEgGxGA0s1mKd0kufQwYz3WjH5opirJMl0NNSEFGtCk2L5tc6ipwfAFy?=
 =?us-ascii?Q?CWNXKytBAYJ4ZjYV4J47kLb2GkTXr0F4gwpCyywGtSHtKr9CrhjIZ0isYWCb?=
 =?us-ascii?Q?X0tvwfDDFWPNSqtQlNbsCPcv3G83NpovUTYCXd0vJiFqgN00yk7YAG/6ANiX?=
 =?us-ascii?Q?U2xtd4dvKMrpV73pWFc+LooQSPknJtU0WcFXEk+1GsgXEtadY6hfyV6YhXGn?=
 =?us-ascii?Q?lSuPEQfTbwYjM3Iv2ZOyoFYdb+D242ZCZHKVVzd6j9VdZdOv/4kvWZnsbtsn?=
 =?us-ascii?Q?LZT+/Gn8RzQ9YMsaXcz9drLGklDQ6V5VNUXvXOsikODPd4UoJICaMQv0aJBg?=
 =?us-ascii?Q?O58Td0MBfgeXN1vvLEKAP2nrV2ckttJKhq4r/c9Gc02Qa1rTIGpGFwTHfNG3?=
 =?us-ascii?Q?XbBjuczLcn6Ov6aY5ZKmAnwrLfibIGn2xKMttXc3pum+8C+Dc25ndI0xzYHD?=
 =?us-ascii?Q?QUNhIboEs81EzfHjAMmYBVXWtuGiwMDRErhlPWbP97U6Mv54CuHHgGYT+W8c?=
 =?us-ascii?Q?c9nRn9k0KC+z2x9YYYbL6Mgmos4lcDZ8Y5G9OUrn6Fe+wl4sKdUbsfY3dsN9?=
 =?us-ascii?Q?DJWx7ZjFsKxCo2UdaW3hiBfkmDekmnA3fm+7gYpHrYOpKumYmP9Wjnwn6Zdu?=
 =?us-ascii?Q?lvjDBPnR2VhlwRSI07MU0g99pMVLbe//zt9hBGZk/COk4+Lz+az7f5VPaifw?=
 =?us-ascii?Q?iKgpSsBRPh1/57TT6IOxe5SYYWcmHJcTApWjm3zuwW1bRD8O3T25/c8gf3bK?=
 =?us-ascii?Q?01OPfRzzVtHvM8bpTga+TpSAE9f+Nr+rZC/Qr3zy4fpJTbsfyZ0juzuxWQXI?=
 =?us-ascii?Q?Z07CCuVasakNlGjmuzWoaB77a3rAlfXKj+EHSA5W3S4kPTb5kHgZaQJ9fu/F?=
 =?us-ascii?Q?0J0d9kjBGtKbJiU6GUp9LHXwuzN3fQvHje+1mK8ih4MLdTkJB1kKLqIUmap9?=
 =?us-ascii?Q?lAKUX5t+l//id7nTQxFfc4kv6TFAXUKo+l+1Ovw7V4FMhVootSyhRt51WK0/?=
 =?us-ascii?Q?0pJ43zUy39BwqDY9JfXGnsMLUpbIysHT3pS+o8j1+tmmYtmemGXFMjKPF/C2?=
 =?us-ascii?Q?0szOhxuyCau6UMgHhn2aGB8tULJVYeEJT1pkBwl6zsJRyFae+GzaywIwfUe7?=
 =?us-ascii?Q?2wGxzqIMmTEcdjYZcqtZwBdrb36Y5xnMBZmcPLWVbw+pFJCN7c9K0/ix1eVO?=
 =?us-ascii?Q?ed3cPHTuMtStDjIlFgSvXh7Kz1LECvAyzM+7Udt9dmdIIsRLoFuJfXLfqEPL?=
 =?us-ascii?Q?AFDAZ87FRRTo0+mHBUKDPGniteumbq9basGXcRPYwxMkCQml2I84DI8KO7o1?=
 =?us-ascii?Q?620TcJTYIc2r0WXyF1O5JnwlDA3XyzHtWWbaw4ISdY1YLxsycNu2dGJ4wYW8?=
 =?us-ascii?Q?oObR1tJ0V655M/78y3W4RxaUAwyU/yRYWjAT3gKc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607da5b5-1f27-4651-a12a-08db84496efd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:05:13.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovwnAkHFCbE4AFY0NTMxWddV/pKw4Y3vRYXztxQRs50VCinp5NL0vIr4lG49b3+RFL8/tvEO1NW+9oPLph2pGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8916
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

Add multi states support, this is to support devices could run in LP mode
when runtime suspend, and OFF mode when system suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 48 +++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 763af1ac454d..31de56366a50 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -65,6 +65,12 @@
 #include <linux/pm_domain.h>
 #include <linux/slab.h>
 
+enum {
+	PD_STATE_LP,
+	PD_STATE_OFF,
+	PD_STATE_MAX
+};
+
 /* SCU Power Mode Protocol definition */
 struct imx_sc_msg_req_set_resource_power_mode {
 	struct imx_sc_rpc_msg hdr;
@@ -368,7 +374,8 @@ static int imx_sc_pd_power(struct generic_pm_domain *domain, bool power_on)
 	hdr->size = 2;
 
 	msg.resource = pd->rsrc;
-	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : IMX_SC_PM_PW_MODE_LP;
+	msg.mode = power_on ? IMX_SC_PM_PW_MODE_ON : pd->pd.state_idx ?
+		   IMX_SC_PM_PW_MODE_OFF : IMX_SC_PM_PW_MODE_LP;
 
 	/* keep uart console power on for no_console_suspend */
 	if (imx_con_rsrc == pd->rsrc && !console_suspend_enabled && !power_on)
@@ -412,11 +419,33 @@ static struct generic_pm_domain *imx_scu_pd_xlate(struct of_phandle_args *spec,
 	return domain;
 }
 
+static bool imx_sc_pd_suspend_ok(struct device *dev)
+{
+	/* Always true */
+	return true;
+}
+
+static bool imx_sc_pd_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+
+	/* For runtime suspend, choose LP mode */
+	genpd->state_idx = 0;
+
+	return true;
+}
+
+struct dev_power_governor imx_sc_pd_qos_governor = {
+	.suspend_ok = imx_sc_pd_suspend_ok,
+	.power_down_ok = imx_sc_pd_power_down_ok,
+};
+
 static struct imx_sc_pm_domain *
 imx_scu_add_pm_domain(struct device *dev, int idx,
 		      const struct imx_sc_pd_range *pd_ranges)
 {
 	struct imx_sc_pm_domain *sc_pd;
+	struct genpd_power_state *states;
 	bool is_off;
 	int mode, ret;
 
@@ -427,9 +456,22 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 	if (!sc_pd)
 		return ERR_PTR(-ENOMEM);
 
+	states = devm_kcalloc(dev, PD_STATE_MAX, sizeof(*states), GFP_KERNEL);
+	if (!states) {
+		devm_kfree(dev, sc_pd);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	sc_pd->rsrc = pd_ranges->rsrc + idx;
 	sc_pd->pd.power_off = imx_sc_pd_power_off;
 	sc_pd->pd.power_on = imx_sc_pd_power_on;
+	states[PD_STATE_LP].power_off_latency_ns = 25000;
+	states[PD_STATE_LP].power_on_latency_ns =  25000;
+	states[PD_STATE_OFF].power_off_latency_ns = 2500000;
+	states[PD_STATE_OFF].power_on_latency_ns =  2500000;
+
+	sc_pd->pd.states = states;
+	sc_pd->pd.state_count = PD_STATE_MAX;
 
 	if (pd_ranges->postfix)
 		snprintf(sc_pd->name, sizeof(sc_pd->name),
@@ -455,14 +497,16 @@ imx_scu_add_pm_domain(struct device *dev, int idx,
 			 sc_pd->name, sc_pd->rsrc);
 
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 
-	ret = pm_genpd_init(&sc_pd->pd, NULL, is_off);
+	ret = pm_genpd_init(&sc_pd->pd, &imx_sc_pd_qos_governor, is_off);
 	if (ret) {
 		dev_warn(dev, "failed to init pd %s rsrc id %d",
 			 sc_pd->name, sc_pd->rsrc);
 		devm_kfree(dev, sc_pd);
+		devm_kfree(dev, states);
 		return NULL;
 	}
 
-- 
2.37.1

