Return-Path: <linux-kernel+bounces-127482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50592894C56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA322B23347
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC63A4500B;
	Tue,  2 Apr 2024 07:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SlgINAU+"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F75A3CF72;
	Tue,  2 Apr 2024 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041947; cv=none; b=fiBo05HyYoJqAkPZzGrT4B9CGDQ7O5mtFLyxknRvEQeI7rztcchT2vGi4RljgxBFHgCkPgKnHuZCIhCt+f0mhVPxLeQqyM9a0UxcothFmeAT76ualRXRgwJEJiGce5GLmuesUnDxOGOF1HDCCdbtDOZW+EsDoMspN5xdL6odXcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041947; c=relaxed/simple;
	bh=flqmIvc29aq03tyjckaFwyCD7FjGJloE0Stz4DI3BWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ej8x9GgAz3EsFLN3edeAiyK3O3bqf0xV4ZjXEGf4ho0NamxICgWt78LpfgkYo47kcMJedUWckT83H5UvycakrWpxEqwKeLeEzIUsjmtsPSlXFrhMn09mWjBASrxPtYnxTqFonDT8K/faCpZfgpvejoqR7rEx1vd1VmFfRRYspPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SlgINAU+; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 01FCCFF80B;
	Tue,  2 Apr 2024 07:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712041943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7mFoXC/7lZncljkGK1+GfQv48vrdua/OVliFLiKRc2A=;
	b=SlgINAU+zuI8Bem8akyfc0t7xKmu4rUVZEM3IVa0IwYsK+DDPs1sDhofdMdra9u+xNJ1fF
	uMW8Popwmvhk1niBAJKFtVQi2IoqADVic4CZ9AsCQ8S6O1QBqgxnbd5r2ILYdrbHKaYVl7
	jBykm4J62EMwPAu8UwwJGOQOMY0S/496JI8257CFrXBxZB+vnCzjrvDVmfqfi85kOkS714
	RvcsnSri9LLhxE2zi/zUGXFfD+D1gPqCte7C2dGW14Gv0v0gCumDg9pfSzNxD/CZCWHNrn
	VIW3PKOnGDk6DZ6lhQTqvGZA4c8EuAS0HGXJimcl1BktvTdIyvT3KQbuwdBd2A==
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
Subject: [PATCH v2 04/13] ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
Date: Tue,  2 Apr 2024 09:12:04 +0200
Message-ID: <20240402071213.11671-5-bastien.curutchet@bootlin.com>
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

In probe(), the dev_err() is used for every returned error.

Replace dev_err() with dev_err_probe() where -EPROBE_DEFER can be
returned.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 sound/soc/ti/davinci-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/davinci-i2s.c b/sound/soc/ti/davinci-i2s.c
index 5c906641640e..cd64f1384e18 100644
--- a/sound/soc/ti/davinci-i2s.c
+++ b/sound/soc/ti/davinci-i2s.c
@@ -708,7 +708,7 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 
 	ret = edma_pcm_platform_register(&pdev->dev);
 	if (ret) {
-		dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "register PCM failed\n");
 		goto err_unregister_component;
 	}
 
-- 
2.44.0


