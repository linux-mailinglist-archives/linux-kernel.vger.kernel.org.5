Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C4275AAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjGTJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjGTJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8428D49E9;
        Thu, 20 Jul 2023 02:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9CzFS//uJt9XS9yyrs9LbOQQcg4yGjFczoCFZbeA/UwfmOCKykR5+kVCMzxa1gkO1uHj64Z2gi7SWyP9yjGa1y6vZrq5sHjaLhz44hztahlW1W9gB/hy1AB3V+bFtrnMIbOhuUTxDjJxlftE+91A5JvfYRSe6j+q1044caN3wMXcaSJiMmWaTKKS8F/uPQOBpvNrbsg4PXEhG9ZUYtZHHqiX+8cySXseV5dUrftJ3V89UR6kCoc00hUOLNchlqNdvqn0V+nKvGUekj1RB2ieaQxyIHv4NGCXIMudjnFSb5EZgUolWaO5Q0GpWVXP1BdwTmWS5IGVJO6F92pUBZofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvDdV2wD3kAct/OCQawOHD6CkCKngznVXUMmhD6D4MQ=;
 b=I+QpUQWBWLr3cWkUQ4hNTrUZnkDAAOQZYoXuhnkHZ1I15wqAK0Q/daUQX3RL3btianXHPBJmgeQKcVoHN/Xx8UR3KKmtDaIZfQEWJWzXbJFFme3eaagPjr0R5NgsdDKBRjbxf5F8/urKbusFY8sS5GQ3xuaW3JM3USUAiNGuvB3B2VM8NHj+26jpYoVnhpyQ82dm7KBixoBhnvdWYcU0d/zLKj8beY7KV3rSc0d2pthUCgf+eCR8E95MFfsAu0Wqlx/de1a9uusu1SxWA5t3vLAosJJLoiHuaMB+J9/fgKQODMh7dd1Tei/nGOzz8QhYeUlQNts0FYXK5SAJ6AiAzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvDdV2wD3kAct/OCQawOHD6CkCKngznVXUMmhD6D4MQ=;
 b=lLCVVNSi4PoZ0txo2BTI4EqhADCxe4flkAHwnv0iNfUBHp9h42s0BdVeiJ0+IVyu4iyaPhdy8Mmzw5KNl5S2DRhRYMJsDSb1V7XrPeM0kCvRakL1BPXrudTVOraFPg6yIz4160iAzMl0Yviaba1u0UIpUiP3q9pKKTTNxNfLlgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/8] genpd: imx: scu-pd: add multi states support
