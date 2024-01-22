Return-Path: <linux-kernel+bounces-33281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F7A8367E8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3001C22AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB85B20A;
	Mon, 22 Jan 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZBrIRWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB05B5A9;
	Mon, 22 Jan 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935596; cv=none; b=B8IcQcIeEbG/l3V+USm6qq0cr1QtuBLwizmSxXTyBEaIRqIS/RO681RCZOxo0upyxtiZsRaQHIvlsyBeKb5Ng/rvsVv4tSAAvGIBxe7ioDBxZS+erB01jkqhVZFuJ7EI+OxCgfRDIZ1zhkbsgLANEbnLzcFZuCC29BNn8kbnvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935596; c=relaxed/simple;
	bh=fOsTqgZAd0vrP6tVW5esPMiUQEc5a6uhT+FU1ciBxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VN3BBoIPGR7JBhjZT1iNNG/YtmOxmW72qkuTYa831BHtHuGTtgPmc+7FWwouy9PsHaPNBt7vYpnLjkiMPkWSPpc4E3Xu482yGYuNqy8FhQ+Vjj4dmw5MuHQFcmBHziMfciRlko5MNK8cIn/reX+o/FReOI8ramHREWuVQWbSvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZBrIRWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4CFC43394;
	Mon, 22 Jan 2024 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935595;
	bh=fOsTqgZAd0vrP6tVW5esPMiUQEc5a6uhT+FU1ciBxb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZBrIRWXC1j1zUoEO9MDjQslkO5/IQI0bObH2KZ5dHUjh6WvG1oCdLEN5hoy3hUdn
	 BCbneDUxTYA2AFO1DoI0mi21ZUL5YPXQBi/tyvgB9JTSzSoPvxkhPTNpXTjJNe0UkO
	 y4sGGV7FSsXbA3kMDag78kQs6u3o5O95gw/ZbTmKl4zERHfulzzkUQpKDQzXSVgIaa
	 40X6EnYZWw5X3wJQiKyqOwCJugpvm27hGaIpsLX57XXcV/hf9lYGSMzUvFpVKbrbVG
	 9v54PD+6rvvsYtERRo1DsFt3Y9qdMhsU90WDmbTmhGUuqhdoBq7yBNkF6BIUsXHsRY
	 56kZDiwZhrx5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	krzysztof.kozlowski@linaro.org,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 59/88] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 09:51:32 -0500
Message-ID: <20240122145608.990137-59-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit bfbea9e5667cfa9552c3d88f023386f017f6c308 ]

In cases where kcalloc() fails for the 'clk_data->clks' allocation, the
code path does not handle the failure gracefully, potentially leading
to a memory leak. This fix ensures proper cleanup by freeing the
allocated memory for 'clk_data' before returning.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20231210165040.3407545-1-visitorckw@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/hisilicon/clk-hi3620.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/hisilicon/clk-hi3620.c b/drivers/clk/hisilicon/clk-hi3620.c
index 2d7186905abd..5d0226530fdb 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -466,8 +466,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
 		return;
 
 	clk_data->clks = kcalloc(num, sizeof(*clk_data->clks), GFP_KERNEL);
-	if (!clk_data->clks)
+	if (!clk_data->clks) {
+		kfree(clk_data);
 		return;
+	}
 
 	for (i = 0; i < num; i++) {
 		struct hisi_mmc_clock *mmc_clk = &hi3620_mmc_clks[i];
-- 
2.43.0


