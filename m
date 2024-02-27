Return-Path: <linux-kernel+bounces-83956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C186A082
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D1E28541E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A3F14E2CB;
	Tue, 27 Feb 2024 19:49:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481714DFF4;
	Tue, 27 Feb 2024 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063346; cv=none; b=KqJFQR8R69YR7gjnFiV9Xu86HSz+j6kmW3LpBLswx0n4+r6gE+XAaVxFgaYoz2pPwLXRu779TWcFa0P1XORrPjhVc6wCi2KY4Ss1bTxPTVggHzr5DZspDZINFPem4RZodqVApa0oZeEe66ds/kzBt35Rf7yYlvn40/mR9LSBEcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063346; c=relaxed/simple;
	bh=H4n1v0imyYH87DK6eE+niRDrOat3zcjgMIz1xRaJW0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbcKlgblp87sxQGDELEm+TeEk6CcV+xeNRApuIiiCWFs8Hpf8sfIbUZHYdftFF43FRdB7jNbwUvhgsNCzUq+OD7q2DzjvwsMTB6Xko5thx9qADTSoXx0qVHa5aYEsugPnBxaeYY+0oAeRVoXWfAgXAL1hjgqT2yF6Ob1Q0DuuuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02F52DA7;
	Tue, 27 Feb 2024 11:49:43 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06773F762;
	Tue, 27 Feb 2024 11:49:01 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-clk@vger.kernel.org
Subject: [PATCH 5/5] clk: scmi: Add support for get/set duty_cycle operations
Date: Tue, 27 Feb 2024 19:48:12 +0000
Message-ID: <20240227194812.1209532-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227194812.1209532-1-cristian.marussi@arm.com>
References: <20240227194812.1209532-1-cristian.marussi@arm.com>
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
index 87e968b6c095..86ef7c553ddd 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -21,6 +21,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_STATE_CTRL_FORBIDDEN,
 	SCMI_CLK_RATE_CTRL_FORBIDDEN,
 	SCMI_CLK_PARENT_CTRL_FORBIDDEN,
+	SCMI_CLK_DUTY_CYCLE_SUPPORTED,
 	SCMI_CLK_MAX_FEATS
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
 	if (!(feats_key & BIT(SCMI_CLK_PARENT_CTRL_FORBIDDEN)))
 		ops->set_parent = scmi_clk_set_parent;
 
+	/* Duty cycle */
+	if (feats_key & BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED)) {
+		ops->get_duty_cycle = scmi_clk_get_duty_cycle;
+		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
+	}
+
 	return ops;
 }
 
@@ -306,6 +352,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (ci->parent_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_FORBIDDEN);
 
+	if (ci->extended_config)
+		feats_key |= BIT(SCMI_CLK_DUTY_CYCLE_SUPPORTED);
+
 	/* Lookup previously allocated ops */
 	ops = clk_ops_db[feats_key];
 	if (!ops) {
-- 
2.43.0


