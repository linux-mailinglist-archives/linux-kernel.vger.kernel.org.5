Return-Path: <linux-kernel+bounces-114341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA52888FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA4C1F272D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78F426A19C;
	Sun, 24 Mar 2024 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kI2ZMNuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2B5213427;
	Sun, 24 Mar 2024 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321729; cv=none; b=kHRlyQD3yrK18iFwxAgaA2tcKZ600pjFS+hzWlTDcntRWyVCr4o87gjZlsNqoj5WD6tYfLNhY/CsVAd7nJKw+89rNAodG3ctbqoZNNCbO/s2NIOieqi8FpK/iO2TKDkHG1XyI67XpWvVXvLH5MGMK1VZpuarMlRiacPQnP4CHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321729; c=relaxed/simple;
	bh=M1XBoXiOTq0p7mgERHXcig2Q0cM/9V/unK6ZP5x0oO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPv//Ec8GJT5snAGZM3U3SuFB1FCIEmq7QRIQuDgS2anV5t+oEddmOhaqUK+y8JInexAdUconPsvEnNRSz6e78Nc9TXq4jiMVSu05n0MrR7ONpTlBnU4WrJPLKs5qmt6U0+YLOxZycsDkW0iRTUlynFzpgOo0ee9mJZuriol0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kI2ZMNuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AA9C43330;
	Sun, 24 Mar 2024 23:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321727;
	bh=M1XBoXiOTq0p7mgERHXcig2Q0cM/9V/unK6ZP5x0oO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kI2ZMNuCDyrgK2hxdOo/vD5gVKy4yapW4SR2pGrv0iyImNksDheDYguzwLcQKvqjq
	 u7F7b+ag3ObVkE9z5PnLRP3sCE1aC9G2DnqA9N9a/aoNW/tQCr+7h9qtnNwuDIkrFW
	 SpgkhLmEZPqRgqrI5iIVfnQZ4HwuHmxSx+nhbJMW3bikCggrIfUswGY4Td6SDd91IW
	 l4FX7RJqZFYmNUvSo27OuQn/+MbhbsEAJJ92mNlbo1W7aNDe02cyKhbsyj0M0ayLiP
	 pEdVtOUb/bii/WGjGKTymxr49ajCvAdpj92ipwoH3XyHHTHL80t+tdJh/emnInM+77
	 ArRUaXUjsjjVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 456/638] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 18:58:13 -0400
Message-ID: <20240324230116.1348576-457-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit e3741a8d28a1137f8b19ae6f3d6e3be69a454a0a ]

By default, when mclk-fs is not provided, the tdm-interface driver
requests an MCLK that is 4x the bit clock, SCLK.

However there is no justification for this:

* If the codec needs MCLK for its operation, mclk-fs is expected to be set
  according to the codec requirements.
* If the codec does not need MCLK the minimum is 2 * SCLK, because this is
  minimum the divider between SCLK and MCLK can do.

Multiplying by 4 may cause problems because the PLL limit may be reached
sooner than it should, so use 2x instead.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://msgid.link/r/20240223175116.2005407-2-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 1c3d433cefd23..cd5168e826df4 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -264,8 +264,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
 	srate = iface->slots * iface->slot_width * params_rate(params);
 
 	if (!iface->mclk_rate) {
-		/* If no specific mclk is requested, default to bit clock * 4 */
-		clk_set_rate(iface->mclk, 4 * srate);
+		/* If no specific mclk is requested, default to bit clock * 2 */
+		clk_set_rate(iface->mclk, 2 * srate);
 	} else {
 		/* Check if we can actually get the bit clock from mclk */
 		if (iface->mclk_rate % srate) {
-- 
2.43.0


