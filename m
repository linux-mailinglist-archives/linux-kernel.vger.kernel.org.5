Return-Path: <linux-kernel+bounces-114855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA348891C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A918829357A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9802C7905;
	Mon, 25 Mar 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWR8/jT/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104527A85F;
	Sun, 24 Mar 2024 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323497; cv=none; b=upGtmsRvkUneNIRsK/UyrnVtbAWEk5H0d1w5JbxSZaFr4FdqV6hlCX6/zboKplL/5xE/89h5Zg60x09DyK2kWjlpTuux3BOhNxi0FT8o/HgcAToz08003uN+gMHdgZ+hhynVLlBl/cjRmfra40nksP0TA6nEti4zVEXYhZsZ+fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323497; c=relaxed/simple;
	bh=TcBsGfVcMD3EtPVOIGdNV8dQNmF63mnpU6DYFDlur2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okLurgk3GLBJ1Cw68YDUPrwP1hQSqXQXckBnVFRfcuD7WMBX7LlVhA6AATSwpTQW6qeE8cu3FGFEZqbylWge2vIWgP9SkAC5Xtw5AGyG8XVh8gtEBufPAaYwdhBdYEmbTS7sjKSK9Geq4nMIxRxH+FqcTN8kb0RVaind3jq+c1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWR8/jT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E11C43390;
	Sun, 24 Mar 2024 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323496;
	bh=TcBsGfVcMD3EtPVOIGdNV8dQNmF63mnpU6DYFDlur2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWR8/jT/GufWMu0nRZmYF+Y82fs4yuF5b24Bm0rrLGUhd0KqyiL6eDIS5etSyjkx0
	 JNpODIINhy2SSRJsPPj1BCnWlstzWF/sm30YqDF85fcL179N9tLyGlazdWfD3wOeGB
	 NBOuUht1AvSKH4KcvbFX74NXfzEO5lhcsPOLFCJUmfgTRObsLKvNuTxD+9dF6gfmu0
	 Twy0m03zJ2oZM1nuuZCmaBxIcz63m40ql09Ux/fGeLGi6Ih4NHV558oWZ73ILl4U4g
	 QDuB00qFPOkfRvt13l1lkBqUp+z48kFPb8AWSDBZBc/Ab6oZfskvFJ7jBhLpdpxgVI
	 CFnP7R98jbKjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 201/317] ASoC: meson: aiu: fix function pointer type mismatch
Date: Sun, 24 Mar 2024 19:33:01 -0400
Message-ID: <20240324233458.1352854-202-sashal@kernel.org>
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
index d299a70db7e59..a164ca2446ecd 100644
--- a/sound/soc/meson/aiu.c
+++ b/sound/soc/meson/aiu.c
@@ -215,11 +215,12 @@ static const char * const aiu_spdif_ids[] = {
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
@@ -236,18 +237,6 @@ static int aiu_clk_get(struct device *dev)
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


