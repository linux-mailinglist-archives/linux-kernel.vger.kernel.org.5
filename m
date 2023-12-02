Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E308F801FC8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjLBXsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBXsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:48:35 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C138EC8;
        Sat,  2 Dec 2023 15:48:40 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C058B160B88;
        Sun,  3 Dec 2023 00:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701560917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yYAAnwjCtRQ2OW4JMv75Ia+LQsmjhgU723C/WzifIwA=;
        b=1cIHJLXWe5i7TC70bl0eezTByuNq/TMduEL0fbkVbSR6IiG0zDHeKVoFiD/NKudSvdQkz6
        MYmTE4YdUMj12dpS9rNDto7vdjRTCYgceqy3lgXmSklSxMv2s+R4E0PWC5DFKAGZh40318
        rNDrTwE2eH6n241dx/HzY9UNN8httkg=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Heidelberg <david@ixit.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/3] dt-bindings: arm: merge qcom,idle-state with idle-state
Date:   Sun,  3 Dec 2023 00:47:17 +0100
Message-ID: <20231202234832.155306-1-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge Qualcomm-specific idle-state binding with generic one.

Signed-off-by: David Heidelberg <david@ixit.cz>

---
v4:
 - drop Linux-specific details
 - integrate compatible into existing block
 - added surrounding patches fixing node names
v3:
 - integrate into idle-state.yml
 - original patch name was:
   "[v2] dt-bindings: arm/msm/qcom,idle-state convert to YAML"

 .../bindings/arm/msm/qcom,idle-state.txt      | 84 -------------------
 .../devicetree/bindings/cpu/idle-states.yaml  | 80 +++++++++++++++++-
 2 files changed, 76 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
deleted file mode 100644
index 606b4b1b709d..000000000000
--- a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
+++ /dev/null
@@ -1,84 +0,0 @@
-QCOM Idle States for cpuidle driver
-
-ARM provides idle-state node to define the cpuidle states, as defined in [1].
-cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
-states. Idle states have different enter/exit latency and residency values.
-The idle states supported by the QCOM SoC are defined as -
-
-    * Standby
-    * Retention
-    * Standalone Power Collapse (Standalone PC or SPC)
-    * Power Collapse (PC)
-
-Standby: Standby does a little more in addition to architectural clock gating.
-When the WFI instruction is executed the ARM core would gate its internal
-clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
-trigger to execute the SPM state machine. The SPM state machine waits for the
-interrupt to trigger the core back in to active. This triggers the cache
-hierarchy to enter standby states, when all cpus are idle. An interrupt brings
-the SPM state machine out of its wait, the next step is to ensure that the
-cache hierarchy is also out of standby, and then the cpu is allowed to resume
-execution. This state is defined as a generic ARM WFI state by the ARM cpuidle
-driver and is not defined in the DT. The SPM state machine should be
-configured to execute this state by default and after executing every other
-state below.
-
-Retention: Retention is a low power state where the core is clock gated and
-the memory and the registers associated with the core are retained. The
-voltage may be reduced to the minimum value needed to keep the processor
-registers active. The SPM should be configured to execute the retention
-sequence and would wait for interrupt, before restoring the cpu to execution
-state. Retention may have a slightly higher latency than Standby.
-
-Standalone PC: A cpu can power down and warmboot if there is a sufficient time
-between the time it enters idle and the next known wake up. SPC mode is used
-to indicate a core entering a power down state without consulting any other
-cpu or the system resources. This helps save power only on that core.  The SPM
-sequence for this idle state is programmed to power down the supply to the
-core, wait for the interrupt, restore power to the core, and ensure the
-system state including cache hierarchy is ready before allowing core to
-resume. Applying power and resetting the core causes the core to warmboot
-back into Elevation Level (EL) which trampolines the control back to the
-kernel. Entering a power down state for the cpu, needs to be done by trapping
-into a EL. Failing to do so, would result in a crash enforced by the warm boot
-code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
-be flushed in s/w, before powering down the core.
-
-Power Collapse: This state is similar to the SPC mode, but distinguishes
-itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
-modes. In a hierarchical power domain SoC, this means L2 and other caches can
-be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
-voltages reduced, provided all cpus enter this state.  Since the span of low
-power modes possible at this state is vast, the exit latency and the residency
-of this low power mode would be considered high even though at a cpu level,
-this essentially is cpu power down. The SPM in this state also may handshake
-with the Resource power manager (RPM) processor in the SoC to indicate a
-complete application processor subsystem shut down.
-
-The idle-state for QCOM SoCs are distinguished by the compatible property of
-the idle-states device node.
-
-The devicetree representation of the idle state should be -
-
-Required properties:
-
-- compatible: Must be one of -
-			"qcom,idle-state-ret",
-			"qcom,idle-state-spc",
-			"qcom,idle-state-pc",
-		and "arm,idle-state".
-
-Other required and optional properties are specified in [1].
-
-Example:
-
-	idle-states {
-		CPU_SPC: spc {
-			compatible = "qcom,idle-state-spc", "arm,idle-state";
-			entry-latency-us = <150>;
-			exit-latency-us = <200>;
-			min-residency-us = <2000>;
-		};
-	};
-
-[1]. Documentation/devicetree/bindings/cpu/idle-states.yaml
diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
index b3a5356f9916..15abc786a978 100644
--- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -243,7 +243,64 @@ description: |+
   just supports idle_standby, an idle-states node is not required.
 
   ===========================================
