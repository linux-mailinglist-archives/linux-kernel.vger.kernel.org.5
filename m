Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6E27B3FE8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjI3KWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3KW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:22:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239DA1A5;
        Sat, 30 Sep 2023 03:22:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso1979967266b.1;
        Sat, 30 Sep 2023 03:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696069342; x=1696674142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZtirj9M2tivqUV5c4dfwol1D3JkkXh+OPU3jGB1bG8=;
        b=GN3oApEO6Q3PtDvX/UPMt/bShaVQOrXstd4kO6mAZJRBRKgljbmKQpEEpQ4SsWkdUs
         r6VtJgU5CzBNZn+BTjv/GANlDkMqXYt/TnfNj2NBVQzL+P9KSrWVwvtG6Z3JxZGh+BmX
         rhjnCRyLb+es4UhEcRZihwg0jwHxj01eAwVhB+OwBJCq43mKJT4RA5VLnht9N6WlYb9o
         0g5yI/en66j3Me0YiIqutbCB9NT6c9otMyOdMZ2Jb6JppI3khHzS5e8q5Z7V+0dVKm8u
         FZJfClspkvLUsA5O/IkyfWL8n/8FRMdfp5178ziueWcLEFDRf/ahsJ5jTMp1HZTitk/2
         dpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696069342; x=1696674142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZtirj9M2tivqUV5c4dfwol1D3JkkXh+OPU3jGB1bG8=;
        b=eTBSZNFlhCtYI+9W3Hqs6lwB/vPmefcnyQ5xZXWiIX2k23BLU03qb8+mS6bsxsyDEL
         ktR/aF6ssPJuKFTMWtnu090FH/jcfyRkKp4AXBV/MpwSKPgaQIcrT8h31NFsgNm+kBCK
         4jKG1ISKLuZ+XUz8gURGCuPZC8e1KyBUhhWhyRUeqQf4ELslw24yYeMM+BXCndZfBUNs
         Mr40x/r0CxYy3GFxDOUofQJUXFaPg2XiVRoQN/Wj2zx8LHWsTjBm8PRP2pmCL62nByAk
         KSMEI0mTpqqzEdc+ffpG3mxUIhYDrR+WS95VB6r4tLSpt7NbR0yDgRbxaLj0QzXbWC0L
         KAuw==
X-Gm-Message-State: AOJu0YxKDwDGgbzatcNJKFIG1dfReSIdo29Wp8lp1cxs79UWkjGtBTuS
        KW4SWxcYDcMldB05BmxWeWk=
X-Google-Smtp-Source: AGHT+IF+H1F51CIrMPFC/m4+UHwtaff6vjf5tw9XtWL2vmQNGl/FMyjf7Yd/qrQfwn/BrYfzyiHS9Q==
X-Received: by 2002:a17:906:74cc:b0:9b2:8c37:eb2b with SMTP id z12-20020a17090674cc00b009b28c37eb2bmr6340972ejl.58.1696069342569;
        Sat, 30 Sep 2023 03:22:22 -0700 (PDT)
Received: from fedora.. (dh207-96-216.xnet.hr. [88.207.96.216])
        by smtp.googlemail.com with ESMTPSA id j25-20020a170906255900b0099bcf1c07c6sm13716547ejb.138.2023.09.30.03.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 03:22:22 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property
Date:   Sat, 30 Sep 2023 12:21:17 +0200
Message-ID: <20230930102218.229613-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930102218.229613-1-robimarko@gmail.com>
References: <20230930102218.229613-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Marangi <ansuelsmth@gmail.com>

Document named opp-microvolt property for opp-v2-kryo-cpu schema.
This property is used to declare multiple voltage ranges selected on the
different values read from efuses. The selection is done based on the
speed pvs values and the named opp-microvolt property is selected by the
qcom-cpufreq-nvmem driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes v5:
* Fix typo in opp items

Changes v4:
* Address comments from Rob (meaning of pvs, drop of
  driver specific info, drop of legacy single voltage OPP,
  better specify max regulators supported)

 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index 27ea7eca73e5..8d2a47e9a854 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -65,6 +65,12 @@ patternProperties:
           5:  MSM8996SG, speedbin 1
           6:  MSM8996SG, speedbin 2
           7-31:  unused
+
+          Bitmap for IPQ806X SoC:
+          0:  IPQ8062
+          1:  IPQ8064/IPQ8066/IPQ8068
+          2:  IPQ8065/IPQ8069
+          3-31:  unused
         enum: [0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7,
                0x9, 0xd, 0xe, 0xf,
                0x10, 0x20, 0x30, 0x70]
@@ -73,6 +79,23 @@ patternProperties:
 
       required-opps: true
 
+    patternProperties:
+      '^opp-microvolt-speed[0-9]+-pvs[0-9]+$':
+        description: |
+          Named opp-microvolt property following the same generic
+          binding for named opp-microvolt.
+
+          The correct voltage range is selected based on the values
+          in the efuse for the speed and the pvs (power variable
+          scaling).
+        minItems: 1
+        maxItems: 4 # Up to 4 regulators: Core, Mem, Dig and HFPLL
+        items:
+          items:
+            - description: nominal voltage
+            - description: minimum voltage
+            - description: maximum voltage
+
     required:
       - opp-hz
 
@@ -258,6 +281,22 @@ examples:
             };
         };
 
+        /* Dummy opp table to give example for named opp-microvolt */
+        opp-table-2 {
+            compatible = "operating-points-v2-kryo-cpu";
+            nvmem-cells = <&speedbin_efuse>;
+
+            opp-384000000 {
+                opp-hz = /bits/ 64 <384000000>;
+                opp-microvolt-speed0-pvs0 = <1000000 950000 1050000>;
+                opp-microvolt-speed0-pvs1 = <925000 878750 971250>;
+                opp-microvolt-speed0-pvs2 = <875000 831250 918750>;
+                opp-microvolt-speed0-pvs3 = <800000 760000 840000>;
+                opp-supported-hw = <0x7>;
+                clock-latency-ns = <100000>;
+            };
+        };
+
         smem {
             compatible = "qcom,smem";
             memory-region = <&smem_mem>;
-- 
2.41.0

