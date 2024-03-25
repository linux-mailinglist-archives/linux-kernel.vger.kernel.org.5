Return-Path: <linux-kernel+bounces-118000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABEF88B22D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0F32E0E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E185C8FF;
	Mon, 25 Mar 2024 21:00:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF5E6CDDB;
	Mon, 25 Mar 2024 21:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400455; cv=none; b=OWAPjrb1GZkfi0RtjYtRtiNjwH69GGLJ1gv4E5+FUAHmQb0VeA35L88eW6BJdLGNidOdZshTvoCtMMuSp+eqpPQU8AHCe+VFRJ7KA7wtB5YglX4HHziTW3L+EoXMxVhXm7T6gNmSESDNn+SH4li86NEQsuNZoSqY8HoAPBoye4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400455; c=relaxed/simple;
	bh=kaHUA4qswzf894DfS4fX7gMqaLkWYQajGAxoXA0sAl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ml+XVe+952+lqgGpO3MiebNCY9Ot3sfiY+chtwnPwqZmBff8aezcgLflDUBKIEuaJlnmfNwvk/QdBWnHx3MZlfI8qG1jlPU+2VRqmb/6nvqebKHXpRxEpqlNFoqzFbt3F0USJv6rdCJQFCfIFzN7AvRaiAmPJ5tJoyhmJpd4QII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A727C13D5;
	Mon, 25 Mar 2024 14:01:26 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0929E3F694;
	Mon, 25 Mar 2024 14:00:50 -0700 (PDT)
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
Subject: [PATCH v2 2/5] clk: scmi: Add support for state control restricted clocks
Date: Mon, 25 Mar 2024 21:00:22 +0000
Message-ID: <20240325210025.1448717-3-cristian.marussi@arm.com>
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

Some exposed SCMI Clocks could be marked as non-supporting state changes.
Configure a clk_ops descriptor which does not provide the state change
callbacks for such clocks when registering with CLK framework.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d5d369b052bd..fc9603988d91 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -18,6 +18,7 @@
 
 enum scmi_clk_feats {
 	SCMI_CLK_ATOMIC_SUPPORTED,
+	SCMI_CLK_STATE_CTRL_FORBIDDEN,
 	SCMI_CLK_MAX_FEATS
 };
 
@@ -230,15 +231,19 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 	 * only the prepare/unprepare API, as allowed by the clock framework
 	 * when atomic calls are not available.
 	 */
-	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
-		ops->enable = scmi_clk_atomic_enable;
-		ops->disable = scmi_clk_atomic_disable;
-		ops->is_enabled = scmi_clk_atomic_is_enabled;
-	} else {
-		ops->prepare = scmi_clk_enable;
-		ops->unprepare = scmi_clk_disable;
+	if (!(feats_key & BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN))) {
+		if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED)) {
+			ops->enable = scmi_clk_atomic_enable;
+			ops->disable = scmi_clk_atomic_disable;
+		} else {
+			ops->prepare = scmi_clk_enable;
+			ops->unprepare = scmi_clk_disable;
+		}
 	}
 
+	if (feats_key & BIT(SCMI_CLK_ATOMIC_SUPPORTED))
+		ops->is_enabled = scmi_clk_atomic_is_enabled;
+
 	/* Rate ops */
 	ops->recalc_rate = scmi_clk_recalc_rate;
 	ops->round_rate = scmi_clk_round_rate;
@@ -288,6 +293,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (atomic_capable && ci->enable_latency <= atomic_threshold)
 		feats_key |= BIT(SCMI_CLK_ATOMIC_SUPPORTED);
 
+	if (ci->state_ctrl_forbidden)
+		feats_key |= BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN);
+
 	/* Lookup previously allocated ops */
 	ops = clk_ops_db[feats_key];
 	if (!ops) {
-- 
2.44.0


