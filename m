Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D31877EA73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346034AbjHPULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbjHPUL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:11:26 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E093D1BE8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:11:24 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bcae8c4072so4826438a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692216684; x=1692821484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Lws75iJ418dvUiFUMpSCZSJpyx26Sbj9eIlHFk1PcY=;
        b=gN0LEIm74Bz0xvqXdVi1r5MAh02OiOvRcyxW0f5+qOT1fJ/7dmXHMYpRBo7e8fuedD
         8E4aeaIwULrgMTSxCM6jl7PiqnX64zMuGoumHx0wl9gy/X+Bc+FYvDnQVSxw7e/jJLxx
         HlLEC2nruRP1nKj8dGZNxRz3ZfnKUDUPrlmrFzHIumdsS2pBPPbZXXu7Io7JbR8rLxHT
         52TZ66fWdg83GsKplHOCsehJ/qqNNLkipPKwsrkQB02DfKddjUYHpd4MCyGel9BmX377
         U5dFdwvUhxoGzVKdzENDAKD78Yk6dYBnyZPLXU7qe5kjSmRbYP6Yqyeb0vQob5B29ZEV
         EGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692216684; x=1692821484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Lws75iJ418dvUiFUMpSCZSJpyx26Sbj9eIlHFk1PcY=;
        b=hW6qigj2uxzQrjDyxwZ2+KyxY54hJfIMTvSw5Hgl6KC+Vu4vpbtGdX9qv4FitqtlAA
         TR0ZJb53sC0gPy++twtXgBWxWm91G5UgefX3t0ZJYnX2dsZRuk9bxzpH9Ah5B8/Zm8EA
         xRgiYWnPIQROQM5PcDPrbtrVtUN9RSr47O3DJx+37MbfNMq0LnUo/TmnfaJUvrA4wwk4
         IaWewqgFBX+ppsN+hSAJDaQISS5ywAGCqFKlQOchNZ/QFyDHTsmNxwlKILcHhrEseshI
         tJndqrEo2Nt+wZZyB+upa23k9u75gjm0QAAnoD7FeOL2YRoVrHgQEwMBo9MFEuqr3VSE
         DNIg==
X-Gm-Message-State: AOJu0YwN+uO7kThlKN+7/3llsHtWa3/aGKXa6hUwnSzqIad2y2deB3UR
        aZb9DtGtH047qwRJVwTW8ogFgS4fsYpakFtGcd4=
X-Google-Smtp-Source: AGHT+IFnT/6Su+IdemW7NvD/jLoMyj22j+Z2P6LjjB67eLjhfM9Ka2Q7lSUSr79I01dl9GO21DBAtw==
X-Received: by 2002:a9d:6a99:0:b0:6b8:dc53:9efd with SMTP id l25-20020a9d6a99000000b006b8dc539efdmr3138769otq.3.1692216684263;
        Wed, 16 Aug 2023 13:11:24 -0700 (PDT)
Received: from localhost ([136.49.140.41])
        by smtp.gmail.com with ESMTPSA id i6-20020a9d6506000000b006b58616daa1sm6349374otl.2.2023.08.16.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:11:23 -0700 (PDT)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: Fix Exynos5433 compatible
Date:   Wed, 16 Aug 2023 15:11:23 -0500
Message-Id: <20230816201123.3530-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

The correct compatible for Exynos5433 is "samsung,exynos5433-dwusb3".
Fix the typo in its usage.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: 949ea75b7ba4 ("dt-bindings: usb: samsung,exynos-dwc3: convert to dtschema")
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 42ceaf13cd5d..240f41b7133a 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -72,7 +72,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: samsung,exynos54333-dwusb3
+            const: samsung,exynos5433-dwusb3
     then:
       properties:
         clocks:
-- 
2.39.2

