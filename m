Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A14477A07A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjHLO0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjHLO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:26:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3D330EE;
        Sat, 12 Aug 2023 07:26:23 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CCqdNK031533;
        Sat, 12 Aug 2023 07:26:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=aTtHr+EmVgBLQGbicrLB7LOOpfNoWlyZZTVuFrUC8FY=;
 b=Ww6yU2ekUuJBnFepXoxM4SZ96crx3i1Ms2eZh1IrVqtIx1CEhi1e+aDepBqoLDhSkKhd
 eNTUvNYBHxTAlWTPVuLfMRRRbrak6uQImkn2solB+SCf0+E+5E1YIhSlYQwim98JPaxR
 uq5VByW3mqkNXSRY9VLUukzlTjgYEGKb90Ll+b/PVM0ZtPIrlYZ4R+d5Ao4VIEn7jlzL
 Kch/khKm2YqqSVVp5nSaYSpF28R/J4z/VMPBPIr2D/7e0ztbmgwvvhZ+gJe2fF98CNt5
 7KeIr3tkPv8B7i4sINlYDs9yML6TeHVt9nXiIn+NmZBzV4G7BxRES9suE4DLkFT2mAXB +A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3se7en0k3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 07:26:08 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 12 Aug
 2023 07:26:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sat, 12 Aug 2023 07:26:05 -0700
Received: from IPBU-BLR-SERVER1.marvell.com (IPBU-BLR-SERVER1.marvell.com [10.28.8.41])
        by maili.marvell.com (Postfix) with ESMTP id 1881E3F7041;
        Sat, 12 Aug 2023 07:26:01 -0700 (PDT)
From:   Gowthami Thiagarajan <gthiagarajan@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <bbhushan2@marvell.com>,
        <lcherian@marvell.com>,
        Gowthami Thiagarajan <gthiagarajan@marvell.com>
Subject: [PATCH v2 5/6] perf/marvell: Odyssey DDR Performance monitor support
Date:   Sat, 12 Aug 2023 19:55:17 +0530
Message-ID: <20230812142518.778259-6-gthiagarajan@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230812142518.778259-1-gthiagarajan@marvell.com>
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: rB0fFa6pGzzntXeJfnTobCnTUVGJn5iB
X-Proofpoint-ORIG-GUID: rB0fFa6pGzzntXeJfnTobCnTUVGJn5iB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_14,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odyssey DRAM Subsystem supports eight counters for monitoring performance
and software can program those counters to monitor any of the defined
performance events. Supported performance events include those counted
at the interface between the DDR controller and the PHY, interface between
the DDR Controller and the CHI interconnect, or within the DDR Controller.

Additionally DSS also supports two fixed performance event counters, one
for ddr reads and the other for ddr writes.

Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
---

v1->v2
-Fixed comment style and some indentations

 drivers/perf/marvell_cn10k_ddr_pmu.c | 435 ++++++++++++++++++++++-----
 1 file changed, 367 insertions(+), 68 deletions(-)

diff --git a/drivers/perf/marvell_cn10k_ddr_pmu.c b/drivers/perf/marvell_cn10k_ddr_pmu.c
index b94a5f6cc22b..3fed04bfab45 100644
--- a/drivers/perf/marvell_cn10k_ddr_pmu.c
+++ b/drivers/perf/marvell_cn10k_ddr_pmu.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
-/* Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
+/*
+ * Marvell CN10K DRAM Subsystem (DSS) Performance Monitor Driver
  *
  * Copyright (C) 2021 Marvell.
  */
@@ -15,24 +16,29 @@
 #include <linux/acpi.h>
 
 /* Performance Counters Operating Mode Control Registers */
-#define DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
-#define OP_MODE_CTRL_VAL_MANNUAL	0x1
+#define CN10K_DDRC_PERF_CNT_OP_MODE_CTRL	0x8020
+#define ODY_DDRC_PERF_CNT_OP_MODE_CTRL		0x20020
+#define OP_MODE_CTRL_VAL_MANUAL			0x1
 
 /* Performance Counters Start Operation Control Registers */
