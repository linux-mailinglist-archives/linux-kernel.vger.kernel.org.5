Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32907618A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbjGYMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjGYMqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:46:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B23DB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:33 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so13617317a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 05:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690289192; x=1690893992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wD+HKpK+g9V/Eo1ZfyVeqQv2ZkF14fSbqDdkDUNFUT0=;
        b=w/PO9oZ0vX3AIlwXEpgXMDW69Lc/0t4Q2pAZ/uS7RSzivD7nkhJpcjl9UWzAZ7ut5I
         KhmYCCSQN4Bs69y9b0VZ5bauEy7/q4xRcb90z0QlFm9T6i26sJGSMVcFfOfmlqc/BLQ5
         mMkJjOH3MdKJB1vlpgSuRDrXx2hKaindWuGl+lcDk60VmT8Kp1kZwQkMJ4oNP0GMALr3
         wYXV59lREFP/wgD3xzESJfoo1aQlebIab4yH5/clqobmdRLlIXm7w1CXjjvfAahEFn6+
         aV/loCTrvYF0dm2IydcoyD2f+hlQs8qvKYVcOES0KtiN9r8BxQvNaC6Y0QIffJbaqAO4
         j6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690289192; x=1690893992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wD+HKpK+g9V/Eo1ZfyVeqQv2ZkF14fSbqDdkDUNFUT0=;
        b=B5pWdZwr+ZaTWGCfQMQfiU7OQUEuHuP+PZDRZqWszU/GRd+WDjlpe0LsLIXhiSOfeo
         Ag0DrzMqX4HkPTS9YDBloX5yAet/yd/xFdgZ3ZGs4FcLADulouB25jylLwfG8OZdu2SW
         JY/VVsCyGCub50HdY9trl2Ef5nA5F+eh9dp+DM+IGL9GPcyFPvrkctIkrhbUeTI6gVtd
         rfZl3VxqX9Zp0ASCp+clRx7MC+LUDhdYqA+4DJEbiUAF3JpG6DY7qcpEDBCXrZvwLJpy
         1smVuX2qGAdGFMSy8yZzNuTvihXB6teYaPPXpUZCshbqpjDVYuvjW2hMlTU4rdUZQkm7
         Wx2Q==
X-Gm-Message-State: ABy/qLYgcpc47MuPFWAh3XfB+0xWG587m304ioyLbzkEZhtB9A3JYVdU
        ZVVQhOcdPtECx+P6DdcPaM7TGA==
X-Google-Smtp-Source: APBJJlFjGkMiiA3LTuUWupyujaXfUXOSOWQNK6zgkhil0TK00MRAeojQIUFo5S8Yz0JEAvI9ImOyDg==
X-Received: by 2002:a17:906:53c5:b0:99b:50ea:2f96 with SMTP id p5-20020a17090653c500b0099b50ea2f96mr2290951ejo.12.1690289192327;
        Tue, 25 Jul 2023 05:46:32 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id xo18-20020a170907bb9200b0099b5a71b0bfsm7970576ejc.94.2023.07.25.05.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 05:46:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] regulator: dt-bindings: dlg,da9121: add buck2 constraints
Date:   Tue, 25 Jul 2023 14:46:27 +0200
Message-Id: <20230725124629.150113-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of describing the constraints for some devices (buck2 not
present), code it in allOf:if:then section to actually allow validation
of this requirement.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/regulator/dlg,da9121.yaml        | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index dc626517c2ad..43f99bc8fbd4 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -97,8 +97,6 @@ properties:
         properties:
           regulator-name:
             pattern: "^BUCK([1-2])$"
-            description: |
-              BUCK2 present in DA9122, DA9220, DA9131, DA9132 only
 
           regulator-initial-mode:
             enum: [ 0, 1, 2, 3 ]
@@ -122,6 +120,23 @@ required:
   - reg
   - regulators
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - dlg,da9122
+                - dlg,da9131
+                - dlg,da9132
+                - dlg,da9220
+    then:
+      properties:
+        regulators:
+          properties:
+            buck2: false
+
 additionalProperties: false
 
 examples:
-- 
2.34.1

