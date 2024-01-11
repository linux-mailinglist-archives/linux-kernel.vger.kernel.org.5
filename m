Return-Path: <linux-kernel+bounces-23414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E65482AC7A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733531C216F0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD2214F65;
	Thu, 11 Jan 2024 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MV14cYbr"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1722A134D0;
	Thu, 11 Jan 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704970351;
	bh=oM426rgWRaHFG49ZkqSvY5eJEqycjUK/T8+1O717p7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=MV14cYbrQRMTh3s6VbeVCU2Tu0bczc/Orb4g9f0YzLnC1H49FMbFFcIeK8s1a5dhs
	 xQA2zLSDm/22ssekiagcTGE9NQwQaEfcmIuRSddLUeEgEo/S/eMwut/cvEeIXy4Zog
	 QyFDaIx+sa61NqqvMFWgLsLFpwUEEbUuA5yJgINTwMoXlUGXTFu/UjeHIWRlPaM6JI
	 3N35SU2g+ENrpn6Pj7VgFLyRW/UD+sqVwHCNqMeLq3gYqrzf8/pz8/dWCEsi1ypDml
	 0COYGnOI0KMrE0f53mTne4SBXBGqqXeE3tJJULVIFibQNanEJd6XE3hvzTJr/6GysV
	 0RlTpmPSpWniA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6FB1837811D1;
	Thu, 11 Jan 2024 10:52:30 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	trevor.wu@mediatek.com,
	kuninori.morimoto.gx@renesas.com,
	chunxu.li@mediatek.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: mediatek: sof-common: Add NULL check for normal_link string
Date: Thu, 11 Jan 2024 11:52:26 +0100
Message-ID: <20240111105226.117603-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not granted that all entries of struct sof_conn_stream declare
a `normal_link` (a non-SOF, direct link) string, and this is the case
for SoCs that support only SOF paths (hence do not support both direct
and SOF usecases).

For example, in the case of MT8188 there is no normal_link string in
any of the sof_conn_stream entries and there will be more drivers
doing that in the future.

To avoid possible NULL pointer KPs, add a NULL check for `normal_link`.

Fixes: 0caf1120c583 ("ASoC: mediatek: mt8195: extract SOF common code")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/mediatek/common/mtk-dsp-sof-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/common/mtk-dsp-sof-common.c b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
index f3894010f656..7ec8965a70c0 100644
--- a/sound/soc/mediatek/common/mtk-dsp-sof-common.c
+++ b/sound/soc/mediatek/common/mtk-dsp-sof-common.c
@@ -24,7 +24,7 @@ int mtk_sof_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		struct snd_soc_dai_link *sof_dai_link = NULL;
 		const struct sof_conn_stream *conn = &sof_priv->conn_streams[i];
 
-		if (strcmp(rtd->dai_link->name, conn->normal_link))
+		if (conn->normal_link && strcmp(rtd->dai_link->name, conn->normal_link))
 			continue;
 
 		for_each_card_rtds(card, runtime) {
-- 
2.43.0


