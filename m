Return-Path: <linux-kernel+bounces-99423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061D2878820
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899D2B23E69
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F7657C6;
	Mon, 11 Mar 2024 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcbY2YIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5935657BF;
	Mon, 11 Mar 2024 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182403; cv=none; b=bTl/T8kEtcq6C3UKEhIbIx5qrUyIxnvtyquewu45IstSvVkDYQRnSMGYJE4gq4rCYqyUA9tR3ETLI5vu3ZBJAmaapzZ3+p4+/o+74tWgREr/+sKLJraokdbKabRiKKDYWAX/nZNI/VYKOppSAIvrUM03caWogaDN53CpvKsOeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182403; c=relaxed/simple;
	bh=Omoo0aUsEXS6COkhR0n4ABgkiK51ZXRtWGZSWByn3pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HtjDDeE6GCknTyjGOtmLi2sXk2CaG4s6kC2HzfA8KobNKou7elTh3uM3jZFpi565qrDu8mzRB0ly4Z/Egn5h7nvXFjv7nvUe4Z1EpNnoqmFWB02rBcByFkLxUjKoKDM5PcCUM0kJm8c9RDFVzZuQZ1JAjp+XlKSfMuYgAVhVUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcbY2YIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64578C43394;
	Mon, 11 Mar 2024 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182403;
	bh=Omoo0aUsEXS6COkhR0n4ABgkiK51ZXRtWGZSWByn3pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jcbY2YIv4AErH3p3YyXISevMxF2rSzUme8v7iLTBXfTTSzwGgyfhzIdGYRM9hjajw
	 hPqSESW5/fSJG79GbgwLLQET6S4gDeJtr3ewIdCFaYdBS1k093xR/ALCU9cZIq/3Wx
	 BjINfGNCxz+C2IdNbt5qCwCF+ZsnTimG3tcXrhGGL6j/a7lhiscmdVnxLvfIhpBSO+
	 2sUaHKJb0LsCAGxZdVYoydmWsRHYFqF/tYxEb2TsBP/l8SwYMd0XwDS5NZZP8o7iZL
	 QrY19nZ52gC7OOW2IHKTbyjKOJAbAdqXHbGt/DM86hMIf37r7CqIxfFrB/2Qetq6Ce
	 1mSideiBcQV8w==
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
Subject: [PATCH AUTOSEL 5.4 3/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:39:47 -0400
Message-ID: <20240311183950.329120-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183950.329120-1-sashal@kernel.org>
References: <20240311183950.329120-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
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
index c384ca3681e9b..c84afc1d02dab 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2889,8 +2889,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
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


