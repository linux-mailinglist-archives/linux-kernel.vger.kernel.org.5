Return-Path: <linux-kernel+bounces-131426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 735078987B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE2A1C27153
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A36F13441C;
	Thu,  4 Apr 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsE9+6Wq"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61C134406
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233639; cv=none; b=K3f/BSx2nHm18OqM3uyVuUKDSgIyxeKUjPq4HfksTGnkGthVQvEiDnyv9iKCbrgDJ1JwGb/uL+HiNmcBqYU8V9kp0xFkeuqLMuJsHRq9eN7Cm7JCFnG9pVrJAPcbZv6ZyHwU81A6/TE3Nrd64lI3D2ju5mRglD+keS8krJrsLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233639; c=relaxed/simple;
	bh=f4a6X59r6o3Bx9Zi1RDVHWdMkdCFHga1R1Kdv58+SNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9GXEHysVsKPnHzPgCNkTWve35/gYrq+bfgAF1K+MKU4EMMCs6uRrVYJJJDHyMtR5hdRjLt0hAgQNjA2DFiKV1I6ZKe890LK+6bLxxhnSuVTbjQUevAS79rcrKDYxuSHyh198o286gbxPQnMJz75ziIieviolx3WDQSCq/bydZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsE9+6Wq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4155baa696eso6582805e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712233636; x=1712838436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3JcSOQ9eNIxg70eEgWDHynCCbG7M8BkHlyC7Pm2TPg=;
        b=AsE9+6WqmdzkoEJEMe+FJGKFh5P+s91SlN5tGJtCCcq2MrLv/aFLyJtSZuiLxoWvLV
         rl4OIP9+7d/FSHZmI8moXaXGzjkHZSTmIMlvdEBfsmWNkwpa8n6sPjkLYwVcfkqhwUVW
         TcCPdHcVmAdqQlzbzC2gZgiYRR8Mrxio9Q+RUYwHllz1T8L4pBf3IAIL0dICnZPlxdrd
         Tc9C3NYlPZv8mONka3+4n0IKbc4wQlDzHJOCLlwq/NHLoQKVHbDKmFsdEqZA4IFqK8b4
         f9fQ87N7Aaab98opqSYkcWtUtfP511LDH8/0jOvIMYgsrgmgJIH02USDwmHNI3DIaMYw
         4BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233636; x=1712838436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3JcSOQ9eNIxg70eEgWDHynCCbG7M8BkHlyC7Pm2TPg=;
        b=KQf43lED6NdNJ9Mb26W3ogQ73mrKyeGrIazUMyhiKpqx8T1ecYmJjkXKhEBIwDOGu2
         OJ48YM0LjDi5OmIzZz7WTGChc/aSxmeSi6iFj04SBegTQ81zdEv/VPS7H0S0FR5Fzu2g
         PYg6VfnwuPJm9YASOWd4OpipRPNt/X0Z0fWMkCepWKmnvLzjw/kd7COVw0as3FiD1Sl4
         ISVZbHw8jGyTPklDB9NQv6kGRCkqzIiU2j8DEMsLJmUh48D64KWUKgoIffkp5Xi/q/15
         z1Xtry4jwBJYD7Q3jhAjnOJ3RiZclrDi5K0W+bixaqSgXdTjBZRXW1UUylHbLhtGqZ1j
         weVg==
X-Forwarded-Encrypted: i=1; AJvYcCW2RUBDmIcWfhCAdqpdnCpOgfA01Q5/wqiXsJF0OB2eqRlUFfjl9D44PFf3VFjXNovY4iToM2CK08P2TG1XpJRPS2l0OVINxbZDU+H/
X-Gm-Message-State: AOJu0YxyvSmdO2FHjX/YDHWINAI0R2ZYptPzNJqRfBatOc3+sKVLczoT
	wNuEGEvdE4kqQoj1+nJMqInGOBbyi8Ck7sk5rThwAd4NXdjBd52vnYHJEnPnm0Y=
X-Google-Smtp-Source: AGHT+IGvDcqiJLkbp5Wt7EHODgO9xmJRsJl8Dm7BikRVLAkTFvIbG0ZaoB6MyTPMSzHJY3e/AcsZhA==
X-Received: by 2002:a05:600c:2342:b0:416:217e:c1b4 with SMTP id 2-20020a05600c234200b00416217ec1b4mr1832453wmq.23.1712233635929;
        Thu, 04 Apr 2024 05:27:15 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([148.252.128.204])
        by smtp.gmail.com with ESMTPSA id bu14-20020a056000078e00b003434b41c83fsm12106303wrb.81.2024.04.04.05.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 05:27:13 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	chanho61.park@samsung.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 11/17] phy: samsung-ufs: ufs: Add support for gs101 UFS phy tuning
