Return-Path: <linux-kernel+bounces-83178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F1868FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A75DE1C24046
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D5213AA35;
	Tue, 27 Feb 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ljMaw76L"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607C13A89F;
	Tue, 27 Feb 2024 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035813; cv=none; b=LL9hJLefCuogYa9nTcRoGwzRtZJF2hafQe3w19n7uUPlLbKCCK83WvsgHoiR+wzGUAfoGYld7u0Q8qVYZuoVsO8JIv5uKo+VsZdaujY/ikUryF92j75viX+cTz8yzx5VgV0IBdZAOKRQK23OPKy00W7r/yOsW3Bc4bm4Pjcz85Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035813; c=relaxed/simple;
	bh=lC8iX2KU7tRIxTdsRwIKJVpK8yVv7zPRfikH6dLURbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6BkoRiGyNqycVJqNs/A8EZZ3yiYv/6iAO+nVJldFwf2BD7wO61aDr1N/dqZD4graXScobePCgPlILPZxBrRNz+E4ruy+QoZDEVaIDzQyTRA3+tKx0NvB+2wxUmSMNk4nn+zZSb5i7lkSJhTWlzXA6uqPmXeFrTtqI1ysDwG+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ljMaw76L; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709035809;
	bh=lC8iX2KU7tRIxTdsRwIKJVpK8yVv7zPRfikH6dLURbE=;
	h=From:To:Cc:Subject:Date:From;
	b=ljMaw76LQ2rUG/CVAwHU3rcYo7/G6YqsiB4NCcjtxG7iZGosTH0mnBTK3jbHNVryc
	 KqIQJ0+DTZvT1ehtJy2kaMH2ujoMuLpxKOpEsHFADO3YOImf4arICn7DJ+FOThak/8
	 KQSoQT/GxAE81k4VMh8giMMtqjZtX5Nb2Ai6HQBlvJv8fe0I0JLHZ6KgBCiznLaVdv
	 u6HBaMIN0UvOTBA9JMFS1p9izblk7bODgSvbRBuN0QTHDrOEiK+81zYhXz0CvVhatR
	 7FZfxb71Q08/3Mf2x0JguUyzimgAYCzoTTLWbdAfZSwdTuk0lqShwoTFtq4XqD4pIm
	 GiF8NiUPzpmTw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4B4537820CC;
	Tue, 27 Feb 2024 12:10:06 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: broonie@kernel.org
Cc: wenst@chromium.org,
	lgirdwood@gmail.com,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	trevor.wu@mediatek.com,
	maso.huang@mediatek.com,
	xiazhengqiao@huaqin.corp-partner.google.com,
	arnd@arndb.de,
	kuninori.morimoto.gx@renesas.com,
	shraash@google.com,
	amergnat@baylibre.com,
	nicolas.ferre@microchip.com,
	u.kleine-koenig@pengutronix.de,
	dianders@chromium.org,
	frank.li@vivo.com,
	allen-kh.cheng@mediatek.com,
	eugen.hristev@collabora.com,
	claudiu.beznea@tuxon.dev,
	jarkko.nikula@bitmer.com,
	jiaxin.yu@mediatek.com,
	alpernebiyasak@gmail.com,
	ckeepax@opensource.cirrus.com,
	zhourui@huaqin.corp-partner.google.com,
	nfraprado@collabora.com,
	alsa-devel@alsa-project.org,
	shane.chien@mediatek.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 00/22] ASoC: Cleanup MediaTek soundcard machine drivers
Date: Tue, 27 Feb 2024 13:09:17 +0100
Message-ID: <20240227120939.290143-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series performs a cleanup of most of the MediaTek AFE drivers and
soundcard machine drivers, reducing code duplication and setting a base
to be consistent with their devicetree bindings, as many of those are
using different properties and nodes for no good reason.

Summarizing:
 - Commonizes functions and ops where possible
 - Adds a common probe mechanism, increasing maintainability of
   soundcard drivers for older MediaTek SoCs
 - Migrates all drivers to support the new bindings
   - Obviously retains compatibility with old device trees
 - Reduces machine-specific parameters hardcoding in drivers
   - Can now set machine-specific params in device tree
   - Uses the `audio-routing` and `dai-link` nodes like some
     other non-MediaTek SoC sound drivers
 - Imposes consistency between MediaTek ASoC machine soundcard
   drivers bindings
 - Reduces code size and greatly reduces the amount of code that
   will be required for newer drivers (retaining compatibility with
   the old bindings was costly in terms of code size, otherwise
   this series would've removed ~1000 more lines, or something
   along that line).

