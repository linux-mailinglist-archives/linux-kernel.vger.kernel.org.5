Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE637B2706
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjI1VFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjI1VFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:05:37 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E6A19D;
        Thu, 28 Sep 2023 14:05:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso1717216166b.1;
        Thu, 28 Sep 2023 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695935130; x=1696539930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TiUWEa7vtDvez0qxDGdk3dEAqTmN/a6RoDYpX62PWU=;
        b=m+cRF2C0QlrpnFSzflvETVY4kR0nAljWbeDKZ6lL9IrPFjJ8ESGP86sA3TXhMN8VIc
         PK4V3oTcAZXK2hv3JAx0I5jsT//7hLkXSzYBkYRaYiqrplKzn72zikvm/N1pp3ldOwDx
         ES3TtmSBo6fYxpGqV+TBEfPrsq3ETVyQqULPLMatyhbC7JWh/KjwRXGo8MGzo8/0YuSx
         +cmlWgUDKKimJjxKOICdxHjRppXCi8DqlTMSLzQjIpoFbPgucqAdqoXOcOLMydcXAE77
         vftsQs2rUfb5u+AfLKkgrQuhSUgbw888xdlnGu5hZ13EGFWQcr0pKkDT77eqmID6d2ji
         KcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695935130; x=1696539930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TiUWEa7vtDvez0qxDGdk3dEAqTmN/a6RoDYpX62PWU=;
        b=cC5UCvg8ZexyKSfiSe8eoWxCQHe5WhqfVR19w3mdgxAw6qaIPTVghC0dKxFIo/EQvB
         cOsuTLsTpL1zaG7McgZ0AKvtOr8B/40yBCLDcpIzyGJPrcFp6ABIA9kFrhkayOnZihrx
         pNDnoVWtnuaeK98hFunKgIAfksyK3ab1o1OTBP8W3FwPwwE5I2VbCQBnYR5CkXpmukCi
         IJa4cHslu9ksgHsUUosazzoZZLR9PWUXOxDFeAhui2O85ZNwJwEv4rgelbcwUKJPjZst
         0ELQojADOSGbQpxT7Q4Uwkd2+/FTp0CVaRQF5jGQg3HWMxU1Wg50npWj65Yno65tv1ln
         mWNw==
X-Gm-Message-State: AOJu0YwEHRAh1g9KCduzPWMY489QUQhNDMdnyUMmoN4a3o/X1HqmgWUM
        eFP7BuYix/N3HiVR3kLpgCVShn00GrmSZw==
X-Google-Smtp-Source: AGHT+IFjzNOEO5eUpznQS8I8Bh8G24pLhZ3BaFIYi4wWvWDdj8hcDCpAJw/phPzZDq4ZlKi5RUt7pA==
X-Received: by 2002:a17:906:454d:b0:9ae:4f64:6db with SMTP id s13-20020a170906454d00b009ae4f6406dbmr2196049ejq.55.1695935130178;
        Thu, 28 Sep 2023 14:05:30 -0700 (PDT)
Received: from fedora.. (dh207-99-57.xnet.hr. [88.207.99.57])
        by smtp.googlemail.com with ESMTPSA id la9-20020a170906ad8900b0098f33157e7dsm11386849ejb.82.2023.09.28.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 14:05:29 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: opp: opp-v2-kryo-cpu: Document named opp-microvolt property
Date:   Thu, 28 Sep 2023 23:04:05 +0200
Message-ID: <20230928210525.1265958-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928210525.1265958-1-robimarko@gmail.com>
References: <20230928210525.1265958-1-robimarko@gmail.com>
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
Changes in v4:
* Describe PVS
* Add description for opp-microvolt entries
---
 .../bindings/opp/opp-v2-kryo-cpu.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index bbbad31ae4ca..f1b4553fd66a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -63,6 +63,12 @@ patternProperties:
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
@@ -71,6 +77,22 @@ patternProperties:
 
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
+          - description: nominal voltage
+          - description: minimum voltage
+          - description: maximum voltage
+
     required:
       - opp-hz
 
@@ -256,6 +278,22 @@ examples:
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

