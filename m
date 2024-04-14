Return-Path: <linux-kernel+bounces-144335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A731A8A44BB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7391F212AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5301350D1;
	Sun, 14 Apr 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxhOPQc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD004135A49;
	Sun, 14 Apr 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120493; cv=none; b=XA5BKg/ELCF+NVMWLbZnRuFSJoxz0T/YmWGdQypuh/yBye2Ogxze+oiVJ2kZA+xUbeC0YFmX8HQpLTsSXDgBiLDNuH6IXhaNjnYP2Rkb1wD7snnhdzSVmqdtNGkbh13KnxozDhnUD3vuUlpK64zTJcPJ3OBHcSweWgXoySiqjUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120493; c=relaxed/simple;
	bh=qX/0RDSf7YaTrXlR3yi+NM6JRFpDm9GRxz4kt0d2t/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIJNie13yXijte7Pyqnox4Ovj7MDWOtCfLNslBu2UF1nWQlPoQg7dwuULeC3+NdtyiUHTIvVPzsaixTiU0ZkTKYaTB5edoTGevg8TtjGWDd2wx/3x6eIdCAiQAXAznOFm2Fmtkyv8fZDZunxvDu1alzPKKCG87Ud8gwcpqKOE1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxhOPQc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BBAC072AA;
	Sun, 14 Apr 2024 18:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120493;
	bh=qX/0RDSf7YaTrXlR3yi+NM6JRFpDm9GRxz4kt0d2t/o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dxhOPQc4X+cr4iX+wwKbi3v6HQJxq2imjwbnx1ozYjmW4ODcufGIAMXn2ZqPkfSn+
	 vV/7Imh+C+AdaMyty0blhQwDdL1WxP0rphby1DOml+fBXn1CWoWPBC+wRc1l+ZEJ+R
	 7C6UsF4zaZRo6RaXzu/8Xn3bCj6obaIEMsU94aVcVbcpFs7ngWNvd94B84VHHhEJBj
	 k9PqJH1Z7Kg5kesFv0hFLq1JprWLdncLNeAa0lT+Uar1Of5DTK3QyHUQnkPyjNvkCQ
	 KCXmr2pnpSRy4RceS4JkBQd/i9zk31k2Uk0dIt5idCF4Cf1sqza8nJzF5JWbJQClIu
	 oibqORGAcOafw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:28 +0200
Subject: [PATCH 03/14] ASoC: SOF: pcm: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-3-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=krzk@kernel.org;
 h=from:subject:message-id; bh=qX/0RDSf7YaTrXlR3yi+NM6JRFpDm9GRxz4kt0d2t/o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTGuPhjtUfqWw7zvnjQ9BTn1c7afI+sEeIPY
 zXYln1O9qiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkxgAKCRDBN2bmhouD
 17DREACMNQ0UTBMAHCLTz3wUYbBgS5RulwxroGsHqbC9N7LT98ZmJZPFh8uZ8zwatkOLU+8Qbf2
 v3SKTqcaeT5pc4OrcMf63/GtyIoj76HXMJaOYHKnLZmadFKvtcyk0TqNim69aJNYQXbpNYWEgm9
 df97UPfmfOTjEGmbbysu08KnLNNdPfMYDcOPxatTcNUav98K5pqFV3hGciN6PnyZG5YuLnFxzQw
 EIH0G1IEPzYxCv/zp2B0ZzVqvWQbS2+lrYtJliZxTe8JbiQXrZPVJBhyujV098/hswnMHz88ExN
 880eytk6TYY/Hb2H4yVZuQqFlJhvNj5sWVZYYTK/BpB7BYxn3JibO+16v8uQXxnJugjqqO+z/sl
 YYKMe5KuBSet9/Hj+zv3JuVpdo9PNKpmQsLRildT0s8vQwjYVIMnCyZBrCZezBMLviL7o+AP1E5
 r/26k5foQyya/Asx0T4bOIuxAkK0jL+uwS4+IJTthgS+PzanmoAJcQy1ubtnNkUFp5HPJPuht3B
 kwfLFYywB9B8TeHl79biKDY+ldbQIqlLvO+ooNBMQX3ubXsevEdK02qRhozY68jxych65Dr5WVC
 K0MFbw0Yxx0d/Xjmjgf0Q40SwPHY0c6jhfGkpWsLXlpxaf25Bp0m6loJK3xuwXXIfBvvTQovbZP
 NJfISERE7NMVYhA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 8fca4b0d63de..cb774e011e31 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -423,7 +423,7 @@ static int sof_pcm_open(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
-	struct snd_sof_dsp_ops *ops = sof_ops(sdev);
+	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
 	struct snd_sof_pcm *spcm;
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;

-- 
2.34.1


