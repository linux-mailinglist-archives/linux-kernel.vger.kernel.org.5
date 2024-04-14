Return-Path: <linux-kernel+bounces-144327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F268A44B1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F3B1C210DF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBA4136988;
	Sun, 14 Apr 2024 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGmwEkCa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41E136671;
	Sun, 14 Apr 2024 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120473; cv=none; b=eLLGK76iiV0Bqhw4qryNN4oT/7pSibABOtzWIlNjcphhnkQi/apqmp8hFsfhpQWTtCAJYZY3HUQ7HFwnTx7KkDjccF8ayT0LyQYBmXcwDB6WYSJte1WfC5BjFkl8keAkronzHcmH2bn3Pn2JMOqQgbS56TV0SCJz49NJ4NAVlRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120473; c=relaxed/simple;
	bh=DA7Xhm7CIdTyUAE5kLzTjcdZetnjAQrUPt5y8eetwKE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jDLhMadj6GfmsgSeVxoHcsAtfr1Z4owzoWlv5V4uQx/fDUlrGuUGdXg+tJfSifdQrMqeooUtJ9Eny4qcHpDb9cLcbAuFBqeCCLHutkT60gjF8QptCTKLwgiBuQjC6UPCbr61yszTeH/96hl4dYA4iQLJSu6WFVF7ebgVBGspHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGmwEkCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C8AC32781;
	Sun, 14 Apr 2024 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120472;
	bh=DA7Xhm7CIdTyUAE5kLzTjcdZetnjAQrUPt5y8eetwKE=;
	h=From:Subject:Date:To:Cc:From;
	b=qGmwEkCaSO+ndP903jkeq/1ya0gUzImqaMqU+OCkahA3j6FSAUuU87u6KNJMPlaWD
	 j7XUeWky2t4ndwM9v/UOLhx3fNfw+wxNcCqRSObq8OucAUK/R0tDGEdYmmtIh01PTM
	 uHftKHEPQbLVjigA8nz4CpNhIcljN+PIWuF6Kil0l7Xb4uSNj4E+Ru7B6KHS1REMTj
	 mO717VMblG6G63ll5q8LGezFNIFloVSRvi4kW5pODlKapSydM33brrj/F8d/E1Y9Ib
	 6A9A/fPAL+Nm3sVIUpuJkC5+gscsMtR876vf7ALyWuCvoFBF3mHqnj4bmzSkZNniiN
	 F7f4PdDf31YcA==
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 00/14] ASoC: Constify local snd_sof_dsp_ops
Date: Sun, 14 Apr 2024 20:47:25 +0200
Message-Id: <20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0kHGYC/x3MSQqAMAxA0atI1gY6qehVxIVD1Gza0ogIxbtbX
 L7F/xmEEpPAUGVIdLNw8AW6rmA9Z38Q8lYMRhmnnHbocQ1eLgxR8J4Tatvutm8W27kFShUT7fz
 8x3F63w8spXrrYQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=krzk@kernel.org;
 h=from:subject:message-id; bh=DA7Xhm7CIdTyUAE5kLzTjcdZetnjAQrUPt5y8eetwKE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTEYgvK0cxgMUWmJqebyTC46hEix8erEmoHQ
 0LgInNsq02JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkxAAKCRDBN2bmhouD
 1+URD/9v7KQnkgevykar6uQg1LyBbWXnatbRj4tlJuPDClSkLTMDWUJwy53UVc11/ocnXpzG8Kw
 yyhvnl7Eu9MULyHfAOxgP2gnA9QTM4o9aJEz9L23dIgxc/m2JdC4TURy+1cVMoJ/lgcAlh3Munz
 XRrw+7PFQyt7KjiZDoy1al6RcoCGsVvgR0shiLEVz3FT0/gHGmoC8jDjasXSsCIox6H6ia3SerY
 Yj5VEYukUlKKBoT9olENDnl8VnPUu0COzOxo+k7NvMqq1mGe8KYiegKO1Qn8FlTyFjt3SxfsyZr
 mMaPRynuHXNuPbPjPAZBFak10oLq30UmFSNS+r/VlSq9Ow8oSt7b7tqFCtDOJHy4sD5UOfgGeh4
 yca45EeuA9NPfaYUc5Q1L1Y3PMiAI9sBNawiFKnGDd8faw/Xer+u1wcssvTcC5XP4qJYWDiOh+O
 lygYWII9seLhRyTeNPFQN/KLUibnuOBgarAeCy9MszUUJstA+nlEaRT9BzaDWeAur4TTjYAoykb
 KXLZ77bHXcOP6yQBHUnN64WtC72OxLmFqWQ91ABt5irDe6GJkgnMRyyu5Eb3ECpyH1GvKTLXCg5
 6mFFdTuOR0lsUAUY1REuH310h+riAImmZka+JoYJjnN6/xKKHtAT3n6jzwyzVD0OiN3G1OQoxca
 WEOmbjIEIC+5ndQ==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

The core code does not modify the 'struct snd_sof_dsp_ops' passed via
pointer in various places, so this can be made pointer to const.

All further patches depend on the first four patches.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (14):
      ASoC: SOF: debug: Constify local snd_sof_dsp_ops
      ASoC: SOF: ipc3: Constify local snd_sof_dsp_ops
      ASoC: SOF: pcm: Constify local snd_sof_dsp_ops
      ASoC: SOF: Constify stored pointer to snd_sof_dsp_ops
      ASoC: SOF: intel: pci-tng: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: hda: Constify snd_sof_dsp_ops
      ASoC: SOF: amd: acp: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8m: Constify snd_sof_dsp_ops
      ASoC: SOF: imx8ulp: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: bdw: Constify snd_sof_dsp_ops
      ASoC: SOF: intel: byt: Constify snd_sof_dsp_ops
      ASoC: SOF: mediatek: mt8186: Constify snd_sof_dsp_ops
      ASoC: SOF: mediatek: mt8195: Constify snd_sof_dsp_ops

 include/sound/sof.h                    | 2 +-
 sound/soc/sof/amd/acp-common.c         | 2 +-
 sound/soc/sof/amd/acp.h                | 2 +-
 sound/soc/sof/debug.c                  | 2 +-
 sound/soc/sof/imx/imx8.c               | 4 ++--
 sound/soc/sof/imx/imx8m.c              | 2 +-
 sound/soc/sof/imx/imx8ulp.c            | 2 +-
 sound/soc/sof/intel/bdw.c              | 2 +-
 sound/soc/sof/intel/byt.c              | 4 ++--
 sound/soc/sof/intel/hda-common-ops.c   | 2 +-
 sound/soc/sof/intel/hda.h              | 2 +-
 sound/soc/sof/intel/pci-tng.c          | 2 +-
 sound/soc/sof/intel/shim.h             | 2 +-
 sound/soc/sof/ipc3-priv.h              | 6 +++---
 sound/soc/sof/mediatek/mt8186/mt8186.c | 2 +-
 sound/soc/sof/mediatek/mt8195/mt8195.c | 2 +-
 sound/soc/sof/pcm.c                    | 2 +-
 17 files changed, 21 insertions(+), 21 deletions(-)
---
base-commit: 9aa527ea9d7e33323f6a5c793eb62b09b7f96d46
change-id: 20240414-n-const-ops-var-136f395b374b

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


