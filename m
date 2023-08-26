Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17353789559
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjHZJjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbjHZJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:38:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD131BF1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:38:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf3f59905so205481266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693042735; x=1693647535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HrYqC/NgvPNZZPzsGiT/lg4ia/WmMQNaEEMcPhrqy+o=;
        b=Ho2ZKHMnGtGNdGBuf86HZIZy5cvOfdsx/KMTyiDrlVTzJ2p9I4hJoHcb21XFxbq794
         7kCprWerLTbqDDzakcT6GCYaPw6UVjpPRNQkBx16TJ7AIveo2Wg43tGSbUTle8ODEz2T
         zaRfar9T1WSVgnz/0RN22bVhj77cLh5rAwiyqIdOfTx5D1l3ZpWu1pXuSIyFwvVPiHJf
         9QcicRlmjb0M1cweqrnQlDcpUGb8N3+UZ5RA7T1xjy5XmfCqNIV6ojgJBPdB3RG5V3sd
         Aatvm5O6xThcji9w6UH/PcTGMMbFTyh+BxEo+1Rnu8+tEbp1WJ/pV9LN6m9dwamLS9va
         tkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693042735; x=1693647535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HrYqC/NgvPNZZPzsGiT/lg4ia/WmMQNaEEMcPhrqy+o=;
        b=Nw+UluNSnh68q7t11Pb7fAO38GxoWU4+6+yXkaR5ZrVd1E6zicSI9kj/+C6yhkWuIY
         w+UDaC+LsA8519oNCalGBgUfcW2MXgm+8OKNxVYOBwH6MxDFCiSbDvbGFrcXmxVVv8mm
         rpxwtD8T383crCqaq6p9ltWTurdnfCeZAnKR2VWi7cXiN8d/iXkVio4BKckNdNOB5eeh
         5je1LpBdVqMrFRhZHgQ00H1h2ryVFwIl9BLVABdYMZrZkmE8RwllpAxCXo7QmfCTKLUU
         GEeKJzrbujxPEPrmFBhD3/4oyK6Ae7ahegJ4/Po6BdIeAqvoWVmh6VZAA0vKADSx50Mr
         mqcQ==
X-Gm-Message-State: AOJu0YxXxpNOMOqaNDMmvRkQ1N1sHXUrsHbyKll/RyQlCSvura/PvfNF
        L7sPz+AyptbBtdt6JTroLOCDEQ==
X-Google-Smtp-Source: AGHT+IHjmbFg1H57TDNIZjkNJapebQSvKKTp1AGIcQS1jr/gn0VFF7slvzzVWFYNMDNRDpABgPxOqw==
X-Received: by 2002:a17:906:2ca:b0:9a1:c352:b6a5 with SMTP id 10-20020a17090602ca00b009a1c352b6a5mr9915168ejk.69.1693042735263;
        Sat, 26 Aug 2023 02:38:55 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906718700b0099bcf1c07c6sm1952970ejk.138.2023.08.26.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 02:38:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mtd: amlogic,meson-nand: drop unneeded quotes
Date:   Sat, 26 Aug 2023 11:38:52 +0200
Message-Id: <20230826093852.9334-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop unneeded quotes over simple string values to fix recently enabled
yamllint warning:

  [error] string value is redundantly quoted with any quotes (quoted-strings)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
index 1c79815e1f7f..57b6957c8415 100644
--- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
@@ -67,8 +67,8 @@ patternProperties:
     unevaluatedProperties: false
 
     dependencies:
-      nand-ecc-strength: ['nand-ecc-step-size']
-      nand-ecc-step-size: ['nand-ecc-strength']
+      nand-ecc-strength: [nand-ecc-step-size]
+      nand-ecc-step-size: [nand-ecc-strength]
 
 
 required:
-- 
2.34.1

