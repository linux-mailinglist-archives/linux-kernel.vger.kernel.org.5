Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B308775A88C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjGTICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjGTIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:01:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B448A2704
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:01:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9939fbb7191so121480666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689840105; x=1692432105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkeQ6vEtEXAHv/4ZNC5eGmeOrq/7dYZCei9hOpclthg=;
        b=DNAw0HLS/YBpCRcq3/48i97QJUtJj1hD0OzyWw/n2C0OSQ0joXt21r6EE8IBWfvW1D
         aN2UmnenmOfQvvAOzXo2ukIxvsWiS5bDkmSfXpI9Hi7tIY0HsAcH+K0xy84TaT/Wta8b
         7NZtXCXyqBXcD2l/G6VgKUzGNUB8yjKxF4eYpV7SeGjIalcPqFQibrSlx3Y8GjzjWOoJ
         9k3WVcCGT61ctbvSeq1sCmwwOhNNJqvqk1rpsIjv34Zug/baiVruJ0MiAO+2vZZSs1IU
         j5Fdzw69+m6lzDAoxfOqho/vC5MX0EE/Rlh+QKKAmns57Zu0FAskfGb1G15FJ2UI6/7N
         4a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689840105; x=1692432105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkeQ6vEtEXAHv/4ZNC5eGmeOrq/7dYZCei9hOpclthg=;
        b=Di/YtmulHTKbc4c/X8mIarJBctNMNm9/g/edOIWduKKWUIc8gcefVgY0xlWCFzKptc
         BhwTRD8zoONnl2j7kZ79kksr4uBNRJGy+5qIdmw3cphaZjrX4l5EbbvVLaKPVoQZ5jhY
         rYEDRdqQKKN3ZjvjPCgY7l19vRqyctEM5GZjcRX1jAyyOPyP7A9xzXVszweiObHMOqns
         Nr8saYdCIY3SyAhbku6i4Uiz05HXL9nI1l4IxL0j65hQ2cg3ox2hHwCaz7aJe2K8BBrL
         zSFr1K5QOYcmG42Lv+/aFstHTgk6htWeOPzF3zKK4UIrprOT7h6KFkxbGlKb/HwuhQbS
         Qeeg==
X-Gm-Message-State: ABy/qLZpiJX0RzQ9M8I77RAInsqVo7H+b5VosRRBSH+UwLpwe2Otlhwy
        P8Kh7hhZpXU5LLhYeizEDGzfTw==
X-Google-Smtp-Source: APBJJlFKARz6zRa1duGfEzjGF0X6RsD/6BHiRqW+ri9DIlLxu7cvHnqNcKiQA/bmM/7RokzJvr4ngA==
X-Received: by 2002:a17:906:6486:b0:997:e836:6bb with SMTP id e6-20020a170906648600b00997e83606bbmr5143886ejm.14.1689840105054;
        Thu, 20 Jul 2023 01:01:45 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063ac500b009882e53a42csm309015ejd.81.2023.07.20.01.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 01:01:44 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: extcon: siliconmitus,sm5502-muic: document connector
Date:   Thu, 20 Jul 2023 10:01:41 +0200
Message-Id: <20230720080141.56329-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230720080141.56329-1-krzysztof.kozlowski@linaro.org>
References: <20230720080141.56329-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document recently added connector for SM5502 MUIC:

  qcom/msm8916-samsung-serranove.dtb: extcon@14: 'connector' does not match any of the regexes: 'pinctrl-[0-9]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
index 7a224b2f0977..7ef2d9bef72d 100644
--- a/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
+++ b/Documentation/devicetree/bindings/extcon/siliconmitus,sm5502-muic.yaml
@@ -27,6 +27,10 @@ properties:
     description: I2C slave address of the device. Usually 0x25 for SM5502
       and SM5703, 0x14 for SM5504.
 
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
   interrupts:
     maxItems: 1
 
-- 
2.34.1

