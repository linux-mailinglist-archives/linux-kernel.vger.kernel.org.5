Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20F765E16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjG0VYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjG0VX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:23:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E2D4200;
        Thu, 27 Jul 2023 14:23:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bb2468257fso8691155ad.0;
        Thu, 27 Jul 2023 14:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690493011; x=1691097811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQZMOPuU2NT251VkgOhkBFz/GJRkDGlyYehHpTo6xuo=;
        b=ivYp4VJCrL/8o1Xn4k6WDMaTuMD3bKTU4BJpdp83TNkv1aQzgezYW+SjC5+QLxW8lh
         00IQvb2RQ1DY4Yv4R6sEuZN7yYF6qWdSiyr1towRuRVGFEwDSgZhrozK8pxzr4pPdl0S
         BF2uXXKUtnQ8HbzR/h352BcbpZ9jXcymuiC/O8Nf0j7q8bhifVUBAQg+JBLWBHky4h0+
         fqhPJvCO5+sTO9Otyciht4/oaN9qAOIedk8P/ojCImjfWB04JEU7f2cZttDA4xqYn/DR
         XRtxwQUJC642nI3RwdLqczsIQdwxecFJ00gfPYR5SuUsOiOLjsZPzKFh797GJ4xDacRo
         PGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493011; x=1691097811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQZMOPuU2NT251VkgOhkBFz/GJRkDGlyYehHpTo6xuo=;
        b=cxmbVbwSiTWI6lqm1SADamyWfd99sselIGHFaHyh6XMssk315DwSuNBlRHatfIKudN
         INDmjYy/ZM2OAIvZzPKxWikISqww2A26gw2uousnQYDVS5ZTnISGH1HYBWUuc1jm3L2K
         91/rPPe39udNEjyN3Rdc3dswSy1xd1uv64zd+z8yAtxd5wndtV23vhXgT6mDxONaaEB2
         a8DPZTmxcTa+wgoNe+JVu/Z2TnukdtFGOI3Uk5W3pcQovJh50W50vT+zBjRiwSMpFeuV
         5gZ6BS0hkkSet5TqpUIxbl36lxioxVL6QEMVNGIBDaBSmhaLbPOXhR3tZIXiHZfmQofa
         G+pA==
X-Gm-Message-State: ABy/qLasYJ3omAxAMFOzt/pcVW4qze4wGIRBBQRArTLDtnscfqu2vOHr
        3d2IHSOKxP8j/oKJT74FjWA=
X-Google-Smtp-Source: APBJJlG1ww+SPQvtSFuUK3ikZ0jM7AgtQ8N3bRakU4pav3WJNQ0ITBLndKGJDY5IP78SwHRXLOQJWQ==
X-Received: by 2002:a17:902:ef87:b0:1b9:e9f1:91e0 with SMTP id iz7-20020a170902ef8700b001b9e9f191e0mr383339plb.41.1690493011002;
        Thu, 27 Jul 2023 14:23:31 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:69d1:d8aa:25be:a2b6])
        by smtp.gmail.com with ESMTPSA id z8-20020a170903018800b001b8a85489a3sm2074529plg.262.2023.07.27.14.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:23:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 12/13] dt-bindings: drm/msm/gpu: Extend bindings for chip-id
Date:   Thu, 27 Jul 2023 14:20:17 -0700
Message-ID: <20230727212208.102501-13-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727212208.102501-1-robdclark@gmail.com>
References: <20230727212208.102501-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Upcoming GPUs use an opaque chip-id for identifying the GPU.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 58ca8912a8c3..56b9b247e8c2 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -13,6 +13,12 @@ maintainers:
 properties:
   compatible:
     oneOf:
+      - description: |
+          The driver is parsing the compat string for Adreno to
+          figure out the chip-id.
+        items:
+          - pattern: '^qcom,adreno-[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$'
+          - const: qcom,adreno
       - description: |
           The driver is parsing the compat string for Adreno to
           figure out the gpu-id and patch level.
-- 
2.41.0