Date: Thu,  4 Apr 2024 13:25:53 +0100
Message-ID: <20240404122559.898930-12-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404122559.898930-1-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the m-phy tuning values for gs101 UFS phy and SoC callbacks
gs101_phy_wait_for_calibration() and gs101_phy_wait_for_cdr_lock().

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/samsung/Makefile          |   1 +
 drivers/phy/samsung/phy-gs101-ufs.c   | 182 ++++++++++++++++++++++++++
 drivers/phy/samsung/phy-samsung-ufs.c |   3 +
 drivers/phy/samsung/phy-samsung-ufs.h |   1 +
 4 files changed, 187 insertions(+)
 create mode 100644 drivers/phy/samsung/phy-gs101-ufs.c

diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
index afb34a153e34..fea1f96d0e43 100644
--- a/drivers/phy/samsung/Makefile
+++ b/drivers/phy/samsung/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
 obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)	+= phy-exynos-mipi-video.o
 obj-$(CONFIG_PHY_EXYNOS_PCIE)		+= phy-exynos-pcie.o
 obj-$(CONFIG_PHY_SAMSUNG_UFS)		+= phy-exynos-ufs.o
+phy-exynos-ufs-y			+= phy-gs101-ufs.o
 phy-exynos-ufs-y			+= phy-samsung-ufs.o
 phy-exynos-ufs-y			+= phy-exynos7-ufs.o
 phy-exynos-ufs-y			+= phy-exynosautov9-ufs.o
