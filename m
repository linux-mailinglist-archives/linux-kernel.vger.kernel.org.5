Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED7792A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242429AbjIEQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353759AbjIEH4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:56:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB80BDF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:56:14 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99bcf2de59cso323860066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693900573; x=1694505373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tA6N1zwAD88Cgl3i6p7QciLW3xFhFAIdikvljwPx/E4=;
        b=PVHrswjZUhRRQRska/pIH66dsoT64dhltonmNPceeOhBbcB7eMuOP3q9HZeaC4Yp1r
         PwPJjKtKaKry3k71XIAf3/srkcBdaMQZIvsRYnmxkQKAAzQJkSWOeeYJadLfqU8sTZ3K
         XiPEicfhNP4LQC0hxO4Uloj+QFyh+OfB0qx4TTR/8K6Om8xL2GPiY10ltGrIqKVGF/87
         uBMCOdIHYAPqeRHOwK2y1Kgf++Jk7XXqApKWAlMCwV012UPPD6tl6IniiR7aLSxGA78f
         j81eguDI8kgxWmmHykLhAmFVyU4A0YXYMlw4S1chF/f9nqqN6p+o6Xi+pRQvtEukQM2x
         S0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693900573; x=1694505373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA6N1zwAD88Cgl3i6p7QciLW3xFhFAIdikvljwPx/E4=;
        b=kWIv6gSxv7lllrblkXthzo1jPJpyJR+lx3M7jKAzUgf5V9eQPiy5FN8EnJ2vfyJ8ZS
         l0xmVOia2cnSzw5EkdxgBSI1X5ifBJ5cMF+dDIUATQvRKjz2aJHPbOR5inJ0Kf2shLST
         e5wgO4HayHjvu7znaCb4LOWBzXYipxWU2YryglVlAWNJbnhPN6vxSoRutT1SOGhvUyTE
         7IDp5AZ7QFosQsUfJ9iEUljsJDR3XfcvzjuuyninSZN7tJGgdJbW1d6+R+adRZYILeSk
         r465IygYDdYYuBirvRZCQCIoqCZChiJWRDegwCa2Huju6OojE5XPtmhuShr0Ybj4T14K
         T57Q==
X-Gm-Message-State: AOJu0YwVlrBuDRVkiFdZgp0mqifSfPnCqOvB+LyC6FJs01ri8irdPIAo
        ZuRROJJmQQSW2jxTIfmmSpHJkw==
X-Google-Smtp-Source: AGHT+IFzwHQmm2igqrBiBviDINXZhxNp5rbCu7WH1mYkxMQ5qhActIok3Pu8r3eEr4NGuhQcAx9ykw==
X-Received: by 2002:a17:907:75f4:b0:9a1:d79a:418e with SMTP id jz20-20020a17090775f400b009a1d79a418emr9434819ejc.40.1693900573242;
        Tue, 05 Sep 2023 00:56:13 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b009926928d486sm7208682ejk.35.2023.09.05.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:56:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: mfd: Revert "dt-bindings: mfd: maxim,max77693: Add USB connector"
Date:   Tue,  5 Sep 2023 09:55:58 +0200
Message-Id: <20230905075558.21219-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit da7ee30ae6662f016f28a9ef090b2132b3c0fb48.

Commit da7ee30ae666 ("dt-bindings: mfd: maxim,max77693: Add USB
connector") was an earlier version of my patch adding the connector,
later superseded by commit 789c9ce9b46f ("dt-bindings: mfd:
maxim,max77693: Add USB connector").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Fix for v6.6-rc1.
---
 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
index 9804d13de648..6a6f222b868f 100644
--- a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
@@ -31,10 +31,6 @@ properties:
   charger:
     $ref: /schemas/power/supply/maxim,max77693.yaml
 
-  connector:
-    $ref: /schemas/connector/usb-connector.yaml#
-    unevaluatedProperties: false
-
   led:
     $ref: /schemas/leds/maxim,max77693.yaml
 
-- 
2.34.1