Date:   Thu, 20 Jul 2023 17:17:00 +0800
Message-Id: <20230720091701.517197-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 329b5d6b-9798-489c-76e3-08db8901780f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cwFRirP03Nc3evVZE4MJM632tpsn2gD4Cx0DVQCrjvgbmwTupxEg73zQtQTUuBknYTd/ePMxYRZOZl2IXGjEuOujqpDp9VMYMDCrXS5PMOfPCNcu5+Vup9H4zKAvmLK4h64K8zY0YqQKorMq0rfr8lqFuq1W7GeJSnK4fFyl106BMSSe415OH7W8q13PuhSqYsBQokJm/eFCj6D/qkVq43sxf7PG9oXfVhpzBn09ud/IjPSIk0szRM2dkwv1MiTW5Mj85JMSnFCaCWw0062XbH3jNEqJ6Zspzp28fXadJci2V8ljYS+nLGJeKTIDcR3Bz3G0D9lIXqHIoXo7Rn0x8hhCwRHXiwKFMUDlZRwnf8//6ouh+vRqFYROq/BrEgqcpbre0Uji5dLTUrCNNuVPQrDgH5btKe2j0uHSgQmf6o/hhw3IFDbxGMrWEWbrdYHorljce/bteMnrZYsMeL/jH+j4pdXZjMIgGFzM7t7KX3tIwJoanekXtlCpd1C8OXkWEiH+/s6VfXQ6A8D7rjoQXZwhltWhw98kz1p5zbq3x8+zv59rJRRXdZlQOHcnzRKvYxlsXHgsQcnqQbhQhJx1UNGaUCH1qU1OLEsDcurzDGnmmbB07aLaGVFvyVSLMie
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2l2FJ6zMEt2pC/G53yKw9imnj0de7Utr0AWGp6NIeS2sqlxRDE9NbeX+Yf/?=
 =?us-ascii?Q?EjfIXe/DFGW2UJGGjrDFNcrbCoEH23UtH7uKqauU5fiZJD5YLUyi4qy2eqHH?=
 =?us-ascii?Q?RSqz12smgC78epZP8bU7lYfxZGcj66EJVqEDkfmlMMnh1ITQtxXAo2oxbScg?=
 =?us-ascii?Q?YD9G49iDFVZnEaZHVYgRKavKuqK7AvuFEY7aGZQ6/e7uzMB4fqLxZTCpfVkM?=
 =?us-ascii?Q?bZegkGtk767E4Z0vUFplm9AeJYxn6SbTtqkNfSBlRU2alSTspOSrNwXMCaa6?=
 =?us-ascii?Q?t+VpiCc69eR9itgTu7mRcbraRZOS/zZFlK6I223jjeF/dpHki9gRXFYR/GSr?=
 =?us-ascii?Q?SHVGJWUgFxYdB4TBvzM8v+UcFVUmKjAP7c2KidACVkI3b2A2e8SbhjAb5Cxu?=
 =?us-ascii?Q?vTI9SWiWPcbFucIqhWHOSTH2t9Tb5auy7rNHXjzf7DlKYFTXZ9KSwn7T8XaZ?=
 =?us-ascii?Q?iXHE51NWws4Y3wr7CJTj9gv2tAZcwm7P/7iF2ovxr9LSyaQn9HmWFZ7HHBNd?=
 =?us-ascii?Q?SBycKZH/iAlp3sADlxT+VMorKkFr9OzCazHy1wQnkjx7CoWULUgVWJf3ZqEq?=
 =?us-ascii?Q?CA0gVkhCCZVHvoEWHCgznbDdGIEBSS9GhN4fHkyoygyo/sg0uexFGpCuwoLu?=
 =?us-ascii?Q?Ut6l936wOZSTcU7JtUfNaijqxRgWmnBYv2hjm1GggTXt9r26X1+T6X6paXdj?=
 =?us-ascii?Q?EublX3S1XW1FvoLhPo8XUrv5LiSMGtgNAx9kTD7OZkX7SrMpRQKNSw7qZxgn?=
 =?us-ascii?Q?30+00gP5zDJ2BG2NpXAExozxBkXMBVEvv5nQXUViSeg/t2lMXmHRlRVrCiuE?=
 =?us-ascii?Q?cOqFi7pLXSosghVCWWMqIo0d/uTvJY5nsJVvT0h9do9ctEKcsUZSMitc+O2f?=
 =?us-ascii?Q?c5XJZaHd1OEa781PwbbLYY8c1VJoJzk/3dWawfrRE5P7yGAwFYb4Fmb+ACku?=
 =?us-ascii?Q?OegDV8841TufFrjBkQiBtMwNNLN067PB11sp/VaSv8+I3FHkqKm09b4UgdLK?=
 =?us-ascii?Q?5nPJDso283ecuee9+Al8n2YEJquEhzK/6lSMVV9BaoFldS5CD7bJ3AwuJT+f?=
 =?us-ascii?Q?Y0SUC7mW+UJUCRarQtNkicwCiJUhgQ2ntdaf+SE9uYDq1td7Qa9HSHFKBl3P?=
 =?us-ascii?Q?oWfi/+JulVRJZpL2r151NYibAXHhpqhFzg0OQOkfwHwwfK0vGtv/87V532vq?=
 =?us-ascii?Q?I9ubOAB6fBHD8v8hLDsIp7lGnYQTN0O14S3I9/L8uX/zRtQrL+zQzM4j7Klz?=
 =?us-ascii?Q?jsRcx9A/bcjOrXWdOEp1HZVjo0ug1nU8bFvT0SUdhiPTP+yNYqo13OG8AYSO?=
 =?us-ascii?Q?2oMryXERsRisR4P0NdsW3IZgKczWP/P9jRw0qfYYjhVwvmZj07+fn7oGGYiM?=
 =?us-ascii?Q?Sf1kNREhSkzrx1AXmcTt6/fCwXBQ0Dj+r03+xQ2us3PI7eTubyMEYVZArX+z?=
 =?us-ascii?Q?Z3Ilql1aaCdW4/VIvLU4J8wulBvLlxysmX215fNpexv3f/yFJhvVwtIW0s9T?=
 =?us-ascii?Q?MGfwVhSN1HfbxhubfpAowaJKcwgZQYQI+YXGEbG6QrmQf4YMhQuXaHydr9Sv?=
 =?us-ascii?Q?+36lBf4LMPeVD3fGaHaY8FV/dDBdl1e37anAhd5u?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 329b5d6b-9798-489c-76e3-08db8901780f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:40.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruie3O2qQZRnB1hpko4gLKEq/w/MJrMVhXE9bmivdNjsvFLJb03dwvT28ahawDMq64J2rDq1Ox26IFPejTXXPA==
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

Add multi states support, this is to support devices could run in LP mode
when runtime suspend, and OFF mode when system suspend.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 763af1ac454d..31de56366a50 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
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

