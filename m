Return-Path: <linux-kernel+bounces-50037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E48847386
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C871F28192
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60311468FE;
	Fri,  2 Feb 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8A7ENZL"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928722085
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888502; cv=none; b=NjBfjvsD8A9Tfn7uWT6dPczhwGH2XkaFTq3KhQCO5NkQTh4KdPXkZYtsPi9onFIwDXOSsEHRte4Qk9wWmbGuG8YXVkwXJHKVKu4/w/W34YZEdYsBFgH0SZRpD7cMDn2li1/U/c9sZEDeIU4ITVKEW85boUA2E8BpCEBuDRFIB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888502; c=relaxed/simple;
	bh=zlLIb0qKsjq730g/1cSkyRa9Pks3D7J4TqPjUvmN+gU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDSUK/R+tOzwehanWTW1O+dBbbQlIKnvk8oxsTwa23YTR0sZZ19fApOzJ3BRFu4GIydVQUJtLpzg5CNFWIfzXo90Bi66NIBUYEe2zhGD04FYVeNUmzy58++DEaRxf/lgV/NStDu/qBRVb8FxRytKr7E7+yv69s3oWlVYb7XbYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v8A7ENZL; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51109060d6aso3233676e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706888499; x=1707493299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4wtSxCTFL8J3xb+0hRT7NhxX/uKEWkZYK0/+CsMczk=;
        b=v8A7ENZLFbbyjmEnTSOukTddPPYg8NoNSbYLJx1kdvS+K3pLCQ26G8OdrQ+crk07dP
         5ngD/iM14IfNQmxvztMIRAA0NipO2wf8cyH8K1+KDSz6nH5oOTPI1zDTy0+C4CNXzu6W
         637+1zIwBguPb3g+JgnFsVImlBa6bAXXvalD2qUSqWF469YDm6VsIN+78CPhfxtXshOR
         KKsdM+K8Rs9hozankpmzbykbnvau7jZITjMLOGTLVejCSLV6rSa3gcAq+dW+1y2X3pNS
         FSFUxTXqpOSO3vpuOwOkz1MfTCaD9coXNmFT34qRCQo1FQnP03PzxC+xLwaSiBBf62Ln
         QJNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888499; x=1707493299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4wtSxCTFL8J3xb+0hRT7NhxX/uKEWkZYK0/+CsMczk=;
        b=Hhw3nWsm3LXcj1kpdQmziI16gLDpuv5PgjzoBuscEqcQYlYsIeI5YxGB0XVOJ/Xa0L
         fWJ/o3cs85tu+tA8/X2K3WacMtVhnH1OFkIGpJHPfma7lFuAGA2WU+eGXA4+FvaknlJ+
         IKIXa1UyAerDOd6T8tKF4XoimsxeSL0jOV3R0O7mH96xhE/LOzPVyNoC5jr8S/Yq8EQE
         hzUzAlt9TtMwN7GCh29BE9kiUmCDNk9AOGlhWzINv3Rnk8MnfTK2ilDwYly5XRfHweBF
         m4n0bbkmV9vaXInos9+B3v11PtQ1xpufafop5QzwWh6+y61iBXYpacre3NgdJiPhxFBd
         QziQ==
X-Gm-Message-State: AOJu0Yw1m36Ry/brb0RI4MKr/F49/dqWsN7MtSfdjMZQBIVugEyvuR9u
	jurosGvGnmhwGs7A8SrJnLSP5UubBwe8Y1p/UacjQr5Re9oBWhdrvD7LFMQjpQ0=
