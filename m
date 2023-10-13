Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8C7C8BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjJMQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjJMQkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:40:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC477101;
        Fri, 13 Oct 2023 09:40:31 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso1703263a12.2;
        Fri, 13 Oct 2023 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697215229; x=1697820029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=igsu/mDD6XdnLZ3nDzMRhMBFqtqYaFu/W30OUakU5+8=;
        b=iFhsodYIW4Mf3t7suO1hhRkIwKjeYJS6aJancBxKU9ax5yQY2KM2ptnzHe1Y4p/7YR
         Xz3L2713BTdmZSikW3cUmXfo526Ru26qukZcO2cEhNo2fBQLRR3kfCNEZdv+lto2glsJ
         6d8YyjjeLYR4jmbiUoK0FRcy/TU3Z2HEL0+4eP6hzyi1tzbHn0HTh0VrVAKWkgmj7LeX
         TC9hoMsELW3vOeFtbfExgR89D9mgtBAAgjE3VLmKk3HsXaNaTI3d/2RtJTWKzU2bl35s
         1EgR4nw9Z1nf0kMjSZPguzrgZrgaCTjMVus8frcKFfKtFHml6WyHH5nsqsvkeF9gnen+
         VYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697215229; x=1697820029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=igsu/mDD6XdnLZ3nDzMRhMBFqtqYaFu/W30OUakU5+8=;
        b=rlwg0uqnXsM76M0MDsa7+ajMD7upqoXLvIsAu2ReSOUSv7PG6Iq/nYHmJSJ/Q4pO0b
         Mros0uKBTCNsbxu1jj27+qhZVJL9++V22uUml/REC1DEk4exAWgTC3cm9ecPQZQuZigK
         cvuFHRQR7+n1oaPkwcjuTg/l3bRNTNEwQW6+wKvjYsuIyHfGFHQPcJfnLNC35IAcv4dw
         y0HaGZtklWJtnjK9ojV2H4gfl7/t16h5ssqGuGZd/0QNI6YovrEfUDME4qG82lEmjxSz
         +A0R8hSEVUydqQAeJDhP742r6e0hEFzMo1UPq1eR8gRdpDEXujfhVDCa1zK4yesFhdkQ
         TuKg==
X-Gm-Message-State: AOJu0Yz2l5H8ZZxlAODahvhLZDzSqWYECr+wgAGE0Q8UxDmoPs+XNkxE
        Qq0UjFoYUXGDCmhfw7pIM7gmgeBBHVMKLw==
X-Google-Smtp-Source: AGHT+IG46/efdGsqBVwi2BN7FMlbH9aMseKY3y61y3LBMb5mfle8djHJNLa7hIkxkcixGTbAQ/sBwg==
X-Received: by 2002:a17:907:774d:b0:9a2:ecd:d963 with SMTP id kx13-20020a170907774d00b009a20ecdd963mr24524148ejc.44.1697215228783;
        Fri, 13 Oct 2023 09:40:28 -0700 (PDT)
Received: from fedora.. ([213.149.38.59])
        by smtp.googlemail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm12531902ejb.58.2023.10.13.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 09:40:28 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: clocks: qcom,gcc-ipq8074: allow QMP PCI PHY PIPE clocks
Date:   Fri, 13 Oct 2023 18:39:33 +0200
Message-ID: <20231013164025.3541606-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PCI PHY PIPE clocks are inputs for the GCC clock controller.
In order to describe this in DTS, allow passing them as the inputs to GCC.

This has a benefit that it avoids doing a global matching by name.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
* Change the commit message to describe the relationship between PIPE
clocks and GCC controller

 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index 52e7831a8d6d..2d44ddc45aab 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -27,11 +27,15 @@ properties:
     items:
       - description: board XO clock
       - description: sleep clock
+      - description: Gen3 QMP PCIe PHY PIPE clock
+      - description: Gen2 QMP PCIe PHY PIPE clock
 
   clock-names:
     items:
       - const: xo
       - const: sleep_clk
+      - const: pcie0_pipe
+      - const: pcie1_pipe
 
 required:
   - compatible
-- 
2.41.0

