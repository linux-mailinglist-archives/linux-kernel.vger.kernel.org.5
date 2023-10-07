Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E4E7BC5DE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbjJGH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343762AbjJGH4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:56:15 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E3A6;
        Sat,  7 Oct 2023 00:56:13 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3afc38cbdbcso1094775b6e.1;
        Sat, 07 Oct 2023 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665372; x=1697270172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0VngE6BdDwFZLAlGMzCM3wLTc/iiRqiIMV99Spu1cQ=;
        b=KKqNYXnRBqzx8ryNMN/8VUFc3ZQUfMrlYdY62u7RK9Wto4DLZqzqY6MkHH05EIgixy
         tDNF2yKMf/8CHRIogqR7S2gtVoVCDSMntxAfnIP7nfSlZ4D78rAOEuc3wj0HzBFZJ4vQ
         gpHKXx5Ll3QnCnFoIRhpFK8uML/6MU58p1DRR1zQqxq1uiAVJ+3kjc7s0OcCrGDlCj3z
         5XM5rzKv6mxCC1xY91hqFrxA4VuWAQgCgPzLqKEh/YWNO7n6Zn4cy+trxcB22W8+640R
         uP0CSZ8xUpg9mObcr0oVh5dYjyNSq+xTc7psExvWnzvYKxndYJ4vQACx8FHdMqTC8eiu
         WxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665372; x=1697270172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0VngE6BdDwFZLAlGMzCM3wLTc/iiRqiIMV99Spu1cQ=;
        b=uLwLmU4TxBBQN0AMVXjwu2aoI93qW2JNy1ZLLZZTk9fQyS+S59h/FB3pGkqcWD2Yja
         un1sAEUWHP7s5c7OGVaJ+wwtRiMksL7yC90eY6j1XplvekI4L3x/ShiQwNNf/Oxpl6cE
         wA7Nr8MtsSIQGysJXFPqgVpvTT0qJgq1i3gA2N/k+FWdQsLDPip3ZeAGyJG0Mg4XmM6A
         a1tt+Or9IOkgvjcb6Ff1f+jIGPHZdlJWf3xc/xTtsZq0ANAMIn1jEAMWQsGJ/Yfh2bwc
         GbtzANkuSbSchoffZEYyZNfO5Tlxyc7iB1KflPkv4wB10hZc6Tc9+D2qH4fJAEN94Cwj
         uh9Q==
X-Gm-Message-State: AOJu0YwiWGzv+LkLqVW5pIwxnog0vVwDykVLJZxd6PVXEZRsasAIE5tH
        iAUllITMFHH+6CoNs6rWw9k=
X-Google-Smtp-Source: AGHT+IFlsn0a5Gb2lUsmV1oYkmI0lc0mxXZ3zgY9HwA4zsDa/bj7XbU7SZvFkJT8chFsAenEEwrEKg==
X-Received: by 2002:a05:6808:18a0:b0:3ae:1359:b51c with SMTP id bi32-20020a05680818a000b003ae1359b51cmr4051929oib.29.1696665372397;
        Sat, 07 Oct 2023 00:56:12 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id t64-20020a4a5443000000b0057346742d82sm702048ooa.6.2023.10.07.00.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:56:11 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 06/10] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Sat,  7 Oct 2023 15:56:03 +0800
Message-Id: <c48106ebe00c0418ffb9fd5f3a827055cf97d1db.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
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

From: Inochi Amaoto <inochiama@outlook.com>

The clint of Sophgo's sg2042 is based off IP designed by T-HEAD, but
Sophgo changes this IP layout to fit its cpu design and is incompatible
with the standard sifive clint. The timer and ipi device are on the
different address, and can not be handled by the sifive,clint dt-bindings.

If we use the same compatible string for mswi and timer of the sg2042
clint like sifive,clint, the DT may be like this:

mswi: interrupt-controller@94000000 {
	compatible = "sophgo,sg2042-clint", "thead,c900-clint";
	interrupts-extended = <&cpu1intc 3>;
	reg = <0x94000000 0x00010000>;
};

timer: timer@ac000000 {
	compatible = "sophgo,sg2042-clint", "thead,c900-clint";
	interrupts-extended = <&cpu1intc 7>;
	reg = <0xac000000 0x00010000>;
};

Since the address of mswi and timer are different, it is hard to merge
them directly. So we need two DT nodes to handle both devices.
If we use this DT for SBI, it will parse the mswi device in the timer
initialization as the compatible string is the same, so will mswi.
As they are different devices, this incorrect initialization will cause
the system unusable.

There is a more robust ACLINT spec. can handle this situation, but
the spec. seems to be abandoned and will not be frozen in the predictable
future.

So it is not the time to add ACLINT spec in the kernel bindings. Instead,
using vendor bindings is more acceptable.

Add new vendor specific compatible strings to identify timer of sg2042
clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../timer/thead,c900-aclint-mtimer.yaml       | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
new file mode 100644
index 000000000000..fbd235650e52
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/thead,c900-aclint-mtimer.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/thead,c900-aclint-mtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CLINT Timer
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2042-aclint-mtimer
+      - const: thead,c900-aclint-mtimer
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    timer@ac000000 {
+      compatible = "sophgo,sg2042-aclint-mtimer", "thead,c900-aclint-mtimer";
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+      reg = <0xac000000 0x00010000>;
+    };
+...
-- 
2.25.1

