Return-Path: <linux-kernel+bounces-67877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A20A857241
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2BF1C2323A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEDF149DF7;
	Fri, 16 Feb 2024 00:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bak94Cr+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27F1946F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042133; cv=none; b=P/T722mCxLLalc5x7JdlS8C97cyPNUkjVwFkFt7+PKX4dJN0xvvkouL8NhH9ZnlT44Z5MUB2F9AwlK8TlCp7FYX3T6+YnA/UvWMGA8zqU0VQGH+86UgGUJqrx9B0bWLausYrlt7zTbh+WAjH6UA1M8NAxMVYLiaLeO3X5hyoZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042133; c=relaxed/simple;
	bh=8VSz8YhXCzbdmH6lcJ0g9fYzRT+znl2jSP343uwb5Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alObSoSScStqyjtd/h/vTVqR6J8ma6u7XWT8zxMzv0vFxcv9jb6Mn8/PzbZCAFMwIsLYu4hRqbOJZ1SGNnqUyKV6upBawRWofxqBYOfro5+wz0S5RM3ugshjpEu7AwZVnDXvIVjW9tkGNJR66OzsqD8V4cNoOHj8KYViq3ej5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bak94Cr+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d780a392fdso1301725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708042130; x=1708646930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97Vl//GERs+wHDqqFSQvA7qG8VAex8iXqN6MPz7a8Ck=;
        b=bak94Cr+9m27sXnJFE7F8kwdW2D69B0F2dlY1FdiKsGZsVY8OQFMBHbwrfU5tSWHf+
         RY/ZNCR1M431Sq6pFZntOAhUHHKtQO2vZrC5ESOe5Iq+xZtVCZiboHH9oz3W+lqtjjg9
         e1TylvH0ZzqaosfpkVsBtDdmsNEiPbZd6AIqgxApcTfiKDArMfxUiDUGaUGLtv+tBe5f
         fUAGoRXvVmASOy5MKjXx4WaPEKSjDv7qCVc/wBal9gA0m3zEaxhyEPlwvVcxuU5yOdy4
         QdRiMuyOgBlqMRooJs5s8/5Y6mJSUYdgFAaEV8WXRKt+KXwur1i/m5vJIimmFjfpoRzs
         zYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042130; x=1708646930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97Vl//GERs+wHDqqFSQvA7qG8VAex8iXqN6MPz7a8Ck=;
        b=O0EUjHNYVNjO3hn4P0EokwBHKWRv6HQZsfDQkn+RehriKyWQ4lUIC9XfdC9o1Wwe0z
         WoR8bizcK4u8+zDpktgAkzEdN7yY6mBHIOm6sjEIlLuBtJ/aduLh+/mejA4Yg+vXXekg
         cgyX4Ng0MTpmDjl0CY388LaVGYF06YkoyE6N+ov+og96jk+KjUM0JLUoW7G9RL5qy3Wf
         NdbizHPD3I3vnwG+obYtN1Cwpx3kasbJ362bvNgPWw+9eBeRpg0sEnsDY5qi27f+9Ya5
         LrSA32N6TmPmTE1Rv0OMvoulcekfTmmFFUZ6W6Sg7jOCJ7BeBUq7m3F3DydQBq/rlHSK
         XTlw==
X-Forwarded-Encrypted: i=1; AJvYcCVX1vC/ZSgk5N9ImOuzOihAPWwDvRfZgOFdPZwfTFgn6BDHNogXuyVyOm/3W3FqZH2jICd43Ypiadhkav8OgqdTVrAS+SGAFyLC3pZh
X-Gm-Message-State: AOJu0YyaBcUrUcChgdDS2FV4McnUjB6UiVfPsLxCeV7VSyl1zsW4CAIQ
	GFq+8VKHZqCyJ4fBgFuZSJpWaVeK71kz78it/VT5j9jCPGUTbYgkPocfZNtldEg=
