Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D186E75250A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjGMOTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGMOS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:18:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954C81BE3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso1421405e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257904; x=1691849904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmq/h80ovL13+V/r08VWoNgXJwdj+6X80/5vfDvf7TM=;
        b=FTghKfMqaBJoT1bpYiRyqVPCuQll3hXIEIstKsh+QL0vxd7oz0qt5Y6eWvlGbpX3cs
         +Sd8BfKgnQJ3Yhu6qkfcD0/MbRRwrSXCz/EVJxnPDtEzIVEnsS6PkrtlMc47dwiUNEbV
         i2x4Pqf2WgLDaZcHPlOAZ8aFYjJq3lq+ySiAg3q/feMEKSqgAO9Y3USRGtZ6iebdX+eA
         Jfmwa8w4Dkyxf0TvwTn1kfObZ/HLrM5Fg1leHhwlyXHTYmcZTqp0dEnp/QpuebVeHEku
         dqK1xcxWePk9lEoGTv+ED5vdPx42YpMsuewFMJgbJJ6QkHyEaE1DRBf0U2m7/3f7DGoG
         hMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257904; x=1691849904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cmq/h80ovL13+V/r08VWoNgXJwdj+6X80/5vfDvf7TM=;
        b=DqvznYQ6Jm7+T4PG0SyFOp6hZTPLxkpp2kFGue+UwHTp4Y2JMZLtFuIX4d0YsC4bGl
         BNLSHN7LS5ix5jfTR+HQfV46brq/g21xvZ2JILGcJrnDsxoxPgp4j0iskDoMCTbdbhUl
         v/uwGBddMTR/UqYN09er/v7cGTiLmotNKkh2Vz5nhMrOLbbvv/X1QWkazkv6p5Gu62fC
         mo+4ih9a/7qRYr+fWiy1xnOPde3dCRMftEAyDlxqnzEihT9BcN772vft5Q40+UxN1Frl
         6GUQHkUqq7KNtg+iM3+2r5IlZ0+R6a0UJhWJN1omT6UPXsg9vFBraKO/xO2a4gFG+9B3
         pL9g==
X-Gm-Message-State: ABy/qLbRS+/Np+njzTVCvNrvQog/ILGetlh/PX6MzaUvMDcj6719pcMl
        y5gVgZt0FjSivzWClsvxVMysAQ==
X-Google-Smtp-Source: APBJJlEw/r/rZ4KP7q3w8Znj84AUPeVdq+hFtHUzpqRpyzbbmKBt2AtXseIEaGeQQAU+CgyD20lUvA==
X-Received: by 2002:a05:6512:2253:b0:4fb:896d:bd70 with SMTP id i19-20020a056512225300b004fb896dbd70mr1399041lfu.46.1689257903884;
        Thu, 13 Jul 2023 07:18:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance domain
Date:   Thu, 13 Jul 2023 16:17:37 +0200
Message-Id: <20230713141738.23970-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable support for performance scaling (DVFS) for generic devices with
the SCMI performance protocol, let's add an SCMI performance domain. This
is being modelled as a genpd provider, with support for performance scaling
through genpd's ->set_performance_state() callback.

Note that, this adds the initial support that allows consumer drivers for
attached devices, to vote for a new performance state via calling the
dev_pm_genpd_set_performance_state(). However, this should be avoided as
it's in most cases preferred to use the OPP library to vote for a new OPP
instead. The support using the OPP library isn't part of this change, but
needs to be implemented from subsequent changes.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Converted to use the new ->domain_info_get() callback.

---
 drivers/firmware/arm_scmi/Kconfig            |  12 ++
 drivers/firmware/arm_scmi/Makefile           |   1 +
 drivers/firmware/arm_scmi/scmi_perf_domain.c | 155 +++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_perf_domain.c

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index ea0f5083ac47..706d1264d038 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -181,6 +181,18 @@ config ARM_SCMI_POWER_DOMAIN
 	  will be called scmi_pm_domain. Note this may needed early in boot
 	  before rootfs may be available.
 
+config ARM_SCMI_PERF_DOMAIN
+	tristate "SCMI performance domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI performance domains which can be
+	  enabled or disabled via the SCP firmware.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called scmi_perf_domain.
+
 config ARM_SCMI_POWER_CONTROL
 	tristate "SCMI system power control driver"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b31d78fa66cc..afee66a65dcb 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
 
 obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
+obj-$(CONFIG_ARM_SCMI_PERF_DOMAIN) += scmi_perf_domain.o
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
 ifeq ($(CONFIG_THUMB2_KERNEL)$(CONFIG_CC_IS_CLANG),yy)
