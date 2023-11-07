Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4657E39F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 11:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjKGKgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 05:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjKGKgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 05:36:12 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9210F3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 02:36:05 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9e28724ac88so53103466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 02:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699353364; x=1699958164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9Vc2qkKhkx61HztjKbbqVRx45srzZVqd+8CPW3yS50=;
        b=YqC6rCMdNigzr6ulktd6QGMMSkJP1/NihqLUbUpI4aInoJ9L6wPk47eC1jxfH9CbZY
         Q1CtzPwGIz+OZeWMBgIIaB/esskESEoLMdDHqXU7d3B1qCzTSMstoldz68JjIPCstNB4
         7fv4+4uy0TzBMKGRUunnWR1uOcbAaEQLJkoN2fWj8Rmzj+fxE6D5ySVdJok805BbaI1t
         YODohfj62sNOJHGzSj2/D1p56Bq8V4sg2YcirKh1xe4ZzRmxOr1opDZO2ywp5JOlnA3e
         2DUeIPXkfe/T3gZpoxP38HbENhk1bKbFl++nQL95s+/mhWPpA1798GdFkf04CalDNLA1
         d66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699353364; x=1699958164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9Vc2qkKhkx61HztjKbbqVRx45srzZVqd+8CPW3yS50=;
        b=VAkJ/TLmEteIUIFBOQXHaPzEVoUobDE+fdMBqg8p8W83zoDqXcRi+Uxr60Gb36/VWJ
         tHkeo0z9GCw3JmELU2TTOC5YNgBnRsPPk8R8IfV+CqYnPtyu4jpQHAFFA+aKq0jcY3E+
         K0gXfaOEIt85rO64Cf4pY38e9ArSSerm9hxn3m55Q774oF8HEndigLb8MgMw2etWDl4e
         w1q2cvCClzuQA4T7W6HMQwcDouauFq92gs8V7H1HsO5TZ3VmM9uVs2eedGjc1DIm6Je+
         qJPbtm/bmgEf7ypGu65nt+lUJ/A37E5eJhkSAIkRCxjw1FRF9Oz+dQR6kmrjk1xkfhN1
         cVmQ==
X-Gm-Message-State: AOJu0YyVS9Jxqky5MlAPSWuHPwOUQSKDn1XB7bwDDIerMIxrsW78kPsq
        Bv71IW9wFulBo4YIO/QBuCfUrw==
X-Google-Smtp-Source: AGHT+IGlcsVnMGNpyWLBotkYWP9vhPvQ1zyDE2+TWGxgndROuli3GOxflA+1dY6Ar37umkuXKpUK5w==
X-Received: by 2002:a17:907:74b:b0:9ae:65a5:b6fa with SMTP id xc11-20020a170907074b00b009ae65a5b6famr15853415ejb.32.1699353364150;
        Tue, 07 Nov 2023 02:36:04 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709064e4700b0099d798a6bb5sm877590ejw.67.2023.11.07.02.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 02:36:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display/msm: qcom,sm8250-mdss: add DisplayPort controller node
Date:   Tue,  7 Nov 2023 11:36:00 +0100
Message-Id: <20231107103600.27424-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DisplayPort controller node in MDSS binding, already used
in DTS:

  sm8250-xiaomi-elish-boe.dtb: display-subsystem@ae00000: Unevaluated properties are not allowed ('displayport-controller@ae90000' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/display/msm/qcom,sm8250-mdss.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
index 994975909fea..51368cda7b2f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8250-mdss.yaml
@@ -52,6 +52,16 @@ patternProperties:
       compatible:
         const: qcom,sm8250-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        items:
+          - const: qcom,sm8250-dp
+          - const: qcom,sm8350-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     additionalProperties: true
-- 
2.34.1

