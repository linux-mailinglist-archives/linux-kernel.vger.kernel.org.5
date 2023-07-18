Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5B757BAB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjGRMTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjGRMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:19:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E426C10D2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:19:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so9275924e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 05:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689682755; x=1692274755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUmULxkJFQkbBwEQikvTVT92ks+bcAZHBP/gpoL5XI8=;
        b=TZe/zrcthxpYgsZSQihwFHzWg2tk3hsyGxzn/l5g8q9Ew87/9RiM0VRSYQ6BQABeAq
         9f2flR9Ygorp/Z/7DMQ/Fgt0U3Cco7oNxrIm1r1D725Ic2hnNfg9C0WPtFGdV9kw3gSp
         wIvjxexiFKu5Yf5Kvjky2YmEAsAjBiQKB1nNojWBZwAlm2accL4oO8OZv80CRQdQjTnG
         tB4rJMdo62zzp8JJuYt9JEKsIlWSnsO4kPuML8tp0jHygthPoll3FwRJ4p0V+z+NKico
         tULHcrUtsZWHnsUdB4cfHMoheedw8k6gsldVMcnSW0IJQbaJ9ySUM5FPERo0Zxd0/M2y
         mtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689682755; x=1692274755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUmULxkJFQkbBwEQikvTVT92ks+bcAZHBP/gpoL5XI8=;
        b=AB1sXHQAYrspbhxGnFoEnwRBLQ7N9wd+XDQQp0DHJvVeYykFgzIY16YJh7MOvcOt4n
         ZH60QEl3asJxvfKwTAElxTn6n+m68RqFvDJ6refPuZeMkRiwEGoywFbsiSgjEuA55gFt
         V1S58OZrsx1ueOumdSKR/tsnPEPfEdZw1YWgbaRMjltSa17f7B8u5hGKO8vib/pYdZw8
         aAqcD2AM6ZaYSS9y+1lkhhgG6nU31cjyaNCgmNrMHTdU65IQvvsgf7EaQKLYaaxEe53V
         HbK9jZp/T+SOJeoxd0QnJ+iig/79ODL8ErXkugIuN2r36A3SS1x/2p4pDQEfK1o2sD7p
         cH9w==
X-Gm-Message-State: ABy/qLYY34k+iqv0o1uEHvZepbx5Dv7Fj/LggJrRJnSXQJJwbdfvr5Ib
        AdtvcfgtMpX3NVDxCgeL7PBPaw==
X-Google-Smtp-Source: APBJJlHeSgmv4OvLtCzplL5DOdPiNL1Kv9fzuYpvYuRbztKa3zmdelLDnvaYxWFqpKf38qxkspOovQ==
X-Received: by 2002:a05:6512:682:b0:4fb:89f2:594c with SMTP id t2-20020a056512068200b004fb89f2594cmr1456881lfe.56.1689682755090;
        Tue, 18 Jul 2023 05:19:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj181.neoplus.adsl.tpnet.pl. [83.9.29.181])
        by smtp.gmail.com with ESMTPSA id w5-20020ac25d45000000b004fbc95a4db3sm418257lfd.28.2023.07.18.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 05:19:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Jul 2023 14:19:10 +0200
Subject: [PATCH v4 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230328-topic-msgram_mpm-v4-1-bae382dc0f92@linaro.org>
References: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
In-Reply-To: <20230328-topic-msgram_mpm-v4-0-bae382dc0f92@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689682752; l=3218;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=u7PKeGTsnebqt/okOLLY3lwduIHrT4WR6NdeB30CILY=;
 b=D/5g2C3sqCGpybb/GodJlreV5rDzRD9x/w6Al8mFWyfRb19zFCPxVj5YC+m4wBj6PH/LQR7Tg
 9ay+dDf8/eQAnOE/EG5tuOTQMKMIAsQTR1BgkUyS5s00i2lcdudg3RA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
use 'reg' to point to the MPM's slice of Message RAM without cutting into
an already-defined RPM MSG RAM node used for GLINK and SMEM.

Document passing the register space as a slice of SRAM through the
qcom,rpm-msg-ram property. This also makes 'reg' deprecated.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/interrupt-controller/qcom,mpm.yaml    | 52 +++++++++++++++-------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
index 509d20c091af..4ce7912d8047 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -29,6 +29,12 @@ properties:
     maxItems: 1
     description:
       Specifies the base address and size of vMPM registers in RPM MSG RAM.
+    deprecated: true
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the APSS MPM slice of the RPM Message RAM
 
   interrupts:
     maxItems: 1
@@ -64,33 +70,45 @@ properties:
 
 required:
   - compatible
-  - reg
   - interrupts
   - mboxes
   - interrupt-controller
   - '#interrupt-cells'
   - qcom,mpm-pin-count
   - qcom,mpm-pin-map
+  - qcom,rpm-msg-ram
 
 additionalProperties: false
 
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    mpm: interrupt-controller@45f01b8 {
-        compatible = "qcom,mpm";
-        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
-        reg = <0x45f01b8 0x1000>;
-        mboxes = <&apcs_glb 1>;
-        interrupt-controller;
-        #interrupt-cells = <2>;
-        interrupt-parent = <&intc>;
-        qcom,mpm-pin-count = <96>;
-        qcom,mpm-pin-map = <2 275>,
-                           <5 296>,
-                           <12 422>,
-                           <24 79>,
-                           <86 183>,
-                           <90 260>,
-                           <91 260>;
+
+    remoteproc-rpm {
+        compatible = "qcom,msm8998-rpm-proc", "qcom,rpm-proc";
+
+        glink-edge {
+            compatible = "qcom,glink-rpm";
+
+            interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+            qcom,rpm-msg-ram = <&rpm_msg_ram>;
+            mboxes = <&apcs_glb 0>;
+        };
+
+        mpm: interrupt-controller {
+            compatible = "qcom,mpm";
+            qcom,rpm-msg-ram = <&apss_mpm>;
+            interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&apcs_glb 1>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupt-parent = <&intc>;
+            qcom,mpm-pin-count = <96>;
+            qcom,mpm-pin-map = <2 275>,
+                               <5 296>,
+                               <12 422>,
+                               <24 79>,
+                               <86 183>,
+                               <91 260>;
+        };
     };

-- 
2.41.0

