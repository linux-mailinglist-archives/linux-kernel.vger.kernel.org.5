Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB42480AF32
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjLHV4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574827AbjLHV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:56:03 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2253D19B6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:56:00 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-332c0c32d19so3013600f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702072558; x=1702677358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FNNr06IKR2wHvvjMWyMyZa7PkCEwhAg0OAea5b5CEQ=;
        b=O/jVzTeoRcIBQO2m4uErlRzKiWx/bIWtxdIHNXG3oE1PgQD4uTRiopC5M3VyxSvYKH
         sLiK4ZmJDmiFbFYygbrE09x69V6vA3RBeKXmnSNUhqGJVTnjx9QUJmiTiczlUYImsllX
         sQH7ypnOlvNUdUdHJiIfY1Odj6+rgV1i0IRqeORlQAVGez44ldW+eZKlsr8zt7/XUydg
         13aQk7mDKQqseGNIGLFgf43BlRsbBrv4a7VusGnRpL9layJDbkqOmUrDc1zUx9R0kZd9
         WaAWuPHJxnXrihX0ihQvdZirOQlFjkDozeL+ieXDrSQ2Fdoc1pilV7uHnmTKhp9u2wIU
         k0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702072558; x=1702677358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FNNr06IKR2wHvvjMWyMyZa7PkCEwhAg0OAea5b5CEQ=;
        b=Hm66BpCRwpBIByDKajUYk+DrBCDJQf3Y2rkK8lIHBS0im9P74hbVPVscb34jvlQl9L
         v55vWXMSJb40gANS5BdU7jvetYQBDFYlwWA3kqsxlYhJoX94p5m3xnQoVGhupnF0VZnM
         N7V4EoPvpXAViulhnZWRIlbQVy+v7uwpse7XPySLJhFRiIotaMfw8rhaE53oln65CX4M
         JZa+B+STef3KdIMtXZi6JaV6jx/f4WH4EawCo/wIVEeZn3r8SNUHKW1bP2aIawyndvLv
         tx2H+cv0iTwgh83hj1PS+Q7zV37cKNaWD2aKbIwljIf1SSkYuG7eWPJrU9GOV3JauHV+
         vXZQ==
X-Gm-Message-State: AOJu0YzKJDiqaRCxa5R+BQEyHJ0CzPG5hJyW9LSVXBcU3YVBaovhbIsw
        Kb0xCrJh4hmLRIWTm2DsEoa+YA==
X-Google-Smtp-Source: AGHT+IGvRUidIL2hN6C1Wbor5BHgOmcp4VS76izN4wM3n0g1hdRblNGvOAF3034RNG3Ruc3nPJfLZg==
X-Received: by 2002:a1c:4b10:0:b0:40c:2cab:3571 with SMTP id y16-20020a1c4b10000000b0040c2cab3571mr294915wma.180.1702072558287;
        Fri, 08 Dec 2023 13:55:58 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id r20-20020a05600c459400b0040b349c91acsm6321789wmo.16.2023.12.08.13.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:55:57 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 08/10] dt-bindings: pinctrl: qcom,ipq5018-tlmm: use common TLMM bindings
Date:   Fri,  8 Dec 2023 22:55:32 +0100
Message-Id: <20231208215534.195854-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
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

Reference common Qualcomm SoC TLMM bindings to drop commonly used
properties and also bring other schemas for common definitions.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml          | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
index fad0118fd521..23300606547c 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5018-tlmm.yaml
@@ -23,13 +23,6 @@ properties:
   interrupts:
     maxItems: 1
 
-  interrupt-controller: true
-  "#interrupt-cells": true
-  gpio-controller: true
-  "#gpio-cells": true
-  gpio-ranges: true
-  wakeup-parent: true
-
   gpio-reserved-ranges:
     minItems: 1
     maxItems: 24
@@ -95,7 +88,10 @@ required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

