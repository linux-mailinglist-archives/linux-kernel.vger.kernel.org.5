Return-Path: <linux-kernel+bounces-78921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0980A861AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5A42881E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA2142638;
	Fri, 23 Feb 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HqKYrSH4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA413BAC2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710687; cv=none; b=IRFoEAorMFzdPoeC5tH1rRncWEkh3F/QBjhbGJQMzuvVAuevJzouZTzTCVgAXzG1eHEW5BYPDxFSq/+tKYTKPD6xkmnkODorl0y9GTt9iBnGj7/kV463eDrUgYUM9MKL0/vRSazUDA3eUcwy6wH31jbGpwz6IOgZaPUCaBk2ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710687; c=relaxed/simple;
	bh=j16zsMD+HTWYyVy/k1AZwAJ7XoBtLsYNzq4+rvXeU68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdfQgSBTa2vi5QjentePENcip/hQaBINzg7VBw3LZmtOjnT6g4DyCmxwHqm8V2mIx0h9RjbCXC1ST+aZj8TiElgpBBo6vawEXeCsussu0jz1Hq/1NNLBb76ekWu+RWXrYeCvNXlTm3IbsT+aQBxxNjp21iouBDYjnWNP462oTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HqKYrSH4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41274cada64so4611695e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708710683; x=1709315483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2ahiTP/lW6MiTpxUmavX+y9bbyFd7JEgWLGkKtHM5s=;
        b=HqKYrSH4k5QihKMztmSVPgqZrFiLmMyvfiXjYQRUHWUwDWkFqQoeHsG65wTViCSA0b
         /jOmLxFXvB06gOp7A8KXPBTSLojfTCBsW1NckldqfTAS3VLMzemESALKlwyYZf8mxdD9
         F4EyyItJqorM0lERafQ4JmxG2ZmN62jsTKtqy/+iSMypx2r+4LNlXhthLmcvSn81E1H+
         yVIcHmevmli2Q69/VFvlSI67VMscr1WfjLV0iEmqB31wQfotbKFbgKHjmPvA14gOkhU6
         KK8Lwg6IT7bsvXHwhsmm04kzOgtnpuPvdTeYv4wuKHwQ6JM0Ngr7IbW+R6QHLuozN7LF
         Mi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710683; x=1709315483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2ahiTP/lW6MiTpxUmavX+y9bbyFd7JEgWLGkKtHM5s=;
        b=KJ1ISPRtaVE3giRoZHxF1F2oHlmQi1Br6ON3zRWdzmsGKMK/ygQYpK/Zuigm/Qh/Ek
         WaN9TSzEvUaB/wzhPbje+ksctXOsUf2O2SDOXi65TU5lrkCSDuxA9dlbjU0O9Mmpi3JK
         n0xCy7pmSktcV02CBQjZRJwMUp/+Oe8K2ODwUTmce6PH5BTDw1+NjobSOmMEZlp+jIQ0
         cLXcdNyaVKvL6Neg+to7dUI71gDVB7yVpLvnkYaTZbAVYWwP1xLniLpwYQyBotDMFlwb
         /SF/exgcpRsXgja4s7Fs07gFqnj/di/AhQ5MnDj6WUJqc4NyzZ2taHAdlHKSdztub8Yi
         u1kA==
X-Forwarded-Encrypted: i=1; AJvYcCW4V/ebRRnobfJz8z/DybgPh44yKSDW9IIV0tb7CLl4XH11Po3dJ4bIalYz8JS9n50T0Kk+bYTxpRZIyHCodGtUCMWufdcEsPD1LAPA
X-Gm-Message-State: AOJu0YxvITbXHZ54GjYLcNGuB7QblOLMrFYkft4rbeYzQOLOhjFGbffO
	2LnvIuSo9Asq+MygkZxjwjjxU5ktlzzbd6pmdKuWCiCHGkJrvyoQ4iXDBYHAjJk=
X-Google-Smtp-Source: AGHT+IGqnoqMSxnWyvarUuiuXtt8jg0EPFcrolAZQBwRrHQk3pPFoxvi/xtJ821ZsNJVMnK4y5tzhw==
X-Received: by 2002:a05:600c:5114:b0:412:9830:a259 with SMTP id o20-20020a05600c511400b004129830a259mr383837wms.25.1708710683406;
        Fri, 23 Feb 2024 09:51:23 -0800 (PST)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:e8a0:25a6:d4ec:a7ff])
        by smtp.googlemail.com with ESMTPSA id bo10-20020a056000068a00b0033cddadde6esm3711524wrb.80.2024.02.23.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:51:22 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH 2/6] ASoC: meson: axg-tdm-interface: add frame rate constraint
Date: Fri, 23 Feb 2024 18:51:08 +0100
Message-ID: <20240223175116.2005407-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223175116.2005407-1-jbrunet@baylibre.com>
References: <20240223175116.2005407-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

According to Amlogic datasheets for the SoCs supported by this driver, the
maximum bit clock rate is 100MHz.

The tdm interface allows the rates listed by the DAI driver, regardless of
the number slots or their width. However, these will impact the bit clock
rate.

Hitting the 100MHz limit is very unlikely for most use cases but it is
possible.

For example with 32 slots / 32 bits wide, the maximum rate is no longer
384kHz but ~96kHz.

Add the constraint accordingly if the component is not already active.
If it is active, the rate is already constrained by the first stream rate.

Fixes: d60e4f1e4be5 ("ASoC: meson: add tdm interface driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index cd5168e826df..2cedbce73837 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -12,6 +12,9 @@
 
 #include "axg-tdm.h"
 
+/* Maximum bit clock frequency according the datasheets */
+#define MAX_SCLK 100000000 /* Hz */
+
 enum {
 	TDM_IFACE_PAD,
 	TDM_IFACE_LOOPBACK,
@@ -153,19 +156,27 @@ static int axg_tdm_iface_startup(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	/* Apply component wide rate symmetry */
 	if (snd_soc_component_active(dai->component)) {
+		/* Apply component wide rate symmetry */
 		ret = snd_pcm_hw_constraint_single(substream->runtime,
 						   SNDRV_PCM_HW_PARAM_RATE,
 						   iface->rate);
-		if (ret < 0) {
-			dev_err(dai->dev,
-				"can't set iface rate constraint\n");
-			return ret;
-		}
+
+	} else {
+		/* Limit rate according to the slot number and width */
+		unsigned int max_rate =
+			MAX_SCLK / (iface->slots * iface->slot_width);
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						   SNDRV_PCM_HW_PARAM_RATE,
+						   0, max_rate);
 	}
 
-	return 0;
+	if (ret < 0)
+		dev_err(dai->dev, "can't set iface rate constraint\n");
+	else
+		ret = 0;
+
+	return ret;
 }
 
 static int axg_tdm_iface_set_stream(struct snd_pcm_substream *substream,
-- 
2.43.0


