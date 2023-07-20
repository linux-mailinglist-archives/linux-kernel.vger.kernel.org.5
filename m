Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2253275B06A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGTNwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGTNwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:52:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E6826B8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:52:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e916b880so493763b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689861130; x=1690465930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qS4rSoMpsPTrpbs2pXhcvTjAuzxn4O4O0rAmnyVf5nA=;
        b=PM0ucZWv2HP+s6G6MjWgANRwFtP4rxmVf9ge5rFDkBv8onydvKdZqDWKFBJo4J0pQK
         oSqs7R2SEGdvbEbqP/YylewMILEcQPbsuVfAPXQYvxb1NDBUSkjrSGGVWLoKrA3f19rm
         Mz9gSJcbyRX4fzpmrCpWEuva7f40DZ1qQ9oIwVGBWRELGtv8IaLUNIwygAsmnZKi/VME
         uKxGJXQto6+3ceYBPvV0uowRRb+Frdsq9uh6tkyYMuDeb0ybPAQ8D4OAmzhpOQe2ChjE
         gvfC+q+wjZXeycg2kvMnS07drF4Qn183nZ9t3T1ltQ05IXh+cr6qEvRD4pfSkslEkB9H
         f5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861130; x=1690465930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qS4rSoMpsPTrpbs2pXhcvTjAuzxn4O4O0rAmnyVf5nA=;
        b=gF9j0YWjIyQHecUubijTk9wg1BSVndoFeAtffd+ptJp/GtzCilVKr5TcqWuwgzcEnY
         eQ4V2D0tJ/zDa/28Wv2b2Xr18JExx7vMrbTe7tLtc+n9O69wfxrXghkGhE1oXgAZx/dh
         xb9JJwXQZrDupktkxdJdHgjL1FyNZgQ83iZwW9t4aL9yOaYFZXGK6QT/+NxB7qbX1a4W
         mbJK3lD55oLZNX/H7LyXyTn/BN37S9VsHNt8ayA9EiEz7t3pxBEuFq9St0QjLm7f1Qim
         5FapQzYb/ENfRWPA8GeGxDFWxRY1dem3EH/nwBE0qCbPZ3TZK9RXyq6ciyxFTgWyI/9M
         VS0A==
X-Gm-Message-State: ABy/qLaO6Ytq1fD5/QuSdz4D0RxdU1nGih3Pob6tV0fr7NW1UIhanv7Y
        HiCYns7CZH/QzlAxRD4nUF+SYA==
X-Google-Smtp-Source: APBJJlEZfB9LccJbk0uRcMlpNu6LKwKkACSbEbpmdAREbEDK1tuuO3YVIX+J3yvt7Vysm0XaHHXmxw==
X-Received: by 2002:a05:6a21:998a:b0:134:8b50:47cd with SMTP id ve10-20020a056a21998a00b001348b5047cdmr14500922pzb.9.1689861130087;
        Thu, 20 Jul 2023 06:52:10 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78d12000000b00679fef56287sm1197529pfe.147.2023.07.20.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:52:09 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        peterz@infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>,
        Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 2/3] soc: sifive: Add SiFive private L2 cache driver
Date:   Thu, 20 Jul 2023 21:51:20 +0800
Message-Id: <20230720135125.21240-3-eric.lin@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720135125.21240-1-eric.lin@sifive.com>
References: <20230720135125.21240-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SiFive private L2 cache driver which will show
cache config information when booting and add cpu hotplug
callback functions.

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Nick Hu <nick.hu@sifive.com>
Signed-off-by: Nick Hu <nick.hu@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
---
 drivers/soc/sifive/Kconfig            |   8 ++
 drivers/soc/sifive/Makefile           |   1 +
 drivers/soc/sifive/sifive_pl2.h       |  27 ++++
 drivers/soc/sifive/sifive_pl2_cache.c | 194 ++++++++++++++++++++++++++
 include/linux/cpuhotplug.h            |   1 +
 5 files changed, 231 insertions(+)
 create mode 100644 drivers/soc/sifive/sifive_pl2.h
 create mode 100644 drivers/soc/sifive/sifive_pl2_cache.c

diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
index e86870be34c9..573564295058 100644
--- a/drivers/soc/sifive/Kconfig
+++ b/drivers/soc/sifive/Kconfig
@@ -7,4 +7,12 @@ config SIFIVE_CCACHE
 	help
 	  Support for the composable cache controller on SiFive platforms.
 
+config SIFIVE_PL2
+	bool "Sifive private L2 Cache controller"
+	help
+	  Support for the private L2 cache controller on SiFive platforms.
+	  The SiFive Private L2 Cache Controller is per hart and communicates
+	  with both the upstream L1 caches and downstream L3 cache or memory,
+	  enabling a high-performance cache subsystem.
+
 endif
diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
index 1f5dc339bf82..707493e1c691 100644
--- a/drivers/soc/sifive/Makefile
+++ b/drivers/soc/sifive/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SIFIVE_CCACHE)	+= sifive_ccache.o
+obj-$(CONFIG_SIFIVE_PL2)	+= sifive_pl2_cache.o
diff --git a/drivers/soc/sifive/sifive_pl2.h b/drivers/soc/sifive/sifive_pl2.h
new file mode 100644
index 000000000000..9a5c9ee898bd
--- /dev/null
+++ b/drivers/soc/sifive/sifive_pl2.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 SiFive, Inc.
+ *
+ */
+
+#ifndef _SIFIVE_PL2_H
+#define _SIFIVE_PL2_H
+
+#define SIFIVE_PL2_CONFIG1_OFFSET	0x1000
+#define SIFIVE_PL2_CONFIG0_OFFSET	0x1008
+#define SIFIVE_PL2_PMCLIENT_OFFSET	0x2800
+
+#define SIFIVE_PL2CACHE_CONFIG 0x00
+#define SIFIVE_PL2CACHE_CONFIG_BANK_MASK GENMASK_ULL(7, 0)
+#define SIFIVE_PL2CACHE_CONFIG_WAYS_MASK GENMASK_ULL(15, 8)
+#define SIFIVE_PL2CACHE_CONFIG_SETS_MASK GENMASK_ULL(23, 16)
+#define SIFIVE_PL2CACHE_CONFIG_BLKS_MASK GENMASK_ULL(31, 24)
+
+struct sifive_pl2_state {
+	void __iomem *pl2_base;
+	u32 config1;
+	u64 config0;
+	u64 pmclientfilter;
+};
+
+#endif /*_SIFIVE_PL2_H */
diff --git a/drivers/soc/sifive/sifive_pl2_cache.c b/drivers/soc/sifive/sifive_pl2_cache.c
new file mode 100644
index 000000000000..da2dc0eead74
--- /dev/null
+++ b/drivers/soc/sifive/sifive_pl2_cache.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive private L2 cache controller Driver
+ *
+ * Copyright (C) 2018-2023 SiFive, Inc.
+ */
+
+#define pr_fmt(fmt) "pL2CACHE: " fmt
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpuhotplug.h>
+#include <linux/bitfield.h>
+#include "sifive_pl2.h"
+
+static DEFINE_PER_CPU(struct sifive_pl2_state, sifive_pl2_state);
+
+static void sifive_pl2_state_save(struct sifive_pl2_state *pl2_state)
+{
+	void __iomem *pl2_base = pl2_state->pl2_base;
+
+	if (!pl2_base)
+		return;
+
+	pl2_state->config1 = readl(pl2_base + SIFIVE_PL2_CONFIG1_OFFSET);
+	pl2_state->config0 = readq(pl2_base + SIFIVE_PL2_CONFIG0_OFFSET);
+	pl2_state->pmclientfilter = readq(pl2_base + SIFIVE_PL2_PMCLIENT_OFFSET);
+}
+
+static void sifive_pl2_state_restore(struct sifive_pl2_state *pl2_state)
+{
+	void __iomem *pl2_base = pl2_state->pl2_base;
+
+	if (!pl2_base)
+		return;
+
+	writel(pl2_state->config1, pl2_base + SIFIVE_PL2_CONFIG1_OFFSET);
+	writeq(pl2_state->config0, pl2_base + SIFIVE_PL2_CONFIG0_OFFSET);
+	writeq(pl2_state->pmclientfilter, pl2_base + SIFIVE_PL2_PMCLIENT_OFFSET);
+}
+
+/*
+ * CPU Hotplug call back function
+ */
+static int sifive_pl2_online_cpu(unsigned int cpu)
+{
+	struct sifive_pl2_state *pl2_state = this_cpu_ptr(&sifive_pl2_state);
+
+	sifive_pl2_state_restore(pl2_state);
+
+	return 0;
+}
+
+static int sifive_pl2_offline_cpu(unsigned int cpu)
+{
+	struct sifive_pl2_state *pl2_state = this_cpu_ptr(&sifive_pl2_state);
+
+	/* Save the pl2 state */
+	sifive_pl2_state_save(pl2_state);
+
+	return 0;
+}
+
+/*
+ *  PM notifer for suspend to ram
+ */
+#ifdef CONFIG_CPU_PM
+static int sifive_pl2_pm_notify(struct notifier_block *b, unsigned long cmd,
+				void *v)
+{
+	struct sifive_pl2_state *pl2_state = this_cpu_ptr(&sifive_pl2_state);
+
+	switch (cmd) {
+	case CPU_PM_ENTER:
+		/* Save the pl2 state */
+		sifive_pl2_state_save(pl2_state);
+		break;
+	case CPU_PM_ENTER_FAILED:
+	case CPU_PM_EXIT:
+		sifive_pl2_state_restore(pl2_state);
+		break;
+	default:
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block sifive_pl2_pm_notifier_block = {
+	.notifier_call = sifive_pl2_pm_notify,
+};
+
+static inline void sifive_pl2_pm_init(void)
+{
+	cpu_pm_register_notifier(&sifive_pl2_pm_notifier_block);
+}
+
+#else
+static inline void sifive_pl2_pm_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
+static const struct of_device_id sifive_pl2_cache_of_ids[] = {
+	{ .compatible = "sifive,pl2cache1" },
+	{ /* sentinel value */ }
+};
+
+static void pl2_config_read(void __iomem *pl2_base, int cpu)
+{
+	u32 cfg, banks, ways, cacheline, sets;
+
+	cfg = readl(pl2_base + SIFIVE_PL2CACHE_CONFIG);
+	banks = FIELD_GET(SIFIVE_PL2CACHE_CONFIG_BANK_MASK, cfg);
+	ways = FIELD_GET(SIFIVE_PL2CACHE_CONFIG_WAYS_MASK, cfg);
+	cacheline = FIELD_GET(SIFIVE_PL2CACHE_CONFIG_BLKS_MASK, cfg);
+	sets = FIELD_GET(SIFIVE_PL2CACHE_CONFIG_SETS_MASK, cfg);
+	pr_info("%u banks, ways/bank=%u, bytes/block=%llu, sets:%llu, size:%d for CPU:%d\n",
+		banks, ways, BIT_ULL(cacheline), BIT_ULL(sets), ways << (sets + cacheline), cpu);
+}
+
+static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
+{
+	struct device_node *cpu_node, *pl2_node;
+	struct sifive_pl2_state *pl2_state = NULL;
+	struct resource *res;
+	void __iomem *pl2_base;
+	int cpu;
+
+	/* Traverse all cpu nodes to find the one mapping to its pl2 node. */
+	for_each_cpu(cpu, cpu_possible_mask) {
+		cpu_node = of_cpu_device_node_get(cpu);
+		pl2_node = of_parse_phandle(cpu_node, "next-level-cache", 0);
+
+		/* Found it! */
+		if (dev_of_node(&pdev->dev) == pl2_node) {
+			/* Use cpu to get its percpu data sifive_pl2_state. */
+			pl2_state = per_cpu_ptr(&sifive_pl2_state, cpu);
+			break;
+		}
+	}
+
+	if (!pl2_state) {
+		pr_err("Failed to find CPU node for %s.\n", pdev->name);
+		return -EINVAL;
+	}
+
+	/* Set base address of select and counter registers. */
+	pl2_base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(pl2_base))
+		return PTR_ERR(pl2_base);
+
+	/* Print pL2 configs. */
+	pl2_config_read(pl2_base, cpu);
+	pl2_state->pl2_base = pl2_base;
+
+	return 0;
+}
+
+static struct platform_driver sifive_pl2_cache_driver = {
+	.driver = {
+		   .name = "SiFive-pL2-cache",
+		   .of_match_table = sifive_pl2_cache_of_ids,
+		   },
+	.probe = sifive_pl2_cache_dev_probe,
+};
+
+static int __init sifive_pl2_cache_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
+				"soc/sifive/pl2:online",
+				sifive_pl2_online_cpu,
+				sifive_pl2_offline_cpu);
+	if (ret < 0) {
+		pr_err("Failed to register CPU hotplug notifier %d\n", ret);
+		return ret;
+	}
+
+	ret = platform_driver_register(&sifive_pl2_cache_driver);
+	if (ret) {
+		pr_err("Failed to register sifive_pl2_cache_driver: %d\n", ret);
+		cpuhp_remove_state(CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE);
+		return ret;
+	}
+
+	sifive_pl2_pm_init();
+
+	return 0;
+}
+
+device_initcall(sifive_pl2_cache_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 25b6e6e6ba6b..f2df088bf7eb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -209,6 +209,7 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_BLK_MQ_ONLINE,
 	CPUHP_AP_ARM_MVEBU_SYNC_CLOCKS,
+	CPUHP_AP_RISCV_SIFIVE_PL2_ONLINE,
 	CPUHP_AP_X86_INTEL_EPB_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
 	CPUHP_AP_PERF_X86_ONLINE,
-- 
2.40.1

