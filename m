Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8B07E9214
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjKLSoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLSoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:44:14 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA0A272C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:11 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5b31c5143a0so42985387b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814650; x=1700419450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3sqqPllgETnwwQvfwmEwhxp6/p5QdcAaEjx6oKJg44Y=;
        b=oBEn/gyA0BaVF0GDwMMAfZa1wit0LRjQBvi1KSxvt8GN4LHRiWvvgLDwFSApTvHxvY
         AotjvFf3GPeGO+PrhWfH8KRfB5UuoFVdg3We3K4aoKB6U1S5xRpe75ymKvfakhHTzRQf
         Q04cR7tUn+/3mQn4rYcsWNARKp7oWFqmWuF1EXwVtIAF14XbtkHbYG2pE4gGZfbeNzpi
         GJhDmhAj9KxeB3k0VbrINGmx6dC/tFvwI80mx4Vsoa31jwWBFwvxlZ52k4Z3i6WgZNuy
         rTYP6yyu1rElJvixBlprq9KEZd8qGV979d8qLe4Jy9aq4+E6kAluE0lqzz7EH2RFAPWz
         w8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814650; x=1700419450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sqqPllgETnwwQvfwmEwhxp6/p5QdcAaEjx6oKJg44Y=;
        b=PPVzMUdwfm/sw4nVXGPSS2XsRFFO+5dzfdRq9rt3Ua+geU2tt0pGSOJQbnYxFOQ6Wy
         OrtRIsn+t7UpFvMIdRcAL5XuGvFSOBDZi1ZuQERtB1NVdlhlJ2M1oXO75ALpUiotjRqK
         FvFgXFLR7r/dmt0zl9O/ZrMFu3GGP+mNpXQduixYwqrFOdyTlZJ9YlOS+GWD2dZMhH8Y
         nKXAQ2JdlrAxjRP8Az3+PBN2eEMlGySStBPUOwKVYOD3l0BiOQLV9Bd4ReWJUPIZXrbw
         PT8DmoOf/4ObCBCg/3ZKU0nPW1UWuNPI7LE3u4LtZLksqsMALelyfb5jAWgHDUgnZtTp
         R5eQ==
X-Gm-Message-State: AOJu0YxwV//vL6+Cxiwmm/lpAPc94qwk8+N4SmstaS2AaimQZ/bLLxq7
        bsfb+BA7aq61T5G1mKg0vV25NA==
X-Google-Smtp-Source: AGHT+IGGlUk61F4BEzF1VDsWt9xVT4gMPv8utBpaeVZEcfGMjrCm0u4YtgErk53VC2pVhXrV1Vku9w==
X-Received: by 2002:a81:5201:0:b0:5a7:ba09:e58b with SMTP id g1-20020a815201000000b005a7ba09e58bmr5191792ywb.14.1699814650481;
        Sun, 12 Nov 2023 10:44:10 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1308938ywe.80.2023.11.12.10.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:44:10 -0800 (PST)
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
Subject: [PATCH 1/5] dt-bindings: gpu: samsung-rotator: drop redundant quotes
Date:   Sun, 12 Nov 2023 19:43:59 +0100
Message-Id: <20231112184403.3449-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Compatibles should not use quotes in the bindings.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/gpu/samsung-rotator.yaml         | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
index d60626ffb28e..18bf44e06e8f 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-rotator.yaml
@@ -12,10 +12,11 @@ maintainers:
 properties:
   compatible:
     enum:
-      - "samsung,s5pv210-rotator"
-      - "samsung,exynos4210-rotator"
-      - "samsung,exynos4212-rotator"
-      - "samsung,exynos5250-rotator"
+      - samsung,s5pv210-rotator
+      - samsung,exynos4210-rotator
+      - samsung,exynos4212-rotator
+      - samsung,exynos5250-rotator
+
   reg:
     maxItems: 1
 
-- 
2.34.1

