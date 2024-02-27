Return-Path: <linux-kernel+bounces-83955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2186A081
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D60287BF8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008B714DFD6;
	Tue, 27 Feb 2024 19:49:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DA14CAD1;
	Tue, 27 Feb 2024 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709063343; cv=none; b=UhyY6m1CwdPaRJGV+XDWXNP9sWLYh+xgJpnz1hx7g96Smw+HP+sdNeYnpVWipZT2CMdLhc8DwBIGWAGlmmSLZ+oDTIG1HmACAsYld1U0Ha8UnBtvI9m/5B0oxsvVcy1Z2xVruFa3+8GQ93HUOiIXl9WJfKtTkTai8yhsTlGHj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709063343; c=relaxed/simple;
	bh=kyoC3QjAGJnw2ltWGrVe82yoB+HRlUgN+egixJlg/3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndg+KjvDPijxfFcYc4B48ziB14cyyfyGmVWwLug/eOQpMumtDqH7FumP2o6aulEeSmdI9SU41d6yuYVuhLSWw+Mz7aQLKDxPD8GSNOXwsaPQBS1pJM16JEwkMOQNnqElwJMVXbQ0PfFc1AWM3v4H13hX0h3+5K8pwPI2j0t4jGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B87CFEC;
	Tue, 27 Feb 2024 11:49:40 -0800 (PST)
Received: from pluto.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CE243F762;
	Tue, 27 Feb 2024 11:48:59 -0800 (PST)
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
Subject: [PATCH 4/5] clk: scmi: Add support for re-parenting restricted clocks
Date: Tue, 27 Feb 2024 19:48:11 +0000
Message-ID: <20240227194812.1209532-5-cristian.marussi@arm.com>
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

Some exposed SCMI Clocks could be marked as non-supporting re-parenting
changes.
Configure a clk_ops descriptor which does not provide the re-parenting
callbacks for such clocks when registering with CLK framework.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/clk/clk-scmi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index d20dcc60f9d1..87e968b6c095 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -20,6 +20,7 @@ enum scmi_clk_feats {
 	SCMI_CLK_ATOMIC_SUPPORTED,
 	SCMI_CLK_STATE_CTRL_FORBIDDEN,
 	SCMI_CLK_RATE_CTRL_FORBIDDEN,
+	SCMI_CLK_PARENT_CTRL_FORBIDDEN,
 	SCMI_CLK_MAX_FEATS
 };
 
@@ -254,7 +255,8 @@ scmi_clk_ops_alloc(struct device *dev, unsigned long feats_key)
 
 	/* Parent ops */
 	ops->get_parent = scmi_clk_get_parent;
-	ops->set_parent = scmi_clk_set_parent;
+	if (!(feats_key & BIT(SCMI_CLK_PARENT_CTRL_FORBIDDEN)))
+		ops->set_parent = scmi_clk_set_parent;
 
 	return ops;
 }
@@ -301,6 +303,9 @@ scmi_clk_ops_select(struct scmi_clk *sclk, bool atomic_capable,
 	if (ci->rate_ctrl_forbidden)
 		feats_key |= BIT(SCMI_CLK_RATE_CTRL_FORBIDDEN);
 
+	if (ci->parent_ctrl_forbidden)
+		feats_key |= BIT(SCMI_CLK_PARENT_CTRL_FORBIDDEN);
+
 	/* Lookup previously allocated ops */
 	ops = clk_ops_db[feats_key];
 	if (!ops) {
-- 
2.43.0


