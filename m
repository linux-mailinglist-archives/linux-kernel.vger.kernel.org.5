Return-Path: <linux-kernel+bounces-115506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A71889BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7DC1F333A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E0B236CE0;
	Mon, 25 Mar 2024 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqNU94hC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96C1EC626;
	Sun, 24 Mar 2024 22:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320946; cv=none; b=B4d4EYVhvKKehi9McLx1dgcLPJb3QIFHZN8lCIlNgctzBARjjCCEHJZDXRT9Gzm/OR5fbGuIE40grReEgmUDVSAFC5jjsjQ5lD53GW5rRlnV4GLDRZhPwckoEWJ237v8msDLXLscnf2wWNmXDozrPDW7InaD2oNgbtXddG6tCdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320946; c=relaxed/simple;
	bh=M1XBoXiOTq0p7mgERHXcig2Q0cM/9V/unK6ZP5x0oO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auxx6kGgLWPSfcZ0VCJXW/9RlyciLKU6QTOVmNDQeelEPxyiAt4nV5tladSlalLpK4rvsrwxLZnq7zRIvuRcMSu+PP16YNHmI2GUrj4IdQQGZsb/J57jdDJWouv48XvQ1Z6I0qyeI/35FlWtaK0QJc+fg8YPu/CztJQaoQWKQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqNU94hC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C4EC43394;
	Sun, 24 Mar 2024 22:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320946;
	bh=M1XBoXiOTq0p7mgERHXcig2Q0cM/9V/unK6ZP5x0oO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqNU94hCe32JH6bwyyI3mUcHmkuzgJFjRCOaC/QmVb49SO6OhY8HKwQNdEWT+YLo/
	 WDI0mXFQJcZx140T/BlACMECWS2ZoHyk8qIXoDvnUEwLuGM+i5iRL3/VDZHeV+3Rq2
	 s98j/vyjjUMDvWHzbgP1Zhl/KFvjHeZZiZi9xEoVFwuBglJxLT8jEahMTCjqmMg83t
	 kRa+SboMn6+/fy6cntjPQLjLtGU87Ahxir5BjnmQbtT0EXQdWt0DmHEQNmsoXgTfe7
	 LXspQuF6lYwFrOy538okoy7MgtFSmg08Dv17bNObV1Jso8j1kN5t3OIrqbkcIup5Oz
	 gRYYB853T+XcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 510/713] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 18:43:56 -0400
Message-ID: <20240324224720.1345309-511-sashal@kernel.org>
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


