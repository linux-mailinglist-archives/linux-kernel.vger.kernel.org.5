Return-Path: <linux-kernel+bounces-13070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EC81FF3D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 12:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537B92827B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6CD11188;
	Fri, 29 Dec 2023 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P8P+qE2D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED8F1118C;
	Fri, 29 Dec 2023 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703850229;
	bh=/XUlLtN0OxNKjkOJY7EN5g0ejaPbJLN+tXv+cAsFoO0=;
	h=From:To:Cc:Subject:Date:From;
	b=P8P+qE2Dr4SdxxZxZVWTVycv0wuw0hQNA9rlk+75OvuRAOyl49K4sPBUsh7UVcrH1
	 JQcdy0L1oHiDCwoh19hfvmHLy69+stMoc15UMGbS6v8lilmPSWNgawImb4zeONS/Ux
	 1Tb2DYp0R88ewniCzT67LGc0tM3LvHpYsajTB/BYyNjznhbFLRFUqjdAN4EAih/Uib
	 YIE8W0ivxVblq/f9Ow58CUxUUHSasWzd8Vf9Iu1JdkvHq3aq0NwtJEzxvdFfoeoiH6
	 CRl/GyPC45TNODnsxvrdZ0R/+MSFT4bByCEYqyUVV+PeEoK40je76qTGAvG9Z2JCEB
	 ryT/iDW3RXaYg==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 40DE73780894;
	Fri, 29 Dec 2023 11:43:48 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: linux-sound@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: broonie@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	allen-kh.cheng@mediatek.com,
	jiaxin.yu@mediatek.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	Eugen Hristev <eugen.hristev@collabora.com>
Subject: [PATCH] ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset
Date: Fri, 29 Dec 2023 13:43:42 +0200
Message-Id: <20231229114342.195867-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AUD_PAD_TOP widget's correct register is AFE_AUD_PAD_TOP , and not zero.
Having a zero as register, it would mean that the `snd_soc_dapm_new_widgets`
would try to read the register at offset zero when trying to get the power
status of this widget, which is incorrect.

Fixes: b65c466220b3 ("ASoC: mediatek: mt8186: support adda in platform driver")
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 sound/soc/mediatek/mt8186/mt8186-dai-adda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
index 85ae3f76d951..ad6d4b5cf697 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-adda.c
@@ -499,7 +499,7 @@ static const struct snd_soc_dapm_widget mtk_dai_adda_widgets[] = {
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 
 	SND_SOC_DAPM_SUPPLY_S("AUD_PAD_TOP", SUPPLY_SEQ_ADDA_AUD_PAD_TOP,
-			      0, 0, 0,
+			      AFE_AUD_PAD_TOP, RG_RX_FIFO_ON_SFT, 0,
 			      mtk_adda_pad_top_event,
 			      SND_SOC_DAPM_PRE_PMU),
 	SND_SOC_DAPM_SUPPLY_S("ADDA_MTKAIF_CFG", SUPPLY_SEQ_ADDA_MTKAIF_CFG,
-- 
2.34.1