diff --git a/drivers/firmware/arm_scmi/scmi_perf_domain.c b/drivers/firmware/arm_scmi/scmi_perf_domain.c
new file mode 100644
index 000000000000..4ed2401995be
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_perf_domain.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SCMI performance domain support.
+ *
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/scmi_protocol.h>
+#include <linux/slab.h>
+
+struct scmi_perf_domain {
+	struct generic_pm_domain genpd;
+	const struct scmi_perf_proto_ops *perf_ops;
+	const struct scmi_protocol_handle *ph;
+	const struct scmi_perf_domain_info *info;
+	u32 domain_id;
+};
+
+#define to_scmi_pd(pd) container_of(pd, struct scmi_perf_domain, genpd)
+
+static int
+scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
+{
+	struct scmi_perf_domain *pd = to_scmi_pd(genpd);
+	int ret;
+
+	if (!pd->info->set_perf)
+		return 0;
+
+	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, true);
+	if (ret)
+		dev_warn(&genpd->dev, "Failed with %d when trying to set %d perf level",
+			 ret, state);
+
+	return ret;
+}
+
+static int scmi_perf_domain_probe(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	const struct scmi_handle *handle = sdev->handle;
+	const struct scmi_perf_proto_ops *perf_ops;
+	struct scmi_protocol_handle *ph;
+	struct scmi_perf_domain *scmi_pd;
+	struct genpd_onecell_data *scmi_pd_data;
+	struct generic_pm_domain **domains;
+	int num_domains, i, ret = 0;
+	u32 perf_level;
+
+	if (!handle)
+		return -ENODEV;
+
+	/* The OF node must specify us as a power-domain provider. */
+	if (!of_find_property(dev->of_node, "#power-domain-cells", NULL))
+		return 0;
+
+	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
+	if (IS_ERR(perf_ops))
+		return PTR_ERR(perf_ops);
+
+	num_domains = perf_ops->num_domains_get(ph);
+	if (num_domains < 0) {
+		dev_warn(dev, "Failed with %d when getting num perf domains\n",
+			 num_domains);
+		return num_domains;
+	} else if (!num_domains) {
+		return 0;
+	}
+
+	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
+	if (!scmi_pd)
+		return -ENOMEM;
+
+	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
+	if (!scmi_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++, scmi_pd++) {
+		scmi_pd->info = perf_ops->domain_info_get(ph, i);
+
+		scmi_pd->domain_id = i;
+		scmi_pd->perf_ops = perf_ops;
+		scmi_pd->ph = ph;
+		scmi_pd->genpd.name = scmi_pd->info->name;
+		scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
+		scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
+
+		ret = perf_ops->level_get(ph, i, &perf_level, false);
+		if (ret) {
+			dev_dbg(dev, "Failed to get perf level for %s",
+				 scmi_pd->genpd.name);
+			perf_level = 0;
+		}
+
+		/* Let the perf level indicate the power-state too. */
+		ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
+		if (ret)
+			goto err;
+
+		domains[i] = &scmi_pd->genpd;
+	}
+
+	scmi_pd_data->domains = domains;
+	scmi_pd_data->num_domains = num_domains;
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, scmi_pd_data);
+	if (ret)
+		goto err;
+
+	dev_set_drvdata(dev, scmi_pd_data);
+	dev_info(dev, "Initialized %d performance domains", num_domains);
+	return 0;
+err:
+	for (i--; i >= 0; i--)
+		pm_genpd_remove(domains[i]);
+	return ret;
+}
+
+static void scmi_perf_domain_remove(struct scmi_device *sdev)
+{
+	struct device *dev = &sdev->dev;
+	struct genpd_onecell_data *scmi_pd_data = dev_get_drvdata(dev);
+	int i;
+
+	of_genpd_del_provider(dev->of_node);
+
+	for (i = 0; i < scmi_pd_data->num_domains; i++)
+		pm_genpd_remove(scmi_pd_data->domains[i]);
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_PERF, "perf" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_perf_domain_driver = {
+	.name		= "scmi-perf-domain",
+	.probe		= scmi_perf_domain_probe,
+	.remove		= scmi_perf_domain_remove,
+	.id_table	= scmi_id_table,
+};
+module_scmi_driver(scmi_perf_domain_driver);
+
+MODULE_AUTHOR("Ulf Hansson <ulf.hansson@linaro.org>");
+MODULE_DESCRIPTION("ARM SCMI perf domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

