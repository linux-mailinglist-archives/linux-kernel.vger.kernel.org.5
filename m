Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B398781CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 10:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjHTIKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHTIKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 04:10:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BDFCF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:05:48 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso3403505e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 01:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692518747; x=1693123547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0FBq4YTR+0Eb6sKOYr6I2bt6IPGuv4RF8Oj9v7H5bKY=;
        b=FHCJb70x6bgYq7af5DTY604C3eCpKukIc5sgg7haKJ4ua8rxdXJuvyocaw1yuQcugD
         0gDj8xVX2Cobul2yuq5N9QJs86IDZgiiAEJAzhND9QIr4a/6N8QL3GxbEKR2md8A3kIG
         8rEtxyNh7KNArT4z9Ec6c+B69BH+I7bYmKnFOjJ//SpYsWIwJnAkivpgv5vynzEy96KU
         0WsmLZDrWzgvPsc72k4ZqgUVBorcvCGQrUbnctVv2zXznuodrTaIgXV0H63DUHu1JbkE
         sabbZdDLBSVBv06/UJnd421Oi8mURK6cKtmhPpBcYpD1oIuI+ov/mdMCRbwDMXvYRsQR
         Q8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692518747; x=1693123547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FBq4YTR+0Eb6sKOYr6I2bt6IPGuv4RF8Oj9v7H5bKY=;
        b=gSDC5NRgpvJoHiH15d/SQD/7ZO3tDsuOBDz1XHREjGqhVPIsNFAoxkirtWKZVTk/af
         IwCkIfkMocUgwpmGVZZTo/oc6xkxjCuy6D/SBiV8YbYVt3YLEDwYPHwg+Hg52Us8lwN/
         +v0R4RgaheQqcmOA0BP9x/QlKn1CvtbXjZpZyQRTeHn/6ozFHAsq5WD8OYr8lkZf+56n
         OFMeRgUdqFmw5Oj7vN3T83484Xr7B2QptxyGjQuRBtACHhdOo1r2uRkits8Jzg5LAS+9
         86+j6A+38/UF9ZAZdZSLKsIqWqzvfFSwF0X7PG2dv3W379Rusrt156l8somkkwDSK/eR
         xhLA==
X-Gm-Message-State: AOJu0YzlFIHwktDuqxb8L9MoXuXQ1CNJpSQq0OIIBkfxVDx5eipUkNas
        2kMOPolemB6aeOzPKiP9S6uU3w==
X-Google-Smtp-Source: AGHT+IHVSKGunxzyjKs8EiRSL/Ef32A4iymXe6Uj4pISjyjeo+J1tZB61PFmnIeT4X7LrodP9G30VQ==
X-Received: by 2002:a05:6512:3196:b0:4f8:5d2f:902a with SMTP id i22-20020a056512319600b004f85d2f902amr3217400lfe.60.1692518747125;
        Sun, 20 Aug 2023 01:05:47 -0700 (PDT)
Received: from krzk-bin.. ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id b1-20020aa7df81000000b00528dc95ad4bsm3256338edy.95.2023.08.20.01.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 01:05:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: msm/dp: restrict opp-table to objects
Date:   Sun, 20 Aug 2023 10:05:43 +0200
Message-Id: <20230820080543.25204-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple 'opp-table:true' accepts a boolean property as opp-table, so
restrict it to object to properly enforce real OPP table nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index a31ec9a4179f..f12558960cd8 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -80,7 +80,8 @@ properties:
 
   operating-points-v2: true
 
-  opp-table: true
+  opp-table:
+    type: object
 
   power-domains:
     maxItems: 1
-- 
2.34.1

