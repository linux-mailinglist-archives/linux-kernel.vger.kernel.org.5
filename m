Return-Path: <linux-kernel+bounces-31757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B5B833387
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 11:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF271C2134E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 10:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47ECD271;
	Sat, 20 Jan 2024 10:07:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418CD262;
	Sat, 20 Jan 2024 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705745244; cv=none; b=KhOLz/a/2sqxorC79PX2Bp4svOn1FV86lyXXrMGw+8iytc0HN0KsbmOJNVZkXBE701o0MKJMBf1nlR0I2HygybiOZi7djcGvxmCW3XMCdv/7b4GCWs3f1Z8oDMJv1ym5zEoHgmFWOmSZBnBsHRSuK51K8xOEIs2vnOu0cChI2Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705745244; c=relaxed/simple;
	bh=RHllaD+Z3afhGqk7hdVhYxhjR8H3nKx82VdjEZg6NJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDFo7FVdd4zMjBd7apa2UzDgy8fM688LBTazJbIOtjDt0k+7RAxNZi3tyzeJ1ZKeZiBGGQwBPyRt6PAja0C9PoUheWaYPANAMxPU8GqswNPl8KfMHHxM3P8yEVzQnF+E3/pCkVOPW9d24xtbQSXgbHNwW1ZDd+wsVRtfgXETxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24B96DA7;
	Sat, 20 Jan 2024 02:08:07 -0800 (PST)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F7003F73F;
	Sat, 20 Jan 2024 02:07:19 -0800 (PST)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	peng.fan@oss.nxp.com,
	Cristian Marussi <cristian.marussi@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org
Subject: [PATCH] clk: Check ops are available in clk_gate_restore_context
Date: Sat, 20 Jan 2024 10:07:11 +0000
Message-ID: <20240120100711.2832897-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check in clk_gate_restore_context() to assure that the clock enable
and disable ops are available before calling them.

CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-clk@vger.kernel.org
Fixes: 9be766274db4 ("clk: Clean up suspend/resume coding style")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Spotted this by code inspection.
I may be missing something, though, given my limited familiarity with CLK.
---
 drivers/clk/clk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f0940af485a5..79b90a8099d7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1200,9 +1200,11 @@ void clk_gate_restore_context(struct clk_hw *hw)
 	struct clk_core *core = hw->core;
 
 	if (core->enable_count)
-		core->ops->enable(hw);
+		if (core->ops->enable)
+			core->ops->enable(hw);
 	else
-		core->ops->disable(hw);
+		if (core->ops->disable)
+			core->ops->disable(hw);
 }
 EXPORT_SYMBOL_GPL(clk_gate_restore_context);
 
-- 
2.43.0


