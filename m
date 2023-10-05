Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D923A7B9EF4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjJEOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjJEON5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:13:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F50A5E8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:32:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53406799540so1267897a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696498370; x=1697103170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNwLLYEchjqrT8u4dds+22/hvzzwVkXCbPu7CyE+3Mk=;
        b=V4REbNl/YAk00RXPG9rZxg5pwJCWIBFL6E5x0WAlIICbPHdhHu2STeD/ZWKy739zw0
         vkfNqbtr7nun1bxGzAJMLOzce40sjFpy3nJoo+lkuG7rAKzsVGkVPMpG9TpBE8/7f9+F
         K73Dq2cz4suXtGGUuAJWN5jpwJDATKp3RJU3GdLFSYdK4WK6G/+4Bx7Z1N6dgi8nkxdL
         kkDfq8pWYK8KkIQ3X4j6fNKKFrp3pN09WSkbjd0ci+2H/7sA/EY16yplSwsIC4lUVSQZ
         m1LBONZfdebCqNX1+FKtzMmqkvaXg+jjzBmuh5hx0N/XYvuiqNG/9dc8calhLVhl3WM7
         ORxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696498370; x=1697103170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNwLLYEchjqrT8u4dds+22/hvzzwVkXCbPu7CyE+3Mk=;
        b=SKLkZBnZRhZhM9Z/mxQJavLSorwzHZNulTTOjsq4c8Vh1m+U4EQukqOlKYNLwF8IDq
         DSsPEiDuQq85LuaQK7FunpLKw0wswTQPzlysbuolq3W6bDWqpqcFOsfFm0AeA50VrO2u
         jgaCq4VQDqP+GfDpaiB4hhrpT6bIc/hH5HI6Zerf9lBROwL6A7OJnB+2Ugb9vgztsWTY
         npstM+pxN4M8bXxs39kIgsJIyJneM8eRQkCmZqypHUnRTZnjTbsvcL+izxDBlqOck6dG
         QYuEXYNf2ZrCmK92X1sXM7LTZPvmmXjDYxIFTAl1/+YL2lS2Zh96e5GywKAowcELpT12
         yv8g==
X-Gm-Message-State: AOJu0YymvQnjl+/0aizxoOivdL5XvlhRIH5oNTireZxUe+sfA1jKg8mm
        DlVcvsjlxaRzyR3zyPycf+DMyw==
X-Google-Smtp-Source: AGHT+IGGASEELZoOzZ6BfyTzvlBZV9PBihNgej7jZay1gXGRYHNhNO+WGFiREWZMmxKPAgpv4B/eZA==
X-Received: by 2002:a17:906:310b:b0:9ae:5765:c134 with SMTP id 11-20020a170906310b00b009ae5765c134mr4869914ejx.15.1696498370178;
        Thu, 05 Oct 2023 02:32:50 -0700 (PDT)
Received: from krzk-bin.. (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id rn4-20020a170906d92400b0099bc038eb2bsm863893ejb.58.2023.10.05.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 02:32:49 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: serial: fix regex pattern for matching serial node children
Date:   Thu,  5 Oct 2023 11:32:46 +0200
Message-Id: <20231005093247.128166-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regular expression pattern for matching serial node children should
accept only nodes starting and ending with the set of words: bluetooth,
gnss, gps or mcu.  Add missing brackets to enforce such matching.

Fixes: 0c559bc8abfb ("dt-bindings: serial: restrict possible child node names")
Reported-by: Andreas Kemnade <andreas@kemnade.info>
Closes: https://lore.kernel.org/all/20231004170021.36b32465@aktux/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/serial.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index ea277560a596..5727bd549dec 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -96,7 +96,7 @@ then:
     rts-gpios: false
 
 patternProperties:
-  "^bluetooth|gnss|gps|mcu$":
+  "^(bluetooth|gnss|gps|mcu)$":
     if:
       type: object
     then:
-- 
2.34.1