-  6 - References
+  6 - Qualcomm specific STATES
+  ===========================================
+
+  Idle states have different enter/exit latency and residency values.
+  The idle states supported by the QCOM SoC are defined as -
+
+    * Standby
+    * Retention
+    * Standalone Power Collapse (Standalone PC or SPC)
+    * Power Collapse (PC)
+
+  Standby: Standby does a little more in addition to architectural clock gating.
+  When the WFI instruction is executed the ARM core would gate its internal
+  clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
+  trigger to execute the SPM state machine. The SPM state machine waits for the
+  interrupt to trigger the core back in to active. This triggers the cache
+  hierarchy to enter standby states, when all cpus are idle. An interrupt brings
+  the SPM state machine out of its wait, the next step is to ensure that the
+  cache hierarchy is also out of standby, and then the cpu is allowed to resume
+  execution. This state is defined as a generic ARM WFI state by the ARM cpuidle
+  driver and is not defined in the DT. The SPM state machine should be
+  configured to execute this state by default and after executing every other
+  state below.
+
+  Retention: Retention is a low power state where the core is clock gated and
+  the memory and the registers associated with the core are retained. The
+  voltage may be reduced to the minimum value needed to keep the processor
+  registers active. The SPM should be configured to execute the retention
+  sequence and would wait for interrupt, before restoring the cpu to execution
+  state. Retention may have a slightly higher latency than Standby.
+
+  Standalone PC: A cpu can power down and warmboot if there is a sufficient time
+  between the time it enters idle and the next known wake up. SPC mode is used
+  to indicate a core entering a power down state without consulting any other
+  cpu or the system resources. This helps save power only on that core.  The SPM
+  sequence for this idle state is programmed to power down the supply to the
+  core, wait for the interrupt, restore power to the core, and ensure the
+  system state including cache hierarchy is ready before allowing core to
+  resume. Applying power and resetting the core causes the core to warmboot
+  back into Elevation Level (EL) which trampolines the control back to the
+  kernel. Entering a power down state for the cpu, needs to be done by trapping
+  into a EL. Failing to do so, would result in a crash enforced by the warm boot
+  code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
+  be flushed in s/w, before powering down the core.
+
+  Power Collapse: This state is similar to the SPC mode, but distinguishes
+  itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
+  modes. In a hierarchical power domain SoC, this means L2 and other caches can
+  be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
+  voltages reduced, provided all cpus enter this state.  Since the span of low
+  power modes possible at this state is vast, the exit latency and the residency
+  of this low power mode would be considered high even though at a cpu level,
+  this essentially is cpu power down. The SPM in this state also may handshake
+  with the Resource power manager (RPM) processor in the SoC to indicate a
+  complete application processor subsystem shut down.
+
+  ===========================================
+  7 - References
   ===========================================
 
   [1] ARM Linux Kernel documentation - CPUs bindings
@@ -301,9 +358,15 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - arm,idle-state
-          - riscv,idle-state
+        oneOf:
+          - const: arm,idle-state
+          - items:
+              - enum:
+                  - qcom,idle-state-ret
+                  - qcom,idle-state-spc
+                  - qcom,idle-state-pc
+              - const: arm,idle-state
+          - const: riscv,idle-state
 
       arm,psci-suspend-param:
         $ref: /schemas/types.yaml#/definitions/uint32
@@ -852,4 +915,13 @@ examples:
         };
     };
 
+    // Example 4 - Qualcomm SPC
+    idle-states {
+      cpu_spc: cpu-spc {
+        compatible = "qcom,idle-state-spc", "arm,idle-state";
+        entry-latency-us = <150>;
+        exit-latency-us = <200>;
+        min-residency-us = <2000>;
+      };
+    };
 ...
-- 
2.42.0

