Return-Path: <linux-kernel+bounces-144328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 021668A44B3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978E11F211BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB581369AB;
	Sun, 14 Apr 2024 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzkDFTUQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22713664B;
	Sun, 14 Apr 2024 18:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120479; cv=none; b=RsmJoQMZfLyQ6l9rI7pi+wVVMHPgUcrNl5u44VBmM3a3t7BYPFOqxcGKJUv0g0nMItauSzgllfx1rv7xqrSJgE+fDl6CC/CnvrMfPLgM3xmNzKZ+oufEN8S9to6SP32odnhYbpQK/sy5M6wfyE25PUiLMizjwT1EMWoPXqHpIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120479; c=relaxed/simple;
	bh=xmgaqXbLg3DeFTUiQoF4m+Ls2Yrq43+DOTaWCX8ZMKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2e/AQx6NR8wEfgDUe1b5BQpVRNJ3c/2jl/QTiX5IFogiwyWXA6g9GoPQ6hoAU7QncTZpWnQhzBjCYQJk/e7W4u4fhmwRHKlbNKNILjU4m+I6QmTtcRdh2SIyGd+SYKEN8RDzgAQSiS/i6o5pJHQHJQzLkQc9Sa0TbN2yzTOCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzkDFTUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7878C4AF08;
	Sun, 14 Apr 2024 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120479;
	bh=xmgaqXbLg3DeFTUiQoF4m+Ls2Yrq43+DOTaWCX8ZMKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BzkDFTUQxsljZAUIKewfboJWkThlb4pNhukaWaW8XHW9qECHI7KDf/NpjOl6XgEHS
	 R2nas4NuLLnzHlqVruMOh393wYkJDN4VP+qRisHZbkidRWNrTNEFTeGGvVc+u7rhOT
	 mhZ59/OvTelp9tXrfyqzUrL+XxNmQNaL8LuWg3xmS9Jgn53lKFNUhChTJdBL4nPLUt
	 1c83riQikffKxueMPKe1CLdhBwg9qKt0Ivm+yMZQGNPi7rWm1lugdqPzlG+PyYMo+A
	 dXp4M6Y1iXmZr+Jx1a+PLdOI579kX4iSFcsOWs8SMJhak/tqYideWAaEtV1SBGH883
	 fhv5RoD3lyoYQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:26 +0200
Subject: [PATCH 01/14] ASoC: SOF: debug: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-1-8f53ee5d981c@kernel.org>
References: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
In-Reply-To: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=krzk@kernel.org;
 h=from:subject:message-id; bh=xmgaqXbLg3DeFTUiQoF4m+Ls2Yrq43+DOTaWCX8ZMKE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTFzPWZhyTxMEszRpvlQ0QKX4BQXB5xVIAH8
 AJH3EdVyb+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkxQAKCRDBN2bmhouD
 14IdEACC/ThhaKlGNaics6QTPylF1r78OR3KQ/2urDY9mXFDh3t3WXvHbHI/JdjJZaPqmUsb7JY
 Sce6AQHbAN8aU7B6F9M1CRjqqlvd+CUG9AZ86jhsBKQEW4pkWf9H9bSXFbayb9KSKX+PjTp1OYN
 YCyQRroralceoFlT9rLPlVz0OrwYbSRcTte5mkyWQbutork3I+4CWpQjgdzVq6Df2Y/U+BxEJ9C
 OF96VFwTufA+LOTFaOKBE5F5E8dPB422xybwe5K60hwGWhjHlTtCfHaO/QiGqAZyuQR4K+wkwHv
 ptXKlPczgDZBeHm4kN5NLeorGCE61GyEXHzNUp3XkA3seVyOyUR4pNvMmxhVvFuNYqs8215Y9HL
 4xO0+VKbmLAXjuGRBk7zO/88SCDso1fKgUnb5Q/QauJKX0lXEur4HY2K2AXSOut8L+C9NGW/16N
 On/xCkLjB854sOoN0CwzYzYWC5xLmkhmQr7c7gOl2DuEqpSbeCIXH9b8Y5FVY2WUbLTnDCcaCHt
 eM8hcIKaJ0hQzbbixSVgetepb0djr8J7vb4R2i47VDDzrcBnJ/lGW3YJP5MwTeiLslssCeaxTpL
 heO8xAx2LC6b8pjtvj2tq9jc1dISHf97cDlaIIIHVyck7ZfSeuy18fpZhhw2lO3St0wgnt4OF6G
 4IUMkc2nyhMrzAA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index cf282c8b18af..884d85770426 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -311,8 +311,8 @@ EXPORT_SYMBOL_GPL(snd_sof_dbg_memory_info_init);
 
 int snd_sof_dbg_init(struct snd_sof_dev *sdev)
 {
+	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	struct snd_sof_pdata *plat_data = sdev->pdata;
-	struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	const struct snd_sof_debugfs_map *map;
 	struct dentry *fw_profile;
 	int i;

-- 
2.34.1


