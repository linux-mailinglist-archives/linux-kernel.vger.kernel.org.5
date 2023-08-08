Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65417740AF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjHHRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjHHRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:07:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575CE7D;
        Tue,  8 Aug 2023 09:02:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3176a439606so4478539f8f.3;
        Tue, 08 Aug 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510549; x=1692115349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N77XCzPazpBok51u5jWouG3TfNUMbwqAhma/4DQhYGI=;
        b=fIuQVJV7UoBTVdWJIV18mnPWXHYesbhQyN7e1gPr2Z98Zvf+xtUuMZ02EOkHMvwUVS
         6samL0MKW3KjC9H5VBIyD8L3678pH6Pev7c2xQOs0MsNDPf40E1W2rcvb+oYXcCTZHwS
         cYdVL4EmpXZ/7NVHFSx76iNrm9VGbTM4TEb6oKiVsokPlGZi/3bE9/1m9aI/tdkulu0S
         OwawWwWDmyX8sty9mmauYwrSHMgdS5d25gdFB7+NovtwPxo/GaGCujsk9GKPDAT12Z9N
         jZcft4Ab8C//BQJGzhxg3RWNOXJgoXzQu7kalR3KUcuZ7ZGWpQ8GeYJDZO0q3ze7vP3H
         aC/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510549; x=1692115349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N77XCzPazpBok51u5jWouG3TfNUMbwqAhma/4DQhYGI=;
        b=btghqHelNexVgaiBE/LvEspyGU0FxMoj4DtZNxw06tgyiFAwUfwWa30+KYf6UMA0XK
         3TZp0iPCnWnJblRD8uas3LtA2rxxdGKxLJPTw07HfpNL2HWXgfwu6Sjr9kceSCqGLe0G
         YEPHaGl0g9PetRbIeOOQMqHlIoH2VOxOAxYf77NOoDPUl4SLOrQOLcsX95FfRePMu9L7
         ocvBEJhTymWLm2RX5jHt+SpFO0mX2szPI1md5I3h/cg2HNjXZDbcREwrN/2rV9pUGoVw
         QBpB6rsUO926Bsql5RGZRfYWVE/YK+8fmqyRk8TTe6Z4l0nfG5+z2QoxZp4bPA8jktKk
         Y83g==
X-Gm-Message-State: AOJu0YwbcPJLWvJbsQd+pe+5fWtMnVcWXpjbk45GxSN+fPMR86uy7oie
        b9WIhDpogtfK6Vz1YSGAo/iglRHeTisgsDCe
X-Google-Smtp-Source: AGHT+IHddoIp15tEHXIqOstY3g61YGw6la8f3OjABPjj0xzPIgAjsx0c+Om7KRMWSdIXjcQ3SJUvPw==
X-Received: by 2002:a05:6512:31d1:b0:4fe:49d:6ae2 with SMTP id j17-20020a05651231d100b004fe049d6ae2mr9290985lfe.0.1691492568213;
        Tue, 08 Aug 2023 04:02:48 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b004fbad682ffesm1826587lfo.88.2023.08.08.04.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 04:02:47 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Tue,  8 Aug 2023 13:04:29 +0200
Message-Id: <20230808110432.240773-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.40.1
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

Microchip does have many similar chips, add those to the compatible
string as the driver support is extended.

The new supported chips are:
  - microchip,mcp3910
  - microchip,mcp3912
  - microchip,mcp3913
  - microchip,mcp3914
  - microchip,mcp3918
  - microchip,mcp3919

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    v2:
        - No changes
    v3:
        - No changes
    v4:
        - No changes

 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index f7b3fde4115a..06951ec5f5da 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -18,7 +18,13 @@ description: |
 properties:
   compatible:
     enum:
+      - microchip,mcp3910
       - microchip,mcp3911
+      - microchip,mcp3912
+      - microchip,mcp3913
+      - microchip,mcp3914
+      - microchip,mcp3918
+      - microchip,mcp3919
 
   reg:
     maxItems: 1
-- 
2.40.1

