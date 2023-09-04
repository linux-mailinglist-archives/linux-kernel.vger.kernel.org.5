Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A130479169F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352874AbjIDL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjIDL6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:58:35 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A70197
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 04:58:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dk-0003r2-RT; Mon, 04 Sep 2023 13:58:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dk-003s43-5M; Mon, 04 Sep 2023 13:58:20 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qd8Dj-005pOo-GB; Mon, 04 Sep 2023 13:58:19 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/3] pinctrl: rockchip: add support for io-domain dependency
Date:   Mon,  4 Sep 2023 13:58:14 +0200
Message-Id: <20230904115816.1237684-2-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904115816.1237684-1-s.hauer@pengutronix.de>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Rockchip SoCs, some SoC pins are split in what are called IO
domains.

An IO domain is supplied power externally, by regulators from a PMIC for
example. This external power supply is then used by the IO domain as
"supply" for the IO pins if they are outputs.

Each IO domain can configure which voltage the IO pins will be operating
on (1.8V or 3.3V).

There already exists an IO domain driver for Rockchip SoCs[1]. This
driver allows to explicit the relationship between the external power
supplies and IO domains[2]. This makes sure the regulators are enabled
by the Linux kernel so the IO domains are supplied with power and
correctly configured as per the supplied voltage.
This driver is a regulator consumer and does not offer any other
interface for device dependency.

However, IO pins belonging to an IO domain need to have this IO domain
configured correctly before they are being used otherwise they do not
operate correctly.

We currently do not have any knowledge about which pin is on which IO
domain, so we assume that all pins are on some IO domain and defer
probing of the pin consumers until the IO domain driver has been probed.
Some pins however are needed to access the regulators driving an IO
domain. Deferring probe for them as well would introduce a cyclic
dependency. To break out of this dependency a pin group can be supplied
a rockchip,io-domain-boot-on property. Probe won't be deferred for pin
groups with this property. rockchip,io-domain-boot-on should be added
to all pin groups needed to access the PMIC driving the IO domains.

[1] drivers/soc/rockchip/io-domain.c
[2] Documentation/devicetree/bindings/power/rockchip-io-domain.yaml

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/pinctrl/pinctrl-rockchip.c | 64 ++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-rockchip.h |  3 ++
 2 files changed, 67 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 0276b52f37168..663bd9d6840a5 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -24,6 +24,8 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinctrl.h>
@@ -2678,6 +2680,43 @@ static int rockchip_pmx_get_groups(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
+static int rockchip_pmx_check_io_domain(struct rockchip_pinctrl *info, unsigned group)
+{
+	struct platform_device *pdev;
+	int i;
+
+	if (!info->io_domains)
+		return 0;
+
+	if (info->groups[group].io_domain_skip)
+		return 0;
+
+	for (i = 0; i < info->num_io_domains; i++) {
+		if (!info->io_domains[i])
+			continue;
+
+		pdev = of_find_device_by_node(info->io_domains[i]);
+		if (!pdev) {
+			dev_err(info->dev, "couldn't find IO domain device\n");
+			return -ENODEV;
+		}
+
+		if (!platform_get_drvdata(pdev)) {
+			dev_err(info->dev, "IO domain device is not probed yet, deferring...(%s)",
+				info->groups[group].name);
+			return -EPROBE_DEFER;
+		}
+
+		of_node_put(info->io_domains[i]);
+		info->io_domains[i] = NULL;
+	}
+
+	devm_kfree(info->dev, info->io_domains);
+	info->io_domains = NULL;
+
+	return 0;
+}
+
 static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 			    unsigned group)
 {
@@ -2691,6 +2730,10 @@ static int rockchip_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
 	dev_dbg(dev, "enable function %s group %s\n",
 		info->functions[selector].name, info->groups[group].name);
 
+	ret = rockchip_pmx_check_io_domain(info, group);
+	if (ret)
+		return ret;
+
 	/*
 	 * for each pin in the pin group selected, program the corresponding
 	 * pin function number in the config register.
@@ -3019,6 +3062,8 @@ static int rockchip_pinctrl_parse_groups(struct device_node *np,
 	if (!size || size % 4)
 		return dev_err_probe(dev, -EINVAL, "wrong pins number or pins and configs should be by 4\n");
 
+	grp->io_domain_skip = of_property_read_bool(np, "rockchip,io-domain-boot-on");
+
 	grp->npins = size / 4;
 
 	grp->pins = devm_kcalloc(dev, grp->npins, sizeof(*grp->pins), GFP_KERNEL);
@@ -3417,6 +3462,22 @@ static int rockchip_pinctrl_probe(struct platform_device *pdev)
 			return PTR_ERR(info->regmap_pmu);
 	}
 
+	info->num_io_domains = of_property_count_u32_elems(np, "rockchip,io-domains");
+	if (info->num_io_domains) {
+		int i;
+
+		info->io_domains = devm_kmalloc_array(dev, info->num_io_domains,
+						      sizeof(*info->io_domains), GFP_KERNEL);
+		if (!info->io_domains)
+			return -ENOMEM;
+
+		for (i = 0; i < info->num_io_domains; i++) {
+			info->io_domains[i] = of_parse_phandle(np, "rockchip,io-domains", 0);
+			if (!info->io_domains[i])
+				return -EINVAL;
+		}
+	}
+
 	ret = rockchip_pinctrl_register(pdev, info);
 	if (ret)
 		return ret;
@@ -3439,6 +3500,9 @@ static int rockchip_pinctrl_remove(struct platform_device *pdev)
 
 	of_platform_depopulate(&pdev->dev);
 
+	for (i = 0; i < info->num_io_domains; i++)
+		of_node_put(info->io_domains[i]);
+
 	for (i = 0; i < info->ctrl->nr_banks; i++) {
 		bank = &info->ctrl->pin_banks[i];
 
diff --git a/drivers/pinctrl/pinctrl-rockchip.h b/drivers/pinctrl/pinctrl-rockchip.h
index 4759f336941ef..d2ac79b0a7bc4 100644
--- a/drivers/pinctrl/pinctrl-rockchip.h
+++ b/drivers/pinctrl/pinctrl-rockchip.h
@@ -435,6 +435,7 @@ struct rockchip_pin_group {
 	unsigned int			npins;
 	unsigned int			*pins;
 	struct rockchip_pin_config	*data;
+	bool				io_domain_skip;
 };
 
 /**
@@ -462,6 +463,8 @@ struct rockchip_pinctrl {
 	unsigned int			ngroups;
 	struct rockchip_pmx_func	*functions;
 	unsigned int			nfunctions;
+	struct device_node		**io_domains;
+	int				num_io_domains;
 };
 
 #endif
-- 
2.39.2

