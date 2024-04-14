Return-Path: <linux-kernel+bounces-144334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722248A44BA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829A91C2114F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2FE136E1E;
	Sun, 14 Apr 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVpf9xir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA423135A49;
	Sun, 14 Apr 2024 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713120487; cv=none; b=TYcLFfyJ9L6BFrWJe1TYJyqu1absSS/IZeVwKnzDdK5ucSflT0rS0GJwNO0c4vMgOu/5tRlXXqdGS+btYwEeLKEFbp9pHYhhMyn7/rxwyqeMsJu7CZSj6z6dzi5HzhtmnaEoneveSKiN5s1rmcBRlQXmBHCGAcNgJhCpBQGuVww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713120487; c=relaxed/simple;
	bh=hNJ2G+P/dWd7vsgx62FCkrSeDakr9/PbBt3Vb3M9/xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jmEpk/8n7SN9kNZPKu9dWuNOtzWd+5yvZ6FnNGLexWtrrgwFGAi+E3ZTkUmhEDmhN3NIYqhKSXLIOtUANtMzMxCqVkfftMseFT81wV9ifCb1URh0GpCOymju9sDX3+rhwPr2L8kOnvJCNP/hlVpukFs2O5aYlfzPiipjKkcUm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVpf9xir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE34C3277B;
	Sun, 14 Apr 2024 18:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713120486;
	bh=hNJ2G+P/dWd7vsgx62FCkrSeDakr9/PbBt3Vb3M9/xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FVpf9xir32ka5d/mEH6VXlT5ee8iCgICnJbmAdUgBWcLm7X3LdvWgx5Xfdrrns/2t
	 kRWY5cKyrF8ixMQK9czEHrGlEAVs4PpuYhpu+wjPeR2s76Q+EQzfNa4qnIxy+GHSPR
	 EP0F/u6/RrDQ95Hi3+tX4LYTkRv0MguJFrwM9r+VzSXLfzwpgnRIBEpc6zDpAAvjk4
	 ogwDqro+ZLWdXwkWsRTSzL9O1Ccj4iDdpyuA7mpgQGcACax/gkhFoilwgBlyYQ8ZcN
	 r00TNtFjyRJs0B5z7+w432oYrgytmy1/zSTMwk/pHvzVMb+xX62U549xedRuLvmqJt
	 oTHh4uda5Hnxw==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 14 Apr 2024 20:47:27 +0200
Subject: [PATCH 02/14] ASoC: SOF: ipc3: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-n-const-ops-var-v1-2-8f53ee5d981c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=krzk@kernel.org;
 h=from:subject:message-id; bh=hNJ2G+P/dWd7vsgx62FCkrSeDakr9/PbBt3Vb3M9/xA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmHCTF3uQbFUD8ajbnGaZCZUG17venUqLmUXEMU
 OHBDYeeKIeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZhwkxQAKCRDBN2bmhouD
 18vwD/9tB/adriOXoYJFXctL1cBnqxA6W/ObflSsngdezLjeiWl9WbN9N6wL6KU3uueyVcx9udc
 3IZ+dc1eh3Gpi/MIF/7tpR0djzZiyevMKsi+op7jsPNhJmmsHM/akaO6y/ygyGcQ+F6Gh5VdnOL
 Ls/2Q4b6yK4DQCINa0+LbL7aDKrCjeWAv9Cc5zyr7nAMoYPiFPdcGOeNvaQBpT+CNA6piHSfguQ
 yuf2svGbeCjGpQjcwi2LupfFV3LYyGoSEc2Y9vUD7ajTht9jdyl9hiTwQugzLRXatsaboI91qXF
 SAcl4tFOSS2L0eaYNQsOJSXvtUnGkWE6u+INoBpRg3HWrWswypcg/XY9thJx0vgNN3Wkde2AR3h
 rEEhsRo/HnFAFULU/pfwNv566/aX2mGEKgdNGY32ylmU7ZfMwfd8Wk9eZyBBs50q8LxRO4+tgci
 pOy2A5uzBijBjPJuiO2mUrkKhEsaL6WoSa3U1WOh6HSOae0L52f9TpYdKWycC57O3GQfC75Mn0Z
 egfNPWqvOtL/ahx5+qssvVfYr/5OWyemSsoE4EHagKJqS/9BNMTXjpLIDT2hI09YBaDIw/7wZJS
 UMH/xzb0GL6UQwPbUOz0A8zdQ1RZnhgVx++SCORD6cIiUGSOoXnoJNolYW4KreKMa7nM+ZXzPUR
 hIRB0ABv4uAv3Kw==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/sof/ipc3-priv.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc3-priv.h b/sound/soc/sof/ipc3-priv.h
index 0bbca418e67e..9cd7794f3cb6 100644
--- a/sound/soc/sof/ipc3-priv.h
+++ b/sound/soc/sof/ipc3-priv.h
@@ -36,7 +36,7 @@ static inline int sof_dtrace_host_init(struct snd_sof_dev *sdev,
 				       struct snd_dma_buffer *dmatb,
 				       struct sof_ipc_dma_trace_params_ext *dtrace_params)
 {
-	struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
+	const struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
 
 	if (dsp_ops->trace_init)
 		return dsp_ops->trace_init(sdev, dmatb, dtrace_params);
@@ -46,7 +46,7 @@ static inline int sof_dtrace_host_init(struct snd_sof_dev *sdev,
 
 static inline int sof_dtrace_host_release(struct snd_sof_dev *sdev)
 {
-	struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
+	const struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
 
 	if (dsp_ops->trace_release)
 		return dsp_ops->trace_release(sdev);
@@ -56,7 +56,7 @@ static inline int sof_dtrace_host_release(struct snd_sof_dev *sdev)
 
 static inline int sof_dtrace_host_trigger(struct snd_sof_dev *sdev, int cmd)
 {
-	struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
+	const struct snd_sof_dsp_ops *dsp_ops = sdev->pdata->desc->ops;
 
 	if (dsp_ops->trace_trigger)
 		return dsp_ops->trace_trigger(sdev, cmd);

-- 
2.34.1