X-Google-Smtp-Source: AGHT+IHM3CCjf5Wmu1mQ0DXHmEVhMoKJarp5BUlbNPnrFrVhOAN6O5I6g9AI9OcGFnljzXBeMdhPNw==
X-Received: by 2002:a17:903:443:b0:1db:a54b:acaf with SMTP id iw3-20020a170903044300b001dba54bacafmr558755plb.39.1708042129975;
        Thu, 15 Feb 2024 16:08:49 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001db3d365082sm1789486plb.265.2024.02.15.16.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:08:48 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Eric Lin <eric.lin@sifive.com>,
	Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-riscv@lists.infradead.org,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v1 4/6] drivers/perf: Add SiFive Extensible Cache PMU driver
Date: Thu, 15 Feb 2024 16:08:16 -0800
Message-ID: <20240216000837.1868917-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216000837.1868917-1-samuel.holland@sifive.com>
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Lin <eric.lin@sifive.com>

Add a driver for the PMU found in the SiFive Extensible Cache
controller. This PMU provides a configurable number of counters and a
variety of events. Events are grouped into sets. Each counter can count
events from only one set at a time; however, it can count any number of
events within that set simultaneously. The PMU hardware does not provide
an overflow interrupt.

The counter inhibit register is used to atomically start/stop/read a
group of counters so their values can be usefully compared.

Some events can be filtered further by client ID (e.g. CPU or external
DMA master). That functionality is not supported by this driver.

This driver further assumes that a single Extensible Cache instance is
shared by all CPUs in the system.

Example usage:

$ perf stat -e sifive_ecache_pmu/inner_rd_request/,
	       sifive_ecache_pmu/inner_wr_request/,
	       sifive_ecache_pmu/inner_rd_request_hit/,
	       sifive_ecache_pmu/inner_wr_request_hit/ ls

 Performance counter stats for 'system wide':

            148001      sifive_ecache_pmu/inner_rd_request/
            121064      sifive_ecache_pmu/inner_wr_request/
            113124      sifive_ecache_pmu/inner_rd_request_hit/
            120860      sifive_ecache_pmu/inner_wr_request_hit/

       0.010643962 seconds time elapsed

Example combining the read/write events together within each counter:

$ perf stat -e sifive_ecache_pmu/event=0x601/,
	       sifive_ecache_pmu/event=0xc001/ ls

 Performance counter stats for 'system wide':

            262619      sifive_ecache_pmu/event=0x601/
            224533      sifive_ecache_pmu/event=0xc001/

       0.009794808 seconds time elapsed

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/perf/Kconfig             |  10 +
 drivers/perf/Makefile            |   1 +
 drivers/perf/sifive_ecache_pmu.c | 675 +++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h       |   1 +
 4 files changed, 687 insertions(+)
 create mode 100644 drivers/perf/sifive_ecache_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index b4e4db7424b4..8a3b2b88d8b5 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -164,6 +164,16 @@ config SIFIVE_CCACHE_PMU
 	  for measuring whole-system L2/L3 cache performance using the perf
 	  events subsystem.
 
+config SIFIVE_ECACHE_PMU
+	tristate "SiFive Extensible Cache PMU"
+	depends on RISCV || COMPILE_TEST
+	depends on OF
+	help
+	  Support for the Extensible Cache performance monitoring unit (PMU) on
+	  SiFive platforms. The Composable Cache PMU provides up to 8 counters
+	  for measuring whole-system L2/L3 cache performance using the perf
+	  events subsystem.
+
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 51ef5f50ace4..a51686b413f2 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
 obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_SIFIVE_CCACHE_PMU) += sifive_ccache_pmu.o
