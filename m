Return-Path: <linux-kernel+bounces-113903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFF888742
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533F32941B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FCD21085F;
	Sun, 24 Mar 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPTSluUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7771ED714;
	Sun, 24 Mar 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320988; cv=none; b=Q97DRAEPariyL1vGSKdq5BFre2RBm/1CFTOVQuvvaOLWcdW+avU0aY4L19Eb/sccsCD/XoVX1iUxr3gO/fl8+GlcTXOkzyjv+m0dR1vmGksIwB3HmhwD+lSRgdm7C33wrmNvutFpWv9vL/PxRT0IvM4pFQoWp9Bwz+R6domt1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320988; c=relaxed/simple;
	bh=yndw88zz5hL38S4CIm5fOYrwYgVggB3WZzDKWBTNnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBNupf9Q6tWngr6JYvR7YiCUGCxU+tGjskp9UNUOByFfjJzfZUhvlHLTBXC9Eq5R40GPhYPF9gDQvY5XRNAYDtJWNKF2ZxwsnRF2MKNSiu/mtcnRWboOoiMkYyNGEdEUupGury3/EKdslMbJEmag5OOkrIL9uj53wIwaP2qlNvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPTSluUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4665DC433F1;
	Sun, 24 Mar 2024 22:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320987;
	bh=yndw88zz5hL38S4CIm5fOYrwYgVggB3WZzDKWBTNnLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rPTSluUWj3o2v/QSNgsJDFIIt7vxYPlAcfO4qYz3bJ+ohCSz7CDPee3rJIXwPWixK
	 JOP5LOwwrw85keN26OdJDR5Wy5YKjgxv+w9EaQXkkJFa7z/bwQE7TadIlenW0WVOzG
	 abhgh2V/tI30s/1lzWj3+1C2zsTqxV5xU3mddXfFpz8mJmNhoSuGEAmPeeY3HiUBEn
	 Pg4putA3EOTUwpmcT0gTGeawuYlXslX9av7+CVlb3DowW79DV/oTGLcXDnRfUasF5c
	 v640HOQIYrodTiTO951BnT7Mf5fcfrRCBIVc1R8T+WAEZF+VPA2QkVotL++VIhLIMG
	 T78s7/9yYg3tQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Michal Simek <michal.simek@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 550/713] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Sun, 24 Mar 2024 18:44:36 -0400
Message-ID: <20240324224720.1345309-551-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 7938e9ce39d6779d2f85d822cc930f73420e54a6 ]

The kmalloc() in zynq_clk_setup() will return null if the
physical memory has run out. As a result, if we use snprintf()
to write data to the null address, the null pointer dereference
bug will happen.

This patch uses a stack variable to replace the kmalloc().

Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Suggested-by: Michal Simek <michal.simek@amd.com>
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://lore.kernel.org/r/20240301084437.16084-1-duoming@zju.edu.cn
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/zynq/clkc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 7bdeaff2bfd68..c28d3dacf0fb2 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -42,6 +42,7 @@ static void __iomem *zynq_clkc_base;
 #define SLCR_SWDT_CLK_SEL		(zynq_clkc_base + 0x204)
 
 #define NUM_MIO_PINS	54
+#define CLK_NAME_LEN	16
 
 #define DBG_CLK_CTRL_CLKACT_TRC		BIT(0)
 #define DBG_CLK_CTRL_CPU_1XCLKACT	BIT(1)
@@ -215,7 +216,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	int i;
 	u32 tmp;
 	int ret;
-	char *clk_name;
+	char clk_name[CLK_NAME_LEN];
 	unsigned int fclk_enable = 0;
 	const char *clk_output_name[clk_max];
 	const char *cpu_parents[4];
@@ -426,12 +427,10 @@ static void __init zynq_clk_setup(struct device_node *np)
 			"gem1_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
-	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
+		snprintf(clk_name, CLK_NAME_LEN, "mio_clk_%2.2d", i);
 		idx = of_property_match_string(np, "clock-names", clk_name);
 		if (idx >= 0)
 			can_mio_mux_parents[i] = of_clk_get_parent_name(np,
@@ -439,7 +438,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 		else
 			can_mio_mux_parents[i] = dummy_nm;
 	}
-	kfree(clk_name);
 	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
-- 
2.43.0


