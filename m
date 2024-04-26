Return-Path: <linux-kernel+bounces-159742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFFE8B3389
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B67B2815A6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACAE13D291;
	Fri, 26 Apr 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIPZ6uWA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CB13D525;
	Fri, 26 Apr 2024 09:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122311; cv=none; b=CQl0aoJlRHSgm86OK/+ooSf1TqvMSuQTfCZjeIxFyVQ8hKoJ3wTvHcRvbPXwi/1jfcArvnppnTJ4l/YyauXYmT7WCsX7J28t8W6PAv14No6jY6n/hAvSHdqmgkY+5jUHlInIIfenmb/cqmMCGbzFtvuBfgyH6oyynlJbQoLugz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122311; c=relaxed/simple;
	bh=kMKFC78mUGsx7b4RHA9dgG2P9NgMyAE/GAkkgSE6250=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KU67ygZ++Dji9qUdxj+8BYBezhg5D1gULCPLGPxOl95YKekk/WFgr7zd3XAPROuQzy25STyYf5Oe2y8BL1WFq4+nN/MtLxwMIFvBBzt/GDNmX2OGqA/ru+bfz2NJa6Xm1QeAoM8zHJLEo20HmFQ9TJ5nwrnzhRhDc4Edkzo2rIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIPZ6uWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697AFC2BD11;
	Fri, 26 Apr 2024 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714122310;
	bh=kMKFC78mUGsx7b4RHA9dgG2P9NgMyAE/GAkkgSE6250=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oIPZ6uWA+7TAMJi5kEuM/QMn5Xj7GZcVcS4jfZUyrybC3B5RUkm0r41Y94kj2UlKe
	 NCauoMyJ99LhvzuqUSRvbw3EjpSleAl9VtS2G1/4TrpQ96F2hopqotiX/Ekrc8jvmR
	 bFJ9VmS275AJqTTCF6MhieA5S+J32U0Wm5MDDSq5UEP81eikF7gudnaK86bj3rt3+b
	 kCupQ7GYzmDzFMQO8X4XqE+k0Fs+XDLwE1qiD1Qe6jXbfoMtdcqMHZtxj51+5BtBYm
	 q7sV5zYA4RpFkxuFNCQBMvenhIoxEOF/ClIMeZn2PMMx7AICAmTKkEhl/dsvoKrkfu
	 /ohdvwW3vwARg==
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Fri, 26 Apr 2024 11:03:49 +0200
Subject: [PATCH v2 02/14] ASoC: SOF: ipc3: Constify local snd_sof_dsp_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-n-const-ops-var-v2-2-e553fe67ae82@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682; i=krzk@kernel.org;
 h=from:subject:message-id; bh=kMKFC78mUGsx7b4RHA9dgG2P9NgMyAE/GAkkgSE6250=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmK24gEkNhUhWWsVLmkCo5awt/BmsQBJfrhkCY9
 PLPy73pbimJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZituIAAKCRDBN2bmhouD
 17EzD/9EYcZQxibgKh8DZYlhMIakLJyrdMkfUJ1Xh20O3OImR+/jABppKN4idGJ9tC+Eg2KLf/5
 gZHfQ6chMJMrkoHDuJgTvUfA0MSrNRYAml3SRrR9NZ/d/k2fJzUihUBSE6gzNuk1W/O/b1CVUIF
 56tPqCL5GfMnSmAiML88KaUn8w25LrBR+0FhrhtaWkVp3IbJai/BrbGoqn/x2+oaUyEFUyFPW12
 H4d8iLSwnY4BD5TF1bjz9m89O0DU4fnmd4ZXGPUUwZKqi7+8ndp0McjvFdkQWHtk1HlWFGn/NJK
 zwwq3sdDoz1PUmH2QDwd2og6WNyPlhgteWMwzuJSM/E7PZENLIJmPWiEsgS/76f9twTZ1FXikyf
 CG3wIS7oDgkqPqKtnoREkS26u2d4c9jr6lumZ/YlxxyP4HWt47Tw/3zNkDeja/NkZfbx99fLsNg
 l1pjvn337YhGH/qv60QcyMdeox5bJIvdL5tQXCnrVp3YT9tUddClpvy/Hv9K7MS0jfwx7QeDi5s
 NdamksfVQEgvNeCMYJGuNxfPQnwstIqthv9gl/sF119u9txU1oe+15HiurhvXLwlmuo8riAG+hp
 I11Av7Usd134ko2qIJuNgYGLt0kgV1zShCkTEmm4nT/jJVhLlRYGBZ8TEvTg21g3djM7cicmu2a
 5X/3Z3y/SJRqFyA==
X-Developer-Key: i=krzk@kernel.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Constify the pointer to 'struct snd_sof_dsp_ops' to annotate that
functioon does not modify pointed data.

Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
2.43.0


