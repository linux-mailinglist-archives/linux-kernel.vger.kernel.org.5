Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F276C00C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjHAWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjHAWED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:04:03 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D53719B7;
        Tue,  1 Aug 2023 15:04:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so171784f8f.1;
        Tue, 01 Aug 2023 15:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690927440; x=1691532240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGHbJ1UcvQG2q5/vhVpK7F2Onm155KewZkDkkt5Uamg=;
        b=Sl341e2Zp9kSEZ7liQlbRlgjtIkAgUM0kDa0CeOQdLi5vfezdygOJTZp1zXpDTOQKm
         nu8B2Lg6oR8g9BhglZDykUhM8zk0lglGfw4y8cR9+YxF7Ngvq9jWhIjbQv97NSauKVCr
         BVGzxNaxDNnwGJIlhSWtmd2GJ1yFAyw1Y//2X84bVTGyTqBzi3XyGUzSS0QkwIQc27gT
         3cBEJ6D1/fbu40HeVUhRz5pKYIUqn3VctEnU2BUiba8hSvF+8F54HZXVoGTjGZyCKEkE
         hANuefgNs8SOlnx2jq2/DFtpHHDFKngwYhyITnqaAvbV1mNQdqO8oxUS4vCUu6opKvM5
         EsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927440; x=1691532240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LGHbJ1UcvQG2q5/vhVpK7F2Onm155KewZkDkkt5Uamg=;
        b=QLUtUQub5eNob958VnRrj0NcqtpzyQDoSLVF9cDo0zfbvgH3Dq4UOJB/b+JOZXxKiV
         +w9B+biL2cdCSJHe2AwKVAWwiv8F3kg8ts8fas7H1nCNHxLHLGJsiyiT1iSi7T4m13BX
         AH4kaNsumKDOppnwpyYo+SY+hSlgdZsqoWLjwGBKC/4JWHlsBVpc1uPecI48m6gnJtq1
         FgH5P6jHx3yenFebExNIXUwYtLtV6o7cAo78/gOW6dk8YrC6XyfUp9KiaYGBSnJpFUVm
         6LhwVxmdlzfUZjWgK36InrjkGmCMylm19rTRI4GqxCOLTHXQ0UrQ1LpRpUXW3ss2JlXD
         UWGQ==
X-Gm-Message-State: ABy/qLZbURgpgyxknPTBKECrYt1z6Jdc+1QKxu/Ygb5DPo1AjzBvz284
        tNgvdB2C23Q+qveKJKvaJ2c=
X-Google-Smtp-Source: APBJJlGuHbjlk+GwXHMfiQY05jLuBrrb9mRmiF/9KfZVvRifG5tBZxv1UYIkgQTrCIN5qkdBNEDXfQ==
X-Received: by 2002:adf:f88e:0:b0:317:67fa:eea6 with SMTP id u14-20020adff88e000000b0031767faeea6mr3553111wrp.22.1690927439447;
        Tue, 01 Aug 2023 15:03:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:32f:1f0:2bb:9098:9156:9ead])
        by smtp.gmail.com with ESMTPSA id o20-20020a5d58d4000000b0031762e89f94sm17043463wrf.117.2023.08.01.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 15:03:59 -0700 (PDT)
From:   Raphael Gallais-Pou <rgallaispou@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: pwm: st: convert sti-pwm to DT schema
Date:   Wed,  2 Aug 2023 00:05:59 +0200
Message-ID: <20230801220559.32530-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converts st,sti-pwm binding to DT schema format

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 .../devicetree/bindings/pwm/pwm-st.txt        | 43 -----------
 .../devicetree/bindings/pwm/st,sti-pwm.yaml   | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 43 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-st.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/pwm-st.txt b/Documentation/devicetree/bindings/pwm/pwm-st.txt
deleted file mode 100644
index 19fce774cafa..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-st.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-STMicroelectronics PWM driver bindings
---------------------------------------
-
-Required parameters:
-- compatible :		"st,pwm"
-- #pwm-cells : 		Number of cells used to specify a PWM. First cell
-			specifies the per-chip index of the PWM to use and the
-			second cell is the period in nanoseconds - fixed to 2
-			for STiH41x.
-- reg :			Physical base address and length of the controller's
-			registers.
-- pinctrl-names: 	Set to "default".
-- pinctrl-0: 		List of phandles pointing to pin configuration nodes
-			for PWM module.
-			For Pinctrl properties, please refer to [1].
-- clock-names: 		Valid entries are "pwm" and/or "capture".
-- clocks: 		phandle of the clock used by the PWM module.
-			For Clk properties, please refer to [2].
-- interrupts:		IRQ for the Capture device
-
-Optional properties:
-- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
-- st,capture-num-chan:	Number of available Capture channels.  Default is 0.
-
-[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-[2] Documentation/devicetree/bindings/clock/clock-bindings.txt
-
-Example:
-
-pwm1: pwm@fe510000 {
-	compatible = "st,pwm";
-	reg = <0xfe510000 0x68>;
-	#pwm-cells = <2>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_pwm1_chan0_default
-		     &pinctrl_pwm1_chan1_default
-		     &pinctrl_pwm1_chan2_default
-		     &pinctrl_pwm1_chan3_default>;
-	clocks = <&clk_sysin>;
-	clock-names = "pwm";
-	st,pwm-num-chan = <4>;
-	st,capture-num-chan = <2>;
-};
diff --git a/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
new file mode 100644
index 000000000000..8a7833e9c10c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/st,sti-pwm.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/st,sti-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STi PWM controller
+
+maintainers:
+  - Patrice Chotard <patrice.chotard@foss.st.com>
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: st,sti-pwm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  pinctrl-names:
+    const: default
+
+  pinctrl-0:
+    description: Configuration for the default state.
+
+  clock-names:
+    const: pwm
+
+  clocks:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+  st,pwm-num-chan:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Number of available PWM channels.
+
+  st,capture-num-chan:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: Number of available Capture channels.
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-names
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pwm1: pwm@9510000 {
+        compatible = "st,sti-pwm";
+        #pwm-cells = <2>;
+        reg = <0x9510000 0x68>;
+        interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_pwm1_chan0_default
+                 &pinctrl_pwm1_chan1_default
+                 &pinctrl_pwm1_chan2_default
+                 &pinctrl_pwm1_chan3_default>;
+        clock-names = "pwm";
+        clocks = <&clk_sysin>;
+        st,pwm-num-chan = <4>;
+    };
+...
-- 
2.41.0