-#define DDRC_PERF_CNT_START_OP_CTRL	0x8028
-#define START_OP_CTRL_VAL_START		0x1ULL
-#define START_OP_CTRL_VAL_ACTIVE	0x2
+#define CN10K_DDRC_PERF_CNT_START_OP_CTRL	0x8028
+#define ODY_DDRC_PERF_CNT_START_OP_CTRL		0x200A0
+#define START_OP_CTRL_VAL_START			0x1ULL
+#define START_OP_CTRL_VAL_ACTIVE		0x2
 
 /* Performance Counters End Operation Control Registers */
-#define DDRC_PERF_CNT_END_OP_CTRL	0x8030
-#define END_OP_CTRL_VAL_END		0x1ULL
+#define CN10K_DDRC_PERF_CNT_END_OP_CTRL		0x8030
+#define ODY_DDRC_PERF_CNT_END_OP_CTRL		0x200E0
+#define END_OP_CTRL_VAL_END			0x1ULL
 
 /* Performance Counters End Status Registers */
-#define DDRC_PERF_CNT_END_STATUS		0x8038
+#define CN10K_DDRC_PERF_CNT_END_STATUS		0x8038
+#define ODY_DDRC_PERF_CNT_END_STATUS		0x20120
 #define END_STATUS_VAL_END_TIMER_MODE_END	0x1
 
 /* Performance Counters Configuration Registers */
-#define DDRC_PERF_CFG_BASE		0x8040
+#define CN10K_DDRC_PERF_CFG_BASE		0x8040
+#define ODY_DDRC_PERF_CFG_BASE			0x20160
 
 /* 8 Generic event counter + 2 fixed event counters */
 #define DDRC_PERF_NUM_GEN_COUNTERS	8
@@ -43,18 +49,28 @@
 					 DDRC_PERF_NUM_FIX_COUNTERS)
 
 /* Generic event counter registers */
-#define DDRC_PERF_CFG(n)		(DDRC_PERF_CFG_BASE + 8 * (n))
+#define DDRC_PERF_CFG(base, n)		((base) + 8 * (n))
 #define EVENT_ENABLE			BIT_ULL(63)
 
 /* Two dedicated event counters for DDR reads and writes */
 #define EVENT_DDR_READS			101
 #define EVENT_DDR_WRITES		100
 
+#define DDRC_PERF_REG(base, n)		((base) + 8 * (n))
 /*
  * programmable events IDs in programmable event counters.
  * DO NOT change these event-id numbers, they are used to
  * program event bitmap in h/w.
+ *
  */
+/* Additional programmable events defined in Odyssey */
+#define EVENT_DFI_CMD_IS_RETRY			61
+#define EVENT_RD_UC_ECC_ERROR			60
+#define EVENT_RD_CRC_ERROR			59
+#define EVENT_CAPAR_ERROR			58
+#define EVENT_WR_CRC_ERROR			57
+#define EVENT_DFI_PARITY_POISON			56
+
 #define EVENT_OP_IS_ZQLATCH			55
 #define EVENT_OP_IS_ZQSTART			54
 #define EVENT_OP_IS_TCR_MRR			53
@@ -64,8 +80,8 @@
 #define EVENT_VISIBLE_WIN_LIMIT_REACHED_RD	49
 #define EVENT_BSM_STARVATION			48
 #define EVENT_BSM_ALLOC				47
-#define EVENT_LPR_REQ_WITH_NOCREDIT		46
-#define EVENT_HPR_REQ_WITH_NOCREDIT		45
+#define EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED	46
+#define EVENT_DFI_OR_HPR_REQ_NOCRED		45
 #define EVENT_OP_IS_ZQCS			44
 #define EVENT_OP_IS_ZQCL			43
 #define EVENT_OP_IS_LOAD_MODE			42
@@ -103,28 +119,37 @@
 #define EVENT_HIF_RD_OR_WR			1
 
 /* Event counter value registers */
-#define DDRC_PERF_CNT_VALUE_BASE		0x8080
-#define DDRC_PERF_CNT_VALUE(n)	(DDRC_PERF_CNT_VALUE_BASE + 8 * (n))
+#define CN10K_DDRC_PERF_CNT_VALUE_BASE	0x8080
+#define ODY_DDRC_PERF_CNT_VALUE_BASE	0x201C0
 
 /* Fixed event counter enable/disable register */
-#define DDRC_PERF_CNT_FREERUN_EN	0x80C0
-#define DDRC_PERF_FREERUN_WRITE_EN	0x1
-#define DDRC_PERF_FREERUN_READ_EN	0x2
+#define CN10K_DDRC_PERF_CNT_FREERUN_EN		0x80C0
+#define DDRC_PERF_FREERUN_WRITE_EN		0x1
+#define DDRC_PERF_FREERUN_READ_EN		0x2
 
 /* Fixed event counter control register */
