Return-Path: <linux-kernel+bounces-62219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F3F851D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489A31F2417A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC94445BF9;
	Mon, 12 Feb 2024 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cnnn5VNN"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3717F45BE8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763450; cv=none; b=jXr/OVgua1DUAiq1wnjCw0F20VXmIoG+1/PPnoBOdQ1ny1rFnIM6pVIj9LzjwVUnG64aNkTVIwF2+e+wTP1pkbCdmlzEWNXgTbR8+/v+BNm4RNvNvkD/suaNuKs3NsVLzpXYQmaOVdF6/4zWjOCj869/iUZ+7EAGD8Imss/FdkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763450; c=relaxed/simple;
	bh=ggjzpCTsIN11gB0mcnOs/blBuM22pBJUK+jpoAbT0Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VjJZ9M4+CHROSGadaCe2DV0E9u0pTqpfx0wQWEK9hPnzpTDHfYljffooT4nxSmazJ4kY9Ymx2tTFrkfWhtgelGjQdsGHnjnVfmyEJS34kvwJ/BiV0WzrmfFCuEzL2se9bh0HSO9BbPU39OBMK0PtnkAN8k+4seRsn3UiNLkjtQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cnnn5VNN; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b8807b55aso501838f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707763446; x=1708368246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cLI6uvtWJiJNaaVlPDaGYM7oaeBfeQ4b4L3zMgYgLRs=;
        b=Cnnn5VNN+fHonnaAhN+9xNVYxUL510NHin28Nu0H9REAljXpomBEEkns0z0proiKHe
         0b7E49Vq/VO0X0ucXoFqnOFOxTU7nlz+YaYZcUdO092ed0UWt8J1MJXrkKnQIAwoNwdT
         LNx3JBK35qM7StkdNk2Q1TEw6snCabB3ZmP8cX6rKDZbi2w5wAnyb7+pkG2udpo2akKJ
         Mjj43lRckcuuB0H6zcqLt1W2tP4aurlT5sfCxDWRSOkUFC3kZeZ77B8fVCqk28vnKi+B
         9lucYb0uQYIEiCqwfAzze1NmpE1Bk4EA81XTJnSMhZXR0NJNqJOUl2shOaC/3WwWhki5
         FQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763446; x=1708368246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cLI6uvtWJiJNaaVlPDaGYM7oaeBfeQ4b4L3zMgYgLRs=;
        b=KBEHsY8Z21I0NLP0FQZP9zoYkv5ZtV+Dp3GLuTYWojTXeNa++I4iX2QZagXWjNoZQ3
         hkaTcmqq6meQ549R/qNc6SXN/wt8Pi6tGzn7c/KY0c6UzPofgqncrY7s3j30k2ybwHOb
         QoRsfFRt/dVqdANW0X5dAQPcWeT4NhEFFa5+SZK6Z+N3hUKdnRTcuxqEpkYxboGRCIDi
         zbmJuw9rbOT8BvK2K1BumhOrqJ3CvWW/kSiqB0AM0F+UjF6Fb0HFT8+LKiMZ7O2cCyDK
         xgflWAqsG7XTahWIONkz9g7gugY8aScUXkSfwIvj/EZ6eojP35TayS8RRJ+8i0F+ifdq
         ZDyg==
X-Forwarded-Encrypted: i=1; AJvYcCXAtQZQ6KkW2rfR3Ar0DxuEdaz2uqThDWNiX6uq56c0CShGgOpMvjmPX82IcZOXkybYKZ6BBKxFHNIaDD0rYJ8HAgKsdGgVAR7qKHY7
X-Gm-Message-State: AOJu0YxV5ufHqmkeH9pVoZ4ciR6lRmSYLTPo7O0KXMDvT6hFQrfUUkzW
	PhTiCp9Ox5Dm8/z416TrrsdXwOLuBBdpIRzbLph9HgR8mP37gJ/njPmo7VNsyX0=
