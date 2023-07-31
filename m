Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C0768C38
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGaGor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjGaGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:44:44 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F610FB;
        Sun, 30 Jul 2023 23:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+N895pVVzj1azw6kCq4invr97UuVXLZTMgm5rfVFow6LUrn84C6moexO1cD7sxImCF/khoo+EO6pTls3xTYXpuXuZxfXGK/mjfCj56Dkbxq/Ufe5/vVElYyQ7cjHX7WBkInfPMsETQ/Z/EO9TJwBeYHXmNfP14e+zKGBvRLcIXrLjfQYCusUfIS434HbZPUxfpYbNzYaDA/maFBTGoucIeBFIhPc6ZhCk4GhMPzIt2j9HTc4qBOXFFK6+8ilxVeL3a3HP03n8Q5m3uzUH+N86AdW86D0FliW3kXw1qzrXls4A1jScY3cXsP8BqNIm4l5EWCIG+77WZcRHjV9OcJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTqXGAi4gv6df3uCGkaSZVTjEApwuAc+7+xXRdnwpqU=;
 b=aZ/ycowiZJQ3BMC8LMGIc7kZnAUZ+3apcEW7+DXBdlPBCX+VUeDBZasFE1iRfBgBeHpIp+hO7hAGp9yJRfxmihfpB20cpcny5QB+pSuNwagoHqG2j+OGhsuTW7lov7+n4Ap99wqq2lYxFjtWOiYYs7ld/n95uB/eqiS3dpNVrHPk7N5tx/7r22YRK+73CbmRgQ8CT3h5frxprqjYXvjjjeZIl+ROIj6VHtkxk/VehEDxyINvpSOXuFveTQUkw1tfJuU0PAmd9kGJIhpsru5bD6h9NXTEjIqwvCzTBHgbaRvK3L4/dx4Z4RlTW2vMCNInqEtjT0jmJx1G/qFh0gcG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTqXGAi4gv6df3uCGkaSZVTjEApwuAc+7+xXRdnwpqU=;
 b=lf7iNFEb70jXadI3BwqPeL7MfMbDKEzdm5R7Am+AnvfMeBsUErXlu9fHRLSYqPcf62NCRnszMjxsGSB3L5xQ99X9XaCARAzlfu9YVcJ9+KTG9CCJG5Uv5+vErPfpU7u/C3EqRbEZl7UXp2TyLTPdB8LPXBXXUHRPkFpBv4D/4Fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/8] genpd: imx: scu-pd: add multi states support
