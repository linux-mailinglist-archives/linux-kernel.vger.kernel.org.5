Return-Path: <linux-kernel+bounces-67879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3DB857244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5283E1C234C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D026EEB1;
	Fri, 16 Feb 2024 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S6Y5JR1w"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC760DDCA
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042139; cv=none; b=j54iWof2BUwkj7/pxGlHCzLHP5NVSrP6fBKiWi0+ZpT15QtAT7aCwJV3Mhkd5AUNekdD0zO2juT0EN+jj++oEKSdC8j06kwAHM7pIPdhsb/9bSDFfUJeLuC0pG6+puZLc4i5Xh8Ap14EHAP84XYZ0WSqB8rwfAQjkPikYixuk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042139; c=relaxed/simple;
	bh=JkAv4hlLlinDg6WO1Ei4HQwcmM/jZtqgc/bSglhHsww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaaxG/x/hlIDsvZj2k+rycV/wCG3by5xEls5/NSkTBGEIConLaaAY4JodlEJHpDQMmlKEij9Yyb+PNEc++h9AnzCcHbscJ2ycQt8/fwMsnruHySALRaQFpuQ7bJ4PNnT641oo6NEsFAEAldugi2VbX0AogFDWRnY1zeucfVU9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=S6Y5JR1w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d93edfa76dso1264925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708042136; x=1708646936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p/acc0KNWqEiBrI2bUhG9VfOZxykMoq55GvaWo8V2Yc=;
        b=S6Y5JR1w3TP0drTyAZGnJwJacp5+a+bICH80W8ZiRiRzeQ6eVW4km8dbVHFSpXeCOc
         K3TqdDSVQLPlKuUMygKZw6DsQsBXjAZ1i7XBsVzddTelE1Lx2Bd3RULAvVh9IMufj7ti
         jNYBx2G43Jbc3Zc7muX0X9pBd6aCPIichTxJpOVSkBCXeYKPl+ENebSJEFYBw++d6Jkm
         ocP7RaUkwiW23wZb482Zj9MzzIKCysCwb63uGe2sISP2DGu3tpAeUW91XFCk9kC4zUTO
         haQ7NdzywK4jzWMinCq//YVnLX2ocPmRgVhDeEUJMaBlFKyQxqCYoL+RRX4DmQuE9a+7
         eTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042136; x=1708646936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/acc0KNWqEiBrI2bUhG9VfOZxykMoq55GvaWo8V2Yc=;
        b=hsHKCFNx4m9EWVqgMAZ076U8W7v8rwPVIHiUi4rWdYsl15wFpYRJw1bw+V9fLTZM/N
         FLihkZuH6UmSo0nVDTdehircsmi4oj797tFuIymbIniACyfTf56hLmbFyx6HMzCHY8Nw
         KoHl8YpCzAKyA7KcvdVwz7vLGlgcMdWz39fl0ZNyy/j7QerpWFRLKvwejic1iMbxBaQm
         3plkDi3b3ZuWjGEwUSdJSvoTlC4dRq3wfdEbv1wh23pmnLyNPk6hls7yxkQPgDoWpZ2W
         XmguGjsCWlLF0b34MIytsYh0Fyqee6NRMqIGQ7C15c5AcbHkGCCxnGx4Yd4IiluV3DFX
         LpjA==
X-Forwarded-Encrypted: i=1; AJvYcCUdgfWIZUk/JtuEVjyQB22S7z9S9h2JW4G17AVCwtJF63H2imFbH+GenL8cl4ivEmoU2AR3CYQ6rwhbG3NTKIMAmGfB82MYZTVHvDu8
X-Gm-Message-State: AOJu0YxEJMobjB1uDZzTRUzcbExX0VlsdHhYfcJ37NYNtNERry2LOmrZ
	gcQq15Y/otrG1ssSgeGd2fA6d/JbGYO4jIoWnNJOJNygiC0umPi97g08nR4lkwU=
X-Google-Smtp-Source: AGHT+IHJy/A1S+sldWkfbkh3Ezw6XCoeo322r0XKeVNd/Im9EAWCGT0knZuiKSibPYqHNzxRxpUokQ==
X-Received: by 2002:a17:902:ec89:b0:1db:aa46:4923 with SMTP id x9-20020a170902ec8900b001dbaa464923mr46470plg.40.1708042136146;
        Thu, 15 Feb 2024 16:08:56 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001db3d365082sm1789486plb.265.2024.02.15.16.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:08:54 -0800 (PST)
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
	Greentime Hu <greentime.hu@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v1 6/6] drivers/perf: Add SiFive Private L2 Cache PMU driver
Date: Thu, 15 Feb 2024 16:08:18 -0800
Message-ID: <20240216000837.1868917-7-samuel.holland@sifive.com>
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

From: Greentime Hu <greentime.hu@sifive.com>

