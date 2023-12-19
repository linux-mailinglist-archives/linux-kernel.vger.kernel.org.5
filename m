Return-Path: <linux-kernel+bounces-4633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925C818021
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A51C230B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5C4C9C;
	Tue, 19 Dec 2023 03:12:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9142881E;
	Tue, 19 Dec 2023 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AFCF200584;
	Tue, 19 Dec 2023 04:12:25 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C653C2005A1;
	Tue, 19 Dec 2023 04:12:24 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0423E1802201;
	Tue, 19 Dec 2023 11:12:22 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v2] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
Date: Tue, 19 Dec 2023 10:30:57 +0800
Message-Id: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When flag mclk_with_tere and mclk_direction_output enabled,
The SAI transmitter or receiver will be enabled in very early
stage, that if FSL_SAI_xMR is set by previous case,
for example previous case is one channel, current case is
two channels, then current case started with wrong xMR in
the beginning, then channel swap happen.

The patch is to clear xMR in hw_free() to avoid such
channel swap issue.

Fixes: 3e4a82612998 ("ASoC: fsl_sai: MCLK bind with TX/RX enable bit")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- add fixes tag

 sound/soc/fsl/fsl_sai.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 32bbe5056a63..546bd4e333b5 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -714,6 +714,9 @@ static int fsl_sai_hw_free(struct snd_pcm_substream *substream,
 	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	unsigned int ofs = sai->soc_data->reg_offset;
 
+	/* Clear xMR to avoid channel swap with mclk_with_tere enabled case */
+	regmap_write(sai->regmap, FSL_SAI_xMR(tx), 0);
+
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx, ofs),
 			   FSL_SAI_CR3_TRCE_MASK, 0);
 
-- 
2.34.1


