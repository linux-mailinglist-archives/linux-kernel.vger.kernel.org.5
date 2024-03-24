Return-Path: <linux-kernel+bounces-113850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A438886F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F843285FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F4135A6F;
	Sun, 24 Mar 2024 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnBsgOyX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445401E8E5A;
	Sun, 24 Mar 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320891; cv=none; b=N+QqCHZtNseM3AFUbY4GP6MNruAj2kzx9JjY4o3HVvfE5sAa06QpJlJOYXVC7RmcJFpmETsE5UGr41Trqx6BukYNu8Sw+d+LbjeWKNK6NZIQDIbCS01CHiiRZQWyrsu2UgcrVXV2vno6zN4TV526VMbGA9ehq2Qmp9YfVI/MEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320891; c=relaxed/simple;
	bh=3VrZTWUZxOF3mjUB31yZJdGrFQ+8dvR97x19mZM3h6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfF/lPFFJgQTfOrwv3y+ZYJMPKz3S2Hv7eVMCUiYqTM5C+kcq0hTsCxN7OsjFUTQi0gtm3KnV6YOTKeGQ9m6NfeYOC//zzC/L/1Aq4WstOHnDLsTmcvqTZwbpzYX95pGUP2seWzWOGq3iRgeaOnD61YGI22es9ZHLi8iuHTtm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnBsgOyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B526C433F1;
	Sun, 24 Mar 2024 22:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320889;
	bh=3VrZTWUZxOF3mjUB31yZJdGrFQ+8dvR97x19mZM3h6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnBsgOyX63u/zn1ej17eJkHUjpGuQ/8NS0wpnPo/xPgUSMSbhKclQCXBpid5iT0bE
	 W/S4J/b47J8eC6s7tPj2+8eu6HKL9UImpkRYv2atija2sYDbVgrYbyBuK9ie/znXbV
	 dbk6f2QsO1fyR71+efhfDrNV4iHSDILj8ZxSki4Ash6htKdKlQhyPTXMpKPDTX4GGB
	 wxqZr93oatrIrsi+rXiQW0UZLCVvHP8mutNaz/8xQ02BQYiF3D8O8lilmuh2ymOWFl
	 ZZiggGFeWYg/W+MTTxI5c3TqTBgrTIyMalgXgZzX9J961e0IoowcvS9fcz9gdnePyo
	 lD04vuxfXR3uQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 454/713] clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
Date: Sun, 24 Mar 2024 18:43:00 -0400
Message-ID: <20240324224720.1345309-455-sashal@kernel.org>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 9b2a11c83859c06233049b134bd8ee974b284559 ]

The status configuration for SD1 mux clock is SEL_SDHI1_STS. Fix it.

Fixes: 16b86e5c03c5 ("clk: renesas: rzg2l: Refactor SD mux driver")
Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240131102930.1841901-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/renesas/r9a07g043-cpg.c | 2 +-
 drivers/clk/renesas/r9a07g044-cpg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index b70bb378ab469..075ade0925d45 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -138,7 +138,7 @@ static const struct cpg_core_clk r9a07g043_core_clks[] __initconst = {
 	DEF_FIXED("SPI1", R9A07G043_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 	DEF_SD_MUX("SD0", R9A07G043_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
 		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
-	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+	DEF_SD_MUX("SD1", R9A07G043_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_shdi,
 		   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 	DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G043_CLK_SD0, 1, 4),
 	DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G043_CLK_SD1, 1, 4),
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index 1047278c9079a..bc822b9fd7ce6 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -178,7 +178,7 @@ static const struct {
 		DEF_FIXED("SPI1", R9A07G044_CLK_SPI1, CLK_DIV_PLL3_C, 1, 4),
 		DEF_SD_MUX("SD0", R9A07G044_CLK_SD0, SEL_SDHI0, SEL_SDHI0_STS, sel_shdi,
 			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
-		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI0_STS, sel_shdi,
+		DEF_SD_MUX("SD1", R9A07G044_CLK_SD1, SEL_SDHI1, SEL_SDHI1_STS, sel_shdi,
 			   mtable_sdhi, 0, rzg2l_cpg_sd_clk_mux_notifier),
 		DEF_FIXED("SD0_DIV4", CLK_SD0_DIV4, R9A07G044_CLK_SD0, 1, 4),
 		DEF_FIXED("SD1_DIV4", CLK_SD1_DIV4, R9A07G044_CLK_SD1, 1, 4),
-- 
2.43.0


