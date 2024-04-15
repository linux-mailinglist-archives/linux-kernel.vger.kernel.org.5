Return-Path: <linux-kernel+bounces-145569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DF8A57EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9EAF1C20FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2504184A5A;
	Mon, 15 Apr 2024 16:37:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704783CCC;
	Mon, 15 Apr 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199033; cv=none; b=SweqO6CyBbbow1LxAAUh5yroH0WwrP953Sp8sbho7D15yaLsmbhVsaNYn7YabkmTjyFm+RijaDAAF+TAkiqjYqtVPIiQuqkOpiBw7k+KN/TBuSVbVVJ59EpRjhemoiuRRiGWWRUuL+ftWqtsoq1/uAMcQNoaVyOjOjxzFxSMIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199033; c=relaxed/simple;
	bh=cK+5PBqMFF+PgTRuERucVVmlIpa7o9q+w7QkvwbOkxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POkZ6+DQHFRMCmdMDUrnaIYI8HXQ5a6AszVKPdW4lhfR7NaF1H9UuwQmZN8R3D4bILtwSeAtUJiwnxzDrhBpXraDXa7jiDVBiio8dsH6f2zWX12s/Zx9XxFeMxM75om3IRzUZONusckAHbYVv4qDmEfJrLios89QAUAgvCAhQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 593E3DA7;
	Mon, 15 Apr 2024 09:37:40 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A184E3F64C;
	Mon, 15 Apr 2024 09:37:09 -0700 (PDT)
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
Subject: [PATCH v3 3/5] clk: scmi: Add support for rate change restricted clocks
Date: Mon, 15 Apr 2024 17:36:47 +0100
Message-ID: <20240415163649.895268-4-cristian.marussi@arm.com>
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

Some exposed SCMI Clocks could be marked as non-supporting rate changes.
Configure a clk_ops descriptors which does not provide the rate change
callbacks for such clocks when registering with CLK framework.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
v2 --> v3
- using SCMI_CLK_RATE_CTRL_SUPPORTED instead of _FORBIDDEN
---
 drivers/clk/clk-scmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index e70708573965..ba234b56f742 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -20,6 +20,7 @@
 enum scmi_clk_feats {
 	SCMI_CLK_ATOMIC_SUPPORTED,
 	SCMI_CLK_STATE_CTRL_SUPPORTED,
+	SCMI_CLK_RATE_CTRL_SUPPORTED,
 	SCMI_CLK_FEATS_COUNT
 };
 
@@ -248,7 +249,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 	ops->recalc_rate = scmi_clk_recalc_rate;
 	ops->round_rate = scmi_clk_round_rate;
 	ops->determine_rate = scmi_clk_determine_rate;
-	ops->set_rate = scmi_clk_set_rate;
+	if (feats_key & BIT(SCMI_CLK_RATE_CTRL_SUPPORTED))
+		ops->set_rate = scmi_clk_set_rate;
 
 	/* Parent ops */
 	ops->get_parent = scmi_clk_get_parent;
@@ -302,6 +304,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (!ci->state_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_STATE_CTRL_SUPPORTED);
 
+	if (!ci->rate_ctrl_forbidden)
+		feats_key |= BIT(SCMI_CLK_RATE_CTRL_SUPPORTED);
+
 	if (WARN_ON(feats_key >= db_size))
 		return NULL;
 
-- 
2.44.0


