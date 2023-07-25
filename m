Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82B176106C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGYKQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjGYKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:16:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8561BCB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:16:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5221f193817so4212490a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690280176; x=1690884976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kgjzM14QEiL69p/YLX8lqgzuetXlnguUNrcPLd50K6I=;
        b=C4czm/+Xz2UutJXlca3VkY/5VlywrDLHuMNp4CGjo7VZ0TpqzJjydvmrSDzTVSgAEt
         +K3IZtgfB7epGyj4hbxX3wdBDlHFLyGYF8k87sMiH+G1gcqAMx40aZLy7MF9s5xeQP5x
         fhnbmSwYWkAVdLsXKHBG7KQami1/9ue4beRYmJdyrSe/ka3umBmFTIAsEMhYhkmED0+n
         h/tD+XzOhnhPcv7zRtsI2fsZdxpvyQNcwnEGlJZJJczCbDOtfM40WLASHHbA4aiLIfjA
         D/rEU4Og78VLM9QbuzZ0XS+STA60ygyZjzHaQn79vehoGSKmUMX5h5wYMfmhLuvrMwXR
         vuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690280176; x=1690884976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgjzM14QEiL69p/YLX8lqgzuetXlnguUNrcPLd50K6I=;
        b=kHoVgVIg7k3TranJqQ8E0iLtdA45ojOiG9vdBiueq/82mZZ08/BLebDj7YtlBqzyT4
         L8uGv/CDaYnBsaK8az3x50uItVlvkyYXr5qAOQNZ//78C9/lZ2UvDyZXZ1Y3/Bp1wiAU
         IyVDJQxrmUYaXdKxXWVYhZ9sSbL04qzmUzrv2edZ22ea+r2aOxokF/JpTeHWyQGzfJHQ
         NG70WNTeXzF0lJhecSgoHfegTWwhBzd2+b9pATd/ydTbTfZIPCmmnxxlnrSnu2wGrIGx
         iCK+0LxvJVingLBoQ9FG9UHohbhrn9n/AGy3VppXa0xApTF0/wDvhPiL/27LB1jujRlU
         hlKg==
X-Gm-Message-State: ABy/qLaIVBvN/F44gm4aOKlazkbSOg7DyCFBTGukDeUfZZpzL78UgJmg
        opw5W3kvCXcifCleoUmKqMdg/A==
X-Google-Smtp-Source: APBJJlGBMU5DGuFGwk0qtfh0c2aQo1t0zRXQTiXXDi0POVtlnNNbgD2TyBllza9yPhuzHMFnWRx1Kg==
X-Received: by 2002:aa7:d410:0:b0:522:3a0d:38c2 with SMTP id z16-20020aa7d410000000b005223a0d38c2mr3214909edq.9.1690280176127;
        Tue, 25 Jul 2023 03:16:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f23-20020a05640214d700b005224ec27dd7sm544171edx.66.2023.07.25.03.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:16:15 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: display: msm: sm6125-mdss: drop unneeded status from examples
Date:   Tue, 25 Jul 2023 12:16:10 +0200
Message-Id: <20230725101610.75122-1-krzysztof.kozlowski@linaro.org>
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

Example DTS should not have 'status' property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml   | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
index 2525482424cb..479c82e6a0d8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6125-mdss.yaml
@@ -95,8 +95,6 @@ examples:
         #size-cells = <1>;
         ranges;
 
-        status = "disabled";
-
         display-controller@5e01000 {
             compatible = "qcom,sm6125-dpu";
             reg = <0x05e01000 0x83208>,
@@ -170,8 +168,6 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
 
-            status = "disabled";
-
             ports {
                 #address-cells = <1>;
                 #size-cells = <0>;
@@ -210,8 +206,6 @@ examples:
 
             required-opps = <&rpmpd_opp_svs>;
             power-domains = <&rpmpd SM6125_VDDMX>;
-
-            status = "disabled";
         };
     };
 ...
-- 
2.34.1

