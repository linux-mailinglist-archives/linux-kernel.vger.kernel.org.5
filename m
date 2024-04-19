Return-Path: <linux-kernel+bounces-151620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD78AB133
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7961F248AA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11412FF97;
	Fri, 19 Apr 2024 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pn99CK6a"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214B12F59A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538915; cv=none; b=bNbgY90TNFD2kuEz9sWxUL9iKWkamuiK6YCreWEZHPLUgl2wj61/kFK4UXZ0U2KBN35bPxmvMTRdxDHYT5oMJpICNDtEFs6RsH1IjlkpvtSy3gcLQisyjFbR4A/jqvNBcIGqyqa/LxlCn16X6cpf/XQGRHMu2hhrCEXVC1iqxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538915; c=relaxed/simple;
	bh=6VfB2MxnfpwxDajfB1IcH+LrSDMjCd5/ucMZhFDOGNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqf9JDdTK4oPH4kKuSPCatYB5/e0v8asfgAy1vOVXDM3gdbQUXMMAO+wMWqlnK8mOvwJy1+CPdkQUmBNOQrXirJ0GCT1YlbpLCZ/YyEHj0th85P7ZKSRGqDNTXX1UPGUZ4nnX9T2qSZ0v1QgeU9PPUroHCaamuGxJfbIcSr7z4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pn99CK6a; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso4286095e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538910; x=1714143710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMUP+wlhZ8g+tuzLPiwn3mBsR+LeHm7xmSWj9q3JJJ4=;
        b=Pn99CK6ahsFL+ub4ubej7dilB2KDhnyDRBehHJ3r/RXIXKmOb6p+zsDW8J12cy5bMK
         aQcDinrKSwYBMv5/O8YDRGfgWWKZVXv7wQyrI8/6R2aXjpyiF+caqVpUJx7boUtmfrrC
         pXbY603ahuSoavjE168NVcgKu2c7b/bw+rH4zk+O03AwARFSBQO+uwtxU3Hgq/m7aHLP
         uyis2dEC1cFBfHiVV8o1hGaaxHyEQa6oQd4PsFrjPqfvMys2g7FLiofgPVFKMelhVlZr
         ie3/K8aAJrw+bVGThqmx6LvIWXo58bSdV1CBbXjdw6dlr71Ig24qb7231c4WERjjYuIP
         vjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538910; x=1714143710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMUP+wlhZ8g+tuzLPiwn3mBsR+LeHm7xmSWj9q3JJJ4=;
        b=QGo1z7dQvfp0frCFbmcJb3VlWgnaQEzxYgysA1Z6TP/Q9PrXF8E9OPS6ymvbTa7gLG
         ufOtjZKmNa85mws2XgExhaZEAzi24KDt5INqu3ZdH8wosysqpCt7/edse/Z2uA+gMrQY
         g0ap7wvNXIZF0CtjabjI9YTO7f/BnFehcww+VCIZyfkAwo0Ej1MOEAZO6uYGSoTg501F
         2CCD1KHB7p0PQ2WzrPxMRegSH+LATOmDJYu11gQhvtLgFmxUfmWMX1M9/Qla/fi7B9gV
         x2BAqgIs3T22w7DYmLX4zCVY14OrUGKNz9SEp+Nq2vhfUKREbNfV2pO2vKPodsKOltAR
         ezaw==
X-Forwarded-Encrypted: i=1; AJvYcCVhpuOtwHSByjTMKj8w2ZLlFBSwmxgRkG3F6VRdKsC1Tkpsgm78vW1WvaiRRqyrG55BLvjYpItW3+rUZxAAObsQrqFZmQIzQv2A5JxW
X-Gm-Message-State: AOJu0YxbPR52PH4pVJVt4C5qtu46AUNtTF9mHrF5+OkDF6IgOP7ytD/k
	5czQ72lYsV/kmFoHNaC/XFBqzaLjyRtRY2opsjbbfNsk8Tp/z4+PYrFsRvKfUZo=
X-Google-Smtp-Source: AGHT+IHpuWndHVKKKBXkjzI7oYy1jjgdAKfsoS5fJeCifW0YVwRYgaH5UckN0SgJC5ZFGU4MLWkuGQ==
X-Received: by 2002:a05:600c:1d01:b0:419:96:965 with SMTP id l1-20020a05600c1d0100b0041900960965mr1874240wms.37.1713538910674;
        Fri, 19 Apr 2024 08:01:50 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10660462wmq.4.2024.04.19.08.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:01:49 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: qcom: sc8280xp: add Display port Jack
Date: Fri, 19 Apr 2024 16:01:39 +0100
Message-Id: <20240419150140.92527-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
References: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add support to Display Port Jack events, by making use of common helper
function.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index b7fd503a1666..ced89cf65b5b 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -19,6 +19,7 @@ struct sc8280xp_snd_data {
 	struct snd_soc_card *card;
 	struct sdw_stream_runtime *sruntime[AFE_PORT_MAX];
 	struct snd_soc_jack jack;
+	struct snd_soc_jack hdmi_jack[8];
 	bool jack_setup;
 };
 
@@ -27,6 +28,8 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_jack *hdmi_jack  = NULL;
+	int hdmi_pcm_id = 0;
 
 	switch (cpu_dai->id) {
 	case WSA_CODEC_DMA_RX_0:
@@ -41,10 +44,20 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
 		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
 		break;
+	case DISPLAY_PORT_RX_0:
+		hdmi_pcm_id = 0;
+		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
+		break;
+	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
+		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
+		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
 	default:
 		break;
 	}
 
+	if (hdmi_jack)
+		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
+
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
 
-- 
2.43.0