This series was (manually) tested on MT8173, MT8192, MT8195 and MT8186
Chromebooks.

AngeloGioacchino Del Regno (22):
  ASoC: mediatek: mt8192-afe-pcm: Convert to devm_pm_runtime_enable()
  ASoC: mediatek: mt8192-afe-pcm: Simplify with dev_err_probe()
  ASoC: mediatek: Commonize ADDA rate transform functions and enums
  ASoC: mediatek: Assign dummy when codec not specified for a DAI link
  ASoC: mediatek: Add common machine soundcard driver probe mechanism
  ASoC: mediatek: common: Constify struct mtk_sof_priv
  ASoC: mediatek: mt8188: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8195: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8192: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: mt8186: Migrate to mtk_soundcard_common_probe
  ASoC: mediatek: Add common snd_soc_ops .startup() callback
  ASoC: mediatek: mt8195: Migrate to the common mtk_soundcard_startup
  ASoC: mediatek: mt8192: Migrate to the common mtk_soundcard_startup
  ASoC: mediatek: mt8186-rt1019: Migrate to the common
    mtk_soundcard_startup
  ASoC: mediatek: Add common mtk_afe_component_probe callback
  ASoC: mediatek: Use common mtk_afe_pcm_platform with common probe cb
  ASoC: mediatek: mt8186: Unify mt8186-mt6366 machine drivers
  ASoC: dt-bindings: mt8195: Document audio-routing and dai-link subnode
  ASoC: dt-bindings: mt8192: Document audio-routing and dai-link subnode
  ASoC: dt-bindings: mt8186: Document audio-routing and dai-link subnode
  arm64: dts: mediatek: mt8195-cherry: Specify sound DAI links and
    routing
  arm64: dts: mediatek: mt8186-corsola: Specify sound DAI links and
    routing

 .../sound/mt8186-mt6366-da7219-max98357.yaml  |  112 +-
 .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   |  112 +-
 .../sound/mt8192-mt6359-rt1015-rt5682.yaml    |  129 +-
 .../bindings/sound/mt8195-mt6359.yaml         |  123 ++
 .../boot/dts/mediatek/mt8186-corsola.dtsi     |   42 +-
 .../boot/dts/mediatek/mt8195-cherry.dtsi      |   45 +
 sound/soc/mediatek/Kconfig                    |   24 +-
 sound/soc/mediatek/common/Makefile            |    2 +
 .../mediatek/common/mtk-afe-platform-driver.c |   18 +
 .../soc/mediatek/common/mtk-dai-adda-common.c |   70 +
 .../soc/mediatek/common/mtk-dai-adda-common.h |   45 +
 .../soc/mediatek/common/mtk-dsp-sof-common.c  |   15 +-
 .../soc/mediatek/common/mtk-dsp-sof-common.h  |    1 -
 sound/soc/mediatek/common/mtk-soc-card.h      |    7 +-
 .../mediatek/common/mtk-soundcard-driver.c    |  205 ++-
 .../mediatek/common/mtk-soundcard-driver.h    |   42 +
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt6797/mt6797-dai-adda.c   |   85 +-
 sound/soc/mediatek/mt7986/mt7986-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c    |   14 +-
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c   |   90 +-
 sound/soc/mediatek/mt8186/Makefile            |    3 +-
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    |   19 +-
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c   |   94 +-
 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 1189 -----------------
 ...t6366-rt1019-rt5682s.c => mt8186-mt6366.c} |  578 ++++----
 sound/soc/mediatek/mt8188/mt8188-afe-pcm.c    |   21 +-
 sound/soc/mediatek/mt8188/mt8188-dai-adda.c   |   89 +-
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     |  203 +--
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |  114 +-
 sound/soc/mediatek/mt8192/mt8192-dai-adda.c   |   90 +-
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      |  301 ++---
 sound/soc/mediatek/mt8195/mt8195-afe-pcm.c    |   21 +-
 sound/soc/mediatek/mt8195/mt8195-dai-adda.c   |   90 +-
 sound/soc/mediatek/mt8195/mt8195-mt6359.c     |  487 +++----
 35 files changed, 1739 insertions(+), 2769 deletions(-)
 create mode 100644 sound/soc/mediatek/common/mtk-dai-adda-common.c
 create mode 100644 sound/soc/mediatek/common/mtk-dai-adda-common.h
 delete mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
 rename sound/soc/mediatek/mt8186/{mt8186-mt6366-rt1019-rt5682s.c => mt8186-mt6366.c} (72%)

-- 
2.44.0


