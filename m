Return-Path: <linux-kernel+bounces-153480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07C8ACE92
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECD61C21348
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A6B1514DC;
	Mon, 22 Apr 2024 13:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CG/uFNBI"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7101509A3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793447; cv=none; b=i+1DgR1nqWi2X32MsQDHFfHUKFqH9Th2WwDGS+ld4QDtR02pH8pHvgfCmVEAygf1nMh5djL39FBauVi8Ig6ilekuGFf9oEd15/7IpKHiIu8DHiPg54VtraiDc2uC87eLOFBL4WaRq5GX8YHRM2yJywLf8WsP2Ybfn+TVWQ9gSnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793447; c=relaxed/simple;
	bh=RSqYj9fLODqyWDFm63AWBPUaIjp1sUJoSIUJRQbfYkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p409LLOliKJZbGtt0lhQjNtoZ2bVKD1OUkYbFqZD2ASWRkBfU3t+GggbNoFx0guKm6fSrE3Q2UDt3fQS7vbtwYk2f2mhl/HDFtLwuW1FogKOLCicXkHhNaXOmEBktl7gJijC8nDKn6vbrt8mI4YdhWtOOjZThVdPlfu/GvnnHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CG/uFNBI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41a7ae25d53so4709265e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713793444; x=1714398244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ooDB6P5Kmg8yEzYGOGc1KNPluwmb/df6YvlokaERTg=;
        b=CG/uFNBIV+oCyYzHsctOIXuXw5rKjIBn2qpK5FYUhWfhKpqCe6x1cIkBvkjch9RXcv
         0zpIr1jwe7tDzY7e48H6eOOXCFjvFgx2vyMa/x8DYlQ2ZLPrn8ja8DSiHjcf+9bjwr7i
         QxUCOGHyw4K/uvNeZF7kQxn97GcYMOOdp5m1yy+TkQtRTQzD0tRITRQl9zfPaEaMFxz0
         U8Zs0biViHD++fZQ9uqzMwcPfkjpZqaM8gi+BA8GXZ+fa1EKXWJ+jn9T68Gk8hjEd1P4
         qakrXOXLn7DGkMZASq/F5/9bnRTOvTFnh5SD9AEnCV8wqgET4OHt3Q4JnC/bbETs9CvI
         EuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793444; x=1714398244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ooDB6P5Kmg8yEzYGOGc1KNPluwmb/df6YvlokaERTg=;
        b=YbuIpKM8pESJtZHsLKT+jC0h7mGWAjoUHLPHEPCwpReqXK11cKLV3X8LlfXCWc5mEq
         xBE5l2/ODKH9QlIXi3bbcWn+/ixPXb/fYWvOhpHjUOp2s9VsbZD2utPvlV4CmWLzGT2v
         n+erzAhkXHbILsD3gmHvxl5WeJgCv+pFj6CaIA1lPCcP+A0dfbO7IDoKq+KHjK7VGyf8
         d0zUNwZxHWQ2eeBxJoefYXbAldGbzk3LehCsjZs+kumXrFWYZY4BAKfKW394q/khataw
         D5/2/8XiEC1Fd88bgmaeGhd1pVMaKsw2DBxUg17AuNoTOXp6EBRA3YBKwDXAOSuZjFou
         5szg==
X-Forwarded-Encrypted: i=1; AJvYcCXHomxebHY+Ur9hkOLE6upTSh1vNPopsBvtXkYyK6vrwZA3QuB22NzB0O0l6UBDzRAKTKXJHyDr/aGHfUzxid4Yhi1zvG+kQcNqpMiF
X-Gm-Message-State: AOJu0YwuW2X0t6q1ewNhm3+Z5+vyhB2sDKpD30NpkwW0CzBTpE5Rl29W
	GFDfqzPB62nMhpXnC70TYcFSpcOwiStiiwI6pB/XXPaEWo4CIBNbTWuPqzbIlsI=
X-Google-Smtp-Source: AGHT+IHnK3xm7CMZ4D7teNrVAR475tu+8odtu8N0waL9N53OtCwv49PY4AtgG8UEQNcltk7ayCBSBg==
X-Received: by 2002:a05:600c:46cb:b0:418:a786:3760 with SMTP id q11-20020a05600c46cb00b00418a7863760mr6722875wmo.15.1713793443690;
        Mon, 22 Apr 2024 06:44:03 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm20731069wmq.6.2024.04.22.06.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:44:02 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/4] ASoC: qcom: sc8280xp: add Display port Jack
Date: Mon, 22 Apr 2024 14:43:53 +0100
Message-Id: <20240422134354.89291-4-srinivas.kandagatla@linaro.org>
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

Add support to Display Port Jack events, by making use of common helper
function.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 878bd50ad4a7..38f97f19add9 100644
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
@@ -41,10 +44,21 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
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
+		break;
 	default:
 		break;
 	}
 
+	if (hdmi_jack)
+		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
+
 	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
 }
 
-- 
2.25.1


