Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E27886B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244513AbjHYMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjHYML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:11:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AC1BC2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:55 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a4818db4aso1202965a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692965514; x=1693570314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W09M8JIJtZCbNBhGe/AHRCcrRIGkrBwh+HJVwKRzmpo=;
        b=qy/k8F4E2HnvzsVd4KmFJ9w+Is3DiCU8cReyo3hylHEak4SVWOjMPSvhS4/qaaCgvA
         gy6RFInVgy/huM+JuWnN+G2wXg7OC7gFuYVwGr7WH//qN5CgjPciVrBKR6q7Tju6Gx7t
         7nBqvHwBincOZ3iQXO8cWUDH+fMLTGv49kSthzS0o/vsrTWMYKP4p/VMFxqe4Xre01+w
         Vsx+JAOobalOWf4KG7OwC0jqltoRkxFpPV9wtKcos2Bpcm3J68urwbix3l5LFKaXZmM5
         xwl3TTxDMLEcJrmF0JAHKjV0tP7kWfLK23KvpMX/v5o3CAKQK7bznbZhI4KMuEixrXB6
         gquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692965514; x=1693570314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W09M8JIJtZCbNBhGe/AHRCcrRIGkrBwh+HJVwKRzmpo=;
        b=XbXfwyjKzXp1cMew1Jt9RaUnJdHCiEUMEuf2yY/AIRjbTwPENbJiuB3feEK+840itV
         KKNHW129x1rodUsFf9YXTR8YTYgd5p92LBRPYyCjJZv0wLQptW22o2DAfgutOjVKm3rS
         bpcocNnzI6lO7yyLcwVQ13z3nUDCxwEoRdowcj43mutLJxy5z7cyIhfO8wQTQPcNjg8L
         AGJo57aCVtnoe8z0BWIwLZrwRnCXoGtmlGGKGGegaSbluU8oCTJhIDRx6TgjuaKPWnhB
         7S23KAMQLRRJCyAVipt9TpBGa/dMnpjRdIqseYDnlMj+d2+bs2lC6xK7QC0NKOqS73ML
         e8IQ==
X-Gm-Message-State: AOJu0Ywa6SPa1iC1hZlfssO4Aa5PkF0y006oF68fT7QFzYcjFBxP6ZO7
        T6NG3nYVuBA6es/It7TBR3Vn8Q==
X-Google-Smtp-Source: AGHT+IGeaaxzgQU3D9ocJw3HPTByA322ZOhgy6e3l3Q+GdmYumf8G9Xf+6/gcGtQ7Yrnsa53Y5ZIkg==
X-Received: by 2002:a50:ef08:0:b0:523:3e77:7eb5 with SMTP id m8-20020a50ef08000000b005233e777eb5mr14091316eds.2.1692965514049;
        Fri, 25 Aug 2023 05:11:54 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id l5-20020a056402124500b005222c6fb512sm952311edw.1.2023.08.25.05.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 05:11:53 -0700 (PDT)
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
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/3] dt-bindings: display: novatek,nt35950: define ports
Date:   Fri, 25 Aug 2023 14:11:41 +0200
Message-Id: <20230825121142.101759-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
References: <20230825121142.101759-1-krzysztof.kozlowski@linaro.org>
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

The panel-common schema does not define what "ports" property is, so
bring the definition by referencing the panel-common-dual.yaml. Panels
can be single- or dual-link, thus require only one port@0.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>

---

Changes since v3:
1. Rb tag

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

