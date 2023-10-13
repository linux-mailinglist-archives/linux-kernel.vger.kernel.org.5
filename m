Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5187C8C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 19:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjJMRjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 13:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjJMRjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 13:39:07 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FB0BF;
        Fri, 13 Oct 2023 10:39:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40566f8a093so24099465e9.3;
        Fri, 13 Oct 2023 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697218745; x=1697823545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HZyxbaZrzegHjjHG1xEeKX3lyEz0S3pL4gqIEs+3eM=;
        b=kTOptCowLTvTLbvWXqTuxThm0Uatrwiyz8+h0appWlUFxmJ9DzXvNNxnML+PiHvJbn
         +Uk9FGNmxhOnIBEgXcM/GL2vyoFw0vWouRVJ0cBw6tHz5SIuXPCoNANuo6x+hKxrelzp
         NamxFOkeUGHFKzaooqjh/dLE+h776ZN39p3+GcvGA+/eDlUBEEuviPwOrbqhcEM1k2ln
         q94H/fa0PEEu+1wdoc7hNwa3hGZZxVxvUx7P3MmFuGhRT4HXRTrei1ecrGOVgnQ5NQtl
         AkRmNChoghwdbiv+G7c/azqEE2R+ZF8lfnMYzea5BN2AUbo6evi0UiX3qKR+uNnomWfl
         PGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697218745; x=1697823545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HZyxbaZrzegHjjHG1xEeKX3lyEz0S3pL4gqIEs+3eM=;
        b=JOANor6a+MBVR1TxL17+OHksdKndul6Yj/l4A89qSH+aQoTLdh7dHccAPXQyM1o2jf
         W399dE61paJWd3ZhKsmSOhLPiNt+y1AB98wz2Sg3CscLGPkMDuBkGoOwgOdF8BFUo7cy
         B6Wwq6zK0AkuPCszjwrs4XfOVAHpiHydE1BSx+71mXMkDuRLyPO7t6isHwEDD91qRsyM
         irYHqBTWGlA2NwrVf7zHQZfBTtpsxLrBX4AOV7fyjRbLsFigGYiERZ/qn1QY5dQIS4az
         1I74+A9ttPKXPO/3I55pJTYNtKz5STQEcD1EfYurnudrYdSxy+YxAqomVrDcVa1ICZik
         aACg==
X-Gm-Message-State: AOJu0YxLWKNOPc8+/N1gaIYzdCFmLCTcJIbCrqkvWLsG6WRKgPx4h6uU
        BUlSNOVmc8xk8VeSUJluiJQ=
X-Google-Smtp-Source: AGHT+IHVbVmwZE3/otPzs22R6/X6n7J2gWHh+vwuxdJ3uBEXVrVq5NBgLBHqqIkRGdNnsxGSqo5ulg==
X-Received: by 2002:a1c:4b18:0:b0:404:4b6f:d705 with SMTP id y24-20020a1c4b18000000b004044b6fd705mr24771845wma.17.1697218744536;
        Fri, 13 Oct 2023 10:39:04 -0700 (PDT)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id j11-20020a05600c42cb00b0040652e8ca13sm692074wme.43.2023.10.13.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 10:39:04 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property
Date:   Fri, 13 Oct 2023 19:38:52 +0200
Message-Id: <20231013173854.7399-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231013173854.7399-1-ansuelsmth@gmail.com>
References: <20231013173854.7399-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document named opp-microvolt property for opp-v2-kryo-cpu schema.
This property is used to declare multiple voltage ranges selected on the
different values read from efuses. The selection is done based on the
speed pvs values and the named opp-microvolt property is selected by the
qcom-cpufreq-nvmem driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes v6:
* Rebase on top of dependant series
* Fix example to use krait

Changes v5:
* Fix typo in opp items

Changes v4:
* Address comments from Rob (meaning of pvs, drop of
  driver specific info, drop of legacy single voltage OPP,
  better specify max regulators supported)
---
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index 316f9c7804e4..fd04d060c1de 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -68,6 +68,12 @@ patternProperties:
           6:  MSM8996SG, speedbin 2
           7-31:  unused
 
+          Bitmap for IPQ806x SoC:
+          0:  IPQ8062
+          1:  IPQ8064/IPQ8066/IPQ8068
+          2:  IPQ8065/IPQ8069
+          3-31:  unused
+
           Other platforms use bits directly corresponding to speedbin index.
 
       clock-latency-ns: true
@@ -262,6 +268,22 @@ examples:
             };
         };
 
+        /* Dummy opp table to give example for named opp-microvolt */
+        opp-table-2 {
+            compatible = "operating-points-v2-krait-cpu";
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
2.40.1

