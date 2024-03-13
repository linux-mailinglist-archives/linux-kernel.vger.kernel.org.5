Return-Path: <linux-kernel+bounces-101395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C587A692
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0CE280BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6343F8F7;
	Wed, 13 Mar 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mIOzWzEx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9981F3EA95;
	Wed, 13 Mar 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327756; cv=none; b=gRiawPiVOXxOgMpJOE5ZTKO4cevufvtSP5/KhBIklTEpEAC4ccUciOvNhmXTe03oCjbIEuX8Dxhx3x3u0VHkmMq9vez47VzokYHMSOPASZgKSdSU2G5zX1tVXKTBfIDeoriYal0L5f825cf+DI2zNN1TSfA6lfK1ONnRJwX8A3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327756; c=relaxed/simple;
	bh=ClgWR4mgcTFs9Nig5y7IuRN0DOliEM0btt6YY0gL/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARHVXdD4QQ+kyNhbbvtkl4EKYXXPTF80m45EDaloUk/Eh4XDUbYfsl4+M85hwgOSCUBudsb2IQ+9POkXEcxf3mazCIv7UL+YoXBgdQrXK12rxdwgc9EKR6UE2S5ju/EWeW7d27YzLC1ySsteo/45wEDy9tlUPKQ1idli7rpEPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mIOzWzEx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710327753;
	bh=ClgWR4mgcTFs9Nig5y7IuRN0DOliEM0btt6YY0gL/ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIOzWzExBH4AplqiqK8P0VL9xCv+EU2v1zCfJkG5IndrnoPTxJocT5jYYQurRhuQw
	 T5Rv2wfU8+effzYeAeVKRWcwaOtwgzkpx2qqrXiPd9EPJF4v7YMPz+JelPNK8zsTSD
	 BcyQctx/OWi8hVyeJShzyxetvtkHaTijB/2359a6VoG3bnGPDXOuVuFKQmju7nX5sz
	 +nTOi5DXjba5SwCiVPvXA+YExdBd6VCkHIpxc3SemQlXAyIGm4NSdpsIOhHUOY1dhq
	 cCOC4dengMngDaFYnK7ljzR5EEMkVIjWQWutpwV8+PIxU9pX3ENxGS9kx94888DrBP
	 0VQFirJrBCFlQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0E55E37820C6;
	Wed, 13 Mar 2024 11:02:31 +0000 (UTC)
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
Subject: [PATCH v3 15/22] ASoC: mediatek: Add common mtk_afe_component_probe callback
Date: Wed, 13 Mar 2024 12:01:40 +0100
Message-ID: <20240313110147.1267793-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
References: <20240313110147.1267793-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple MediaTek AFE PCM component drivers are using their own .probe()
callback, but most of those are simply duplicated functions as they are
doing exactly the same thing over and over.

Add a common probe callback for this component to reduce duplication.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../mediatek/common/mtk-afe-platform-driver.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/mediatek/common/mtk-afe-platform-driver.c b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
index 32edcb6d5219..9b72b2a7ae91 100644
--- a/sound/soc/mediatek/common/mtk-afe-platform-driver.c
+++ b/sound/soc/mediatek/common/mtk-afe-platform-driver.c
@@ -126,10 +126,28 @@ int mtk_afe_pcm_new(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_new);
 
+static int mtk_afe_component_probe(struct snd_soc_component *component)
+{
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	snd_soc_component_init_regmap(component, afe->regmap);
+
+	/* If the list was never initialized there are no sub-DAIs */
+	if (afe->sub_dais.next && afe->sub_dais.prev) {
+		ret = mtk_afe_add_sub_dai_control(component);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 const struct snd_soc_component_driver mtk_afe_pcm_platform = {
 	.name		= AFE_PCM_NAME,
 	.pointer	= mtk_afe_pcm_pointer,
 	.pcm_construct	= mtk_afe_pcm_new,
+	.probe		= mtk_afe_component_probe,
 };
 EXPORT_SYMBOL_GPL(mtk_afe_pcm_platform);
 
-- 
2.44.0


