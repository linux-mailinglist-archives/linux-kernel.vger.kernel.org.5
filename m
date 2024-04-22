Return-Path: <linux-kernel+bounces-153481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873898ACE94
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90171C20AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C83314F9F8;
	Mon, 22 Apr 2024 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbkRXTtu"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE711514C0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793448; cv=none; b=D92aKBEhuM0+KZ1/uiQHSMpVhtJZ/sVp+inkTTZbsw09K6xkJmxGRGe4InSgXS7S3JKsg9V0OU5TERhF1UlaVyGHt+njUnDkX1fGYRAuGkdNfnHEU7NolP3vjx6gpX3c2eKOud7SJQHKQRUtJSr0H4O4DT6bA6XZUlEjZmp8+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793448; c=relaxed/simple;
	bh=bLGXgpxnbSKLkCQguZ5XOqrsE1dxN3y9EhIB6LMNF4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B007MhQQYph3YfQc047fTcLs3ujjAmL2xpsfMVycJbBgf5uHg4mpQSY+ZjKvlNgDKASuoPbTT4jlMzqik97ix5RERZpOtb5GWrXiiHYVnncGd3HLGaKXN/6QxRw+grvlq/Nv51lu2q2Ic5Egb0PCuzMCmXI8DQk0TGT3s6HhOOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EbkRXTtu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-419fc79e4dcso10423275e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713793445; x=1714398245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kwADMk5cdAVshWhjo8kiL5c8AnuAMycon0bxlwOriw=;
        b=EbkRXTtuBFcB5ir4wLkOKCiA1onqCV/vpsABL8+jW5BD0E3EKpN6OkM36CD50hmhTo
         H83ZYbWKwdhFTM/v+9RTFi9+FmK7M2mOjrx1ZN1IKU7EUioGV8uwbptDSzumgPTi4WDn
         Si7GFQ0ieuT4yJu7TEiK6O8T6SAJt3MSe6TxNAT2ov0+PNpnKnMaOhLlglM4xJ2R0TH9
         34hGHtd1tB/+s0jx2dmTSkTeb527R4P+zQYVWjn42PVZOhbgbqBQJ9hhnB2i3SphZXzs
         tTs7VcLWTZrSN1v4BipsDsbRdZC46GfaRvmyUU1x8IukbzNaRxgECOj5GdhsfTicvjad
         lxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793445; x=1714398245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kwADMk5cdAVshWhjo8kiL5c8AnuAMycon0bxlwOriw=;
        b=RjrHkpU1Q98+5JhLxPN4AdAkP6QNFVu5Aroyy6/+70roZYX871kXJFJ0YzVEclYeUw
         bYgKcyf0HB2sl6jFWwVh8qS1+U8CQAzRDDx3QAkXPI/wEXTAZMCHRpK5lNr/asa9chN3
         X1CuY96eXQwsfccFjFklhq8+ZxveI4i4Nlmlpp/rYwqjAC4kHrnr+HzQE6hl/GOlOlww
         Jj+HAA7UbZzO8RsTAC/EKRxQrwy8441hj3UXYX+mkBh6MOwR8+smnhksumAjxYqH58XC
         v4UkxCVo5STgM1NvZXDuWoesB0GLvbB/c4niLyflL8l7XGpNlAtHCBTX5gSCbtDlfawE
         GNww==
X-Forwarded-Encrypted: i=1; AJvYcCU2vxEmyUsHXNuiyRjHV3z8bIQWnGjwCiM8Kng/xw6EQwGDGO3CsimW3+4gDlhu0yKt1gb88nwDPDk+s9GU/4uRpeys2dcCX818FevG
X-Gm-Message-State: AOJu0YyMGN20a+CwNbcpHdStUbPi96+XgILkADZTs0ruq5Lxiz8S30nF
	VrQZLyqADth1deewcha48apAodDVLtQFmwu2pCVcRxmFnDPjc8DwqwF5Jr+3Rm8v8YbG0qBNsh5
	Y
X-Google-Smtp-Source: AGHT+IG4kwKfyMpRuWXlxFeKbxQWHJY+DwiUbTneZBOl7/zDE6gyAXrGAyk7QNgJ9pYfFQ1pPWWLuA==
X-Received: by 2002:a05:600c:4688:b0:418:a2ce:77ae with SMTP id p8-20020a05600c468800b00418a2ce77aemr7466632wmo.27.1713793445132;
        Mon, 22 Apr 2024 06:44:05 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm20731069wmq.6.2024.04.22.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:44:04 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/4] ASoC: qcom: sm8250: fix a typo in function name
Date: Mon, 22 Apr 2024 14:43:54 +0100
Message-Id: <20240422134354.89291-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Fix a small type in the function name as its confusing to see a SoC name
that does not exist.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sm8250.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index d70df72c0160..9bd159b81d69 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -70,7 +70,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 	return qcom_snd_sdw_startup(substream);
 }
 
-static void sm2450_snd_shutdown(struct snd_pcm_substream *substream)
+static void sm8250_snd_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
@@ -115,7 +115,7 @@ static int sm8250_snd_hw_free(struct snd_pcm_substream *substream)
 
 static const struct snd_soc_ops sm8250_be_ops = {
 	.startup = sm8250_snd_startup,
-	.shutdown = sm2450_snd_shutdown,
+	.shutdown = sm8250_snd_shutdown,
 	.hw_params = sm8250_snd_hw_params,
 	.hw_free = sm8250_snd_hw_free,
 	.prepare = sm8250_snd_prepare,
-- 
2.25.1


