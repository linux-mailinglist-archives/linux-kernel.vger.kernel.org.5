Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20571761878
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjGYMhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjGYMhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:37:18 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74519AA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:37:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98e39784a85so1386406566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690288635; x=1690893435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhZOTY2v8nNqCcShLqLA7mLbnG45oifLvhvNr+/6z/o=;
        b=WyKTRrgFJwUyfdp/c764JU7lMiUG7ykQmHfDjHirhMDJqFOBbsxFq6z3SCEIgb19ss
         YpFaUBqyiLzV4eTpcmNQEpKLQQ5rJUhGxTh/V1FSezErKgwzefb6XHVSy4pGGxA0e12E
         ZOMmDSHBVzfF7nYb2VeGsTx9UNebdwtn8ivJ7jqVcretOqzTeu8G0LuvvPd6W5H6wnAM
         +QMk+2pTqLcQhlO0oLdPinA53C7Kjo0fdeW0V9FmeRhFo9LsmH5EBpEC8FCAWXdoiirN
         a3iw/EI8jQx1h8qvMy91oVXEGeQmok4/yYivpEPKODZrLb4wq0UNJxz9ZloJhfoyzgup
         SuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690288635; x=1690893435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhZOTY2v8nNqCcShLqLA7mLbnG45oifLvhvNr+/6z/o=;
        b=GJQDC8PFhnv8INyEucpEv5JAFopZmmSCG99riRKVJALkiVTSqy8TMMXIQbnjONxsp+
         sYd5f9p9gU2fiSSOOubVCet+heDwpe6wH2aLktQOBtBJjHAzOeGBcjn61OFMgX/B/8Vz
         6pDmttf+XugheAaRnFsd88gLBPFHmpTzJLk2nmHhgl09I1WFb4zkiTumkYTXRhdTIASj
         DDrcSLj7FmQ4v0RGUfhEHmfhbSIZWE+gqZNtk2TTUvDJwDXeftcCDd1aYoBZZ78brOqO
         HfnxJYGHXPIJq5yRZnEml5tlDDP7odXF/tqTTgm14oot+aBBgN+JXHTSI2bmqvwsvgIK
         nzng==
X-Gm-Message-State: ABy/qLaOU0G04F1dj6WsIeMytL+seDlFYoBd026t/YryEySoTIDSTNGG
        UycqchwkT5uPRWayxl6eEJKAUA==
X-Google-Smtp-Source: APBJJlHY+74HHjey/C1hM74+8GGWFdnbCBbGLwWt0v2dOdMJV8ZhK+BaA46nQ+0c+9MOCfr3RN29Eg==
X-Received: by 2002:a17:907:2cc1:b0:993:f611:7c97 with SMTP id hg1-20020a1709072cc100b00993f6117c97mr2259221ejc.33.1690288634744;
        Tue, 25 Jul 2023 05:37:14 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id op10-20020a170906bcea00b00989027eb30asm8140654ejb.158.2023.07.25.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:37:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: qca,ar803x: add missing unevaluatedProperties for each regulator
Date:   Tue, 25 Jul 2023 14:37:11 +0200
Message-Id: <20230725123711.149230-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each regulator node, which references common regulator.yaml schema,
should disallow additional or unevaluated properties.  Otherwise
mistakes in properties will go unnoticed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/qca,ar803x.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
index 161d28919316..3acd09f0da86 100644
--- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
@@ -75,6 +75,7 @@ properties:
     description:
       Initial data for the VDDIO regulator. Set this to 1.5V or 1.8V.
     $ref: /schemas/regulator/regulator.yaml
+    unevaluatedProperties: false
 
   vddh-regulator:
     type: object
@@ -82,6 +83,7 @@ properties:
       Dummy subnode to model the external connection of the PHY VDDH
       regulator to VDDIO.
     $ref: /schemas/regulator/regulator.yaml
+    unevaluatedProperties: false
 
 unevaluatedProperties: false
 
-- 
2.34.1