-#define DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
-#define DDRC_FREERUN_WRITE_CNT_CLR	0x1
-#define DDRC_FREERUN_READ_CNT_CLR	0x2
+#define CN10K_DDRC_PERF_CNT_FREERUN_CTRL	0x80C8
+#define ODY_DDRC_PERF_CNT_FREERUN_CTRL		0x20240
+#define DDRC_FREERUN_WRITE_CNT_CLR		0x1
+#define DDRC_FREERUN_READ_CNT_CLR		0x2
+
+/* Fixed event counter clear register, defined only for Odyssey */
+#define ODY_DDRC_PERF_CNT_FREERUN_CLR		0x20248
 
 /* Fixed event counter value register */
-#define DDRC_PERF_CNT_VALUE_WR_OP	0x80D0
-#define DDRC_PERF_CNT_VALUE_RD_OP	0x80D8
-#define DDRC_PERF_CNT_VALUE_OVERFLOW	BIT_ULL(48)
-#define DDRC_PERF_CNT_MAX_VALUE		GENMASK_ULL(48, 0)
+#define CN10K_DDRC_PERF_CNT_VALUE_WR_OP		0x80D0
+#define CN10K_DDRC_PERF_CNT_VALUE_RD_OP		0x80D8
+#define ODY_DDRC_PERF_CNT_VALUE_WR_OP		0x20250
+#define ODY_DDRC_PERF_CNT_VALUE_RD_OP		0x20258
+
+#define VERSION_V1				1
+#define VERSION_V2				2
 
 struct cn10k_ddr_pmu {
 	struct pmu pmu;
 	void __iomem *base;
+	struct ddr_pmu_platform_data *p_data;
+	int version;
 	unsigned int cpu;
 	struct	device *dev;
 	int active_events;
@@ -135,6 +160,54 @@ struct cn10k_ddr_pmu {
 
 #define to_cn10k_ddr_pmu(p)	container_of(p, struct cn10k_ddr_pmu, pmu)
 
+struct ddr_pmu_platform_data {
+	u64 counter_overflow_val;
+	u64 counter_max_val;
+	u64 ddrc_perf_cnt_base;
+	u64 ddrc_perf_cfg_base;
+	u64 ddrc_perf_cnt_op_mode_ctrl;
+	u64 ddrc_perf_cnt_start_op_ctrl;
+	u64 ddrc_perf_cnt_end_op_ctrl;
+	u64 ddrc_perf_cnt_end_status;
+	u64 ddrc_perf_cnt_freerun_en;
+	u64 ddrc_perf_cnt_freerun_ctrl;
+	u64 ddrc_perf_cnt_freerun_clr;
+	u64 ddrc_perf_cnt_value_wr_op;
+	u64 ddrc_perf_cnt_value_rd_op;
+};
+
+static const struct ddr_pmu_platform_data cn10k_ddr_pmu_pdata = {
+	.counter_overflow_val =  BIT_ULL(48),
+	.counter_max_val = GENMASK_ULL(48, 0),
+	.ddrc_perf_cnt_base = CN10K_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = CN10K_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = CN10K_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = CN10K_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = CN10K_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = CN10K_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = CN10K_DDRC_PERF_CNT_FREERUN_EN,
+	.ddrc_perf_cnt_freerun_ctrl = CN10K_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = 0,
+	.ddrc_perf_cnt_value_wr_op = CN10K_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = CN10K_DDRC_PERF_CNT_VALUE_RD_OP,
+};
+
+static const struct ddr_pmu_platform_data odyssey_ddr_pmu_pdata = {
+	.counter_overflow_val = 0,
+	.counter_max_val = GENMASK_ULL(63, 0),
+	.ddrc_perf_cnt_base = ODY_DDRC_PERF_CNT_VALUE_BASE,
+	.ddrc_perf_cfg_base = ODY_DDRC_PERF_CFG_BASE,
+	.ddrc_perf_cnt_op_mode_ctrl = ODY_DDRC_PERF_CNT_OP_MODE_CTRL,
+	.ddrc_perf_cnt_start_op_ctrl = ODY_DDRC_PERF_CNT_START_OP_CTRL,
+	.ddrc_perf_cnt_end_op_ctrl = ODY_DDRC_PERF_CNT_END_OP_CTRL,
+	.ddrc_perf_cnt_end_status = ODY_DDRC_PERF_CNT_END_STATUS,
+	.ddrc_perf_cnt_freerun_en = 0,
+	.ddrc_perf_cnt_freerun_ctrl = ODY_DDRC_PERF_CNT_FREERUN_CTRL,
+	.ddrc_perf_cnt_freerun_clr = ODY_DDRC_PERF_CNT_FREERUN_CLR,
+	.ddrc_perf_cnt_value_wr_op = ODY_DDRC_PERF_CNT_VALUE_WR_OP,
+	.ddrc_perf_cnt_value_rd_op = ODY_DDRC_PERF_CNT_VALUE_RD_OP,
+};
+
 static ssize_t cn10k_ddr_pmu_event_show(struct device *dev,
 					struct device_attribute *attr,
 					char *page)
@@ -190,9 +263,9 @@ static struct attribute *cn10k_ddr_perf_events_attrs[] = {
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpr_req_with_nocredit,
-					EVENT_HPR_REQ_WITH_NOCREDIT),
+				 EVENT_DFI_OR_HPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpr_req_with_nocredit,
-					EVENT_LPR_REQ_WITH_NOCREDIT),
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
 	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
@@ -215,6 +288,85 @@ static struct attribute_group cn10k_ddr_perf_events_attr_group = {
 	.attrs = cn10k_ddr_perf_events_attrs,
 };
 
+static struct attribute *odyssey_ddr_perf_events_attrs[] = {
+	/* Programmable */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_or_wr_access, EVENT_HIF_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_wr_access, EVENT_HIF_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rd_access, EVENT_HIF_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_rmw_access, EVENT_HIF_RMW),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hif_pri_rdaccess, EVENT_HIF_HI_PRI_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_bypass_access, EVENT_READ_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_act_bypass_access, EVENT_ACT_BYPASS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_wr_data_access,
+				 EVENT_DFI_WR_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_rd_data_access,
+				 EVENT_DFI_RD_DATA_CYCLES),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_hpri_sched_rd_crit_access,
+				 EVENT_HPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_lpri_sched_rd_crit_access,
+				 EVENT_LPR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_trxn_crit_access,
+				 EVENT_WR_XACT_WHEN_CRITICAL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_active_access, EVENT_OP_IS_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_or_wr_access,
+				 EVENT_OP_IS_RD_OR_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_rd_active_access,
+				 EVENT_OP_IS_RD_ACTIVATE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_read, EVENT_OP_IS_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_write, EVENT_OP_IS_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_mwr, EVENT_OP_IS_MWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge, EVENT_OP_IS_PRECHARGE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_rdwr,
+				 EVENT_PRECHARGE_FOR_RDWR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_precharge_for_other,
+				 EVENT_PRECHARGE_FOR_OTHER),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rdwr_transitions, EVENT_RDWR_TRANSITIONS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_write_combine, EVENT_WRITE_COMBINE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_war_hazard, EVENT_WAR_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_raw_hazard, EVENT_RAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_waw_hazard, EVENT_WAW_HAZARD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_selfref, EVENT_OP_IS_ENTER_SELFREF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_powerdown,
+				 EVENT_OP_IS_ENTER_POWERDOWN),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_enter_mpsm, EVENT_OP_IS_ENTER_MPSM),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_refresh, EVENT_OP_IS_REFRESH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_crit_ref, EVENT_OP_IS_CRIT_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_spec_ref, EVENT_OP_IS_SPEC_REF),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_load_mode, EVENT_OP_IS_LOAD_MODE),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqcl, EVENT_OP_IS_ZQCL),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_cam_wr_access, EVENT_OP_IS_ZQCS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cycles, EVENT_DFI_OR_HPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_retry_fifo_full,
+				 EVENT_RETRY_FIFO_FULL_OR_LPR_REQ_NOCRED),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_alloc, EVENT_BSM_ALLOC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_bsm_starvation, EVENT_BSM_STARVATION),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_rd,
+					EVENT_VISIBLE_WIN_LIMIT_REACHED_RD),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_win_limit_reached_wr,
+					EVENT_VISIBLE_WIN_LIMIT_REACHED_WR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mpc, EVENT_OP_IS_DQSOSC_MPC),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dqsosc_mrr, EVENT_OP_IS_DQSOSC_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_tcr_mrr, EVENT_OP_IS_TCR_MRR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqstart, EVENT_OP_IS_ZQSTART),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_zqlatch, EVENT_OP_IS_ZQLATCH),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_parity_poison,
+				 EVENT_DFI_PARITY_POISON),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_wr_crc_error, EVENT_WR_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_capar_error, EVENT_CAPAR_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_crc_error, EVENT_RD_CRC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_rd_uc_ecc_error, EVENT_RD_UC_ECC_ERROR),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_dfi_cmd_is_retry, EVENT_DFI_CMD_IS_RETRY),
+	/* Free run event counters */
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_reads, EVENT_DDR_READS),
+	CN10K_DDR_PMU_EVENT_ATTR(ddr_ddr_writes, EVENT_DDR_WRITES),
+	NULL
+};
+
+static struct attribute_group odyssey_ddr_perf_events_attr_group = {
+	.name = "events",
+	.attrs = odyssey_ddr_perf_events_attrs,
+};
+
 PMU_FORMAT_ATTR(event, "config:0-8");
 
 static struct attribute *cn10k_ddr_perf_format_attrs[] = {
@@ -255,6 +407,13 @@ static const struct attribute_group *cn10k_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *odyssey_attr_groups[] = {
+	&odyssey_ddr_perf_events_attr_group,
+	&cn10k_ddr_perf_format_attr_group,
+	&cn10k_ddr_perf_cpumask_attr_group,
+	NULL
+};
+
 /* Default poll timeout is 100 sec, which is very sufficient for
  * 48 bit counter incremented max at 5.6 GT/s, which may take many
  * hours to overflow.
@@ -267,13 +426,24 @@ static ktime_t cn10k_ddr_pmu_timer_period(void)
 	return ms_to_ktime((u64)cn10k_ddr_pmu_poll_period_sec * USEC_PER_SEC);
 }
 
-static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
+static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap,
+				     struct cn10k_ddr_pmu *ddr_pmu)
 {
+	int ret = 0;
+
 	switch (eventid) {
 	case EVENT_HIF_RD_OR_WR ... EVENT_WAW_HAZARD:
 	case EVENT_OP_IS_REFRESH ... EVENT_OP_IS_ZQLATCH:
 		*event_bitmap = (1ULL << (eventid - 1));
 		break;
+	case EVENT_DFI_PARITY_POISON ...EVENT_DFI_CMD_IS_RETRY:
+		if (ddr_pmu->version == VERSION_V2) {
+			*event_bitmap = (1ULL << (eventid - 1));
+		} else {
+			pr_err("%s Invalid eventid %d\n", __func__, eventid);
+			ret = -EINVAL;
+		}
+		break;
 	case EVENT_OP_IS_ENTER_SELFREF:
 	case EVENT_OP_IS_ENTER_POWERDOWN:
 	case EVENT_OP_IS_ENTER_MPSM:
@@ -281,10 +451,10 @@ static int ddr_perf_get_event_bitmap(int eventid, u64 *event_bitmap)
 		break;
 	default:
 		pr_err("%s Invalid eventid %d\n", __func__, eventid);
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int cn10k_ddr_perf_alloc_counter(struct cn10k_ddr_pmu *pmu,
@@ -357,6 +527,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 {
 	u32 reg;
 	u64 val;
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 
 	if (counter > DDRC_PERF_NUM_COUNTERS) {
 		pr_err("Error: unsupported counter %d\n", counter);
@@ -364,7 +535,7 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 	}
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
-		reg = DDRC_PERF_CFG(counter);
+		reg = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
 		val = readq_relaxed(pmu->base + reg);
 
 		if (enable)
@@ -374,7 +545,13 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 
 		writeq_relaxed(val, pmu->base + reg);
 	} else {
-		val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+		if (p_data->ddrc_perf_cnt_freerun_en)
+			val = readq_relaxed(pmu->base +
+					    p_data->ddrc_perf_cnt_freerun_en);
+		else
+			val = readq_relaxed(pmu->base +
+					    p_data->ddrc_perf_cnt_freerun_ctrl);
+
 		if (enable) {
 			if (counter == DDRC_PERF_READ_COUNTER_IDX)
 				val |= DDRC_PERF_FREERUN_READ_EN;
@@ -386,7 +563,13 @@ static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
 			else
 				val &= ~DDRC_PERF_FREERUN_WRITE_EN;
 		}
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
+
+		if (p_data->ddrc_perf_cnt_freerun_en)
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_en);
+		else
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_ctrl);
 	}
 }
 
@@ -394,13 +577,18 @@ static u64 cn10k_ddr_perf_read_counter(struct cn10k_ddr_pmu *pmu, int counter)
 {
 	u64 val;
 
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
+
 	if (counter == DDRC_PERF_READ_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_rd_op);
 
 	if (counter == DDRC_PERF_WRITE_COUNTER_IDX)
-		return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_WR_OP);
+		return readq_relaxed(pmu->base +
+				     p_data->ddrc_perf_cnt_value_wr_op);
 
-	val = readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE(counter));
+	val = readq_relaxed(pmu->base +
+			    DDRC_PERF_REG(p_data->ddrc_perf_cnt_base, counter));
 	return val;
 }
 
@@ -408,6 +596,7 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	u64 prev_count, new_count, mask;
 
 	do {
@@ -415,20 +604,48 @@ static void cn10k_ddr_perf_event_update(struct perf_event *event)
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 	} while (local64_xchg(&hwc->prev_count, new_count) != prev_count);
 
-	mask = DDRC_PERF_CNT_MAX_VALUE;
+	mask = p_data->counter_max_val;
 
 	local64_add((new_count - prev_count) & mask, &event->count);
 }
 
+static void cn10k_ddr_perf_counter_start(struct cn10k_ddr_pmu *ddr_pmu,
+					 int counter)
+{
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_start_op_ctrl;
+
+	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
+static void cn10k_ddr_perf_counter_stop(struct cn10k_ddr_pmu *ddr_pmu,
+					int counter)
+{
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
+	u64 ctrl_reg = p_data->ddrc_perf_cnt_end_op_ctrl;
+
+	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
+		       DDRC_PERF_REG(ctrl_reg, counter));
+}
+
 static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 	int counter = hwc->idx;
+	u64 ctrl_reg = pmu->p_data->ddrc_perf_cnt_op_mode_ctrl;
 
 	local64_set(&hwc->prev_count, 0);
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, true);
+	if (pmu->version == VERSION_V2) {
+	/* Setup the PMU counter to work in manual mode */
+		writeq_relaxed(OP_MODE_CTRL_VAL_MANUAL, pmu->base +
+			       DDRC_PERF_REG(ctrl_reg, counter));
+
+		cn10k_ddr_perf_counter_start(pmu, counter);
+	}
 
 	hwc->state = 0;
 }
