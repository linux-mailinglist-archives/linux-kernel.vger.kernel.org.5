Return-Path: <linux-kernel+bounces-33375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2291C8368F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DD41F22083
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271C76E2B2;
	Mon, 22 Jan 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLkVK3U+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E46DD1E;
	Mon, 22 Jan 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936034; cv=none; b=uQ5pS3Il+nRXvLO0ZYD71RX5Ta9JteAJvvjMMHLxnhWZqUOS/ZInR9QsH6i9FYciedDk51+/Mybc5U4KKOlZ5ADFNpS6W4w8c6q36r+DaUJvpfqkENVC4SikTgoJ21M9VSQcJKdwdOkDAnaSQ8kbyuRKvkC0A2+p9CUMJb1njNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936034; c=relaxed/simple;
	bh=fOsTqgZAd0vrP6tVW5esPMiUQEc5a6uhT+FU1ciBxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKImFK3xqNh/qg8c5F1YM4rrxlGkTmgY8AXafhP9YFo7J7LhhuUoK/IhGH1sjqg/RtgBCF3EH3xBCgbcN16CaUVR1y2CFu9vCBLy6mo1TvGyJeZXtdGbabkSl1uxJvqBH/Jg/RLmqyO7OqgwJqb3OyjWh8hNtQvNaiStzFjqrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLkVK3U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0063C43390;
	Mon, 22 Jan 2024 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936034;
	bh=fOsTqgZAd0vrP6tVW5esPMiUQEc5a6uhT+FU1ciBxb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLkVK3U+ioDx57r4/AtB++X8dV+lc2D5ZtmuGdav4bcv0jD3pcL4yLL6nSZM4tC1l
	 FrFI1nQRjU2xsXdxAcU/cLkmgZ7ULl2PgUby7GoK3aqr8w1z8DAn17dzXuxgtghu4d
	 zJIJiqJh8oHNpb2kDNuSmq8SZEWyRrrHFOj8dZk8DWLlHaWKK5Ay+IVf6eZ+2PNqpU
	 UBgfL+3wIaae3hXunobhk9NmZ2gGRey/tqdoXt8+5JdHgbyAp69xkcT9m+X8lQz1QO
	 Sx1l3nEy4hZVwbfMTLoj9omn/lzkt3W9DULmRhhG0GQJSzKXJ3CsTcj2kB0o7D+bwS
	 MqEH69J2qhWOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	krzysztof.kozlowski@linaro.org,
	angelogioacchino.delregno@collabora.com,
	heiko@sntech.de,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 51/73] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:02:05 -0500
Message-ID: <20240122150432.992458-51-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


