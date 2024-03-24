Return-Path: <linux-kernel+bounces-113841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758B0888EAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7231F34F22
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6581E88F6;
	Sun, 24 Mar 2024 23:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckvo6msx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F01E9651;
	Sun, 24 Mar 2024 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320898; cv=none; b=SbFT/rI7jH098D9CL0QvQpQYHMuF0ZV5N3HQCa6uqQ9lo78Y1HCQCz9Sm4RIf21u60g6kqWaVhKnxcb0xBvEYhP64/ZMJ6FHcqCvH0opXHI26sDViCRy8NV2H3DZN5X4X57w2ZXHJCEwNmxE5DDBdpnj+cTjgaSLAINlTYzT8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320898; c=relaxed/simple;
	bh=32Gku5sbfFWN/XgXjEhBLHodUGyYu8Wv1FUmnhm2HPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YG4fOt2xYaMWBTjZGrMwWqloNGhusSrxzwVFFI50GTCM2Wpykd6/lQSqE8kXSCx8h+rxENLg1ZeUdmsxGbMu3xw7x8qtt5MBfusj42T/D15OtoCSm7mUrbW3BmWLEIVB8QjL5Eh2SvsSKMtO8hORF28caGnIeUkU6ititWVFAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckvo6msx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F85C433C7;
	Sun, 24 Mar 2024 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320897;
	bh=32Gku5sbfFWN/XgXjEhBLHodUGyYu8Wv1FUmnhm2HPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckvo6msx06LK/hXyupX4SsvrHQarOfj41EzMgPhziAF6938DOgAvSGkeNSj+gotPp
	 Puzzr7pq+sAz/sOEyGApu6aFAIFZF0avaDdenBstWbLSkgBuqwaIO9e6Qql1gjb0nA
	 wdDmTSEhVtyv5mOtv8jgMAfvlkNrDAMV2lnEl7ThQ4U7k+ws3cVqnYOmGDgB9KVwA6
	 99FsQYBBgPbFUOJC7LsLhinDvnS23OkkH4PZWldbkhRRWJOlzOrD1JsPHiZy2dkhPq
	 Hjj+GD6JCwvP+HOMyK6uwKRVQMc9H8S0LX8AqQymGzkmpn39b4DV6I/Vs8K6ishYfP
	 DTH5b2i/GITUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 460/713] ASoC: meson: t9015: fix function pointer type mismatch
Date: Sun, 24 Mar 2024 18:43:06 -0400
Message-ID: <20240324224720.1345309-461-sashal@kernel.org>
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

[ Upstream commit 5ad992c71b6a8e8a547954addc7af9fbde6ca10a ]

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

sound/soc/meson/t9015.c:274:4: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  274 |                         (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 33901f5b9b16 ("ASoC: meson: add t9015 internal DAC driver")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Link: https://msgid.link/r/20240213215807.3326688-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/t9015.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 9c6b4dac68932..571f65788c592 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -48,7 +48,6 @@
 #define POWER_CFG	0x10
 
 struct t9015 {
-	struct clk *pclk;
 	struct regulator *avdd;
 };
 
@@ -249,6 +248,7 @@ static int t9015_probe(struct platform_device *pdev)
 	struct t9015 *priv;
 	void __iomem *regs;
 	struct regmap *regmap;
+	struct clk *pclk;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -256,26 +256,14 @@ static int t9015_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk))
-		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get core clock\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "failed to get core clock\n");
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
 	if (IS_ERR(priv->avdd))
 		return dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 
-	ret = clk_prepare_enable(priv->pclk);
-	if (ret) {
-		dev_err(dev, "core clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			priv->pclk);
-	if (ret)
-		return ret;
-
 	ret = device_reset(dev);
 	if (ret) {
 		dev_err(dev, "reset failed\n");
-- 
2.43.0


