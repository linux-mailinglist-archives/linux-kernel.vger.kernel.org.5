Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3B75B070
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjGTNwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjGTNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:52:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC082711
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:52:17 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668711086f4so585006b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689861137; x=1690465937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONFSGAv7y90DGzRrUkV1P1co+f8slZz0RMgOAtkjbUs=;
        b=Xo66GV2DTiiJX09urJIVCaPrqjcD3+s8b3B+Y391uNwqdfYmLfibC23cYp83DAFeug
         g+6JzcO2s9Yyw34MdsxEJcRO/oxtrvLU6WZNCLnwSkcM+IgwfR5BHrL/Z09UKm48zDMj
         six2AtLy8U24H4LkdTzyoMSTPp3Ws9b1rYrwYiMtDTBMbB6hLm2fEEuVvjXkLJYZ2R2+
         qq6mokIrTUmR+smZcb9H08907luaq5tx0JWStj6UGHoZ2dWamJfdvWrRvWazzvHNUnlm
         HHYU99eB3uv5G8zogRFOyZ1UadxivRjzl3OXAZ+A7vj6IGG6ILcBh6oAEwEytgWEKOHO
         NTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861137; x=1690465937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONFSGAv7y90DGzRrUkV1P1co+f8slZz0RMgOAtkjbUs=;
        b=gmB/sVUdqhJV0duys2UUkqpcygvCYuqsxfu8yP2Z8R03DbTYWCxghU+EDhcxUK9tNE
         YpcRmCHw1JLe64Ub3fMJGgW77Q/eKDnBxVb+1QifUyspmkEWkNwKRrZ7e7Nv9UA5uDUV
         NGkGVSM4tYsUKhqxcHlqLbz/0+sEA9qovA9ofVi68vOUONQVLqbQiVdLgkDyWhlLVoFt
         s7+KsNBHDmvDMW7pduiOwFaInPuciLrB3BmGl/w3icq5nkXxr2g+7knAEPeL3fS/lSuM
         HtuQmC2mZ6u7fc0hdbr/lQ6DSV0N4jze+1N/gTv/WYoramyImTgPJZmnm7eodA2OFh7e
         nOcw==
X-Gm-Message-State: ABy/qLajPsbXh6XBsUqV0hl4PE1u0Ta//J6gK/zwXRqOzsdhyI3NZYhT
        kLF8mw+xLGwWyFw8wiOdio12rQ==
X-Google-Smtp-Source: APBJJlFlKnY0IUdleot0oBts+4K3Onqkc0JWBCYK/QiPnn+BULkkW4WIkG6gQyWhBGWpvYxJYor7Iw==
X-Received: by 2002:a05:6a00:4888:b0:666:6c01:2e9e with SMTP id dk8-20020a056a00488800b006666c012e9emr7158648pfb.15.1689861137141;
        Thu, 20 Jul 2023 06:52:17 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78d12000000b00679fef56287sm1197529pfe.147.2023.07.20.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:52:16 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        peterz@infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>,
        Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 3/3] soc: sifive: Add SiFive private L2 cache PMU driver
Date:   Thu, 20 Jul 2023 21:51:21 +0800
Message-Id: <20230720135125.21240-4-eric.lin@sifive.com>
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

From: Greentime Hu <greentime.hu@sifive.com>

The SiFive private L2 cache PMU is per-core and supports
per-task profiling and event counting. Users can use the
perf tool to profile by event name and event id.
Example:
$ perf stat -C 0 -e /sifive_pl2_pmu/inner_acquire_block_btot/
                -e /sifive_pl2_pmu/inner_acquire_block_ntob/
                -e /sifive_pl2_pmu/inner_acquire_block_ntot/ ls

 Performance counter stats for 'CPU(s) 0':

               300      sifive_pl2_pmu/inner_acquire_block_btot/
             17801      sifive_pl2_pmu/inner_acquire_block_ntob/
              5253      sifive_pl2_pmu/inner_acquire_block_ntot/

       0.088917326 seconds time elapsed

