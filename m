Return-Path: <linux-kernel+bounces-151619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6678AB132
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA7C1C233C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A5512FB04;
	Fri, 19 Apr 2024 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq/C0LVY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8C12F394
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538912; cv=none; b=ODChFyzZhMu5eBkKxu0qvboswwt2jZtJ6vYXJYR7w4YDsn5JZa5XAH2j9U/tHjTHGBa3mEMMpmdJgQQuDhTtP1AOcqpT2ICOYHq4tCRVyrPOwA6jKENqdMNiBQ1QwMX6YvfBcSqGKkEsS3FqAYPPOnrUWAlww+atZjikFmcS874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538912; c=relaxed/simple;
	bh=Yaor62sYcDjIvBNPTk74x1zdaU8YS2t8ezX+C3LnvTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l/bgD11uYlZGVRoX1kKdQ4wCyX+itsrPXf04DTg5REIt+fa57yqxredF1BIohzGfO1o/UbFO+HRio1rU6vJPxuvcYIEAGKDF7yzF6FCUO3pH/rORoNrklr2cyD0X8+FPZ7QA2QD/Tlvpw+k1CPiTgPN/Q4sHk6ikctdkRg7EPEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cq/C0LVY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-418c0d83e61so22760665e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538909; x=1714143709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=du5C0hgzbqVxZXImYAbxQy35/QgbiTxBZrKV2sLLphs=;
        b=Cq/C0LVYPXlF5thEf0+WJF8DHMkcCe/7aP+exe9YYXiZrOGhv8CAdxNYNsNdTlOd69
         KvLUPNiSZsghPjIJ/2TSHIG7b+KK16uZTcJHS2XLhmtuw/h6QylNAScm0fU3ANobzdqE
         iBkymNmdlsXIux+UKnnVMB6K8qf88ZuV37/dHZSCGF/TnbtmJCTdKrwDVg3iHbYOjpsM
         wQpXeG7LywETQzjihCHixQ2IHsblE/TnyCjvhPhuVzcFxD5XAt53AI+T+31IJC298f5+
         aP36NmVkXzbK6aREHOzLOjnDHSGF7zIi5Ft7h3l/ESFUySycBjDigo6mEgm5nRIWK5ft
         eYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538909; x=1714143709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=du5C0hgzbqVxZXImYAbxQy35/QgbiTxBZrKV2sLLphs=;
        b=BUz/7SJ8CDdJHOsyeHB7Qb3VY9Bdt8laSxavUqlYb55PWAZjq42QfoX676vZIIWml3
         MUiX06z82p8Uq6RyCkC5IImHNPMLkY5Ddb14aOviB4LpCGHt0gj7Bq4o0t0ZW2vRB1Av
         cqeeV31OWMjBQbwHTIunkx3WsbR/wH8/CuSQlIbGdUWoL5y99OkU5Fn+OaCYSVwCtLUK
         EO33TPn7+yFkLLm8YCzskeFXIcd6ROyIT4vL5+j+HdPYW9085tn7PQEEO4SPh3cZcvF2
         EI9YpTPa4NTAfguTXrtAqfvFF1tejb6oGRQ456hMjbh1UpywuNc55szQ3mLH4/pJZsIH
         vRHA==
X-Forwarded-Encrypted: i=1; AJvYcCXEH0bKOQTbZI/l0P83Q2t+TohskXbadmVXlSBngYSjEJRpzjtN4T3n3REbCr8w+esVj6M+ffg8DuKpSB0AS5qKv3VtVbnbQMt1o7rB
X-Gm-Message-State: AOJu0Yxo0vl//qCIb66VNqhbxQ8bg3Uk5QU1Pwzcz5YsGfbVl+gOXf7k
	0eG4wTC/pVmg/hYdJsfBHEUrSmmf11L/BKGi6kdjI97HtrFNEouvpb8BYK4rrLw=
X-Google-Smtp-Source: AGHT+IEIK53TDBowNSsIB8o/KBchyuj/pRPeFMmAXDj0MXN4/pA43aqm2tY0y8v2ZBLiX0IgHACxzQ==
X-Received: by 2002:a05:600c:3108:b0:418:b425:d7da with SMTP id g8-20020a05600c310800b00418b425d7damr2069794wmo.32.1713538909053;
        Fri, 19 Apr 2024 08:01:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10660462wmq.4.2024.04.19.08.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:01:48 -0700 (PDT)
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
Subject: [PATCH 2/4] ASoC: qcom: common: add Display port Jack function
Date: Fri, 19 Apr 2024 16:01:38 +0100
Message-Id: <20240419150140.92527-3-srinivas.kandagatla@linaro.org>
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

Add a common function to add Display port jack, this can be used by
multiple board files and avoid any code duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h |  3 +++
 2 files changed, 33 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 747041fa7866..50abd4acaa3e 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -7,10 +7,14 @@
 #include <sound/jack.h>
 #include <linux/input-event-codes.h>
 #include "common.h"
+#define NAME_SIZE	32
 
 static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone Jack", NULL),
 	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
+	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
+	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
 };
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
@@ -239,4 +243,30 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
+
+int qcom_snd_dp_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_soc_jack *hdmi_jack, int hdmi_pcm_id)
+{
+	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	struct snd_soc_card *card = rtd->card;
+	char jack_name[NAME_SIZE];
+	int rval, i;
+
+	snprintf(jack_name, sizeof(jack_name), "HDMI/DP%d Jack", hdmi_pcm_id);
+	rval = snd_soc_card_jack_new(card, jack_name, SND_JACK_AVOUT, hdmi_jack);
+	if (rval)
+		return rval;
+
+	for_each_rtd_codec_dais(rtd, i, codec_dai) {
+		rval = snd_soc_component_set_jack(codec_dai->component, hdmi_jack, NULL);
+		if (rval != 0 && rval != -ENOTSUPP) {
+			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
+			return rval;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_snd_dp_jack_setup);
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/qcom/common.h b/sound/soc/qcom/common.h
index d7f80ee5ae26..3675d72c5285 100644
--- a/sound/soc/qcom/common.h
+++ b/sound/soc/qcom/common.h
@@ -9,5 +9,8 @@
 int qcom_snd_parse_of(struct snd_soc_card *card);
 int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 			    struct snd_soc_jack *jack, bool *jack_setup);
+int qcom_snd_dp_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_soc_jack *jack, int id);
+
 
 #endif
-- 
2.43.0


