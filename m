Return-Path: <linux-kernel+bounces-114372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBCC888FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FD82905BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1BB26FA69;
	Sun, 24 Mar 2024 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0YsMxlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324513BAE7;
	Sun, 24 Mar 2024 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321766; cv=none; b=hr3vpikTEX/HenpGcc5syVUR68Ln9OgGQu9HCXmgioUvM6IbUitgPb392DM543Tdp7oJFaLDHPJHdD0V26csyl9KqHdX+NQhq41KG/ZL9cuWEGsoDu6Ax4ihIIWh8uLKdcdQYt5wEhZv5pefbnSvj2woK0Q7sqTSgFC/3G5hWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321766; c=relaxed/simple;
	bh=yndw88zz5hL38S4CIm5fOYrwYgVggB3WZzDKWBTNnLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgemTxuJ7HTYdSwJkzHWFrq4/SejkrZZRxU8GX/rQ9f4iXp/WDbk4CJoSNADIS+SBljMofjpgSMhb+6ouuoqtx6rxSR57T4tFezvi+y/zVkFE3DWTFIM6bEILuQGAlSORjFcceARFZPPIODRn0ybRyNbS97fDCpUoeoiW0jklX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0YsMxlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B836C43390;
	Sun, 24 Mar 2024 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321765;
	bh=yndw88zz5hL38S4CIm5fOYrwYgVggB3WZzDKWBTNnLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0YsMxlI+QJdqoDGTaF2uWaDjnk2xBw57kEPD7TPlOEB2nSJHKA2Rr0mwXjBWiig3
	 OMpE7xO+2EVjzGSpSxsDozwivdP+u8QLBUrCrhfxcfH76bwmgQZr8Y2Xi2PM467m8u
	 YzFzIB2wg/JavinY+Qtycgifz3I8TbhZB57J5Iuu5ie0qrzWKoTsmXBtxs6Du8opXk
	 DV+Xu6aM47e/nLhVKyfYrYRfNkhaUlQN07pfu84EJnp5O/U5YJiMahs87zmkS/4nDX
	 KNX/huADjLYcBFB8fxRMMECPVQYHtf4msBTv3FpoOXRyatFRt7jVN575foCiOwCp5Q
	 GusaHIz0SqC/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Michal Simek <michal.simek@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 493/638] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Sun, 24 Mar 2024 18:58:50 -0400
Message-ID: <20240324230116.1348576-494-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


