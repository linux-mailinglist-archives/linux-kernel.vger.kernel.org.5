Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5E75B065
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjGTNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGTNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:52:00 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B3A2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:51:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666e97fcc60so516985b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689861119; x=1690465919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwIjpadbA1bA+sFrh7qCEP0xay0bdLfI0ypl9RcKrcI=;
        b=IhvSszQH7ed5TdLQb/bhOsEEIP+Ti0MkfkYGqt7ql/69xRHHL7UfR2C0woZnzRxj4M
         wKZ13zLz+NT/Sjq9PqG+ncOpY+pxRLudha7/fqfiqsjW8PueNjqggffIFnocWL2F+SxM
         3YQ279j8kREhvC0zy5sclfszwT0fQn+POzPFYIr6odeP9tEGjT2F0bI00dhSmAkOa0kc
         GaudZfPloQNfmuUiH6rlF+9PF7ak7XwXfiIe57vpXx+S+YmjAyD392jnF9kY7F5DHpxt
         v+Jny5mkuXnvvHrKbZiABGpuoaoov8tddSudAw0eYt97XWovnpYh9ptj57+BN71t9RCa
         K/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861119; x=1690465919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwIjpadbA1bA+sFrh7qCEP0xay0bdLfI0ypl9RcKrcI=;
        b=WnJRGNqvoFyz7wTZ+RVE1yzHBwzepnv9wp2f8u2obuT0IIxq2jJjFExmQCv9MVdISO
         hxxOJtwR6kQ6iZH9urMyYxpK0RBiYgaW8Gpdvr8kVFA8x9vRkq8wKt0Me6MgcEyli2Mh
         bvGijguv8StMZYuzRPjOnGthJn7WqC3JZJrdESpHpMxzvHfRj9hZJSQt6awu004cwkM/
         6QfVJsGlKbT+8rMqjTiEJgN9/K4F9/5Y0kLdlCNSVR199n6YnYU1azwNK7b3jFktTWNk
         t1Yh8RHyU/NJLDvoZWGQw46FEhAvuzJL//xDrVT3OOgBhq9a0wbkwHj4BitVi+QXF+jJ
         1FIA==
X-Gm-Message-State: ABy/qLYSScMXi3cPoD3h5F/32pO7pHHuJ16FHFtYYj+eAkCOd9aJWxey
        oBMWtBySEOWJ3UdoSIyQvAz1vg==
X-Google-Smtp-Source: APBJJlG0R23vqKexKWkbs1Zy4QZQSyTSNTWmgwbdNzmyOhYsE1lhy3kIgnsfh3MEtlFSekjQ6Tdxkw==
X-Received: by 2002:a05:6a20:549c:b0:135:4858:681 with SMTP id i28-20020a056a20549c00b0013548580681mr6149717pzk.9.1689861118900;
        Thu, 20 Jul 2023 06:51:58 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78d12000000b00679fef56287sm1197529pfe.147.2023.07.20.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:51:58 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        peterz@infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>,
        Nick Hu <nick.hu@sifive.com>
Subject: [PATCH v2 1/3] dt-bindings: riscv: sifive: Add SiFive Private L2 cache controller
Date:   Thu, 20 Jul 2023 21:51:19 +0800
Message-Id: <20230720135125.21240-2-eric.lin@sifive.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230720135125.21240-1-eric.lin@sifive.com>
References: <20230720135125.21240-1-eric.lin@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add YAML DT binding documentation for SiFive Private L2
cache controller

Signed-off-by: Eric Lin <eric.lin@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Nick Hu <nick.hu@sifive.com>
---
 .../bindings/cache/sifive,pl2cache.yaml       | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
new file mode 100644
index 000000000000..ee8356c5eeee
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2023 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/sifive,pl2cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive Private L2 Cache Controller
+
+maintainers:
+  - Greentime Hu  <greentime.hu@sifive.com>
+  - Eric Lin  <eric.lin@sifive.com>
+
+description:
+  The SiFive Private L2 Cache Controller is per core and
+  communicates with both the upstream L1 caches and
+  downstream L3 cache or memory, enabling a high-performance
+  cache subsystem.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: sifive,pl2cache1
+      - const: cache
+
+  cache-block-size: true
+  cache-level: true
+  cache-sets: true
+  cache-size: true
+  cache-unified: true
+
+  reg:
+    maxItems: 1
+
+  next-level-cache: true
+
+required:
+  - compatible
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    cache-controller@10104000 {
+        compatible = "sifive,pl2cache1","cache";
+        cache-block-size = <64>;
+        cache-level = <2>;
+        cache-sets = <512>;
+        cache-size = <262144>;
+        cache-unified;
+        reg = <0x10104000 0x4000>;
+        next-level-cache = <&L4>;
+    };
-- 
2.40.1

