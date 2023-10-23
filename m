Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46077D39CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjJWOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjJWOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:41:19 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3208B10CC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-457cba20cb7so1387163137.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698072057; x=1698676857; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldEUxwW0Fy0mrzjboUPRF8EoX2iX0HxtTAw56Z0DCkc=;
        b=wabt2kFZTL+Zwb/XNWxzllEFDPHKguDA3Cy6bRrQLsb9DgwDMEuUfKeH9WRHOuPJpl
         brvpFFNTX/g+lWV/CLDB69wr01EMlp1ae546txwbHaeC75Jki8MIij3E6vOsBrrb8Lnb
         ambm++fBQ9i6MOPFlceHU/YMOQbIuobazkahWs/SUzjDAZMNGrFC2MllAPGJC4KO5Ga/
         sFFkOCB3ngLd9GWatxrhJGZXo2K8xm30LM31GEUO2guyDvqs3Kbv4iT+5LpDxfeFuCpQ
         SDA/DeFauzKgMCv+D9VMKsl3x58vc5J9Px0NyMQSa2eHbVmqZ4yLnvMNQxBXHNOBkXtN
         icqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072057; x=1698676857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldEUxwW0Fy0mrzjboUPRF8EoX2iX0HxtTAw56Z0DCkc=;
        b=TXBSDeHefsKthmqIqcVA08ayfrX0nWWwUTZcAj6ZKuLdOp9BEpxrHWk2GuBY/jwmMB
         Dfb1bmMoWSVu204rqlWQSSooEDneT6DOQypR1JdpW2r0r8V1IoOgywybDQ90jwv6tW7e
         7RIK3D9icPH/MoRzgVkGOJpmyBuUVNDkZOWC7l78DF18uLpdX4qdJOqMCoql+7rBgq96
         EunPdfG6Iec76D2ysMUbZcHhedV2dii5f8ZFrItXfzQqtL/PwK+Zvxa7XE2kXXCKh0ui
         +6drywKN8moVKeM5HI7+9AhB1XpfJbejybAZecliip0pPoAsiMJjS5opg9CYP+J+kcUm
         94jw==
X-Gm-Message-State: AOJu0YyMbv5fuM5rEP1qrbUpw9iOrRjwMHqolcx251DFCkoK33tvSSKc
        tQR/Gz2PSXYWAFcPIiJm1ILuYA==
X-Google-Smtp-Source: AGHT+IFLiGqYjYgkkmhbWIWlxZwOq0jwUvhrblN+PaMrfko4EvmObtO4ZiyTI0M3Yr+diwGb3WhYbg==
X-Received: by 2002:a67:b206:0:b0:44e:98d8:c62e with SMTP id b6-20020a67b206000000b0044e98d8c62emr8900193vsf.33.1698072056935;
        Mon, 23 Oct 2023 07:40:56 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id f1-20020a05620a408100b007789a3499casm2725020qko.115.2023.10.23.07.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:40:56 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 23 Oct 2023 16:40:11 +0200
Subject: [PATCH 11/18] dt-bindings: pwm: add power-domains property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v1-11-5c860ed5c33b@baylibre.com>
References: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
In-Reply-To: <20231023-display-support-v1-0-5c860ed5c33b@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=DODtQ3KKkKmSOKStztk0HQRraEPq6Af8qZra+9tlquw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBlNoXPErWn29tQPCf4oVzASO7FUbuxbsUhXSJzI3GY
 C7jeCR+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZTaFzwAKCRArRkmdfjHURXt/D/
 9MzVckTai5VFj0U2crACXdS3d85+cjns4FtKSUJrUj/WjckEkdp0JsdxKC1zFkNjWK0Ihsv/kw4yem
 CjzBSNb9MoorMzjySnhztrmePXHYs2TD7BKvHL3UzwQizLhHPUeK0tCLvMrfd3C+G3i//d5Im+GJ3v
 CPe74eH/Rt4ZHcSUt5BrjEeSfrCE+f5ge9YTMoV9VuuimUyfWf7CZnRzZdcDKZC8hkrn+f/17wtBMu
 R+oWl6HOInmMINApfqjKTEkiC6vMr1qcZPCT2DsKxjDoEFBacV1PVafe71gumjbFeRk215SA/PTx1/
 TH/xHn4Jwlrj94CzH1hUxoYbU74wGylMDpyjEAxRGamB/CBJMGOiksErFg4F4qCV58Q6E+DLMgSRM9
 qzBPT0RwgvjthxPYqCDZdm0LesHEhqcnu6q5IzWWAVF1x0uTl53lW58W0xjyGDQGfhgB50Q2wBQUAe
 ZyLLg1qCtnsSijsKnH7tmjpUGHyN3OTeaqztt5HgDvJBGOiuNyuA07yJIOB2gRt23IrtPo+wFZHtEX
 fLnYrGMi+HR8rtWvuWHDoUEPM3py0EML3ZNo5mOUBu28/m6ThGcgb87IVVXBJsybV0iJcia4VD1/Ox
 FjnvboSPmCb8+ILzMlww4Ln+u4fDTotP+vaGxPMNz4G5GF3MT+loseO0hexg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Mediatek datasheet, the display PWM block has a power
domain.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index 153e146df7d4..efe0cacf55b7 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -53,6 +53,12 @@ properties:
       - const: main
       - const: mm
 
+  power-domains:
+    maxItems: 1
+    description: A phandle and PM domain specifier as defined by bindings of
+      the power controller specified by phandle. See
+      Documentation/devicetree/bindings/power/power-domain.yaml for details.
+
 required:
   - compatible
   - reg
@@ -67,6 +73,7 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     pwm0: pwm@1401e000 {
         compatible = "mediatek,mt8173-disp-pwm";
@@ -75,4 +82,5 @@ examples:
         clocks = <&mmsys CLK_MM_DISP_PWM026M>,
                  <&mmsys CLK_MM_DISP_PWM0MM>;
         clock-names = "main", "mm";
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
     };

-- 
2.25.1

