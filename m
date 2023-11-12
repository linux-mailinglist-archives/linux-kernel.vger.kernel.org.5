Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB8D7E9210
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjKLSoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjKLSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:44:16 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8BC273E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:13 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5bf58204b7aso38447157b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814653; x=1700419453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKapjGZo46m2u3Pg+KgGkylJklW8QTl7gfgNZK8ZJCY=;
        b=iw0kFUuRxQS4MRdP9ZPJzS7oPkfkXebd7c3njWsPui62lFi9tOfKXScs9zrlWtyZke
         7Jjc8kGfU+f64JD0OYZCI1omZqi9njEXxR740nn4JJzH/eZiaSfCNdKUBD8f4rdS4gYe
         EKoch+HpXgXPOyKP6E2gd+3uyLdzti8z8XACNYyHq6L781CWAslb0/Cq8DtkFNC3E7A7
         FyZ66B8dO0eri9nfL5KYHQZz3r+dx6KxpMQSAfVJs9BWzQXBgRGcsQjgCdGuW7oD7rPU
         ojtYcCugoS5kp/dVJ41ajgLFRVxoQBg4yCV03ckCIZTUPQjDxUz++GTn3yssESJmKRdI
         LtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814653; x=1700419453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKapjGZo46m2u3Pg+KgGkylJklW8QTl7gfgNZK8ZJCY=;
        b=S0iCcCm9uBA6zMavbWknHON68ABusaKRqmSwUTvS3DN70Ty6y+x+2AozmUzPmICQPb
         +u3DB/c0fk4twfuF1vtBYyoqtDRQJ372PIaKd9AoyurqgrFSnrjEt2YEFYOqE5Swgji9
         76nmAD97Yg7lYZEoIU1qDbN11UhPdz9Jlb2wyNxfGRPGRpguqEvVntXuNPox6MEZsxYb
         6V5H8Kdb2WYzwmJcFJ0qawpIhPtG8pwhAT02eOumRORV6BAP7FERss77YLCdozBMM+7O
         qfCMyQ9SfsPTJLL49iA4HN7Fby1Jg4pEL1I84phZttWkoncB2eAljv/c6IOINZlIKTDN
         p3yw==
X-Gm-Message-State: AOJu0Yzqs1hXAaRrIdkgbeyQB1fnbEqrWRJckqtQ7mKIa7OGI5UGIcdd
        HSPEf5C2cegh+4RPaS8mkr7NLg==
X-Google-Smtp-Source: AGHT+IG6jLEwOvsic3zim3Oi0DQNKZCCpaWpZotIRjhbW1JFP57Ypl6v3EbQBFpfe1K3LZKV2jWSMQ==
X-Received: by 2002:a0d:ca8f:0:b0:5a7:ba54:af02 with SMTP id m137-20020a0dca8f000000b005a7ba54af02mr5340230ywd.38.1699814652746;
        Sun, 12 Nov 2023 10:44:12 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1308938ywe.80.2023.11.12.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:44:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/5] dt-bindings: gpu: samsung: constrain clocks in top-level properties
Date:   Sun, 12 Nov 2023 19:44:01 +0100
Message-Id: <20231112184403.3449-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When number of clock varies between variants, the Devicetree bindings
coding convention expects to have widest constraints in top-level
definition of the properties and narrow them in allOf:if:then block.

This is more readable and sometimes allows to spot some errors in the
bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml | 10 ++++++++--
 .../devicetree/bindings/gpu/samsung-scaler.yaml        | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
index b6951acc7643..f368966cf83a 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -22,8 +22,14 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks: {}
-  clock-names: {}
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+
   iommus: {}
   power-domains: {}
 
diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
index 97d86a002a90..e08fc1e4115f 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -21,8 +21,14 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks: {}
-  clock-names: {}
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+
   iommus: {}
   power-domains: {}
 
-- 
2.34.1

