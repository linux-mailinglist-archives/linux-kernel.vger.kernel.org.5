Return-Path: <linux-kernel+bounces-33567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EE2836B74
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBCC285C65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0954E153BF1;
	Mon, 22 Jan 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8BQgP1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49874153BE8;
	Mon, 22 Jan 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936750; cv=none; b=J5Pos7vee1Rh+24s3SHOo6eD5rbqqmIa75aPLdwgflZjrPlHKxGpp7FeGtVr1RScL8fmKSBV/XsAB5UmTWx+YFw/W/POjOVc2S0BbG7KsRGtM0Z64pylAc/inDN2z/ld2rhx8E0K3mEeeTzP2Nl0wuETxf2h+pOk6+rMdOoKdhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936750; c=relaxed/simple;
	bh=0KTWyS8Xzr4SoH0wDO00T+Si73qtvNG9CoD6qibffQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=raIJFfC8eRzKfYmAvwnn+L3sSSJyYt+jFY0GNwrVrLkZrmfcCw8GIwVTuLsSjjgN2u7kCd4pSr+YMKBDiCXofpWFFjC1MfnuWlrtooulOeJlfnGXoJ+5aOUfuAlappfeMF2vo7eSo8G6cnlMuTFZLmj99vY0v1f/+fVbyopw9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8BQgP1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9036DC433F1;
	Mon, 22 Jan 2024 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936749;
	bh=0KTWyS8Xzr4SoH0wDO00T+Si73qtvNG9CoD6qibffQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E8BQgP1wXV86v3drUjw8Hfxk8zBNEA6PQQhtNk5CO6nn8MBVpnWfe3TcUHYajlJWi
	 j4TK4SAYrXUU0loDbk5QnGpd2XZ/yYOr432+c7GCHXLjUJGRJZ3Q0r1ISYJ0lKznv7
	 v9zOY4O4HjYDdetdrNCfXgPF2dPTc73EQ4go7bE3rI7GVgUSniDLdR7XsEXneBNDzL
	 XBDgCoqK0FJnWEpVwLO7a6R/Ft/DJzmZveFqmuFP/mRIpLyg4fza7kDejfl2o7ohkW
	 TqIA7wo2iuCZUgRg4x80g0qEWJ6xYnYAyWzmZjwGWRJuclwhie6ZecdGDyoU4pXWKg
	 mzwrdkdzC8M1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	heiko@sntech.de,
	luca.ceresoli@bootlin.com,
	robh@kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 18/23] clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()
Date: Mon, 22 Jan 2024 10:17:58 -0500
Message-ID: <20240122151823.997644-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
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
index 77072c7778b9..93b4d8933797 100644
--- a/drivers/clk/hisilicon/clk-hi3620.c
+++ b/drivers/clk/hisilicon/clk-hi3620.c
@@ -481,8 +481,10 @@ static void __init hi3620_mmc_clk_init(struct device_node *node)
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


