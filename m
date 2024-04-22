Return-Path: <linux-kernel+bounces-153479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0798ACE91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975CA281A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540E31509BA;
	Mon, 22 Apr 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Au0Qv3by"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9E150981
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793445; cv=none; b=MIWQUtLo5WR5BBnavpw3OkoJzYRU7sqzop8HNPimzcecUR6LLiUU7MN8WY9rJbf44UbmwXU0mWc3tGdAuClhFEViWdJ7Trp5wk/ebj8u5+CnwN1DUOPxR6w3S9pzBgNINsikTGcLbQxHx91svbg2Vct2L1py7A0EnJtzR1avnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793445; c=relaxed/simple;
	bh=QPGkywHhxJwbRVmkKg4yvrDXLaFojPp13JVOp7ayaxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQ6RkoDdP59HXpQTzf9VYFf5Xh2QVe/eXfWPMRsNFynzJs4aoRRvC6F2xcRaqEKZlHj6dV7k7z4V6i1WiAWpind5sBi0j0QnWMPNc/G67lLb9Vcjmku6ayxmEQkePgRI9yWRzDa4demQAxXuevVZkl8JDAoi7ic+eRd/xzYKbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Au0Qv3by; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3465921600dso3960418f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713793442; x=1714398242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DCZ+LurAPUpbkstxc4dh5F2TeDg5m/lAZJCQ3k7AMU=;
        b=Au0Qv3byobwaaub26oFA22SLu1mNmnRAIhpclfeKZDMCuHpSu0dUqgwZklL7A6UjWL
         7AULhuWnB7G2H82jDUIvxfy0gGYQwJZSiV1fzG/onONiCydn1ZLod5QnJ+JxmzUAmSz7
         YNio+FttIDmhhVqPBa5Tdi9J0xbKk700DvfSexPpJu4BYGxIS8bO3Nh+M3M2j86Fa6ag
         A0/VsVkC4H1Fu3zSp/0VQTAPvfWfg/5tDtAN56nB8N1Tff2SZgXttSOpMSId168NW9oI
         yfqXe6fPPPOxYuyw6Ua6hYVD7j15DD47SYCfC7tK0Kz7Q+5xkfRVmV6SZMI7GvT/mrZG
         cfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793442; x=1714398242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DCZ+LurAPUpbkstxc4dh5F2TeDg5m/lAZJCQ3k7AMU=;
        b=jP+ZlEROdoFZJ0s4hPMn3a7h0nBUilXOxZuJJ2UgVkcd3Gdyin8IIVmx37ByCN0gXA
         oZB9+g36OfiPolXT7+PgRZipbpBXiA9Gm8AM9LGG4LZR8BYUbaIjRPM0JZ4gyScFrgPt
         DthDZ4bml4dSAnx9A2b+Z8y/ZqQYScEITr+lUxnh26AV+WlfQ8/43xm3xO/utcfQOupW
         XCHl3LdeDSGGSID7vnvX9iU6Is0sHE9mOs6QYy9358c0gASExl7HdU/CgaZjad0VMK5b
         7IaBEM0mtxE3Vyd++8cr9u7iokvTnvlwwCpRYHy8fEhyqBca6TT67y7lcdFYiLD7jPsh
         Rhow==
X-Forwarded-Encrypted: i=1; AJvYcCXDWhPlYvl40QEfCABw/VEomf88J0LCYDcVy6H61+DnH4TulkKCT+egxlqjYQ7i5e77NIl8W6bOWKRvrP9y3lTdoaob7sbJzsYMmaD+
X-Gm-Message-State: AOJu0YzrrviijmeCjyBMk69/5YknK6SQUCHESvEuPbNPQJlD1iqjQZOf
	wP8dSscDD4YCQiLX2XiERM9NRDHfowHzGYd2/q9jOcoGJfytAk/3fp3HzsQVuzo=
X-Google-Smtp-Source: AGHT+IEq1VrIPR3upvHPe1XfDjkR/T391HRzjxsXogocBrP/QBTphSY+BSVPlcXSaBcwT4MucQNb0w==
X-Received: by 2002:a5d:6a07:0:b0:343:77f4:e663 with SMTP id m7-20020a5d6a07000000b0034377f4e663mr6457055wru.18.1713793442317;
        Mon, 22 Apr 2024 06:44:02 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm20731069wmq.6.2024.04.22.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:44:01 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
Date: Mon, 22 Apr 2024 14:43:52 +0100
Message-Id: <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
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

Add a common function to add Display port jack, this can be used by
multiple board files and avoid any code duplication.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/common.c | 29 +++++++++++++++++++++++++++++
 sound/soc/qcom/common.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 747041fa7866..3bfe618e7bd7 100644
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
@@ -239,4 +243,29 @@ int qcom_snd_wcd_jack_setup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_wcd_jack_setup);
+
+int qcom_snd_dp_jack_setup(struct snd_soc_pcm_runtime *rtd,
+			   struct snd_soc_jack *hdmi_jack, int hdmi_pcm_id)
+{
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
2.25.1


