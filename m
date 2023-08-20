Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87F7781D5C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjHTK1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjHTK1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:27:11 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA8E1BB;
        Sun, 20 Aug 2023 03:23:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe11652b64so3455105e87.0;
        Sun, 20 Aug 2023 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527034; x=1693131834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJH7/+si9b/KfqTSKBxRUP5/ijpoIPhIhDqlelDJelY=;
        b=sffEoRgVY9C46xe3jeqfnb/NdSnP4epsfcljuRKQKlLMo/GN8xEzC6UJTC5qXVthLk
         ZFbatSZ0AGBA3Bjxgl4JI27Juepb4hMjDQryptjEpue65DqcQK9iNBHBnzpyX5ijwFfp
         6bcz7GImgMNvNMq2+yelkVPi1FGCB8U4sbincXLcjIGAi7PSLMWKeGMw/MkVoHm8p6Lc
         nHmtze+brJW7nyRCibBLG2MMO/14XIwN729HZe+/QEjUVbtQ7gZwhEHXSSbb78JbMIHo
         EGi0BRd9qT8gBeA8qzQxo4DQJalsMIGfSHeKfIorMBQA7tq9k2LhAww4Yll7kedGR0ne
         ro8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527034; x=1693131834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJH7/+si9b/KfqTSKBxRUP5/ijpoIPhIhDqlelDJelY=;
        b=UORVNytouNOfCwaxTkLvO13XPihJ8UT4eM2XKt7WcvDfPQnU821/Ki2zygCYg+ZHh8
         j8lVCh0zklWdc9YzcZIiDpooOchpf4QMMvZe2CF2d1M3RAw6RYEIHwWZ6eEL1f5X81k2
         t0qijxmTgyPMuc826F15IZmgYc6lgtxW7bAjUcgySr+pWBDuyJKKQ4yt26yBRdTwFN5p
         QiQVANxY/wWE5UmGV6X5Xa3vyDz5KjDNwDnrQHeIuyTE0MxW32pcDf6YGMAgG66eHshP
         YPM25JXu9XyWF1wlieDNctkQM1mWtyp9zSqGPKnIeApk3ekGIBpEyUxuFGWJYPL005Hk
         ohMA==
X-Gm-Message-State: AOJu0YxQaQ4KdKlQPkubOopuzRNRcJORmSNdkTFjYhb+Bfnr7g7Re76S
        8L0dupC7s0LmQIPGyom/1Io=
X-Google-Smtp-Source: AGHT+IHQLA6aFC0cYcEHyElnpiYWDjxmQIkQeMHlKJjj9w1g0h8CNdggn7yatseLJ2PWBadSJzZ+rg==
X-Received: by 2002:a05:6512:31c8:b0:4fb:91c5:fd38 with SMTP id j8-20020a05651231c800b004fb91c5fd38mr3276295lfe.0.1692527033673;
        Sun, 20 Aug 2023 03:23:53 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ff9d22e486sm1193787lfq.226.2023.08.20.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:23:52 -0700 (PDT)
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
Subject: [PATCH v7 1/6] dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx family
Date:   Sun, 20 Aug 2023 12:26:05 +0200
Message-ID: <20230820102610.755188-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230820102610.755188-1-marcus.folkesson@gmail.com>
References: <20230820102610.755188-1-marcus.folkesson@gmail.com>
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
    v6:
        - No changes
    v7:
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