$ perf stat -C 0 -e /sifive_pl2_pmu/event=0x10001/
                -e /sifive_pl2_pmu/event=0x4001/
                -e /sifive_pl2_pmu/event=0x8001/ ls

 Performance counter stats for 'CPU(s) 0':

               251      sifive_pl2_pmu/event=0x10001/
              2620      sifive_pl2_pmu/event=0x4001/
               644      sifive_pl2_pmu/event=0x8001/

       0.092827110 seconds time elapsed

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Co-developed-by: Eric Lin <eric.lin@sifive.com>
Signed-off-by: Eric Lin <eric.lin@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Nick Hu <nick.hu@sifive.com>
---
 drivers/perf/Kconfig                  |  10 +
 drivers/perf/Makefile                 |   1 +
 drivers/perf/sifive_pl2_pmu.c         | 602 ++++++++++++++++++++++++++
 drivers/soc/sifive/sifive_pl2.h       |   2 +
 drivers/soc/sifive/sifive_pl2_cache.c |  10 +-
 5 files changed, 624 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/sifive_pl2_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index f4572a5cca72..d6245122ffb2 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -234,4 +234,14 @@ config CXL_PMU
 
 	  If unsure say 'm'.
 
+config SIFIVE_PL2_PMU
+	bool "Sifive private L2 Cache PMU"
+	depends on SIFIVE_PL2 && PERF_EVENTS
+	default y
+	help
+	  Support for the private L2 cache controller performance monitor unit
+	  (PMU) on SiFive platforms. The SiFive private L2 PMU can monitor the
+	  each hart L2 cache performance and it consists of a set of event
+	  programmable counters and their event selector registers.
+
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 16b3ec4db916..3141782dbfc9 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
 obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
