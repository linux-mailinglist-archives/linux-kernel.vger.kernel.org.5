Return-Path: <linux-kernel+bounces-148215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 900348A7F6D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BA11F221D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BB412C490;
	Wed, 17 Apr 2024 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V0xVi65/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0A1350FA;
	Wed, 17 Apr 2024 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713345295; cv=none; b=PjLp2s82PoJ+3xgvtAlzQWha/6BW4V1lvQZdU9mdm4izyLve2wDlTVClrkobHBAN/l3fmZeSW8yOFiAYf894QPly6LdHMrlIfN3fHP+2lpO6SoX08V0x21UzEEfQuyTTiGqa3QlYrlBn7q7jyzso/a0FjjobZhi/jUKqhdOFLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713345295; c=relaxed/simple;
	bh=iH7lIckySb87ZWozzRX2hB3qwJEfr5HosqlPjWrcJrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofOgo/ps1D9duIi6nfYe6wKDs9BXALhm/MTldXFfO4sl9jgrzwq2vmLVYNJ0zN++bIgOTkPFaLUXuVLQOxhEDw9x4CIyaCabT3pBDhBR9yFTxWN3i0tRRKYMQ4i3UtJYP4eGlUVyrqfyeyH98NJ5+z63bpWxDsam9CtrAO0s/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V0xVi65/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713345291;
	bh=iH7lIckySb87ZWozzRX2hB3qwJEfr5HosqlPjWrcJrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V0xVi65/wxT0XY+e3Ql4FYfIURniYB7ziPmIqlZ+TzdeSuPdL6Z3uNnwzF2oYS/63
	 BwwIBTDTvY3+ZMySliLNFrluSePwr4z7vUDHIT1S/huP3DzcsErxAqzHfJ0LCbeVrj
	 W+x99jV6SL2YI0MVxzWzJHk/Iq+N25CVr5yWRksj+v+4U74QaLx0UOrNzsd05phhDv
	 cT9RC+YKGOyccIaMPGVeCK/2N+b6Md0pn9F05tGrGDyvt1/lWXqSEWpFzQAz/yd5bQ
	 X33R8MpdPncPEndPdfQtyPNp7VqJw6OzzImC+anMcr020fxopBom8xN8g1dk8pee5c
	 3FIsPfT+UemVw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6B23F3782146;
	Wed, 17 Apr 2024 09:14:50 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: djakov@kernel.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	keescook@chromium.org,
	gustavoars@kernel.org,
	henryc.chen@mediatek.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	wenst@chromium.org,
	amergnat@baylibre.com,
	Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH v2 4/7] soc: mediatek: Add MediaTek DVFS Resource Collector (DVFSRC) driver
Date: Wed, 17 Apr 2024 11:14:39 +0200
Message-ID: <20240417091442.170505-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
References: <20240417091442.170505-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
Hardware module used to collect all the requests from both software and the
various remote processors embedded into the SoC and decide about a minimum
operating voltage and a minimum DRAM frequency to fulfill those requests in
an effort to provide the best achievable performance per watt.

This hardware IP is capable of transparently performing direct register R/W
on all of the DVFSRC-controlled regulators and SoC bandwidth knobs.

This driver includes support for MT8183, MT8192 and MT8195.

Co-Developed-by: Dawei Chien <dawei.chien@mediatek.com>
[Angelo: Partial refactoring and cleanups]
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/Kconfig             |  11 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c        | 551 +++++++++++++++++++++++
 include/linux/soc/mediatek/dvfsrc.h      |  36 ++
 include/linux/soc/mediatek/mtk_sip_svc.h |   3 +
 5 files changed, 602 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 include/linux/soc/mediatek/dvfsrc.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 1b7afb19ccd6..d7293977f06e 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -26,6 +26,17 @@ config MTK_DEVAPC
 	  The violation information is logged for further analysis or
 	  countermeasures.
 
