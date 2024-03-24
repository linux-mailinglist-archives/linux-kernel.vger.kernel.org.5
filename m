Return-Path: <linux-kernel+bounces-115253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86829888DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD791C2A113
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD351CDDF6;
	Mon, 25 Mar 2024 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvKsXw0v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6E1856D5;
	Sun, 24 Mar 2024 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324367; cv=none; b=VdfgEodc8szRgzYtc9tlQDCxyHtoiZDEwvCZOIydzmSs1npK4ZLdLHli6Q6W8t7NiQnU67RTbcUagcfxu28ETd7Oj9ZNNZko/mODsKKnbAAy6LksVCBVecoQERsEMgzHAWS6g9yf3+6MTLAn7gOc8djft58D+ETuAuJK3IEBmTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324367; c=relaxed/simple;
	bh=9MZHMgR8QlDiSQ81BInBmmb7tp3DJW0f2NAZceSm0qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlgzvIAYBg7PFbUr7FTqpLmZ+3BT16toVhGq7cry6SZdWG0gmorsazgUMOV2CCxle3yM8Omnhno0Hfaw6Dz/8KKwcUmEu2weB1expojTm7jDNlCAh4BM3x4TH/UxLmg1nrWtvKQXxLUmFMMItnNh57NJb6/gIIeubP50WSZAG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvKsXw0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3E3C43394;
	Sun, 24 Mar 2024 23:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324366;
	bh=9MZHMgR8QlDiSQ81BInBmmb7tp3DJW0f2NAZceSm0qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvKsXw0vFiuZlWNTkkZUzDCC6FH0a7wk+6G0pMohOpNLhpEHRmse5tA395BuObXiX
	 OXRAgnaB9Sa4m6O2+qWvEcG1I5fAzyU+juMAszq4dHJs6kQhkAcTfpgb78OMyYoE0z
	 VAKgXfGbTX7qas8EPpB1aRtU1oeg/iHIyVuLs0JpfxsAu4/QFOXRaEUUS/Zh6l/NFz
	 xAus/PVDTBzrt8s25K1pNk8L2hpgaMmbx16ypta4BhibqT1Yr+xb3OtZPP7GpLgXuI
	 KuXb604OsxljFwgrtHgw6jR9iiPqlulFLbieXSn+6fZLRaoRuf9q9vYssG5MXhok0X
	 Zd9kqJWyeVZog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Taniya Das <tdas@codeaurora.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 133/148] clk: qcom: gdsc: Add support to update GDSC transition delay
Date: Sun, 24 Mar 2024 19:49:57 -0400
Message-ID: <20240324235012.1356413-134-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Taniya Das <tdas@codeaurora.org>

[ Upstream commit 4e7c4d3652f96f41179aab3ff53025c7a550d689 ]

GDSCs have multiple transition delays which are used for the GDSC FSM
states. Older targets/designs required these values to be updated from
gdsc code to certain default values for the FSM state to work as
expected. But on the newer targets/designs the values updated from the
GDSC driver can hamper the FSM state to not work as expected.

On SC7180 we observe black screens because the gdsc is being
enabled/disabled very rapidly and the GDSC FSM state does not work as
expected. This is due to the fact that the GDSC reset value is being
updated from SW.

Thus add support to update the transition delay from the clock
controller gdscs as required.

Fixes: 45dd0e55317cc ("clk: qcom: Add support for GDSCs)
Signed-off-by: Taniya Das <tdas@codeaurora.org>
Link: https://lore.kernel.org/r/20220223185606.3941-1-tdas@codeaurora.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Stable-dep-of: 117e7dc697c2 ("clk: qcom: dispcc-sdm845: Adjust internal GDSC wait times")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gdsc.c | 26 +++++++++++++++++++++-----
 drivers/clk/qcom/gdsc.h |  8 +++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index a077133c7ce38..83541e9d50701 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015, 2017-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -39,9 +39,14 @@
 #define CFG_GDSCR_OFFSET		0x4
 
 /* Wait 2^n CXO cycles between all states. Here, n=2 (4 cycles). */
-#define EN_REST_WAIT_VAL	(0x2 << 20)
-#define EN_FEW_WAIT_VAL		(0x8 << 16)
-#define CLK_DIS_WAIT_VAL	(0x2 << 12)
+#define EN_REST_WAIT_VAL	0x2
+#define EN_FEW_WAIT_VAL		0x8
+#define CLK_DIS_WAIT_VAL	0x2
+
+/* Transition delay shifts */
+#define EN_REST_WAIT_SHIFT	20
+#define EN_FEW_WAIT_SHIFT	16
+#define CLK_DIS_WAIT_SHIFT	12
 
 #define RETAIN_MEM		BIT(14)
 #define RETAIN_PERIPH		BIT(13)
@@ -314,7 +319,18 @@ static int gdsc_init(struct gdsc *sc)
 	 */
 	mask = HW_CONTROL_MASK | SW_OVERRIDE_MASK |
 	       EN_REST_WAIT_MASK | EN_FEW_WAIT_MASK | CLK_DIS_WAIT_MASK;
-	val = EN_REST_WAIT_VAL | EN_FEW_WAIT_VAL | CLK_DIS_WAIT_VAL;
+
+	if (!sc->en_rest_wait_val)
+		sc->en_rest_wait_val = EN_REST_WAIT_VAL;
+	if (!sc->en_few_wait_val)
+		sc->en_few_wait_val = EN_FEW_WAIT_VAL;
+	if (!sc->clk_dis_wait_val)
+		sc->clk_dis_wait_val = CLK_DIS_WAIT_VAL;
+
+	val = sc->en_rest_wait_val << EN_REST_WAIT_SHIFT |
+		sc->en_few_wait_val << EN_FEW_WAIT_SHIFT |
+		sc->clk_dis_wait_val << CLK_DIS_WAIT_SHIFT;
+
 	ret = regmap_update_bits(sc->regmap, sc->gdscr, mask, val);
 	if (ret)
 		return ret;
diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
index bd1f2c780d0af..a31d3dc36f2f2 100644
--- a/drivers/clk/qcom/gdsc.h
+++ b/drivers/clk/qcom/gdsc.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2015, 2017-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2017-2018, 2022, The Linux Foundation. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -29,6 +29,9 @@ struct reset_controller_dev;
  * @cxcs: offsets of branch registers to toggle mem/periph bits in
  * @cxc_count: number of @cxcs
  * @pwrsts: Possible powerdomain power states
+ * @en_rest_wait_val: transition delay value for receiving enr ack signal
+ * @en_few_wait_val: transition delay value for receiving enf ack signal
+ * @clk_dis_wait_val: transition delay value for halting clock
  * @resets: ids of resets associated with this gdsc
  * @reset_count: number of @resets
  * @rcdev: reset controller
@@ -42,6 +45,9 @@ struct gdsc {
 	unsigned int			clamp_io_ctrl;
 	unsigned int			*cxcs;
 	unsigned int			cxc_count;
+	unsigned int			en_rest_wait_val;
+	unsigned int			en_few_wait_val;
+	unsigned int			clk_dis_wait_val;
 	const u8			pwrsts;
 /* Powerdomain allowable state bitfields */
 #define PWRSTS_OFF		BIT(0)
-- 
2.43.0