diff --git a/drivers/phy/samsung/phy-gs101-ufs.c b/drivers/phy/samsung/phy-gs101-ufs.c
new file mode 100644
index 000000000000..17b798da5b57
--- /dev/null
+++ b/drivers/phy/samsung/phy-gs101-ufs.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UFS PHY driver data for Google Tensor gs101 SoC
+ *
+ * Copyright (C) 2024 Linaro Ltd
+ * Author: Peter Griffin <peter.griffin@linaro.org>
+ */
+
+#include "phy-samsung-ufs.h"
+
+#define TENSOR_GS101_PHY_CTRL		0x3ec8
+#define TENSOR_GS101_PHY_CTRL_MASK	0x1
+#define TENSOR_GS101_PHY_CTRL_EN	BIT(0)
+#define PHY_GS101_LANE_OFFSET		0x200
+#define TRSV_REG338			0x338
+#define LN0_MON_RX_CAL_DONE		BIT(3)
+#define TRSV_REG339			0x339
+#define LN0_MON_RX_CDR_FLD_CK_MODE_DONE BIT(3)
+#define TRSV_REG222			0x222
+#define LN0_OVRD_RX_CDR_EN		BIT(4)
+#define LN0_RX_CDR_EN			BIT(3)
+
+#define PHY_PMA_TRSV_ADDR(reg, lane)	(PHY_APB_ADDR((reg) + \
+					((lane) * PHY_GS101_LANE_OFFSET)))
+
+#define PHY_TRSV_REG_CFG_GS101(o, v, d) \
+	PHY_TRSV_REG_CFG_OFFSET(o, v, d, PHY_GS101_LANE_OFFSET)
+
+/* Calibration for phy initialization */
+static const struct samsung_ufs_phy_cfg tensor_gs101_pre_init_cfg[] = {
+	PHY_COMN_REG_CFG(0x43, 0x10,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x3C, 0x14,  PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x46, 0x48,  PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x200, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x201, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x202, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x203, 0x0a, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x204, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x205, 0x11, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x207, 0x0c, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2E1, 0xc0, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x22D, 0xb8, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x234, 0x60, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x238, 0x13, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x239, 0x48, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23A, 0x01, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23B, 0x25, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23C, 0x2a, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23D, 0x01, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23E, 0x13, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x23F, 0x13, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x240, 0x4a, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x243, 0x40, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x244, 0x02, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x25D, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x25E, 0x3f, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x25F, 0xff, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x273, 0x33, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x274, 0x50, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x284, 0x02, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x285, 0x02, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2A2, 0x04, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x25D, 0x01, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2FA, 0x01, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x286, 0x03, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x287, 0x03, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x288, 0x03, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x289, 0x03, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2B3, 0x04, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2B6, 0x0b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2B7, 0x0b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2B8, 0x0b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2B9, 0x0b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2BA, 0x0b, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2BB, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2BC, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2BD, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x29E, 0x06, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2E4, 0x1a, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2ED, 0x25, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x269, 0x1a, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x2F4, 0x2f, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x34B, 0x01, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x34C, 0x23, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x34D, 0x23, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x34E, 0x45, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x34F, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x350, 0x31, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x351, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x352, 0x02, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x353, 0x00, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x354, 0x01, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x43, 0x18, PWR_MODE_ANY),
+	PHY_COMN_REG_CFG(0x43, 0x00, PWR_MODE_ANY),
+	END_UFS_PHY_CFG,
+};
+
+static const struct samsung_ufs_phy_cfg tensor_gs101_pre_pwr_hs_config[] = {
+	PHY_TRSV_REG_CFG_GS101(0x369, 0x11, PWR_MODE_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x03, PWR_MODE_ANY),
+};
+
+/* Calibration for HS mode series A/B */
+static const struct samsung_ufs_phy_cfg tensor_gs101_post_pwr_hs_config[] = {
+	PHY_COMN_REG_CFG(0x8, 0x60, PWR_MODE_PWM_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x222, 0x08, PWR_MODE_PWM_ANY),
+	PHY_TRSV_REG_CFG_GS101(0x246, 0x01, PWR_MODE_ANY),
+	END_UFS_PHY_CFG,
+};
+
+static const struct samsung_ufs_phy_cfg *tensor_gs101_ufs_phy_cfgs[CFG_TAG_MAX] = {
+	[CFG_PRE_INIT]		= tensor_gs101_pre_init_cfg,
+	[CFG_PRE_PWR_HS]	= tensor_gs101_pre_pwr_hs_config,
+	[CFG_POST_PWR_HS]	= tensor_gs101_post_pwr_hs_config,
+};
+
+static const char * const tensor_gs101_ufs_phy_clks[] = {
+	"ref_clk",
+};
+
+static int gs101_phy_wait_for_calibration(struct phy *phy, u8 lane)
+{
+	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
+	const unsigned int timeout_us = 40000;
+	const unsigned int sleep_us = 40;
+	u32 val;
+	u32 off;
+	int err;
+
+	off = PHY_PMA_TRSV_ADDR(TRSV_REG338, lane);
+
+	err = readl_poll_timeout(ufs_phy->reg_pma + off,
+				 val, (val & LN0_MON_RX_CAL_DONE),
+				 sleep_us, timeout_us);
+
+	if (err) {
+		dev_err(ufs_phy->dev,
+			"failed to get phy cal done %d\n", err);
+	}
+
+	return err;
+}
+
+#define DELAY_IN_US	40
+#define RETRY_CNT	100
+static int gs101_phy_wait_for_cdr_lock(struct phy *phy, u8 lane)
+{
+	struct samsung_ufs_phy *ufs_phy = get_samsung_ufs_phy(phy);
+	u32 val;
+	int i;
+
+	for (i = 0; i < RETRY_CNT; i++) {
+		udelay(DELAY_IN_US);
+		val = readl(ufs_phy->reg_pma +
+			    PHY_PMA_TRSV_ADDR(TRSV_REG339, lane));
+
+		if (val & LN0_MON_RX_CDR_FLD_CK_MODE_DONE)
+			return 0;
+
+		udelay(DELAY_IN_US);
+		/* Override and enable clock data recovery */
+		writel(LN0_OVRD_RX_CDR_EN, ufs_phy->reg_pma +
+		       PHY_PMA_TRSV_ADDR(TRSV_REG222, lane));
+		writel(LN0_OVRD_RX_CDR_EN | LN0_RX_CDR_EN,
+		       ufs_phy->reg_pma + PHY_PMA_TRSV_ADDR(TRSV_REG222, lane));
+	}
+	dev_err(ufs_phy->dev, "failed to get cdr lock\n");
+	return -ETIMEDOUT;
+}
+
+const struct samsung_ufs_phy_drvdata tensor_gs101_ufs_phy = {
+	.cfgs = tensor_gs101_ufs_phy_cfgs,
+	.isol = {
+		.offset = TENSOR_GS101_PHY_CTRL,
+		.mask = TENSOR_GS101_PHY_CTRL_MASK,
+		.en = TENSOR_GS101_PHY_CTRL_EN,
+	},
+	.clk_list = tensor_gs101_ufs_phy_clks,
+	.num_clks = ARRAY_SIZE(tensor_gs101_ufs_phy_clks),
+	.wait_for_cal = gs101_phy_wait_for_calibration,
+	.wait_for_cdr = gs101_phy_wait_for_cdr_lock,
+};
diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index f57a2f2a415d..813bce47121d 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -310,6 +310,9 @@ static int samsung_ufs_phy_probe(struct platform_device *pdev)
 
 static const struct of_device_id samsung_ufs_phy_match[] = {
 	{
+		.compatible = "google,gs101-ufs-phy",
+		.data = &tensor_gs101_ufs_phy,
+	}, {
 		.compatible = "samsung,exynos7-ufs-phy",
 		.data = &exynos7_ufs_phy,
 	}, {
diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/phy-samsung-ufs.h
index 7de6b574b94d..9b7deef6e10f 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.h
+++ b/drivers/phy/samsung/phy-samsung-ufs.h
@@ -147,5 +147,6 @@ int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy, u8 lane);
 extern const struct samsung_ufs_phy_drvdata exynos7_ufs_phy;
 extern const struct samsung_ufs_phy_drvdata exynosautov9_ufs_phy;
 extern const struct samsung_ufs_phy_drvdata fsd_ufs_phy;
+extern const struct samsung_ufs_phy_drvdata tensor_gs101_ufs_phy;
 
 #endif /* _PHY_SAMSUNG_UFS_ */
-- 
2.44.0.478.gd926399ef9-goog


