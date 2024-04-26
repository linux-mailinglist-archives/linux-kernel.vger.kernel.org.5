Return-Path: <linux-kernel+bounces-159747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C658E8B338E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BE91C2112E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F40C13FD8A;
	Fri, 26 Apr 2024 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdu7msck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00513D299;
	Fri, 26 Apr 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122350; cv=none; b=Xk2mOfXyXdzLFwSSePJNQCI0354I0eQy+Zm5bfrq2k+YmePOr7VUAczIGyC38vGDE7CkthrV1zc0Rc+mEO72DSrlaSKOONJOMBB4nfWIzBo443P+EzHruvAmj2QHJyvoQXHYrZRJBbU7+JJ67mjoRLE0veE7VJJd54ppCDQBv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122350; c=relaxed/simple;
	bh=OmWsR1whBin0FkWyWjikvJi4ntg0jTMwYm6UxGalLwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJAj3qvz4pok2qPRLchF6NHi7rzGF+kqQqjQI8SEKnmM5RRSz9PdIjsLuHY+lc+Uhy29DOV60oHQ/YqedP6Id6iLroLI1NJ1h0JGAuiPlAhj9bJ+XO6gXxSwRYmbVRhhiurCfgrY5cVTkjJCn5BVRNecKx3CtfXaY5+HscyZssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdu7msck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470ABC113CD;
	Fri, 26 Apr 2024 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122349;
	bh=OmWsR1whBin0FkWyWjikvJi4ntg0jTMwYm6UxGalLwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Hdu7msckPY9+UmLMRoJM9T7ZsGeKXiX/bjBsUMJhD2iffwU5uae8550h9gvdi9xOZ
	 jUY6iGKUP5Mj6XBCRv453Uv1+cR783janwVB3LmT5kIzNx4wxpmhlW1ToEOExWFv6J
	 3UvUV+f/cQsAfWAteU/QWhjiLiav9L2xnnGNYvQJWAqmbNyZI0Owtj0Esa7OPEl6Lv
	 dNNNxhxOyuIO/YaZZQ5foCMJ+F6S9Z1+6NfOCB+3i5YjK2fq3MJCyW+oOjYADx5Pkm
	 KW2t4/YD5OWQ7n/Rg7K/VhKrpiKBYMKL36+a6XWqRYT7WkcMY+3gDHeAcdqUjKTkzb
	 3wSibzYE9U30Q==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:54 +0200
Subject: [PATCH v2 07/14] ASoC: SOF: amd: acp: Constify snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-7-e553fe67ae82@kernel.org>
References: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
In-Reply-To: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=krzk@kernel.org;
 h=from:subject:message-id; bh=OmWsR1whBin0FkWyWjikvJi4ntg0jTMwYm6UxGalLwQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24lZVO6ZDd9Ma+CskZK59Rr5+n1NdIFKL+9W
 9OWn+/QE/6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituJQAKCRDBN2bmhouD
 13pLD/9RMyi2vNH+DIJ48G2LLs8RefNjWl15z8IwxEgJEnU1DjsRWBCUM6g4j4cB8PBIvJiAGcS
 VCo+wy7RI9ljNeYY3gBGlkCKA3iAdHiYoq3EXj/1OY6U1N8Qc2yqKASwflh5SMEndWwDkfh64BN
 4GHSgLPQHgqdC6QmBb2dVui3HWpxP/Ew/2Qr4NgUOHU98MPkBah3ID1P9SGGAQi0hckG9aabhFK
 Kj4EnjZoARWzfVrlAQD2VsJHc1JAE/e0eWEdm6LB3YGAHED768fwI4BmYh80+yDKzaVhxkTry39
 NA56Uxi0tEgzbhgaKzDyS4j/xRDf7lht/xFxo6Yrux7lHFNCNP/2BDShKXQchFtPRZ0ELL21ile
 5imnZbX2SJo0ui4xbhL/wG7NnanT6yebPvxDEMiVeezTTb1+/OBww+J/K8AIovLfJv4iTIiNfCs
 qnjzA/rUrgDRBPffwpsBWVJb8Wg1ZtSaZhb6BmF6Dfm63G0Z6zJ5OGlQsFdfUfIFGKtfSuPn4zW
 EQsQ0OQpSMoeRifpHhWxYzq6BcFfFG27s9FF0KKOwdMo22/W9If5Mgw9LXkjqZ5F6wjv8ZS/kuD
 yBGXZkQE14OyTXGXTg6h5HBpXSjUrVv+1GqncTBdM9ybGLsq9VA2eWacR0ChKGsUrrn8Efy5gz9
 51HxKKCm188Pp6Q==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

'struct snd_sof_dsp_ops' is not modified by core code, so it can be made
const for increased code safety.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/amd/acp-common.c | 2 +-
 sound/soc/sof/amd/acp.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 0fc4e20ec673..b26fa471b431 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -193,7 +193,7 @@ struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
 }
 
 /* AMD Common DSP ops */
-struct snd_sof_dsp_ops sof_acp_common_ops = {
+const struct snd_sof_dsp_ops sof_acp_common_ops = {
 	/* probe and remove */
 	.probe			= amd_sof_acp_probe,
 	.remove			= amd_sof_acp_remove,
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e229bb6b849d..87e79d500865 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -310,7 +310,7 @@ int acp_pcm_hw_params(struct snd_sof_dev *sdev, struct snd_pcm_substream *substr
 snd_pcm_uframes_t acp_pcm_pointer(struct snd_sof_dev *sdev,
 				  struct snd_pcm_substream *substream);
 
-extern struct snd_sof_dsp_ops sof_acp_common_ops;
+extern const struct snd_sof_dsp_ops sof_acp_common_ops;
 
 extern struct snd_sof_dsp_ops sof_renoir_ops;
 int sof_renoir_ops_init(struct snd_sof_dev *sdev);

-- 
2.43.0


