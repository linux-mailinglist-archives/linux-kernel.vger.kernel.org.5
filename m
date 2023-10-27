Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E197D95CB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjJ0K6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbjJ0K6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:58:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F6D18F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:09 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40839652b97so14065115e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698404288; x=1699009088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnRkBO9T7mpu/9qbQ4qd8eFU+MMR5Opxp/fD1o8ihl0=;
        b=tTGEbMgGo14cjFdrj+vbbt48kF5PZMQgAnAwFpzNOORnHHbASE2AxcmWdT58jLGBlA
         1CuT9Viv9KZNjn5XdjCB8DBRRADE5K6Ep8IScP9mi7vMj//TnfUdxhKq2i1CjRtg3Z3Q
         M+JJjtTRoQkK2/STw5mH0PHDp+FzGuoub4tTGNa8mjfTnwMb+jLPpmperB806jscGPv/
         6D3FLw6Qphv9wDiRr5v4kj/f3ThxWezueOa9JCjB4W7edQR6NicqeLGkFXRYuTakJnMC
         N7SKinQTVKGQbRibfe2h3Vgeg9Iy0oS8KJgHmEqnZQEUqJdvA+Tbg0yymZMGnIrNskUo
         zsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698404288; x=1699009088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnRkBO9T7mpu/9qbQ4qd8eFU+MMR5Opxp/fD1o8ihl0=;
        b=ioRhJcFRXXLcZG6iTqBASuXCUWDxIRcYzVp2mjR4KCbCfzgaWMg1qUL2YCsv8/4pSr
         t2YbW5TQmj2G602DfGQu8SmkbidrSoH5LyA/48tVpV4rekfTpTV6WqOlb0QP6Fwwoouk
         6Lo/hCFYGaUI6MurODyf/T02nMJd2gC0Kj9UhSmcgyL1kG8Nozhs/XIKfevISpDG/8qG
         B/lRoqXuzpfWYlRqt9Tvcd3E6kCxat6agbmocXXmN1mwP78j7xvGWKIixXA0Pc8ywf3a
         YiY3pgZNf2MT1ZaO3BB1zNiBRhNHcmPzy3zKzoXkWZxuFj0XObFhzo7xXmN0uqlL0oCP
         H8Kw==
X-Gm-Message-State: AOJu0YzpSwXcxel0XZKla7VajKH2EEFnLi25fDh6GQ4Pi23SOD3Ap5Rn
        88u8NK8hBzOIIP5A0OBa3Cw+fw==
X-Google-Smtp-Source: AGHT+IGebDNbdDKX/IZobIxUnkODGsr9PdTVtrGQ1bCRfn1/ZgdLC1oMrxdvfJdXxEp3U1pvkCGVew==
X-Received: by 2002:a05:600c:19d1:b0:405:3955:5881 with SMTP id u17-20020a05600c19d100b0040539555881mr1831887wmq.36.1698404287889;
        Fri, 27 Oct 2023 03:58:07 -0700 (PDT)
Received: from srini-hackbox.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b004065daba6casm4819626wmb.46.2023.10.27.03.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:58:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     johan@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 2/2] ASoC: codecs: wsa883x: make use of new mute_unmute_on_trigger flag
Date:   Fri, 27 Oct 2023 11:57:47 +0100
Message-Id: <20231027105747.32450-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
References: <20231027105747.32450-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setup the PA is left unmuted even when the
Soundwire ports are not started streaming. This can lead to click
and pop sounds during start.
There is a same issue in the reverse order where in the PA is
left unmute even after the data stream is stopped, the time
between data stream stopping and port closing is long enough
to accumulate DC on the line resulting in Click/Pop noise
during end of stream.

making use of new mute_unmute_on_trigger flag is helping a
lot with this Click/Pop issues reported on this Codec

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index e40d583a1ce6..4ea550b0601b 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1203,9 +1203,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 			break;
 		}
 
-		snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
-					      WSA883X_DRE_GAIN_EN_MASK,
-					      WSA883X_DRE_GAIN_FROM_CSR);
 		if (wsa883x->port_enable[WSA883X_PORT_COMP])
 			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
 						      WSA883X_DRE_OFFSET_MASK,
@@ -1218,9 +1215,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
 					      WSA883X_PDM_EN_MASK,
 					      WSA883X_PDM_ENABLE);
-		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
-					      WSA883X_GLOBAL_PA_EN_MASK,
-					      WSA883X_GLOBAL_PA_ENABLE);
 
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1346,6 +1340,7 @@ static const struct snd_soc_dai_ops wsa883x_dai_ops = {
 	.hw_free = wsa883x_hw_free,
 	.mute_stream = wsa883x_digital_mute,
 	.set_stream = wsa883x_set_sdw_stream,
+	.mute_unmute_on_trigger = true,
 };
 
 static struct snd_soc_dai_driver wsa883x_dais[] = {
-- 
2.21.0

