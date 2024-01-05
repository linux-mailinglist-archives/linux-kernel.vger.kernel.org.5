Return-Path: <linux-kernel+bounces-18026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C706825766
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE511C21911
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B590328B5;
	Fri,  5 Jan 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKFQskzt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D26B31A79
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5aefcc2fso16793975e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 07:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704470369; x=1705075169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT3J/E5ihwUzRJFy9hQ6iVDhNFb12f1LhdaU7OTuQXY=;
        b=gKFQskzt/u4Fyqu59e+TLxIiOYzC3Amq0Ld6MEYdXrMlsk3W09Lt2EBS35W4iFxm4q
         5vyi6zjKEFvv7DYQbL3uRMGnH5yknMrm0SYEaNN/ioaNHXmPt5emxGPp5SejTa5FaAOk
         IibSwcb6CsdxYdBJOCTVpWCCRxkj4G0Ul6nMKSsAUPme2pU7hxn44b5xgYV0ADEkQUar
         iozUeAT31AIV0EwdTKlButyJVelMs2QIYWrLEh/OPR6J2bRr7pLoixkd0Ix2XdL+Bb8v
         TwNH7dTvzcH2tEiMl09KaLM9WbsvbnW5QqZvE/Db41AL7AsCG1AKBnQhhKQY8CxdJXJJ
         UfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704470369; x=1705075169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jT3J/E5ihwUzRJFy9hQ6iVDhNFb12f1LhdaU7OTuQXY=;
        b=o6Wle8UL7Or1re2o7K4Xjq8UTLFlCA7T+xdHBRtmpe7M/mr2xn0mgYLjOWCTesdW5L
         0tkuozDMZpmQu13CeRFztTw8v5Nb0TSUbqTXnUUc2Djz4c4InpW2ocxqzLhT1fImQ8uC
         5M7HLS96kYRNviVksFHkfHsv3xvZYSufRD4EMB5jEUyi+9/9WpJtUpyKTLPYSVubl/d4
         3OtsQlqsIhk1KasRsY1hYjFG/Q8CdAKvomqWB1ncniNphdnCcxBv/0C/FnsoHGAc5rKf
         SsgvGjOO3AqH+IGluqwomt2Flfyff2M/hHTPvK6FLTCZVdHm2XsI4sj87cAph2kf5shG
         PjhA==
X-Gm-Message-State: AOJu0Yz+KQMLTLmgypkG70CRrcRCryObIljQ6stBqdIGhfDVKF92l30q
	FmASSDpsaRljsE3nFsmMO7WpubyZTssArw==
X-Google-Smtp-Source: AGHT+IH5ut0EXwmAZDo/9DvX++hIFWHA1Cpb3/Vc1PS5kLNAcDr62IMg/U92zdOSnDTc/Xtlv/jLDQ==
X-Received: by 2002:a05:600c:1f83:b0:40d:355e:ab90 with SMTP id je3-20020a05600c1f8300b0040d355eab90mr1335180wmb.67.1704470369044;
        Fri, 05 Jan 2024 07:59:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id su8-20020a17090703c800b00a29910a9366sm326024ejb.8.2024.01.05.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:59:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v2 3/4] ASoC: dt-bindings: qcom,wsa8840: Add reset-gpios for shared line
Date: Fri,  5 Jan 2024 16:59:17 +0100
Message-Id: <20240105155918.279657-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On newer Qualcomm platforms, like X1E80100-CRD, the WSA884x speakers
share SD_N GPIOs between two speakers, thus a coordinated assertion is
needed.  Linux supports handling shared GPIO lines through "reset-gpios"
property, thus allow specifying either powerdown or reset GPIOs (these
are the same).

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

If previous patches are fine, then this commit is independent and could
be taken via ASoC.
---
 .../devicetree/bindings/sound/qcom,wsa8840.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
index d717017b0fdb..22798d22d981 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa8840.yaml
@@ -28,6 +28,10 @@ properties:
     description: Powerdown/Shutdown line to use (pin SD_N)
     maxItems: 1
 
+  reset-gpios:
+    description: Powerdown/Shutdown line to use (pin SD_N)
+    maxItems: 1
+
   '#sound-dai-cells':
     const: 0
 
@@ -37,11 +41,16 @@ properties:
 required:
   - compatible
   - reg
-  - powerdown-gpios
   - '#sound-dai-cells'
   - vdd-1p8-supply
   - vdd-io-supply
 
+oneOf:
+  - required:
+      - powerdown-gpios
+  - required:
+      - reset-gpios
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


