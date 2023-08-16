Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0769177E62B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbjHPQPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344644AbjHPQPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:15:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045152D41;
        Wed, 16 Aug 2023 09:15:00 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5233deb7cb9so8391524a12.3;
        Wed, 16 Aug 2023 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692202498; x=1692807298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93TiF+9sn07ORbH6WQDY7fYtgvsRXMMvS+8C6cxP9kA=;
        b=Nr30s0gMPBSxq8W5w+EZrKS03TIoU7UjUvzKpewzNgCGF7KQgepxMFVsXCwkARxSEK
         hKf7VzLx9LCksfGRunoE452zkUgrTaKYRvz4ZJt22qSzyxBFweT9sPy0B+p0y5lsx2Sv
         g13qIxWE4CljyX9cJXdJxCwQyd2FwZwBsr8NBv06M8K18bW6w9oM8tTzqerUzdjyBwro
         cc5mj3psYFiCNpH/9sz63D1erGL12M2i8NRbdcd2mrdwwysbbXjcr/+6z/bl6+fDsthU
         6Sl/NJRYg2hqpp2TsBHE2Ulaahd8SRk0IUVX3KPfqtbE9DYw5uiE9N4LFF8AQpSXl7BZ
         /PKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202498; x=1692807298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93TiF+9sn07ORbH6WQDY7fYtgvsRXMMvS+8C6cxP9kA=;
        b=SPnFveYvuXvWGAf07RScAr1Lfw5bSLbY2WbobU5fykRvQw430stFLrdppXuStnpIVs
         VKTOUxE8gA+mv2ZBWNdSTbFTjEOmUWUZCjyDWUCFD5B78DnHJUB0sShUndl31N+briJN
         /RDxdZBQPpfv70uE3sTadyDH/qtCplxWwoLPlU5lu1cU0zUr67FFiMuWwSs2SQQcAMsc
         795XPKW+aSDOl4mjFflLQDd6KvkjtalD6W5SkIcQu+qRwgR556EMIkPCcJdMXf7YnMPL
         ychcWNFTUlmSPrTcePa/JH6PIASm5pLPENz33d1EMgmE8Z/XEvGh+ScqoRDm11yTH1UC
         kmxw==
X-Gm-Message-State: AOJu0YwS4fq8umrw+4mplNJ9XNmvEqk2i6jcnuz0/R4bDDDUvoX8uQrr
        5o3aO/ySe1bUVt68+apnaq4=
X-Google-Smtp-Source: AGHT+IHMoWEIRQSK1r8uMbRYQ6sz8eFxgajzrkGiMrfauxoqRqWW7KP+u0+Cvl3dtqohhK5rRmtQfQ==
X-Received: by 2002:aa7:da11:0:b0:523:3e7e:451b with SMTP id r17-20020aa7da11000000b005233e7e451bmr1744282eds.37.1692202498254;
        Wed, 16 Aug 2023 09:14:58 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id bo6-20020a0564020b2600b0052574ef0da1sm2536733edb.28.2023.08.16.09.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:14:57 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: qcom-wdt: document IPQ5018
Date:   Wed, 16 Aug 2023 18:13:59 +0200
Message-ID: <20230816161455.3310629-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the IPQ5018 watchdog compatible.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index 6d0fe6abd06a..5046dfa55f13 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - qcom,kpss-wdt-ipq4019
+              - qcom,apss-wdt-ipq5018
               - qcom,apss-wdt-ipq5332
               - qcom,apss-wdt-ipq9574
               - qcom,apss-wdt-msm8994
-- 
2.41.0