Add a driver for the PMU found in the SiFive Private L2 Cache
controller. This PMU provides a configurable number of counters and a
variety of events. Events are grouped into sets. Each counter can count
events from only one set at a time; however, it can count any number of
events within that set simultaneously. The PMU hardware does not provide
an overflow interrupt or a way to atomically control groups of counters.

A separate Private L2 Cache instance exists for each core, so this
driver supports per-core and per-task profiling.

Some events can be filtered further by client ID (e.g. CPU or external
DMA master). That functionality is not supported by this driver.

Example usage:

$ perf stat -e sifive_pl2_pmu/inner_get/,sifive_pl2_pmu/outer_get/ ls

 Performance counter stats for 'ls':

             95041      sifive_pl2_pmu/inner_get/
                 3      sifive_pl2_pmu/outer_get/

       0.003971538 seconds time elapsed

       0.000000000 seconds user
       0.006315000 seconds sys

Example combining multiple events together within each counter:

$ perf stat -e sifive_pl2_pmu/event=0x301/,   # inner_put_*_data
	       sifive_pl2_pmu/event=0x303/ ls # outer_put_*_data

 Performance counter stats for 'ls':

              6828      sifive_pl2_pmu/event=0x301/
                11      sifive_pl2_pmu/event=0x303/

       0.005696538 seconds time elapsed

       0.000000000 seconds user
       0.006337000 seconds sys

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Co-developed-by: Eric Lin <eric.lin@sifive.com>
Signed-off-by: Eric Lin <eric.lin@sifive.com>
Co-developed-by: Samuel Holland <samuel.holland@sifive.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v1:
 - Add missing events to PL2 sets 2, 4, and 5
 - Use event_base and config_base to precompute register addresses
 - Check event validity earlier, in the .event_init hook
 - Implement .filter for systems where only some CPUs have a PL2
 - Only allocate percpu data when probing each PL2 instance
 - Reference count the `struct pmu` to fix unbind/bind crashes
 - Probe via DT since the PMU driver is now the only PL2 driver
 - Allow the driver to be built as a module

 drivers/perf/Kconfig          |  10 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/sifive_pl2_pmu.c | 748 ++++++++++++++++++++++++++++++++++
 3 files changed, 759 insertions(+)
 create mode 100644 drivers/perf/sifive_pl2_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 8a3b2b88d8b5..bd5ebed8630b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -174,6 +174,16 @@ config SIFIVE_ECACHE_PMU
 	  for measuring whole-system L2/L3 cache performance using the perf
 	  events subsystem.
 
+config SIFIVE_PL2_PMU
+	tristate "SiFive Private L2 Cache PMU"
+	depends on RISCV || COMPILE_TEST
+	depends on OF
+	help
+	  Support for the Private L2 Cache performance monitoring unit (PMU) on
+	  SiFive platforms. The Private L2 Cache PMU provides up to 64 counters
+	  for measuring per-program or per-hart L2 cache performance using the
+	  perf events subsystem.
+
 config THUNDERX2_PMU
 	tristate "Cavium ThunderX2 SoC PMU UNCORE"
 	depends on ARCH_THUNDER2 || COMPILE_TEST
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index a51686b413f2..d5501196dcd8 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_RISCV_PMU_SBI) += riscv_pmu_sbi.o
 obj-$(CONFIG_SIFIVE_CCACHE_PMU) += sifive_ccache_pmu.o
 obj-$(CONFIG_SIFIVE_ECACHE_PMU) += sifive_ecache_pmu.o
