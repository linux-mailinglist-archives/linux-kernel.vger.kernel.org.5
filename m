Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8B780F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378203AbjHRPf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378199AbjHRPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:35:37 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2081.outbound.protection.outlook.com [40.107.247.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C612D59;
        Fri, 18 Aug 2023 08:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXVxeKkfckjZyjQUwqQmEnDSTAQc8rGy3gABCEkl/nILzHh5O3ke8Oph/uEb5bXoolZIdKYjP03pBhWKreNH8xe2aVccf9qTElP/ZnUvA0dgUOWGFkeYmZgX8iuuTA1BL566QFYg7tGxdoifAFB7qxHxU+ekNEt5WUJVoCuQQ4QpOYJ2dTcrNHOgvdNT2nSqpgo+OvhWdADjfZaBeKEMv+3DdH5g6wp1Rl1VZi7+9wS1n7MbSKDcwaPeQ920pKK1ovbQr3MpwSECFZYmF14bV7UpAmACmjki9OS7+lxs9tSIhc0w7XzkS6BO7vNQSjiAr1PsjlLJAxx2IvwrMj+fXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/r9EXLIQ0sI7Lv0f0v4KtPqlGRFkNdgMIDyL44N9Tg=;
 b=awXDIdrRsucXU+2kD7hNl87uIFEYDjc4JZrjYPD3mYyEIz+mT6d0XbV+qPWe/pzanRkgGF4S3/5x/ApZaOXRwNfT4eYeDeQu/w4O6l9vxasZcwOmdTOmpPGXS/PBGRx3UWlfCBgfEMJ1pfKanQ6HUe7G844QdtngtK33lwwS9hglUZM21GCUE/+u5o3G9thd0cASn4Q6hXVVJIj830wuINmU7oKUcl4Cci5M37fCMmVfiv9+4HcdV4Mf5z+g9l727KWoNbdz485ldVOQuMKjUJTd1TISVE26SfYByfDokvzqdTOGVNtUCuoFTQfXWvGHqJ2iTtxujlGSBUGJ1HowTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/r9EXLIQ0sI7Lv0f0v4KtPqlGRFkNdgMIDyL44N9Tg=;
 b=SSoAPxJQu+TCBPErYcp/J+ohbIE0oSKvHCWj+wFWg2HqEs8thhjCm9LGi29k/p3Kcgnz09JFkd5pFoqsozLBdEx9zWPI3/PRbECyVslc+2x9LbOHNu9Z9UiiYz1kHjIKaFBO8sM2ki9bihiAXzKm2+096qVY/ZLATLQ8OttZji0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PR3PR04MB7307.eurprd04.prod.outlook.com (2603:10a6:102:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 15:35:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 15:35:33 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Shenwei Wang <shenwei.wang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, imx@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 2/2] genpd: regulator-pd: add regulator-pd driver
Date:   Fri, 18 Aug 2023 10:34:46 -0500
Message-Id: <20230818153446.1076027-2-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818153446.1076027-1-shenwei.wang@nxp.com>
References: <20230818153446.1076027-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0088.namprd12.prod.outlook.com
 (2603:10b6:802:21::23) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|PR3PR04MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cfe0846-d335-41ae-b03a-08dba000c314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHMzxGqEx/xwcarsk7RpIWzlEUnwyg9R0nAUo6fDSLsObiEJU1OrdIj9bBDX/353IN3EPHl20SnRadcpPwkVcAx9wMQ6zgCUwQa+0RX9SFEwBykT7v002l5h1E15HTRTageOcXAHkdzzy3BWBgx3oNefmKWiiHu2Xtx13HWLqsDIVIUetCw1nqOYJkdw1vIidd7YAkMWUJuVFfC1++K7PHKPJNKi81pRLFbzGSU2vwjSoThKbKZ+QMK+DqMAoBplDwlZS9/AE/artfouso/HWHqVC2pf6fRegOVCL+LXVNwJN/Ksu4P2mW30TvQScEpj7R6LS3ILplJ9T0V5lAtfVav5th1G44+ZdKqNDtAfBr+n03p6jZxsW1quuCcZUCa/FobbDkzAUbOGtfK1kcLFxvB35oLC4jLFzXufC7AooZ1u/2132VdGh5HiCHNkk+8+bJAXUlcn40WjRDwCQoz+dha7i+TpCTKcyIIV9glQqaO1WCklN+26zcL7C8uPxJYM4TCDSqJ781ty97DigK9z5DDpqmz9oJ6OkWVQ1d/EokGBJTKTJeKe5eVaiOQHke2SYvyXehrH0+RWf7VBnQApvo5I/Oh4iIEei0vxXX82dFLkJjG3T6jR5nlc7LrpP4RI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199024)(1800799009)(186009)(316002)(2616005)(1076003)(6666004)(26005)(6486002)(6506007)(55236004)(52116002)(6512007)(44832011)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(110136005)(54906003)(66476007)(66556008)(66946007)(38100700002)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PRPpsoteHYLy4qAiyuJhAYdyniUk3IKg+Trqdvro0LSFdjmHfyu8WZj86aFm?=
 =?us-ascii?Q?Gicr/eakNHHU74CjAiejY2rDTeMV11FktIiP1hm5VEvUxU5+JPtZpw3xFDab?=
 =?us-ascii?Q?Rx2DJGoOxqAEJd6Ia6zVeaFt4Z92Ei4AK8nS8rRRG0GGUF0xRMbJ8E2rvlqV?=
 =?us-ascii?Q?51DGFW6iqxAoH0Tc9DHhBP227onaasuxtJYDLC++nNtZyFzGjVDwwCM6F6AX?=
 =?us-ascii?Q?0HH9p0bNCcOTMkVmsPJsfbMWY3cdtzSFec08QECAnWFaU4yZbNq+kJ4CP/db?=
 =?us-ascii?Q?P8tNDO7YQyDCPS665Ml0XlyUxEjb2MoYn+09puUZk0ERhU42mxe6pTZqE2An?=
 =?us-ascii?Q?7AMMflej6h10LT5+rKAq6hVF1HZDwSox8oP/UUE4zkxIjcpiJO46eARmDy/g?=
 =?us-ascii?Q?IXGxFNTepuxdDaf2FDW6+LkZu2hZrCj099R58S9a7MW+YPe5RXXfm3vBC04f?=
 =?us-ascii?Q?lcleypnfvtJjxZXpsuY4raeozH0+g3yWo+U52MdfscXhQ/NGO8mRjvptyNyA?=
 =?us-ascii?Q?k47yfpfhlg1QhgvViUSjmsKloKjqcPlljkCNSlvjsEHEewD7wxoPkdHYEeEx?=
 =?us-ascii?Q?xvtFZOuc/ebik14ISIW+KiVLDQwGTrkR2ihXl7+JyHnT7k7UfBrDDfohYQuW?=
 =?us-ascii?Q?G739bHSeXJzjeCVSQwDjfung+vxkZ4oyaAtmS1EGiiSuTtMp2FODdA58pezW?=
 =?us-ascii?Q?URFUr1KouJJ1RoJNl6D8extoihOgZEKOQRMlwAk1Z8iFXk8neqvBm6l1TGt8?=
 =?us-ascii?Q?We+ZNhLlW711gKKe9ipKwto5JgILln25ECPtFAoJ/KbpVeZoKVZZa/HP9MB9?=
 =?us-ascii?Q?z/BcV8YgrxsyC5ci/l0qyrkKMADPoagYmD8Gtm4yjk1TuhKvzwbuRZGHuX1R?=
 =?us-ascii?Q?q96CDpeXevU97JTv9IZsWSceAobxg+/J2DsdOPURd/2XDldDOLnA9ht59gHx?=
 =?us-ascii?Q?p6OfIOrV/OVJtmu6Jh6eZyOKr822NbLg3s6OXw+slQtWglJuwYrxHzBYT4S1?=
 =?us-ascii?Q?+dUCGXYwk5HgfjLcE1CtfMPY1ZO+wMOjThbL+bZcR1sCOrwTyvTqrgIcRHuc?=
 =?us-ascii?Q?eb7OFgR06PdllDl59KKxz0F6yZ+y2d2tinO/JU2ZcHd/fW3HPSmDjxESTIMK?=
 =?us-ascii?Q?sb4bio6c++HkZ1+CLRyNwl+BIq+l8uipRFEBrtmTKiTb+aa5QvOebrE0ZjEL?=
 =?us-ascii?Q?mYsgWYWKruDshuZ+/n5Cyf7UIKY2YMw8QaK7mwcvallLu1rswBfPQyIsDCJZ?=
 =?us-ascii?Q?k7/U9lWN180UZIl9KEb6shOpEEqKt25YFW1FMv2br2TO9gOrdrFz6cIjeMPA?=
 =?us-ascii?Q?S9GIDHv7FOhysYZnzc9Fj7SK2QTzFgGg5QrAE8nhKb0/24eZEKH1X+u/PYGD?=
 =?us-ascii?Q?47K7F2QU512e3f1qMYRmxHAxeiVDI7P+qKP2VRjMuTjFNjEbP8Xd6HymHP5F?=
 =?us-ascii?Q?kclRD+UhgWyYxP14TyoUVeXvhyrH7XcSsdvVisdnx4eoEEfz1tu64tzJb+/R?=
 =?us-ascii?Q?PWHZghxFX70d+dEe/M3JydLk57D5h779ESK/XPXaq/QrmW70/GTJpadXpAvl?=
 =?us-ascii?Q?/M8mYxsuhf1J3wcv84DtrzSs1TfsRXUdpI8LuBf3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cfe0846-d335-41ae-b03a-08dba000c314
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 15:35:33.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeonaXOlfJxBD62DmqyrjqHTxkIpiDtOmWqW9UptScAAr+QGZJcpuSncFmqTm0PDmDbb3ud63FiueTRREA2FKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7307
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements a power domain by wrapping a group of regulators
into a unified genpd abstraction. The power domain is defined in the
device tree, allowing the driver framework to automatically manage
the power for the those devices which use the power domain. This removes
the need to manually adjust each individual driver to directly control
the regulators. The solution can also take the benefit of runtime PM
subsystem, and the device's power can be managed automatically when the
device is idle.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 drivers/genpd/Makefile       |   1 +
 drivers/genpd/regulator-pd.c | 145 +++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 drivers/genpd/regulator-pd.c

