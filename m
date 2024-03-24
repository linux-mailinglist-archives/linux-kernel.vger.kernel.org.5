Return-Path: <linux-kernel+bounces-115136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F8888E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A69B2EBA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F261C6FE8;
	Mon, 25 Mar 2024 01:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV+jfXxV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B3229C07;
	Sun, 24 Mar 2024 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324135; cv=none; b=qPzYrGHvO28+fS+WWbGb5q+1PpaOjql0nDAezKiMtpoD/5c2Rh/HWorRJvi9NgbkWOCvt2lnT5zr4Tc6iMNskpidVDsDURQW3InT8ycnzoVB53Jmpr6R7pRJGwPoB1Mh81CMBzkgUPxXvzDeG8kf58Hhtzz1T/Q1M3B2usgVhx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324135; c=relaxed/simple;
	bh=XwLDNVI86IIwGddSOsCOTHlYxsyUqTfeAEzQBytVP1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TShfYmgKXLjWHmSlqfK9kOV8bG405MUhiZP+a+Pjk1rzhqcs875LtkL5YgqJfBXDabCUZ1a9K5W2DyPImo85M1kVvAxbBQVsmfS6saF63YwnFHZ0FoN4+cxglOG8eE12cy/V3UGzrpAB1JvgZqHZYqcEalA3nUeBM7G8gguNvjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV+jfXxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E43C43390;
	Sun, 24 Mar 2024 23:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324134;
	bh=XwLDNVI86IIwGddSOsCOTHlYxsyUqTfeAEzQBytVP1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV+jfXxVFzQOXGuQaxWR/crwwOF+VV6mKq6o6tIQeHLs7f3Fky1cGaBPd8XdJ/Gl0
	 49XtFFR9NuEbW15twegrtWhK6TNcL8j3brtN8addCWv7YGMNNYYq0PfxbA/OGD2FLp
	 1nZ5rq3eX271VRqb1+I+yE6bUZ+jCXjdNoSVW+rcX0e1oah5sKKXDhYUmOPDGrDEdC
	 /cQ8bYUArUlF5LaMKfH9QtBisHPt6Bfe/wH4bYjK75C0+FPeCAmVCat7zMXgud6yS7
	 ooJSOOC+0kU1zs0OrvwJDUYm/kZ5xoyhmZ23Bh2ivljbs/ocCNpk/SUtwGHDKFntk/
	 2H03h0QOHgT3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 131/183] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 19:45:44 -0400
Message-ID: <20240324234638.1355609-132-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index f5a431b8de6c3..34aff050caf25 100644
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


