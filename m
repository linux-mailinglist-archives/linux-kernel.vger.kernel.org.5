Return-Path: <linux-kernel+bounces-114943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E76F0888C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3463293F17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8ADF2DAAFD;
	Mon, 25 Mar 2024 00:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ84GMna"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5F17A379;
	Sun, 24 Mar 2024 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323654; cv=none; b=HOjXOvV2BSZiaeyZJ2W8LrXY/H1iDJxgznuV0CwLl9cLCAGfToWNYqwcNNPV3f95vrh4/YCieD78NlbcmPu2PGQlm1ZTYCqjgHj6F/aEjFabhu10v00+hT+Nq4TfPJQ5AlWvpYrM4TxLf/eNY/2xHdDBo+H5brrycx2p+slY7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323654; c=relaxed/simple;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fWdJaW1sabZph0gC/RDJLdIUaPo2F4XGxVEjW7fxm2LDt4h3g2xyxrqGCK7ZezmuOjtNg0bQJe6Ll1IRoC9ahmtt+rpgbXgGcMVjSAFzbrQs9sa1tMfBufAsRdVBuI0e3vR48Mm6rFNb8UUrC3R2VUbJtX9zgeMhn2SvmCDMMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ84GMna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE46C43390;
	Sun, 24 Mar 2024 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323653;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RJ84GMnaEsRdo6kw+J5yOj5MnK/Qp7TFhGjVVfgSv7gll09zXX1HPWEnysEzzE1qX
	 zWTWUqt54gdwGdBiBJLmkeDliSIOp31da03RddQa7tbYRtlT0WhpkAm+j6Dyo19zBk
	 sx/GSEN7aSU6ql/zRJErPaHUnW2X1t8Sf3L5ilzWuxB3nKsIhGc27kK9VBwL6V+0fW
	 26mVxWMJ4NACcFbMgPA2Y8haqwkPVQ07si8L8TL5DBSrDKN0fdhSHfag8xb1GS5WHm
	 nk7sz8oeLaTwS1GnPiwjqgwKXKEG5qyxBONe/uKn+oE+hr3sMO1iYBoOJwqDr2q7r8
	 uBFPJhqbNq7Vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 025/238] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Sun, 24 Mar 2024 19:36:53 -0400
Message-ID: <20240324234027.1354210-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 57aeded978c28..d6efc85f966b0 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2898,8 +2898,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0


