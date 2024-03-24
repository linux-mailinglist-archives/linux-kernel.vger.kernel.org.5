Return-Path: <linux-kernel+bounces-114874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03838892DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E0BB27117
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC072CB3EC;
	Mon, 25 Mar 2024 00:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgAsQDev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4921AFFA;
	Sun, 24 Mar 2024 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323519; cv=none; b=k+9IZsVTdY1NRmcEMDZ+Tv1yh0J9YhBSFcim6n95TaivA1DuDd/N2FUCz6DYL+uUpWUvhmNs/GJu9GJ2ezeaPv3k+Dw7BCoQoOdrKyEhemoXUn91zVpTuo87eZympZqAZKteHEpYk5bKOUKrm3xVWtFolW5PiE8U6YVl6UpKCPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323519; c=relaxed/simple;
	bh=s6m5EmNhs2Ghj/NYFkNGqUdDS4byPtOw1zu8uhIlB5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEJRcqEje5tYxdhoItMmTfQVwxlX5AqYYwucnyIQBOGxCxjE1r/c98im2v3So5o7ex2kGe3Tevz8vxFpeOcWWOPSpguFSx2jXnysqtEECS2Odx/pltDF5QiX5ZHIWEIcfyNYGRyeNFz+Q3wNtIZj4JR6fv8NkycrdwTppPK4oOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgAsQDev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E90C43394;
	Sun, 24 Mar 2024 23:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323519;
	bh=s6m5EmNhs2Ghj/NYFkNGqUdDS4byPtOw1zu8uhIlB5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mgAsQDevOU7VLUajvkOMkyQfBW+zh3yYzzPlA5p/VVynhnqpI/vSmoGFl9MPJT4v1
	 c+SNWYYRSvHZpcB7OIlD75qdNDiHUZhotKxk2EsPZfHQygKZJAbsJwm/qNDDeY0zEb
	 W88jG6fyYIaUvZfcPcVO4bF0Lm8/ALE8AGAP/o+MckhJEkl/au7xebpeegBqchyxkh
	 Be6CGTHG8nfgNocgOKgVS8KpIttjZl1758tMPwjGQHZgWwGE315uHB0R+if4hgdbF1
	 2v6Rb110RMqFIhhyAsXisz4DTR12u4e2ip30o683jWqLmzMefrAfhXljvsTw0QOTOu
	 Fno/VQW4sfcWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 226/317] ASoC: meson: axg-tdm-interface: fix mclk setup without mclk-fs
Date: Sun, 24 Mar 2024 19:33:26 -0400
Message-ID: <20240324233458.1352854-227-sashal@kernel.org>
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


