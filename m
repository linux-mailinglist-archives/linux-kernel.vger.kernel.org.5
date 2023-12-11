Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BA80C54A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjLKJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjLKJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:54:08 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E128E;
        Mon, 11 Dec 2023 01:54:14 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5bcfc508d14so3580295a12.3;
        Mon, 11 Dec 2023 01:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702288454; x=1702893254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA04sfNkH62YtYg6Nmq5x2j1Jcg5BYJtxmdnCLXGgCI=;
        b=mrb5bq9bp3XzapTLBupayEIyRgwXPGUJz/OAQY89hYHjUHJNnRMdWGDLZ4VMXFzKvf
         qei+E6U9kwoBVrDxp/UwoPzPoKt4g2bbOK+9EGyQ02/JFjRxQBktXlX4FkRT71z3ZLhY
         0kQi+NsJAkGRa0E31W494VMcpucmsNjrxsM6XMU7HWUfCLTVgKl/vSb/fbH0zEIqNgwL
         hiPfqkH8qW7xVyo8tvs3ftaJ4wfx4gCGM6/W8S4rHjD+8sLwgQPLiySDw76koAyDVgwl
         HT6tcqGjh3NbvuAQoWkYN1AivIKZEfYWiJBMsCTSjPN1yjYqlp7TAe49cJERggctlZLN
         zU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702288454; x=1702893254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AA04sfNkH62YtYg6Nmq5x2j1Jcg5BYJtxmdnCLXGgCI=;
        b=quNPiv/hutHlwnjI8yO8uc+YJZDtafIYJDaBJhV0cyy7HccnhYBRDyLy4R72RcIVAo
         ILPkj/XDvFwtyB5dOJ2ptRi8gRzD9S7ow0ZiCQrVHvMdEay9G7p7cPdmYoq9ZrUB5o7A
         0ueUU4s0GHp/G5ahmbdGXDAwW54UIVIqtFSF2bik+peI8kLjFj24eg3RsUo8x/Sn04Ht
         DIvK3ZSpWEWXDLwvrMtPAJ6X8pqK/59PduMw/vOAYKsrJz8/7al6Z7mGdOHXeUKNrUiB
         vMuKI+5GHIt43cwDYZ5ffubY3vBDW73lw0JyEb/+cPDg4uB0Zht/fkFR7b6eoevKYeXb
         ZILg==
X-Gm-Message-State: AOJu0YzAGmnpE9cVsD8Kua0k13CLOz9D9B+2H8+A4T7zEJQ/Zs+TSNHN
        nRulFNp9zPxTDdSd6P+L7E4=
X-Google-Smtp-Source: AGHT+IFqSNjgBxvcCASuoNTVlJPNlgjlLzFSaeUpu44Ey6GZeodxdNuVHFZImKjMy0H9Ph6Aiyyh5w==
X-Received: by 2002:a05:6a21:789d:b0:18f:df5f:d9f3 with SMTP id bf29-20020a056a21789d00b0018fdf5fd9f3mr6159341pzc.91.1702288454100;
        Mon, 11 Dec 2023 01:54:14 -0800 (PST)
Received: from localhost.localdomain ([2409:8a6a:5426:70b1:a6fc:77ff:fe50:e63d])
        by smtp.gmail.com with ESMTPSA id mt20-20020a17090b231400b002853349e490sm8149734pjb.34.2023.12.11.01.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 01:54:13 -0800 (PST)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>
Subject: [RFC, PATCH 2/2] ASoC: qcom: sm8250: Add TERTIARY_TDM_RX_0 support
Date:   Mon, 11 Dec 2023 17:53:57 +0800
Message-ID: <20231211095357.4629-2-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211095357.4629-1-lujianhua000@gmail.com>
References: <20231211095357.4629-1-lujianhua000@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TERTIARY_TDM_RX_0 case to make speaker amplifiers working
on xiaomi-elish tablet.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 sound/soc/qcom/sm8250.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f298167c2a23..00c89c073e72 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -16,6 +16,7 @@
 
 #define DRIVER_NAME		"sm8250"
 #define MI2S_BCLK_RATE		1536000
+#define TDM_BCLK_RATE		12288000
 
 struct sm8250_snd_data {
 	bool stream_prepared[AFE_PORT_MAX];
@@ -53,6 +54,7 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct snd_soc_dai *codec_dai = snd_soc_rtd_to_codec(rtd, 0);
+	int ret, j;
 
 	switch (cpu_dai->id) {
 	case TERTIARY_MI2S_RX:
@@ -63,6 +65,23 @@ static int sm8250_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
+	case TERTIARY_TDM_RX_0:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_DSP_A;
+		snd_soc_dai_set_sysclk(cpu_dai,
+			Q6AFE_LPASS_CLK_ID_TER_TDM_IBIT,
+			TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+
+		for_each_rtd_codec_dais(rtd, j, codec_dai) {
+			ret = snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+			snd_soc_dai_set_sysclk(codec_dai,
+				0,
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+			if (ret < 0) {
+				dev_err(rtd->dev, "TDM fmt err:%d\n", ret);
+				return ret;
+			}
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.41.0

