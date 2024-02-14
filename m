Return-Path: <linux-kernel+bounces-65811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC29855224
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA731F2B1DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC112F586;
	Wed, 14 Feb 2024 18:30:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C270412EBFB;
	Wed, 14 Feb 2024 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707935447; cv=none; b=o63yIyBWFqCrx08kbAqijk9srrW2klSPNWfKpyJUtN9QfIooqvd3Ek2I9rFERAwkJjm4W2AmJBf3+6b9yfBjYCH03a87XSh/E6zWdMasY+rlgEbQO+o9Cm/VEGILIKyxr6N1lvDLK8OrMBZOn8dJBYEf0Zj051uO+lGqAI7UPe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707935447; c=relaxed/simple;
	bh=WYEne98DDgqD6wOMHk6cJ+Hy4mmBoGUxdY4E2T7jmSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVS4eoL602I4gi4Cqc8urm0eL2PWMEDOnU0oI3PLteoHzmepv+bKkB1eMd5nNS6ys3MRYGKuGW9EC0y124YIBUbt7wyq1g5V6uOUhE5Q63FgjEQWAe+zW3lHJ6J+D2CN20ruRmLXPUsJF09ufZZlJ4sxrPOjomdHSB2bCP0f2lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28EA7DA7;
	Wed, 14 Feb 2024 10:31:26 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E533F7B4;
	Wed, 14 Feb 2024 10:30:43 -0800 (PST)
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
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: [PATCH 7/7] clk: scmi: Support get/set duty_cycle operations
Date: Wed, 14 Feb 2024 18:30:06 +0000
Message-ID: <20240214183006.3403207-8-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214183006.3403207-1-cristian.marussi@arm.com>
References: <20240214183006.3403207-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the CLK framework callbacks related to get/set clock duty cycle if
the relared SCMI clock supports OEM extended configurations.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index b91a0dbd2fe0..9d3b1e749226 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -158,6 +158,45 @@ static int scmi_clk_atomic_is_enabled(struct clk_hw *hw)
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
@@ -256,6 +295,12 @@ scmi_clk_ops_alloc(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->parent_ctrl_forbidden)
 		ops->set_parent = scmi_clk_set_parent;
 
+	/* Duty cycle */
+	if (ci->extended_config) {
+		ops->get_duty_cycle = scmi_clk_get_duty_cycle;
+		ops->set_duty_cycle = scmi_clk_set_duty_cycle;
+	}
+
 	return ops;
 }
 
-- 
2.43.0


