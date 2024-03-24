Return-Path: <linux-kernel+bounces-113445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8680888463
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086431C23B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B710F13AD2C;
	Sun, 24 Mar 2024 22:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0ZNXi0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8C13AD15;
	Sun, 24 Mar 2024 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320246; cv=none; b=Hgc0EUIFHACCCJNy5v544cZkr4Mb2RmFE8sT4hBDldpM11hD2wgn9FWrt+jdVqZK9Cs2lDNGpOZ43GObsWIOZs+jOB+nA0k/cf5abRPSTj7CAQ7lNsqOxko8MkDYzyj/0t/x1tE4CUlr+V5azAL0vGDDGeVA7nyxubCS8/tnaMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320246; c=relaxed/simple;
	bh=mN5mjGnNuZ7gDkFtRQKDdrZdUImsHtrYEv/9w/QBvfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYyW0ulTlM1Ais3jQkEqjPW75cGOazymvpSfxsa6mEgJIAhnCIMUrMR4vGUQb9RUrFC+Y785lhJlQKnYd1dbtG+j4XdxcTk7MHOQIBZawR7bGds0KmCsN2tKwdrD9TBX50/uWOTJ4DcLHFZQ4MRfKXxYvFGU5npQcuqTUMXoBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0ZNXi0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26544C433F1;
	Sun, 24 Mar 2024 22:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320246;
	bh=mN5mjGnNuZ7gDkFtRQKDdrZdUImsHtrYEv/9w/QBvfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0ZNXi0KAXs1hYO+EsSXTGVSa+PPtg+hNUVu76wq3S8WVceVsFUH7G7Fteg4fOUPn
	 USyWMzVFUCP+QtMjR/iTK1xxnqvEg812+OySz0q1jlFe4njq37UZqBSVbQ4YZOE5eM
	 jx3zHgY8boj8zlfwhWntGHcY5DId52jkfRgaFzyHSv2HN5nF8QaCfQ309f31j/a6yK
	 9ZEVxuMbtQDh8LC8gJj7An0+w273ss/WKcW4d/KXCPSIgHijSbO9MRFJ9p9FeI/2wB
	 FpxBIHxxj0qMCuqfUS8jZY0bKXVRSfcyqwub2zKOc9nnHUb1+v5U5yICET+IYOuGAC
	 s8KzMYJpAkR/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 554/715] phy: qcom: qmp-usbc: add support for the Type-C handling
Date: Sun, 24 Mar 2024 18:32:13 -0400
Message-ID: <20240324223455.1342824-555-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit dfdaba27b4660ec26de955cf4459499ddb005e2d ]

The USB-C PHYs on the msm8998, QCM2290 and SM6115 platforms use special
register to control which lanes of the Type-C port are used for the
SuperSpeed USB connection. Mimic the qmp-combo driver and handle this
register.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240113-pmi632-typec-v2-12-182d9aa0a5b3@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Stable-dep-of: 01b086ccdeff ("phy: qcom: qmp-usbc: handle CLAMP register in a correct way")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-usbc.c | 97 +++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
index 52f1b3f7b81eb..214cf4203de41 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-usbc.c
@@ -18,6 +18,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/usb/typec.h>
+#include <linux/usb/typec_mux.h>
 
 #include "phy-qcom-qmp.h"
 #include "phy-qcom-qmp-pcs-misc-v3.h"
