Return-Path: <linux-kernel+bounces-95466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63315874DF5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E208B1F2328B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278212C7F1;
	Thu,  7 Mar 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uA5X1r/E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B3E12BF2D;
	Thu,  7 Mar 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811908; cv=none; b=bEUBjKtmpGXm4b5Z1u3CJW7Jo5J2j6/BivZ99ch/6kyu2Lkn4pIcQVDvHh6u977YjHa4MYsaMPf/kEJleOjic5RHXWD+PUFmzpUoaXeCBkrAXLGjJMKjm3sear+deSGnPkfjruGLkp5jIwNenDhloIsLKFI8Oql7A3SV1hR1NNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811908; c=relaxed/simple;
	bh=QN26t0rrc+NSqCdkkiNG9yykGnvaBYqQoqHRENbyT90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJzTv3FVuwDdXWOXWdpH06C1b3RbcFitWgwE7HcYx6EUK5K6fN7ydCo4IhRvW+GF8ersBJDgu3W2F9lQWwMBDFOy6VrMrTniT76H4GpileJFX/sY7Er5hA5qxhDJ+RGY8SvNS5mH6oQ20PX07+KQIKmtNwtDFlASQUlnq8X5eP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uA5X1r/E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709811905;
	bh=QN26t0rrc+NSqCdkkiNG9yykGnvaBYqQoqHRENbyT90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uA5X1r/EUyZbap1KSgmTfV2aVBnzOsLbZMukHMITrnaSlf6iyk1gcv2In7PJ+HFHf
	 gAJYpnX4jOYZLP9fkSgRsrRU/9xMRPW/C0ucWQkhxaYg3fuL2gMEmlosiPYT4Tmn/X
	 NBlVeIBNlDHhZ+1/TqwySNqmrcpOTwV+FX0SIQF5SviZrmT8+DYHt1YyzYEbKUfvRB
	 VOzpzYUq9Fy1twUGSBZPMMgjhskzWoj6D5x5rQZjWfRlYxBDtfxCF4PwhTrlUcpqBL
	 1H3L2d5pgLWuL+PIdmRGTnobU8FtPghy2vX5OHyvi3HiN7Us+7olXnrfRdwyjg2Iwt
	 SEGK0n5dZeZwg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CBCBF37820EA;
	Thu,  7 Mar 2024 11:45:02 +0000 (UTC)
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
Subject: [PATCH v2 05/22] ASoC: mediatek: Add common machine soundcard driver probe mechanism
Date: Thu,  7 Mar 2024 12:44:28 +0100
Message-ID: <20240307114445.196981-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
References: <20240307114445.196981-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a common machine soundcard driver probe function that supports both
DSP and AFE-direct usecases and also provides a hook for legacy machine
soundcard driver probe mechanisms.

Note that the hook is there because, even for legacy probe, a lot of the
actual code can still be commonized, hence still reducing duplication
for the legacy devicetree retrocompatibility cases.

This common probe function deprecates all of the inconsistent previous
probe mechanisms and aims to settle all of the MediaTek card drivers on
consistent and common devicetree properties describing wanted DAIs,
device specific DAI configuration and DAI links to codecs found on
each device/board.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/common/mtk-soc-card.h      |   7 +-
 .../mediatek/common/mtk-soundcard-driver.c    | 148 ++++++++++++++++++
 .../mediatek/common/mtk-soundcard-driver.h    |  18 +++
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-soc-card.h b/sound/soc/mediatek/common/mtk-soc-card.h
index eeda79370049..3f6e24dd22df 100644
--- a/sound/soc/mediatek/common/mtk-soc-card.h
+++ b/sound/soc/mediatek/common/mtk-soc-card.h
@@ -9,9 +9,14 @@
 #ifndef _MTK_SOC_CARD_H_
 #define _MTK_SOC_CARD_H_
 
+struct mtk_platform_card_data;
+struct mtk_sof_priv;
+
 struct mtk_soc_card_data {
+	const struct mtk_sof_priv *sof_priv;
+	struct list_head sof_dai_link_list;
+	struct mtk_platform_card_data *card_data;
 	void *mach_priv;
-	void *sof_priv;
 };
 
 #endif
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.c b/sound/soc/mediatek/common/mtk-soundcard-driver.c
index 000a086a8cf4..b1db17e392d5 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.c
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.c
@@ -10,6 +10,8 @@
 #include <linux/of.h>
 #include <sound/soc.h>
 
+#include "mtk-dsp-sof-common.h"
+#include "mtk-soc-card.h"
 #include "mtk-soundcard-driver.h"
 
 static int set_card_codec_info(struct snd_soc_card *card,
@@ -136,3 +138,149 @@ void clean_card_reference(struct snd_soc_card *card)
 		snd_soc_of_put_dai_link_codecs(dai_link);
 }
 EXPORT_SYMBOL_GPL(clean_card_reference);
