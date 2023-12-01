Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A37800BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378990AbjLANXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378972AbjLANXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:23:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F99F10D0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 05:23:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50bc57d81f4so3049662e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 05:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701436989; x=1702041789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Igs/1xxmdZDx69Ib2yYmnUGtoYW4fPjWxGWyWHxaXA0=;
        b=tF4YK+19sNHdrbQlvMNiLnJJ96TCijF3XhC0LfbAhyePm4mlLQvnUdsix4Dp5cqZ30
         lQFjBznd/gUyWVawbfDJDr8VZOkROyIgJ88G4zf6JdA6d+ntSP7bAk9Yj9CJ+TrKzlVx
         CI6x0I4JInIbG/iylKCnI1jhfL1lQZn3JzhbBHZH32KsZVYsX9SfEJIjlzBmrO1ogPlw
         DmBtcSTpXgEZQ4vcSqnCXsQKXW83EK218DpnYU26c7OrmQwkiGG+dXs0jUdOzA9Jx2AW
         qHwHAWCXcVGtd3QamKrervsl1c2+cjqAgOpvxcQ5Zp4epPSmjaZfIUFoGvuogvKUSJkI
         ubHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436989; x=1702041789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Igs/1xxmdZDx69Ib2yYmnUGtoYW4fPjWxGWyWHxaXA0=;
        b=keahusy/sQ16m4ewNFfO6cnIVNOZwhPzlJ9INwgtHrJ/soUS2UssjPw6wXToymBjhQ
         gHQfRBcZM/ejoqgjfVGG7F8VnTMHBf0qVKTUD+P9ncDaRw4KZI8EvMm1VtY1yvKOnIkn
         02mQcQfIFXKZVQBYguTv8kds4FHLDgsLMYJXQk3xBCuwjOMCuGd+DwmEo7/cwsgTpieh
         6c3L1tptmIjiOj9pZeAHmddzgnXMuoPY2W0od2jayN7vnkNr9zZ+eKC45DYcqUl0Z6L1
         yj2/Qdgpubbse4yrRNkehwOCEMj6au5GQ7UVEDxwsTYugdIuBYfEqg1u7HXrKZBKAS5u
         RNNg==
X-Gm-Message-State: AOJu0YwVZWU+W1DKX82WgKGxZD6Gn5IrciWlakoSOV6kjWeSPQpCJs0u
        6lG0YvpdcQK1GrN6sSC2buwQwg==
X-Google-Smtp-Source: AGHT+IGC7piV6frnlDTmJAucTJLcGnBXEN4l2bs6VOfOWHWe7GrruFEgN+yKEvb3SCIRrhNJkHYZog==
X-Received: by 2002:a05:6512:2027:b0:50b:c700:f976 with SMTP id s7-20020a056512202700b0050bc700f976mr529088lfs.0.1701436989392;
        Fri, 01 Dec 2023 05:23:09 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id r16-20020a05600c459000b00406408dc788sm9067720wmo.44.2023.12.01.05.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:23:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: marvell: move MMP boards to common marvell directory
Date:   Fri,  1 Dec 2023 14:23:06 +0100
Message-Id: <20231201132306.60753-1-krzysztof.kozlowski@linaro.org>
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

Marvell board bindings are spread over arm/marvell/ and arm/mrvl/
directories.  Move MMP board bindings from the latter to the former, to
keep all of them together.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/{mrvl/mrvl.yaml => marvell/marvell,mmp.yaml} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/arm/{mrvl/mrvl.yaml => marvell/marvell,mmp.yaml} (89%)

diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,mmp.yaml
similarity index 89%
rename from Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
rename to Documentation/devicetree/bindings/arm/marvell/marvell,mmp.yaml
index 4c43eaf3632e..92a667e27ec8 100644
--- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,mmp.yaml
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/mrvl/mrvl.yaml#
+$id: http://devicetree.org/schemas/arm/marvell/marvell,mmp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell Platforms
+title: Marvell MMP Platforms
 
 maintainers:
   - Lubomir Rintel <lkundrak@v3.sk>
-- 
2.34.1

