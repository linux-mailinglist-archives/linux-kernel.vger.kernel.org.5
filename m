Return-Path: <linux-kernel+bounces-113845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9C8886ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8235E1C26115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811FE2046C6;
	Sun, 24 Mar 2024 23:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbd1im59"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714111E9644;
	Sun, 24 Mar 2024 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320897; cv=none; b=S+Iud6keKWpZVgDV3sAmyEwSb+PuwTOCmF8y9sCXoZgQmFNvzw3/K/nH0obuA8Y3Y5IRcIeW7C3vRidlz/YDim0aOt6OMkrnbmE+EMj82xqboOy87UtsQXbyUBT2XqD/1BFOst/Jv8WPs7iSGAVhWHqNTrZ5cNa0qEjVAFkvaFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320897; c=relaxed/simple;
	bh=PtAQUABtyxDZgdlJVsykILPS9lA4896XsifrH3VUvDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mkdh5S/5ONIyRPM8AP5CSAcHT+g8a2mbX3flcP2DVcVzYIHkQIMsq+aHblgthS8NsFuTuOgQehmxxJwX9vx3Pbvf7+pEpNQKQ6Ppoii/DKPcoKhTkKN/q/wClrg2ER5thQiRFhq9jXp1vgD3+N2JQ5+w8EmB0dv4LQl3JP0e8YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbd1im59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83350C433F1;
	Sun, 24 Mar 2024 22:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320896;
	bh=PtAQUABtyxDZgdlJVsykILPS9lA4896XsifrH3VUvDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xbd1im59eSN7cMWc2Xi3Vz4GDgG2/sEoj+Uwryhsrc4/r9VuIY4udLAc766Y0b3Rm
	 0dhcTHz54HpBTAi5zuLLLaRNzdam8pnkgrrNKhj6Q5ECziT8JV2Y+c5XHodiTNp2Gw
	 tmnQCt5cpSO9wSvsKi1wcpYPfmDd2vfNEaDafhQUnCwcZKygQvmfQ3Od8KwtSGThia
	 hXY63aR1EIwoFPbGD6nJl3RQj3xqEmXuriER6nnOv/uc7hSw0Iui5sFgYaCe4Uan0f
	 XyL63skHKPVWInLUVpgpwHFcsEblp7JhbgfF9Lr0F+L+nFF2RUOKHXaGtvzxwO3DXj
	 hsVyNsm1bqG1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 459/713] ASoC: meson: aiu: fix function pointer type mismatch
Date: Sun, 24 Mar 2024 18:43:05 -0400
Message-ID: <20240324224720.1345309-460-sashal@kernel.org>
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

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 98ac85a00f31d2e9d5452b825a9ed0153d934043 ]

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

sound/soc/meson/aiu.c:243:12: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  243 |                                        (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 6ae9ca9ce986 ("ASoC: meson: aiu: add i2s and spdif support")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Link: https://msgid.link/r/20240213215807.3326688-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/aiu.c | 19 ++++---------------
 sound/soc/meson/aiu.h |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/aiu.c b/sound/soc/meson/aiu.c
index 7109b81cc3d0a..5d1419ed7a62d 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -212,11 +212,12 @@ static const char * const aiu_spdif_ids[] = {
 static int aiu_clk_get(struct device *dev)
 {
 	struct aiu *aiu = dev_get_drvdata(dev);
+	struct clk *pclk;
 	int ret;
 
-	aiu->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(aiu->pclk))
-		return dev_err_probe(dev, PTR_ERR(aiu->pclk), "Can't get the aiu pclk\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "Can't get the aiu pclk\n");
 
 	aiu->spdif_mclk = devm_clk_get(dev, "spdif_mclk");
 	if (IS_ERR(aiu->spdif_mclk))
@@ -233,18 +234,6 @@ static int aiu_clk_get(struct device *dev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Can't get the spdif clocks\n");
 
-	ret = clk_prepare_enable(aiu->pclk);
-	if (ret) {
-		dev_err(dev, "peripheral clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-				       (void(*)(void *))clk_disable_unprepare,
-				       aiu->pclk);
-	if (ret)
-		dev_err(dev, "failed to add reset action on pclk");
-
 	return ret;
 }
 
diff --git a/sound/soc/meson/aiu.h b/sound/soc/meson/aiu.h
index 393b6c2307e49..0f94c8bf60818 100644
--- a/sound/soc/meson/aiu.h
+++ b/sound/soc/meson/aiu.h
@@ -33,7 +33,6 @@ struct aiu_platform_data {
 };
 
 struct aiu {
-	struct clk *pclk;
 	struct clk *spdif_mclk;
 	struct aiu_interface i2s;
 	struct aiu_interface spdif;
-- 
2.43.0


