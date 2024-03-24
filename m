Return-Path: <linux-kernel+bounces-113313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73870888354
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13CC1B2289D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB98193169;
	Sun, 24 Mar 2024 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqnbX6ZV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E019314B;
	Sun, 24 Mar 2024 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320114; cv=none; b=j8tl+WK6Wi6WL7Nqim30xfb5JqAIKQNT0MEMxWRt4SNQUXw4QKJSl4JazwJE0cFvViatxWkMyuIpICpqJGdbItuzIOPsMUV1imXuXDKFN4LhinANeyXAe+wXhHY7SPrFlGA8ia45cqxBYbhOF0R3VFey0XV/r43b5ZV5Y+Iab2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320114; c=relaxed/simple;
	bh=3VrZTWUZxOF3mjUB31yZJdGrFQ+8dvR97x19mZM3h6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYb+BWyBn7GIwPVhTDIa0xBBoAV2I+2Bz4MjSseFtEeTMnMtk3KLxCaEfHz6WnOqev06eKzqjviSl71p8zK+Z/3OEXweV88FIbKB5AoU6+6jC6khrOF0nwMe9fYAzH/It6mFopduPD8v8F5nlqrCHt7dv462EWHyKUN4anhHLEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqnbX6ZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B20FC43330;
	Sun, 24 Mar 2024 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320113;
	bh=3VrZTWUZxOF3mjUB31yZJdGrFQ+8dvR97x19mZM3h6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qqnbX6ZVFTEuhg9X13O8ld1pnnMjd1NmP0+IFHLPV+tu9I0aFk4nkn1M2LN4fvfdU
	 MlP7sbYQC6e+ZNvsbPMQUNWGqndW1TZFldgQ/puortBShs2oG4bZscw3Li1wKop6wm
	 QMPGKJ2mJDm5ku16F8JqS5Is+6Ku/e3nelhY6ulLOH+YMledaHgLhDWOeiZpb8Y9QD
	 onxYxVWOjhOziy2oN+DZhHeabMEtd+9wcEsmqv3aXsfAZ9TcLj1jfBBe16AmbTxTBw
	 wV0+uzoT4ta5zsNfUsLRMB/ChCP7fK3h2Jsw4aucLLcqrMJjrGvLeyFosT6LCaKd9W
	 BpKeEeY5KeUVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Hien Huynh <hien.huynh.px@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 422/715] clk: renesas: r9a07g04[34]: Use SEL_SDHI1_STS status configuration for SD1 mux
Date: Sun, 24 Mar 2024 18:30:01 -0400
Message-ID: <20240324223455.1342824-423-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


