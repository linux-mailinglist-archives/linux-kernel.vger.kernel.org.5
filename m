Return-Path: <linux-kernel+bounces-114890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E9E88927F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF46293DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56C41BD021;
	Mon, 25 Mar 2024 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOwE3UBj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E6927CBD9;
	Sun, 24 Mar 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323544; cv=none; b=LdSfpob5lHd8x0ihUxMBbuDxzhjMQbGfpj+M6/m58HsZHFegYzBPXrINOfgp0cUgKvggA5PAndikuuNRwB1t/yrNyVzUgBAvEboTVb3zf94NQVJ/G0amohsa/w+59Zr8jsvtEZt4Bm4NltZd5VVbfKP7p95nFnoR6gYDhzI0GH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323544; c=relaxed/simple;
	bh=uv+y9qKoXVm0GVCcYcJXwCwMLvSbWX+N9jYqynB1a0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk8Q+9tWXN9pSAyUtIvDW5CcG1iuqqDRimIUn7crbWVZKlKHHmMeDh8auck6F6KfxisJnX5diPolDkgQ+du3a+sDMS7N8nZ51ey2SqnCn20UuNmBTVTIv+zWUx7YaeEyc9QyWo9Z/jncPXpDd383h4MgzxgAray/6lM5AP57SVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOwE3UBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827B9C43399;
	Sun, 24 Mar 2024 23:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323543;
	bh=uv+y9qKoXVm0GVCcYcJXwCwMLvSbWX+N9jYqynB1a0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOwE3UBjYcx3AVCvdprxXDIYs2RIY1zD/d4p58F1zqx5sFqzvDfGhu0UQBjtN1ZuQ
	 DNBeDsor4Tj3YxHlmlWX3dqBS0cMitKmErlnbsEpoq7QkDlJRM2Oj81o4v0XKZ9iKT
	 P6qAh8Qgxa3pw0SMGnpM8VOU38W8OmhSg3uARtXxmHN5Gmd7EqAdzW1Sg+reZoQ/QI
	 mHY0fEUQCRJFbHIaZUHiz3ly90GX6TYqNuslo1lkUAtMU4WGjeRHKnWN3Vv1YdA+7L
	 R7iPyVMuDfgjyUZGwIF0mK7TOUnUx+3QQ2vq+YUSG7USoQvqAejkPxlPmnuVIEdaSA
	 EpNHa4trumNRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Michal Simek <michal.simek@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 251/317] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Sun, 24 Mar 2024 19:33:51 -0400
Message-ID: <20240324233458.1352854-252-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 204b83d911b90..c615664505a55 100644
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
@@ -425,12 +426,10 @@ static void __init zynq_clk_setup(struct device_node *np)
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
@@ -438,7 +437,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 		else
 			can_mio_mux_parents[i] = dummy_nm;
 	}
-	kfree(clk_name);
 	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
-- 
2.43.0