+obj-$(CONFIG_SIFIVE_ECACHE_PMU) += sifive_ecache_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/sifive_ecache_pmu.c b/drivers/perf/sifive_ecache_pmu.c
new file mode 100644
index 000000000000..51b2fa3781c9
--- /dev/null
+++ b/drivers/perf/sifive_ecache_pmu.c
@@ -0,0 +1,675 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive EC (Extensible Cache) PMU driver
+ *
+ * Copyright (C) 2023-2024 SiFive, Inc.
+ * Copyright (C) Eric Lin <eric.lin@sifive.com>
+ *
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+#define ECACHE_SELECT_OFFSET		0x2000
+#define ECACHE_CLIENT_FILTER_OFFSET	0x2200
+#define ECACHE_COUNTER_INHIBIT_OFFSET	0x2800
+#define ECACHE_COUNTER_OFFSET		0x3000
+
+#define ECACHE_PMU_MAX_COUNTERS		8
+
+struct sifive_ecache_pmu_slice {
+	void __iomem			*base;
+};
+
+struct sifive_ecache_pmu {
+	struct pmu			pmu;
+	struct hlist_node		node;
+	struct notifier_block		cpu_pm_nb;
+	struct perf_event		*events[ECACHE_PMU_MAX_COUNTERS];
+	DECLARE_BITMAP(used_mask, ECACHE_PMU_MAX_COUNTERS);
+	unsigned int			cpu;
+	unsigned int			txn_flags;
+	int				n_counters;
+	int				n_slices;
+	struct sifive_ecache_pmu_slice	slice[] __counted_by(n_slices);
+};
+
+#define to_ecache_pmu(p) (container_of(p, struct sifive_ecache_pmu, pmu))
+
+/* Store the counter mask for a group in the leader's extra_reg */
+#define event_group_mask(event) (event->group_leader->hw.extra_reg.config)
+
+#ifndef readq
+static inline u64 readq(void __iomem *addr)
+{
+	return readl(addr) | (((u64)readl(addr + 4)) << 32);
+}
+#endif
+
+#ifndef writeq
+static inline void writeq(u64 v, void __iomem *addr)
+{
+	writel(lower_32_bits(v), addr);
+	writel(upper_32_bits(v), addr + 4);
+}
+#endif
+
+/*
+ * sysfs attributes
+ *
+ * We export:
+ * - cpumask, used by perf user space and other tools to know on which CPUs to create events
+ * - events, used by perf user space and other tools to create events symbolically, e.g.:
+ *     perf stat -a -e sifive_ecache_pmu/event=inner_put_partial_data_hit/ ls
+ *     perf stat -a -e sifive_ecache_pmu/event=0x101/ ls
+ * - formats, used by perf user space and other tools to configure events
+ */
+
+/* cpumask */
+static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct sifive_ecache_pmu *ecache_pmu = dev_get_drvdata(dev);
+
+	if (ecache_pmu->cpu >= nr_cpu_ids)
+		return 0;
+
+	return sysfs_emit(buf, "%d\n", ecache_pmu->cpu);
+};
+
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *sifive_ecache_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL,
+};
+
+static const struct attribute_group sifive_ecache_pmu_cpumask_group = {
+	.attrs = sifive_ecache_pmu_cpumask_attrs,
+};
+
+/* events */
+static ssize_t sifive_ecache_pmu_event_show(struct device *dev, struct device_attribute *attr,
+					    char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define SET_EVENT_SELECT(_event, _set)	(BIT_ULL((_event) + 8) | (_set))
+#define ECACHE_PMU_EVENT_ATTR(_name, _event, _set) \
+	PMU_EVENT_ATTR_ID(_name, sifive_ecache_pmu_event_show, SET_EVENT_SELECT(_event, _set))
+
+enum ecache_pmu_event_set1 {
+	INNER_REQUEST = 0,
+	INNER_RD_REQUEST,
+	INNER_WR_REQUEST,
+	INNER_PF_REQUEST,
+	OUTER_PRB_REQUEST,
+	INNER_REQUEST_HIT,
+	INNER_RD_REQUEST_HIT,
+	INNER_WR_REQUEST_HIT,
+	INNER_PF_REQUEST_HIT,
+	OUTER_PRB_REQUEST_HIT,
+	INNER_REQUEST_HITPF,
+	INNER_RD_REQUEST_HITPF,
+	INNER_WR_REQUEST_HITPF,
+	INNER_PF_REQUEST_HITPF,
+	OUTER_PRB_REQUEST_HITPF,
+	INNER_REQUEST_MISS,
+	INNER_RD_REQUEST_MISS,
+	INNER_WR_REQUEST_MISS,
+	INNER_PF_REQUEST_MISS,
+	OUTER_PRB_REQUEST_MISS,
+	ECACHE_PMU_MAX_EVENT1_IDX
+};
+
+enum ecache_pmu_event_set2 {
+	OUTER_REQUEST = 0,
+	OUTER_RD_REQUEST,
+	OUTER_PUT_REQUEST,
+	OUTER_EV_REQUEST,
+	OUTER_PF_REQUEST,
+	INNER_PRB_REQUEST,
+	INNER_REQUEST_WCYC,
+	INNER_RD_REQUEST_WCYC,
+	INNER_WR_REQUEST_WCYC,
+	INNER_PF_REQUEST_WCYC,
+	OUTER_PRB_REQUEST_WCYC,
+	OUTER_REQUEST_WCYC,
+	OUTER_RD_REQUEST_WCYC,
+	OUTER_PUT_REQUEST_WCYC,
+	OUTER_EV_REQUEST_WCYC,
+	OUTER_PF_REQUEST_WCYC,
+	INNER_PRB_REQUEST_WCYC,
+	INNER_AG_WCYC,
+	INNER_AP_WCYC,
+	INNER_AH_WCYC,
+	INNER_BP_WCYC,
+	INNER_CP_WCYC,
+	INNER_CX_WCYC,
+	INNER_DG_WCYC,
+	INNER_DP_WCYC,
+	INNER_DX_WCYC,
+	INNER_EG_WCYC,
+	OUTER_AG_WCYC,
+	OUTER_AP_WCYC,
+	OUTER_AH_WCYC,
+	OUTER_BP_WCYC,
+	OUTER_CP_WCYC,
+	OUTER_CX_WCYC,
+	OUTER_DG_WCYC,
+	OUTER_DP_WCYC,
+	OUTER_DX_WCYC,
+	OUTER_EG_WCYC,
+	ECACHE_PMU_MAX_EVENT2_IDX
+};
+
+static struct attribute *sifive_ecache_pmu_events[] = {
+	/*  pmEventSelect1 */
+	ECACHE_PMU_EVENT_ATTR(inner_request, INNER_REQUEST, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_rd_request, INNER_RD_REQUEST, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_wr_request, INNER_WR_REQUEST, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_pf_request, INNER_PF_REQUEST, 1),
+	ECACHE_PMU_EVENT_ATTR(outer_prb_request, OUTER_PRB_REQUEST, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_request_hit, INNER_REQUEST_HIT,  1),
+	ECACHE_PMU_EVENT_ATTR(inner_rd_request_hit, INNER_RD_REQUEST_HIT, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_wr_request_hit, INNER_WR_REQUEST_HIT, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_pf_request_hit, INNER_PF_REQUEST_HIT, 1),
+	ECACHE_PMU_EVENT_ATTR(outer_prb_request_hit, OUTER_PRB_REQUEST_HIT, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_request_hitpf, INNER_REQUEST_HITPF,  1),
+	ECACHE_PMU_EVENT_ATTR(inner_rd_request_hitpf, INNER_RD_REQUEST_HITPF, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_wr_request_hitpf, INNER_WR_REQUEST_HITPF, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_pf_request_hitpf, INNER_PF_REQUEST_HITPF, 1),
+	ECACHE_PMU_EVENT_ATTR(outer_prb_request_hitpf, OUTER_PRB_REQUEST_HITPF, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_request_miss, INNER_REQUEST_MISS,  1),
+	ECACHE_PMU_EVENT_ATTR(inner_rd_request_miss, INNER_RD_REQUEST_MISS, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_wr_request_miss, INNER_WR_REQUEST_MISS, 1),
+	ECACHE_PMU_EVENT_ATTR(inner_pf_request_miss, INNER_PF_REQUEST_MISS, 1),
+	ECACHE_PMU_EVENT_ATTR(outer_prb_request_miss, OUTER_PRB_REQUEST_MISS, 1),
+
+	/*  pmEventSelect2 */
+	ECACHE_PMU_EVENT_ATTR(outer_request, OUTER_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_rd_request, OUTER_RD_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_put_request, OUTER_PUT_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_ev_request, OUTER_EV_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_pf_request, OUTER_PF_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_prb_request, INNER_PRB_REQUEST, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_request_wcyc, INNER_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_rd_request_wcyc, INNER_RD_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_wr_request_wcyc, INNER_WR_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_pf_request_wcyc, INNER_PF_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_prb_request_wcyc, OUTER_PRB_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_request_wcyc, OUTER_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_rd_request_wcyc, OUTER_RD_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_put_request_wcyc, OUTER_PUT_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_ev_request_wcyc, OUTER_EV_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_pf_request_wcyc, OUTER_PF_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_prb_request_wcyc, INNER_PRB_REQUEST_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_ag_wcyc, INNER_AG_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_ap_wcyc, INNER_AP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_ah_wcyc, INNER_AH_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_bp_wcyc, INNER_BP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_cp_wcyc, INNER_CP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_cx_wcyc, INNER_CX_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_dg_wcyc, INNER_DG_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_dp_wcyc, INNER_DP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_dx_wcyc, INNER_DX_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(inner_eg_wcyc, INNER_EG_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_ag_wcyc, OUTER_AG_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_ap_wcyc, OUTER_AP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_ah_wcyc, OUTER_AH_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_bp_wcyc, OUTER_BP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_cp_wcyc, OUTER_CP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_cx_wcyc, OUTER_CX_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_dg_wcyc, OUTER_DG_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_dp_wcyc, OUTER_DP_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_dx_wcyc, OUTER_DX_WCYC, 2),
+	ECACHE_PMU_EVENT_ATTR(outer_eg_wcyc, OUTER_EG_WCYC, 2),
+	NULL
+};
+
+static struct attribute_group sifive_ecache_pmu_events_group = {
+	.name = "events",
+	.attrs = sifive_ecache_pmu_events,
+};
+
+/* formats */
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *sifive_ecache_pmu_formats[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group sifive_ecache_pmu_format_group = {
+	.name = "format",
+	.attrs = sifive_ecache_pmu_formats,
+};
+
+/*
+ * Per PMU device attribute groups
+ */
+
+static const struct attribute_group *sifive_ecache_pmu_attr_grps[] = {
+	&sifive_ecache_pmu_cpumask_group,
+	&sifive_ecache_pmu_events_group,
+	&sifive_ecache_pmu_format_group,
+	NULL,
+};
+
+/*
+ * Event Initialization
+ */
+
+static int sifive_ecache_pmu_event_init(struct perf_event *event)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	u64 ev_type = config >> 8;
+	u64 set = config & 0xff;
+
+	/* Check if this is a valid set and event */
+	switch (set) {
+	case 1:
+		if (ev_type >= BIT_ULL(ECACHE_PMU_MAX_EVENT1_IDX))
+			return -ENOENT;
+		break;
+	case 2:
+		if (ev_type >= BIT_ULL(ECACHE_PMU_MAX_EVENT2_IDX))
+			return -ENOENT;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	/* Do not allocate the hardware counter yet */
+	hwc->idx = -1;
+	hwc->config = config;
+
+	event->cpu = ecache_pmu->cpu;
+
+	return 0;
+}
+
+/*
+ * Low-level functions: reading and writing counters
+ */
+
+static void configure_counter(const struct sifive_ecache_pmu *ecache_pmu,
+			      const struct hw_perf_event *hwc, u64 config)
+{
+	for (int i = 0; i < ecache_pmu->n_slices; i++) {
+		void __iomem *base = ecache_pmu->slice[i].base;
+
+		if (config)
+			writeq(0, base + hwc->event_base);
+		writeq(config, base + hwc->config_base);
+	}
+}
+
+static u64 read_counter(const struct sifive_ecache_pmu *ecache_pmu, const struct hw_perf_event *hwc)
+{
+	u64 value = 0;
+
+	for (int i = 0; i < ecache_pmu->n_slices; i++) {
+		void __iomem *base = ecache_pmu->slice[i].base;
+
+		value += readq(base + hwc->event_base);
+	}
+
+	return value;
+}
+
+static void write_inhibit(const struct sifive_ecache_pmu *ecache_pmu, u64 mask)
+{
+	u64 used_mask;
+
+	/* Inhibit all unused counters in addition to the provided mask */
+	bitmap_to_arr64(&used_mask, ecache_pmu->used_mask, ECACHE_PMU_MAX_COUNTERS);
+	mask |= ~used_mask;
+
+	for (int i = 0; i < ecache_pmu->n_slices; i++) {
+		void __iomem *base = ecache_pmu->slice[i].base;
+
+		writeq(mask, base + ECACHE_COUNTER_INHIBIT_OFFSET);
+	}
+}
+
+/*
+ * pmu->read: read and update the counter
+ */
+static void sifive_ecache_pmu_read(struct perf_event *event)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_raw_count, new_raw_count;
+	u64 oldval;
+
+	/* Inhibit the entire group during a read transaction for atomicity */
+	if (ecache_pmu->txn_flags == PERF_PMU_TXN_READ && event->group_leader == event)
+		write_inhibit(ecache_pmu, event_group_mask(event));
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = read_counter(ecache_pmu, hwc);
+
+		oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count, new_raw_count);
+	} while (oldval != prev_raw_count);
+
+	local64_add(new_raw_count - prev_raw_count, &event->count);
+}
+
+/*
+ * State transition functions:
+ *
+ * start()/stop() & add()/del()
+ */
+
+/*
+ * pmu->start: start the event
+ */
+static void sifive_ecache_pmu_start(struct perf_event *event, int flags)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	hwc->state = 0;
+
+	/* Set initial value to 0 */
+	local64_set(&hwc->prev_count, 0);
+
+	/* Enable this counter to count events */
+	configure_counter(ecache_pmu, hwc, hwc->config);
+}
+
+/*
+ * pmu->stop: stop the counter
+ */
+static void sifive_ecache_pmu_stop(struct perf_event *event, int flags)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	/* Disable this counter to count events */
+	configure_counter(ecache_pmu, hwc, 0);
+	sifive_ecache_pmu_read(event);
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+/*
+ * pmu->add: add the event to the PMU
+ */
+static int sifive_ecache_pmu_add(struct perf_event *event, int flags)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Find an available counter idx to use for this event */
+	do {
+		idx = find_first_zero_bit(ecache_pmu->used_mask, ecache_pmu->n_counters);
+		if (idx >= ecache_pmu->n_counters)
+			return -EAGAIN;
+	} while (test_and_set_bit(idx, ecache_pmu->used_mask));
+
+	event_group_mask(event) |= BIT_ULL(idx);
+	hwc->config_base = ECACHE_SELECT_OFFSET + 8 * idx;
+	hwc->event_base = ECACHE_COUNTER_OFFSET + 8 * idx;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	ecache_pmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		sifive_ecache_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+/*
+ * pmu->del: delete the event from the PMU
+ */
+static void sifive_ecache_pmu_del(struct perf_event *event, int flags)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/* Stop and release this counter */
+	sifive_ecache_pmu_stop(event, PERF_EF_UPDATE);
+
+	ecache_pmu->events[idx] = NULL;
+	clear_bit(idx, ecache_pmu->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+/*
+ * Transaction synchronization
+ */
+
+static void sifive_ecache_pmu_start_txn(struct pmu *pmu, unsigned int txn_flags)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(pmu);
+
+	ecache_pmu->txn_flags = txn_flags;
+
+	/* Inhibit any counters that were deleted since the last transaction */
+	if (txn_flags == PERF_PMU_TXN_ADD)
+		write_inhibit(ecache_pmu, 0);
+}
+
+static int sifive_ecache_pmu_commit_txn(struct pmu *pmu)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(pmu);
+
+	ecache_pmu->txn_flags = 0;
+
+	/* Successful transaction: atomically uninhibit the counters in this group */
+	write_inhibit(ecache_pmu, 0);
+
+	return 0;
+}
+
+static void sifive_ecache_pmu_cancel_txn(struct pmu *pmu)
+{
+	struct sifive_ecache_pmu *ecache_pmu = to_ecache_pmu(pmu);
+
+	ecache_pmu->txn_flags = 0;
+
+	/* Failed transaction: leave the counters in this group inhibited */
+}
+
+/*
+ * Driver initialization
+ */
+
+static void sifive_ecache_pmu_hw_init(const struct sifive_ecache_pmu *ecache_pmu)
+{
+	for (int i = 0; i < ecache_pmu->n_slices; i++) {
+		void __iomem *base = ecache_pmu->slice[i].base;
+
+		/* Disable the client filter (not supported by this driver) */
+		writeq(0, base + ECACHE_CLIENT_FILTER_OFFSET);
+	}
+}
+
+static int sifive_ecache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct sifive_ecache_pmu *ecache_pmu =
+		hlist_entry_safe(node, struct sifive_ecache_pmu, node);
+
+	if (ecache_pmu->cpu >= nr_cpu_ids)
+		ecache_pmu->cpu = cpu;
+
+	return 0;
+}
+
+static int sifive_ecache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
+{
+	struct sifive_ecache_pmu *ecache_pmu =
+		hlist_entry_safe(node, struct sifive_ecache_pmu, node);
+
+	/* Do nothing if this CPU does not own the events */
+	if (cpu != ecache_pmu->cpu)
+		return 0;
+
+	/* Pick a random online CPU */
+	ecache_pmu->cpu = cpumask_any_but(cpu_online_mask, cpu);
+	if (ecache_pmu->cpu >= nr_cpu_ids)
+		return 0;
+
+	/* Migrate PMU events from this CPU to the target CPU */
+	perf_pmu_migrate_context(&ecache_pmu->pmu, cpu, ecache_pmu->cpu);
+
+	return 0;
+}
+
+static int sifive_ecache_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *ecache_node = dev_of_node(dev);
+	struct sifive_ecache_pmu *ecache_pmu;
+	struct device_node *slice_node;
+	u32 slice_counters;
+	int n_slices, ret;
+	int i = 0;
+
+	n_slices = of_get_available_child_count(ecache_node);
+	if (!n_slices)
+		return -ENODEV;
+
+	ecache_pmu = devm_kzalloc(dev, struct_size(ecache_pmu, slice, n_slices), GFP_KERNEL);
+	if (!ecache_pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ecache_pmu);
+
+	ecache_pmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.attr_groups	= sifive_ecache_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= sifive_ecache_pmu_event_init,
+		.add		= sifive_ecache_pmu_add,
+		.del		= sifive_ecache_pmu_del,
+		.start		= sifive_ecache_pmu_start,
+		.stop		= sifive_ecache_pmu_stop,
+		.read		= sifive_ecache_pmu_read,
+		.start_txn	= sifive_ecache_pmu_start_txn,
+		.commit_txn	= sifive_ecache_pmu_commit_txn,
+		.cancel_txn	= sifive_ecache_pmu_cancel_txn,
+	};
+	ecache_pmu->cpu = nr_cpu_ids;
+	ecache_pmu->n_counters = ECACHE_PMU_MAX_COUNTERS;
+	ecache_pmu->n_slices = n_slices;
+
+	for_each_available_child_of_node(ecache_node, slice_node) {
+		struct sifive_ecache_pmu_slice *slice = &ecache_pmu->slice[i++];
+
+		slice->base = devm_of_iomap(dev, slice_node, 0, NULL);
+		if (IS_ERR(slice->base))
+			return PTR_ERR(slice->base);
+
+		/* Get number of counters from slice node */
+		ret = of_property_read_u32(slice_node, "sifive,perfmon-counters", &slice_counters);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Slice %pOF missing sifive,perfmon-counters property\n",
+					     slice_node);
+
+		ecache_pmu->n_counters = min_t(u32, slice_counters, ecache_pmu->n_counters);
+	}
+
+	sifive_ecache_pmu_hw_init(ecache_pmu);
+
+	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE, &ecache_pmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add CPU hotplug instance\n");
+
+	ret = perf_pmu_register(&ecache_pmu->pmu, "sifive_ecache_pmu", -1);
+	if (ret) {
+		dev_err_probe(dev, ret, "Failed to register PMU\n");
+		goto err_remove_instance;
+	}
+
+	return 0;
+
+err_remove_instance:
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE, &ecache_pmu->node);
+
+	return ret;
+}
+
+static void sifive_ecache_pmu_remove(struct platform_device *pdev)
+{
+	struct sifive_ecache_pmu *ecache_pmu = platform_get_drvdata(pdev);
+
+	perf_pmu_unregister(&ecache_pmu->pmu);
+	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE, &ecache_pmu->node);
+}
+
+static const struct of_device_id sifive_ecache_pmu_of_match[] = {
+	{ .compatible = "sifive,extensiblecache0" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sifive_ecache_pmu_of_match);
+
+static struct platform_driver sifive_ecache_pmu_driver = {
+	.probe	= sifive_ecache_pmu_probe,
+	.remove_new	= sifive_ecache_pmu_remove,
+	.driver	= {
+		.name		= "sifive_ecache_pmu",
+		.of_match_table	= sifive_ecache_pmu_of_match,
+	},
+};
+
+static void __exit sifive_ecache_pmu_exit(void)
+{
+	platform_driver_unregister(&sifive_ecache_pmu_driver);
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE);
+}
+module_exit(sifive_ecache_pmu_exit);
+
+static int __init sifive_ecache_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE,
+				      "perf/sifive/ecache:online",
+				      sifive_ecache_pmu_online_cpu,
+				      sifive_ecache_pmu_offline_cpu);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&sifive_ecache_pmu_driver);
+	if (ret)
+		goto err_remove_state;
+
+	return 0;
+
+err_remove_state:
+	cpuhp_remove_multi_state(CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE);
+
+	return ret;
+}
+module_init(sifive_ecache_pmu_init);
+
+MODULE_LICENSE("GPL");
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index be6361fdc8ba..55bd3a5e0033 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -231,6 +231,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_POWERPC_HV_24x7_ONLINE,
 	CPUHP_AP_PERF_POWERPC_HV_GPCI_ONLINE,
 	CPUHP_AP_PERF_RISCV_SIFIVE_CCACHE_ONLINE,
+	CPUHP_AP_PERF_RISCV_SIFIVE_ECACHE_ONLINE,
 	CPUHP_AP_PERF_CSKY_ONLINE,
 	CPUHP_AP_WATCHDOG_ONLINE,
 	CPUHP_AP_WORKQUEUE_ONLINE,
-- 
2.43.0


