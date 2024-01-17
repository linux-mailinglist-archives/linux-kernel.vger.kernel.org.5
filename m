Return-Path: <linux-kernel+bounces-29181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89400830A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D1791F22A10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731F22318;
	Wed, 17 Jan 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aqhsRBoW"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23022301
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507311; cv=none; b=E1ZZAKLsDKGsJ4DZ/rbF51NbbzBEv3T7A+n0wVsARQtc3XzFTN3BKoHcVdJPn74eO0APSsSWRGLyY8XEpwU4hGvb6hP8DK5pCcP3OVZd+E9LPf1yznU9PtdmcPyDpohhOBAcUGUdlDtVQtdbisWpDyDOU8ytUj9YQ5iTrWb/CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507311; c=relaxed/simple;
	bh=wLSVYE15E2g90Dj0K7HUb1DitgDJMY1HXgqE3IAaJfE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=uohFaVn5EP9281DQrmjpXjaMMs3pz58SsjpKmpn/3WVHMB16inzPg7XtPK14gjunjpzkms+W8PG94RAOOmc5IaKC1+1WEutcO0JMgOxCVrz3oNFdbRyH5CzNemyon/QX5Pf/MEC0VZ84pSyJ/sIbPcCGm6Z/DHpAAy+cHLYAeZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aqhsRBoW; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso11881271e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705507308; x=1706112108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RPUZBZDrfdYl4F0b5cPRIc1XdwQaC23i574HsCddaAI=;
        b=aqhsRBoWYZsp3mXhbHvf3T+adEsrC3ucM+vcdeDWh3WEE8M1J7Mw9hkO0pG56pJqxK
         WYmb/VNA0Qbv+EnwQZ0TlH4a1dqcyqnyJaSqUKOcVitMVredvmHsyv1aJisCLHlJ/U7H
         ZmnnRuTjtp8sm/s6reLnDQ2+q8QIWWNzyyDvPReRRihmc+6NkN/sVadju/yJMEURVoe3
         HtV5SkoaXP1FuJPH8wxIbmfx5lX8rKEFbAs/Sizb9Cvl/uWzzL/BTKbDQ1iAfJIELlSS
         4UvIzm8SpQxya9F2BAlGvVE2I/+THQvK834oetxXF+myF1KdGb3MtRVEuqYcWdGb6rAU
         kDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507308; x=1706112108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPUZBZDrfdYl4F0b5cPRIc1XdwQaC23i574HsCddaAI=;
        b=iY1oXbbDuKo6Hf+FNSX7twvSQJC+EtFPWBuGvA3ewPHKISVp752KecezWsGG63DjL6
         gTdUKE7ypSORzWuCHtcUcXdAQlfPPG2XPZ4nvT1LctJpm4cCPghQT3zzgOJhjaYDLhqp
         niHeLgYjGJhkqwAk/+GQ5KlqjmSXYJHSEiXQJwq/5b2AjbdbxVNK9baRi9Alf7htNQ39
         hXCi1QUn69BtfX0Kw0XktsxvO9ZB0urRHPlcWXC+VlSMzzM0uxADE804dzcz9oC9fkiv
         1t2AuxFBgDiD4pCJPLrswlYCxi6y8TL5R2auQ8kREWnwk+d3xIV+Jw6iX7jI7cjNNium
         iYug==
X-Gm-Message-State: AOJu0YzcpY+miu5TriS7iZ+0ZdACuc+zWPfs61fled6dLnz2Srm2aVqr
	3pj9sYxUo0kdPHBKkiJeMelpeKFa9T8FXg==
X-Google-Smtp-Source: AGHT+IGnzExKU0R4Qn+CYcC37yXpWuIxghDl3sUWiaidmjt27s2vQQnDPD+7b4ohIsNOYcVEgtoseQ==
X-Received: by 2002:a05:6512:b19:b0:50e:2bf0:dd6a with SMTP id w25-20020a0565120b1900b0050e2bf0dd6amr5479909lfu.13.1705507307888;
        Wed, 17 Jan 2024 08:01:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709061c5200b00a2ed534f21esm834409ejg.63.2024.01.17.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:01:47 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: allow up to eight CPU/codec DAIs
Date: Wed, 17 Jan 2024 17:01:44 +0100
Message-Id: <20240117160144.1305127-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sound card on Qualcomm X1E80100 CRD board will use eight DAIs in one DAI
link, so increase the limit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The sound card machine driver is already accepted, but the DTS was not
posted yet. I plan to post the DTS soon, after merge window.  The
almost-ready-work-in-progress showing 8 codecs is available here:

https://github.com/krzk/linux/blob/n/audio-sm8650-on-neil-codelinaro-topic-sm8650-upstream-integ/arch/arm64/boot/dts/qcom/x1e80100-crd.dts#L175
---
 sound/soc/soc-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f8524b5bfb33..516350533e73 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1037,7 +1037,7 @@ static int soc_dai_link_sanity_check(struct snd_soc_card *card,
 	return -EINVAL;
 }
 
-#define MAX_DEFAULT_CH_MAP_SIZE 7
+#define MAX_DEFAULT_CH_MAP_SIZE 8
 static struct snd_soc_dai_link_ch_map default_ch_map_sync[MAX_DEFAULT_CH_MAP_SIZE] = {
 	{ .cpu = 0, .codec = 0 },
 	{ .cpu = 1, .codec = 1 },
@@ -1046,6 +1046,7 @@ static struct snd_soc_dai_link_ch_map default_ch_map_sync[MAX_DEFAULT_CH_MAP_SIZ
 	{ .cpu = 4, .codec = 4 },
 	{ .cpu = 5, .codec = 5 },
 	{ .cpu = 6, .codec = 6 },
+	{ .cpu = 7, .codec = 7 },
 };
 static struct snd_soc_dai_link_ch_map default_ch_map_1cpu[MAX_DEFAULT_CH_MAP_SIZE] = {
 	{ .cpu = 0, .codec = 0 },
@@ -1055,6 +1056,7 @@ static struct snd_soc_dai_link_ch_map default_ch_map_1cpu[MAX_DEFAULT_CH_MAP_SIZ
 	{ .cpu = 0, .codec = 4 },
 	{ .cpu = 0, .codec = 5 },
 	{ .cpu = 0, .codec = 6 },
+	{ .cpu = 0, .codec = 7 },
 };
 static struct snd_soc_dai_link_ch_map default_ch_map_1codec[MAX_DEFAULT_CH_MAP_SIZE] = {
 	{ .cpu = 0, .codec = 0 },
@@ -1064,6 +1066,7 @@ static struct snd_soc_dai_link_ch_map default_ch_map_1codec[MAX_DEFAULT_CH_MAP_S
 	{ .cpu = 4, .codec = 0 },
 	{ .cpu = 5, .codec = 0 },
 	{ .cpu = 6, .codec = 0 },
+	{ .cpu = 7, .codec = 0 },
 };
 static int snd_soc_compensate_channel_connection_map(struct snd_soc_card *card,
 						     struct snd_soc_dai_link *dai_link)
-- 
2.34.1