X-Google-Smtp-Source: AGHT+IGvZgNljdQJeXEnx1Bcsyc/p36FoHZO0vYXUyxE28XL740l3VgIeyf1ign+KzPUYPjVCMqyKg==
X-Received: by 2002:ac2:5969:0:b0:50e:9f5f:a78e with SMTP id h9-20020ac25969000000b0050e9f5fa78emr4073298lfp.5.1706888499418;
        Fri, 02 Feb 2024 07:41:39 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdCsvT7bvaPBStGioEEtBDj7FwEfmLDYxyWNjLHFW21Nw1QSXeO9h8VrqoxGPwvciCqCBqmjK6SMXjJBFfE4g9884EinjfNx8XYvNK5o9Pf8z9ZQDWvMtK6s1gwdWJE5Ic8BFpG+DO/QhK7JLRHQQ2M89fiOQuvAPrjHpsoFzRrQiqrTYNzCsTlONBkUT6DXmPqKh2DKqWh+b0AfiRyXbXlj690POw9IRh/iz2ybEDyYJqFUujU3j6DC/ETDPdjfqYFtsDvxIXt700oIq7MbrnDBCa+aaUwl1dQ/aqDvj2bVjAcVNd
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu9-20020a170906ba8900b00a37116e2885sm624819ejd.84.2024.02.02.07.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:41:39 -0800 (PST)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] ASoC: codecs: tx-macro: Drop unimplemented DMIC clock divider
Date: Fri,  2 Feb 2024 16:41:32 +0100
Message-Id: <20240202154134.66967-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
References: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Downstream driver configures DMIC clock rate through the divider
register but only parts of this code ended up in the upstream driver: we
always write the same value 0, so DIV2.  Same default value is used also
for the AMIC rate control.

Let's make it obvious and drop unneeded parts of the code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 124c2e144f33..cdceccf64ac8 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -38,6 +38,8 @@
 #define CDC_TX_TOP_CSR_I2S_RESET	(0x00AC)
 #define CDC_TX_TOP_CSR_SWR_DMICn_CTL(n)	(0x00C0 + n * 0x4)
 #define CDC_TX_TOP_CSR_SWR_DMIC0_CTL	(0x00C0)
+/* Default divider for AMIC and DMIC clock: DIV2 */
+#define CDC_TX_SWR_MIC_CLK_DEFAULT	0
 #define CDC_TX_SWR_DMIC_CLK_SEL_MASK	GENMASK(3, 1)
 #define CDC_TX_TOP_CSR_SWR_DMIC1_CTL	(0x00C4)
 #define CDC_TX_TOP_CSR_SWR_DMIC2_CTL	(0x00C8)
@@ -270,7 +272,6 @@ struct tx_macro {
 	struct clk_hw hw;
 	bool dec_active[NUM_DECIMATORS];
 	int tx_mclk_users;
-	u16 dmic_clk_div;
 	bool bcs_enable;
 	int dec_mode[NUM_DECIMATORS];
 	struct lpass_macro *pds;
@@ -743,7 +744,6 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 	unsigned int val, dmic;
 	u16 mic_sel_reg;
 	u16 dmic_clk_reg;
-	struct tx_macro *tx = snd_soc_component_get_drvdata(component);
 
 	val = ucontrol->value.enumerated.item[0];
 	if (val >= e->items)
@@ -793,7 +793,7 @@ static int tx_macro_put_dec_enum(struct snd_kcontrol *kcontrol,
 			dmic_clk_reg = CDC_TX_TOP_CSR_SWR_DMICn_CTL(dmic);
 			snd_soc_component_write_field(component, dmic_clk_reg,
 						CDC_TX_SWR_DMIC_CLK_SEL_MASK,
-						tx->dmic_clk_div);
+						CDC_TX_SWR_MIC_CLK_DEFAULT);
 		}
 	}
 
@@ -882,7 +882,7 @@ static int tx_macro_enable_dec(struct snd_soc_dapm_widget *w,
 
 				snd_soc_component_write_field(component, dmic_clk_reg,
 							CDC_TX_SWR_DMIC_CLK_SEL_MASK,
-							tx->dmic_clk_div);
+							CDC_TX_SWR_MIC_CLK_DEFAULT);
 			}
 		}
 		snd_soc_component_write_field(component, dec_cfg_reg,
-- 
2.34.1