X-Google-Smtp-Source: AGHT+IHLbJI4HfzbTuKjLym5/RCgm7GtPC5HjkGAf5cn6cHNV0VwlDqLTCQaOgq8c81mozNchAy57g==
X-Received: by 2002:adf:f189:0:b0:33b:8787:2d9e with SMTP id h9-20020adff189000000b0033b87872d9emr1533322wro.44.1707763446509;
        Mon, 12 Feb 2024 10:44:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7wUI9UR3Q6Lny/OeoyG49MdQiMsbnvgoN6SbRUDpFrqJeb7yvikH/y86E7x0MrbZdrAXEdymyFhPev9OG2LxF3vB5l5l1ZBJ+aAUSYXFAGrJuDEhAx4VpLMpKKCRAr4qIQvyTffELv/pys/dARgK9yX383hTjjqOuf6pjYaFu9bu0MjVVTjwSfZ4BCGfiWnzKYaANbJeioGBJ0NKHy6HSjv25UcCAFBBqt7/Rgkavgib3tCmct2vbaivVVcbrWVrhMo0X0wTV
Received: from krzk-bin.. ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id w13-20020a5d404d000000b0033b4dae972asm7448371wrp.37.2024.02.12.10.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:44:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2] arm64: dts: qcom: x1e80100-crd: add sound card
Date: Mon, 12 Feb 2024 19:44:03 +0100
Message-Id: <20240212184403.246299-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sound card to X1E80100-CRD board and update DMIC supply.  Works so
far:
 - Audio playback via speakers or audio jack headset,
 - DMIC0-3 recording.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Change in v2:
1. Rebase omn dmic02->dmic23 renaming.
2. Add missing dmic pinctrl in lpass_vamacro node.
3. Add Rb tag.

Depends on dmic02->dmic23 renaming:
https://lore.kernel.org/linux-devicetree/20240212172335.124845-5-krzysztof.kozlowski@linaro.org/T/#u

For full bindings dtbs_check compliance (not a dependency!) also needed:
https://lore.kernel.org/linux-devicetree/20240212183800.243017-1-krzysztof.kozlowski@linaro.org/
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 98 ++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 12abc9287a75..6a0a54532e5f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -18,7 +18,7 @@ aliases {
 		serial0 = &uart21;
 	};
 
-	audio-codec {
+	wcd938x: audio-codec {
 		compatible = "qcom,wcd9385-codec";
 
 		pinctrl-names = "default";
@@ -48,6 +48,94 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	sound {
+		compatible = "qcom,x1e80100-sndcard";
+		model = "X1E80100-CRD";
+		audio-routing = "WooferLeft IN", "WSA WSA_SPK1 OUT",
+				"TwitterLeft IN", "WSA WSA_SPK2 OUT",
+				"WooferRight IN", "WSA2 WSA_SPK2 OUT",
+				"TwitterRight IN", "WSA2 WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS3",
+				"VA DMIC1", "MIC BIAS3",
+				"VA DMIC2", "MIC BIAS1",
+				"VA DMIC3", "MIC BIAS1",
+				"VA DMIC0", "VA MIC BIAS3",
+				"VA DMIC1", "VA MIC BIAS3",
+				"VA DMIC2", "VA MIC BIAS1",
+				"VA DMIC3", "VA MIC BIAS1",
+				"TX SWR_INPUT1", "ADC2_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_woofer>, <&left_tweeter>,
+					    <&swr0 0>, <&lpass_wsamacro 0>,
+					    <&right_woofer>, <&right_tweeter>,
+					    <&swr3 0>, <&lpass_wsa2macro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 
@@ -494,6 +582,14 @@ spkr_23_sd_n_active: spkr-23-sd-n-active-state {
 	};
 };
 
+&lpass_vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+	qcom,dmic-sample-rate = <4800000>;
+};
+
 &mdss {
 	status = "okay";
 };
-- 
2.34.1


