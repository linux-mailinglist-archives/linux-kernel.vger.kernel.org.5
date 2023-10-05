Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A558F7BA077
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbjJEOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235402AbjJEOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:35:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AABBA5EC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:32:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b6559cbd74so142608366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696498371; x=1697103171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdLOn08HJMrX2Ou2DkH0AnNqsbvAINSqQuseGJAmCt0=;
        b=hHpq1jnNTJvqDyADj+w00PSih1ks2bzAQ2JLnQumUe5tM8tnwyzVR2+Cia5H8agxTD
         MnBzxiSrUf+q6DcwSSFBf7fVUIjAI7MQN9MB5ggTzn8le6ze6kW6HmCZgRbxxh2ImOgv
         IBV23glvYDtO+a7qul8BnaSuNgMLGK+fNQAacNBN6mcVdZLHQtZhveKpkrnM2XPY7tCP
         CKxwWsE5vwzj2CooSXTDRoTAGMbpeNKELEucG0XeK2QPjsNwu9uvgQBW6GL1nK2TyWfw
         2ZMxyPc4cej04yGjMeRy/TZSo1cfgn3KOIvOqfx4d921R85yGdVAV0e20AEo8aXncBIK
         R4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498371; x=1697103171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdLOn08HJMrX2Ou2DkH0AnNqsbvAINSqQuseGJAmCt0=;
        b=CdrVfgqdFVDPzftkeAKdkcIZqff9RgXgED+Bjt4EGuGot5y0OzlaUP6vBQntfAdRbk
         bT1IISrtk7Hs919/I+vaXFB+ZTFzw+ESXVISQpFQZIE/izbrc4FaSzxKJbZU4LRQ1PQJ
         h6HzjtBpgx2Bp7OJh5czMeUknqQzMJO9A9Ug+9HIURAqS/IGPT6lSwyUOW7FnL+41OzA
         P1mK5AcHjT+WDMbY4kU6qReOvE3QuVwn+4ZwavZP7zRo1e6GRr3ZgaCltyB5DKPy6URq
         ccLivjJiyE1E8WOsMRUv13uFiphqTQ52po8ZAvt7CqTOPDhGDxEzQ4qF8oKVRa0i/ZH6
         +q7w==
X-Gm-Message-State: AOJu0Ywvl19Ah7jg4qWD35C+X7oQBgJ+OXp0jxB70Y4k4fjvvsu5XXI+
        sRssrTi0F17chcTiNG9CCMG12g==
X-Google-Smtp-Source: AGHT+IEGiwd6GZAfK3FbFUd2UMYw/vGyBuvevBUIP7Ff7gNZtLv+jk3/3mwwnVIKtSHWpnmRH8BORw==
X-Received: by 2002:a17:906:74cc:b0:9a1:d0bb:d215 with SMTP id z12-20020a17090674cc00b009a1d0bbd215mr4501972ejl.5.1696498371530;
        Thu, 05 Oct 2023 02:32:51 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm863893ejb.58.2023.10.05.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:32:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] dt-bindings: serial: allow naming of Bluetooth with GPS children
Date:   Thu,  5 Oct 2023 11:32:47 +0200
Message-Id: <20231005093247.128166-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
References: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices attached over UART combine Bluetooth and GNSS/GPS receiver,
so allow "bluetooth-gnss" naming of children nodes.

Link: https://lore.kernel.org/all/20231004070309.2408745-1-andreas@kemnade.info/
Suggested-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 5727bd549dec..468af429c3e6 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  "^(bluetooth|gnss|gps|mcu)$":
+  "^(bluetooth|bluetooth-gnss|gnss|gps|mcu)$":
     if:
       type: object
     then:
-- 
2.34.1

