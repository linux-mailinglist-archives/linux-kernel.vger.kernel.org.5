Return-Path: <linux-kernel+bounces-118003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5188B233
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDDF1F67308
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C11770CB2;
	Mon, 25 Mar 2024 21:01:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919916F085;
	Mon, 25 Mar 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400459; cv=none; b=nAeoFjgG8YSl62mWnv+vZ4gReJUyHQ0S+Tt2rrhGLXp0CD+yXmgToTtLee2E6sUSNWmyxgr8aQKSVeS5WC9MD3yqtg6bmJmGF9H/SteVkqVDB1HFyDRlhjDP0fIcuHSbo1IRIJkWycpbmJiarqPcl/nZC3Z675b0wiQLmZh6eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400459; c=relaxed/simple;
	bh=4SiRoeD6bB8DFgQrOsAZsx4BXqwPKBOWJLo8r/Mu7Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPBifP2YAf9JHdn9gPNEL1PizsC7n8prGpvG/kyJNi48j6jlZ1cFsyE1yZ5aAV15FRqY/e+vx41eQ1FH6BY74V5feXAMU2WDd0neMMoMrmiom55pwCHfMHXdFzBcYdPj/RbeZaBmixz+DXoTaQs7NSfWcvzc98pgiqCkVeddP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8D21595;
	Mon, 25 Mar 2024 14:01:31 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 003D53F694;
	Mon, 25 Mar 2024 14:00:55 -0700 (PDT)
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
Subject: [PATCH v2 4/5] clk: scmi: Add support for re-parenting restricted clocks
Date: Mon, 25 Mar 2024 21:00:24 +0000
Message-ID: <20240325210025.1448717-5-cristian.marussi@arm.com>
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
2.44.0


