Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2FD77B846
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjHNMIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjHNMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:08:16 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C63130;
        Mon, 14 Aug 2023 05:08:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bc512526cso560576766b.1;
        Mon, 14 Aug 2023 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692014894; x=1692619694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z369mYIQzHYsN6X5H/LOPSxwrlAYkxTZaw2kQwdW4h8=;
        b=CBF/GZo2sBi4/aQeGCyJRnoZ1XByk986ULQfP+81myX94L+k7UB0RKiRKxRRGiMSKB
         N5X5eWEuBg6Q/qI83G6jRwPv4UHLVBY/RNxcbZB4UlkRJ6ib1Cmw25ATU/pCn57VYRKc
         V5qvO6yTD8/iDJ3rCbYz+HUs7WCqShPppZFmyGiUugZTYYaA40dt/Q9eoDm6Tah5EbP8
         IHxBCpUvdJtAvycUMgPat3kHQrA4VlL+F5xC/8/pbIOVdso6N8n5rBfyjx5ZqnrbNvAr
         BQeZ/qA+knkTGyGEYYiwEerpVeWnhG/1tX8mVmb73KpShGISQLmr/Y3RUfVNOQleiBk6
         GxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014894; x=1692619694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z369mYIQzHYsN6X5H/LOPSxwrlAYkxTZaw2kQwdW4h8=;
        b=ZqJ3ubJUCHI5nFHZWd6Dol/ppSCxwqwniNO0xyX1oURvikYV401RxuVVm0ifyqF9hT
         iSCzKCqpOLAdm145Q1/Zf7of78u6oSg+69rJofnzFbvYt5pAngg3AT4wSvh52ynXPjMq
         yWPiyIbH5MHtH8hdvjQI52lPVCvFMbrr6Hemvs/N13n0/o+0UJtkqH+T3zl3IP2lRClA
         vIZalDEJGTfa9SyTJO23as2XDjVkV9uW/SlxjcdHTlaf/BDCNc9/xboWF7MtMh3Bl0Gv
         iUhzKoVBXqDb699LBuatVKb4qU8JyrNeHX4nCE8rdNV4lUoerpQQG6Ar0EwMmG8MkZAC
         plkA==
X-Gm-Message-State: AOJu0Yy02UaSKpvNSq+xLTwdPYAZHcajsapB00hZs9m6qhpESqRt6u1U
        +yBtSaPXtZYef3G4xQ43q5Q=
X-Google-Smtp-Source: AGHT+IF3PRo4K3yMWC0O34Ju0yjUjUw/5bYzCSWqvUTeR6TYiFYg18ZL5L5dxSP2/XkJ5yRBVPoW9A==
X-Received: by 2002:a17:906:21b:b0:99c:2535:372d with SMTP id 27-20020a170906021b00b0099c2535372dmr7224216ejd.33.1692014893483;
        Mon, 14 Aug 2023 05:08:13 -0700 (PDT)
Received: from goliat.isc.local (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b009930042510csm5600433ejf.222.2023.08.14.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 05:08:12 -0700 (PDT)
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
Subject: [PATCH v5 1/6] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Mon, 14 Aug 2023 14:10:05 +0200
Message-ID: <20230814121010.184842-1-marcus.folkesson@gmail.com>
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
    v5:
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
2.41.0

