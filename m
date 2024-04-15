Return-Path: <linux-kernel+bounces-145572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414A98A57F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F297E283E98
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF585C59;
	Mon, 15 Apr 2024 16:37:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAB78565A;
	Mon, 15 Apr 2024 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199038; cv=none; b=RH+4cAbzslut28Ua7jBrCQkBiaFWflya57rAp5psfjWf0s/HnzQtu3DYtpyXcufnbkhKS9eqH1rSYlA/wLuadrY2PNre4TlaxxsSUAl3X/ZXwU4ejMfFftXqpHT+oz6SsJkNw0BQ2iMYHSBybw4BKjSsV9SM8pAaqj0DG8LafBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199038; c=relaxed/simple;
	bh=19zinLcYkEloXjm+foouTE9hbR4HLHMXAhAj7wsMfWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p56eXRRXjPa/FJ/X/Cfm638TQqMt8czteZ0C67uEA60lgiqvnwHig6Hp3AAfvL2ecscsgTGE368ISQfLKSedCUn+++6HgOSe7/+H08/J0h/gnPaSW8vUUVfFlerZ07MmGkFbIM1OgJmRUECuf6xELPL6j+8Mxp+FUn3G4LFKfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51DE3150C;
	Mon, 15 Apr 2024 09:37:45 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96C703F64C;
	Mon, 15 Apr 2024 09:37:14 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	souvik.chakravarty@arm.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 5/5] clk: scmi: Add support for get/set duty_cycle operations
Date: Mon, 15 Apr 2024 17:36:49 +0100
Message-ID: <20240415163649.895268-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415163649.895268-1-cristian.marussi@arm.com>
References: <20240415163649.895268-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the CLK framework callbacks related to get/set clock duty cycle if
the related SCMI clock supports OEM extended configurations.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index ce0f26ee632f..d86a02563f6c 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -22,6 +22,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_STATE_CTRL_SUPPORTED,
 	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_PARENT_CTRL_SUPPORTED,
+	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -169,6 +170,45 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
 	return !!enabled;
 }
 
+static int scmi_clk_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
+{
+	int ret;
+	u32 val;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	ret = scmi_proto_clk_ops->config_oem_get(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_DUTY_CYCLE,
+						 &val, NULL, false);
+	if (!ret) {
+		duty->num = val;
+		duty->den = 100;
+	} else {
+		dev_warn(clk->dev,
+			 "Failed to get duty cycle for clock ID %d\n", clk->id);
+	}
+
+	return ret;
+}
+
+static int scmi_clk_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
+{
+	int ret;
+	u32 val;
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	/* SCMI OEM Duty Cycle is expressed as a percentage */
+	val = (duty->num * 100) / duty->den;
+	ret = scmi_proto_clk_ops->config_oem_set(clk->ph, clk->id,
+						 SCMI_CLOCK_CFG_DUTY_CYCLE,
+						 val, false);
+	if (ret)
+		dev_warn(clk->dev,
+			 "Failed to set duty cycle(%u/%u) for clock ID %d\n",
+			 duty->num, duty->den, clk->id);
+
+	return ret;
+}
+
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
 			     const struct clk_ops *scmi_ops)
 {
@@ -258,6 +298,12 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 	if (feats_key & BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED))
 		ops->set_parent = scmi_clk_set_parent;
 
+	/* Duty cycle */
+	if (feats_key & BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED)) {
+		ops->get_duty_cycle = scmi_clk_get_duty_cycle;
+		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
+	}
+
 	return ops;
 }
 
@@ -312,6 +358,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->parent_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_SUPPORTED);
 
+	if (ci->extended_config)
+		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
+
 	if (WARN_ON(feats_key >= db_size))
 		return NULL;
 
-- 
2.44.0


