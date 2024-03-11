Return-Path: <linux-kernel+bounces-99417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CC878811
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8349283B30
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74EB59176;
	Mon, 11 Mar 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0ct7dtQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303E6341F;
	Mon, 11 Mar 2024 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182380; cv=none; b=WsBMzDxZ5pkLkosndG7xqlGYzCxPiL1kY6TRjfbAga21Zpl7y/0mO5hI0TFhrkvIYePqdwdVYKkoIFZddbReQQhqLsWuvAKT/BrxlcSZnRpsvJpljaMKp5h003McyjAAdWTHfU7zf08brnsJ50uM9Ghze6jGncy+Se47fmZf308=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182380; c=relaxed/simple;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEv7TUAyjgEJKMRUdeBW5uKIMS0+STl/eiJL87RkZOv9mq6u2mKlc7iOSMf/lSVQ1uC8DJ83130RJsnUlDwy8S2A1lsLleRAV7E7nLWVgPDj2p3ByI4HP1jKvMYmY0J6s9Xi1vi5vttxe9lhs1VUETq9tUXkoAIfol+X4ZNEr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0ct7dtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F75EC433C7;
	Mon, 11 Mar 2024 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182379;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0ct7dtQr+kJ4jbhiBTp67eKHJU9oGS2xo8SvMu5SqeVh/K0sGmIG3ppZMbOmWeYC
	 3B+M9xLhyl3TDxs/XAv+UiTe12anYXsw6ZQQPm7ZKkEJ1frbsl+nRaeYYoJft6N1+l
	 +NxrBatgyHSOFwBcJrR4wx9C/bSSc+mjY+WFoXOJ/puHNWNYwTWxYd7UmF5mFg1Csg
	 dKLz2hjUc7IDv0rr00YZd5D9I6vUj+Og3JeBA+wvaEZARFnvkobxef0w/BrzOH6hdV
	 zP2F0XV2aqI1LzhrMACWdPxnqvlZHyOxTPXtcUGO/BQPD3B4wA/BjuFzbZOmQbRF56
	 F8vmzQB+3miow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 3/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:39:20 -0400
Message-ID: <20240311183923.328881-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183923.328881-1-sashal@kernel.org>
References: <20240311183923.328881-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.212
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


