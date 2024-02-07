Return-Path: <linux-kernel+bounces-56153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7262C84C6BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291C0286E07
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DC20B04;
	Wed,  7 Feb 2024 08:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgIN1qOX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D6208BE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296182; cv=none; b=HVEnWtfDWyNWPSmcd05cwokt0jHNq7yJA7PkPTSsPk5DQOUhDZCBC/vYx+eRTVkVarcz/1xBR99oGUm6er5toG64geR72ufdRcSDomJAG+H5mnR7V85XywoQYxLgoRkieS5SWHTJKSVsYBIm76GkYa9dYYzsdNK56QRL4YEYdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296182; c=relaxed/simple;
	bh=rdI7GKfCdnOTmpOBilN9O3JEYPXprn3uJX3z0L0jrNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KF1pC6DycGNlGV6aLioOkgCMQcUu6rYnH72hAK0CxW9+ctOJXYdrhXaDASgfHxPgPgyKxSllzNikCOI9cIhCKsjNPr5zQ3NM28B1bTaykLrlRvyBcMLm97bnvF2n06m4ynsxAozT8IjC2vwhfcOCKJykWghyrQdbDZbiY00UJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EgIN1qOX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33929364bdaso245603f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 00:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707296178; x=1707900978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liXIACRKvjoHSHWwJp66EaeDBptoHrPZ41e1VyEQRh4=;
        b=EgIN1qOXN0/7H2tP6fnNpYNv3aGk0+R148CPJ2udvrkRXCEW/om7hI6jr5MG1P4clT
         yoZgPsExfOZm/RydhIUbl/R1WVHgVI7xHvsQAZyU+r75FxBeoebkNc8YqUuz6DZEf04d
         y626juUUkgLu/MaZqV2Uuj/Q2JBLV/+kEKlE7wNyxAjurCAcg7RGgxZTFfMHF/keVRcG
         FNq6f9BrmdoYTv3TVCGbAnaWsEuIw5tLN3aJG2l/WdTiy6sIQPnNI3nmT1m6dJdNyD+k
         18ZYMQ36Pvof3nB1xhZNk6fk0kuH6XNR4LMBrqpXyR6MFUNk0DRBuMJIIvoOuwNk8Z73
         nNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296178; x=1707900978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liXIACRKvjoHSHWwJp66EaeDBptoHrPZ41e1VyEQRh4=;
        b=BOSu7u2hALwxqDLkwSP3LUx9gJGVU9Oja3C1w0BS0fIJT0kkp5IEsrT5syhr9ZG0YP
         oe/Esi0KkA0a7UcH1x8BWSvMi6/lVrXQTd6d8B374T1im7SPFRhXsbA32Gwit9atPO75
         0n0v/Re23cIkiZ19oXzwg0hHHYG7NJtwJzHYUhIK2n7PZxpfw6Xnd+gbjMuDzrBC736e
         vwwFG8Ph9WmYHV5ynwykljQnE9ReMZmGRlXFTsc+W0G8enWCsVdrG45DLnP+NvtX0pgh
         MoOh76wQhEyz1VNutVG4hqVGzObYDzghNnGaTyBWIhskxtOa23tfdrI6M6xPRvmwHRJZ
         AduQ==
X-Gm-Message-State: AOJu0YzYUBZ8kudrGV+u9rzo1otAYtLInzXdnIi3Jd24lzXRUryBeBc7
	EIX0Ugux4g8OZOMpMsk3gxLcOLfUunkN8PYivK0GGK4em/OQ4poxr5Eodsj3LQ0=
X-Google-Smtp-Source: AGHT+IGG4lgfUy7JblzBNmRU3galTvfd8NG+BPtV/bukRFe8CGhSGAjN0T6v7Gd/gCz3yHRSlji40Q==
X-Received: by 2002:a5d:4450:0:b0:33b:3dcb:9564 with SMTP id x16-20020a5d4450000000b0033b3dcb9564mr3179404wrr.2.1707296178423;
        Wed, 07 Feb 2024 00:56:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVN2mmboPNrx4QSdEpEN0shWCb1v/FLThDbfLxSbrbu80KgzR3it+oW+lvniE39OxwScqTjuZc93thwx1od88Zt2LFp6h7UrQKjOJs3ETFF20ZZaHqi4j6X5YgWttGXHfRXocWSBLT3+1BmrXVPlRtMEPCKOrJ+wxbne7A3VqM6QCnvBpvWGbQxjdMEaKqcDixHVpsRnm9gx8LwaX2Qx8b9gej1xa7ObrZT8OWMzwGsWqjz4gdaqM5cqo6NroJPlFvNXrp94Ctp
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r8-20020a5d4e48000000b0033ae54cdd97sm940204wrt.100.2024.02.07.00.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 00:56:17 -0800 (PST)
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
Subject: [PATCH] arm64: dts: qcom: x1e80100-crd: add sound card
Date: Wed,  7 Feb 2024 09:56:15 +0100
Message-Id: <20240207085615.27187-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sound card to X1E80100-CRD board and update DMIC supply.
Full schematics are not available and the limited available parts
suggest that DMIC0-1 use BIAS3 and DMIC2-3 use BIAS1.  The DMIC supply
is unknown except one remark for VREG_L1B that it is "used for DMIC if
no WCD".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No dependencies: everything was merged.
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 94 ++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index 12abc9287a75..72b787ce4b20 100644
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
 
@@ -494,6 +582,10 @@ spkr_23_sd_n_active: spkr-23-sd-n-active-state {
 	};
 };
 
+&lpass_vamacro {
+	vdd-micb-supply = <&vreg_l1b_1p8>;
+};
+
 &mdss {
 	status = "okay";
 };
-- 
2.34.1