@@ -436,6 +653,7 @@ static void cn10k_ddr_perf_event_start(struct perf_event *event, int flags)
 static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct cn10k_ddr_pmu *pmu = to_cn10k_ddr_pmu(event->pmu);
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct hw_perf_event *hwc = &event->hw;
 	u8 config = event->attr.config;
 	int counter, ret;
@@ -455,8 +673,8 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 
 	if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
 		/* Generic counters, configure event id */
-		reg_offset = DDRC_PERF_CFG(counter);
-		ret = ddr_perf_get_event_bitmap(config, &val);
+		reg_offset = DDRC_PERF_CFG(p_data->ddrc_perf_cfg_base, counter);
+		ret = ddr_perf_get_event_bitmap(config, &val, pmu);
 		if (ret)
 			return ret;
 
@@ -468,7 +686,12 @@ static int cn10k_ddr_perf_event_add(struct perf_event *event, int flags)
 		else
 			val = DDRC_FREERUN_WRITE_CNT_CLR;
 
-		writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
+		if (p_data->ddrc_perf_cnt_freerun_clr)
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_clr);
+		else
+			writeq_relaxed(val, pmu->base +
+				       p_data->ddrc_perf_cnt_freerun_ctrl);
 	}
 
 	hwc->state |= PERF_HES_STOPPED;
