Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8B67D1D77
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjJUObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:31:22 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD109D65
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:31:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40859c464daso3423435e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aceart.de; s=google; t=1697898675; x=1698503475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LJpDlIiRiwiuxdMoVURDKmaMGrN9X/vug2AO0xEv5U=;
        b=H2rCcNXpA3jXDGeFbK9mj8zF5cR2vDU+1i0xbHxt+sZWDm4AduF7VCfvOLyUAPMkKz
         UFK5RyKuwDR/TA4qlKctoO9TRXTz6deIZKcaceDcbCFJ1F7qfM5o/FMrOF72QRys7eY8
         MXuckKa1UOfOOBGSskPKrnU3OeF0dT3MOuiF7TYYydCDFLbhZIfN+2dGmi+pkGCUjdcP
         H/O0AY4oV7xvkmLuibBmpPHo9lNG+fAUbPrbfuOBmd+6jxajtYDC91qsxAjuVrbzwmBn
         jkn65jw76k+WiVFm+VJ6878wSeLQ5qSXWJFZ/aMPy+7y5qY4+d/JFZfg9QhTnoeBFekz
         iMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697898675; x=1698503475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LJpDlIiRiwiuxdMoVURDKmaMGrN9X/vug2AO0xEv5U=;
        b=iWWzGdeHNGx2swjkFNVMDJgqUbNS54Ia+9q7YDjpUyjTxGM4d8TZ26Q/57R465xxnH
         XhgbE2UpR9Wmxj/Wc6ok+dZ+pgkcKZ6fIhlBbHUMF83arDgIliA2bEsVsqMEf7Wcwo3K
         ZKdIKVVeiiHehYqA/2aEeLKYH2AoTPWVYbbGOHMhTVMfoVT6DTWZXVep9yYHfZuzsbml
         V75xcs3GEbNhU6sUqCtrO25pAVzaaG2rh3tA9NKAX6NwNy6RplHT8DUxwgKGK7tqGuc5
         LOp788etTj5zEZBkKsdKF0Jb6gsQKe+8xzRoF0mfaz7UJigixa4p72hKt6/qPAQVZBI+
         iZsQ==
X-Gm-Message-State: AOJu0YzvlhQ6IypN7r1y9f7gej/7wR/evhnop5L8lrZHCb9VIaqZrrRX
        CDauL0qelR8nGb7ev3r55+rt5Q==
X-Google-Smtp-Source: AGHT+IGNJjyZb+7Uajr8RQ49cwaAVeZxiqb20qecfa04uv1b45gqac/gM6EA8xUjxJMHl12ZkWoRgw==
X-Received: by 2002:a05:600c:4ec6:b0:408:54be:d961 with SMTP id g6-20020a05600c4ec600b0040854bed961mr2901184wmq.35.1697898675050;
        Sat, 21 Oct 2023 07:31:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:d89:b820:87f5:4b33:b582:39f3])
        by smtp.gmail.com with ESMTPSA id u3-20020a5d5143000000b003296b488961sm3793917wrt.31.2023.10.21.07.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 07:31:14 -0700 (PDT)
From:   Lukas Walter <lukas.walter@aceart.de>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Lukas Walter <lukas.walter@aceart.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Huawei Honor 5X / GR5 (2016)
Date:   Sat, 21 Oct 2023 16:30:24 +0200
Message-ID: <20231021143025.77088-1-lukas.walter@aceart.de>
X-Mailer: git-send-email 2.42.0
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

Add a compatible for Huawei Honor 5X / GR5 (2016).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Lukas Walter <lukas.walter@aceart.de>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 7f80f48a0954..20d914b21847 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -191,6 +191,7 @@ properties:
 
       - items:
           - enum:
+              - huawei,kiwi
               - longcheer,l9100
               - samsung,a7
               - sony,kanuti-tulip
-- 
2.42.0

