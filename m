Return-Path: <linux-kernel+bounces-29136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005B830959
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A358C1F231DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1E822EEC;
	Wed, 17 Jan 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrakBhjW"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB0E225A6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504341; cv=none; b=VKx7W92XAT2AnMsKYeh5Irz8xwwqkOgEMrmISDu/wrIrwPwlbLV8iTBkqmFdgRI5uDI7btmVIv2cDPwQD3Q1MaP7nhf7jpBFCtIkFX6sNwCO2FR3t4NxwKpsydauJ/FI1L53bk+LhB7PysMz42xwreaLVSxl8TT26TzN6sl2whY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504341; c=relaxed/simple;
	bh=zTLF4pKwDUhmIJpTw+ifYX48G8Y/tLdkZCXLW1dsOdg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=fdHiURtFKS/zpA3NOeiwjlGPjMQliopUWpHv2T5xFWD0P3tkeS1zfitXeH5cUDpw+XQLedS86jHLVR+pc7ge5cW3C69oR/llGo9KPkfvHbwaAndszZQoEAvqAJw/AjRgxDF+hcLglEFqPTWXQXmO74YVYjQxaG0dlNciAeQYP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IrakBhjW; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7831b3a48e7so661077085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705504338; x=1706109138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ5dWg/o67onmhTzNFtXrOTvUPTxoBK6DGUcni7z13M=;
        b=IrakBhjWYcTx281uJkfflWwa2NOYOeI1bCsGnxGVZrm6IjaBFUx7p0duk6zyKECBmQ
         dY/7X03ylYyCkWz59EehpkTbs8mKqgtBHJSZ/QWQeK9fDPI283k0wJ5UmQqtlYKrPGvm
         OWbP23UZMsfMSm6B5xliduX7ujbSXRKph1AgCZgFWgKSMVdp1T9fLtX8ov9Ec9aeYYom
         baa9xku1mtGfyq662seh7VQELl01Wg64sLh8kFd8W0DgONwth41KNlNEvdhFNdGIab1q
         MyE30R3wPb+HvgHbmC1dHoBz3oqYYXHlpjMqxwL0GJYb5nPqsbQk+O9wFMXudX9GodPm
         tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705504338; x=1706109138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZ5dWg/o67onmhTzNFtXrOTvUPTxoBK6DGUcni7z13M=;
        b=ZEi1/MYdLUMVgUL1MMbSvDsoJCc0DtSW8bKpEG7A0rmjwhlPZo6utjN68WyIHKaQFG
         wDQ2CsrUlNzqY+96KGhw1fSv+hs43wtniv4KE41x5rGnFPm3lI5SMCm4d8QBsoHdx8++
         cH7X4GggLxEeoyt2UQ36sScePKMdhxVcTUtL/jUJB5OE1ghkd+auiKtHMhB5QXFEs5kX
         ax/cqdN68q94QirlP4cxBayC5mZrM/FfD8cSVsrPOvzrMfORQ0Geope4InucQeOMU9yZ
         YlhR7mCskNtuH6K0TkuPZlwZnv2OMcy+m3rsDUCN+x13mTOFicVASBlpEMS+PJzMIgxe
         TMQA==
X-Gm-Message-State: AOJu0Yz1qM8pK98QSPQQjVKY6HSpJgN7OA1eDu6101c46u4LQkL3KCcK
	N9+By2vbVDkC1Rz1flageXdlwe4HBq41lg==
X-Google-Smtp-Source: AGHT+IFuzN2ZXkdL1furtqKyL/+PADgDDPC7U/QwREJrS3KVsloHm7pc6AYqgLOErGBf8DiUCfrogw==
X-Received: by 2002:a05:620a:55b0:b0:783:54a1:136f with SMTP id vr16-20020a05620a55b000b0078354a1136fmr5882267qkn.58.1705504338226;
        Wed, 17 Jan 2024 07:12:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a24c700b007816cf21f7asm4519337qkn.76.2024.01.17.07.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 07:12:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] ASoC: codecs: wcd938x: handle deferred probe
Date: Wed, 17 Jan 2024 16:12:06 +0100
Message-Id: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCD938x sound codec driver ignores return status of getting regulators
and returns EINVAL instead of EPROBE_DEFER.  If regulator provider
probes after the codec, system is left without probed audio:

  wcd938x_codec audio-codec: wcd938x_probe: Fail to obtain platform data
  wcd938x_codec: probe of audio-codec failed with error -22

Fixes: 16572522aece ("ASoC: codecs: wcd938x-sdw: add SoundWire driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index faf8d3f9b3c5..0aaf494844aa 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -3589,7 +3589,7 @@ static int wcd938x_probe(struct platform_device *pdev)
 	ret = wcd938x_populate_dt_data(wcd938x, dev);
 	if (ret) {
 		dev_err(dev, "%s: Fail to obtain platform data\n", __func__);
-		return -EINVAL;
+		return ret;
 	}
 
 	ret = wcd938x_add_slave_components(wcd938x, dev, &match);
-- 
2.34.1