+config MTK_DVFSRC
+	tristate "MediaTek DVFSRC Support"
+	depends on ARCH_MEDIATEK
+	help
+	  Say yes here to add support for the MediaTek Dynamic Voltage
+	  and Frequency Scaling Resource Collector (DVFSRC): a HW
+	  IP found on many MediaTek SoCs, which is responsible for
+	  collecting DVFS requests from various SoC IPs, other than
+	  software, and performing bandwidth scaling to provide the
+	  best achievable performance-per-watt.
+
 config MTK_INFRACFG
 	bool "MediaTek INFRACFG Support"
 	select REGMAP
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 6830512848fd..0665573e3c4b 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
+obj-$(CONFIG_MTK_DVFSRC) += mtk-dvfsrc.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
diff --git a/drivers/soc/mediatek/mtk-dvfsrc.c b/drivers/soc/mediatek/mtk-dvfsrc.c
new file mode 100644
index 000000000000..8c9e21ec23de
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-dvfsrc.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/mediatek/dvfsrc.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+
+/* DVFSRC_LEVEL */
+#define DVFSRC_V1_LEVEL_TARGET_LEVEL	GENMASK(15, 0)
+#define DVFSRC_TGT_LEVEL_IDLE		0x00
+#define DVFSRC_V1_LEVEL_CURRENT_LEVEL	GENMASK(31, 16)
+
+/* DVFSRC_SW_REQ, DVFSRC_SW_REQ2 */
+#define DVFSRC_V1_SW_REQ2_DRAM_LEVEL	GENMASK(1, 0)
+#define DVFSRC_V1_SW_REQ2_VCORE_LEVEL	GENMASK(3, 2)
+
+#define DVFSRC_V2_SW_REQ_DRAM_LEVEL	GENMASK(3, 0)
+#define DVFSRC_V2_SW_REQ_VCORE_LEVEL	GENMASK(6, 4)
+
+/* DVFSRC_VCORE */
+#define DVFSRC_V2_VCORE_REQ_VSCP_LEVEL	GENMASK(14, 12)
+
+#define KBPS_TO_MBPS(x)			((x) / 1000)
+
+#define DVFSRC_POLL_TIMEOUT_US		1000
+#define STARTUP_TIME_US			1
+
+#define MTK_SIP_DVFSRC_INIT		0x0
+#define MTK_SIP_DVFSRC_START		0x1
+
+struct dvfsrc_bw_constraints {
+	u16 max_dram_nom_bw;
+	u16 max_dram_peak_bw;
+	u16 max_dram_hrt_bw;
+};
+
+struct dvfsrc_opp {
+	u32 vcore_opp;
+	u32 dram_opp;
+};
+
+struct dvfsrc_opp_desc {
+	const struct dvfsrc_opp *opps;
+	u32 num_opp;
+};
+
+struct dvfsrc_soc_data;
+struct mtk_dvfsrc {
+	struct device *dev;
+	struct platform_device *icc;
+	struct platform_device *regulator;
+	const struct dvfsrc_soc_data *dvd;
+	const struct dvfsrc_opp_desc *curr_opps;
+	void __iomem *regs;
+	int dram_type;
+};
+
+struct dvfsrc_soc_data {
+	const int *regs;
+	const struct dvfsrc_opp_desc *opps_desc;
+	u32 (*get_target_level)(struct mtk_dvfsrc *dvfsrc);
+	u32 (*get_current_level)(struct mtk_dvfsrc *dvfsrc);
+	u32 (*get_vcore_level)(struct mtk_dvfsrc *dvfsrc);
+	u32 (*get_vscp_level)(struct mtk_dvfsrc *dvfsrc);
+	void (*set_dram_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
+	void (*set_dram_peak_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
+	void (*set_dram_hrt_bw)(struct mtk_dvfsrc *dvfsrc, u64 bw);
+	void (*set_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
+	void (*set_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
+	void (*set_vscp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
+	int (*wait_for_opp_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
+	int (*wait_for_vcore_level)(struct mtk_dvfsrc *dvfsrc, u32 level);
+	const struct dvfsrc_bw_constraints *bw_constraints;
+};
+
+static u32 dvfsrc_readl(struct mtk_dvfsrc *dvfs, u32 offset)
+{
+	return readl(dvfs->regs + dvfs->dvd->regs[offset]);
+}
+
+static void dvfsrc_writel(struct mtk_dvfsrc *dvfs, u32 offset, u32 val)
+{
+	writel(val, dvfs->regs + dvfs->dvd->regs[offset]);
+}
+
+#define dvfsrc_rmw(dvfs, offset, val, mask, shift) \
+	dvfsrc_writel(dvfs, offset, \
+		(dvfsrc_readl(dvfs, offset) & ~(mask << shift)) | (val << shift))
+
+enum dvfsrc_regs {
+	DVFSRC_SW_REQ,
+	DVFSRC_SW_REQ2,
+	DVFSRC_LEVEL,
+	DVFSRC_TARGET_LEVEL,
+	DVFSRC_SW_BW,
+	DVFSRC_SW_PEAK_BW,
+	DVFSRC_SW_HRT_BW,
+	DVFSRC_VCORE,
+	DVFSRC_REGS_MAX,
+};
+
+static const int dvfsrc_mt8183_regs[] = {
+	[DVFSRC_SW_REQ] = 0x4,
+	[DVFSRC_SW_REQ2] = 0x8,
+	[DVFSRC_LEVEL] = 0xDC,
+	[DVFSRC_SW_BW] = 0x160,
+};
+
+static const int dvfsrc_mt8195_regs[] = {
+	[DVFSRC_SW_REQ] = 0xc,
+	[DVFSRC_VCORE] = 0x6c,
+	[DVFSRC_SW_PEAK_BW] = 0x278,
+	[DVFSRC_SW_BW] = 0x26c,
+	[DVFSRC_SW_HRT_BW] = 0x290,
+	[DVFSRC_LEVEL] = 0xd44,
+	[DVFSRC_TARGET_LEVEL] = 0xd48,
+};
+
+static const struct dvfsrc_opp *dvfsrc_get_current_opp(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 level = dvfsrc->dvd->get_current_level(dvfsrc);
+
+	return &dvfsrc->curr_opps->opps[level];
+}
+
+static bool dvfsrc_is_idle(struct mtk_dvfsrc *dvfsrc)
+{
+	if (!dvfsrc->dvd->get_target_level)
+		return true;
+
+	return dvfsrc->dvd->get_target_level(dvfsrc) == DVFSRC_TGT_LEVEL_IDLE;
+}
+
+static int dvfsrc_wait_for_vcore_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	const struct dvfsrc_opp *curr;
+
+	return readx_poll_timeout_atomic(dvfsrc_get_current_opp, dvfsrc, curr,
+					 curr->vcore_opp >= level, STARTUP_TIME_US,
+					 DVFSRC_POLL_TIMEOUT_US);
+}
+
+static int dvfsrc_wait_for_opp_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	const struct dvfsrc_opp *target, *curr;
+	int ret;
+
+	target = &dvfsrc->curr_opps->opps[level];
+	ret = readx_poll_timeout_atomic(dvfsrc_get_current_opp, dvfsrc, curr,
+					curr->dram_opp >= target->dram_opp &&
+					curr->vcore_opp >= target->vcore_opp,
+					STARTUP_TIME_US, DVFSRC_POLL_TIMEOUT_US);
+	if (ret < 0) {
+		dev_warn(dvfsrc->dev,
+			 "timeout! target OPP: %u, dram: %d, vcore: %d\n", level,
+			 curr->dram_opp, curr->vcore_opp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dvfsrc_wait_for_opp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	const struct dvfsrc_opp *target, *curr;
+	int ret;
+
+	target = &dvfsrc->curr_opps->opps[level];
+	ret = readx_poll_timeout_atomic(dvfsrc_get_current_opp, dvfsrc, curr,
+					curr->dram_opp >= target->dram_opp &&
+					curr->vcore_opp >= target->vcore_opp,
+					STARTUP_TIME_US, DVFSRC_POLL_TIMEOUT_US);
+	if (ret < 0) {
+		dev_warn(dvfsrc->dev,
+			 "timeout! target OPP: %u, dram: %d\n", level, curr->dram_opp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static u32 dvfsrc_get_target_level_v1(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_LEVEL);
+
+	return FIELD_GET(DVFSRC_V1_LEVEL_TARGET_LEVEL, val);
+}
+
+static u32 dvfsrc_get_current_level_v1(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_LEVEL);
+	u32 current_level = FIELD_GET(DVFSRC_V1_LEVEL_CURRENT_LEVEL, val);
+
+	return ffs(current_level) - 1;
+}
+
+static u32 dvfsrc_get_target_level_v2(struct mtk_dvfsrc *dvfsrc)
+{
+	return dvfsrc_readl(dvfsrc, DVFSRC_TARGET_LEVEL);
+}
+
+static u32 dvfsrc_get_current_level_v2(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_LEVEL);
+	u32 level = ffs(val);
+
+	/* Valid levels */
+	if (level < dvfsrc->curr_opps->num_opp)
+		return dvfsrc->curr_opps->num_opp - level;
+
+	/* Zero for level 0 or invalid level */
+	return 0;
+}
+
+static u32 dvfsrc_get_vcore_level_v1(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ2);
+
+	return FIELD_GET(DVFSRC_V1_SW_REQ2_VCORE_LEVEL, val);
+}
+
+static void dvfsrc_set_vcore_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ2);
+
+	val &= ~DVFSRC_V1_SW_REQ2_VCORE_LEVEL;
+	val |= FIELD_PREP(DVFSRC_V1_SW_REQ2_VCORE_LEVEL, level);
+
+	dvfsrc_writel(dvfsrc, DVFSRC_SW_REQ2, val);
+}
+
+static u32 dvfsrc_get_vcore_level_v2(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ);
+
+	return FIELD_GET(DVFSRC_V2_SW_REQ_VCORE_LEVEL, val);
+}
+
+static void dvfsrc_set_vcore_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_SW_REQ);
+
+	val &= ~DVFSRC_V2_SW_REQ_VCORE_LEVEL;
+	val |= FIELD_PREP(DVFSRC_V2_SW_REQ_VCORE_LEVEL, level);
+
+	dvfsrc_writel(dvfsrc, DVFSRC_SW_REQ, val);
+}
+
+static u32 dvfsrc_get_vscp_level_v2(struct mtk_dvfsrc *dvfsrc)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_VCORE);
+
+	return FIELD_GET(DVFSRC_V2_VCORE_REQ_VSCP_LEVEL, val);
+}
+
+static void dvfsrc_set_vscp_level_v2(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	u32 val = dvfsrc_readl(dvfsrc, DVFSRC_VCORE);
+
+	val &= ~DVFSRC_V2_VCORE_REQ_VSCP_LEVEL;
+	val |= FIELD_PREP(DVFSRC_V2_VCORE_REQ_VSCP_LEVEL, level);
+
+	dvfsrc_writel(dvfsrc, DVFSRC_VCORE, val);
+}
+
+static void __dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u32 reg,
+				    u16 max_bw, u16 min_bw, u64 bw)
+{
+	u32 new_bw = (u32)div_u64(KBPS_TO_MBPS(bw), 100);
+
+	/* If bw constraints (in mbps) are defined make sure to respect them */
+	if (max_bw)
+		new_bw = min(new_bw, max_bw);
+	if (min_bw && new_bw > 0)
+		new_bw = max(new_bw, min_bw);
+
+	dvfsrc_writel(dvfsrc, reg, new_bw);
+}
+
+static void dvfsrc_set_dram_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_nom_bw;
+
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_BW, max_bw, 0, bw);
+};
+
+static void dvfsrc_set_dram_peak_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_peak_bw;
+
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_PEAK_BW, max_bw, 0, bw);
+}
+
+static void dvfsrc_set_dram_hrt_bw_v1(struct mtk_dvfsrc *dvfsrc, u64 bw)
+{
+	u64 max_bw = dvfsrc->dvd->bw_constraints->max_dram_hrt_bw;
+
+	__dvfsrc_set_dram_bw_v1(dvfsrc, DVFSRC_SW_HRT_BW, max_bw, 0, bw);
+}
+
+static void dvfsrc_set_opp_level_v1(struct mtk_dvfsrc *dvfsrc, u32 level)
+{
+	const struct dvfsrc_opp *opp = &dvfsrc->curr_opps->opps[level];
+	u32 val;
+
+	/* Translate Pstate to DVFSRC level and set it to DVFSRC HW */
+	val = FIELD_PREP(DVFSRC_V1_SW_REQ2_DRAM_LEVEL, opp->dram_opp);
+	val |= FIELD_PREP(DVFSRC_V1_SW_REQ2_VCORE_LEVEL, opp->vcore_opp);
+
+	dev_dbg(dvfsrc->dev, "vcore_opp: %d, dram_opp: %d\n", opp->vcore_opp, opp->dram_opp);
+	dvfsrc_writel(dvfsrc, DVFSRC_SW_REQ, val);
+}
+
+int mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)
+{
+	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
+	bool state;
+	int ret;
+
+	dev_dbg(dvfsrc->dev, "cmd: %d, data: %llu\n", cmd, data);
+
+	switch (cmd) {
+	case MTK_DVFSRC_CMD_BW:
+		dvfsrc->dvd->set_dram_bw(dvfsrc, data);
+		return 0;
+	case MTK_DVFSRC_CMD_HRT_BW:
+		if (dvfsrc->dvd->set_dram_hrt_bw)
+			dvfsrc->dvd->set_dram_hrt_bw(dvfsrc, data);
+		return 0;
+	case MTK_DVFSRC_CMD_PEAK_BW:
+		if (dvfsrc->dvd->set_dram_peak_bw)
+			dvfsrc->dvd->set_dram_peak_bw(dvfsrc, data);
+		return 0;
+	case MTK_DVFSRC_CMD_OPP:
+		if (!dvfsrc->dvd->set_opp_level)
+			return 0;
+
+		dvfsrc->dvd->set_opp_level(dvfsrc, data);
+		break;
+	case MTK_DVFSRC_CMD_VCORE_LEVEL:
+		dvfsrc->dvd->set_vcore_level(dvfsrc, data);
+		break;
+	case MTK_DVFSRC_CMD_VSCP_LEVEL:
+		if (!dvfsrc->dvd->set_vscp_level)
+			return 0;
+
+		dvfsrc->dvd->set_vscp_level(dvfsrc, data);
+		break;
+	default:
+		dev_err(dvfsrc->dev, "unknown command: %d\n", cmd);
+		return -EOPNOTSUPP;
+	}
+
+	/* DVFSRC needs at least 2T(~196ns) to handle a request */
+	udelay(STARTUP_TIME_US);
+
+	ret = readx_poll_timeout_atomic(dvfsrc_is_idle, dvfsrc, state, state,
+					STARTUP_TIME_US, DVFSRC_POLL_TIMEOUT_US);
+	if (ret < 0) {
+		dev_warn(dvfsrc->dev,
+			 "%d: idle timeout, data: %llu, last: %d -> %d\n", cmd, data,
+			 dvfsrc->dvd->get_current_level(dvfsrc),
+			 dvfsrc->dvd->get_target_level(dvfsrc));
+		return ret;
+	}
+
+	if (cmd == MTK_DVFSRC_CMD_OPP)
+		ret = dvfsrc->dvd->wait_for_opp_level(dvfsrc, data);
+	else
+		ret = dvfsrc->dvd->wait_for_vcore_level(dvfsrc, data);
+
+	if (ret < 0) {
+		dev_warn(dvfsrc->dev,
+			 "%d: wait timeout, data: %llu, last: %d -> %d\n",
+			 cmd, data,
+			 dvfsrc->dvd->get_current_level(dvfsrc),
+			 dvfsrc->dvd->get_target_level(dvfsrc));
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_dvfsrc_send_request);
+
+int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd, int *data)
+{
+	struct mtk_dvfsrc *dvfsrc = dev_get_drvdata(dev);
+
+	switch (cmd) {
+	case MTK_DVFSRC_CMD_VCORE_LEVEL:
+		*data = dvfsrc->dvd->get_vcore_level(dvfsrc);
+		break;
+	case MTK_DVFSRC_CMD_VSCP_LEVEL:
+		*data = dvfsrc->dvd->get_vscp_level(dvfsrc);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_dvfsrc_query_info);
+
+static int mtk_dvfsrc_probe(struct platform_device *pdev)
+{
+	struct arm_smccc_res ares;
+	struct mtk_dvfsrc *dvfsrc;
+	int ret;
+
+	dvfsrc = devm_kzalloc(&pdev->dev, sizeof(*dvfsrc), GFP_KERNEL);
+	if (!dvfsrc)
+		return -ENOMEM;
+
+	dvfsrc->dvd = of_device_get_match_data(&pdev->dev);
+	dvfsrc->dev = &pdev->dev;
+
+	dvfsrc->regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(dvfsrc->regs))
+		return PTR_ERR(dvfsrc->regs);
+
+	arm_smccc_smc(MTK_SIP_DVFSRC_VCOREFS_CONTROL, MTK_SIP_DVFSRC_INIT,
+		      0, 0, 0, 0, 0, 0, &ares);
+	if (ares.a0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "DVFSRC init failed: %lu\n", ares.a0);
+
+	dvfsrc->dram_type = ares.a1;
+	dev_dbg(&pdev->dev, "DRAM Type: %d\n", dvfsrc->dram_type);
+
+	dvfsrc->curr_opps = &dvfsrc->dvd->opps_desc[dvfsrc->dram_type];
+	platform_set_drvdata(pdev, dvfsrc);
+
+	ret = devm_of_platform_populate(&pdev->dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to populate child devices\n");
+
+	/* Everything is set up - make it run! */
+	arm_smccc_smc(MTK_SIP_DVFSRC_VCOREFS_CONTROL, MTK_SIP_DVFSRC_START,
+		      0, 0, 0, 0, 0, 0, &ares);
+	if (ares.a0)
+		return dev_err_probe(&pdev->dev, -EINVAL, "Cannot start DVFSRC: %lu\n", ares.a0);
+
+	return 0;
+}
+
+static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp4[] = {
+	{ 0, 0 }, { 0, 1 }, { 0, 2 }, { 1, 2 },
+};
+
+static const struct dvfsrc_opp dvfsrc_opp_mt8183_lp3[] = {
+	{ 0, 0 }, { 0, 1 }, { 1, 1 }, { 1, 2 },
+};
+
+static const struct dvfsrc_opp_desc dvfsrc_opp_mt8183_desc[] = {
+	[0] = {
+		.opps = dvfsrc_opp_mt8183_lp4,
+		.num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp4),
+	},
+	[1] = {
+		.opps = dvfsrc_opp_mt8183_lp3,
+		.num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp3),
+	},
+	[2] = {
+		.opps = dvfsrc_opp_mt8183_lp3,
+		.num_opp = ARRAY_SIZE(dvfsrc_opp_mt8183_lp3),
+	}
+};
+
+static const struct dvfsrc_bw_constraints dvfsrc_bw_constr_mt8183 = { 0, 0, 0 };
+
+static const struct dvfsrc_soc_data mt8183_data = {
+	.opps_desc = dvfsrc_opp_mt8183_desc,
+	.regs = dvfsrc_mt8183_regs,
+	.get_target_level = dvfsrc_get_target_level_v1,
+	.get_current_level = dvfsrc_get_current_level_v1,
+	.get_vcore_level = dvfsrc_get_vcore_level_v1,
+	.set_dram_bw = dvfsrc_set_dram_bw_v1,
+	.set_opp_level = dvfsrc_set_opp_level_v1,
+	.set_vcore_level = dvfsrc_set_vcore_level_v1,
+	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v1,
+	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v1,
+	.bw_constraints = &dvfsrc_bw_constr_mt8183,
+};
+
+static const struct dvfsrc_opp dvfsrc_opp_mt8195_lp4[] = {
+	{ 0, 0 }, { 1, 0 }, { 2, 0 }, { 3, 0 },
+	{ 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 },
+	{ 0, 2 }, { 1, 2 }, { 2, 2 }, { 3, 2 },
+	{ 1, 3 }, { 2, 3 }, { 3, 3 }, { 1, 4 },
+	{ 2, 4 }, { 3, 4 }, { 2, 5 }, { 3, 5 },
+	{ 3, 6 },
+};
+
+static const struct dvfsrc_opp_desc dvfsrc_opp_mt8195_desc[] = {
+	[0] = {
+		.opps = dvfsrc_opp_mt8195_lp4,
+		.num_opp = ARRAY_SIZE(dvfsrc_opp_mt8195_lp4),
+	}
+};
+
+static const struct dvfsrc_bw_constraints dvfsrc_bw_constr_mt8195 = {
+	.max_dram_nom_bw = 255,
+	.max_dram_peak_bw = 255,
+	.max_dram_hrt_bw = 1023,
+};
+
+static const struct dvfsrc_soc_data mt8195_data = {
+	.opps_desc = dvfsrc_opp_mt8195_desc,
+	.regs = dvfsrc_mt8195_regs,
+	.get_target_level = dvfsrc_get_target_level_v2,
+	.get_current_level = dvfsrc_get_current_level_v2,
+	.get_vcore_level = dvfsrc_get_vcore_level_v2,
+	.get_vscp_level = dvfsrc_get_vscp_level_v2,
+	.set_dram_bw = dvfsrc_set_dram_bw_v1,
+	.set_dram_peak_bw = dvfsrc_set_dram_peak_bw_v1,
+	.set_dram_hrt_bw = dvfsrc_set_dram_hrt_bw_v1,
+	.set_vcore_level = dvfsrc_set_vcore_level_v2,
+	.set_vscp_level = dvfsrc_set_vscp_level_v2,
+	.wait_for_opp_level = dvfsrc_wait_for_opp_level_v2,
+	.wait_for_vcore_level = dvfsrc_wait_for_vcore_level_v1,
+	.bw_constraints = &dvfsrc_bw_constr_mt8195,
+};
+
+static const struct of_device_id mtk_dvfsrc_of_match[] = {
+	{ .compatible = "mediatek,mt8183-dvfsrc", .data = &mt8183_data },
+	{ .compatible = "mediatek,mt8195-dvfsrc", .data = &mt8195_data },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver mtk_dvfsrc_driver = {
+	.probe	= mtk_dvfsrc_probe,
+	.driver = {
+		.name = "mtk-dvfsrc",
+		.of_match_table = mtk_dvfsrc_of_match,
+	},
+};
+module_platform_driver(mtk_dvfsrc_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Dawei Chien <dawei.chien@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek DVFSRC driver");
diff --git a/include/linux/soc/mediatek/dvfsrc.h b/include/linux/soc/mediatek/dvfsrc.h
new file mode 100644
index 000000000000..b4579969cd6b
--- /dev/null
+++ b/include/linux/soc/mediatek/dvfsrc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __MEDIATEK_DVFSRC_H
+#define __MEDIATEK_DVFSRC_H
+
+enum mtk_dvfsrc_cmd {
+	MTK_DVFSRC_CMD_BW,
+	MTK_DVFSRC_CMD_HRT_BW,
+	MTK_DVFSRC_CMD_PEAK_BW,
+	MTK_DVFSRC_CMD_OPP,
+	MTK_DVFSRC_CMD_VCORE_LEVEL,
+	MTK_DVFSRC_CMD_VSCP_LEVEL,
+	MTK_DVFSRC_CMD_MAX,
+};
+
+#ifdef CONFIG_MTK_DVFSRC
+
+int mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data);
+int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd, int *data);
+
+#else
+
+static inline int mtk_dvfsrc_send_request(const struct device *dev, u32 cmd, u64 data)
+{ return -ENODEV; }
+
+static inline int mtk_dvfsrc_query_info(const struct device *dev, u32 cmd, int *data)
+{ return -ENODEV; }
+
+#endif /* CONFIG_MTK_DVFSRC */
+
+#endif
diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
index 0761128b4354..abe24a73ee19 100644
--- a/include/linux/soc/mediatek/mtk_sip_svc.h
+++ b/include/linux/soc/mediatek/mtk_sip_svc.h
@@ -22,6 +22,9 @@
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
 			   ARM_SMCCC_OWNER_SIP, fn_id)
 
+/* DVFSRC SMC calls */
+#define MTK_SIP_DVFSRC_VCOREFS_CONTROL	MTK_SIP_SMC_CMD(0x506)
+
 /* IOMMU related SMC call */
 #define MTK_SIP_KERNEL_IOMMU_CONTROL	MTK_SIP_SMC_CMD(0x514)
 
-- 
2.44.0


