Return-Path: <linux-kernel+bounces-127487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF28B894C64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EFB1F22F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E94C3A1C5;
	Tue,  2 Apr 2024 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gtBR9Cj3"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5E57864;
	Tue,  2 Apr 2024 07:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041953; cv=none; b=Anx9vXlImoWXQL5qupllJyizNjDkcyYEyN3scsQeG4p3YnLbr1YIRl+M2a2N2TIw3lrbNgKX88APkABpuuVQIxynAEIGjdlaMMBUCCWPRfneIVwjQxjKik/iBF6ROAk4AB5lXywVP/dhsfccIf1iwLHOe/ymWHbDbaUuFnjPGF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041953; c=relaxed/simple;
	bh=Q7kTk1pOg/NlcWm8yefb0S3wgoRZDW+UapJioBKAJ5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuJgnWPSXhsVDKtH6BoWiId9dT0hTD7EGSZdH32qPsxnKEfQvJ8irhD+kZ16Zyb8ypL/NyNjRU2Nv1hotgnqrPl+onLlKid2TLydMX33sC/YLpT7ZktlDW4x4vwQBeYxqzpSImtUnpQkabIlLscNOCmaEjeyKf9eQgNOi6J7cFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gtBR9Cj3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id D98B9FF808;
	Tue,  2 Apr 2024 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HvbHeeS3hR6xxZxnOS4/gZMDTkNCkYqtTO8AzSbFnAU=;
	b=gtBR9Cj3w6T5MCM3MKOtnT3CCueCifNr1cENC9icgWs52nSs4LVhR0OHZbiOqBiTAWqE0X
	8hMe13a/H9NdlMaJx/iin+LxcIb1N5ZzrVahD5tOrMUrv9TbuADHy12cwoeehL8FtA0pXN
	jmYsvmHrdza7l3M0Dirs2ePt2JtvCNWtFJByV1lfhc8hZh7yeSWnxTr8OnIBCPDG6MGRv9
	3dCiUaeqLIMhBzFo8WY3AzHHVJlR6k6SuG105KTrGoERp7Sx+5eRnnnLbekudOSUuxvAvv
	C6QFsyeJ1YPgRBRUHCLMqD3oIhDwJTfkoU6iNFoS4OzvBU80jMlFJmTJKdxF5g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: [PATCH v2 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
Date: Tue,  2 Apr 2024 09:12:09 +0200
Message-ID: <20240402071213.11671-10-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

McBSP can generate a SYNCERR when unexpected frame pulses are
detected. The driver always disables this feature and ignore the
unexpected frame pulses.

Enable the generation of SYNCERR by the McBSP. Unexpected frame
pulses are not ignored anymore.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index e51f05cda941..82a0dfa07cec 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -441,8 +441,10 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct snd_interval *i = NULL;
 	int mcbsp_word_length, master;
-	unsigned int rcr, xcr, clk_div, freq, framesize;
+	unsigned int clk_div, freq, framesize;
 	unsigned int srgr = 0;
+	unsigned int rcr = 0;
+	unsigned int xcr = 0;
 	u32 spcr;
 	snd_pcm_format_t fmt;
 	unsigned element_cnt = 1;
@@ -539,8 +541,6 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	davinci_mcbsp_write_reg(dev, DAVINCI_MCBSP_SRGR_REG, srgr);
 
-	rcr = DAVINCI_MCBSP_RCR_RFIG;
-	xcr = DAVINCI_MCBSP_XCR_XFIG;
 	if (dev->mode == MOD_DSP_B) {
 		rcr |= DAVINCI_MCBSP_RCR_RDATDLY(0);
 		xcr |= DAVINCI_MCBSP_XCR_XDATDLY(0);
-- 
2.44.0


