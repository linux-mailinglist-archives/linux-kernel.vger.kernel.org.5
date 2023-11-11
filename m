Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB947E87FE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbjKKBuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjKKBt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:49:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB944B3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:49:53 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c97d5d5aso37279157b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699667392; x=1700272192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDlw7BJOYLQR1JOHE6qHm6buxe0pe6v5T1qkeVTyvFM=;
        b=hkL3rPoWuVO5gUpuDYEu231JAx/r4jUemKGdzM4xwqMMk99/cHVj8fcr9dxW3GjgFM
         PZ7Fiv3tKKeA7LUT33Jw4wYpeYblrAd8OPY+QD6JMF1iAtOo33B5JNGvBpTVRxm83SpO
         uEViMvoPqHt4F9nCT/ndHJdiZkp1xWuw/OhZybsJvK6yJrxuE0BlFdkswL2IigpvzIQj
         nmHAugm+g6BU0srgvJuuyuZi6N1zlJxtAhhW/97GI6bDbycmfgY2mKhU45+mEhop1ytJ
         yYap5mf4HO4A2BzZnoZykIdcSAB7B1fOE2EdLknol3TvogyMEHkv81Ao+XyQm5Ph+PpC
         Jydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699667392; x=1700272192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eDlw7BJOYLQR1JOHE6qHm6buxe0pe6v5T1qkeVTyvFM=;
        b=a2B1lHEaJuRS/enPx6KKYl+GfMVTDxE0yyjb37KG+BNnrpC+vwtw3/hxB/mFhb54KG
         PT7cK6asLFJMFkDUIWzXNrH67fq/lYuupmbA+cLZFjwgAp/MieSe4lC4ZTBK7pzIp5T+
         BVLQGE0aqwI0AAEkKR97kpAYq7kNBkodtBlCipCs8zfXgXaEJCSKzCmCMcatdpQSJnwx
         5e55mldyoaoPpYSGki1EoO562wMxfdWRM35sSQbYTGRNQ5L6+znoTr6YMUfrZBPiYpuA
         4181o7jhY76s0XE2rmS9HMMFxyh30qwF0Q7MEMgWUZOvFoglySaTyISpSISCNiUN1APl
         kTLQ==
X-Gm-Message-State: AOJu0YzfJ3kqBPxiF0tN6qwRoFi0slGb8TbG5seqnZooJypTxzQoy6/M
        px/ZwG1Fp3P3oHMqLNjNFK02ffc56kT2
X-Google-Smtp-Source: AGHT+IERwBrWzhyK476JE9i6cDqJ7sSklRpxrfNPiR2sMV/S2AQZXjtMIMjKFVKGwgldZdmSUEYbZqNkwknd
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:77fa:5ee:8100:77])
 (user=davidai job=sendgmr) by 2002:a0d:d747:0:b0:5a7:a929:5b1d with SMTP id
 z68-20020a0dd747000000b005a7a9295b1dmr25429ywd.4.1699667392377; Fri, 10 Nov
 2023 17:49:52 -0800 (PST)
Date:   Fri, 10 Nov 2023 17:49:29 -0800
In-Reply-To: <20231111014933.1934562-1-davidai@google.com>
Mime-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231111014933.1934562-2-davidai@google.com>
Subject: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
From:   David Dai <davidai@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        David Dai <davidai@google.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bindings to represent a virtual cpufreq device.

Virtual machines may expose MMIO regions for a virtual cpufreq device
for guests to read frequency information or to request frequency
selection. The virtual cpufreq device has an individual controller for
each frequency domain.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 .../cpufreq/qemu,cpufreq-virtual.yaml         | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml

diff --git a/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
new file mode 100644
index 000000000000..16606cf1fd1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/cpufreq/qemu,cpufreq-virtual.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cpufreq/qemu,cpufreq-virtual.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Virtual CPUFreq
+
+maintainers:
+  - David Dai <davidai@google.com>
+  - Saravana Kannan <saravanak@google.com>
+
+description:
+  Virtual CPUFreq is a virtualized driver in guest kernels that sends frequency
+  selection of its vCPUs as a hint to the host through MMIO regions. Each vCPU
+  is associated with a frequency domain which can be shared with other vCPUs.
+  Each frequency domain has its own set of registers for frequency controls.
+
+properties:
+  compatible:
+    const: qemu,virtual-cpufreq
+
+  reg:
+    maxItems: 1
+    description:
+      Address and size of region containing frequency controls for each of the
+      frequency domains. Regions for each frequency domain is placed
+      contiugously and contain registers for controlling DVFS(Dynamic Frequency
+      and Voltage) characteristics. The size of the region is proportional to
+      total number of frequency domains.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    // This example shows a two CPU configuration with a frequency domain
+    // for each CPU.
+    cpus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cpu@0 {
+        compatible = "arm,armv8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table0>;
+      };
+
+      cpu@1 {
+        compatible = "arm,armv8";
+        device_type = "cpu";
+        reg = <0x0>;
+        operating-points-v2 = <&opp_table1>;
+      };
+    };
+
+    opp_table0: opp-table-0 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp1098000000 {
+        opp-hz = /bits/ 64 <1098000000>;
+        opp-level = <1>;
+      };
+
+      opp1197000000 {
+        opp-hz = /bits/ 64 <1197000000>;
+        opp-level = <2>;
+      };
+    };
+
+    opp_table1: opp-table-1 {
+      compatible = "operating-points-v2";
+      opp-shared;
+
+      opp1106000000 {
+        opp-hz = /bits/ 64 <1106000000>;
+        opp-level = <1>;
+      };
+
+      opp1277000000 {
+        opp-hz = /bits/ 64 <1277000000>;
+        opp-level = <2>;
+      };
+    };
+
+    soc {
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      cpufreq@1040000 {
+        compatible = "qemu,virtual-cpufreq";
+        reg = <0x1040000 0x10>;
+      };
+    };
-- 
2.42.0.869.gea05f2083d-goog