+obj-$(CONFIG_SIFIVE_PL2_PMU) += sifive_pl2_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/sifive_pl2_pmu.c b/drivers/perf/sifive_pl2_pmu.c
new file mode 100644
index 000000000000..d0bbac0dec06
--- /dev/null
+++ b/drivers/perf/sifive_pl2_pmu.c
@@ -0,0 +1,748 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive Private L2 Cache PMU driver
+ *
+ * Copyright (C) 2018-2024 SiFive, Inc.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+#include <linux/refcount.h>
+
+#define PL2_SELECT_OFFSET		0x2000
+#define PL2_CLIENT_FILTER_OFFSET	0x2800
+#define PL2_COUNTER_OFFSET		0x3000
+
+#define PL2_PMU_MAX_COUNTERS		64
+
+struct sifive_pl2_pmu_event {
+	void __iomem			*base;
+	DECLARE_BITMAP(used_mask, PL2_PMU_MAX_COUNTERS);
+	unsigned int			cpu;
+	int				n_counters;
+	struct perf_event		*events[] __counted_by(n_counters);
+};
+
+struct sifive_pl2_pmu {
+	struct pmu			pmu;
+	struct notifier_block		cpu_pm_nb;
+	refcount_t			refcount;
+	struct sifive_pl2_pmu_event	*__percpu *event;
+};
+
+#define to_pl2_pmu(p) (container_of(p, struct sifive_pl2_pmu, pmu))
+
+static DEFINE_MUTEX(g_mutex);
+static struct sifive_pl2_pmu *g_pl2_pmu;
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
+ * - events, used by perf user space and other tools to create events symbolically, e.g.:
+ *     perf stat -a -e sifive_pl2_pmu/event=inner_put_partial_data_hit/ ls
+ *     perf stat -a -e sifive_pl2_pmu/event=0x101/ ls
+ * - formats, used by perf user space and other tools to configure events
+ */
+
+/* events */
+static ssize_t sifive_pl2_pmu_event_show(struct device *dev, struct device_attribute *attr,
+					 char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define SET_EVENT_SELECT(_event, _set)	(BIT_ULL((_event) + 8) | (_set))
+#define PL2_PMU_EVENT_ATTR(_name, _event, _set) \
+	PMU_EVENT_ATTR_ID(_name, sifive_pl2_pmu_event_show, SET_EVENT_SELECT(_event, _set))
+
+enum pl2_pmu_event_set1 {
+	INNER_PUT_FULL_DATA = 0,
+	INNER_PUT_PARTIAL_DATA,
+	INNER_ATOMIC_DATA,
+	INNER_GET,
+	INNER_PREFETCH_READ,
+	INNER_PREFETCH_WRITE,
+	INNER_ACQUIRE_BLOCK_NTOB,
+	INNER_ACQUIRE_BLOCK_NTOT,
+	INNER_ACQUIRE_BLOCK_BTOT,
+	INNER_ACQUIRE_PERM_NTOT,
+	INNER_ACQUIRE_PERM_BTOT,
+	INNER_RELEASE_TTOB,
+	INNER_RELEASE_TTON,
+	INNER_RELEASE_BTON,
+	INNER_RELEASE_DATA_TTOB,
+	INNER_RELEASE_DATA_TTON,
+	INNER_RELEASE_DATA_BTON,
+	INNER_RELEASE_DATA_TTOT,
+	INNER_PROBE_BLOCK_TOT,
+	INNER_PROBE_BLOCK_TOB,
+	INNER_PROBE_BLOCK_TON,
+	INNER_PROBE_PERM_TON,
+	INNER_PROBE_ACK_TTOB,
+	INNER_PROBE_ACK_TTON,
+	INNER_PROBE_ACK_BTON,
+	INNER_PROBE_ACK_TTOT,
+	INNER_PROBE_ACK_BTOB,
+	INNER_PROBE_ACK_NTON,
+	INNER_PROBE_ACK_DATA_TTOB,
+	INNER_PROBE_ACK_DATA_TTON,
+	INNER_PROBE_ACK_DATA_TTOT,
+	PL2_PMU_MAX_EVENT1_IDX
+};
+
+enum pl2_pmu_event_set2 {
+	INNER_PUT_FULL_DATA_HIT = 0,
+	INNER_PUT_PARTIAL_DATA_HIT,
+	INNER_ATOMIC_DATA_HIT,
+	INNER_GET_HIT,
+	INNER_PREFETCH_READ_HIT,
+	INNER_ACQUIRE_BLOCK_NTOB_HIT,
+	INNER_ACQUIRE_PERM_NTOT_HIT,
+	INNER_RELEASE_TTOB_HIT,
+	INNER_RELEASE_DATA_TTOB_HIT,
+	OUTER_PROBE_BLOCK_TOT_HIT,
+	INNER_PUT_FULL_DATA_HIT_SHARED,
+	INNER_PUT_PARTIAL_DATA_HIT_SHARED,
+	INNER_ATOMIC_DATA_HIT_SHARED,
+	INNER_GET_HIT_SHARED,
+	INNER_PREFETCH_READ_HIT_SHARED,
+	INNER_ACQUIRE_BLOCK_NTOB_HIT_SHARED,
+	INNER_ACQUIRE_PERM_NTOT_HIT_SHARED,
+	INNER_RELEASE_TTOB_HIT_SHARED,
+	INNER_RELEASE_DATA_TTOB_HIT_SHARED,
+	OUTER_PROBE_BLOCK_TOT_HIT_SHARED,
+	OUTER_PROBE_BLOCK_TOT_HIT_DIRTY,
+	PL2_PMU_MAX_EVENT2_IDX
+};
+
+enum pl2_pmu_event_set3 {
+	OUTER_PUT_FULL_DATA = 0,
+	OUTER_PUT_PARTIAL_DATA,
+	OUTER_ATOMIC_DATA,
+	OUTER_GET,
+	OUTER_PREFETCH_READ,
+	OUTER_PREFETCH_WRITE,
+	OUTER_ACQUIRE_BLOCK_NTOB,
+	OUTER_ACQUIRE_BLOCK_NTOT,
+	OUTER_ACQUIRE_BLOCK_BTOT,
+	OUTER_ACQUIRE_PERM_NTOT,
+	OUTER_ACQUIRE_PERM_BTOT,
+	OUTER_RELEARE_TTOB,
+	OUTER_RELEARE_TTON,
+	OUTER_RELEARE_BTON,
+	OUTER_RELEARE_DATA_TTOB,
+	OUTER_RELEARE_DATA_TTON,
+	OUTER_RELEARE_DATA_BTON,
+	OUTER_RELEARE_DATA_TTOT,
+	OUTER_PROBE_BLOCK_TOT,
+	OUTER_PROBE_BLOCK_TOB,
+	OUTER_PROBE_BLOCK_TON,
+	OUTER_PROBE_PERM_TON,
+	OUTER_PROBE_ACK_TTOB,
+	OUTER_PROBE_ACK_TTON,
+	OUTER_PROBE_ACK_BTON,
+	OUTER_PROBE_ACK_TTOT,
+	OUTER_PROBE_ACK_BTOB,
+	OUTER_PROBE_ACK_NTON,
+	OUTER_PROBE_ACK_DATA_TTOB,
+	OUTER_PROBE_ACK_DATA_TTON,
+	OUTER_PROBE_ACK_DATA_TTOT,
+	PL2_PMU_MAX_EVENT3_IDX
+};
+
+enum pl2_pmu_event_set4 {
+	INNER_HINT_HITS_MSHR = 0,
+	INNER_READ_HITS_MSHR,
+	INNER_WRITE_HITS_MSHR,
+	INNER_READ_REPLAY,
+	INNER_WRITE_REPLAY,
+	OUTER_PROBE_REPLAY,
+	REPLAY,
+	SLEEP_BY_MISS_QUEUE,
+	SLEEP_BY_EVICT_QUEUE,
+	SLEEP_FOR_BACK_PROBE,
+	SLEEP,
+	PL2_PMU_MAX_EVENT4_IDX
+};
+
+enum pl2_pmu_event_set5 {
+	READ_SLEEP_TIMER_EXPIRE = 0,
+	READ_OLDEST_TIMER_EXPIRE,
+	WRITE_SLEEP_TIMER_EXPIRE,
+	WRITE_OLDEST_TIMER_EXPIRE,
+	READ_SLEEP,
+	READ_DIR_UPDATE_WAKEUP,
+	READ_MISS_QUEUE_WAKEUP,
+	READ_EVICT_QUEUE_WAKEUP,
+	READ_SLEEP_TIMER_WAKEUP,
+	WRITE_SLEEP,
+	WRITE_DIR_UPDATE_WAKEUP,
+	WRITE_MISS_QUEUE_WAKEUP,
+	WRITE_EVICT_QUEUE_WAKEUP,
+	WRITE_SLEEP_TIMER_WAKEUP,
+	PL2_PMU_MAX_EVENT5_IDX
+};
+
+static struct attribute *sifive_pl2_pmu_events[] = {
+	PL2_PMU_EVENT_ATTR(inner_put_full_data, INNER_PUT_FULL_DATA, 1),
+	PL2_PMU_EVENT_ATTR(inner_put_partial_data, INNER_PUT_PARTIAL_DATA, 1),
+	PL2_PMU_EVENT_ATTR(inner_atomic_data, INNER_ATOMIC_DATA, 1),
+	PL2_PMU_EVENT_ATTR(inner_get, INNER_GET, 1),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_read, INNER_PREFETCH_READ, 1),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_write, INNER_PREFETCH_WRITE, 1),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_ntob, INNER_ACQUIRE_BLOCK_NTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_ntot, INNER_ACQUIRE_BLOCK_NTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_btot, INNER_ACQUIRE_BLOCK_BTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_ntot, INNER_ACQUIRE_PERM_NTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_btot, INNER_ACQUIRE_PERM_BTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_ttob, INNER_RELEASE_TTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_tton, INNER_RELEASE_TTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_bton, INNER_RELEASE_BTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_data_ttob, INNER_RELEASE_DATA_TTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_data_tton, INNER_RELEASE_DATA_TTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_data_bton, INNER_RELEASE_DATA_BTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_release_data_ttot, INNER_RELEASE_DATA_TTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_block_tot, INNER_PROBE_BLOCK_TOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_block_tob, INNER_PROBE_BLOCK_TOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_block_ton, INNER_PROBE_BLOCK_TON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_perm_ton, INNER_PROBE_PERM_TON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_ttob, INNER_PROBE_ACK_TTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_tton, INNER_PROBE_ACK_TTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_bton, INNER_PROBE_ACK_BTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_ttot, INNER_PROBE_ACK_TTOT, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_btob, INNER_PROBE_ACK_BTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_nton, INNER_PROBE_ACK_NTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_data_ttob, INNER_PROBE_ACK_DATA_TTOB, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_data_tton, INNER_PROBE_ACK_DATA_TTON, 1),
+	PL2_PMU_EVENT_ATTR(inner_probe_ack_data_ttot, INNER_PROBE_ACK_DATA_TTOT, 1),
+
+	PL2_PMU_EVENT_ATTR(inner_put_full_data_hit, INNER_PUT_FULL_DATA_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_put_partial_data_hit, INNER_PUT_PARTIAL_DATA_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_atomic_data_hit, INNER_ATOMIC_DATA_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_get_hit, INNER_GET_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_read_hit, INNER_PREFETCH_READ_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_ntob_hit, INNER_ACQUIRE_BLOCK_NTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_ntot_hit, INNER_ACQUIRE_PERM_NTOT_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_ttob_hit, INNER_RELEASE_TTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_data_ttob_hit, INNER_RELEASE_DATA_TTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit, OUTER_PROBE_BLOCK_TOT_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_put_full_data_hit_shared, INNER_PUT_FULL_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_put_partial_data_hit_shared, INNER_PUT_PARTIAL_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_atomic_data_hit_shared, INNER_ATOMIC_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_get_hit_shared, INNER_GET_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_read_hit_shared, INNER_PREFETCH_READ_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_ntob_hit_shared,
+			   INNER_ACQUIRE_BLOCK_NTOB_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_ntot_hit_shared,
+			   INNER_ACQUIRE_PERM_NTOT_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_ttob_hit_shared, INNER_RELEASE_TTOB_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_data_ttob_hit_shared,
+			   INNER_RELEASE_DATA_TTOB_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit_shared, OUTER_PROBE_BLOCK_TOT_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit_dirty, OUTER_PROBE_BLOCK_TOT_HIT_DIRTY, 2),
+
+	PL2_PMU_EVENT_ATTR(outer_put_full_data, OUTER_PUT_FULL_DATA, 3),
+	PL2_PMU_EVENT_ATTR(outer_put_partial_data, OUTER_PUT_PARTIAL_DATA, 3),
+	PL2_PMU_EVENT_ATTR(outer_atomic_data, OUTER_ATOMIC_DATA, 3),
+	PL2_PMU_EVENT_ATTR(outer_get, OUTER_GET, 3),
+	PL2_PMU_EVENT_ATTR(outer_prefetch_read, OUTER_PREFETCH_READ, 3),
+	PL2_PMU_EVENT_ATTR(outer_prefetch_write, OUTER_PREFETCH_WRITE, 3),
+	PL2_PMU_EVENT_ATTR(outer_acquire_block_ntob, OUTER_ACQUIRE_BLOCK_NTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_acquire_block_ntot, OUTER_ACQUIRE_BLOCK_NTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_acquire_block_btot, OUTER_ACQUIRE_BLOCK_BTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_acquire_perm_ntot, OUTER_ACQUIRE_PERM_NTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_acquire_perm_btot, OUTER_ACQUIRE_PERM_BTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_ttob, OUTER_RELEARE_TTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_tton, OUTER_RELEARE_TTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_bton, OUTER_RELEARE_BTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_data_ttob, OUTER_RELEARE_DATA_TTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_data_tton, OUTER_RELEARE_DATA_TTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_data_bton, OUTER_RELEARE_DATA_BTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_release_data_ttot, OUTER_RELEARE_DATA_TTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot, OUTER_PROBE_BLOCK_TOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tob, OUTER_PROBE_BLOCK_TOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_ton, OUTER_PROBE_BLOCK_TON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_perm_ton, OUTER_PROBE_PERM_TON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_ttob, OUTER_PROBE_ACK_TTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_tton, OUTER_PROBE_ACK_TTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_bton, OUTER_PROBE_ACK_BTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_ttot, OUTER_PROBE_ACK_TTOT, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_btob, OUTER_PROBE_ACK_BTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_nton, OUTER_PROBE_ACK_NTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_data_ttob, OUTER_PROBE_ACK_DATA_TTOB, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_data_tton, OUTER_PROBE_ACK_DATA_TTON, 3),
+	PL2_PMU_EVENT_ATTR(outer_probe_ack_data_ttot, OUTER_PROBE_ACK_DATA_TTOT, 3),
+
+	PL2_PMU_EVENT_ATTR(inner_hint_hits_mshr, INNER_HINT_HITS_MSHR, 4),
+	PL2_PMU_EVENT_ATTR(inner_read_hits_mshr, INNER_READ_HITS_MSHR, 4),
+	PL2_PMU_EVENT_ATTR(inner_write_hits_mshr, INNER_WRITE_HITS_MSHR, 4),
+	PL2_PMU_EVENT_ATTR(inner_read_replay, INNER_READ_REPLAY, 4),
+	PL2_PMU_EVENT_ATTR(inner_write_replay, INNER_WRITE_REPLAY, 4),
+	PL2_PMU_EVENT_ATTR(outer_probe_replay, OUTER_PROBE_REPLAY, 4),
+	PL2_PMU_EVENT_ATTR(replay, REPLAY, 4),
+	PL2_PMU_EVENT_ATTR(sleep_by_miss_queue, SLEEP_BY_MISS_QUEUE, 4),
+	PL2_PMU_EVENT_ATTR(sleep_by_evict_queue, SLEEP_BY_EVICT_QUEUE, 4),
+	PL2_PMU_EVENT_ATTR(sleep_for_back_probe, SLEEP_FOR_BACK_PROBE, 4),
+	PL2_PMU_EVENT_ATTR(sleep, SLEEP, 4),
+
+	PL2_PMU_EVENT_ATTR(read_sleep_timer_expire, READ_SLEEP_TIMER_EXPIRE, 5),
+	PL2_PMU_EVENT_ATTR(read_oldest_timer_expire, READ_OLDEST_TIMER_EXPIRE, 5),
+	PL2_PMU_EVENT_ATTR(write_sleep_timer_expire, WRITE_SLEEP_TIMER_EXPIRE, 5),
+	PL2_PMU_EVENT_ATTR(write_oldest_timer_expire, WRITE_OLDEST_TIMER_EXPIRE, 5),
+	PL2_PMU_EVENT_ATTR(read_sleep, READ_SLEEP, 5),
+	PL2_PMU_EVENT_ATTR(read_dir_update_wakeup, READ_DIR_UPDATE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(read_miss_queue_wakeup, READ_MISS_QUEUE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(read_evict_queue_wakeup, READ_EVICT_QUEUE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(read_sleep_timer_wakeup, READ_SLEEP_TIMER_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(write_sleep, WRITE_SLEEP, 5),
+	PL2_PMU_EVENT_ATTR(write_dir_update_wakeup, WRITE_DIR_UPDATE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(write_miss_queue_wakeup, WRITE_MISS_QUEUE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(write_evict_queue_wakeup, WRITE_EVICT_QUEUE_WAKEUP, 5),
+	PL2_PMU_EVENT_ATTR(write_sleep_timer_wakeup, WRITE_SLEEP_TIMER_WAKEUP, 5),
+	NULL
+};
+
+static struct attribute_group sifive_pl2_pmu_events_group = {
+	.name = "events",
+	.attrs = sifive_pl2_pmu_events,
+};
+
+/* formats */
+PMU_FORMAT_ATTR(event, "config:0-63");
+
+static struct attribute *sifive_pl2_pmu_formats[] = {
+	&format_attr_event.attr,
+	NULL,
+};
+
+static struct attribute_group sifive_pl2_pmu_format_group = {
+	.name = "format",
+	.attrs = sifive_pl2_pmu_formats,
+};
+
+/*
+ * Per PMU device attribute groups
+ */
+
+static const struct attribute_group *sifive_pl2_pmu_attr_grps[] = {
+	&sifive_pl2_pmu_events_group,
+	&sifive_pl2_pmu_format_group,
+	NULL,
+};
+
+/*
+ * Event Initialization
+ */
+
+static int sifive_pl2_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 config = event->attr.config;
+	u64 ev_type = config >> 8;
+	u64 set = config & 0xff;
+
+	/* Check if this is a valid set and event */
+	switch (set) {
+	case 1:
+		if (ev_type >= BIT_ULL(PL2_PMU_MAX_EVENT1_IDX))
+			return -ENOENT;
+		break;
+	case 2:
+		if (ev_type >= BIT_ULL(PL2_PMU_MAX_EVENT2_IDX))
+			return -ENOENT;
+		break;
+	case 3:
+		if (ev_type >= BIT_ULL(PL2_PMU_MAX_EVENT3_IDX))
+			return -ENOENT;
+		break;
+	case 4:
+		if (ev_type >= BIT_ULL(PL2_PMU_MAX_EVENT4_IDX))
+			return -ENOENT;
+		break;
+	case 5:
+		if (ev_type >= BIT_ULL(PL2_PMU_MAX_EVENT5_IDX))
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
+	return 0;
+}
+
+/*
+ * pmu->read: read and update the counter
+ */
+static void sifive_pl2_pmu_read(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_raw_count, new_raw_count;
+	u64 oldval;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = readq((void *)hwc->event_base);
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
+static void sifive_pl2_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
+		return;
+
+	hwc->state = 0;
+
+	/* Set initial value to 0 */
+	local64_set(&hwc->prev_count, 0);
+	writeq(0, (void *)hwc->event_base);
+
+	/* Enable this counter to count events */
+	writeq(hwc->config, (void *)hwc->config_base);
+}
+
+/*
+ * pmu->stop: stop the counter
+ */
+static void sifive_pl2_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	/* Disable this counter to count events */
+	writeq(0, (void *)hwc->config_base);
+	sifive_pl2_pmu_read(event);
+
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+/*
+ * pmu->add: add the event to the PMU
+ */
+static int sifive_pl2_pmu_add(struct perf_event *event, int flags)
+{
+	struct sifive_pl2_pmu *pl2_pmu = to_pl2_pmu(event->pmu);
+	struct sifive_pl2_pmu_event *ptr = *this_cpu_ptr(pl2_pmu->event);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Find an available counter idx to use for this event */
+	do {
+		idx = find_first_zero_bit(ptr->used_mask, ptr->n_counters);
+		if (idx >= ptr->n_counters)
+			return -EAGAIN;
+	} while (test_and_set_bit(idx, ptr->used_mask));
+
+	hwc->config_base = (unsigned long)ptr->base + PL2_SELECT_OFFSET + 8 * idx;
+	hwc->event_base = (unsigned long)ptr->base + PL2_COUNTER_OFFSET + 8 * idx;
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	ptr->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		sifive_pl2_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+/*
+ * pmu->del: delete the event from the PMU
+ */
+static void sifive_pl2_pmu_del(struct perf_event *event, int flags)
+{
+	struct sifive_pl2_pmu *pl2_pmu = to_pl2_pmu(event->pmu);
+	struct sifive_pl2_pmu_event *ptr = *this_cpu_ptr(pl2_pmu->event);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	/* Stop and release this counter */
+	sifive_pl2_pmu_stop(event, PERF_EF_UPDATE);
+
+	ptr->events[idx] = NULL;
+	clear_bit(idx, ptr->used_mask);
+
+	perf_event_update_userpage(event);
+}
+
+/*
+ * pmu->filter: check if the PMU can be used with a CPU
+ */
+static bool sifive_pl2_pmu_filter(struct pmu *pmu, int cpu)
+{
+	struct sifive_pl2_pmu *pl2_pmu = to_pl2_pmu(pmu);
+	struct sifive_pl2_pmu_event *ptr = *this_cpu_ptr(pl2_pmu->event);
+
+	/* Filter out CPUs with no PL2 instance (no percpu data allocated) */
+	return !ptr;
+}
+
+/*
+ * Driver initialization
+ */
+
+static void sifive_pl2_pmu_hw_init(const struct sifive_pl2_pmu_event *ptr)
+{
+	/* Disable the client filter (not supported by this driver) */
+	writeq(0, ptr->base + PL2_CLIENT_FILTER_OFFSET);
+}
+
+static int sifive_pl2_pmu_pm_notify(struct notifier_block *nb, unsigned long cmd, void *v)
+{
+	struct sifive_pl2_pmu *pl2_pmu = container_of(nb, struct sifive_pl2_pmu, cpu_pm_nb);
+	struct sifive_pl2_pmu_event *ptr = *this_cpu_ptr(pl2_pmu->event);
+	struct perf_event *event;
+
+	if (!ptr || bitmap_empty(ptr->used_mask, PL2_PMU_MAX_COUNTERS))
+		return NOTIFY_OK;
+
+	for (int idx = 0; idx < ptr->n_counters; idx++) {
+		event = ptr->events[idx];
+		if (!event)
+			continue;
+
+		switch (cmd) {
+		case CPU_PM_ENTER:
+			/* Stop and update the counter */
+			sifive_pl2_pmu_stop(event, PERF_EF_UPDATE);
+			break;
+		case CPU_PM_ENTER_FAILED:
+		case CPU_PM_EXIT:
+			/* Restore and enable the counter */
+			sifive_pl2_pmu_start(event, PERF_EF_RELOAD);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return NOTIFY_OK;
+}
+
+static int sifive_pl2_pmu_pm_register(struct sifive_pl2_pmu *pl2_pmu)
+{
+	if (!IS_ENABLED(CONFIG_CPU_PM))
+		return 0;
+
+	pl2_pmu->cpu_pm_nb.notifier_call = sifive_pl2_pmu_pm_notify;
+	return cpu_pm_register_notifier(&pl2_pmu->cpu_pm_nb);
+}
+
+static void sifive_pl2_pmu_pm_unregister(struct sifive_pl2_pmu *pl2_pmu)
+{
+	if (!IS_ENABLED(CONFIG_CPU_PM))
+		return;
+
+	cpu_pm_unregister_notifier(&pl2_pmu->cpu_pm_nb);
+}
+
+static struct sifive_pl2_pmu *sifive_pl2_pmu_get(void)
+{
+	struct sifive_pl2_pmu *pl2_pmu;
+	int ret;
+
+	guard(mutex)(&g_mutex);
+
+	pl2_pmu = g_pl2_pmu;
+	if (pl2_pmu) {
+		refcount_inc(&pl2_pmu->refcount);
+		return pl2_pmu;
+	}
+
+	pl2_pmu = kzalloc(sizeof(*pl2_pmu), GFP_KERNEL);
+	if (!pl2_pmu)
+		return ERR_PTR(-ENOMEM);
+
+	pl2_pmu->pmu = (struct pmu) {
+		.attr_groups	= sifive_pl2_pmu_attr_grps,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+		.task_ctx_nr	= perf_sw_context,
+		.event_init	= sifive_pl2_pmu_event_init,
+		.add		= sifive_pl2_pmu_add,
+		.del		= sifive_pl2_pmu_del,
+		.start		= sifive_pl2_pmu_start,
+		.stop		= sifive_pl2_pmu_stop,
+		.read		= sifive_pl2_pmu_read,
+		.filter		= sifive_pl2_pmu_filter,
+	};
+
+	refcount_set(&pl2_pmu->refcount, 1);
+
+	pl2_pmu->event = alloc_percpu(typeof(*pl2_pmu->event));
+	if (!pl2_pmu->event) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	ret = sifive_pl2_pmu_pm_register(pl2_pmu);
+	if (ret)
+		goto err_free_percpu;
+
+	ret = perf_pmu_register(&pl2_pmu->pmu, "sifive_pl2_pmu", -1);
+	if (ret) {
+		pr_err("%s: Failed to register PMU: %d\n", __func__, ret);
+		goto err_unregister_pm;
+	}
+
+	g_pl2_pmu = pl2_pmu;
+
+	return pl2_pmu;
+
+err_unregister_pm:
+	sifive_pl2_pmu_pm_unregister(pl2_pmu);
+err_free_percpu:
+	free_percpu(pl2_pmu->event);
+err_free:
+	kfree(pl2_pmu);
+
+	return ERR_PTR(ret);
+}
+
+static void sifive_pl2_pmu_put(void)
+{
+	struct sifive_pl2_pmu *pl2_pmu;
+
+	guard(mutex)(&g_mutex);
+
+	pl2_pmu = g_pl2_pmu;
+	if (!refcount_dec_and_test(&pl2_pmu->refcount))
+		return;
+
+	g_pl2_pmu = NULL;
+	perf_pmu_unregister(&pl2_pmu->pmu);
+	sifive_pl2_pmu_pm_unregister(pl2_pmu);
+	free_percpu(pl2_pmu->event);
+	kfree(pl2_pmu);
+}
+
+static int sifive_pl2_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev_of_node(dev);
+	struct sifive_pl2_pmu_event *ptr;
+	struct sifive_pl2_pmu *pl2_pmu;
+	unsigned int cpu;
+	u32 n_counters;
+	int ret;
+
+	/* Instances without a sifive,perfmon-counters property do not contain a PMU */
+	ret = of_property_read_u32(np, "sifive,perfmon-counters", &n_counters);
+	if (ret || !n_counters)
+		return -ENODEV;
+
+	/* Determine the CPU affinity of this PL2 instance */
+	for_each_possible_cpu(cpu) {
+		struct device_node *cache_node, *cpu_node;
+
+		cpu_node = of_cpu_device_node_get(cpu);
+		if (!cpu_node)
+			continue;
+
+		cache_node = of_parse_phandle(cpu_node, "next-level-cache", 0);
+		of_node_put(cpu_node);
+		if (!cache_node)
+			continue;
+
+		of_node_put(cache_node);
+		if (cache_node == np)
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -ENODEV;
+
+	ptr = devm_kzalloc(dev, struct_size(ptr, events, n_counters), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ptr);
+
+	ptr->cpu = cpu;
+	ptr->n_counters = n_counters;
+
+	ptr->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ptr->base))
+		return PTR_ERR(ptr->base);
+
+	sifive_pl2_pmu_hw_init(ptr);
+
+	pl2_pmu = sifive_pl2_pmu_get();
+	if (IS_ERR(pl2_pmu))
+		return PTR_ERR(pl2_pmu);
+
+	*per_cpu_ptr(pl2_pmu->event, cpu) = ptr;
+
+	return 0;
+}
+
+static void sifive_pl2_pmu_remove(struct platform_device *pdev)
+{
+	struct sifive_pl2_pmu_event *ptr = platform_get_drvdata(pdev);
+
+	*per_cpu_ptr(g_pl2_pmu->event, ptr->cpu) = NULL;
+	sifive_pl2_pmu_put();
+}
+
+static const struct of_device_id sifve_pl2_pmu_of_match[] = {
+	{ .compatible = "sifive,pl2cache1" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sifve_pl2_pmu_of_match);
+
+static struct platform_driver sifive_pl2_pmu_driver = {
+	.probe	= sifive_pl2_pmu_probe,
+	.remove_new	= sifive_pl2_pmu_remove,
+	.driver	= {
+		.name		= "sifive_pl2_pmu",
+		.of_match_table	= sifve_pl2_pmu_of_match,
+	},
+};
+module_platform_driver(sifive_pl2_pmu_driver);
+
+MODULE_LICENSE("GPL");
-- 
2.43.0