+obj-$(CONFIG_SIFIVE_PL2_PMU) += sifive_pl2_pmu.o
diff --git a/drivers/perf/sifive_pl2_pmu.c b/drivers/perf/sifive_pl2_pmu.c
new file mode 100644
index 000000000000..bbdc006f0c8d
--- /dev/null
+++ b/drivers/perf/sifive_pl2_pmu.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SiFive private L2 cache controller PMU Driver
+ *
+ * Copyright (C) 2018-2023 SiFive, Inc.
+ */
+
+#define pr_fmt(fmt) "pL2CACHE_PMU: " fmt
+
+#include <linux/kprobes.h>
+#include <linux/kernel.h>
+#include <linux/kdebug.h>
+#include <linux/mutex.h>
+#include <linux/bitmap.h>
+#include <linux/perf_event.h>
+#include <linux/atomic.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/cpu_pm.h>
+
+#define SIFIVE_PL2_PMU_MAX_COUNTERS	64
+#define SIFIVE_PL2_SELECT_BASE_OFFSET	0x2000
+#define SIFIVE_PL2_COUNTER_BASE_OFFSET	0x3000
+
+#define SIFIVE_PL2_COUNTER_MASK   GENMASK_ULL(63, 0)
+
+struct sifive_pl2_pmu_event {
+	struct perf_event **events;
+	void __iomem *event_counter_base;
+	void __iomem *event_select_base;
+	u32 counters;
+	DECLARE_BITMAP(used_mask, SIFIVE_PL2_PMU_MAX_COUNTERS);
+};
+
+struct sifive_pl2_pmu {
+	struct pmu *pmu;
+};
+
+static bool pl2pmu_init_done;
+static struct sifive_pl2_pmu sifive_pl2_pmu;
+static DEFINE_PER_CPU(struct sifive_pl2_pmu_event, sifive_pl2_pmu_event);
+
+#ifndef readq
+static inline unsigned long long readq(void __iomem *addr)
+{
+	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
+}
+#endif
+
+#ifndef writeq
+static inline void writeq(unsigned long long v, void __iomem *addr)
+{
+	writel(lower_32_bits(v), addr);
+	writel(upper_32_bits(v), addr + 4);
+}
+#endif
+
+/* formats */
+static ssize_t sifive_pl2_pmu_format_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct dev_ext_attribute *eattr;
+
+	eattr = container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+#define SIFIVE_PL2_PMU_PMU_FORMAT_ATTR(_name, _config)				\
+	(&((struct dev_ext_attribute[]) {					\
+		{ .attr = __ATTR(_name, 0444, sifive_pl2_pmu_format_show, NULL),\
+		  .var = (void *)_config, }					\
+	})[0].attr.attr)
+
+static struct attribute *sifive_pl2_pmu_formats[] = {
+	SIFIVE_PL2_PMU_PMU_FORMAT_ATTR(event, "config:0-63"),
+	NULL,
+};
+
+static struct attribute_group sifive_pl2_pmu_format_group = {
+	.name = "format",
+	.attrs = sifive_pl2_pmu_formats,
+};
+
+/* events */
+
+static ssize_t sifive_pl2_pmu_event_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define SET_EVENT_SELECT(_event, _set)	(((u64)1 << ((_event) + 8)) | (_set))
+#define PL2_PMU_EVENT_ATTR(_name, _event, _set)			\
+	PMU_EVENT_ATTR_ID(_name, sifive_pl2_pmu_event_show,	\
+	SET_EVENT_SELECT(_event, _set))
+
+enum pl2_pmu_event_set1 {
+	INNER_PUT_FULL_DATA = 0,
+	INNER_PUT_PARTIAL_DATA,
+	INNER_ARITHMETIC_DATA,
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
+	INNER_ARITHMETIC_DATA_HIT,
+	INNER_GET_HIT,
+	INNER_PREFETCH_READ_HIT,
+	INNER_ACQUIRE_BLOCK_NTOB_HIT,
+	INNER_ACQUIRE_PERM_NTOT_HIT,
+	INNER_RELEASE_TTOB_HIT,
+	INNER_RELEASE_DATA_TTOB_HIT,
+	OUTER_PROBE_BLOCK_TOT_HIT,
+	INNER_PUT_FULL_DATA_HIT_SHARED,
+	INNER_PUT_PARTIAL_DATA_HIT_SHARED,
+	INNER_ARITHMETIC_DATA_HIT_SHARED,
+	INNER_GET_HIT_SHARED,
+	INNER_PREFETCH_READ_HIT_SHARED,
+	INNER_ACQUIRE_BLOCK_HIT_SHARED,
+	INNER_ACQUIRE_PERM_NTOT_HIT_SHARED,
+	OUTER_PROBE_BLOCK_TOT_HIT_SHARED,
+	OUTER_PROBE_BLOCK_TOT_HIT_DIRTY,
+	PL2_PMU_MAX_EVENT2_IDX
+};
+
+enum pl2_pmu_event_set3 {
+	OUTER_PUT_FULL_DATA = 0,
+	OUTER_PUT_PARTIAL_DATA,
+	OUTER_ARITHMETIC_DATA,
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
+	PL2_PMU_MAX_EVENT4_IDX
+};
+
+static struct attribute *sifive_pl2_pmu_events[] = {
+	PL2_PMU_EVENT_ATTR(inner_put_full_data, INNER_PUT_FULL_DATA, 1),
+	PL2_PMU_EVENT_ATTR(inner_put_partial_data, INNER_PUT_PARTIAL_DATA, 1),
+	PL2_PMU_EVENT_ATTR(inner_arithmetic_data, INNER_ARITHMETIC_DATA, 1),
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
+	PL2_PMU_EVENT_ATTR(inner_arithmetic_data_hit, INNER_ARITHMETIC_DATA_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_get_hit, INNER_GET_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_read_hit, INNER_PREFETCH_READ_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_ntob_hit, INNER_ACQUIRE_BLOCK_NTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_ntot_hit, INNER_ACQUIRE_PERM_NTOT_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_ttob_hit, INNER_RELEASE_TTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_release_data_ttob_hit, INNER_RELEASE_DATA_TTOB_HIT, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit, OUTER_PROBE_BLOCK_TOT_HIT, 2),
+	PL2_PMU_EVENT_ATTR(inner_put_full_data_hit_shared, INNER_PUT_FULL_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_put_partial_data_hit_shared, INNER_PUT_PARTIAL_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_arithmetic_data_hit_shared, INNER_ARITHMETIC_DATA_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_get_hit_shared, INNER_GET_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_prefetch_read_hit_shared, INNER_PREFETCH_READ_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_block_hit_shared, INNER_ACQUIRE_BLOCK_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(inner_acquire_perm_hit_shared, INNER_ACQUIRE_PERM_NTOT_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit_shared, OUTER_PROBE_BLOCK_TOT_HIT_SHARED, 2),
+	PL2_PMU_EVENT_ATTR(outer_probe_block_tot_hit_dirty, OUTER_PROBE_BLOCK_TOT_HIT_DIRTY, 2),
+
+	PL2_PMU_EVENT_ATTR(outer_put_full_data, OUTER_PUT_FULL_DATA, 3),
+	PL2_PMU_EVENT_ATTR(outer_put_partial_data, OUTER_PUT_PARTIAL_DATA, 3),
+	PL2_PMU_EVENT_ATTR(outer_arithmetic_data, OUTER_ARITHMETIC_DATA, 3),
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
+	NULL
+};
+
+static struct attribute_group sifive_pl2_pmu_events_group = {
+	.name = "events",
+	.attrs = sifive_pl2_pmu_events,
+};
+
+/*
+ * Per PMU device attribute groups
+ */
+
+static const struct attribute_group *sifive_pl2_pmu_attr_grps[] = {
+	&sifive_pl2_pmu_format_group,
+	&sifive_pl2_pmu_events_group,
+	NULL,
+};
+
+/*
+ * Low-level functions: reading and writing counters
+ */
+
+static inline u64 read_counter(int idx)
+{
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+
+	if (WARN_ON_ONCE(idx < 0 || idx > ptr->counters))
+		return -EINVAL;
+
+	return readq(ptr->event_counter_base + idx * 8);
+}
+
+static inline void write_counter(int idx, u64 val)
+{
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+
+	writeq(val, ptr->event_counter_base + idx * 8);
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
+	int idx = hwc->idx;
+	u64 delta;
+
+	do {
+		prev_raw_count = local64_read(&hwc->prev_count);
+		new_raw_count = read_counter(idx);
+
+		oldval = local64_cmpxchg(&hwc->prev_count, prev_raw_count,
+					 new_raw_count);
+	} while (oldval != prev_raw_count);
+
+	/* delta is the value to update the counter we maintain in the kernel. */
+	delta = (new_raw_count - prev_raw_count) & SIFIVE_PL2_COUNTER_MASK;
+	local64_add(delta, &event->count);
+}
+
+/*
+ * State transition functions:
+ *
+ * stop()/start() & add()/del()
+ */
+
+/*
+ * pmu->stop: stop the counter
+ */
+static void sifive_pl2_pmu_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+
+	/* Disable this counter to count events */
+	writeq(0, ptr->event_select_base + (hwc->idx * 8));
+
+	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
+	hwc->state |= PERF_HES_STOPPED;
+
+	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
+		sifive_pl2_pmu_read(event);
+		hwc->state |= PERF_HES_UPTODATE;
+	}
+}
+
+/*
+ * pmu->start: start the event.
+ */
+static void sifive_pl2_pmu_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+
+	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
+		return;
+
+	if (flags & PERF_EF_RELOAD)
+		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));
+
+	hwc->state = 0;
+	perf_event_update_userpage(event);
+
+	/* Set initial value 0 */
+	local64_set(&hwc->prev_count, 0);
+	write_counter(hwc->idx, 0);
+
+	/* Enable counter to count these events */
+	writeq(hwc->config, ptr->event_select_base + (hwc->idx * 8));
+}
+
+/*
+ * pmu->add: add the event to PMU.
+ */
+static int sifive_pl2_pmu_add(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+	int idx;
+	u64 config = event->attr.config;
+	u64 set = config & 0xff;
+	u64 ev_type = config >> 8;
+
+	/* Check if this is a valid set and event. */
+	switch (set) {
+	case 1:
+		if (ev_type >= (BIT_ULL(PL2_PMU_MAX_EVENT1_IDX)))
+			return -ENOENT;
+		break;
+	case 2:
+		if (ev_type >= (BIT_ULL(PL2_PMU_MAX_EVENT2_IDX)))
+			return -ENOENT;
+		break;
+	case 3:
+		if (ev_type >= (BIT_ULL(PL2_PMU_MAX_EVENT3_IDX)))
+			return -ENOENT;
+		break;
+	case 4:
+		if (ev_type >= (BIT_ULL(PL2_PMU_MAX_EVENT4_IDX)))
+			return -ENOENT;
+		break;
+	case 0:
+	default:
+		return -ENOENT;
+	}
+
+	idx = find_first_zero_bit(ptr->used_mask, ptr->counters);
+	/* The counters are all in use. */
+	if (idx == ptr->counters)
+		return -EAGAIN;
+
+	set_bit(idx, ptr->used_mask);
+
+	/* Found an available counter idx for this event. */
+	hwc->idx = idx;
+	ptr->events[hwc->idx] = event;
+
+	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
+
+	if (flags & PERF_EF_START)
+		sifive_pl2_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+	return 0;
+}
+
+/*
+ * pmu->del: delete the event from PMU.
+ */
+static void sifive_pl2_pmu_del(struct perf_event *event, int flags)
+{
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Stop the counter and release this counter. */
+	ptr->events[hwc->idx] = NULL;
+	sifive_pl2_pmu_stop(event, PERF_EF_UPDATE);
+	clear_bit(hwc->idx, ptr->used_mask);
+	perf_event_update_userpage(event);
+}
+
+/*
+ * Event Initialization/Finalization
+ */
+
+static int sifive_pl2_pmu_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Don't allocate hw counter yet. */
+	hwc->idx = -1;
+	hwc->config = event->attr.config;
+
+	return 0;
+}
+
+/*
+ * Initialization
+ */
+
+static struct pmu sifive_pl2_generic_pmu = {
+	.name		= "sifive_pl2_pmu",
+	.task_ctx_nr	= perf_sw_context,
+	.event_init	= sifive_pl2_pmu_event_init,
+	.add		= sifive_pl2_pmu_add,
+	.del		= sifive_pl2_pmu_del,
+	.start		= sifive_pl2_pmu_start,
+	.stop		= sifive_pl2_pmu_stop,
+	.read		= sifive_pl2_pmu_read,
+	.attr_groups	= sifive_pl2_pmu_attr_grps,
+	.capabilities   = PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+};
+
+static struct sifive_pl2_pmu sifive_pl2_pmu = {
+	.pmu = &sifive_pl2_generic_pmu,
+};
+
+/*
+ *  PM notifer for suspend to ram
+ */
+#ifdef CONFIG_CPU_PM
+static int sifive_pl2_pmu_pm_notify(struct notifier_block *b, unsigned long cmd,
+				    void *v)
+{
+	struct sifive_pl2_pmu_event *ptr = this_cpu_ptr(&sifive_pl2_pmu_event);
+	struct perf_event *event;
+	int idx;
+	int enabled_event = bitmap_weight(ptr->used_mask, ptr->counters);
+
+	if (!enabled_event)
+		return NOTIFY_OK;
+
+	for (idx = 0; idx < ptr->counters; idx++) {
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
+			 /* Restore and enable the counter */
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
+static struct notifier_block sifive_pl2_pmu_pm_notifier_block = {
+	.notifier_call = sifive_pl2_pmu_pm_notify,
+};
+
+static inline void sifive_pl2_pmu_pm_init(void)
+{
+	cpu_pm_register_notifier(&sifive_pl2_pmu_pm_notifier_block);
+}
+
+#else
+static inline void sifive_pl2_pmu_pm_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
+int sifive_pl2_pmu_probe(struct device_node	*pl2_node,
+			 void __iomem *pl2_base, int cpu)
+{
+	struct sifive_pl2_pmu_event *ptr = per_cpu_ptr(&sifive_pl2_pmu_event, cpu);
+	int ret;
+
+	/* Get counter numbers. */
+	ret = of_property_read_u32(pl2_node, "sifive,perfmon-counters", &ptr->counters);
+	if (ret) {
+		pr_err("Not found sifive,perfmon-counters property\n");
+		return -EINVAL;
+	}
+	pr_info("perfmon-counters: %d for CPU %d\n", ptr->counters, cpu);
+
+	/* Allocate perf_event. */
+	ptr->events = kcalloc(ptr->counters, sizeof(struct perf_event), GFP_KERNEL);
+	if (!ptr->events)
+		return -ENOMEM;
+
+	ptr->event_select_base = pl2_base + SIFIVE_PL2_SELECT_BASE_OFFSET;
+	ptr->event_counter_base = pl2_base + SIFIVE_PL2_COUNTER_BASE_OFFSET;
+
+	if (!pl2pmu_init_done) {
+		ret = perf_pmu_register(sifive_pl2_pmu.pmu, sifive_pl2_pmu.pmu->name, -1);
+		if (ret) {
+			pr_err("Failed to register sifive_pl2_pmu.pmu: %d\n", ret);
+			return ret;
+		}
+		sifive_pl2_pmu_pm_init();
+		pl2pmu_init_done = true;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sifive_pl2_pmu_probe);
diff --git a/drivers/soc/sifive/sifive_pl2.h b/drivers/soc/sifive/sifive_pl2.h
index 9a5c9ee898bd..bc7e5f1da6e6 100644
--- a/drivers/soc/sifive/sifive_pl2.h
+++ b/drivers/soc/sifive/sifive_pl2.h
@@ -24,4 +24,6 @@ struct sifive_pl2_state {
 	u64 pmclientfilter;
 };
 
+int sifive_pl2_pmu_probe(struct device_node *pl2_node,
+			 void __iomem *pl2_base, int cpu);
 #endif /*_SIFIVE_PL2_H */
diff --git a/drivers/soc/sifive/sifive_pl2_cache.c b/drivers/soc/sifive/sifive_pl2_cache.c
index da2dc0eead74..1b9088e1766b 100644
--- a/drivers/soc/sifive/sifive_pl2_cache.c
+++ b/drivers/soc/sifive/sifive_pl2_cache.c
@@ -126,7 +126,7 @@ static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
 	struct sifive_pl2_state *pl2_state = NULL;
 	struct resource *res;
 	void __iomem *pl2_base;
-	int cpu;
+	int cpu, ret;
 
 	/* Traverse all cpu nodes to find the one mapping to its pl2 node. */
 	for_each_cpu(cpu, cpu_possible_mask) {
@@ -155,6 +155,14 @@ static int sifive_pl2_cache_dev_probe(struct platform_device *pdev)
 	pl2_config_read(pl2_base, cpu);
 	pl2_state->pl2_base = pl2_base;
 
+	if (IS_ENABLED(CONFIG_SIFIVE_PL2_PMU)) {
+		ret = sifive_pl2_pmu_probe(pl2_node, pl2_base, cpu);
+		if (ret) {
+			pr_err("Failed to probe sifive_pl2_pmu driver.\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.40.1

