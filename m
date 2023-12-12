Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7580F5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjLLSyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376612AbjLLSyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:54:15 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9BE4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:54:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bf69afa99so7752650e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702407259; x=1703012059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YC/WVH3u8zE3lqMQy1sW6oW6rbaFlnYLpBOstsLNgoU=;
        b=t1ON+Pat9orIqzYCsosWKdEkD3iSFnVmjSeqkERgXpJplFDOkhI/xWOYrmIFwGejW+
         n7dYEwjBHC3cHe2Uz/9z/JBbQm+/IVQJ/9wHDNg73w8s5yXK5jVOEMvfhfHGatx89SxQ
         d8j4/P970tggiPEt+301/30oqFY0IJMYR8SzHZ99D0Xn6GvL6fPovwoRlHvpxVbkYhyR
         Fp/FGV7l6nNV2VFk8iSmn4BUKHtGUHsUumIzqcTw7/yzYLMo3qyoPVEJhU4nkjgkZtan
         ZlSJblWfeNYrPzeyzRHu0AI1fh36GvJLmwgqAUL9kqLRs9pBcRNgNmPaT1ldyS04TMCV
         Ds2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702407259; x=1703012059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YC/WVH3u8zE3lqMQy1sW6oW6rbaFlnYLpBOstsLNgoU=;
        b=CT5DmxJms0K6VyzafKylUG1TRpKiUApiIU0ml8M8U/v+IfMEoe5DBSm1k024kcmiRm
         WTRxmWzMbjVLzdDStiECMbjmFPNqgiRhBLFvlEEFQ7A1jw4bJ58XeJQ/exop0VHX6+1t
         HU8d/DacJxKs2UpWxlZ8wKLx1yNzBNCL9lAngbsPNY/erP/tSxsDQZHrcAhjlXVsjysb
         hNldTBjSM9wA2zD3vlxRw4Qe9g05Ju9k0wzVBKgta06x5lK8FS3qWokI9FE9CqDGCRuJ
         QxZM76p/ElUxs0kAtABHf1SdT+H9zmkCYvI8KHI6a/IhGnch+cPiRoxi3SDU88rf2oNW
         4/ww==
X-Gm-Message-State: AOJu0YzgDFJcSze6uHfKi3Lx8aT1ZFwT3KBw/tciYg92dnD/AJ3MB2pi
        xdUOQivPT9TZLwkqCXQWaXngpQ==
X-Google-Smtp-Source: AGHT+IEnn7PgxM33KM5RP1Ci6mhXnj/c2aTqDDpc6C2q6ZUyTtIv2RFBjSuVzvHvDI603NJQeDoz6A==
X-Received: by 2002:a05:6512:2316:b0:50b:f30b:5499 with SMTP id o22-20020a056512231600b0050bf30b5499mr4430231lfu.80.1702407259047;
        Tue, 12 Dec 2023 10:54:19 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906489400b00a1de512fa24sm6617766ejq.191.2023.12.12.10.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:54:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8550: add missing two RX Soundwire ports in configuration
Date:   Tue, 12 Dec 2023 19:54:15 +0100
Message-Id: <20231212185415.228003-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8550 RX Soundwire port configuration was taken from
downstream sources ("rx_frame_params_default"), but without two ports.
Correct the DTS, even though no practical impact was observed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not adding fixes table, as I am not able to identify whether this was
actually a bug.
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 17c4f0a7638a..1f06fd33d1ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2109,18 +2109,18 @@ swr1: soundwire-controller@6ad0000 {
 			clock-names = "iface";
 			label = "RX";
 
-			qcom,din-ports = <0>;
-			qcom,dout-ports = <10>;
+			qcom,din-ports = <1>;
+			qcom,dout-ports = <11>;
 
-			qcom,ports-sinterval =		/bits/ 16 <0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff>;
-			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0x00 0xff 0xff 0xff 0xff>;
-			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
-			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
-			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff>;
-			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff 0x0f 0xff 0xff 0xff 0xff>;
-			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff 0x00 0xff 0xff 0xff 0xff>;
-			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00 0x00 0xff 0xff 0xff 0xff>;
-			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff>;
+			qcom,ports-sinterval =		/bits/ 16 <0x03 0x3f 0x1f 0x07 0x00 0x18f 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-offset1 =		/bits/ 8 <0x00 0x00 0x0b 0x01 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-offset2 =		/bits/ 8 <0x00 0x00 0x0b 0x00 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstart =		/bits/ 8 <0xff 0x03 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-hstop =		/bits/ 8 <0xff 0x06 0xff 0xff 0xff 0x08 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-word-length =	/bits/ 8 <0x01 0x07 0x04 0xff 0xff 0x0f 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0xff 0x00 0x01 0xff 0xff 0x00 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-block-group-count =	/bits/ 8 <0xff 0xff 0xff 0xff 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff>;
+			qcom,ports-lane-control =	/bits/ 8 <0x01 0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0xff 0xff 0xff>;
 
 			#address-cells = <2>;
 			#size-cells = <0>;
-- 
2.34.1