+
+int mtk_soundcard_common_probe(struct platform_device *pdev)
+{
+	struct device_node *platform_node, *adsp_node;
+	const struct mtk_soundcard_pdata *pdata;
+	struct mtk_soc_card_data *soc_card_data;
+	struct snd_soc_dai_link *orig_dai_link, *dai_link;
+	struct snd_soc_jack *jacks;
+	struct snd_soc_card *card;
+	int i, orig_num_links, ret;
+	bool needs_legacy_probe;
+
+	pdata = device_get_match_data(&pdev->dev);
+	if (!pdata)
+		return -EINVAL;
+
+	card = pdata->card_data->card;
+	card->dev = &pdev->dev;
+	orig_dai_link = card->dai_link;
+	orig_num_links = card->num_links;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret)
+		return ret;
+
+	if (!card->name) {
+		if (!pdata->card_name)
+			return -EINVAL;
+
+		card->name = pdata->card_name;
+	}
+
+	needs_legacy_probe = !of_property_read_bool(pdev->dev.of_node, "audio-routing");
+	if (needs_legacy_probe) {
+		/*
+		 * If we have no .soc_probe() callback there's no way of using
+		 * any legacy probe mechanism, as that cannot not be generic.
+		 */
+		if (!pdata->soc_probe)
+			return -EINVAL;
+
+		dev_info_once(&pdev->dev, "audio-routing not found: using legacy probe\n");
+	} else {
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	soc_card_data = devm_kzalloc(&pdev->dev, sizeof(*soc_card_data), GFP_KERNEL);
+	if (!soc_card_data)
+		return -ENOMEM;
+
+	soc_card_data->card_data = pdata->card_data;
+
+	jacks = devm_kcalloc(card->dev, soc_card_data->card_data->num_jacks,
+			     sizeof(*jacks), GFP_KERNEL);
+	if (!jacks)
+		return -ENOMEM;
+
+	soc_card_data->card_data->jacks = jacks;
+
+	platform_node = of_parse_phandle(pdev->dev.of_node, "mediatek,platform", 0);
+	if (!platform_node)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "Property mediatek,platform missing or invalid\n");
+
+	/* Check if this SoC has an Audio DSP */
+	if (pdata->sof_priv)
+		adsp_node = of_parse_phandle(pdev->dev.of_node, "mediatek,adsp", 0);
+	else
+		adsp_node = NULL;
+
+	if (adsp_node) {
+		if (of_property_read_bool(pdev->dev.of_node, "mediatek,dai-link")) {
+			ret = mtk_sof_dailink_parse_of(card, pdev->dev.of_node,
+						       "mediatek,dai-link",
+						       card->dai_link, card->num_links);
+			if (ret) {
+				of_node_put(adsp_node);
+				of_node_put(platform_node);
+				return dev_err_probe(&pdev->dev, ret,
+						     "Cannot parse mediatek,dai-link\n");
+			}
+		}
+
+		soc_card_data->sof_priv = pdata->sof_priv;
+		card->probe = mtk_sof_card_probe;
+		card->late_probe = mtk_sof_card_late_probe;
+		if (!card->topology_shortname_created) {
+			snprintf(card->topology_shortname, 32, "sof-%s", card->name);
+			card->topology_shortname_created = true;
+		}
+		card->name = card->topology_shortname;
+	}
+
+	/*
+	 * Regardless of whether the ADSP is wanted and/or present in a machine
+	 * specific device tree or not and regardless of whether any AFE_SOF
+	 * link is present, we have to make sure that the platforms->of_node
+	 * is not NULL, and set to either ADSP (adsp_node) or AFE (platform_node).
+	 */
+	for_each_card_prelinks(card, i, dai_link) {
+		if (adsp_node && !strncmp(dai_link->name, "AFE_SOF", strlen("AFE_SOF")))
+			dai_link->platforms->of_node = adsp_node;
+		else if (!dai_link->platforms->name && !dai_link->platforms->of_node)
+			dai_link->platforms->of_node = platform_node;
+	}
+
+	if (!needs_legacy_probe) {
+		ret = parse_dai_link_info(card);
+		if (ret)
+			goto err_restore_dais;
+	} else {
+		if (adsp_node)
+			of_node_put(adsp_node);
+		of_node_put(platform_node);
+	}
+
+	if (pdata->soc_probe) {
+		ret = pdata->soc_probe(soc_card_data, needs_legacy_probe);
+		if (ret) {
+			if (!needs_legacy_probe)
+				clean_card_reference(card);
+			goto err_restore_dais;
+		}
+	}
+	snd_soc_card_set_drvdata(card, soc_card_data);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+
+	if (!needs_legacy_probe)
+		clean_card_reference(card);
+
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "Cannot register card\n");
+		goto err_restore_dais;
+	}
+
+	return 0;
+
+err_restore_dais:
+	card->dai_link = orig_dai_link;
+	card->num_links = orig_num_links;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mtk_soundcard_common_probe);
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.h b/sound/soc/mediatek/common/mtk-soundcard-driver.h
index d92cac1d7b72..44320efff5f8 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.h
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.h
@@ -9,6 +9,24 @@
 #ifndef _MTK_SOUNDCARD_DRIVER_H_
 #define _MTK_SOUNDCARD_DRIVER_H_
 
+struct mtk_sof_priv;
+struct mtk_soc_card_data;
+
+struct mtk_platform_card_data {
+	struct snd_soc_card *card;
+	struct snd_soc_jack *jacks;
+	u8 num_jacks;
+	u8 flags;
+};
+
+struct mtk_soundcard_pdata {
+	const char *card_name;
+	struct mtk_platform_card_data *card_data;
+	struct mtk_sof_priv *sof_priv;
+	int (*soc_probe)(struct mtk_soc_card_data *card_data, bool legacy);
+};
+
 int parse_dai_link_info(struct snd_soc_card *card);
 void clean_card_reference(struct snd_soc_card *card);
+int mtk_soundcard_common_probe(struct platform_device *pdev);
 #endif
-- 
2.44.0


