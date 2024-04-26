Return-Path: <linux-kernel+bounces-159740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D528B3383
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98AE1C217E9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4126C13D527;
	Fri, 26 Apr 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7nCAB0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5213C838;
	Fri, 26 Apr 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122293; cv=none; b=LQI2EEc0krgGIaIP28VYMGQkgxgq4lMKwtOILbZXjrDmKzMczYgcvS6Pvc3MhRPx6vGNiQ7a3EVj65GFN5lc65+wACpe1z+VWuhu+NR4/lV9vr0VriKcmXa+hrTr98o3CU2QjFkVlODe93siS6Y67McBQDIMIzMjZsPc0is5W80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122293; c=relaxed/simple;
	bh=pm2j1dM2p+8pNOKXWZzVY9FMSNrPURtydALmuvx+siw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DkbSOrUE45tmK98EZ3Q5dc1KG9ozJNVp3PmjNExPtGMUHk8y3Nj7Tu9H2iwM5hjTzdIBIZHkiRmzs8m9Ub+4NO84IS49Lj0ATR1cYWPINAgBj6J1uOKIXWpQ3JdxXkQLqTdLiGHTZNuwEJ6FFKqqoydkxhA+d+s6AGNO33y3umQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7nCAB0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131A1C113CE;
	Fri, 26 Apr 2024 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122293;
	bh=pm2j1dM2p+8pNOKXWZzVY9FMSNrPURtydALmuvx+siw=;
	h=From:Subject:Date:To:Cc:From;
	b=E7nCAB0DtLEbFbdOGaX777N0X0XV4k2CNMRL9+fnvIsvomps1P64c/ooLwmWfY+X3
	 m4okEsxFdK473An+EhcsCqQAFa6HntfG69GzO2Y+yieZYm2DDILswmkgoVloKspdtP
	 VvsfdKJZQOW0EMHg3mrm5kEAx5VQsQiSbvYkQfT6KClxI1nur6Bn602Kmvhbdg80HO
	 ulbvVAeDYoUibKbFj7C93WkmLF8czZ4wrBp2DGQljnOy3nS0+JLHVuHrx42omnDqaO
	 v5gh+OR+aeq+vhAzPL9PdcGUEsLKGaYo+ix57EVrPYF2e8h1i9xO3+f01vnE3kdFcL
	 aEnMW4yULsazQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 00/14] ASoC: Constify local snd_sof_dsp_ops
Date: Fri, 26 Apr 2024 11:03:47 +0200
Message-Id: <20240426-n-const-ops-var-v2-0-e553fe67ae82@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRtK2YC/3WNyw6CMBBFf4XM2jH0gYIr/8Ow4DHARNOSKWk0p
 P9uZe/ynOSeu0MgYQpwK3YQihzYuwz6VMCwdG4m5DEz6FLb0iqLDgfvwoZ+DRg7QWUuk2mq3lx
 tD3m1Ck38PoqPNvPCYfPyOQ6i+tn/raiwxHqqDFE1NrUa7k8SR6+zlxnalNIX5tzHxa8AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=krzk@kernel.org;
 h=from:subject:message-id; bh=pm2j1dM2p+8pNOKXWZzVY9FMSNrPURtydALmuvx+siw=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGYrbhyhrRkynmvFIgcWvJC4JAsf1b71Ti8wIkX9f1Kfu/klC
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJmK24cAAoJEME3ZuaGi4PXuo0QAIbH
 d7a92vy0rqiQwWXMMVzg532JOBlhopM0Y5zBK9mU7tQoLdIeMgru6dkEdTZaaWFF97v6z6No6Il
 FFf1Rb6Q0XfLaD0ZuqMOYPYJ8fFvHxnRxifpZ5xoV5wNFvCz8kiCRKpVOEIm9dN8pGcT1tsFbXK
 Aw18iCCpB4B8xnH5f8iUfFYLy5JDsRMXlk23fSDyA6s6zNsh3mwz9dzCUpRREJvB/izLBbtTRs/
 VRr7CJUS0vECgwnjfSC51P0fVt38YKmFIn4U3g+z8fSLu0OzkFwp62t9K7t0jBw9uEqKuWlPEzK
 /sweW2NQCOVyQ8J1WhP26MIDP7Sv4RlGd0cMIg8QVvOpgcKDF3LlR2HbDaqB/s/918jtWdTiNTo
 sfC9R7VtDBuHe7e4NppSo/mxHFOb1pwJga5ZAOCe8bc0aT0pAKEpqi5Ng80tYckqkUeG/Oc2C1+
 JkaJ6E7np1NlsjfbZ/RKDNpoXKox6DqDFrzun0hpeihWUOnB9o3KSla6L+4cjywErQYkaRiaQOu
 VlFFjkcgNa9nz6SismodUx5myDutbGPKUNTtBXa68P9U+KvwNp/zSIN78Ez+NEUlw6CPT0E3WCL
 F/23amcVe9o6pDR9ERhoW/A+wg83tnFlGnEJN8gfzCDngQIowdzdEQdYyT4kRsUj5X7Ohu3Uvrn
 6O74m
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hi,

Changes in v2
=============
- Only rebase on for-next of broonie/sound.git
- Add tags.
- Link to v1: https://lore.kernel.org/r/20240414-n-const-ops-var-v1-0-8f53ee5d981c@kernel.org

Description
===========
The core code does not modify the 'struct snd_sof_dsp_ops' passed via
pointer in various places, so this can be made pointer to const in few
places.  This in turn allows few drivers to have the local (usually
static) 'struct snd_sof_dsp_ops' as const which increased code safety,
as it is now part of rodata.

Not all drivers can be made safer that way. Intel and AMD rely on
customizing that 'struct snd_sof_dsp_ops' before passing to SOF, so they
won't benefit.  They don't lose anything., either.

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
base-commit: efdfbbc4dcc8f98754056971f88af0f7ff906144
change-id: 20240414-n-const-ops-var-136f395b374b

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>


