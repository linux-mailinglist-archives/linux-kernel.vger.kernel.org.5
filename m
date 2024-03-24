Return-Path: <linux-kernel+bounces-116192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F350488A52D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F776B2C5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16D3BA323;
	Mon, 25 Mar 2024 03:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQ1W0nxx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E295284551;
	Sun, 24 Mar 2024 23:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323792; cv=none; b=r+l3ouKoDbH/GPYyWcO/+hvzED80XWWdwFUbp/wrmhmL+gDst1f9H5RsaXRDhq0gHEVfmd4oY9TQKCUqMecToQZj/ORyy4G8iBYXx8Orn1J8fnmacTuxBB5GLjcVRQD/WkqE2NHTmeZ0mp31/g1G2VFQbY8OuSbiS3Qfa/iuNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323792; c=relaxed/simple;
	bh=s6m5EmNhs2Ghj/NYFkNGqUdDS4byPtOw1zu8uhIlB5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEOfip5TD8Eeb6onJxAJnMDeemBdNbirTnLMbtr9lVZ6aYa5YzZNHE98nuXS5gPuxx7kPaMzmg4+uqdIiLsrG7aRue1ykVKi8e2xdnf+axsMkUpovCfZdcYSIL+lbgsMvD+IVN5bVz7jg/um4Bs/X518+aRTiilnJFtV5c2+Q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQ1W0nxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580F0C433F1;
	Sun, 24 Mar 2024 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323792;
	bh=s6m5EmNhs2Ghj/NYFkNGqUdDS4byPtOw1zu8uhIlB5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQ1W0nxx5wVIewUNDsMMfY7Q7JC0D3z2p/GSOmj3jAvYpZCrcVw7hxp2FVnuYKlVu
	 XCpl42vrH47lxFd4sdhn5EVVt4Ck1Yp9z1jh6IrZUYinIN/LoKd+ztAoKtzhF057Wj
	 dneVLUpTbdQBnDSGwX/tLE9O68wzWH3nj0QxmkgJfP925JjOG25S+mYNLS/WCc2J9Q
	 YI5E6CvgaVtjnU+nFdrgJM0q2pEDbkfL106WzMMlOPw5vI/sPSfqK8dx4obixyq8Po
	 x/KW6/FsziIrfS6AdLtH1v8zZ7LjmE60+7SGFeV+3T2LNW5ezVS0Cu6Vd3zXb/LtBy
	 gfh+/6YQg60Iw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 169/238] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 19:39:17 -0400
Message-ID: <20240324234027.1354210-170-sashal@kernel.org>
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
index e076ced300257..ac43a7ab7bcf6 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -266,8 +266,8 @@ static int axg_tdm_iface_set_sclk(struct snd_soc_dai *dai,
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


