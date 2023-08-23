Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF00785299
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHWIXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234394AbjHWITk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:19:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9053A96
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:15:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99d937b83efso690803266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692778514; x=1693383314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2I/rcTmF/d9ASGbPY9AUiCj5AxfuxUDm5JR/iDbnII=;
        b=WePlgP/TalC4r5lDsRV0VLnR4Qk2YImVFkCGSjegCbhbDEAsfZ0SPjACzUvrxaIAjJ
         TT3IC2qalX3RCMZ2OcJ6OrIHpubkC4e229lqsML+3hlP5F+oauoLhIzY7amy2tKd2HAi
         OsstpVeextg5zr4jdwwTqp3EcUh3UI592/D2CMyKP4iYk/GOGFwEtvC8wH69tIkShntX
         ozjm+AJUjWJVxa9YVu5p1ubp9tObtl2oUroJAL9woRzegKYCz5OKEeXXZ0w8uT+z4Wd8
         kD3sZStaQIa7rjBbYW974ztUikPa0bTO/qB/Zu3X4FzO+0fTuUAVCV1zNawHPhTL309N
         xkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778514; x=1693383314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2I/rcTmF/d9ASGbPY9AUiCj5AxfuxUDm5JR/iDbnII=;
        b=Gc8xVMKlD+YX7OsJlwZrdkvWV37/fD72OqdH4YI3Za8d/tlXVmA3HBcRNQCl264Fsv
         wMQTVeb6eS8k5iJb0FKyU+uFTH/Kzj+3L9INsJJncVhkCbHxXAYxa0rSgmZsowyi5rDR
         GbETWMZ5zyUteOo8NqKHQvumLoBCIkwPrKBpRPrWYCSGXEegythD7qLMhOR24N9p1uFc
         XzHVCpaP8ZLlczyMEoUdtgEuqWZXZ5ZlpQ+cV8fTatBylEJ1rpUMeooNkEEo+wam/b2H
         Mi8z+LIzYeJa5xwmL5752gE3ffSYB+qThKqs6237zEsCAa84JTx2zFcgSDF73Jq7GT49
         j4tw==
X-Gm-Message-State: AOJu0YyUr/6cr3Tm7FEEv6F2ROXUv1f9Eg+kOdk2UjW2/V258leAH1so
        4o/x6MSK24w/VQoItXStEpxzWA==
X-Google-Smtp-Source: AGHT+IETjdWV9RFfADLDj5Dy07TdSIAvWrcUOrOhKZnPagMQpfK7z/rBMAjru/IHXBr1oBQ1hT3lCw==
X-Received: by 2002:a17:906:2192:b0:99d:decd:3dde with SMTP id 18-20020a170906219200b0099ddecd3ddemr8804671eju.18.1692778514041;
        Wed, 23 Aug 2023 01:15:14 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906b01200b0098e78ff1a87sm9539730ejy.120.2023.08.23.01.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:15:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jianhua Lu <lujianhua000@gmail.com>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/3] dt-bindings: display: novatek,nt35950: define ports
Date:   Wed, 23 Aug 2023 10:14:59 +0200
Message-Id: <20230823081500.84005-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
References: <20230823081500.84005-1-krzysztof.kozlowski@linaro.org>
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

The panel-common schema does not define what "ports" property is, so
bring the definition by referencing the panel-common-dual.yaml. Panels
can be single- or dual-link, thus require only one port@0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Use panel-common-dual

Changes since v1:
1. Rework to add ports to device schema, not to panel-common.
---
 .../devicetree/bindings/display/panel/novatek,nt35950.yaml     | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
index 377a05d48a02..7cac93b20944 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
@@ -19,7 +19,7 @@ description: |
   either bilinear interpolation or pixel duplication.
 
 allOf:
-  - $ref: panel-common.yaml#
+  - $ref: panel-common-dual.yaml#
 
 properties:
   compatible:
@@ -59,6 +59,7 @@ required:
   - avee-supply
   - dvdd-supply
   - vddio-supply
+  - ports
 
 additionalProperties: false
 
-- 
2.34.1

