Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD874776983
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbjHIUKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjHIUKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:10:02 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A12106
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:10:00 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so188999e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691611799; x=1692216599;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6XLoKrNgsmk7viP+YC7H/buNRrtbWmWLQbvsiyzw8s=;
        b=SWw8OjNw3SwTMTbDbAdjStjekRnYIGbTxaLFqj7VZ8YRRHs+LysmN+7XVw8kda/PtO
         rdC5HziWhvDaH5qW4shzQ3dHjNkF8CUKFfWYFJW6xlS327hdaxDl2710wM10z9yEl2mB
         A/deqeCRvh9RnjTisET8RpzPexrbAo5hanJpNqj1Ey+j3pVYF090U0eD3vAuVwzppRVk
         ccwN9vPzWeoUToZQmbWUTRICbTQxOwX/EDX7IaamJvtsv/nZsTwmeEvQPeQB7AjEv9G9
         sLfmLlpB4jnPJlyRnr5oNBcLqgcVFjGWB9ymK9BrpNnvKsF+9sm31p2zdRLfemsFaSHy
         dOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611799; x=1692216599;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V6XLoKrNgsmk7viP+YC7H/buNRrtbWmWLQbvsiyzw8s=;
        b=GtW5WFJiUKzsq+0A8EH8vLzHANKgCys8uMdtq0fUEM+nFGZ0Q3qfHd/f+Tk/MRolSg
         yZv7J655awwVMFA+XR4JMMzgYZJPN7DNmpqIQOkbwaOGx41OhICtjWlZZXpOW2QPgThX
         7eHDaPlc47xpjHKOgAYLkNpw+zSLqs2JmjNPYvQq73WYVv+r2LV+tmP3dkYArqDDGccc
         lQMvecmPCGE/XT9qsXZqnu23QrIW5HcxQcDU9w0F55NA6rYvaTDUF17Zc+xylM7JpQHt
         ZMI4J773DJ7Yl5iQ7pA/FmKZP23ya4dpTP2zOBD/kcpLC85PMNxtbgCT5f5026W6fM3Y
         r7CQ==
X-Gm-Message-State: AOJu0YxIegJyyj7eM4i4g2xrsKGYcDKtjDhRCGe7Ohftwj6GCzNDscSJ
        4bn6fCUctdL/XcznImuY8Y5hUA==
X-Google-Smtp-Source: AGHT+IF08/jyxQ5gzR560y3uAW97Bxj0LaAmp3w5Urt8jwoTQWN4Z96Gu6Aw1SQJqPEenrTb+JlBng==
X-Received: by 2002:a05:6512:3c89:b0:4fe:3e89:fcb2 with SMTP id h9-20020a0565123c8900b004fe3e89fcb2mr148854lfv.34.1691611798990;
        Wed, 09 Aug 2023 13:09:58 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id q7-20020a19a407000000b004fb7848bacbsm2413405lfc.46.2023.08.09.13.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:09:58 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 22:09:48 +0200
Subject: [PATCH RFC DNM] perf: Add support for Qualcomm Last-Level Cache
 Controller PMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-llcc_pmu-v1-1-dd27bd1f44c9@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIvy02QC/x2N0QqDMAwAf0XyvECtINNfERltjDNQa2nnEMR/N
 /h4B8edUDgLF+irEzL/pcgWFepXBbS4+GWUSRmssY15mw5/WxLCEIg+ad2RWu4mT03rawsaeVc
 YfXaRFs3iHoLKlHmW47kM43Xdyo44kXUAAAA=
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691611797; l=10142;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IzGgwLJxOKyAxkA8Yg1aDkGbo/ZbfTkcq54Y5dHJP0s=;
 b=cE7QfOpiF3356UHbu2pxSFkILkOv+GWOUHFGJiRq1PViCKFM994930wpcSrvmHWXF3U1Nc5uW
 CIdSSLOw1bCBfN7eacHd/VKEzxmraxGsFnbPK3J/FQlDl5l1TENlhjr
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Qualcomm LLCC (Last-Level Cache Controller) PMU,
which provides a single event, expressing cache read misses.

Based on the vendor driver found in the msm-5.10 downstream kernel.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Hi, I've been trying to get this driver going upstream by cleaning it
up and adding the necessary perf boilerplate (the original Qualcomm one
only pokes at the PMU from within the kernel itself) to use the
userspace tool.

I can not however get it to cooperate.. in this iteration I get a PMU
event registered (though with only a "raw" name - no "x OR y" like with
other PMUs on the system) as:

llcc_pmu/read_miss/                                [Kernel PMU event]

but the .read callback is never called when I run:

sudo perf stat -C 0 -a -e llcc_pmu/read_miss/ stress-ng -C 8 -c 8 -m 10

which always returns 0

if I add --always-kernel I get:
<not supported>      llcc_pmu/read_miss/