Date:   Mon, 31 Jul 2023 14:47:45 +0800
Message-Id: <20230731064746.2717684-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 5131891f-d8c8-41cc-38ee-08db919171b2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 380tpObBOTV3uINmOhMdsG35m4Ut1vs6aNSxI3vts8l41i44PflwAVueU1uNU05uCfF/IlRkqgNIQqMqV/J6LSxmA/q/0okJswnab3oTDeKdyaWaoVO037a1g6SM6kXlBjfX84+k+LhYXS4txkPcjkbchEVGBxeDqoQU04gTISXc0KFpkZL09xX1loo5Xy4XjddjooKDSYYcLV1x3Mh1fSKZV415O4KKJr4/eqioZQFGGcyDTiqDK8Bsip6HOvBk74hBh/+zcYjMxj9pf0EHRPvFOf51gIENgoveOHrZ6SSkja90wR5hbdppeQpCtf33NPqdlNVOkeVlFPD22867b98AHyKvnbrmDJQ9jNHcQ7VxjmRYS6VQsm9ILskvXbH6xsqKw3LvO2pwQKVi8/+IYSlQEBcSucuAxhrYFKM1emlndSt2YT+K9LMA7YHPjG86G3H96DbJWraZx+WnpHodM+lVmqh8werKFIBDr0JmoQkzTZpG2QFRbUs5bHds3+dxxaykHUMeFbNA996deFUWrApb9BqpwooLra1ZAiB1HdpSeDtfLHIjOfyqI4R+JvCeIwdsXy1RyCfDUf9TuIFwlnudpv5nfjrEzueno7qJ/HRJdNUSOyhoFX7v512N8iBS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d7LNBw7FVLhiMdVnbzUuQyVgF48FxKd79h3EAC7iB4rE9swqy/J2yVJJu0gD?=
 =?us-ascii?Q?LayAwK0n2ip7ADIxJJ0smIhrYWcqGE68OPLIDOZUJ8LL7FGeFh8c+Tra6hjM?=
 =?us-ascii?Q?dPYXbTYhLBKLwSsfxPm8RBdsgJQrSmVUdY0nj/706v0tvYYu+Ibm1V48grRg?=
 =?us-ascii?Q?9xQy5LKEvhKA3SzbMmt0WqxRjqDiBRXP7n41CekpNRgWNbDei2+B/5EdyXgU?=
 =?us-ascii?Q?7cCu4X6qfKMpxAYdmr62Y8ucWugO0PlBQMHTT/NsjyuRxtLdV9Hs70qa/U1D?=
 =?us-ascii?Q?hJcVRZD0r8SDUOLvCy5pTkmvIfA2TAmNpXy8lVqpzDLecmU91tYRTSD1sZ9z?=
 =?us-ascii?Q?HuWI0HkeAKLMDyJc0HjAxA68eSIv2sIDLsawlmJA+vhaKZx7fW2iGydvCdpX?=
 =?us-ascii?Q?I4Rh4my8jHGADRcNnLJXpDzqhQLBFGLa/MHLwFf+HtWdyKU1utunSdfTS7mI?=
 =?us-ascii?Q?N0yuHPWXPtJ7I16gs6u7on3SpUMhKQMzEMwKw8fY2XfbFwfZlEsqq6W9R419?=
 =?us-ascii?Q?w7FbNd/FWWyafGndiutwvfLCys3EJr/AQBKI+PKQuRSywn/4cPkD6y6OVzP3?=
 =?us-ascii?Q?Qa2xbCpWHYx0hOR+FV9+9ndShbM820Kyh+YbcAzY4uATZlTWy3o3bAKUZ6Mj?=
 =?us-ascii?Q?/hBgbe/V2BVlxJwgKQfPpJ7FMbXdw+BL9h8GqIgYWccyMThvcliBIV9befsO?=
 =?us-ascii?Q?0lb6xIjcfb83Ym9l0bMd3EZ13xr18a0fmbIu4VvuBHgM5eQcBz0yNnZh/0Oj?=
 =?us-ascii?Q?3AIUZNLZTTwIgX6Y5+xZ0L8uZ1EtabksK3cOZYXxjT64W6UEKFI3oedcGPuI?=
 =?us-ascii?Q?PYKvrCpFMhHlV2uG3SlNdiWuAbKj5xNNljQIYOgwR6cumgg1gI7np6EcPQbY?=
 =?us-ascii?Q?xh7dgtT6QGl9ARNArsZ1ZMc5j5cYA9g1pNXDtiUWGWVpD0Pm7RuyS8vN9S1B?=
 =?us-ascii?Q?NTt2O+oxBpqZ2PwTjvV/rQc8FT3WTXltK+ZqPKL7atg27vpehKv06NS9tQ0t?=
 =?us-ascii?Q?pJd/fm8XvfTsc63Tmgqrqgf91mTEpmh4SaFUICN5yualK2LD+etwtTSUb8aT?=
 =?us-ascii?Q?YgrVTB0sIdHWKo9AgKSSTXVPQm2PlP2LxgU0d6FtAzDjOdLrYiNmXCeXI50/?=
 =?us-ascii?Q?BKi3ARTF0m/odA1fIJj70BxsNNE/5fMivD/H/N2nJc6anrpCN3iHXZoLPeuj?=
 =?us-ascii?Q?KvJc1VkpGKWgaSAOWT0mvKX1iVJZ8yO2rsreWgFKD4tosA4bzIPhEwbdpKuK?=
 =?us-ascii?Q?Sm8EJSRvYHe7W3t8rbUg8SEK0kTSBtKOZuc7QHzo9yaIuGtZU54Qrp14eenU?=
 =?us-ascii?Q?ZOZDKKzLMFnk9ouZdZepWcMS/dpURFIhjRz808FyMb8iU++to4XjgDY8ZgLt?=
 =?us-ascii?Q?V/lUFhxcfqgTdSCZ5agisfgehuvqxAIAo8A1sQ6LyiUFTCXfcuCyBccay3yZ?=
 =?us-ascii?Q?D+97/2pSdx/m9PO6lcerN/UUTJIAVrpsoFhmBm7CbFY04Dae8HyVr5fNa7cd?=
 =?us-ascii?Q?IUMza5klfFKSJabSoqHyD9vyCcSo4BuRP6xzolw+dsJ74YkU3tV+tW1liixQ?=
 =?us-ascii?Q?xp52EJvKoOabDAvzoqDIYlb7QbwHaVQYk4WTwCQe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5131891f-d8c8-41cc-38ee-08db919171b2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:26.9248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2lLYqp3z+nENl/RKQWOxxM6w/jUxyx2zU+zKPbT1BDlsV3tOIluEUyLejdFEj/NPTZRbgQB7Slqbz5SUDNhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
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
 drivers/genpd/imx/scu-pd.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 2f693b67ddb4..30da101119eb 100644
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