@@ -374,11 +376,17 @@ struct qmp_usbc {
 	struct reset_control_bulk_data *resets;
 	struct regulator_bulk_data *vregs;
 
+	struct mutex phy_mutex;
+
 	enum phy_mode mode;
+	unsigned int usb_init_count;
 
 	struct phy *phy;
 
 	struct clk_fixed_rate pipe_clk_fixed;
+
+	struct typec_switch_dev *sw;
+	enum typec_orientation orientation;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -497,6 +505,7 @@ static int qmp_usbc_init(struct phy *phy)
 	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
 	void __iomem *pcs = qmp->pcs;
+	u32 val = 0;
 	int ret;
 
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
@@ -523,6 +532,14 @@ static int qmp_usbc_init(struct phy *phy)
 
 	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
 
+#define SW_PORTSELECT_VAL			BIT(0)
+#define SW_PORTSELECT_MUX			BIT(1)
+	/* Use software based port select and switch on typec orientation */
+	val = SW_PORTSELECT_MUX;
+	if (qmp->orientation == TYPEC_ORIENTATION_REVERSE)
+		val |= SW_PORTSELECT_VAL;
+	writel(val, qmp->pcs_misc);
+
 	return 0;
 
 err_assert_reset:
@@ -620,23 +637,34 @@ static int qmp_usbc_power_off(struct phy *phy)
 
 static int qmp_usbc_enable(struct phy *phy)
 {
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	int ret;
 
+	mutex_lock(&qmp->phy_mutex);
+
 	ret = qmp_usbc_init(phy);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	ret = qmp_usbc_power_on(phy);
-	if (ret)
+	if (ret) {
 		qmp_usbc_exit(phy);
+		goto out_unlock;
+	}
+
+	qmp->usb_init_count++;
+out_unlock:
+	mutex_unlock(&qmp->phy_mutex);
 
 	return ret;
 }
 
 static int qmp_usbc_disable(struct phy *phy)
 {
+	struct qmp_usbc *qmp = phy_get_drvdata(phy);
 	int ret;
 
+	qmp->usb_init_count--;
 	ret = qmp_usbc_power_off(phy);
 	if (ret)
 		return ret;
@@ -874,6 +902,61 @@ static int phy_pipe_clk_register(struct qmp_usbc *qmp, struct device_node *np)
 	return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
 }
 
+#if IS_ENABLED(CONFIG_TYPEC)
+static int qmp_usbc_typec_switch_set(struct typec_switch_dev *sw,
+				      enum typec_orientation orientation)
+{
+	struct qmp_usbc *qmp = typec_switch_get_drvdata(sw);
+
+	if (orientation == qmp->orientation || orientation == TYPEC_ORIENTATION_NONE)
+		return 0;
+
+	mutex_lock(&qmp->phy_mutex);
+	qmp->orientation = orientation;
+
+	if (qmp->usb_init_count) {
+		qmp_usbc_power_off(qmp->phy);
+		qmp_usbc_exit(qmp->phy);
+
+		qmp_usbc_init(qmp->phy);
+		qmp_usbc_power_on(qmp->phy);
+	}
+
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
+static void qmp_usbc_typec_unregister(void *data)
+{
+	struct qmp_usbc *qmp = data;
+
+	typec_switch_unregister(qmp->sw);
+}
+
+static int qmp_usbc_typec_switch_register(struct qmp_usbc *qmp)
+{
+	struct typec_switch_desc sw_desc = {};
+	struct device *dev = qmp->dev;
+
+	sw_desc.drvdata = qmp;
+	sw_desc.fwnode = dev->fwnode;
+	sw_desc.set = qmp_usbc_typec_switch_set;
+	qmp->sw = typec_switch_register(dev, &sw_desc);
+	if (IS_ERR(qmp->sw)) {
+		dev_err(dev, "Unable to register typec switch: %pe\n", qmp->sw);
+		return PTR_ERR(qmp->sw);
+	}
+
+	return devm_add_action_or_reset(dev, qmp_usbc_typec_unregister, qmp);
+}
+#else
+static int qmp_usbc_typec_switch_register(struct qmp_usbc *qmp)
+{
+	return 0;
+}
+#endif
+
 static int qmp_usbc_parse_dt_legacy(struct qmp_usbc *qmp, struct device_node *np)
 {
 	struct platform_device *pdev = to_platform_device(qmp->dev);
@@ -994,16 +1077,24 @@ static int qmp_usbc_probe(struct platform_device *pdev)
 
 	qmp->dev = dev;
 
+	qmp->orientation = TYPEC_ORIENTATION_NORMAL;
+
 	qmp->cfg = of_device_get_match_data(dev);
 	if (!qmp->cfg)
 		return -EINVAL;
 
+	mutex_init(&qmp->phy_mutex);
+
 	ret = qmp_usbc_vreg_init(qmp);
 	if (ret)
 		return ret;
 
+	ret = qmp_usbc_typec_switch_register(qmp);
+	if (ret)
+		return ret;
+
 	/* Check for legacy binding with child node. */
-	np = of_get_next_available_child(dev->of_node, NULL);
+	np = of_get_child_by_name(dev->of_node, "phy");
 	if (np) {
 		ret = qmp_usbc_parse_dt_legacy(qmp, np);
 	} else {
-- 
2.43.0


