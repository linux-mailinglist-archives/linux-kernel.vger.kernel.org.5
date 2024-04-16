Return-Path: <linux-kernel+bounces-146386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD928A649E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8099B2836EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518A584FBA;
	Tue, 16 Apr 2024 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2IEdI4su"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9480611;
	Tue, 16 Apr 2024 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713251666; cv=none; b=LrMqezH3KiJPO6TkFc44zhPue4digEIGtz06jhGAi77aWWBw8qKl+sTEQDS5+nlgAm5DdTaWcDNbHr2/EvpOYL+B6zS1Wstm2ZJjYxlzKWbj82mVENE/iWgg9c5/G7jbAWcj2/w3EpyqL99wEVTPfaXihWFgg9aNL9mk3yDQdFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713251666; c=relaxed/simple;
	bh=sujJ+yH45hDcBjqKeWC7ARxj1AokpNPpDXwr5VjyZPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfe9fFqFMzEPB8NZ4gNXkoqcdDnCAlWZxvZ5olIu7OyiddziFXcVV0TL1hAYXHdA5a9d5s1HSolgMsQ0bRbE7UBHk+nruu2j9OKLPC1CjhERvVYAlK81nqkw3JD5cmATzrqpgxwwXYIfllPPf268P6dlB/aTW/WPPhH/eYR5Ei0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2IEdI4su; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713251663;
	bh=sujJ+yH45hDcBjqKeWC7ARxj1AokpNPpDXwr5VjyZPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2IEdI4suxMn1ims9sXpVJcEKFXWEBriNbbcqbkXyvaZFtPayxhpdn+PRp89Y9bymk
	 8R4RmOvuG+JqKaJMxrY2wHGWMZzVdQFs0wKUYVgXylQ3pjBo3su11IAJVPO75oCmhT
	 hCTBQvq36qAjvpraT6HTdLtW/M5YIcEZoOXIpoK/CIt48EOETPx2DS0TQrdd3CJG63
	 +JM9WrQlsFVMWUGJKXt8+MwDOIthdu7JF4hJIDquoCziHHYFfukuU5DdnP/NpI1KCD
	 tUokoRYUPPn6jtqyBq8lHmnrgEQl0bgThYFpa5Vm5tPcJxqzlBn27x7ojTSiZF53Au
	 z7mEzLrlz8LVQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 16680378211D;
	Tue, 16 Apr 2024 07:14:21 +0000 (UTC)
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
Subject: [PATCH v5 02/18] ASoC: mediatek: common: Constify struct mtk_sof_priv
Date: Tue, 16 Apr 2024 09:13:54 +0200
Message-ID: <20240416071410.75620-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
References: <20240416071410.75620-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apart from a dai_link_list variable, the mtk_sof_priv currently holds
data that never gets modified during runtime.

Constify the mtk_sof_priv structure and move the SOF dai_link_list as
sof_dai_link_list in struct mtk_soc_card_data, which is a structure
that already holds the card's machine specific, runtime modified data.

This allows to safely pass the mtk_sof_priv structure as platform data
for the commonized card probe mechanism.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/common/mtk-dsp-sof-common.c   | 15 +++++++--------
 sound/soc/mediatek/common/mtk-dsp-sof-common.h   |  1 -
 sound/soc/mediatek/common/mtk-soc-card.h         |  2 +-
 sound/soc/mediatek/common/mtk-soundcard-driver.h |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.c b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
index 7ec8965a70c0..bca758dca2c9 100644
--- a/sound/soc/mediatek/common/mtk-dsp-sof-common.c
+++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
@@ -15,7 +15,7 @@ int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_soc_card *card = rtd->card;
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	const struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
 	int i, j, ret = 0;
 
 	for (i = 0; i < sof_priv->num_streams; i++) {
@@ -55,7 +55,6 @@ int mtk_sof_card_probe(struct snd_soc_card *card)
 	int i;
 	struct snd_soc_dai_link *dai_link;
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
 
 	/* Set stream_name to help sof bind widgets */
 	for_each_card_prelinks(card, i, dai_link) {
@@ -63,7 +62,7 @@ int mtk_sof_card_probe(struct snd_soc_card *card)
 			dai_link->stream_name = dai_link->name;
 	}
 
-	INIT_LIST_HEAD(&sof_priv->dai_link_list);
+	INIT_LIST_HEAD(&soc_card_data->sof_dai_link_list);
 
 	return 0;
 }
