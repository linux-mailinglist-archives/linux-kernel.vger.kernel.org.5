Return-Path: <linux-kernel+bounces-118001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491CC88B22E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6562E1E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E66EB73;
	Mon, 25 Mar 2024 21:00:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491806E611;
	Mon, 25 Mar 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400457; cv=none; b=tFMgPQofzla+SoQ/cP+b80eJB86MSNwXxfJlc0lUK6ekjhSrEFPOAfgRh9K+iG9B3uOF2GKq3BxfyH4Vv4efXTqol+gLKohJXLWs1qr6NKylB3mwx1RCh3IGdrOFxflxTuD9tD4rBjzwP4ZeNhYnvB5DaHccB0Jk+SOSsTb7ZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400457; c=relaxed/simple;
	bh=hB33tkx1tDZ2enEUqqqlcpk1sDTP9MOONtP7X5H/VUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBlseXyZ1Ztn3OR/pjNgnOJUSaMBKtCOpx0gX9f1AE3B1XMYzAtQM/qcwmel2hyedFPVYo6/dmnap5RtSjmb6rYNJYiD2FJ5m9gM2wDUczoUUf+mt7uU8JcwFJj29tm+Zt4FDQNq+XHo71hnyeAoPXNk0dqhFddN22XAFXmGjE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 520E2153B;
	Mon, 25 Mar 2024 14:01:29 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58D5F3F694;
	Mon, 25 Mar 2024 14:00:53 -0700 (PDT)
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
Subject: [PATCH v2 3/5] clk: scmi: Add support for rate change restricted clocks
Date: Mon, 25 Mar 2024 21:00:23 +0000
Message-ID: <20240325210025.1448717-4-cristian.marussi@arm.com>
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

Some exposed SCMI Clocks could be marked as non-supporting rate changes.
Configure a clk_ops descriptors which does not provide the rate change
callbacks for such clocks when registering with CLK framework.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index fc9603988d91..d20dcc60f9d1 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -19,6 +19,7 @@
 enum scmi_clk_feats {
 	SCMI_CLK_ATOMIC_SUPPORTED,
 	SCMI_CLK_STATE_CTRL_FORBIDDEN,
+	SCMI_CLK_RATE_CTRL_FORBIDDEN,
 	SCMI_CLK_MAX_FEATS
 };
 
@@ -248,7 +249,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 	ops->recalc_rate = scmi_clk_recalc_rate;
 	ops->round_rate = scmi_clk_round_rate;
 	ops->determine_rate = scmi_clk_determine_rate;
-	ops->set_rate = scmi_clk_set_rate;
+	if (!(feats_key & BIT(SCMI_CLK_RATE_CTRL_FORBIDDEN)))
+		ops->set_rate = scmi_clk_set_rate;
 
 	/* Parent ops */
 	ops->get_parent = scmi_clk_get_parent;
@@ -296,6 +298,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (ci->state_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_STATE_CTRL_FORBIDDEN);
 
+	if (ci->rate_ctrl_forbidden)
+		feats_key |= BIT(SCMI_CLK_RATE_CTRL_FORBIDDEN);
+
 	/* Lookup previously allocated ops */
 	ops = clk_ops_db[feats_key];
 	if (!ops) {
-- 
2.44.0


