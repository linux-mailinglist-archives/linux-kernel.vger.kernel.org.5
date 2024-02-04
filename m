Return-Path: <linux-kernel+bounces-51910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B339C84909F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659851F21BEC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8552BD1C;
	Sun,  4 Feb 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myFRwBFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03362C68F;
	Sun,  4 Feb 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707081756; cv=none; b=KnWoO+Poqq8S7Edq/JjxPBjlRldu6W+AM9IipgsRQWHZtpJ0P8c3BKZ+oPmT46fMysBWpDitYKK+A1i0Ggjf55VrH4tFZ4vSAEoY92z8lY4INDLstLgcWlVcuHQugPtfleEBPYe1PQ4tfY7hXghhhVWQRvfgBoXloZL+Um6chik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707081756; c=relaxed/simple;
	bh=19YsFeFhaGh/mSKxE5Vjn63fd5qD0OXsxFoyJDZmE8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mHkuZoJ+iy2XzNMzUqvTcEI1mBwqaZ00ElP5584iXs4Np1EnzXRAuuJJM+UK1lBsXk9Ou7nD5oJ1DQlBUhcelRBqErirIrbDCXkLlJoB0F6UxgVGafIoSdKHaBU7Smw+gLuKC+YoEnW4vkPHThcDOTyOQIXtsPX/9S7iIBITvSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myFRwBFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C63C433F1;
	Sun,  4 Feb 2024 21:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707081755;
	bh=19YsFeFhaGh/mSKxE5Vjn63fd5qD0OXsxFoyJDZmE8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myFRwBFwMCZmakox81paGcwuF+C8pJP+j6xPXIsuXVlyPjXZrHpsz/cPsbBSXwf81
	 d3YEFKFiOyKeCSiKVm1TkNXBamw4R2oyivuX7qvwN9Vkw6UBRqXNQMGNLUn38TTeRU
	 R7U46kLUkG1m2nIAuCzoQZlXJ5nUe1tN53CynyKDGYf/iwJnFw/GAAdMXTsEx0oXpf
	 Q8VQ/zLIZxGyfC5I175QLoVSY9HdVqV7zQGiv9a/IYYvDWAs5X9pVUHA+Xpcdk4hkb
	 DWnCK7/6YfKVlWpr2qfv+FXCXSrboC3cArvXdujC4TTRX9sHKBJXdK691t5hhs0D3c
	 ReXX9WH9P0B2g==
From: Arnd Bergmann <arnd@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Weidong Wang <wangweidong.a@awinic.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fix SND_SOC_WCD939X dependencies
Date: Sun,  4 Feb 2024 22:22:02 +0100
Message-Id: <20240204212207.3158914-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240204212207.3158914-1-arnd@kernel.org>
References: <20240204212207.3158914-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

SND_SOC_WCD939X has an optional dependency on TYPEC, so the newly added
SND_SOC_WCD939X_SDW option that selects it needs the same dependency, otherwise
it can fail randconfig builds like:

WARNING: unmet direct dependencies detected for SND_SOC_WCD939X
  Depends on [m]: SOUND [=y] && SND [=y] && SND_SOC [=y] && SND_SOC_WCD939X_SDW [=y] && (SOUNDWIRE [=y] || !SOUNDWIRE [=y]) && (TYPEC [=m]
 || !TYPEC [=m])
  Selected by [y]:
  - SND_SOC_WCD939X_SDW [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && SOUNDWIRE [=y]
arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_soc_codec_remove':
wcd939x.c:(.text+0x1950): undefined reference to `wcd_clsh_ctrl_free'
arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_codec_ear_dac_event':
wcd939x.c:(.text+0x35d8): undefined reference to `wcd_clsh_ctrl_set_state'
arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_codec_enable_hphr_pa':
wcd939x.c:(.text+0x39b0): undefined reference to `wcd_clsh_ctrl_set_state'
arm-linux-gnueabi-ld: wcd939x.c:(.text+0x39dc): undefined reference to `wcd_clsh_set_hph_mode'
arm-linux-gnueabi-ld: wcd939x.c:(.text+0x3bc0): undefined reference to `wcd_clsh_ctrl_set_state'

Fixes: be2af391cea0 ("ASoC: codecs: Add WCD939x Soundwire devices driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 75d88bd1dc6f..58ee431edfd8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2084,6 +2084,7 @@ config SND_SOC_WCD939X
 
 config SND_SOC_WCD939X_SDW
 	tristate "WCD9390/WCD9395 Codec - SDW"
+	depends on TYPEC || !TYPEC
 	select SND_SOC_WCD939X
 	select SND_SOC_WCD_MBHC
 	select REGMAP_IRQ
-- 
2.39.2