@@ -73,7 +72,7 @@ static struct snd_soc_pcm_runtime *mtk_sof_find_tplg_be(struct snd_soc_pcm_runti
 {
 	struct snd_soc_card *card = rtd->card;
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	const struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
 	struct snd_soc_pcm_runtime *fe;
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
@@ -113,7 +112,7 @@ static int mtk_sof_check_tplg_be_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 {
 	struct snd_soc_card *card = rtd->card;
 	struct mtk_soc_card_data *soc_card_data = snd_soc_card_get_drvdata(card);
-	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	const struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
 	struct snd_soc_pcm_runtime *sof_be;
 	struct mtk_dai_link *dai_link;
 	int ret = 0;
@@ -125,7 +124,7 @@ static int mtk_sof_check_tplg_be_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		else if (sof_be->dai_link->be_hw_params_fixup)
 			ret = sof_be->dai_link->be_hw_params_fixup(sof_be, params);
 	} else {
-		list_for_each_entry(dai_link, &sof_priv->dai_link_list, list) {
+		list_for_each_entry(dai_link, &soc_card_data->sof_dai_link_list, list) {
 			if (strcmp(dai_link->name, rtd->dai_link->name) == 0) {
 				if (dai_link->be_hw_params_fixup)
 					ret = dai_link->be_hw_params_fixup(rtd, params);
@@ -144,7 +143,7 @@ int mtk_sof_card_late_probe(struct snd_soc_card *card)
 	struct snd_soc_component *sof_comp = NULL;
 	struct mtk_soc_card_data *soc_card_data =
 		snd_soc_card_get_drvdata(card);
-	struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
+	const struct mtk_sof_priv *sof_priv = soc_card_data->sof_priv;
 	struct snd_soc_dai_link *dai_link;
 	struct mtk_dai_link *mtk_dai_link;
 	int i;
@@ -173,7 +172,7 @@ int mtk_sof_card_late_probe(struct snd_soc_card *card)
 			mtk_dai_link->be_hw_params_fixup = dai_link->be_hw_params_fixup;
 			mtk_dai_link->name = dai_link->name;
 
-			list_add(&mtk_dai_link->list, &sof_priv->dai_link_list);
+			list_add(&mtk_dai_link->list, &soc_card_data->sof_dai_link_list);
 		}
 
 		if (dai_link->no_pcm)
diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.h b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
index 4bc5e1c0c8ed..8784ee471132 100644
--- a/sound/soc/mediatek/common/mtk-dsp-sof-common.h
+++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.h
@@ -30,7 +30,6 @@ struct mtk_sof_priv {
 	int num_streams;
 	int (*sof_dai_link_fixup)(struct snd_soc_pcm_runtime *rtd,
 				  struct snd_pcm_hw_params *params);
-	struct list_head dai_link_list;
 };
 
 int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/mediatek/common/mtk-soc-card.h b/sound/soc/mediatek/common/mtk-soc-card.h
index d92dc36d4577..3f6e24dd22df 100644
--- a/sound/soc/mediatek/common/mtk-soc-card.h
+++ b/sound/soc/mediatek/common/mtk-soc-card.h
@@ -13,7 +13,7 @@ struct mtk_platform_card_data;
 struct mtk_sof_priv;
 
 struct mtk_soc_card_data {
-	struct mtk_sof_priv *sof_priv;
+	const struct mtk_sof_priv *sof_priv;
 	struct list_head sof_dai_link_list;
 	struct mtk_platform_card_data *card_data;
 	void *mach_priv;
diff --git a/sound/soc/mediatek/common/mtk-soundcard-driver.h b/sound/soc/mediatek/common/mtk-soundcard-driver.h
index 44320efff5f8..4fd2ffb7e486 100644
--- a/sound/soc/mediatek/common/mtk-soundcard-driver.h
+++ b/sound/soc/mediatek/common/mtk-soundcard-driver.h
@@ -22,7 +22,7 @@ struct mtk_platform_card_data {
 struct mtk_soundcard_pdata {
 	const char *card_name;
 	struct mtk_platform_card_data *card_data;
-	struct mtk_sof_priv *sof_priv;
+	const struct mtk_sof_priv *sof_priv;
 	int (*soc_probe)(struct mtk_soc_card_data *card_data, bool legacy);
 };
 
-- 
2.44.0


