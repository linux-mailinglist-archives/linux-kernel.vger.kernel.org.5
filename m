Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FC80C9CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjLKMbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbjLKMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:31:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CFCA9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:12 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c2308faedso46230985e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702297871; x=1702902671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN91HNt5gkaIzgOq9vwezVCDXB7gy5tWKyJ+X5HCihA=;
        b=vxupRBh7oWaVum5aI/uqEZr806fwfYVCJbKUZO/I3zPkWBWDAmzKDb4uTtVXlNpI7X
         J1AMwupmvG8qoxCn6xN9FX41zbmSbeR8b1n3V1T6+Nr6Zpiu0quObzAi3YrEFH2aDB81
         gc1EYa0zcGArRzZgm+EaL7f3ZKPo4QOWYMHHXv1w3rWLGzUEk6Gix+0UtEk/60U7m8oW
         3iBK/UUBhrDbj6tHFlcWoNczROKI/EgVdTgrGP79j+sPc1x5Kc72f7IBN1ATrcxScmJU
         8FNGSFGkRsDOlfOKkXYAe4/9xjvLf6iBfnR4RNigN4xnUU2lyhLnpR1fw72YqTjjoxrs
         PIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297871; x=1702902671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN91HNt5gkaIzgOq9vwezVCDXB7gy5tWKyJ+X5HCihA=;
        b=L2coDEWmwC67c267YmJ2r5986qBP8BRyo6OJuKQICGdPLs/WyYHr2nVa06eUeybl1Q
         /Crv259emWu7qpeeb7iDFpNfAFOkHlhCx1WqM8yN6ljcey4l5WsjW8TDXE8EeUzT8eOt
         IoTRIdlXYfEfESmiNxC3hgT+g8UaphCNA1m4vUvphchYX8DKTw+Jpjgjx5kC/riuZKl7
         oQqWBKVrJ9zSKBqi71koaUftXO1xVwQFsug7sO3OtpK47T8khRrZdBp24MKBSbSKVfwe
         7epxrAWHyIRI5k6aXkTBzp8C4976B8EuFFxZUE3jDECEQidP8OmRgduu4Fn6cDgmub5S
         Icmw==
X-Gm-Message-State: AOJu0YxhPaQDsyY5EqJVUXm/ujuBf4OYYGD6BnZvUVVTkxlQhW1sQ0Hj
        Zj4oBQevxZN+A5lAGP3260O0CR5DjlB81iyUrgk=
X-Google-Smtp-Source: AGHT+IGe0TsF6kU3cIp8ndlWh7qt+klx3I1j7J1zNAl229HSG1N5Cw5CH8QU9alImW7ATLvT821E1g==
X-Received: by 2002:a7b:c389:0:b0:40c:3820:f004 with SMTP id s9-20020a7bc389000000b0040c3820f004mr2353363wmj.132.1702297870759;
        Mon, 11 Dec 2023 04:31:10 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s5-20020a05600c384500b0040b632f31d2sm12932313wmr.5.2023.12.11.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:31:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ASoC: dt-bindings: qcom,lpass-rx-macro: Add X1E80100 LPASS TX
Date:   Mon, 11 Dec 2023 13:31:02 +0100
Message-Id: <20231211123104.72963-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
References: <20231211123104.72963-1-krzysztof.kozlowski@linaro.org>
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

Add bindings for Qualcomm X1E80100 SoC Low Power Audio SubSystem (LPASS)
TX macro codec, which looks like compatible with earlier SM8550.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index cee79ac42a33..3e2ae16c6aba 100644
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@ -20,7 +20,9 @@ properties:
           - qcom,sm8550-lpass-tx-macro
           - qcom,sc8280xp-lpass-tx-macro
       - items:
-          - const: qcom,sm8650-lpass-tx-macro
+          - enum:
+              - qcom,sm8650-lpass-tx-macro
+              - qcom,x1e80100-lpass-tx-macro
           - const: qcom,sm8550-lpass-tx-macro
 
   reg:
-- 
2.34.1

