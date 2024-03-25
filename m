Return-Path: <linux-kernel+bounces-118004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D62888B237
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1AF01FA07D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD737317B;
	Mon, 25 Mar 2024 21:01:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFFC71732;
	Mon, 25 Mar 2024 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400462; cv=none; b=YvWdkIaN83GL3jLu5Yqk9S2Zw2rmhoH8iTGrAu1T9YamB5VRJd9gSbNQ2sIPP4hVA1lw3cWtDtWmmqaIhF7fm+3dBNbH4ZDVaqgGotRTzfhMXR9ipjeovqVwDv+E3Bmxx8hUWc0NdtT3/tYhILKF+SdLI7Y7l/odxc/G6rhDu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400462; c=relaxed/simple;
	bh=Kh7/2pNWHN+bMKCPsHFaHNTHCq1l8WYfgz9x9QJkawU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y35Tnfp15D/R7VrQx+VgUhUSf1WX3DlTzMlskqNizi+5IOtyuDxiFNBJTjz0/772ec0ZfsWmNYxPz61jLzGScHjZ56TFimDEiLfgV9zkixYOOmWkT2rT0kfec5uZ7c37jDH/yhGbvwVJX3yNb/c1jEImxY8XQLWNLKko+CbXPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E35EC2F4;
	Mon, 25 Mar 2024 14:01:33 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496C23F694;
	Mon, 25 Mar 2024 14:00:58 -0700 (PDT)
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
Subject: [PATCH v2 5/5] clk: scmi: Add support for get/set duty_cycle operations
Date: Mon, 25 Mar 2024 21:00:25 +0000
Message-ID: <20240325210025.1448717-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325210025.1448717-1-cristian.marussi@arm.com>
References: <20240325210025.1448717-1-cristian.marussi@arm.com>
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
2.44.0