diff --git a/drivers/genpd/Makefile b/drivers/genpd/Makefile
index 666753676e5c..5eacd7ea2a2d 100644
--- a/drivers/genpd/Makefile
+++ b/drivers/genpd/Makefile
@@ -15,3 +15,4 @@ obj-y					+= sunxi/
 obj-y					+= tegra/
 obj-y					+= ti/
 obj-y					+= xilinx/
+obj-y					+= regulator-pd.o
diff --git a/drivers/genpd/regulator-pd.c b/drivers/genpd/regulator-pd.c
new file mode 100644
index 000000000000..dc30a81d7e65
--- /dev/null
+++ b/drivers/genpd/regulator-pd.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2023 NXP Semiconductor, Inc.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regulator/consumer.h>
+
+struct regulator_power_domain {
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	struct regulator *reg;
+	int idx;
+};
+
+#define to_regulator_power_domain(_genpd) container_of(_genpd, struct regulator_power_domain, genpd)
+
+static int regulator_power_domain_on(struct generic_pm_domain *genpd)
+{
+	struct regulator_power_domain *domain = to_regulator_power_domain(genpd);
+
+	if (IS_ERR_OR_NULL(domain->reg))
+		return -ENODEV;
+
+	return regulator_enable(domain->reg);
+}
+
+static int regulator_power_domain_off(struct generic_pm_domain *genpd)
+{
+	struct regulator_power_domain *domain = to_regulator_power_domain(genpd);
+
+	if (IS_ERR_OR_NULL(domain->reg))
+		return -ENODEV;
+
+	return regulator_disable(domain->reg);
+}
+
+static struct generic_pm_domain *
+regulator_power_domain_xlate(struct of_phandle_args *spec, void *data)
+{
+	struct generic_pm_domain *domain = ERR_PTR(-ENOENT);
+	struct genpd_onecell_data *pd_data = data;
+	struct regulator_power_domain *rpd;
+	unsigned int i;
+
+	for (i = 0; i < pd_data->num_domains; i++) {
+		rpd = to_regulator_power_domain(pd_data->domains[i]);
+		if (rpd->idx == spec->args[0]) {
+			domain = &rpd->genpd;
+			break;
+		}
+	}
+
+	return domain;
+}
+
+static int regulator_power_domain_probe(struct platform_device *pdev)
+{
+	struct regulator_power_domain *gpd;
+	struct genpd_onecell_data *pd_data;
+	struct device *dev = &pdev->dev;
+	struct generic_pm_domain **pds;
+	char name[16];
+	u32 num;
+	int i;
+
+	if (of_property_read_u32(dev->of_node, "regulator-number", &num))
+		return -ENODEV;
+
+	if (num < 1)
+		return -EINVAL;
+
+	/* Limit the regulator count to <=100 */
+	if (num > 100)
+		num = 100;
+
+	pd_data = devm_kzalloc(dev, sizeof(*pd_data), GFP_KERNEL);
+	pds = devm_kcalloc(dev, num, sizeof(*pds), GFP_KERNEL);
+	gpd = devm_kcalloc(dev, num, sizeof(*gpd), GFP_KERNEL);
+
+	if (!pds || !pd_data || !gpd)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		bool is_off = 1;
+
+		snprintf(name, 16, "regulator-%d", i);
+		gpd->reg = devm_regulator_get_optional(dev, name);
+
+		/* Let the initial pd state as is as the regulator's */
+		if (!(IS_ERR_OR_NULL(gpd->reg)))
+			is_off = (regulator_is_enabled(gpd->reg) > 0) ? 0 : 1;
+
+		pm_genpd_init(&gpd->genpd, NULL, is_off);
+
+		gpd->genpd.power_off = regulator_power_domain_off;
+		gpd->genpd.power_on = regulator_power_domain_on;
+		gpd->genpd.name = dev_name(dev);
+		gpd->dev = dev;
+		gpd->idx = i;
+		pds[i] = &gpd->genpd;
+		gpd++;
+	}
+
+	pd_data->domains = pds;
+	pd_data->num_domains = num;
+	pd_data->xlate = regulator_power_domain_xlate;
+	platform_set_drvdata(pdev, pd_data);
+
+	return of_genpd_add_provider_onecell(dev->of_node, pd_data);
+}
+
+static int regulator_power_domain_remove(struct platform_device *pdev)
+{
+	struct genpd_onecell_data *pd_data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int i;
+
+	of_genpd_del_provider(np);
+	for (i = 0; i < pd_data->num_domains; i++)
+		pm_genpd_remove(pd_data->domains[i]);
+
+	return 0;
+}
+
+static const struct of_device_id regulator_power_domain_dt_ids[] = {
+	{ .compatible = "regulator-power-domain"},
+	{ }
+};
+
+static struct platform_driver regulator_power_domain_driver = {
+	.driver = {
+		.name = "regulator2pd",
+		.of_match_table = regulator_power_domain_dt_ids,
+	},
+	.probe = regulator_power_domain_probe,
+	.remove = regulator_power_domain_remove,
+};
+builtin_platform_driver(regulator_power_domain_driver)
+
+MODULE_AUTHOR("Shenwei Wang <shenwei.wang@nxp.com>");
+MODULE_DESCRIPTION("regulator power domain driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

