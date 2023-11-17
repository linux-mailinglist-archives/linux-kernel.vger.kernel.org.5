Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8087EF878
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346251AbjKQUR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346188AbjKQURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:17:49 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A105D7A;
        Fri, 17 Nov 2023 12:17:46 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9db6cf8309cso324727266b.0;
        Fri, 17 Nov 2023 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700252264; x=1700857064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FT55umVdQ3ABR+ChZLMcI5+8wttiT8rkJ6vkSExahQ=;
        b=Y1XtcDPKNquPi+N0nX5PUoLA8zYECBuN9MpazQ8SzetHdog/p+4aZaYIV0gWgUMqjt
         sG+/+5tDMJ+h0sw8DzhbjY/WRdBvGhoTe+v8rW+orZbD2DpqkByejFflWfYukWC0ltOl
         f4LNYXAhQoIvwdzuRYvmN4qc9FjotKA6rO+taqqEKFq6wlZTtc/TQ0GTyr+nvHbLXyEy
         4Spv/EVHdUNOJJaspqaDIRwzdNh1+YvLwwgxd8P9J0zf6y1YKXzQ+1YHaK/Ya9N2Z3D6
         DHiYEymUkpyu73qymwkk+AXE1Zi3yaFQw/pCPg5Phm+QJMG3R3HaPH6HELNZ+SMqGqCQ
         Fe8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252264; x=1700857064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FT55umVdQ3ABR+ChZLMcI5+8wttiT8rkJ6vkSExahQ=;
        b=EdighO1EAKpvKXAB1qYsdxxNpFNOjSx5m2ez+/dg5zLUPD60autVjE2ynucrfyjto1
         SoJCuK30T0cx85kSmlq2gsd1kUuwZp4Am4dV36BXeGAC7zsUf0DZrxnSJpOWm9AKPe4E
         DH5OWJw0KjLDFuBMo1/Fy4DIZYS4hNHxH2AFmGcKTE9SlyjSEja5nWyN2LGNOQlgqIgd
         DAuTRECkL4gKCr8SAZH/HAmbef/0uND9SFW2t/UcUVp+MKnAEp+674UGi8+OywMKLFZD
         aBLephkGV6NK3jgKInXVYP0lW470i2+8RFiVEaoUlP7IKRf/n77PfD3gVDIpMJalLCzi
         3qnQ==
X-Gm-Message-State: AOJu0YwvFwyG/22l+VQYs8UwLyntKoa1441oeQhqBj9R7LnrM8ycPZ5i
        ZULMFs4JGzCowEIslPWIiF8=
X-Google-Smtp-Source: AGHT+IFMq1o0Se3JMQMNhVwxLmvjAdp1t8mKGcqp6ikQODtj4GRKfY2136N2S3IHAcnlzeOIfjkJDA==
X-Received: by 2002:a17:906:260f:b0:9be:2963:5669 with SMTP id h15-20020a170906260f00b009be29635669mr137097ejc.68.1700252264337;
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
Received: from david-ryuzu.fritz.box ([188.195.169.6])
        by smtp.googlemail.com with ESMTPSA id e7-20020a1709062c0700b0099d804da2e9sm1130630ejh.225.2023.11.17.12.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:17:44 -0800 (PST)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, David Wronek <davidwronek@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/8] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
Date:   Fri, 17 Nov 2023 21:08:36 +0100
Message-ID: <20231117201720.298422-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231117201720.298422-1-davidwronek@gmail.com>
References: <20231117201720.298422-1-davidwronek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the Xiaomi Redmi Note 9S (curtana) smartphone, which is based
on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..9a4e71279bc3 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -994,6 +994,7 @@ properties:
 
       - items:
           - enum:
+              - xiaomi,curtana
               - xiaomi,joyeuse
           - const: qcom,sm7125
 
-- 
2.42.1

