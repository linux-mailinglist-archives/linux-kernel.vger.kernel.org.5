Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D17E9212
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjKLSoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjKLSoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:44:19 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F94273E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:16 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a90d6ab962so43108787b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814655; x=1700419455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA6uZGdGjNfy56jm7BNtgPNmqVGZq5+CSaOwN7oZJ+E=;
        b=kr4uWEPJOdp6qNPx5pPSxfvNv6wQE4zfjoAYeB/wdO+AGrdMakhhlU1kZbdZarZBSU
         216invsFu5fD6N2xTxA/z9nOUQKp+1W2VYyDYzOOqVt4utTK+4eoeSVBXruMn7q/IsgK
         MGWSL4RR3WQSh5qh45d7ekAFNjNFlOfcKJipaLJTUsNDygqQ35lG0iHgYPL/YNkuDiqa
         YZAIxeJ+lxheJX4C7NFPdqZLU3M+Z66zxIxXvJ7wmzw/ZCnDGWL2p3YOQu0jvN4L3K2p
         Fe3r2G+DBbCCtakIaR14RNCyQRkOqBfFGkE9MoabInDf7mbfC8eFrrzKq/szO/aLP0bH
         htUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814655; x=1700419455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA6uZGdGjNfy56jm7BNtgPNmqVGZq5+CSaOwN7oZJ+E=;
        b=sqMBnvw1k6pXj2uBDCmD7AHAXL8UuMQdmtbHAegPMBasti0sNajadr70hm7LQcOwzA
         27WaLeCAhhL+PfGfvQeVLOCj4L691vzCeEs4NkamfDLQsefvT0ihgkb4pTH7nGwBv9Sj
         zjjV8rcqAVZ2qU4rDykmz7TzJRQV2omnAaaSZsdFM0lC3NXfUReBSuB0cWLxvHs6DDh5
         jg5t05bxt/3aatXzgT+i7LlTlOT+/2fvnTtXDkLwXGvSZMhjWxFnZ9L4q7g1toshoHu2
         y5Z5ddNMTKkzcdD7/sMnmieUpVVCLuZNJIdKZDz/sO1CVBW8ZmKlw7jVpXQSQM6Tc8Mz
         uMaA==
X-Gm-Message-State: AOJu0YyTwM12Qa8LeLUBMjaTZ51zjr78aCQa3VydgSj6x1cSXl7SUrAv
        ZHTSnTmaW0fRDJGfH/g9SSxiAg==
X-Google-Smtp-Source: AGHT+IFDp9bTcaoYSS3SmDoNnC/Q/pGeVtVhCAudVa3PU9gSMb/Nn24WRlw1g6TBbP8UrZiRDk3iCg==
X-Received: by 2002:a0d:cc53:0:b0:5af:b0ca:6950 with SMTP id o80-20020a0dcc53000000b005afb0ca6950mr4995062ywd.42.1699814655547;
        Sun, 12 Nov 2023 10:44:15 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1308938ywe.80.2023.11.12.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:44:15 -0800 (PST)
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
Subject: [PATCH 5/5] dt-bindings: gpu: samsung-scaler: constrain iommus and power-domains
Date:   Sun, 12 Nov 2023 19:44:03 +0100
Message-Id: <20231112184403.3449-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
References: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide specific constraints for iommus and power-domains, based on
current DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/gpu/samsung-scaler.yaml      | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
index e08fc1e4115f..9fb530e65d0e 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-scaler.yaml
@@ -29,8 +29,12 @@ properties:
     minItems: 1
     maxItems: 3
 
-  iommus: {}
-  power-domains: {}
+  iommus:
+    minItems: 1
+    maxItems: 2
+
+  power-domains:
+    maxItems: 1
 
 required:
   - compatible
@@ -54,6 +58,8 @@ allOf:
         clock-names:
           items:
             - const: mscl
+        iommus:
+          minItems: 2
 
     else:
       properties:
@@ -67,6 +73,8 @@ allOf:
             - const: pclk
             - const: aclk
             - const: aclk_xiu
+        iommus:
+          maxItems: 1
 
 additionalProperties: false
 
-- 
2.34.1

