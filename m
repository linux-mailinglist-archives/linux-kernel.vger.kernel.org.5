Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A089A7E9213
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 19:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjKLSoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 13:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjKLSoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 13:44:17 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A70273E
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:14 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5ac376d311aso41268657b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814654; x=1700419454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ph7m6E1Vtkv7RR08QhRUG59xkdDRnqIt7SGyWJz8QU=;
        b=TpcWzFbFbWQD/R4q1X10vUxWwV7ztvB5P+uMEmzb9P6mjcfL+EXPSWcAiyxEK2KMls
         hjVUpoUy6j7zaBWFxJ70GmJPgQKPCKUSLhQ5MdGXEnVnBumkiOQQf2DpEDAbH9Y7RIjB
         64HVagIdcRWSEErRbMfyfkjVZ+Iia0l9loEH00GZ0oHzRahwTLLAf/E5xH39TGfXwzSC
         T2t8SE8MM8yDA56VfUS0L+MFtcko3m6G8a75dCK8iRyIF0bepJKp2/Mf75yGuRr0EUq4
         FmH6u5gBG8ngP7AAohZRT0iq2WksHTyZUEoH/d/mOyTszQPVC7tPNlKL47d8W/YRrZSW
         Cmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814654; x=1700419454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ph7m6E1Vtkv7RR08QhRUG59xkdDRnqIt7SGyWJz8QU=;
        b=WfL7LFkx2lVT3r2N2shmQLP8QfOaXtLv8wOprpZp1Ka+dw/6mBQ/h6qtYEub/WjSLG
         YIvKaTFbFIntw3EAPQZ06t4/V/sTVTIWp9BMMd1CwVMdDG1t/20C4bHebrKdJjBPzz2V
         i/IYGGPJkMVxcQfojUH/2DngXpWs5NiORf5lYxD5cq2Vxl1SaK5nRmzmhesIpaI+tEDy
         F7wN8DFG4nUVpJl5XqS8owRwkiy7/w52ck+k4QLLcxBbuKiKV5XdB672tlyhWpH/noYu
         st1wLqHeMvx8HemU+YC/nJ1pdH8RtWg02OQ/AdDFpyFkgQDg/wtQkVgvtZMwofXqJ7d7
         Y6OA==
X-Gm-Message-State: AOJu0YxW5xWvY2kwAKftUIHteoxuGKSgm3oUMFqqFxJL4fofXL19m4lk
        5ATShIPeb9b236hMhK2uaeShXw==
X-Google-Smtp-Source: AGHT+IHpzvYeJiWjBu0flWuD/GyQnhsKd8gKM5c0RQLvUyFjf+fvZeq5nvs0RJ5Nw84f/GzsfgSNXA==
X-Received: by 2002:a81:4113:0:b0:5a8:277f:b378 with SMTP id o19-20020a814113000000b005a8277fb378mr2138130ywa.1.1699814653985;
        Sun, 12 Nov 2023 10:44:13 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1308938ywe.80.2023.11.12.10.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:44:13 -0800 (PST)
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
Subject: [PATCH 4/5] dt-bindings: gpu: samsung-g2d: constrain iommus and power-domains
Date:   Sun, 12 Nov 2023 19:44:02 +0100
Message-Id: <20231112184403.3449-4-krzysztof.kozlowski@linaro.org>
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

Provide specific constraints for iommus and power-domains, based on
current DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/gpu/samsung-g2d.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
index f368966cf83a..132aaa49597b 100644
--- a/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
+++ b/Documentation/devicetree/bindings/gpu/samsung-g2d.yaml
@@ -30,8 +30,12 @@ properties:
     minItems: 1
     maxItems: 2
 
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
-- 
2.34.1