So, here's me asking for some help. It's probably missing some small
detail, as per usual..
---
 drivers/perf/Kconfig         |   8 ++
 drivers/perf/Makefile        |   1 +
 drivers/perf/qcom_llcc_pmu.c | 277 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 273d67ecf6d2..31d848c88d8a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -155,6 +155,14 @@ config QCOM_L3_PMU
 	   Adds the L3 cache PMU into the perf events subsystem for
 	   monitoring L3 cache events.
 
+config QCOM_LLCC_PMU
+	tristate "Qualcomm Technologies LLCC PMU"
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF
+	help
+	  Support for the last-level cache performance monitor unit found
+	  on some Qualcomm Snapdragon SoCs.
+
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 16b3ec4db916..eb02574780b5 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
+obj-$(CONFIG_QCOM_LLCC_PMU) += qcom_llcc_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
diff --git a/drivers/perf/qcom_llcc_pmu.c b/drivers/perf/qcom_llcc_pmu.c
new file mode 100644
index 000000000000..db290ae141a7
--- /dev/null
+++ b/drivers/perf/qcom_llcc_pmu.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+struct llcc_pmu {
+	struct pmu		pmu;
+	struct hlist_node	node;
+	void __iomem		*base;
+	struct perf_event	event;
+	raw_spinlock_t		lock;
+	u64			*llcc_stats;
+};
+#define to_llcc_pmu(p) (container_of(p, struct llcc_pmu, pmu))
+
+#define LLCC_READ_MISS_EV 	0x1000
+
+#define CNT_SCALING_FACTOR	0x3
+
+#define MAX_NUM_CPUS		16
+
+#define MON_CFG(m)		((m)->base + 0x200)
+ #define MON_CFG_ENABLE(cpu)	BIT(cpu)
+ #define MON_CFG_CLEARn(cpu)	BIT(16 + cpu)
+
+#define MON_CNT(m)		((m)->base + 0x220)
+ #define MON_CNT_VAL		GENMASK(23, 0)
+#define MON_CNTn(m, cpu)	(MON_CNT(m) + 0x4 * cpu)
+
+static DEFINE_PER_CPU(unsigned int, users_alive);
+
+static void mon_enable(struct llcc_pmu *llcc_pmu, int cpu)
+{
+	u32 val;
+
+	val = readl_relaxed(MON_CFG(llcc_pmu));
+	val |= MON_CFG_ENABLE(cpu);
+	writel_relaxed(val, MON_CFG(llcc_pmu));
+}
+
+static void mon_disable(struct llcc_pmu *llcc_pmu, int cpu)
+{
+	u32 val;
+
+	val = readl_relaxed(MON_CFG(llcc_pmu));
+	val &= ~MON_CFG_ENABLE(cpu);
+	writel_relaxed(val, MON_CFG(llcc_pmu));
+}
+
+static void mon_clear(struct llcc_pmu *llcc_pmu, int cpu)
+{
+	u32 val;
+
+	val = readl_relaxed(MON_CFG(llcc_pmu));
+
+	val |= MON_CFG_CLEARn(cpu);
+	writel_relaxed(val, MON_CFG(llcc_pmu));
+
+	val &= ~MON_CFG_CLEARn(cpu);
+	writel_relaxed(val, MON_CFG(llcc_pmu));
+}
+
+static int qcom_llcc_event_init(struct perf_event *event)
+{
+	struct llcc_pmu *llcc_pmu = to_llcc_pmu(event->pmu);
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (is_sampling_event(event)) {
+		dev_dbg(llcc_pmu->pmu.dev, "Per-task counters are unsupported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (has_branch_stack(event)) {
+		dev_dbg(llcc_pmu->pmu.dev, "Filtering is unsupported\n");
+		return -EINVAL;
+	}
+
+	if (event->cpu < 0) {
+		dev_warn(llcc_pmu->pmu.dev, "Can't provide per-task data!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void qcom_llcc_event_read(struct perf_event *event)
+{
+	struct llcc_pmu *llcc_pmu = to_llcc_pmu(event->pmu);
+	unsigned long irq_flags;
+	int cpu = event->cpu;
+	u64 readout;
+
+	raw_spin_lock_irqsave(&llcc_pmu->lock, irq_flags);
+
+	mon_disable(llcc_pmu, cpu);
+
+	readout = FIELD_GET(MON_CNT_VAL, readl_relaxed(MON_CNTn(llcc_pmu, cpu)));
+	readout <<= CNT_SCALING_FACTOR;
+
+	llcc_pmu->llcc_stats[cpu] += readout;
+
+	mon_clear(llcc_pmu, cpu);
+	mon_enable(llcc_pmu, cpu);
+
+	if (!(event->hw.state & PERF_HES_STOPPED))
+		local64_set(&event->count, llcc_pmu->llcc_stats[cpu]);
+
+	raw_spin_unlock_irqrestore(&llcc_pmu->lock, irq_flags);
+}
+
+static void qcom_llcc_pmu_start(struct perf_event *event, int flags)
+{
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON(!(event->hw.state & PERF_HES_UPTODATE));
+
+	event->hw.state = 0;
+}
+
+static void qcom_llcc_event_stop(struct perf_event *event, int flags)
+{
+	qcom_llcc_event_read(event);
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int qcom_llcc_event_add(struct perf_event *event, int flags)
+{
+	struct llcc_pmu *llcc_pmu = to_llcc_pmu(event->pmu);
+	unsigned int cpu_users;
+
+	raw_spin_lock(&llcc_pmu->lock);
+
+	cpu_users = per_cpu(users_alive, event->cpu);
+	if (!cpu_users)
+		mon_enable(llcc_pmu, event->cpu);
+
+	cpu_users++;
+	per_cpu(users_alive, event->cpu) = cpu_users;
+
+	raw_spin_unlock(&llcc_pmu->lock);
+
+	event->hw.state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (flags & PERF_EF_START)
+		qcom_llcc_pmu_start(event, PERF_EF_RELOAD);
+
+	return 0;
+}
+
+static void qcom_llcc_event_del(struct perf_event *event, int flags)
+{
+	struct llcc_pmu *llcc_pmu = to_llcc_pmu(event->pmu);
+	unsigned int cpu_users;
+
+	raw_spin_lock(&llcc_pmu->lock);
+
+	cpu_users = per_cpu(users_alive, event->cpu);
+	cpu_users--;
+	if (!cpu_users)
+		mon_disable(llcc_pmu, event->cpu);
+
+	per_cpu(users_alive, event->cpu) = cpu_users;
+
+	raw_spin_unlock(&llcc_pmu->lock);
+}
+
+static ssize_t llcc_pmu_event_show(struct device *dev, struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sysfs_emit(page, "event=0x%04llx\n", pmu_attr->id);
+}
+
+static struct attribute *qcom_llcc_pmu_events[] = {
+	PMU_EVENT_ATTR_ID(read_miss, llcc_pmu_event_show, LLCC_READ_MISS_EV),
+	NULL,
+};
+
+static const struct attribute_group qcom_llcc_pmu_events_group = {
+	.name = "events",
+	.attrs = qcom_llcc_pmu_events,
+};
+
+PMU_FORMAT_ATTR(event, "config:0-15");
+static struct attribute *qcom_llcc_pmu_format_attrs[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static const struct attribute_group qcom_llcc_pmu_format_group = {
+	.name = "format",
+	.attrs = qcom_llcc_pmu_format_attrs,
+};
+
+static const struct attribute_group *qcom_llcc_pmu_attr_groups[] = {
+	&qcom_llcc_pmu_format_group,
+	&qcom_llcc_pmu_events_group,
+	NULL,
+};
+
+static int qcom_llcc_pmu_probe(struct platform_device *pdev)
+{
+	static struct llcc_pmu *llcc_pmu;
+	int ret;
+
+	if (num_possible_cpus() > MAX_NUM_CPUS)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "LLCC PMU only supports <=%u CPUs\n",
+				     MAX_NUM_CPUS);
+
+	llcc_pmu = devm_kzalloc(&pdev->dev, sizeof(*llcc_pmu), GFP_KERNEL);
+	if (!llcc_pmu)
+		return -ENOMEM;
+
+	llcc_pmu->llcc_stats = devm_kcalloc(&pdev->dev, num_possible_cpus(),
+					    sizeof(*llcc_pmu->llcc_stats), GFP_KERNEL);
+
+	llcc_pmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(llcc_pmu->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(llcc_pmu->base),
+				     "Failed to register LLCC PMU\n");
+
+	llcc_pmu->pmu = (struct pmu) {
+		.event_init	= qcom_llcc_event_init,
+		.add		= qcom_llcc_event_add,
+		.del		= qcom_llcc_event_del,
+		.start		= qcom_llcc_pmu_start,
+		.stop		= qcom_llcc_event_stop,
+		.read		= qcom_llcc_event_read,
+
+		.attr_groups	= qcom_llcc_pmu_attr_groups,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.module		= THIS_MODULE,
+	};
+
+	raw_spin_lock_init(&llcc_pmu->lock);
+
+	ret = perf_pmu_register(&llcc_pmu->pmu, "llcc_pmu", -1);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to register LLCC PMU\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_llcc_pmu_match_table[] = {
+	{ .compatible = "qcom,llcc-pmu-v2" },
+	{ }
+};
+
+static struct platform_driver qcom_llcc_pmu_driver = {
+	.probe = qcom_llcc_pmu_probe,
+	.driver = {
+		.name = "qcom-llcc-pmu",
+		.of_match_table = qcom_llcc_pmu_match_table,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(qcom_llcc_pmu_driver);
+
+MODULE_DEVICE_TABLE(of, qcom_llcc_pmu_match_table);
+MODULE_DESCRIPTION("QCOM LLCC PMU");
+MODULE_LICENSE("GPL");

---
base-commit: 21ef7b1e17d039053edaeaf41142423810572741
change-id: 20230809-topic-llcc_pmu-c6e9dbc36b12

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