@@ -487,6 +710,9 @@ static void cn10k_ddr_perf_event_stop(struct perf_event *event, int flags)
 
 	cn10k_ddr_perf_counter_enable(pmu, counter, false);
 
+	if (pmu->version == VERSION_V2)
+		cn10k_ddr_perf_counter_stop(pmu, counter);
+
 	if (flags & PERF_EF_UPDATE)
 		cn10k_ddr_perf_event_update(event);
 
@@ -513,17 +739,19 @@ static void cn10k_ddr_perf_event_del(struct perf_event *event, int flags)
 static void cn10k_ddr_perf_pmu_enable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
-		       DDRC_PERF_CNT_START_OP_CTRL);
+		       p_data->ddrc_perf_cnt_start_op_ctrl);
 }
 
 static void cn10k_ddr_perf_pmu_disable(struct pmu *pmu)
 {
 	struct cn10k_ddr_pmu *ddr_pmu = to_cn10k_ddr_pmu(pmu);
+	struct ddr_pmu_platform_data *p_data = ddr_pmu->p_data;
 
 	writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
-		       DDRC_PERF_CNT_END_OP_CTRL);
+		       p_data->ddrc_perf_cnt_end_op_ctrl);
 }
 
 static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
@@ -550,6 +778,7 @@ static void cn10k_ddr_perf_event_update_all(struct cn10k_ddr_pmu *pmu)
 
 static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 {
+	struct ddr_pmu_platform_data *p_data = pmu->p_data;
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 prev_count, new_count;
@@ -562,7 +791,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		prev_count = local64_read(&hwc->prev_count);
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 
-		/* Overflow condition is when new count less than
+		/*
+		 * Overflow condition is when new count less than
 		 * previous count
 		 */
 		if (new_count < prev_count)
@@ -575,7 +805,8 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 		prev_count = local64_read(&hwc->prev_count);
 		new_count = cn10k_ddr_perf_read_counter(pmu, hwc->idx);
 
-		/* Overflow condition is when new count less than
+		/*
+		 * Overflow condition is when new count less than
 		 * previous count
 		 */
 		if (new_count < prev_count)
@@ -587,11 +818,23 @@ static irqreturn_t cn10k_ddr_pmu_overflow_handler(struct cn10k_ddr_pmu *pmu)
 			continue;
 
 		value = cn10k_ddr_perf_read_counter(pmu, i);
-		if (value == DDRC_PERF_CNT_MAX_VALUE) {
+		if (value == p_data->counter_max_val) {
 			pr_info("Counter-(%d) reached max value\n", i);
-			cn10k_ddr_perf_event_update_all(pmu);
-			cn10k_ddr_perf_pmu_disable(&pmu->pmu);
-			cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			/*
+			 * As separate control register is added for each
+			 * counter in odyssey, no need to update all
+			 * the events
+			 */
+			if (pmu->version == VERSION_V2) {
+				cn10k_ddr_perf_event_update(pmu->events[i]);
+				cn10k_ddr_perf_counter_stop(pmu, i);
+				cn10k_ddr_perf_counter_start(pmu, i);
+
+			} else {
+				cn10k_ddr_perf_event_update_all(pmu);
+				cn10k_ddr_perf_pmu_disable(&pmu->pmu);
+				cn10k_ddr_perf_pmu_enable(&pmu->pmu);
+			}
 		}
 	}
 
@@ -632,7 +875,10 @@ static int cn10k_ddr_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
 
 static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 {
+	struct ddr_pmu_platform_data *pltfm_data;
+	struct device *dev = &pdev->dev;
 	struct cn10k_ddr_pmu *ddr_pmu;
+	const char  *compatible;
 	struct resource *res;
 	void __iomem *base;
 	char *name;
@@ -643,6 +889,14 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ddr_pmu->dev = &pdev->dev;
+
+	pltfm_data = (struct ddr_pmu_platform_data *)
+		      device_get_match_data(&pdev->dev);
+	if (!pltfm_data) {
+		dev_err(&pdev->dev, "Error: No device match data found\n");
+		return -ENODEV;
+	}
+	ddr_pmu->p_data = pltfm_data;
 	platform_set_drvdata(pdev, ddr_pmu);
 
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
@@ -651,25 +905,59 @@ static int cn10k_ddr_perf_probe(struct platform_device *pdev)
 
 	ddr_pmu->base = base;
 
-	/* Setup the PMU counter to work in manual mode */
-	writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
-		       DDRC_PERF_CNT_OP_MODE_CTRL);
-
-	ddr_pmu->pmu = (struct pmu) {
-		.module	      = THIS_MODULE,
-		.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
-		.task_ctx_nr = perf_invalid_context,
-		.attr_groups = cn10k_attr_groups,
-		.event_init  = cn10k_ddr_perf_event_init,
-		.add	     = cn10k_ddr_perf_event_add,
-		.del	     = cn10k_ddr_perf_event_del,
-		.start	     = cn10k_ddr_perf_event_start,
-		.stop	     = cn10k_ddr_perf_event_stop,
-		.read	     = cn10k_ddr_perf_event_update,
-		.pmu_enable  = cn10k_ddr_perf_pmu_enable,
-		.pmu_disable = cn10k_ddr_perf_pmu_disable,
-	};
+	ret = device_property_read_string(dev, "compatible", &compatible);
+	if (ret) {
+		pr_err("compatible property not found\n");
+		return ret;
+	}
+
+	if ((strncmp("marvell,cn10k-ddr-pmu", compatible,
+		     strlen(compatible)) == 0))
+		ddr_pmu->version = VERSION_V1;
+	else
+		ddr_pmu->version = VERSION_V2;
+
+	if (ddr_pmu->version == VERSION_V1) {
+		ddr_pmu->pmu = (struct pmu) {
+			.module	      = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = cn10k_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add	     = cn10k_ddr_perf_event_add,
+			.del	     = cn10k_ddr_perf_event_del,
+			.start	     = cn10k_ddr_perf_event_start,
+			.stop	     = cn10k_ddr_perf_event_stop,
+			.read	     = cn10k_ddr_perf_event_update,
+			.pmu_enable  = cn10k_ddr_perf_pmu_enable,
+			.pmu_disable = cn10k_ddr_perf_pmu_disable,
+		};
+
+	/*
+	 * As we have separate control registers for each counter in Odyssey,
+	 * setting up the mode will be done when we enable each counter
+	 *
+	 */
 
+	/* Setup the PMU counter to work in manual mode */
+		writeq(OP_MODE_CTRL_VAL_MANUAL, ddr_pmu->base +
+		      (ddr_pmu->p_data->ddrc_perf_cnt_op_mode_ctrl));
+	} else {
+		ddr_pmu->pmu = (struct pmu) {
+			.module       = THIS_MODULE,
+			.capabilities = PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr = perf_invalid_context,
+			.attr_groups = odyssey_attr_groups,
+			.event_init  = cn10k_ddr_perf_event_init,
+			.add         = cn10k_ddr_perf_event_add,
+			.del         = cn10k_ddr_perf_event_del,
+			.start       = cn10k_ddr_perf_event_start,
+			.stop        = cn10k_ddr_perf_event_stop,
+			.read        = cn10k_ddr_perf_event_update,
+			.pmu_enable  = NULL,
+			.pmu_disable = NULL,
+		};
+	}
 	/* Choose this cpu to collect perf data */
 	ddr_pmu->cpu = raw_smp_processor_id();
 
@@ -712,7 +1000,10 @@ static int cn10k_ddr_perf_remove(struct platform_device *pdev)
 
 #ifdef CONFIG_OF
 static const struct of_device_id cn10k_ddr_pmu_of_match[] = {
-	{ .compatible = "marvell,cn10k-ddr-pmu", },
+	{ .compatible = "marvell,cn10k-ddr-pmu",
+	  .data = &cn10k_ddr_pmu_pdata },
+	{ .compatible = "marvell,odyssey-ddr-pmu",
+	  .data = &odyssey_ddr_pmu_pdata },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
@@ -720,7 +1011,14 @@ MODULE_DEVICE_TABLE(of, cn10k_ddr_pmu_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id cn10k_ddr_pmu_acpi_match[] = {
-	{"MRVL000A", 0},
+	{
+		.id = "MRVL000A",
+		.driver_data = (kernel_ulong_t)&cn10k_ddr_pmu_pdata,
+	},
+	{
+		.id = "MRVL000C",
+		.driver_data = (kernel_ulong_t)&odyssey_ddr_pmu_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, cn10k_ddr_pmu_acpi_match);
@@ -752,6 +1050,7 @@ static int __init cn10k_ddr_pmu_init(void)
 	if (ret)
 		cpuhp_remove_multi_state(
 				CPUHP_AP_PERF_ARM_MARVELL_CN10K_DDR_ONLINE);
+
 	return ret;
 }
 
-- 
2.25.1

